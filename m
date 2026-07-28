Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF457C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohaF-0007Ks-N0; Tue, 28 Jul 2026 09:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohaB-0007JF-7t
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:10:55 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woha8-00020o-T7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:10:54 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66893db7bccso5116504d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244252; cv=none;
 d=google.com; s=arc-20260327;
 b=Nq01vTQBfNxgcLryh2dVJtYGwoqL6WDfi+mXVTjOmhVwXbkCt5v3J4Z1LxyjXoAo3t
 gmTU/6wPJwzzxZ68HoVdcFGdqSYKEn6iBH6zWHpYM388ADIMM1FMC1ehJc969emY5VdL
 srF6t6b35GlJFsjLsB44G5RjvfZY/B4v4tocvWmyELsne2dqnDiMtTINmPWvlQ9qJtSf
 zhTIDpaUJZCb4yBR9Z8+Wp6A+Uy/odTOycbG4DL52bVZYSUnqIRNJPcsNdvISUOz+twr
 ANC1rDRzaIZY1RE8LlXRGkJwtA4Gtb8ZsQDKLkr+UY/5q4jaf97N4Kd+TGpfNCTdZXfo
 Zjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5b5PkYlWFhkF9HA7hvxT8BueeiqPXo1SsxoJJJy4exw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=IoUOUYdcR3z/wrvHhhQm8rLnk+QUYhP93W4aa49h1jpuWnFmwMPjdEHa/4CBWeCJQY
 B0Fto76+T/HmJIw2rEJVP2oJWQcpmiC5rW1uGIP5FPRkYXjXi8LpBGyE03inS3NzxVyD
 fn3NAkmBXU5xil46/XVe6BJYGLC4bR4nK8cM8wzraH2wkUsSa+GqR14jwJQ15upQdiwN
 DfsZHfoU7i3wu3V9pWLtHN6v4m+5dMQ+GnHcuoQGG6bXYW5F14NWwXQCG3InSUodFM/N
 +G0xaXW8jaSBJ0K6V9AHWAOSmyLMigfEoUzMKyXCrfw84QRzQfJ+jo+biyQieH0GcQ9W
 2TYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785244252; x=1785849052; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5b5PkYlWFhkF9HA7hvxT8BueeiqPXo1SsxoJJJy4exw=;
 b=oi6U6Is6w7UZskMXOMsUltKgD72jws5FU6WLPbADa9wDF+kpfy0ZwnDt6D4nPTXMII
 HTznwH2JF7PvPpK2vJ+Njp2eIgGhOaL6VZuwxjJpovX8s+vAIJY7L15Ec/w2okeH0INW
 fgWpBwpSxXa774/3sS/15C8UUdtgh/Uii09ShkHQhW8YjiZWna4pw/yKubOTuJAI4nZQ
 vweUESt/j/Ii2raQ0OGl3xm2bEUaTzXZRy0Yd2HjAJa9zOKm4m0Ru8N1pidear3zVQME
 UYPD2jwZyI+fSdTkZU/L0BvR5ITAdcZHoTi2ZMO0aJ3Y79hkjuI0DI4rQin92xOIsl1M
 lJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244252; x=1785849052;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5b5PkYlWFhkF9HA7hvxT8BueeiqPXo1SsxoJJJy4exw=;
 b=l54iIkz4S3udRujMYdXUaHrGB/CQfgyFHhFPKQSo63+bxAGeZzNSnME+HRYG2qYeRI
 0Ty6kSgqEysnsTjwFU+2Eq0iwAcKzjUZergA2M/pWrLozwF+Vmwlb+ZnnthDMoMXiAye
 zrCC8UxQTGM9FugCkcGd3aL+tW2yB98Y1Nf25jEW8Tr0W2nWvh8ZQt3gKVgTc+UL5sXh
 hDRF9so+AHpUmSCm7TXk6yD6cQzQcwWtcrD3fSoKUvAYYPgtdevKeKbWgYDb0nFd0IvX
 +9KQpUxLebPNRDKJplGjGQHZVEPpo1ZeCHVMCfNYUlhVpP/GDnW9ZMHy/vNCXk8CObiz
 lC/w==
X-Gm-Message-State: AOJu0YxqmhaFajX/zDgXlP93Pc3rLqSKNb5kbKIv+gTkSQnRN6xAtrfe
 HZA1hGNXyqNacYCrV/83yIHVhJ/BSNsyLSb6XrRf0ZTUcMgwD4DHsssiy91rGd4soYGCeVdKzrL
 6frXRnlalu75A+o/8y5HX0Xfhs/PyjG6sHNCYtiDoIA==
X-Gm-Gg: AR+sD12uM2+kG0p5tOHe+aEnMoZP3cFX8Ny2n60xufLmyIGiimSoL4AQJiOpWAcqxLX
 daudij/P67/Ybo9gbeI9mXZc4IH3+DsiECrEE/LEwkW/IJBV9+d7OL9RoJuMtdS/krpkjct8fdE
 nkmlje4HqHilx66y6KDNKpEAPNp78aDyYUftTYFk9URVw0jyyCalRmvwV2oZ50ap/Q1xB3pBXZi
 e3H9nmu8wquFIyN4b3zY4plJqjsh90L1Jv6q5NSlJfYMPDOabTPAwcIgJ6/cF+NvSdmQvbcHEQ6
 lS2vWwW+9zKfyHZWltYXCv5ZLA5OHYody7h1NxQyvwr4RA==
X-Received: by 2002:a05:690e:4005:b0:667:91ba:9bdc with SMTP id
 956f58d0204a3-6690545d1b7mr999478d50.11.1785244251630; Tue, 28 Jul 2026
 06:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-2-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:10:39 +0100
X-Gm-Features: AUfX_mzel0WsdEsnhTkAXYMtatvaxAyUyyQDinPC2WGG1PLaOtDkiPlvcxiDxKM
Message-ID: <CAFEAcA9DCByPPCL6fSnuMYmpBALNJaktyEB8ywAU2BU39GnaNA@mail.gmail.com>
Subject: Re: [PATCH 01/10] target/arm: Implement FTMOPA (non-widening, FP32)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 14 Jul 2026 at 00:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


> +static void sme_tmop(void *vza, void *vzn, void *vzm, uint64_t *zk,
> +                     void *fn_opaque, uint32_t desc, MemOp esz,
> +                     void (*fn)(void *, void *, void *, void *))
> +{
> +    intptr_t oprsz = simd_maxsz(desc);
> +    intptr_t index = simd_data(desc);
> +    intptr_t esize = 1 << esz;
> +    intptr_t host_adj = HOST_BIG_ENDIAN ? 8 - esize : 0;
> +    /* Base in bits for op3[index*:csize], csize = (VL * 2) / esize. */
> +    intptr_t ctrl_base = index * oprsz * 2;
> +    /* Create a zero for use with the largest esz. */
> +    uint32_t zero = 0;
> +
> +    for (intptr_t row = 0; row < oprsz; row += esize) {
> +        void *vza_row = vza + tile_vslice_offset(row);
> +
> +        for (intptr_t col = 0; col < oprsz; col += esize) {
> +            void *e2 = vzm + (col ^ host_adj);
> +            void *e3 = vza_row + (col ^ host_adj);

Having just read patch 4, is it possible to do this with the H
macros rather than a manual host_adj, as we do in
sme_tmop_2way_sh() there ?

-- PMM

