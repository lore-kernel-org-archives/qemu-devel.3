Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C3D7495C
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 13:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6VEI-0002W7-Jt; Thu, 31 Oct 2024 09:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6VEF-0002Vk-N9
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 09:28:48 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6VED-0006m0-B5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 09:28:46 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso3551662a12.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730381323; x=1730986123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeP2QOZSEgr376nGAbwFxRp7c0KN6vb8QnoH0EUmki0=;
 b=BSyFQLJXBDFhh8UxrCgQFyAbvIe+MXWIa40dcwz6158f+573MJlxgdxqSQ899Nv5Oq
 FbnJgJsjfgOhy8Hnt5k/4IBGDn48Ng/oFLLxwFvjpyxXOhWWwYdtb3DQzzPG4BLIREff
 B8YE9FX/Ae3/MWjEXZQwKF/Ez35mJnZMysZ0aVZw/Qdh1nsvAO2bUh+sNrMej7SENC5R
 YdFzkM/0OaOk+j5NhtAPoLAowIDNeYIUb4zTSshFtfEeta9vMTyBUtoCoK6zWdTVVoOb
 lA87RAgUqUhceHcScGbAyW3CTtP7f+Uq/waP+LYG5BXhHV1fxeTHN+ooqqB992lRjxjS
 LxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730381323; x=1730986123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZeP2QOZSEgr376nGAbwFxRp7c0KN6vb8QnoH0EUmki0=;
 b=WWUscZcX1G3WDGJ1Ym6+edVlnR1Jx/A+LcwMtfxBkqroOJn++gCahIywK+H/ctYspC
 ZaZ+w9FBCPpB9/JgB3qmNfOfw8pA1P38IAag5TvAe7QwFxqyP4Py6s0rdFS/g4DIpD+g
 yase1NwN08qfGqWCzkdVxsMY2Od4cNGi+44uG1txEPI7X4psFcRl2w/zMGmLepRWRha2
 VMWCbD4pBwskzfkV8ha4B3qH+J00oo6GdaOq9GJ5nJT5ZwZty5tb5qN+fErX05Ej3Z3r
 P4sx1BhbAiahn9+hXBtgncu6PYoQ8uwVY7MWWtMhvvGnm83LsWfJNPT8E1aXj/YnDaci
 X9KQ==
X-Gm-Message-State: AOJu0Yx7Y967vmOQlRsLJUUbbtGTA78wk45SAiTqyJtn+Ird/sJeuHzr
 RrvXVUE6KBQObZcBqHr1uKEU6ijIYntF4oIhqlf+zSnqFaNFm4kWP1E13xZzOKJtI50OpXcyK09
 eXUvNPnPMWAgfTzkyNBBIpYPY2dgEd8p4cNuXzoSnJt7Zk8SF
X-Google-Smtp-Source: AGHT+IH6850VMn/u0eYWh8Io6TeY20efmxavJ9p8ZaEZCyc+K6DlizjF1TJyH3t4Forg4/m9ivrHQqyUqrBhiTB8bkE=
X-Received: by 2002:a05:6402:1ccc:b0:5c8:d9b8:9325 with SMTP id
 4fb4d7f45d1cf-5ceabefaf79mr2664128a12.5.1730381323176; Thu, 31 Oct 2024
 06:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241030155734.2141398-1-peterx@redhat.com>
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 13:28:31 +0000
Message-ID: <CAFEAcA_p+LiT6wz2UaPBUs14XBnuCM9x46piOLSJP6WivMMbAQ@mail.gmail.com>
Subject: Re: [PULL 00/18] Migration 20241030 patches
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

On Wed, 30 Oct 2024 at 15:57, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit cc5adbbd50d81555b8eb73602ec16fde40b55be4:
>
>   Merge tag 'pull-tpm-2024-10-18-1' of https://github.com/stefanberger/qemu-tpm into staging (2024-10-18 15:45:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20241030-pull-request
>
> for you to fetch changes up to 53a60118d2654dd8e595e61f4e767ff747fd0b69:
>
>   migration/multifd: Zero p->flags before starting filling a packet (2024-10-30 11:32:41 -0400)
>
> ----------------------------------------------------------------
> Migration pull request for softfreeze
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


>  {include/sysemu => migration}/cpu-throttle.h |  14 ++

Hi; this fails to build on macos:

https://gitlab.com/qemu-project/qemu/-/jobs/8237753019

../ui/cocoa.m:40:10: fatal error: 'sysemu/cpu-throttle.h' file not found
    40 | #include "sysemu/cpu-throttle.h"
       |          ^~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

thanks
-- PMM

