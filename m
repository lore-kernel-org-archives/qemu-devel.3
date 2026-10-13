Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BFDCC6B1C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGffs-0008Lc-G8; Tue, 13 Oct 2026 12:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGffp-0008Ke-Ps
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:48:21 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGffn-0000A3-1p
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:48:21 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-888cbacf70eso37722647b3.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791910098; cv=none;
 d=google.com; s=arc-20260327;
 b=eNaXk80X9FJD/xZdVJiKIyxwG6PtTh9xBEr3tAs4l0lcg9yFoELtPI7GRsNf4UuLrD
 /udX3JeZF/ylJ9BrXqPjTc06kOWscEJ940m5gBkzoincFRMiDHekQiHtbX02tJhokcHm
 Yp1khazLmsaTH98NfB+nSai2zh9i3MNklrxuBRyQIN6xJfY8Zss3klqWlF4oRNzlqcft
 KRG+MxGADuHGni8INPW5zlaRk0WFFQC6JFmmNn+U4x8tnUCIuBh4wldE1q+8I6a0FuR/
 E+HMqM7fHmLDq94H6vStkWC/pCB3rrgpIToBUtZK5klq2UsnWoB/dfYUsBmmO/g5Hja0
 ugNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UbcTxUBPWUyFIA0yRh+V7xI5nZadhqOBoqHNTMUOxcI=;
 fh=STFjNyXLj0lfgNvlZzFLUS1rWfs5JAUbmS2H0sDlju8=;
 b=PvLW9hQCtkJoa049hTkgfpDK9KYfpIOevS3hl9+SRbLUCMDaSziVVAL1ixO/yZbmMp
 mB1XFU6EP++80rnbFVt3F8hT3xabcg/hjrO8rwN4H1kJcotgW4y0onn00HEDQdoOQoPr
 ruQLS3uc0DY/DSEC32qirYROxct85O2U9CQYdQG2/nG9F8sMQjRGq4cx+/qMWkKMBv9g
 mO2nXT7jfF9Sth+6xsBkiiD1qSSzDw3azeBrHTqTaI8hzVaKA66KSjskJl0E4BuSEOGX
 6rHTLJyFLRnxVwQjfHcQmhYG0p8utFCLhc/kVxOPj/l4mmDhukpO3Msom1KyQdvoetuS
 5xNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791910098; x=1792514898; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UbcTxUBPWUyFIA0yRh+V7xI5nZadhqOBoqHNTMUOxcI=;
 b=OCkK8X8vcZas9qBPKGPpKSctiSPfwna1Oqm+wo72Q6ItBzs6rPvECCt1wmh9d3TMwG
 nGGK5En+WBNSj6R8vxI9HgmBhqusn1Jqdr10+yjIf8ZJEqtVRb/Gl5+oM9ApFNI5K6na
 g3xJCGvZRtPclk3rUjkHJd6qy7OYx3gmeitJGbbZ7JKXjynpPBfMU4WhdtwyCsvobW7/
 FjonRjY/JNZnmQS0kC/YGa513GAV2wtz5jQj/cqj0k//RMhOdJYeqN+YMRdScOcSYOa6
 LbXP8S7HAMtRqXXMDsYCrNL7poGK6Ct4SxmQ8xCtN+UnTG92XsA6OWNUXXDIU7RQEVdF
 OAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791910098; x=1792514898;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UbcTxUBPWUyFIA0yRh+V7xI5nZadhqOBoqHNTMUOxcI=;
 b=aI5POPrKQE1vvlG1ve+oBBsT6jzOxkc5lfcaPUJp/QUXj2AVIBYr9LQvk3VhIe2Jte
 fySNCthGddHzQ7ZaBZcYRDwsPpLSJT7YJVr5bXmo3Jmqrk2aZyXSihy6rUYXG5xW/a0t
 9Jyu9+7j49U01jowRTOE+2deGnEq7YjBp9hkoEqlSKXgB9m9//Y5vL8yxsb5GlnGGjzm
 XeI6OMznU9QLWz6dCOCoPWW99M7pCaJmTxEUuudEYuAadp6D0VljpbEvz/I54AvbIod3
 ddIKCw+PLzB7yPQsmLknkHwI8krOpBte6knA8WFfSgdABAquQ5kHF+rDOM6dF5+7pMct
 YUZA==
