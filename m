Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3F7C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 13:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvJu-0004RN-Bq; Tue, 25 Feb 2025 08:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvJo-0004R0-T1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:49:53 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvJj-0003Nr-JN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:49:50 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6fcdf0980a6so27283017b3.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740491386; x=1741096186; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jNd7r7LIozbeBPZN2JJC/ZHmac4FW1Rw2VceOm+nyZY=;
 b=ZIQYBWbs2IZ/uPe55Gl4QP5ew5N8VH964XdRJEShqbuw9DOfTIZzvs+RYkofSZmJ+i
 tiKHUSsCcYHif+e8f/5q+unEMfdl3aGYu7VTQT38ZezUxSYXMEI++GSuEFC4VA4ps1cF
 KqJ9FhLRZvpj80DsebJfsiKQfNxRaPvy26Fj3vlnNTr3lmKN+Ik76ry85qEfimJrVdE5
 i9hruxVgZwYWHf1xrxNgnQ5e+JkqIhaPtrC2YwhHdiQAOrHAzIIS9Em1m/5g9gYgdwsV
 FWrLUw7DIMai54SzRD4p0esqX2DV4pUs2GBw9JC4YwQYL4fs1bV36lfw/AKUa/9nVKbd
 Ykjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740491386; x=1741096186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNd7r7LIozbeBPZN2JJC/ZHmac4FW1Rw2VceOm+nyZY=;
 b=SRI/oLpo1FcBZX8m0NlreRBO+g8HoIAUHVxQzWrScF2cmD0BPa/zI4hHHyk7xu60aI
 vrt/rVxVCYD/Bne98eRmZd3spcumdPGDOwm/6c3248rgWdDMIPMdZh7dFDqLK0ccV/CK
 11UkPjIjOzL771AitvDVYu72ktKC65AQ9CJEZ+v3YgwwK8Fy4EkMzN2sDu+nDkff8FAT
 mLdl8uvWcvLNn68S8NDtcjmFdRoaTXb84+hGY+ESFtxpRvdIFGC4i+EBmuGmOq+GFWTI
 F4nh0tFYS9lkYph5f43Bx5tdUdFFRkHXECqvbye/SAX9tMN71bhTU0/269wevITjV4lN
 d0XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxnnPdtbRWfKb+G8GSHC4nO9/l/+JnM3uhhwZEYuKKtUrVck+fqOehfW027QqNLBrWviVxSRWyq+aM@nongnu.org
X-Gm-Message-State: AOJu0YyLkpv+3EtavOnBEAxDlhbMejikwGNg5ECxtwmlMzKvx3f9XntC
 JVzoud9SqVt34yoqE8ZwHkeOWRlpKdAtQO+TGicLUTG95x11IFWLGgHbE6cWRgv0JBBh7h1KqCF
 AFfX77LT2SVmlL1tSKWlVcbgSlITbtNDOpa9SVA==
X-Gm-Gg: ASbGncsK8evKD4QWAQPVKgwCuJoJHr4U1cjECuGGJsXn/SqnpS6EkRbqNtVEAxZZ8ZY
 8ykmjxX3xysGaR0QON0adoaBv5c7gJEjptUWai3VwbGska4NupLAtjR8W6bNFrz6KQs/qn36ZeE
 obwmi8UqNl
X-Google-Smtp-Source: AGHT+IH7BVR4/b9eGOKn2qDDwMNZLkxvarMwNnQKmUjUjDAm4YyFVRw5m4LU/RszrCLySGpnehXrdZuS5IACjQoiykI=
X-Received: by 2002:a05:690c:6f8f:b0:6fb:949f:117 with SMTP id
 00721157ae682-6fbcc23a67cmr139014987b3.12.1740491386053; Tue, 25 Feb 2025
 05:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
 <20250219184609.1839281-7-wuhaotsh@google.com>
In-Reply-To: <20250219184609.1839281-7-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 13:49:34 +0000
X-Gm-Features: AWEUYZn4xpvywFMJ5yLFnI7bhWeRlqomFp54fvHSlV3BjBlArIhXCY8Qe0FK8j8
Message-ID: <CAFEAcA-KggoS6oUO9h0iGCy6ZDGTLecqBE_1ujsQ2cVcrEqUzQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/17] hw/misc: Add nr_regs and cold_reset_values to
 NPCM GCR
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com, 
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com, 
 titusr@google.com, chli30@nuvoton.corp-partner.google.com, 
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 19 Feb 2025 at 18:46, Hao Wu <wuhaotsh@google.com> wrote:
>
> These 2 values are different between NPCM7XX and NPCM8XX
> GCRs. So we add them to the class and assign different values
> to them.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>


> @@ -156,10 +157,12 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
>  static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
>  {
>      NPCMGCRState *s = NPCM_GCR(obj);
> +    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
>
> -    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> -
> -    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
> +    g_assert(sizeof(s->regs) >= sizeof(c->cold_reset_values));
> +    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
> +    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));

I looked again at this code after seeing the fix to the
similar code in npcm_clk that Pierrick just sent, and this
one looks broken in a different way:

c->cold_reset_values is a pointer, not an array, so
  g_assert(sizeof(s->regs) >= sizeof(c->cold_reset_values))
is asserting that the s->regs[] array is bigger than the size
of a pointer (8 bytes), which probably isn't what you meant.

Other than that, this is now the same as the fixed npcm_clk code,
except that we could do the same as that does and use a local
variable for sizeof_regs:

    size_t sizeof_regs = c->nr_regs * sizeof(uint32_t);
    g_assert(sizeof(s->regs) >= sizeof_regs);
    memcpy(s->regs, c->cold_reset_values, sizeof_regs);

But also, in this device (unlike npcm_clk) we have separate
reset method functions for npcm7xx and npcm8xx. So we don't
really need the s->cold_reset_values pointer at all, because
we could make npcm7xx_gcr_enter_reset() directly copy from
npcm7xx_cold_reset_values[] and similarly fro the npcm8xx function.

I think we should at least delete the assert() that isn't
doing what it looks like it's doing; I'll leave it to you
whether you want to also do one of the other two suggestions.

thanks
-- PMM

