Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C51F506CC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fH-0000lz-Sr; Mon, 16 Mar 2026 09:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w27fE-0000kv-Cy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:21 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w27fC-0003Y6-4o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:20 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64c97997b0fso3302922d50.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 06:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773666435; cv=none;
 d=google.com; s=arc-20240605;
 b=Eq+bNsUMGFGPUawRCy7Qx/uqDGXzwfmZk+Or0EJLB789R7wKojXoR7zehk9+InDXaD
 znCqvCJ4oI4zUxOet+axJtYAnsaGeSEUpBQcIzMbpcfWEhsj5nxYK31PXT/G4UJH8hqT
 kOtosL6s4MTjH85rYQc0gLKqCFxVFp0kI1lqXHvD/iMbRuPI6JdLJbhTYoYaQQ5QBiMa
 H7QpXIOCPOxunqWruAsrx7I7mFZ6cO/G8c2LDM44ZZdHdHpJAN4Xcp6nkrWaoKd60Pn7
 zrVVWrw6qMWeg9tMMwimeYMZSHeE7XgAEK6vXAVwm0SdcQJU/6wFhRPw5fDC1+QMMDhn
 rLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1qO0lYTzcd+TEHehS2Ce954Qcv7RIwobbt2jryIdeH8=;
 fh=gffcMCOUXtBOrrjZQMiDLavK++hmBvO7zO0yh09tQqI=;
 b=e9zOy0jDG6w6rODG+oXuAn38/Crbjorwdl6nCZTOeNstmbbDRhewFUzoA0Gfv5+pJR
 RtJvbB20xfX6OzqlOvZe6Yhi0+QVR2of4aNEMsWM8d9FIaZ5HzELbUsYxqzndNClLAvE
 Qqunmo736G+WQyN1qK1aOZzl0R/oYAqGOkrBA4ykN8JbNeXgo66Fz2hhlKcuAZsYSomp
 92cLvmAmjAsAPVFdhjPNCtZByJ87LZM0FVGWVEmbOzPWGuWXPM9rXwwaMmo0DGcxT3+w
 2nBELvpO/x9AabVv22rhEMwBsHfIBSgZrgzstC09KWdIiuCHCEySk8Hdh5AN/GDp2K3S
 u/mQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773666435; x=1774271235; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1qO0lYTzcd+TEHehS2Ce954Qcv7RIwobbt2jryIdeH8=;
 b=iaWaWCDmr27VWPjiBEyv9/3pxiExvy4bKTjdsM0qj/1uE+LI0f6gSZi82VJRdLRIgT
 Ws6OxR8tkbfesUGUP/4Y94AwI+WtF53DkiszO25qSwegGuZ4CiJiLzEtvvdNj/tAqmx4
 /7Wypbg9wFxzFRWhgSnQzqHLeddQwuRo5+FnFWSMuXczOSBy6d7zNkQyd2pSWNsV3+xg
 i+6jiME8E+RirdCdN5+2ZffpvGlHc9xF9Nx0jliG1OCUh84yu3tMimxJDORp8f3lb+LU
 5+Ug6wA6C2QEzcXms/F2hGDT1L1Zki1oxeVQ9jFhTUvZwnN5xXBzxS8I2QkwBGU10yvr
 z6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773666435; x=1774271235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qO0lYTzcd+TEHehS2Ce954Qcv7RIwobbt2jryIdeH8=;
 b=js2LNme+DCnrJQILusFtBoBbOKrRgO8ZBrGzslDOU1XumB/3SJkED/T5SsxeDprCgc
 QoiQr2gmnaDZRmoC3hcCJpq6NVshm+rdNGC7Qp46UXy4bwM7LTtd5kVYeUuJFhIiOVEV
 SBMeEGEtPqZAWKi6KdoKop7R1uEPJA515mWrUdG8NxvEEzRi6Eh4+Ug3ki43v71pr6tE
 VjwEkwMuDNQf4RMWR8K1EIGE1BjFOUr4hYXGkyNN0V52oOQWCoMD6TKMrlyB1w21XGg9
 QmZC+h3mTrpEEsnV9HbE0opbofaVsN+w/J/9T7vy/4/27x93cQZkCsuQcjS0G6rMpaCt
 xriA==
X-Gm-Message-State: AOJu0Yy5d6UAy5Ds0QOjOMVtY5U+KtLwDB7VlYzQ2kTBYPglaruAjFd5
 1f44VAxPgOWkdShHcR9mT1Q49HX7+XKDWeLcpG6ru1Ah0qt5LHtz/kZ7nvKyhr+ZJYHPmNpng+Q
 iM0BQ7oPMuAhHUqhOwDrM2zhB67fDZ/xk/SozMlCOzN/liLn9jy+1
X-Gm-Gg: ATEYQzxY1VkwmN0pteoiUcG8zP1JLWoRP+ydqF9pk546wxwWgbi7nuoM6jC4hU6M+A/
 PZ3GWTm2m7ZSFlZsQ1IEW1/ZxszciRNRTuUh02NvO/aDjN7M7l4lZEoOJ6HPXtOeoY42paa6eNX
 O7Ozupdv6aRCn+riCDRc2GFYgRnualH/8uFb9WR/9mf1+TgIh8aQxe7KWEr0L7nbpYSac++c4sQ
 0QDJIPmQAFaAuTkahjWABIMFK5+Nvf8eC1BgLjJ1mZELpWRfzM35mAccEJ0IMCXGElKg8qcFGsR
 IbLF/Zoyp4rsbNxHEDnC5Cic4WPG2PFyM4b0/4acP+HYzdFmSlSIKHxBRT/xdJQRFZg=
X-Received: by 2002:a05:690e:1306:b0:64e:86c5:8da9 with SMTP id
 956f58d0204a3-64e86c5946amr335044d50.6.1773666435300; Mon, 16 Mar 2026
 06:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260316104039.195960-1-thuth@redhat.com>
In-Reply-To: <20260316104039.195960-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 13:07:03 +0000
X-Gm-Features: AaiRm52ZI7TIvf7Xp7bXeZrOBR4p1ffkDfr1oJxK05e_TQfuRZxLsxUiVBZajHc
Message-ID: <CAFEAcA-MWUzt9GXQbdp1bov2UfZghFcWaPO9QNqWEBxjTPK+3w@mail.gmail.com>
Subject: Re: [PULL 00/14] Fixes for "-device xyz,
 help" and updates to MAINTAINERS
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Mar 2026 at 10:40, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb2922a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-12 15:21:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-16
>
> for you to fetch changes up to bc4ee6025a71290eb47d86c2c77eb1f40fbb6305:
>
>   MAINTAINERS: Add another reviewer to s390x boot (2026-03-16 11:36:32 +0100)
>
> ----------------------------------------------------------------
> * Fix various crashes that can occur when starting QEMU with -device xyz,help
> * Update various sections in the MAINTAINERS file



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

