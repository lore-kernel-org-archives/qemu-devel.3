Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F3BCCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Fpl-0003z8-Ec; Mon, 29 Sep 2025 11:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3FpY-0003wC-A1
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3FpQ-0001xf-I7
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759159812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UB7JHQLLdi7g2pfKQNYDfNibZIRZaJg5g/DLFvF6qsY=;
 b=iwLazRTKIfIpAca9WoBKJPRGStRtzJYOoJn2q9xw4ZXB/WDaWqoE4cEFJN7eUeA/NW+tP9
 /QmFFebHO2RdedoEXbMw3JZfwKtd/dzl4cwKLHtLNXy43oe/Jn15+c7BqYiARl1RH4paVQ
 JGZAyoDsEPwW+tKtWkZ3MkpUagdhxU8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-coEaJJ8xMxeKJzi2x2PyvQ-1; Mon, 29 Sep 2025 11:30:11 -0400
X-MC-Unique: coEaJJ8xMxeKJzi2x2PyvQ-1
X-Mimecast-MFC-AGG-ID: coEaJJ8xMxeKJzi2x2PyvQ_1759159810
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee130237e1so2135197f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759159810; x=1759764610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UB7JHQLLdi7g2pfKQNYDfNibZIRZaJg5g/DLFvF6qsY=;
 b=T6UhmveS6ukOlvczh/hpKNfUNWue9Ly8gvMzvT23StzIOfCerMChKi9vJl87xSdG/M
 ZmhslAzf6mvCH3IS91dp7ddlsLsRO3rodjVoN0QFi+73JZQEfS4m3tQLBoRIAeVcTc7s
 55oqHahjc5DFoHgjq1h3ptMGpQ9HZCiUBuqAYCueGFkKOWPZ85L18mcWD+p8o3KTs54l
 j9+vPablkstA4lGlFV+N1+Fv1Avgtsj6cwtfAoxtwlRQq/jcC3FZ0zkfW0OcoAoQAPuL
 JkiQzr+ELXlvBhSDVbXr2A5b7UIyqyUwEaASVpBtwlt8RUBnqQOQTEaugxlHLrBbjbjc
 SPZg==
X-Gm-Message-State: AOJu0YxxrPKUAD5AooTHUmYiv39kPb2MII9Te+q5AQinKVWDK2KeTJvZ
 1j/kwF30PDsLmelFCaUVu3kFVmxyLc2ObBkFx+LvRlEMxN2orNMy/W7a272yzxw1KguU1NYCvDK
 L3v0nzo/ZekJQ0TUZuhoVqNrpJkMDwt/oX51mYWcmPf9VJsZ6QZFLWQhT
X-Gm-Gg: ASbGncsCFQsJltEAnuezM0eyfeF3G+MZUhpBbCdjqomYfpx52mHn+2QXY7k5U/qrdJT
 X7IUxqwQp5nMUoICSMqWNEaTzKo54gi8GdJUDSEM5mKHIRtWcGUV6DiE53We1XYET5Uo3xfKmga
 BGSFUlrWa7aYHncICrcJED8lcq9slG+jG3ZHIrIefGe5ikWIgaZNSc7qfy2NDFm4kX3KH0RbDD4
 dF6Vrh5lmbTJIR80L9d3Wg8XtGhhrRplQdzJqKZXp7kb6sZLX6UjmYE/GB9yG0HYFxkxd6oNFFJ
 4n6FSviSnSYCRbznPNCCyDUXQXaGR8+BDlmQkISNFsiYuEB08eWyGuussfmKKcBjMKrmmNAlM8A
 zE752O5jb8RY=
X-Received: by 2002:a5d:64c9:0:b0:3e7:4fda:fe0c with SMTP id
 ffacd0b85a97d-40e436423ffmr17371091f8f.15.1759159809787; 
 Mon, 29 Sep 2025 08:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP2TAXCqlUxsO67974YXOyqxH04DE5y4Q+Sez1wZtb8/7Y+Kc1kProKh+kAjWIKaMf48dsCA==
