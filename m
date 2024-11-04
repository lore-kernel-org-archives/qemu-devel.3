Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166C4D1BDC1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zVw-00066c-Gf; Mon, 04 Nov 2024 11:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7zVp-00066I-Cr
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:01:08 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7zVl-0006yP-Go
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:01:04 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5ceca7df7f0so2436886a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730736060; x=1731340860; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LRUR4NDXOahyqu0wbsy0bO+8UtBTQFHQhRUVXDN+Tco=;
 b=kVfzzlj/0dMsyz/PiEcE3V3QTpJkx13qfPkqiNupz1UdYdnXFVGQKunHg9823zhiKr
 d5B57XWLM0Bzng/mILNhp+g8dTbNXRBIwHIFXIEjHXbDse5jJqTl4e3ftIqrsakYShtU
 BHw+gxKqTXOD7ksO9r5Fh2P1ZM4b28FbZQfr/wlJJfYImJkcTMZYXREshLrA6Tt228dj
 Rjbovpa+ZSapSIzBc2C0rvx/oljFKk3UgY5aAG/81S+zaLznCanYbiVA1SqATJApC2YH
 epi614Wf6Xxz0waUkB3dgBiez8h94yVGmWajhAl2JWGGJAaBdZllqZa88SkGWb5MvvJd
 6uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730736060; x=1731340860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRUR4NDXOahyqu0wbsy0bO+8UtBTQFHQhRUVXDN+Tco=;
 b=MuWpqtqYcMYKzeiz6SVz46nqXn/JjacAkZZqJY+0SyxZHUUsVHk93gWpVC5JqfWi9T
 uNZUydNUjPzeQ3VYosXkS0/oTMBWqLrZygPQnZpo+ocUPkwAb0btiLdBIrFHFDORtLIn
 x//VeefZRVTK97v8X5Lwk593rFnaq6L1NNrigPVADeWckB+KkBzViMocukwjKfgnswQc
 IAKlHR8tDSFtyb+ymdMBbm0//gsZ/Ww2yYmJB0wXU/scA/vA0i/1sC/IIYQpgczzOoB2
 G2fL+XuZo0ehWg943I/G6z/Uxn4zuPzqmCqg8+E+eO7blrzON4DakgN9+H9JZ4jOaBCr
 QQbQ==
X-Gm-Message-State: AOJu0YwIK2y36n+RTAnBex1KVGxDQ93B0594O9gO0sXktKktsN6W6BZD
 tu84vYyDLR1meaApgLBKI39xs/1MbArbufecrVec6U+8pdMYBGrDGTSqOJykkuOuPxmSV8LiYk2
 bPCWhoh+ijgQz/RScuKJvhbuwO9+Fogrp3R46mA==
X-Google-Smtp-Source: AGHT+IHOn7y3sA18lNYqE/r+gQDda/HNrBSTIhoaeIuE3CLrs8X1+Y7fC18tpP/+oCiouJwbFYp+LQw77nQEJSdfbfg=
X-Received: by 2002:a05:6402:5242:b0:5ce:e5dc:69b with SMTP id
 4fb4d7f45d1cf-5cee5dc06f8mr564516a12.8.1730736059487; Mon, 04 Nov 2024
 08:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20241101134625.2240813-1-peterx@redhat.com>
In-Reply-To: <20241101134625.2240813-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 16:00:48 +0000
Message-ID: <CAFEAcA-5-WHyyL9WmS+avWJsS7zKBbk-7V9b6QdazLBvainTRg@mail.gmail.com>
Subject: Re: [PULL v2 00/18] Migration 20241030 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 1 Nov 2024 at 13:46, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit ea8ae47bdd2024dc2596f16b27f27fd4dcc08776:
>
>   Merge tag 'pull-target-arm-20241029' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-10-31 13:28:57 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20241030-pull-request
>
> for you to fetch changes up to 00b4b216534d84ace7b0583cec70a3aaf256cb25:
>
>   migration/multifd: Zero p->flags before starting filling a packet (2024-10-31 15:48:18 -0400)
>
> ----------------------------------------------------------------
> Migration pull request for softfreeze
>
> v2:
> - Patch "migration: Move cpu-throttle.c from system to migration",
>   fix build on MacOS, and subject spelling
>
> NOTE: checkpatch.pl could report a false positive on this branch:
>
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>   #21:
>    {include/sysemu => migration}/cpu-throttle.h | 0
>
> That's covered by "F: migration/" entry.
>
> Changelog:
>
> - Peter's cleanup patch on migrate_fd_cleanup()
> - Peter's cleanup patch to introduce thread name macros
> - Hanna's error path fix for vmstate subsection save()s
> - Hyman's auto converge enhancement on background dirty sync
> - Peter's additional tracepoints for save state entries
> - Thomas's build fix for OpenBSD in dirtyrate.c
> - Peter's deprecation of query-migrationthreads command
> - Peter's cleanup/fixes from the "export misc.h" series
> - Maciej's two small patches from multifd+vfio series
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

