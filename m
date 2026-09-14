Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B751C88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62wp-0005Lg-5v; Mon, 14 Sep 2026 05:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62wg-0005L3-FZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:25:50 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62wW-0007ac-QT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:25:42 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab201ecso1429857d50.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789377939; cv=none;
 d=google.com; s=arc-20260327;
 b=WV1xGBmfezTFL5nt8OvJ9l5Ar07V0QR4nQdMjBPm5Pd+J1RJRuFyweO2M0F+p832S6
 oUpDMi/VzYtylUo8/5NGs9F4nIGMbcCN9OfdSs5p8JG0J7mLhyulVM3DbvTyLu3iDa55
 lFkYLq98y67tglL7NwT6rbxvRLEj06wt1083vwVohWYaN17L3e/YjpsnR1oz41i1MVue
 p1xV0/ODo6nGX3aFUGqNkeNmkloeKwlcJ9KcgJpOVrvUjTlMO1QVEX3FQtuXo0F4NRPf
 pZQsaJjhZkykISIQlEDOZ3Oqhoen0BLLnR6RgrGWBA8s82WKknfxs8hnQC4QA4uw+ZSh
 SGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ttXtpQIXqxzbNmZ76ADmjLvv4DvVyfG8eddTuGE1QF0=;
 fh=8LQETOjJZKQZ6mBfptWjSfdXEJmcldyjFN6wkgsKsAM=;
 b=h6PcaQmN/VogjcgK3NROqzczdszOhIVacu45NyOM5W9fWPZNpisYAG6yZH9zWYTjrV
 BKyh/7VeW3N+uz6i9VXtXaydZZLyx99XhPX+n4oOgkRk33f8+XFanrGK1jUYC8J4rL6r
 MvLVGdEqQNBk7Wa9me7IheMSgWKRLw6uO/opERkHc8ZTqRVYlr8SB4b6VDkHC0ipma7+
 pP5ADXAheEAFa9JmLS1qtEhqnvR18/albyDN/nVcf9mdVUCLmRPGM/+r4m4ZIGmOAlPu
 G/DHOeAjfJcZr5HrUDtKAIWO7OdZz0zcffR8qI1DPcUYS1XXD29QMP6W0+aG121yny2w
 d8Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789377939; x=1789982739; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ttXtpQIXqxzbNmZ76ADmjLvv4DvVyfG8eddTuGE1QF0=;
 b=DmqsnJqr3YU20Pb7YWBKcmCJiBiSQjyxBKfh4eo/zNqTHudet+VL0JM7w4nEdD+oYs
 8CbWhJY5aIT5/H1J+X+C51ByXwGSyWracqS7J5mITsaRBVNm7iY2Zr6v60oqifq+DNa+
 RRAtiKKkIYjRz1Rr5Y1iMrYyociYTM00MGex0XQyhj7RQnmCKj3wnpuRvgg+ml20aV/v
 9Zlz4NlRK0mxfq32hODqatKImo4bq56scMOyRIC9yJCb7xvbqX4pH+JzET0ijg447QbM
 9JDEzIbBQ/9OlP5iz5w1BCyXaGhkVrOORrpkgTtBLPAxRM1Dy0WvD7FDgQ4qF4MeBd62
 KWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377939; x=1789982739;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ttXtpQIXqxzbNmZ76ADmjLvv4DvVyfG8eddTuGE1QF0=;
 b=qywLciWVqaA9OLmhwdFUqsbGCz6wkSSutFbJj76p6h9oKsmCNEHnmJm3n9SmLDtQ6h
 FRomvnuG8y8slxLQ8bnxq5FuYPQBOyHR6amKMGj0hOIVM0UywDgm/PwAn67Cf+f/CoGy
 jBSR1Akg5Rivg7wOun2FB/qysUs39AHCNch/HMF155GvN2SsA30Qi+v33UJZqmDWjoJf
 D+9gJMxn1O8L40fnDPjJttwgCVrFZvJTkol05gJHIRtrjYen9LVNLU5jHUX1Qh+LA+tY
 YlXn/xTtUVn3moycGhHsaTehGIz7f6AfquCRfGxZy2fY5uzlnX7skBqfjplY3S4r9OYG
 U+Zg==
X-Gm-Message-State: AFuF++mAkVpgcyhOqyrDBH+27wq3JE+81PzeRgratn4k/hG4UCbNePb5
 XAWhiws67Pw6O/BPbtqJQY6QhC+yRTn5Xfa+ut3EmAPnL/zgryxcHEuxjtF2i3FgIsLYlPaVf8Y
 IozUtBDuaa8tkx3W069gJKv+QaM3tY+F+tGguBwNuNA==
X-Gm-Gg: AYBFou1ksSyoL3XWp1S7COvnGEWu1kUi6Luh099sJ91O5OOuXByNzn22y+UZQhL8g8M
 3g7CwJJyWwuR/pCwhVqRltIGORPTc1A5jLLNwieoC9TERfFijmGwUeuROHaXc20GuKcdwvzweHI
 MFR0JfylebHW+KR/Thou88nAAHjv5goqBehzFyPohNUJ78C5YoBHFvoIuEznyJHWOBPlAu3Ysyj
 BOqg0G+XUx32MACdNcIZayOgsjg+jbLrRG6EM3gNWLhRKGd9hICWnkbkahFrBx9sTffrCc1rUdG
 HWw4D1IPodSCVvlb+yk/u60y8sxC5MuMfzcnzt+LUoDKrvE/8e+Vxxhb2zT7vZysWuvif8FTjNH
 KjtaqxgnlvCj3ZEh6iX6GeQGzmIZHTk9+jfL+Aew=
X-Received: by 2002:a05:690e:4887:20b0:671:3f7:9cf1 with SMTP id
 956f58d0204a3-6714dfe9629mr204038d50.25.1789377939303; Mon, 14 Sep 2026
 02:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260909051717.19647-1-vgarhw@gmail.com>
In-Reply-To: <20260909051717.19647-1-vgarhw@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:25:28 +0100
X-Gm-Features: AcwNN1XmLjKHj964Rn0343kZcCi6eLX8Km2ZZIdn2nNB4MVSvo9R8rnCPw5Dp3g
Message-ID: <CAFEAcA9Bjg=LfvPJtP0QzzCwjx6rZ0SCyAN7Tc-Pf7-Xf7zfPQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email address for Vikram Garhwal
To: Vikram Garhwal <vgarhw@gmail.com>
Cc: qemu-devel@nongnu.org, francisco.iglesias@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 9 Sept 2026 at 07:29, Vikram Garhwal <vgarhw@gmail.com> wrote:
>
> Signed-off-by: Vikram Garhwal <vgarhw@gmail.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>




Applied to target-arm.next, thanks.

-- PMM

