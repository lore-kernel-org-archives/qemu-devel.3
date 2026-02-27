Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D6FFEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzJV-0003pP-7n; Fri, 27 Feb 2026 09:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvzJT-0003oe-4i
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:59:31 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvzJP-00037j-EP
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:59:30 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48318d08ec2so55665e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772204366; x=1772809166; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2U6BkZZmlo7MrZabwn9eG8crLb3somxEKkXgFy3eCjU=;
 b=ySvzfA7CSe1VU1TbCniW37MoasC+8IKZE0mmf9zbmkuWw68SgSjtcyLjQMi6asWTCo
 P/G3C5orF3X5gF8RzfFQBuJXoX/UPvFu1FptlZcnwDnAkfjPDqNZ8ZBIX3V4tfp7q70K
 zU/sGdEObfq1tGe2NblaqIMrlZ2V68RoN3jQfa2KqJ8A69n5h7MV9D4vzSp6GDSGdN5z
 18y6VS0KatmLD/FJf8PlqQ4LHFXIGacptOdPmLwqVgnFk9Tj6cVyZHVwyl86DyfUYzya
 YEzI1wFzJFurZffi8DSe/nTdsoz+wHtcW4EDWArGX8ozOKW/j/SjbU9kn3lHgoeoQ8sJ
 7fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772204366; x=1772809166;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2U6BkZZmlo7MrZabwn9eG8crLb3somxEKkXgFy3eCjU=;
 b=hs+r31+0T417/MKgDbnH9FMhbo7BguXP8FwtuSSP2VhckFPk2BomcmmDkSjek8mCcW
 PbXim5UKkzXqPuLpzSmxbLCtrcCoqxdZXl3vA11R0j0NK2BZzExPp41lg+wcPOWDpWT4
 CPK4lpxQVwUUdUL0Mr3E9rviWKsE8w2KTVtuW48GbfMJ52OTYjosLkBJVywpwwoKGix3
 JwobQ/N3cum6OxbsF4eYniP0+bn+of/3TDxucMzxj/eRplufQnVK/S39zB08/efaVTXA
 wTjXCBvpeCkQ8iMDsEjzD1/LpkPbWPRbIAUBZPh8MtUMl1/pQ3kHjSjtTzmUJJKynom4
 rJgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9myfBEk7nu+UxEwk3irQt1OHIRNUiFkmE6SQUz0aWNCFjqdKgn3cq1Aa76MviWzd2CzntsH7nIOJ2@nongnu.org
X-Gm-Message-State: AOJu0YzY7ujYR6UlaibqKiGKd8aoe2flMdnrXjH9RG9ZAz/VVCsx6WMH
 ytsX/bjL0EqhSFpAWyyaxPvEdiGGzWLCeUPi8yVntKbxxwYRhopnKDNu+Vb7MX6RJg==
X-Gm-Gg: ATEYQzzfD7dLseU1tZAxjZrdjxxOAS+/g8rGh571tCrwrOxyHSSEQqK9s0NT0rGnRJf
 DbbOVqL0GY27G6Ps/ZUvN9IwigBFqaIJFQZ2yOcwfVfLFFijA0eQzwGAMaS1Nf5peR5bZP7n7MI
 DEoLRNIEl/tUomIFY8rnjoHnfMFESdjcT8x++v8ODZ1UaVKksDq0nHMFL3KFkwJpvd3i4FPMo9M
 +zIY20d7jWln5PqQ3ijwwym5tKlIyAprN95LcfArIRSJ9Dlg8pT5YesqZzazrxd7kwyYp/RAsb1
 KTvkupVaF3XTCo2+NfjzEYaxHclkmUeEwRwIaCate+mM3cSqFrtZ1DY0Oqo1m+Tk6td2XPsSTNb
 qyC66iu+/t1YY3N+GHT9xXAXkyy470LSTveQugWTz+HFVxwHUkME3sc9O5opJBAtRO9DpqvH544
 YfqnEVReXP4QRbn2q9kWewZWCkgIn02OChEcq4QiYAzZ2/bSaUvvMhf79ItkAU3WrUmplFMiUc1
 N0=
X-Received: by 2002:a05:600c:154e:b0:47e:d9e7:1c12 with SMTP id
 5b1f17b1804b1-483c31a96c4mr2353065e9.6.1772204365303; 
 Fri, 27 Feb 2026 06:59:25 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm8064154f8f.23.2026.02.27.06.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:59:24 -0800 (PST)
Date: Fri, 27 Feb 2026 14:59:21 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC v4 24/31] hw/arm/smmuv3: Determine register bank from MMIO
 offset
