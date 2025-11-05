Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430EECCFA05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbVN-0000Lu-Dz; Wed, 05 Nov 2025 06:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGbVC-0000LI-1a
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGbV9-00021K-5H
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762341388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9x/Y83/Y4VGd12E8Vin7a9f+380gHh/E/JVOpnek/Kc=;
 b=KIKjrf+5OyTMgt02tNkaE00axm87asXJSzW/E9s/E3h9/v5sZMd6+b4MthE6R9V2ZtqSQs
 9CWl1b51ksuWJebEISQCuJk+5APD2rosoLTDD24bE28qOlCJKUtn4k/+DEFDf11mbjvGax
 IymGQwvF2PydNOYe4p2Luliawt+W2AI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-hgsMEWUaOO6jKaOx-dy0Qg-1; Wed, 05 Nov 2025 06:16:27 -0500
X-MC-Unique: hgsMEWUaOO6jKaOx-dy0Qg-1
X-Mimecast-MFC-AGG-ID: hgsMEWUaOO6jKaOx-dy0Qg_1762341386
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b7267543bc9so59427566b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762341386; x=1762946186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9x/Y83/Y4VGd12E8Vin7a9f+380gHh/E/JVOpnek/Kc=;
 b=qLy8d6K3km1pk9pr7KJQCdCjCZDSvYMI+hq3Z+5bgvY3T9Z7ILVWxYpxCu/NaTcTs5
 BgHWtUQe97S2QrqwE+gcoLfwHWnAD0kntohiJqDzJD4qCjq8UYRlF+uV0J+dCcnWW9qi
 2zTDaGa0Nve8YFIO+ol2+NRefX/DL7yt9jQU2OYvujVnr9g60EHs+Qf99Vj6SgfQm4ov
 NzVxUCj7s510KNt+teiGZjLDf3wR+rVI3RDVhXwID8doSTayzYX56+/EczBEa9TgYVoC
 Hwqd5FGGNQHgd7X8c4S4sLpO1+VT3jqD+viz6BzN+nw7YBwq7gQfs1JVOlUWxC8JBDQQ
 vyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762341386; x=1762946186;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9x/Y83/Y4VGd12E8Vin7a9f+380gHh/E/JVOpnek/Kc=;
 b=bWBHATsi5Et93Qwf7CKTwXxNaiCTgdds0lmcQiUSuWp7hPkO9CbMGYO94Uu2NCm9Lc
 lwsQyYh29SXqSUN8VyyBv8SKeWSAb+mVzZ50upR+TqyBUsjmejTUezvqCI1GtzboXJtZ
 xo9AXiRjKNguiFnpRykxedH8SDTls4FZbfw0zApmJTKvpLgrjCouMv1QSgns/xdqBvsj
 2H65tcyKsSDKPNm2XYssSLdx3H3hNDGg6fk/nLx3EtgH9XB76zI71exbpZ2/M5jPZhtf
 Zs5uIWbQMtRF6kCLouBePQpz3q/mmgDR6BnZmtSYfMLlo4SvuyfNjSFxfvV1P0rPd1DB
 iPAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWtjyGw3UrpwiE8OWEHEcFYXfEsJ/F+jD8ucTM3f8lvf5wF5G/JcuFpojmhaVpaxBoeLsTezqV5bQ8@nongnu.org
X-Gm-Message-State: AOJu0YxJAYBtz6bZyiUkVnGU84iEXCWwYAEcY/7k8GjJ0FPlS4XGOAoT
 zTGQw6wNd0y419fE8T52wuOiHu29SuAQMmCYOfleFRwhvRp/fHQY7MQg/7ac6yuP7YJZpmzwHQs
 oxmcElNSAoX50HtbP2F2+eJr0/1NqSy5wAW3We6AKUK3dw0K0izWBgjYN
X-Gm-Gg: ASbGncum2NH58xW9xa7acobGOMea0Yf+XXFtTabQ4e6ZLDW0rsi6ri1K+34tUMeNsUK
 fEpixnv79q0XQBklsgpItnUVkdfGMXLHcp3bKPBJQuu5tQxZBaBWaHD92ZeI/shvvmoBmOAFMyX
 3Tnx/q3GC0ur04LzqRpulCB4GiYJlMWiWvvQY4oj+FXbdOgcLH9zlSyh5hXetHxbXkIhmfdzQc9
 U8iMA9gANFGX59mHXmvSKY+rdjaGcsGz9EXP6guLSQKkygcGMpuOSCnDC8daMTLjP5H7eIhlY8s
 dpuNVDAjHev3JHenuBR3TQ35FZQMIkkQFpDIZ85b/s1pM6rlr3MoFbGbh86EnsCCOUsdEArCtK3
 sRFWp0ts6BVsixCDdyYyT34984eL18wJVbg0Sh7I=
X-Received: by 2002:a17:907:9494:b0:b6d:519f:2384 with SMTP id
 a640c23a62f3a-b726554c530mr291788466b.46.1762341386025; 
 Wed, 05 Nov 2025 03:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFJZow/anRANWEYGKNEdoff5p5GHJgaf1NFU6Y6wvhCtUDVcluCAan3l/0Jqn8+VSk0eI+ig==
