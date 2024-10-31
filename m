Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA60CD767D9
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 14:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6WXX-00043X-Ge; Thu, 31 Oct 2024 10:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6WXV-000437-57
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:52:45 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6WXT-0007m2-D8
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:52:44 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so1516008a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730386361; x=1730991161; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJgLVJmeePWa4W+iUyK3ZvX400I8PGqGDpOgiFC8j24=;
 b=K3QHVu4Go5Lt3MyKSYWjbL6GQO1Tb0YUBfA571iNwaBJZ/gKXEIV3gulMcF+DIC6kK
 3vQNqaJBKKXjWz3of4uQU5TBO3aa/RGswl1m8Kgi3lXwZF7m7Lgc7vQjmkLlo4QleJi0
 TfeC2ueJKM0/0V2ZcP8ugsazoYhn7TaPGYMY0YWjsWaOdaNHZXRuGcQUMz38YXdK52Ph
 Ld0DzwCP+T4jJHcIKZA+ykvwD5ytrY/XVX9YuZrYm3dYtOEJBDoLVMNya45gdfZZx/Bd
 hQe9HU/2cAuq9vXr34xpdfXOt/5MRM5gBiQcZJ6ZPiwHWUY54OufzNyc8eSJXpJ7ifab
 tO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730386361; x=1730991161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJgLVJmeePWa4W+iUyK3ZvX400I8PGqGDpOgiFC8j24=;
 b=Q93Pv1hFjNAWINIWSOfG7MpBjWeuUg5twIxjr5EnoDxqOC2U3lMNSztykGsL4cqpDH
 XzL3o9T68nX/zhXq4rsBBsv5plD0vhC1MmXSiblCC+NtdkCMo09TEJ47yT73uWuXwFFI
 8an7ALif9PbjY+HidYe4kwcbzyEgOr8M7ZQZoEsUgKQSt/75OyjXFCwYH8hK9PWkKUX6
 8b+2qMTTJXvFlcbPz7fXfawjM6jS9Wk+ATp2zM5/W1aJoEwX0yy/uErLWCop1pAs4dDs
 GjXFcg3WkvndD5X9z1HvQPfnV/IsiXAsNJ8DWDrDi6/JPD5jingMy/bEFMD+CuUcpcQU
 b4uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfFU3Boh4qbHd2/R4iWLH9vC3FGvtIZQIgq/YQiWmGDGB0ZJQO9npGQyA7v1hsFgFgsyZFmepvONjN@nongnu.org
X-Gm-Message-State: AOJu0Yw7+C3la0pZcWEHe6WfAtb7NeIStGgdcgRqdEnPJcaefalF0u4F
 inA6lw0FXEi7svusFQdU75kcnZzjWYRl3n2seNuSZp7TGxr9+BH+o7iLuC+LohpRcJJscIsc77R
 XMRSAyz2fIYRPVxHkGo8vxOn/l9O3YQ6og8X9Yw==
X-Google-Smtp-Source: AGHT+IFwR+A/kGV8kX2wywIUJN3dR7Phmd92hBldmHEhb85QCOs1IPg4HsHV0kCU/Wir051iCdp86XgAdkZubCHkqg4=
X-Received: by 2002:a05:6402:90c:b0:5cb:e53e:9d86 with SMTP id
 4fb4d7f45d1cf-5cbe53e9eb4mr10412424a12.21.1730386360676; Thu, 31 Oct 2024
 07:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241030155734.2141398-1-peterx@redhat.com>
 <CAFEAcA_p+LiT6wz2UaPBUs14XBnuCM9x46piOLSJP6WivMMbAQ@mail.gmail.com>
 <ZyOZTDUB-GfyRYo9@x1n>
In-Reply-To: <ZyOZTDUB-GfyRYo9@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 14:52:28 +0000
Message-ID: <CAFEAcA-HCha9cnKvB8Xh5bQMspcEeyYr65i__MCg=2OsYdH9zA@mail.gmail.com>
Subject: Re: [PULL 00/18] Migration 20241030 patches
To: Peter Xu <peterx@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 31 Oct 2024 at 14:50, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Oct 31, 2024 at 01:28:31PM +0000, Peter Maydell wrote:
> > Hi; this fails to build on macos:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/8237753019
> >
> > ../ui/cocoa.m:40:10: fatal error: 'sysemu/cpu-throttle.h' file not found
> >     40 | #include "sysemu/cpu-throttle.h"
> >        |          ^~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
>
> Errr, cocoa.m used cpu-throttle for Speed feature.. so it needs it to be
> exported.
>
> Luckily cocoa.m is only compiled in system_ss.  The simplest fix so far is
> to only move cpu-throttle.c, not cpu-throttle.h yet in the commit:
>
> "migration: Move cpu-throttole.c from system to migration"
>
> Fixup patch to be squashed:
>
> ===8<===
> From 68515db81e28832cbd24b1cdbc12aeb618c9de54 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 31 Oct 2024 10:37:29 -0400
> Subject: [PATCH] fixup! migration: Move cpu-throttole.c from system to
>  migration

If you're fixing up that commit anyway you could also fix
the typo in the commit message: s/throttole/throttle/.

-- PMM