Message-ID: <aaGxST56MQWlN8fJ@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101830.2996354-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221101830.2996354-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Sat, Feb 21, 2026 at 06:18:29PM +0800, Tao Tang wrote:
> Modify the main MMIO handlers (smmu_write_mmio, smmu_read_mmio)
> to determine the security state of the target register based on its
> memory-mapped offset.
> 
> By checking if the offset is within the secure register space (>=
> SMMU_SECURE_REG_START), the handlers can deduce the register's
> SEC_SID (reg_sec_sid). This SID is then passed down to the register
> access helper functions (smmu_writel, smmu_readl, etc.).
> 
> Inside these helpers, the switch statement now operates on a masked,
> relative offset:
> 
>     uint32_t reg_offset = offset & 0xfff;
>     switch (reg_offset) {
>         ...
>     }
> 
> This design leverages a key feature of the SMMU specification: registers
> with the same function across different 3 security states
> (Non-secure, Secure, Realm) share the same relative offset. This avoids
> significant code duplication. The reg_sec_sid passed from the MMIO
> handler determines which security bank to operate on, while the masked
> offset identifies the specific register within that bank.
> 
> It is important to distinguish between the security state of the
> register itself and the security state of the access. A
> higher-privilege security state is permitted to access registers
> belonging to a lower-privilege state, but the reverse is not allowed.
> This patch lays the groundwork for enforcing such rules.
> 
> For future compatibility with Realm states, the logic in the
> else block corresponding to the secure offset check:
> 
>     if (offset >= SMMU_SECURE_REG_START) {
>         reg_sec_sid = SMMU_SEC_SID_S;
>     } else {
>         /* Future Realm handling */
>     }
> 
> will need to be expanded.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 57 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9c09ea0716e..d81485a6a46 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1781,12 +1781,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  }
>  
>  static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
> -                               uint64_t data, MemTxAttrs attrs)
> +                                uint64_t data, MemTxAttrs attrs,
> +                                SMMUSecSID reg_sec_sid)
>  {
> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
> +    uint32_t reg_offset = offset & 0xfff;

This breaks all registers above 4k?
For example, TCU registers/PMU reside on some of this area and if SW
writes to those this might be aliased to something as CR0, which might
disable the SMMU and bypass some security checks. (in case it’s managed
by the hypervisor).

I believe you should check the secure offset explicitly to distinguish secure
and non-secure.

>  
> -    switch (offset) {
> +    switch (reg_offset) {
>      case A_GERROR_IRQ_CFG0:
>          if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
>              /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
> @@ -1851,13 +1852,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>  }
>  
>  static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
> -                               uint64_t data, MemTxAttrs attrs)
> +                               uint64_t data, MemTxAttrs attrs,
> +                               SMMUSecSID reg_sec_sid)
>  {
>      Error *local_err = NULL;
> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
> +    uint32_t reg_offset = offset & 0xfff;
>  
> -    switch (offset) {
> +    switch (reg_offset) {
>      case A_CR0:
>          bank->cr[0] = data;
>          bank->cr0ack = data & ~SMMU_CR0_RESERVED;
> @@ -2094,16 +2096,25 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>      SMMUState *sys = opaque;
>      SMMUv3State *s = ARM_SMMUV3(sys);
>      MemTxResult r;
> +    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>  
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
>  
> +    /*
> +     * Realm and Non-secure share the same page-local offset layout; Secure uses
> +     * the same layout but is mapped starting at 0x8000(SMMU_SECURE_REG_START)
> +     */
> +    if (offset >= SMMU_SECURE_REG_START) {
> +        reg_sec_sid = SMMU_SEC_SID_S;
> +    }
> +
>      switch (size) {
>      case 8:
> -        r = smmu_writell(s, offset, data, attrs);
> +        r = smmu_writell(s, offset, data, attrs, reg_sec_sid);
>          break;
>      case 4:
> -        r = smmu_writel(s, offset, data, attrs);
> +        r = smmu_writel(s, offset, data, attrs, reg_sec_sid);
>          break;
>      default:
>          r = MEMTX_ERROR;
> @@ -2115,12 +2126,13 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>  }
>  
>  static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
> -                               uint64_t *data, MemTxAttrs attrs)
> +                               uint64_t *data, MemTxAttrs attrs,
> +                               SMMUSecSID reg_sec_sid)
>  {
> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
> +    uint32_t reg_offset = offset & 0xfff;
>  
> -    switch (offset) {
> +    switch (reg_offset) {
>      case A_GERROR_IRQ_CFG0:
>          /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
>          if (!smmu_msi_supported(s)) {
> @@ -2149,17 +2161,22 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>  }
>  
>  static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
> -                              uint64_t *data, MemTxAttrs attrs)
> +                              uint64_t *data, MemTxAttrs attrs,
> +                              SMMUSecSID reg_sec_sid)
>  {
> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
> +    uint32_t reg_offset = offset & 0xfff;
>  
> -    switch (offset) {
> +    switch (reg_offset) {
>      case A_IDREGS ... A_IDREGS + 0x2f:
> -        *data = smmuv3_idreg(offset - A_IDREGS);
> +        *data = smmuv3_idreg(reg_offset - A_IDREGS);
>          return MEMTX_OK;
>      case A_IDR0 ... A_IDR5:
> -        *data = bank->idr[(offset - A_IDR0) / 4];
> +        if (reg_sec_sid == SMMU_SEC_SID_S) {
> +            g_assert((reg_offset - A_IDR0) / 4 < 5);

Asserting here is too much as this can be easily triggered by guests,
we should follow the convention of other unimplemented registers.

Thanks,
Mostafa

> +        }
> +
> +        *data = bank->idr[(reg_offset - A_IDR0) / 4];
>          return MEMTX_OK;
>      case A_IIDR:
>          *data = s->iidr;
> @@ -2275,16 +2292,20 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>      SMMUState *sys = opaque;
>      SMMUv3State *s = ARM_SMMUV3(sys);
>      MemTxResult r;
> +    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>  
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
> +    if (offset >= SMMU_SECURE_REG_START) {
> +        reg_sec_sid = SMMU_SEC_SID_S;
> +    }
>  
>      switch (size) {
>      case 8:
> -        r = smmu_readll(s, offset, data, attrs);
> +        r = smmu_readll(s, offset, data, attrs, reg_sec_sid);
>          break;
>      case 4:
> -        r = smmu_readl(s, offset, data, attrs);
> +        r = smmu_readl(s, offset, data, attrs, reg_sec_sid);
>          break;
>      default:
>          r = MEMTX_ERROR;
> -- 
> 2.34.1
> 
> 