X-Received: by 2002:a17:907:9494:b0:b6d:519f:2384 with SMTP id
 a640c23a62f3a-b726554c530mr291784266b.46.1762341385598; 
 Wed, 05 Nov 2025 03:16:25 -0800 (PST)
Received: from [192.168.42.203] (tmo-083-103.customers.d1-online.com.
 [80.187.83.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a3496sm473046366b.8.2025.11.05.03.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 03:16:25 -0800 (PST)
Message-ID: <ae368b2a-4acb-4cbe-a629-ad19e4ebf767@redhat.com>
Date: Wed, 5 Nov 2025 12:16:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/37] hw/misc: Add RISC-V CMGCR device implementation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alistair23@gmail.com, qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
 <20251023043520.1777130-5-alistair.francis@wdc.com>
 <a8e88aaa-02ef-406e-9737-bbe017e420d3@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a8e88aaa-02ef-406e-9737-bbe017e420d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 05/11/2025 11.15, Philippe Mathieu-Daudé wrote:
> On 23/10/25 06:35, alistair23@gmail.com wrote:
>> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
>>
>> Add RISC-V implementation of the Coherent Manager Global Control
>> Register (CMGCR) device. It is based on the existing MIPS CMGCR
>> implementation but adapted for RISC-V systems.
>>
>> The CMGCR device provides global system control for multi-core
>> configurations in RISC-V systems.
>>
>> This is needed for the MIPS BOSTON AIA board.
>>
>> Signed-off-by: Chao-ying Fu <cfu@mips.com>
>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Message-ID: <20251018154522.745788-9-djordje.todorovic@htecgroup.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   include/hw/misc/riscv_cmgcr.h |  50 +++++++
>>   hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
>>   hw/misc/Kconfig               |   9 ++
>>   hw/misc/meson.build           |   2 +
>>   4 files changed, 309 insertions(+)
>>   create mode 100644 include/hw/misc/riscv_cmgcr.h
>>   create mode 100644 hw/misc/riscv_cmgcr.c
> 
> 
>> +static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
>> +{
>> +    gcr->gcr_base = val & GCR_BASE_GCRBASE_MSK;
>> +    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
>> +
>> +    /*
>> +     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
>> +     * cpc automatically.
>> +     */
>> +    update_cpc_base(gcr, val + 0x8001);
>> +}
>> +
>> +/* Read GCR registers */
>> +static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    RISCVGCRState *gcr = (RISCVGCRState *) opaque;
>> +
>> +    switch (addr) {
>> +    /* Global Control Block Register */
>> +    case GCR_CONFIG_OFS:
>> +        /* Set PCORES to 0 */
>> +        return 0;
>> +    case GCR_BASE_OFS:
>> +        return gcr->gcr_base;
>> +    case GCR_REV_OFS:
>> +        return gcr->gcr_rev;
>> +    case GCR_CPC_STATUS_OFS:
>> +        return is_cpc_connected(gcr);
>> +    case GCR_L2_CONFIG_OFS:
>> +        /* L2 BYPASS */
>> +        return GCR_L2_CONFIG_BYPASS_MSK;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" 
>> HWADDR_PRIx
>> +                      "\n", size, addr);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
>> +{
>> +    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
>> +}
>> +
>> +/* Write GCR registers */
>> +static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned 
>> size)
>> +{
>> +    RISCVGCRState *gcr = (RISCVGCRState *)opaque;
>> +    RISCVGCRVPState *current_vps;
>> +    int cpu_index, c, h;
>> +
>> +    for (c = 0; c < gcr->num_core; c++) {
>> +        for (h = 0; h < gcr->num_hart; h++) {
>> +            if (addr == RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h * 
>> 8) {
>> +                cpu_index = c * gcr->num_hart + h;
>> +                current_vps = &gcr->vps[cpu_index];
>> +                current_vps->reset_base = data & GCR_CL_RESET_BASE_MSK;
>> +                cpu_set_exception_base(cpu_index + gcr->cluster_id *
>> +                                       gcr->num_core * gcr->num_hart,
>> +                                       get_exception_base(current_vps));
>> +                return;
>> +            }
>> +        }
>> +    }
>> +
>> +    switch (addr) {
>> +    case GCR_BASE_OFS:
>> +        update_gcr_base(gcr, data);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" 
>> HWADDR_PRIx
>> +                      " 0x%" PRIx64 "\n", size, addr, data);
>> +        break;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps gcr_ops = {
>> +    .read = gcr_read,
>> +    .write = gcr_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
> 
> Dubious DEVICE_NATIVE_ENDIAN use, do you mean DEVICE_LITTLE_ENDIAN?
> 
> Maybe we can alter checkpatch to no accept new DEVICE_NATIVE_ENDIAN
> in our code base.

Yes, please. Apart from some very rare cases, DEVICE_NATIVE_ENDIAN should 
never be used in new device code.

  Thomas