X-Gm-Message-State: AFq9FYJG8fjeM6WOwuVYbPzqKoXYn2DpHPzVQVFWyeQDE7noj2lGeXt2
 hypZrZ0U5pOvLiEG5bffSZr4svVE/kIjQmzqSyojvFQ8B1iapj/J/ENbqjVnh2Aum0ULTP41rUy
 n0RRexTq2EC8nq1WAuhyrDdp0QgY/L8KFBjsSdxek9A==
X-Gm-Gg: AYBFou2+GAdOQryOywO+p2PrpEJITLrK8QHrES4ZHUpHFWcDOcvP5nmwHlzp8GBx1R6
 +kSKNqXMik6fTn/ul1v+iEyx5H16tVqnO0gY5Gvk4Ytwx5p9JG6fH5M+jKrO9NXtEK5o6az+2uH
 xfWfh1XupD3qYaQKRUvgIurIQIEAIx02VNN234XPBoJHmvwnkeDhRbFRrzpTEs9/YFrLVpzCmwR
 sq49glh6GiiWbuTt/MDuTjGG/PQxLGLkRNdT6ewf9pquDykkovPuEwJ2/E0AN5Wvl2j8klg63yU
 fj9y31e8TgPDvcdFO1DUep3pG19xN99UNAIkIytO29dV/JmmbmOaeja/uyTtC2ecM/uW6veM8bi
 VwdytuFiwdZuth+F5xlZ6fFrSsI9L2Diw6JqSvks=
X-Received: by 2002:a05:690c:64c9:b0:873:5c6b:a303 with SMTP id
 00721157ae682-8b07ee3497fmr39342127b3.49.1791910097705; Tue, 13 Oct 2026
 09:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-4-aefe5e76a0e3@linux.microsoft.com>
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-4-aefe5e76a0e3@linux.microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:48:04 +0100
X-Gm-Features: AclHuK807kaRaph7r4pkL63cFbItPKEV6IXn2fB43vXfeDZ3f4hY5r4pdBLYolc
Message-ID: <CAFEAcA-FfUt2AmxnAqSPkca_-WBS9WBvRgzfj9f26by2FccqDA@mail.gmail.com>
Subject: Re: [PATCH v6 04/14] meson, target/arm/mshv: Enable arm64 build & add
 initial MSHV support
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 1 Oct 2026 at 11:52, Aastha Rawat
<aastharawat@linux.microsoft.com> wrote:
>
> Enable the build of the MSHV accelerator for arm64 in the Meson build
> system. Introduce initial files and stub implementations to support MSHV
> for the ARM target.
>
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       | 10 ++++--
>  hw/i386/mshv/clock.c        |  2 +-
>  include/system/mshv.h       |  2 +-
>  meson.build                 |  8 ++---
>  target/arm/meson.build      |  1 +
>  target/arm/mshv/meson.build |  7 ++++
>  target/arm/mshv/mshv-all.c  | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 103 insertions(+), 8 deletions(-)
>
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index efe19a3914..f3f1825b0b 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -142,8 +142,10 @@ static int create_partition(int mshv_fd, int *vm_fd)
>  {
>      int ret;
>      uint64_t pt_flags, host_proc_features;
> -    union hv_partition_processor_xsave_features disabled_xsave_features;
>      union hv_partition_processor_features disabled_partition_features = {0};
> +#if defined(__x86_64__)
> +    union hv_partition_processor_xsave_features disabled_xsave_features;
> +#endif

This is the common mshv file; if you are adding __x86_64__ ifdefs
to it then something is in the wrong place and needs to be moved
to an architecture-specific file/function.

thanks
-- PMM

