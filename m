Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240D5C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfe68-0005bG-Vw; Fri, 03 Jul 2026 09:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfe67-0005ag-BT
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:38:27 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfe65-0002PE-Up
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:38:27 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664c1406f91so699602d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783085905; cv=none;
 d=google.com; s=arc-20260327;
 b=KOcpn34vRPvNaVERPVrjdvRzmTFyzrT247fzkVzozG16+zXmEjqP3qinuZjKTtTpES
 D16j9yj4MPdgeK21whe1uLhgFh6BzYVVvxrnKHEP0vesOOHTs3vJyywIaqGlSoTIaTmN
 +4LXA8GMdCgZmYp7eUOLpByP3tNCeLG04jkEuXHg//juHDA7LUtnk11DeqkN1bx1lOoC
 UURD/FesDJ6pdVJJFPyp3fdk9Tvs68VL/H408wuTspBaY6zq1CUhUX/RHfT+O/Bg3Cb+
 VIZfJp6pwAz8JMBlqNERmusebTYPzdgHg8qO6PcHa74GSY7lHFS5ua2xIyh6ppTqx3qu
 o65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YlCzQeiCTHWvHSq7Cx/s6bQ18JfhI2MRpZaHlMsqq1s=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=iuQSUmAswfLAyMkH2EdUhgYoi24nW5/vYRZwO4OqhWug9V4Zwggqi9YAOKhzPuU1Gn
 DPf7niCfQPPMu/F5Or6PbLArMW8JRYUqgxF8NTtjQsWq9G8Nq4vVAH3Dq0izpRhNcB6Z
 OEFEm81XY9DcztWlhPA3jm73zEWoZcHnaeM6BWkKU0ni0pbe6VSO4Y3jbRQqa8MKOXKH
 kStxBdyUqiFI/r7BJw527hRH9AWlCoHHMd0kimLTfa/EOklBFkKvfZlnDAzn6t9EajsA
 k0/XDg9+KD/UCscGJFXjFDLvCHHObQksItLyj1MVo5Ig3J/o0pDjT/f4Hbpm/hOt6fCR
 LPmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783085905; x=1783690705; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YlCzQeiCTHWvHSq7Cx/s6bQ18JfhI2MRpZaHlMsqq1s=;
 b=C2VR28BtqABcPqZYasFlsC6xtx4V//peMjyzc6Hxw37gKmOkBIFUz6OWjD4IS8qtKO
 Lct/8SAt0F/hgz7siAeGnetrNbu4ZwpncvlktdVlfZ2j1DOkjbVMOsLUFtmo09opIHmP
 eX+FONrPwQoGcakU09CoT58Ra/XUntM/BKoncFYxzb5eeVAWKXAdAh+Cf0iLfUq2WMXo
 NNIbWbjhWi4eUXFz9Z+vpYjYPGByMRCW/FdiHJxw/Zonk2Vq8offbQybtPA3kO5S3t08
 PuCi1kYwhsgPkBqcSELQXpXl+0dKMnJDGEIX0SbkRqPNT66usQahebyeTdmVByS3srSb
 Jw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783085905; x=1783690705;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YlCzQeiCTHWvHSq7Cx/s6bQ18JfhI2MRpZaHlMsqq1s=;
 b=Y72A9pA1PmFKeoXhNMNdCye0omtbAQJ6woiTbzRceB54K2YeRgoqV+/3J1OLAT36wq
 eC69/vqM065SY/SBLNqAFkUi6J57ym+ZmN9CQh6IaYOYdCVAjpo9hyyOcl+mjEp/uCBp
 GX0+uqxXoIqTskAq1oTRycsOmp7kxcN7mcMLfv9T5kOuL4eILDedK7jLIFqbZuXOT81L
 G0E+5ejyFwDwnubf9SVpXB4l825A94Lq+eyBRApfxX7IK6X6Shvlw1inyl3YIqpJUMVp
 2zzaXHj9+eA6PRgcCk+R/w135e1aPTtIRnAPVirvycOQbHAdusJznvkqbzF8/L+mUCH+
 lDdg==
X-Gm-Message-State: AOJu0YwOTjsuq8wRrBsuxWpj0ard2bGlmkgeS7K+sxQGBAoCQ1lSDViH
 vyvEPCSNwfpFa+lW3yWj5n6x8/TFxkFK+lAhhc/2Hx9Z/j12aAjH7PzmR/FPTzTRkDQP/WmlonT
 lBA9Pj2e2XNtoa86FxAA2rGCd1yhSB2ZBzUSm12S6NQ==
X-Gm-Gg: AfdE7ckFCq4amEdSOU1wljcUV9c6nB2XMEtLp79DFyoLHtb2/5lzFKJcQYuJw40nBTD
 1Da7+M24+bUKy4zausT9FCfLM4+L6HoqLs6uVuRoceRq7wTJKlGfGL3ZWdTaG6BmZngWnhO2+Yb
 UeEhJd7ECHnct9TTxI1bDvHk+aWIeGqzT19l+TA4o+wGjNUktVIPffEs0jF4bGqRyaXIxoAtXuA
 ro7/VFCeYpeC0/3X3Qe34nd0xpuaz8agtPnnJf0tWx6Zr8Pah8yxm8ZqjafFvDf9T3pgkZ/g7Nm
 +3Fx/6frf1LDXOvunz9EbJ65IzM4p77E/ATiosj68//Bfn1mjHpYynqY
X-Received: by 2002:a05:690e:1917:b0:662:ebb0:36fa with SMTP id
 956f58d0204a3-665219ec54emr9868207d50.20.1783085904491; Fri, 03 Jul 2026
 06:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-9-peter.maydell@linaro.org>
 <0f59d1a1-986d-4a0f-b865-699c4674589c@linaro.org>
In-Reply-To: <0f59d1a1-986d-4a0f-b865-699c4674589c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 14:38:12 +0100
X-Gm-Features: AVVi8CdhDcwmTxHsZ8a_rD_aUCiGWFTd2_PYx69beSAqBSRLs441GWW8EpehnN0
Message-ID: <CAFEAcA-o-mX8hzwOLBU+WhOP4uuvYDa+-H8fzHO6g0iM83g7Bg@mail.gmail.com>
Subject: Re: [PATCH 08/11] target/arm: Add new feature
 ARM_FEATURE_NO_NEON_TRAPS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 2 Jul 2026 at 22:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/2/26 11:40, Peter Maydell wrote:
> > +            } else if (!arm_feature(env, ARM_FEATURE_NO_NEON_TRAPS)) {
>
> Is the double negative really worth being able to limit the addition of the new feature to
> cortex-a8?

Yeah, I was kind of on the fence about it myself. It's not so
much the adding an extra ARM_FEATURE_NEON_TRAPS line to all our
existing CPU types as also needing to do it on every new one we
add in future -- having the default be the setting that's most
likely to be correct for a new CPU felt a little better. But I
suppose everybody cuts and pastes from an existing CPU type
when adding a new one, so there's not much in it, and we're
probably better keeping the feature as a simple "does this
CPU have this" positive-sense one.

-- PMM