X-Received: by 2002:a5d:64c9:0:b0:3e7:4fda:fe0c with SMTP id
 ffacd0b85a97d-40e436423ffmr17371056f8f.15.1759159809377; 
 Mon, 29 Sep 2025 08:30:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602efdsm19465189f8f.34.2025.09.29.08.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:30:08 -0700 (PDT)
Message-ID: <81c98959-45dc-4cbc-836f-a34fdf160801@redhat.com>
Date: Mon, 29 Sep 2025 17:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] hw/arm/smmuv3: Harden security checks in MMIO
 handlers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-12-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250925162618.191242-12-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Tao,

On 9/25/25 6:26 PM, Tao Tang wrote:
> This patch hardens the security validation within the main MMIO
> dispatcher functions (smmu_read_mmio and smmu_write_mmio).
>
> First, accesses to the secure register space are now correctly gated by
> whether the SECURE_IMPL feature is enabled in the model. This prevents
> guest software from accessing the secure programming interface when it is
> disabled, though some registers are exempt from this check as per the
> architecture.
>
> Second, the check for the input stream's security is made more robust.
> It now validates not only the legacy MemTxAttrs.secure bit, but also
> the .space field. This brings the SMMU's handling of security spaces
> into full alignment with the PE.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 53c7eff0e3..eec36d5fd2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1484,6 +1484,12 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s,
>      return smmu_irq_ctl_evtq_irqen_disabled(s, sec_idx);
>  }
>  
> +/* Check if the SMMU hardware itself implements secure state features */
> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->bank[SMMU_SEC_IDX_S].idr[1], S_IDR1, SECURE_IMPL);
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1723,6 +1729,43 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>      return 0;
>  }
>  
> +static bool is_secure_impl_exempt_reg(hwaddr offset)
Worth a comment: some secure registers can be accessed even if secure HW
is not implemented. Returns true if this is the case or something alike.
> +{
> +    switch (offset) {
> +    case A_S_EVENTQ_IRQ_CFG0:
> +    case A_S_EVENTQ_IRQ_CFG1:
> +    case A_S_EVENTQ_IRQ_CFG2:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +/* Helper function for Secure register access validation */
> +static bool smmu_check_secure_access(SMMUv3State *s, MemTxAttrs attrs,
> +                                     hwaddr offset, bool is_read)
> +{   /* Check if the access is secure */
> +    if (!(attrs.space == ARMSS_Secure || attrs.space == ARMSS_Root ||
First occurence of ARMSS_Root in hw dir? Is it needed?
> +          attrs.secure == 1)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Non-secure %s attempt at offset 0x%" PRIx64 " (%s)\n",
> +            __func__, is_read ? "read" : "write", offset,
> +            is_read ? "RAZ" : "WI");
> +        return false;
> +    }
> +
> +    /* Check if the secure state is implemented. Some registers are exempted */
> +    /* from this check. */
> +    if (!is_secure_impl_exempt_reg(offset) && !smmu_hw_secure_implemented(s)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Secure %s attempt at offset 0x%" PRIx64 ". But Secure state "
> +            "is not implemented (RES0)\n",
> +            __func__, is_read ? "read" : "write", offset);
> +        return false;
> +    }
> +    return true;
> +}
> +
>  static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>                                 uint64_t data, MemTxAttrs attrs,
>                                 SMMUSecurityIndex reg_sec_idx)
> @@ -2038,6 +2081,13 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
>      SMMUSecurityIndex reg_sec_idx = SMMU_SEC_IDX_NS;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        if (!smmu_check_secure_access(s, attrs, offset, false)) {
> +            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
> +            return MEMTX_OK;
> +        }
> +        reg_sec_idx = SMMU_SEC_IDX_S;
> +    }
>  
>      switch (size) {
>      case 8:
> @@ -2252,6 +2302,14 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>      /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>      offset &= ~0x10000;
>      SMMUSecurityIndex reg_sec_idx = SMMU_SEC_IDX_NS;
> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
> +        if (!smmu_check_secure_access(s, attrs, offset, true)) {
> +            *data = 0;
> +            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
> +            return MEMTX_OK;
> +        }
> +        reg_sec_idx = SMMU_SEC_IDX_S;
> +    }
>  
>      switch (size) {
>      case 8:
Thanks

Eric


