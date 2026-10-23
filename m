Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81643606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jDFVwaHy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEIs-0006Hj-9D; Fri, 23 Oct 2026 08:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEIe-00069h-CL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:23:08 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEIb-0003lt-EE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:23:07 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ae8607e8afso6161817b3.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792758183; cv=none;
 d=google.com; s=arc-20260327;
 b=Q7YinucMvUbMOj98kiVJG4EIN3QmoNdTkaX3iPRtT8d2vpIEiaLM/ifrQgQoE4kRek
 NvLItaZECiSFcFr3lU1deRYPI2DUtAc+rvc/qoJvOTtkUFcUTEaeXvjgj2v1pZ4kHK71
 0+MxlleA+zI/l4uGb7Nl34IHKcNBUx0a9MOOKxMANjekOxtVl5w7DvfAn/H5egp25jU0
 xQFQVb/rgxWZWEoAnpeLpEoi3ORGqD2d9pP9ZZQ/brzPUeK7rqXso4FRBOsx10Qh16nw
 ucRO+Nmj3m/JljcqlfYTP9VPcq6bRSgAvkrZ4ULO1pYEGAnjWkKQxieKSkycHsaDLuVJ
 ja8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TAd5U1oVwz9nDy8tp5YfJsBkNhujjzjK+7KNOGZSHH0=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=prSQOl20Hom4iOGzu1B3OzvXlWS/OUICJcldceqnmFFFKIF5HtgufVmhkitzHQC1bQ
 KSmt7upyepWZthqkyzx9TTXmQjGDlRVa9XdZlsukqRzWDUVHuiUhMLbV1PaV/t4Q5ZjT
 bNI79/QqmKrKUg0JWP7TBQayVUwT7Z5Q43CqMioCWf9ejGH/VQGibpbh1j87Ru4DFFiM
 g9NQEhE7sMp38abldQdElnuNYMrVRBLnptkWQFk2U0jpmoHeIWlUSIqjUqCPNjVAhvVO
 AsnNgNVKSH5BMwV0NGT7wBfIwYgPpsAeYY+jAKjquyN0YDCTbRt8AP6rubsNvbCy+UiP
 1lhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792758183; x=1793362983; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TAd5U1oVwz9nDy8tp5YfJsBkNhujjzjK+7KNOGZSHH0=;
 b=jDFVwaHyerdfQ78+YX2F7uIoTvwwPXiXI6/dxE4PNvUVRF4ms1rI/RVhD6+MNglAKM
 K1b30S3VN9FvTbc1+AQkYfJqrerFRhQnvEcXb9ZN8VeRmtN+49g/8LulvBTv1mv/r1Ei
 Dr8+p+wTaJoPb3+1KnuuV6RKxEog/Y25MD7uWYWaTLoTitWr/nWMKFW3QzUfXzyNze2p
 MTfBfKJkN1RqJ5S6D9ESnljkCiWZsyiDbzfldOelqZKXCJ9tEC+8YhLWofpjB3YD/4Lp
 hW0AiyFMY8r51S6FMYljhYFv1K8lnRyfO24SAn4CpN/ihUGQaMhD4MNMrFb0nZ9YvHho
 V9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758183; x=1793362983;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TAd5U1oVwz9nDy8tp5YfJsBkNhujjzjK+7KNOGZSHH0=;
 b=TfBWOPSVO8ZztwWq9Ru5q5JrIloMMb9XSTVEanszLuqK8bSsT8K3xRxbKuPzarNkYf
 KtvdHO1MEt5afeVQ1zWdEgZecbRyhPrXgs0/2JMLFOzsUMfIAc8bPkYbcaJ9ooDygHd+
 AyCrceC2u7xw0i/WezvRFSh+MQYCKreRVetRfGZ7EzmA6li0RewQ5ON+7j49J8SG6ugj
 PVOdx/83CfSOIk7synaU35deREns1gwvGp31VNgOBa1KMBFEHTfXInRrSa+/kk+JX70q
 hkfq9VovMPEWwqPOdxNanv0NtTy9EtXqcaElbA4Pgv9IVhAHcEzCqdsnQQ9TVC/cDihQ
 52lg==
X-Gm-Message-State: AFq9FYIEPRxZL/dU7simOPEBqNEmUrz5q0jizq/cd9l3Cb1YiojLzEp3
 FXgebXocB8M5gg4zQjiat+JJWg0gzndIY2MigVZ+Wws/CFGVD3uuv+2X88UQpNsV7cC1ZbEfXnR
 IhQVLNHKMK/XyUbQMeRxKzRiwl3N9I7+n2/L0FlmLpw==
X-Gm-Gg: AYBFou1OlAjTCcIib5zaVHLhV6E4r/KofIojNkxKKZ/KeeHe6gIXW/yIFMMGFoMYgFa
 ZbVbHEiklJTWkUvbRJFN6WHHH8swfLaC/TJFMuxAxm772EwRVGKY3djBlFcQrV6/8MA0QHO6uRs
 sR0LfP//DWDr1xRjubr2jkRmjGayZge9IE/JFLQ417+PZ+nujChCWlxc0PU3nBd2ZZYyDap7tFi
 6L+nvGSEVfeO3ig/Cd02KtE2WPKotKUna8tyst/xG7h9PcJ2GlMsFPNYtM+ecdcl4j3aQ1X40Nd
 zHAriZcnL1gqYEAM1avbYelr5WOF4l0rVhGGBMV1Klnl7OKU3Hl4C5pEp5GUXSRoFnI4s/B54d1
 pLrgJJQd4BCohBQM+nSpKItwH73C5TuWubh7rX+Bsyzgr8QzoBIWe0tgzbRwCdMnGsaUZKf2daq
 7QfQ9ygKNUXBE8CXXxAPG0
X-Received: by 2002:a05:690c:38a:b0:864:6f4d:ef7f with SMTP id
 00721157ae682-8b157bc505cmr17583497b3.7.1792758183505; Fri, 23 Oct 2026
 05:23:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
 <20261022213647.21665-6-mohamed@unpredictable.fr>
In-Reply-To: <20261022213647.21665-6-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:22:52 +0100
X-Gm-Features: AclHuK9cQS86p9WUt7Inj40v9Pxefy5Er_lPBugds6z5fVDOLuLcu9KFILclsHc
Message-ID: <CAFEAcA9QcieQO3_iDgYrQHDLOhgGfygOF4QHbXY2tNoyh1oHkg@mail.gmail.com>
Subject: Re: [PATCH 5/6] hvf: arm: advertise ID_AA64PFR0_EL1.GIC
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 22:36, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> For the kernel-irqchip=on case, advertise ID_AA64PFR0_EL1.GIC.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 1237077603..e813f14ed4 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1230,6 +1230,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
>      }
>
> +    /*
> +     * On HVF, kernel-irqchip implies GICv3.
> +     * The kernel-irqchip=off,gic-version=3 legacy case also supports
> +     * the host CPU interface but advertising it in ID_AA64PFR0_EL1
> +     * is not implemented yet.
> +     */
> +
> +    if (hvf_irqchip_in_kernel()) {
> +        /* Advertise the GIC system register interface */
> +        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, GIC, 1);
> +    }
> +
>      ahcf->isar = host_isar;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

