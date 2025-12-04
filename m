Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56536D206AC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 14:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRADd-00045S-2h; Thu, 04 Dec 2025 09:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRADa-00043w-SN
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 09:22:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRADZ-0002DG-2W
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 09:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764858120;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SD5W4SkFB1q6NVAsWelACBEt4onCHvYn7wbJOAJI2Q=;
 b=YBJa3yluGQriyLAjzHQuPZgQibi9V3tAVahTYeX0SaPSsp7RhRZ46myh5JaO7JT9e3qTpW
 ryFe0F2MB8Jzvm079idM+JzWAsa0qvHoLQ+kAa/RCEid5KeqPMOiFrV6QwTkUJxE++Egqj
 ZsKa8KZImFe9iaifSSUj8TTElkCf5Jg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-kD5e900iMliwSnZNk0i7mA-1; Thu, 04 Dec 2025 09:21:51 -0500
X-MC-Unique: kD5e900iMliwSnZNk0i7mA-1
X-Mimecast-MFC-AGG-ID: kD5e900iMliwSnZNk0i7mA_1764858110
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-787d4af9896so13687407b3.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 06:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764858110; x=1765462910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SD5W4SkFB1q6NVAsWelACBEt4onCHvYn7wbJOAJI2Q=;
 b=ny6Wxo/YAibNjV2Tv7jaur8mp3IenfpRPrj159nb0wQcUad3uCmuFA7nIBWDi7YNsb
 zTzJt9M40NlsNseaEAwisfVq6Ym0T1o9mL2ktRe3vilBXMTFw6/NW7nL+nkGlT4IUBLg
 7tdBkuS+ItcWHjjx+MRJ/MdUHD2jqpmJCObFt7FkjQk98Nyc8t/15F3rtWwbpjS2+DyF
 xGuKBiikRvmHzVHX36O+6vR0FlrbUSJvVrUSYOOIKqL5DhkMB3G4bwYvFNsHBkzbBYBo
 X4qQ0r5oiGhwYAJlWnKnVbHHSjsc4vZbPtXQPKQeqIYEF0e/dtu9LfanK7yaeM4La5jF
 QZRQ==
X-Gm-Message-State: AOJu0YzhXp082nswvrpWutRugpkCRKRacc54ajUdI3NClT2Lq31GK/++
 xLoojwFMZZd7F2qYnluEw5Kmr89OmlKOMnG6ezJay8hlWGfqppBxcyjEXU4fFvbv5H331w6TzLy
 fo1SXuqVlX3E/HbVTtr4ypV4+KRMqv29LNmBn60N+L4Q0cBBDzunmK+0K
X-Gm-Gg: ASbGnctraUrPW/WTwCvCtBHwtIB4aTzZ6MtGmciA1Nie9UbshzsQ9etJgwUlRFWvyS5
 7FyTH0BRCcRR3DQdF2wQtmFLx5uDZSG1ucFLBCBu6gBV4MSK+K4xwV32NLExQuSoS0hOWpPGCeT
 FS56UDEdpLhzydnWwVLVYmVhV/yklpHayI29JxiUTuvFx3GsfSKjMkyObr5SHWVhQxTDgK93mbN
 PSdO39YjTcDXDIHv+ARQseW70SdPtbeUtIN3Lg57FPGqBkgKo7DjbF+dPK/UMUEMDm4iVsFDuj4
 g3+VEBM9KeL4H8AX5saIqvxR735qQzNsI/05OxVPEi4OkBJCwGfy8l1evb0sew6eOHJodQPaisW
 T268AJ7Hbc+Oef2BXz2ysXmsEh+WcuaY/eHWnSdb8y3v79fzEBc3RyvrDgA==
X-Received: by 2002:a05:690e:4010:b0:641:eeca:193a with SMTP id
 956f58d0204a3-64436f8c8f5mr4679688d50.3.1764858110247; 
 Thu, 04 Dec 2025 06:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTSNO6a89PgLBgZiM9M15aT6b/fUKMLUenYhfhJ4YSAT9/71RNh356zungi03JGJwBn1qlKQ==
X-Received: by 2002:a05:690e:4010:b0:641:eeca:193a with SMTP id
 956f58d0204a3-64436f8c8f5mr4679656d50.3.1764858109646; 
 Thu, 04 Dec 2025 06:21:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78c1b4adbefsm5886107b3.2.2025.12.04.06.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 06:21:49 -0800 (PST)
Message-ID: <83975c51-b49a-4300-af76-f2289c8bcdec@redhat.com>
Date: Thu, 4 Dec 2025 15:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 15/21] hw/arm/smmuv3: Determine register bank from MMIO
 offset
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151331.4130048-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012151331.4130048-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/12/25 5:13 PM, Tao Tang wrote:
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
> with the same function across different security states
> (Non-secure, Realm, Root) share the same relative offset. This avoids
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
> For future compatibility with Realm and Root states, the logic in the
> else block corresponding to the secure offset check:
>
> if (offset >= SMMU_SECURE_REG_START) {
>     reg_sec_sid = SMMU_SEC_SID_S;
> } else {
>     /* Future Realm/Root handling */
> }
>
> will need to be expanded. This will be necessary to differentiate
> between the Root Control Page and Realm Register Pages, especially since
> the Root Control Page is IMPLEMENTATION DEFINED.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 61 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 16 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index f161dd3eff..100caeeb35 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1675,12 +1675,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
>  
> -    switch (offset) {
> +    switch (reg_offset) {
>      case A_GERROR_IRQ_CFG0:
>          if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
>              /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
> @@ -1745,12 +1746,13 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>  }
>  
>  static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
> -                               uint64_t data, MemTxAttrs attrs)
> +                               uint64_t data, MemTxAttrs attrs,
> +                               SMMUSecSID reg_sec_sid)
>  {
> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
> +    uint32_t reg_offset = offset & 0xfff;
>  
> -    switch (offset) {
> +    switch (reg_offset) {
>      case A_CR0:
>          bank->cr[0] = data;
>          bank->cr0ack = data & ~SMMU_CR0_RESERVED;
> @@ -1985,12 +1987,33 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
>  
> +    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
> +    /*
> +     * The security state of the access (MemTxAttrs attrs) may differ from the
> +     * security state to which the register belongs. Future support will include
> +     * Realm and Root security states.
> +     *
> +     * The SMMU architecture specifies that Realm, Root, and Non-secure
> +     * registers share the same offset layout within the last 4 hexadecimal
> +     * digits (16 bits) of the address. Only Secure state registers are
> +     * mapped to a higher address space, starting from
> +     * SMMU_SECURE_REG_START (0x8000).
> +     *
> +     * Therefore, we can directly use the offset to distinguish Secure
> +     * registers. When Realm and Root support is needed in the future, we
> +     * only need to enhance the 'else' block of the corresponding 'if'
> +     * statement to handle those specific security states.
I wouldn't add that many references to the Realm and Root support in the
very code. Maybe move that in the commit desc.
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
> @@ -2002,12 +2025,13 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
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
>          if (!smmu_msi_supported(s, reg_sec_sid)) {
> @@ -2036,12 +2060,13 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
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
>          *data = smmuv3_idreg(offset - A_IDREGS);
>          return MEMTX_OK;
> @@ -2165,13 +2190,17 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>  
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
> +    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
declaration should be at the beginning of the function, ie before the
offset setting
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
Thanks

Eric


