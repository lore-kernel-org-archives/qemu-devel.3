Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EC2EDA682
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxROB-0005yA-8E; Tue, 03 Mar 2026 10:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxRNt-0005Tc-UF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:10:07 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxRNr-0003uE-6u
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:10:04 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so4817101d50.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772550602; cv=none;
 d=google.com; s=arc-20240605;
 b=P7e/AggZpkKylvgcRFdr/Zs5oOaLWMZMZQdnX7jPVCge5XSLJWeMHmR7PdfpOfnMi6
 FqO3WiQ1XbbtyirinqPgkMrkGG/LVcrHUjn5LnSGLNQb0te9ADSXF7vloBVZ3d8tJeqK
 t2VM7bZPlsvIhBdLkPIl2centFtTJvxkur8jEWYj3k4dyNSEJ4szP96KXSkGX8+G25aj
 DzCDKKsyt49crKB9+UJ11xPTcF9COkyxDgEVq2cSrZIUFU+tEewmzrwGNkuoBCwelYJJ
 NftOOLud1Sr1kAwGExdX1ljwUh4WX5+U0Uf4V6wSYZJSFoP5ds1hWyt+MsSzLYGR0Uq+
 Wp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fxXTogvuWYH9Fq6iS8mpnihsHSCczqovzurl8AXK6fs=;
 fh=LxwO+sNjkA3OxY6FxKRJEAnaQYryCEtQLNDujGbbbLc=;
 b=Ag9M8pqv0HDWCMlHFK0suliXPtoUfPrJXf9B/F8j4AHEk7PlvedN8I0i94ivjwEGdC
 n2VSWZtwRH9EH4EK6IMuBmDpYvCJW7DA2fII5GQ6Z5pelZYfIpLtSVdmxh0pXO0ShRKa
 MvI/MJT7NYXxPmmyU1b2BOXy3nl6J7Zq1s+WKQF8A98rSTCBbDZcxij1/MyQT/xQ5vs1
 gQiNyV35O6PtBXCd6tR5Jv5iC+jh2ekoz/Paa1vF4+dJBu3cQIG7eBEATki+0JwB1D9N
 y/+maSC2ndPvt0HBAAvlwo7sOMtZskLfJivRz6edjPTCnkeXvDwdcSg619RRWM0Bc1UM
 8CWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772550602; x=1773155402; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fxXTogvuWYH9Fq6iS8mpnihsHSCczqovzurl8AXK6fs=;
 b=n6XbAEF4Rz5Wg3Ewx2cmGZVnkFjBYbPba8u4rRAgT57JJE9gJDLi2JKFkwJSxJFZNK
 6f4OZtYYKvH6gh0P1NmKUe6z/FvS9f+A2sdBJ+1cRJA9REmGfumtu6N2/ZWyszZkeojG
 DtEWn0U8jTIBfHWVqHyTQa1WD6c2UEjXY/YxG037ZJMSakVSFsPYAffxShEQoB0O5Zj6
 lleuFq/0WXBFesZSYKsATCtwH1Fd9SIn1OMmocWzQa0/6PGPtNkdTtATCKudy1PAvojW
 UKokZKSvNCFBdw4tewjGcMBgsPVQrTrBbis5zPh14W2ApM40n8+qprBkTgHUC9pHDbsJ
 PT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550602; x=1773155402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxXTogvuWYH9Fq6iS8mpnihsHSCczqovzurl8AXK6fs=;
 b=dDl0UKUmlGPZVTXy8FE9rDyjrsG8FCo5bUGWMfnFlC0ArYK0Cj8DoKKrhvvjAZV8JE
 YtvUkTkZCic+n9oN3rpQK8Dn9pJplvsFUfXpjmgtgsc4Gt2sJbWTiEnlbrXa0S09wC8X
 u/qg9maouv65jeuHyiDmY/Ti+jz6cyR2p3GVc628v/UC9ipQAnbzvD4rzkcaD9cUH05E
 yrtWu4BCb/ul6QtZnVZlnbplndOi2t88cqZmfieCCt/lj+aXJybz9lPBgyobqotsWJU5
 Va2jKzFUADJB1Yj2FhQdGwkegD2AGeTVJanFZ5FnXlFuf3UDFhhMqK8BvZKIxwaLN3vK
 XezQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjGEmhB0R0JTHBGDRnWqS539REPBTAu+RFNuNfw4Pp0prSwdQtbiG6c0Zx4QvunsZDHS/vLW+FVAfV@nongnu.org
X-Gm-Message-State: AOJu0YyVRwwJvsuNx02E/nKXGWLkX84tU1KBpBM2IG6pNYWC4TRoYQJK
 CUmFPn2IXA5IrDLqm4kJe5eQxBOeN9zhD/khZjAkGi0e74MfidJlEE6BE72RO1MHyIsBG8l2VFE
 2LxTK5v/YGrsbw9v27X6OtmBw9l2DG/7D3t7rxQHr0w==
X-Gm-Gg: ATEYQzzFlJu3x8ELTzpRkaFCoH4P2yloTI88Hvx08Xv7LzGowz7zIn9UZqGv2EytoTj
 DMemRdqNhBiDk2/MheuqxjeT0M6FbtJhvH951b/zXRQHBV1+p+BJQQ3wHe6pheJw4pnDeJolIPT
 CVTHQQb/ITZ2pEzt1RXJKWQnkmoxKh18QSCFC+7CXHuRSsuENJoAZuTyWX1oo+uGmVvEvJIX9g7
 gogQgb/dBgiIvGEe/F56K1pk0Vti7NwF887LtmeLEbicrDh79EMnSXNyXqGNAa/ozdPNhlr+4L2
 rLHv0yrbJZBCVwOS0ScOGbxYH+7hYpP4aVOwJgvjya14ux4ws3VqeUvwfkrKRlKfGXo=
X-Received: by 2002:a05:690e:5:b0:64c:a4ab:e4da with SMTP id
 956f58d0204a3-64cc2083ab1mr11292565d50.6.1772550601838; Tue, 03 Mar 2026
 07:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20260303143928.1747116-1-eric.auger@redhat.com>
 <20260303143928.1747116-4-eric.auger@redhat.com>
In-Reply-To: <20260303143928.1747116-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 15:09:49 +0000
X-Gm-Features: AaiRm5031lcUy-1-nehwB4fqLMjxhdMftmN22SK1Wq5RCFCcyZFC87G8TjFHrcs
Message-ID: <CAFEAcA9uPdKJ_TSFUvN10Det8Copcg+gPoqi6yNZ+Cj=mk3xbg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] target/arm/kvm: Export kvm_print_register_name()
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 3 Mar 2026 at 14:39, Eric Auger <eric.auger@redhat.com> wrote:
>
> We want to use kvm_print_register_name() in machine.c so
> let's export the helper and implement a stub when kvm
> is not enabled.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v1 -> v2:
> - add doc comment
> - no code after g_assert_not_reached()
> - use char * instead of gchar
> ---
>  target/arm/kvm_arm.h  | 8 ++++++++
>  target/arm/kvm-stub.c | 5 +++++
>  target/arm/kvm.c      | 2 +-
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index cc0b374254e..ca2492c7412 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -266,4 +266,12 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level);
>
>  void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
>
> +/*
> + * kvm_print_register_name:
> + * @regidx: register KVM index
> + *
> + * Returns a human-readable string representing this register
> + */
> +char *kvm_print_register_name(uint64_t regidx);

We should also say "The caller must free the string with g_free()."

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

