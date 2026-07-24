Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAF7C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBqV-0001ld-C9; Fri, 24 Jul 2026 05:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBqR-0001lF-9O
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:05:27 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBqP-0007s4-OU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:05:26 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-667b0ced2d3so118441d50.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784883922; cv=none;
 d=google.com; s=arc-20260327;
 b=gzdyXXmc8N8HN5a+LNoVXPNpGUHvSOUhgNDFY77ZTYmgH6W4odxYCiSSkUj+ooh23e
 JQBYbQtjk246dSqmrGQlFiiL38HdcsAsn8Qr3NHGKtIhOoPTaXqNN6OVUMcz9YUy+cow
 31hG91JbXlhx9Dw9vdzj0RMglDLhLzJMBhkktXQhYSc1Uy2P/KZNz/vig0RI+UtaPI6G
 0qNU1ID1skeqAc/WQz7TAP6P+H4NUFIVr8/N7+3GJTgWoq/9QEelb7/NFchYmSxEM2+Z
 lKVKnTXWWM36WNCYfsSSr6753bnJ35JfmuFxYj5hIPyasSEHXmaxSP4OKQ2C5fZzLSjN
 K8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wB2BU+1Vc1TG15tTSEPTTjNW5RsQoKo5eo/pDr5JZkI=;
 fh=STxFIowJCx4pxjwsKYQoDOt7BIX+xrHFt1w6RQ8JIHg=;
 b=XkRD1tZKERmAP+Dp3L73FUwt3RbTb6cx6R1e1Lb06uh53CW5kLu3uuJVJ+NhGP6e/K
 MG+0Kb1iXUNdSX99Eo3FcXxvy/4TtVnAb58iLdH8PBO/MFDUyy+NMHM2ST3GHHjoY2BM
 DpgZrYEUCYnhj4LRg3SqUCE6zQkbZgPp6ffvJ/Yu6Tc5NqWQbmc+jguyel73BxubAjCc
 lH/gXEc40t5tT46fEHyEWHym7kg4Uf4cSSRwnwI8lJZlxyNNju+RLSyBZKfxOeHzgQlq
 Yjj8uw7/8U7w2oG/IHpKwr1w3TB0144BoeIiBVsxJNtPa3GKZzROJT/HP1nKg9VyTUy2
 Whig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784883922; x=1785488722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wB2BU+1Vc1TG15tTSEPTTjNW5RsQoKo5eo/pDr5JZkI=;
 b=KMATxNakjl8F/HCMaywH1FRniJ5wehSRGEttzyhD87vWl7ZkkYHjyhrf6VvZY2BPen
 j5VaAnz8Xj7CNvFdqtk4d0Kx35zLL4Fam4fcZo9X6KZ02GIzgM+RPwZ1NBpHKvh5F3eK
 BpGhCM/bEFCAvgh8LPpt73nw5ObMdRkF76kezm27BsdSuAQwmVJcxfn2iToFKxj8FsUK
 wSLxsbYAtLgcgfYLjyxbBaXhRFixN5DNl9Uo9EOjfHrp96s3Y+1pcyBwcbIw8exoAYRs
 cr2OQXO8+qYjHgj9I5X7LP2mqWG+0FK61o9WLT2e3xGtHpGA9DbAoMGrHCMoembYiMGo
 OS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784883922; x=1785488722;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wB2BU+1Vc1TG15tTSEPTTjNW5RsQoKo5eo/pDr5JZkI=;
 b=I4snz9AsioLT6HmkFe8eOKyL3ven8rJIIaC7vilEKy2635uiX3o55NZWHhrCl9de6/
 C4vGGhffc4OrNnyq1GWrlHfB6+IwF85zzkAzbIqR1zwMAi4nYgg1mGJ86BlPM17zLAef
 ygIx5HBKNsb4YtXzArIPjCJp8sAvyRR/kVK9Y+chvZd0tvC1T8KMaoEyQz4M1CNCcNUd
 vEbX90u5SY2LEJLrl16+F81TduEOQALpNH+dSaGFwI0ctxj/uNzJJguxuLsEHfnJBcaK
 2t9S7FjrpG+RtYM70X9/GFRvILJGBglqIX3j/pQ5DHEuloSH9c6HsWOJAE7v9SeF+T58
 aRCQ==
X-Gm-Message-State: AOJu0YyIKQMJSlGHOEVjYFMvkhpaAfnWiIweR5/fqGpY2xncE+I324TJ
 ceoZCc+wKu+KNISmd1TmfGHwBY85xy4nF6+RXl/tnmD7P6Vb+jKNBHqC0a5flidWMRFQGJi272U
 lRqkVKVUYVHwgYMXJEy1KDANu3i5dTom3l4SUHso1BA==
X-Gm-Gg: AR+sD1390LW20VIvQ0srwEaawFF79R61RTswn/WLfG34IM3e+CEsITSohJzT63LS/Pw
 wMpUqCnjdp665xrovF5tidUWHdO930WCEGv/QHyAl+lC9lWT6UAKokXXbpEH3SmSg7n/UTq894+
 GJ/4/FSg3cCYtPJuIgU/eNlWaLeIitczpgdcqcQ6ouNE4yyvq+mK1GHrkhsrcSIFFDmeY31OdCa
 l3Vtedzhz8t6/9rS2Cg2SksX5zBRmC05YJ+rZ+hgYzuF+W3LsYpjeV9LGcFXzDJG04idufof2vw
 V0WUfttzQXgTRbAqcpM1aD4FoUHeAPKnoJcZEyVV9PkK7Xl5nwUTcONF
X-Received: by 2002:a53:b3ca:0:b0:667:8a13:c3f with SMTP id
 956f58d0204a3-668a4ca8e4amr1459639d50.42.1784883921570; Fri, 24 Jul 2026
 02:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260721122135.6288-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260721122135.6288-1-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2026 10:05:10 +0100
X-Gm-Features: AUfX_mwaGCJT00JZd7RJaLMRTv0VuNAvviznYWPT_k44VupjCN1PJ8QRgka4u80
Message-ID: <CAFEAcA82mU4y_qbHOSacXEutgR3FALUuzk2kEKmXbV2YDD_tqw@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/arm: Build fixes related to GICv3/v5 and hw
 accelerators
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 21 Jul 2026 at 13:21, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Build fixes for when QEMU is configured using --disable-tcg
> or --without-default-devices. First 3 patches might be
> candidate for the next release, but still these configs are
> not covered on our CI, I can't complain.
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX
>   target/arm: Add stub for define_gicv5_cpuif_regs()
>   target/arm: Only compile gicv5-cpuif.c when GICv5 is selected
>   target/arm: Build TCG stubs as stub library
>




Applied to target-arm.next, thanks.

-- PMM

