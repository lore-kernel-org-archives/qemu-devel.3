Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55401CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ42M-0001Zg-WB; Thu, 21 May 2026 10:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ41t-0001JU-S5
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:05:43 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ41l-0006CG-Po
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:05:39 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c52bb5dd7so6020724d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779372323; cv=none;
 d=google.com; s=arc-20240605;
 b=h7938oPTeqQbemIsEgFhWFyD8gOC7MPULwqJvx6OL0gV/K0R/jYDWjVOUYrLf3ZLGF
 fIdjldsNgFNzkeLB1Wa+vMvQo3Dy0R0KlqM3Rmq+zbTQ89Db5rBT7huyCtquNxJWPMHs
 bCPzYBTXB/nrdyIY5VE/Kiq9GL3+f97YPUMT8qX3Gi0yoXDnDPRy+NeV832g5L/kaPQq
 4BoD2oWcJ7giRv5c878rUGSkeNfQxObDYLQFXLorwdsr7aF0rvujhnzkB869mSzXlJHb
 Ckd1mivl9aDUuCHhiHvH/lC1pV6aaQ46NVc0Q6NLCO+kZqTyXHhcefQdcwrj5xFwfg/D
 dmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=glCp+je1rn5P2pXLcdWdgxumiY4iqmYs0GuwWcGNqfY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=IcNmAt0UPovnIKwG2W0QZrvuzASv7UGusC2dcE55qEcWdYTb9y8al+EWgfb4oCrEb+
 SFjU1UP4etwVHBbFBqAFVrYZRJU+7OVrKtFQEOC796HU/I57W95QGpzoT5agL5MkARHD
 y8NasE4ZBVkrvIrUt1U8G5B9K8E+bHsNeQ3M65z3NtzwIF72G/8X7vET6GIto64djlTx
 jXY3gTJ0VZeRnOyPQ54mazb49Yfnf0F0YMexdLFv8gRd8SZlSi2ddc45oswMQyBW4oqS
 ICqQDXJpFizkWg0Tl5EXDkJv/1l1ELZvlcaOq18qVbPCIk+vUi6X8GZMolgHR7CSUarw
 DB5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779372323; x=1779977123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=glCp+je1rn5P2pXLcdWdgxumiY4iqmYs0GuwWcGNqfY=;
 b=PEZS7dc8JEnnoWR7aNajrtmaREie3pvp6qdubQrcddOV+TEjUNDtPl6TBILd9vKVRW
 JrSFgz2Ks4YVIFlLdPDE10a34H+NRzOc4w6tQnKb9YqZfIUGNANvd7z9D1UYjYTd8Dok
 FsHGEMVSzW5xmqiaOkch+PJCKxJVSkr1eEp1Mj6YfmZZ1BJHvgrOAKtRZoAxNwTL4uE8
 pAlYQ1I9Zk70rkrbQbhhulL55OrbnT4Sh+ZzFM4jUAKBEw7ocGAMBDOjNjy03Zrx7FHu
 5Zkv+Xt8KIbb1q/Sw5hkvYZEgmFKD/KFaMtw+7G0n3bFbjO3FAryz2ZcZMnFeTCUME30
 Lplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372323; x=1779977123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glCp+je1rn5P2pXLcdWdgxumiY4iqmYs0GuwWcGNqfY=;
 b=TzKMf7WOAYWbxdDJcWQMUmn9LUivVYWinqUYDIvDFQF/601Y+kaRaqbId4slLp4/HC
 fg9M8n6Gekg+wXy0HsP1FcOyFI+8xWrUFbcL0pQAvBXlwYuEMMqWT6VZpib0zdl8YIyh
 iVtcZiaRg6eJXI+Zh4VhsXRWoGRMt1Feb38+yuy4ysANh2GmpZ/Ppi1VFogR1sCUTCDg
 M0ytyUI2J9hEC0szXbbLCMPUkeM2bLZoxU2wVVRr63Awa9COroWv5Dp/tYGBDBvjls5Z
 7hQ2L5ulPghwdNLigDXJ9ox2Sy2Bu5a5zy9mu1Qy7DQlt+xa8RA+2QJOud/GD4lzsjgc
 K5eQ==
X-Gm-Message-State: AOJu0YxRvLg8+bd14Rw9ZjF2tJlh0SRTLVjwldgdrEd4wN/YVJ+YkDUN
 gM+ch/Wv63cejFmO1O+QT6QIXw05FCua8Vei3OV70OJTVveTj9o6OrUv7r0Pjp2Cf/QNqDm5Y+6
 kFLPtPPh7T9nC2WOAKLogcPLs6rW5p5ycrit6jJtXKg==
X-Gm-Gg: Acq92OEmMW5BpmUuDThPwFJJhQMDpjdw92SLesWnByb4DzqEjo6vUCEvXQYyanN3sZb
 e8kfIx8P7hV4YssNE5Ya5uhd5w1f9FULQ1Z7yOvJ+iWNj6tc5tqyAyp6aiTc89Go1aIL9jNkwdv
 ThazBHzv3FpC9cvRVYyYZBIYTdlT64dLDz+7bU9eZkcIdYWRZFwKdf8ZwuRYNv4pCt/X+QNiOjj
 GOdSOug90hwFwkzbQmcp95EkcivHNdMGwBaTeqxVBX6I7YXc0xF5UD0CNJ0JWUR9Y0gJ27VEkHL
 nP0g5tXxEZ054J6YQnVh+EQmMdmjUmeYz41Jpr2YY7HuCZgsJBzeCF1Qei9X6p/OqVzBLw81F1L
 Xog==
X-Received: by 2002:a05:690e:4005:b0:658:a18:cdf0 with SMTP id
 956f58d0204a3-65eae04b9c8mr2467505d50.29.1779372322588; Thu, 21 May 2026
 07:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-8-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:05:10 +0100
X-Gm-Features: AVHnY4LqOFoCm3gjOXHMXDgktw6dOeTzm-XZplVIIAcgu49kGFvP-RoA1aGl4-Y
Message-ID: <CAFEAcA9sOVf-R-3xDmvKYeHdEkCXJnC1P-nDi6h4YZYqdpiURw@mail.gmail.com>
Subject: Re: [PATCH v6 07/64] target/arm: Update HCRX bits for Arm ARM M.a.a
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 20 May 2026 at 19:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 00830b1724..f02d3c6a71 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -258,7 +258,9 @@ FIELD(VSTCR, SA, 30, 1)
>  #define HCRX_TCR2EN   (1ULL << 14)
>  #define HCRX_SCTLR2EN (1ULL << 15)
>  #define HCRX_GCSEN    (1ULL << 22)
> -
> +#define HCRX_ENFPM    (1ULL << 23)
> +#define HCRX_PACMEN   (1ULL << 24)
> +#define HCRX_SRMASKEN (1ULL << 26)
>  #define HPFAR_NS      (1ULL << 63)

We should keep the blank line separating the HCRX bit
definitions from HPFAR_NS. Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

