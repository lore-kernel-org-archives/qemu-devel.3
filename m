Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CABCC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 16:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYTWl-0000x7-9q; Fri, 09 Feb 2024 11:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYTWj-0000wv-DT
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:14:57 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYTWh-0000OW-MF
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:14:57 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56001b47285so1594285a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 08:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707495294; x=1708100094; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2zdmkVODjJe54yWW4qNAaj6cEulhsvnhm1tU7IcuJnQ=;
 b=xyfdEWUchp9YNB9PhESl2F8oloGiIq6sOkdSijGNS7RdFGkElZPbbpPf1ig+SUEFOo
 vo6dxN189qkxPStSQJBia6ewy7DIeflIUvSdqFS0WUTyoI11/7/vP43XOGxyRhPFFGz9
 nzr5M6hZNm7EX+MLjqALSd7hcqJMmjhAfKjjHJhBLcyMzBxUKGh1/PyTBN4UTlHqJhVh
 58T2H6gHkA/69t3oV3uLc45Xow3xWdjkN/A8O1xOY0Qee0S+dnmefW9HRarz/QavCJSp
 RIk5pI4N67l73dzyZdiXQJe7mCzRbn/8R+5qHk56tZ+Iw5uIKN499xMqPYgyaUYfEzv7
 Tazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707495294; x=1708100094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2zdmkVODjJe54yWW4qNAaj6cEulhsvnhm1tU7IcuJnQ=;
 b=gtQq7tEqc+m1rmIUBaKkgs/0ppb2eBF8Gzcnf48AHOGaIB5M9n6ZNeLPirqmTfvBwU
 R0WvkRuRh5ur63X5zgZ435Ob5pxoNC9U6wD73DHxLJNDANe8f/0TNXY2vmuyeKlUrTgk
 W2tgAEnm8p8SQNZVvFxxIxfsve8dUievnJDnEPxO+s04xwxJVzuC8LfAykjXJtYOs85K
 JkjmejjhXf5eXHW/PB/EnHz3uQJ1prlVNCZk0b8SSNL1htS3VtDZ4/R2pbkH4nkAt6Je
 mc5xnhcMmLpnNQlQqndHxBDbqwWHgw2hJZiqEwNStmYOd1dDsdyJg6nQjHQYJy3RNJ/K
 sYmg==
X-Gm-Message-State: AOJu0YyLqJt6btPa6oxDiAU2attY0KnM4ebPwkYcPGjgS2QgddipnyWm
 UlaT/nqtAwLMuWD6d2e6D9NalD0DyPWJhz9OlLGYOjEBmFIJRLcxHzPS1LaZENtQK3UglVYJ4er
 5I8IUJtCoZ9tm+Kcb0jDRztgJ+lRxW3w9U0ge2Q==
X-Google-Smtp-Source: AGHT+IEonn4RKfxbeeMTEKJknN0ZO7yc+79+x5msft1PnaK2asQdYFtTwkwajuSdMk891Ajbxp/thGaD2QOZ5EEhwwE=
X-Received: by 2002:a05:6402:356:b0:560:eaa8:9654 with SMTP id
 r22-20020a056402035600b00560eaa89654mr1655152edw.12.1707495293949; Fri, 09
 Feb 2024 08:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20240208030528.368214-1-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 16:14:42 +0000
Message-ID: <CAFEAcA9uT4gtH_GNVaS0PQBUUKBgShs_eZFd72D0pWU2FqemAw@mail.gmail.com>
Subject: Re: [PULL 00/34] Migration staging patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 8 Feb 2024 at 03:05, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-staging-pull-request
>
> for you to fetch changes up to 940bf8ff1ca82aa458c553d9aa9dd7671ed15a4d:
>
>   ci: Update comment for migration-compat-aarch64 (2024-02-07 10:51:27 +0800)
>
> ----------------------------------------------------------------
> Migration pull
>
> - William's fix on hwpoison migration which used to crash QEMU
> - Peter's multifd cleanup + bugfix + optimizations
> - Avihai's fix on multifd crash over non-socket channels
> - Fabiano's multifd thread-race fix
> - Peter's CI fix series
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

