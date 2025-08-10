Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED39C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 16:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul9K8-0002C3-6E; Sun, 10 Aug 2025 12:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ul9K1-00026Y-UN; Sun, 10 Aug 2025 12:55:02 -0400
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net ([159.89.151.119])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ul9Jx-0006Ml-9p; Sun, 10 Aug 2025 12:55:01 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXijLXzphoH7osBg--.973S2;
 Mon, 11 Aug 2025 00:54:47 +0800 (CST)
Received: from [192.168.31.34] (unknown [113.246.234.235])
 by mail (Coremail) with SMTP id AQAAfwB3AAjEzphoSGMPAA--.18862S2;
 Mon, 11 Aug 2025 00:54:47 +0800 (CST)
Message-ID: <a5154459-a632-42b0-b599-d5dff85b5dd2@phytium.com.cn>
Date: Mon, 11 Aug 2025 00:54:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 02/11] hw/arm/smmuv3: Implement read/write logic for secure
 registers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-3-tangtao1634@phytium.com.cn>
 <4c84da2c-eefd-45b3-88ed-cc5070e5c421@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <4c84da2c-eefd-45b3-88ed-cc5070e5c421@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3AAjEzphoSGMPAA--.18862S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQASBWiXooAA6wAEsk
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZw17Kw4UKF43AFWDCFy8Xwb_yoW8tw1Dto
 WUKr1rXr13Jr17uryUJr1UJr13JF1UJrnrtr1UKry7Jr1xJF1UJ3yUJryUt3yUtr18Gr1D
 Jr1UJFy0yFyUAr15n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=159.89.151.119;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtu5ljg5lje1ms4xmtka.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/8/7 05:53, Pierrick Bouvier wrote:
> On 8/6/25 8:11 AM, Tao Tang wrote:
>> This patch builds upon the previous introduction of secure register
>> definitions by providing the functional implementation for their access.
>>
>> The availability of the secure programming interface is now correctly
>> gated by the S_IDR1.SECURE_IMPL bit. When this bit indicates that
>> secure functionality is enabled, the I/O handlers (smmuv3_read and
>> smmuv3_write) will correctly dispatch accesses to the secure
>> register space.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3-internal.h |   5 +
>>   hw/arm/smmuv3.c          | 451 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 456 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index 483aaa915e..1a8b1cb204 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -122,6 +122,11 @@ REG32(CR0,                 0x20)
>>     #define SMMU_CR0_RESERVED 0xFFFFFC20
>>   +/*
>> + * BIT1 and BIT4 are RES0 in SMMU_S_CRO
>> + */
>> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>> +
>>   REG32(CR0ACK,              0x24)
>>   REG32(CR1,                 0x28)
>>   REG32(CR2,                 0x2c)
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index ab67972353..619180d204 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -317,6 +317,18 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>       s->gerrorn = 0;
>>       s->statusr = 0;
>>       s->gbpa = SMMU_GBPA_RESET_VAL;
>> +
>> +    /* Initialize secure state */
>> +    memset(s->secure_idr, 0, sizeof(s->secure_idr));
>> +    /* Secure EL2 and Secure stage 2 support */
>> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1);
>> +    /* Secure state implemented */
>> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
>> +        SECURE_IMPL, 1);
>> +    s->secure_idr[1] = FIELD_DP32(s->secure_idr[1], S_IDR1,
>> +        S_SIDSIZE, SMMU_IDR1_SIDSIZE);
>> +
>> +    s->secure_gbpa = SMMU_GBPA_RESET_VAL;
>>   }
>>
>
> Should we wait for the end of the series to enable this support, as 
> not everything is implemented yet?
>

Hi Pierrick,

Thansk for your suggestion! I will move all of this code into the final 
patch. Then I will check if there are other codes with similar 
situations that also need to be moved into the final patch.


>>   static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>> @@ -1278,6 +1290,12 @@ static void smmuv3_range_inval(SMMUState *s, 
>> Cmd *cmd, SMMUStage stage)
>>       }
>>   }
>>   +/* Check if the SMMU hardware itself implements secure state 
>> features */
>> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
>> +{
>> +    return FIELD_EX32(s->secure_idr[1], S_IDR1, SECURE_IMPL);
>> +}
>> +
>>   static int smmuv3_cmdq_consume(SMMUv3State *s)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>> @@ -1508,9 +1526,91 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>       return 0;
>>   }
>>   +/* Helper function for secure register write validation */
>> +static bool smmu_validate_secure_write(MemTxAttrs attrs, bool 
>> secure_impl,
>> +                                       hwaddr offset, const char 
>> *reg_name)
>> +{
>> +    if (!attrs.secure || !secure_impl) {
>> +        const char *reason = !attrs.secure ?
>> +            "Non-secure write attempt" :
>> +            "SMMU didn't implement Security State";
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: %s at offset 0x%" PRIx64 " (%s, WI)\n",
>> +                      __func__, reason, offset, reg_name);
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +/* Helper function for secure register read validation */
>> +static bool smmu_validate_secure_read(MemTxAttrs attrs, bool 
>> secure_impl,
>> +                                      hwaddr offset, const char 
>> *reg_name,
>> +                                      uint64_t *data)
>> +{
>> +    if (!attrs.secure || !secure_impl) {
>> +        const char *reason = !attrs.secure ?
>> +            "Non-secure read attempt" :
>> +            "SMMU didn't implement Security State";
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: %s at offset 0x%" PRIx64 " (%s, RAZ)\n",
>> +                      __func__, reason, offset, reg_name);
>> +        *data = 0; /* RAZ */
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +/* Macro for secure write validation - returns early if validation 
>> fails */
>> +#define SMMU_CHECK_SECURE_WRITE(reg_name) \
>> +    do { \
>> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset, \
>> +                                        reg_name)) { \
>> +            return MEMTX_OK; \
>> +        } \
>> +    } while (0)
>> +
>> +/* Macro for attrs.secure only validation */
>> +#define SMMU_CHECK_ATTRS_SECURE(reg_name) \
>> +    do { \
>> +        if (!attrs.secure) { \
>> +            qemu_log_mask(LOG_GUEST_ERROR, \
>> +                          "%s: Non-secure write attempt at offset " \
>> +                          "0x%" PRIx64 " (%s, WI)\n", \
>> +                          __func__, offset, reg_name); \
>> +            return MEMTX_OK; \
>> +        } \
>> +    } while (0)
>> +
>> +/* Macro for secure read validation - returns RAZ if validation 
>> fails */
>> +#define SMMU_CHECK_SECURE_READ(reg_name) \
>> +    do { \
>> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset, \
>> +                                       reg_name, data)) { \
>> +            return MEMTX_OK; \
>> +        } \
>> +    } while (0)
>> +
>
> For this, and previous macros, shouldn't we return MEMTX_ERROR instead?
>

According to ARM IHI 0070 G.b page 87/:
/

/When SMMU_S_IDR1.SECURE_IMPL == 0, /

/    - The SMMU does not support the Secure state/

/    - SMMU_S_* registers are RAZ/WI to all accesses./

RAZ/WI is indeed a deterministic hardware behavior, and I think it is 
architecturally distinct from conditions like a Terminate or a Fault. 
While the software might not get a "real" value from a register (it gets 
zeros) or its write might have no effect, the hardware access itself 
completes without any protocol-level error.

This is my current understanding, but I'm keen to hear if anyone has a 
different perspective or sees it differently.


>> +/* Macro for attrs.secure only validation (read) */
>> +#define SMMU_CHECK_ATTRS_SECURE_READ(reg_name) \
>> +    do { \
>> +        if (!attrs.secure) { \
>> +            qemu_log_mask(LOG_GUEST_ERROR, \
>> +                          "%s: Non-secure read attempt at offset " \
>> +                          "0x%" PRIx64 " (%s, RAZ)\n", \
>> +                          __func__, offset, reg_name); \
>> +            *data = 0; \
>> +            return MEMTX_OK; \
>> +        } \
>> +    } while (0)
>> +
>
> A simple style detail, but it's more readable to keep all backslashes 
> on same column (after the longest line).
>
> #define SMMU_CHECK_SECURE_READ(reg_name)                       \
> do {                                                           \
>     if (!smmu_validate_secure_read(attrs, secure_impl, offset, \
>                                    reg_name, data)) {          \
>         return MEMTX_OK;                                       \
>     } \
> } while (0)
>

That's a good point, it's much more readable that way. Thanks for the 
suggestion, I'll check all the code and fix it in the next version.


>>   static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>>                                  uint64_t data, MemTxAttrs attrs)
>>   {
>> +    bool secure_impl = false;
>> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
>> +        secure_impl = smmu_hw_secure_implemented(s);
>> +    }
>> +
>>       switch (offset) {
>>       case A_GERROR_IRQ_CFG0:
>>           s->gerror_irq_cfg0 = data;
>> @@ -1535,6 +1635,41 @@ static MemTxResult smmu_writell(SMMUv3State 
>> *s, hwaddr offset,
>>       case A_EVENTQ_IRQ_CFG0:
>>           s->eventq_irq_cfg0 = data;
>>           return MEMTX_OK;
>> +    case A_S_GERROR_IRQ_CFG0:
>> +        /* No need to check secure_impl here */
>> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG0");
>> +        s->secure_gerror_irq_cfg0 = data;
>> +        return MEMTX_OK;
>> +    case A_S_STRTAB_BASE:
>> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
>> +                                        "S_STRTAB_BASE")) {
>> +            return MEMTX_OK;
>> +        }
>> +        s->secure_strtab_base = data;
>> +        return MEMTX_OK;
>> +    case A_S_CMDQ_BASE:
>> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_BASE");
>> +        s->secure_cmdq.base = data;
>> +        s->secure_cmdq.log2size = extract64(s->secure_cmdq.base, 0, 5);
>> +        if (s->secure_cmdq.log2size > SMMU_CMDQS) {
>> +            s->secure_cmdq.log2size = SMMU_CMDQS;
>> +        }
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_BASE:
>> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_BASE");
>> +        s->secure_eventq.base = data;
>> +        s->secure_eventq.log2size = extract64(s->secure_eventq.base, 
>> 0, 5);
>> +        if (s->secure_eventq.log2size > SMMU_EVENTQS) {
>> +            s->secure_eventq.log2size = SMMU_EVENTQS;
>> +        }
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_IRQ_CFG0:
>> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
>> +                                        "S_EVENTQ_IRQ_CFG0")) {
>> +            return MEMTX_OK;
>> +        }
>> +        s->secure_eventq_irq_cfg0 = data;
>> +        return MEMTX_OK;
>>       default:
>>           qemu_log_mask(LOG_UNIMP,
>>                         "%s Unexpected 64-bit access to 0x%"PRIx64" 
>> (WI)\n",
>> @@ -1546,6 +1681,11 @@ static MemTxResult smmu_writell(SMMUv3State 
>> *s, hwaddr offset,
>>   static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>>                                  uint64_t data, MemTxAttrs attrs)
>>   {
>> +    bool secure_impl = false;
>> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
>> +        secure_impl = smmu_hw_secure_implemented(s);
>> +    }
>> +
>>       switch (offset) {
>>       case A_CR0:
>>           s->cr[0] = data;
>> @@ -1650,6 +1790,137 @@ static MemTxResult smmu_writel(SMMUv3State 
>> *s, hwaddr offset,
>>       case A_EVENTQ_IRQ_CFG2:
>>           s->eventq_irq_cfg2 = data;
>>           return MEMTX_OK;
>> +    case A_S_CR0:
>> +        SMMU_CHECK_SECURE_WRITE("S_CR0");
>> +        s->secure_cr[0] = data;
>> +        /* clear reserved bits */
>> +        s->secure_cr0ack = data & ~SMMU_S_CR0_RESERVED;
>> +        smmuv3_cmdq_consume(s);
>> +        return MEMTX_OK;
>> +    case A_S_CR1:
>> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
>> +                                        "S_CR1")) {
>> +            return MEMTX_OK;
>> +        }
>> +        s->secure_cr[1] = data;
>> +        return MEMTX_OK;
>> +    case A_S_CR2:
>> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
>> +                                        "S_CR2")) {
>> +            return MEMTX_OK;
>> +        }
>> +        s->secure_cr[2] = data;
>> +        return MEMTX_OK;
>> +    case A_S_IRQ_CTRL:
>> +        if (!smmu_validate_secure_write(attrs, secure_impl, offset,
>> +                                        "S_IRQ_CTRL")) {
>> +            return MEMTX_OK;
>> +        }
>> +        s->secure_irq_ctrl = data;
>> +        return MEMTX_OK;
>> +    case A_S_GERRORN:
>> +        SMMU_CHECK_SECURE_WRITE("S_GERRORN");
>> +        smmuv3_write_gerrorn(s, data);
>> +        smmuv3_cmdq_consume(s);
>> +        return MEMTX_OK;
>> +    case A_S_GERROR_IRQ_CFG0:
>> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG0");
>> +        s->secure_gerror_irq_cfg0 = data;
>> +        return MEMTX_OK;
>> +    case A_S_GERROR_IRQ_CFG0 + 4:
>> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG0");
>> +        s->secure_gerror_irq_cfg0 = 
>> deposit64(s->secure_gerror_irq_cfg0,
>> +                                              32, 32, data);
>> +        return MEMTX_OK;
>> +    case A_S_GERROR_IRQ_CFG1:
>> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG1");
>> +        s->secure_gerror_irq_cfg1 = data;
>> +        return MEMTX_OK;
>> +    case A_S_GERROR_IRQ_CFG2:
>> +        SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG2");
>> +        s->secure_gerror_irq_cfg2 = data;
>> +        return MEMTX_OK;
>> +    case A_S_GBPA:
>> +        SMMU_CHECK_SECURE_WRITE("S_GBPA");
>> +        if (data & R_S_GBPA_UPDATE_MASK) {
>> +            s->secure_gbpa = data & ~R_S_GBPA_UPDATE_MASK;
>> +        }
>> +        return MEMTX_OK;
>> +    case A_S_STRTAB_BASE:
>> +        SMMU_CHECK_SECURE_WRITE("S_STRTAB_BASE");
>> +        s->secure_strtab_base = deposit64(s->secure_strtab_base, 0, 
>> 32, data);
>> +        return MEMTX_OK;
>> +    case A_S_STRTAB_BASE + 4:
>> +        SMMU_CHECK_SECURE_WRITE("S_STRTAB_BASE");
>> +        s->secure_strtab_base = deposit64(s->secure_strtab_base, 32, 
>> 32, data);
>> +        return MEMTX_OK;
>> +    case A_S_STRTAB_BASE_CFG:
>> +        SMMU_CHECK_SECURE_WRITE("S_STRTAB_BASE_CFG");
>> +        s->secure_strtab_base_cfg = data;
>> +        if (FIELD_EX32(data, S_STRTAB_BASE_CFG, FMT) == 1) {
>> +            s->secure_sid_split = FIELD_EX32(data, 
>> S_STRTAB_BASE_CFG, SPLIT);
>> +            s->secure_features |= SMMU_FEATURE_2LVL_STE;
>> +        }
>> +        return MEMTX_OK;
>> +    case A_S_CMDQ_BASE:
>> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_BASE");
>> +        s->secure_cmdq.base = deposit64(s->secure_cmdq.base, 0, 32, 
>> data);
>> +        s->secure_cmdq.log2size = extract64(s->secure_cmdq.base, 0, 5);
>> +        if (s->secure_cmdq.log2size > SMMU_CMDQS) {
>> +            s->secure_cmdq.log2size = SMMU_CMDQS;
>> +        }
>> +        return MEMTX_OK;
>> +    case A_S_CMDQ_BASE + 4:
>> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_BASE");
>> +        s->secure_cmdq.base = deposit64(s->secure_cmdq.base, 32, 32, 
>> data);
>> +        return MEMTX_OK;
>> +    case A_S_CMDQ_PROD:
>> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_PROD");
>> +        s->secure_cmdq.prod = data;
>> +        smmuv3_cmdq_consume(s);
>> +        return MEMTX_OK;
>> +    case A_S_CMDQ_CONS:
>> +        SMMU_CHECK_SECURE_WRITE("S_CMDQ_CONS");
>> +        s->secure_cmdq.cons = data;
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_BASE:
>> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_BASE");
>> +        s->secure_eventq.base = deposit64(s->secure_eventq.base, 0, 
>> 32, data);
>> +        s->secure_eventq.log2size = extract64(s->secure_eventq.base, 
>> 0, 5);
>> +        if (s->secure_eventq.log2size > SMMU_EVENTQS) {
>> +            s->secure_eventq.log2size = SMMU_EVENTQS;
>> +        }
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_BASE + 4:
>> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_BASE");
>> +        s->secure_eventq.base = deposit64(s->secure_eventq.base, 32, 
>> 32, data);
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_PROD:
>> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_PROD");
>> +        s->secure_eventq.prod = data;
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_CONS:
>> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_CONS");
>> +        s->secure_eventq.cons = data;
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_IRQ_CFG0:
>> +        SMMU_CHECK_SECURE_WRITE("S_EVENTQ_IRQ_CFG0");
>> +        s->secure_eventq_irq_cfg0 = 
>> deposit64(s->secure_eventq_irq_cfg0,
>> +                                              0, 32, data);
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_IRQ_CFG0 + 4:
>> +        SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG0");
>> +        s->secure_eventq_irq_cfg0 = 
>> deposit64(s->secure_eventq_irq_cfg0,
>> +                                              32, 32, data);
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_IRQ_CFG1:
>> +        SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG1");
>> +        s->secure_eventq_irq_cfg1 = data;
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_IRQ_CFG2:
>> +        SMMU_CHECK_ATTRS_SECURE("S_EVENTQ_IRQ_CFG2");
>> +        s->secure_eventq_irq_cfg2 = data;
>> +        return MEMTX_OK;
>>       default:
>>           qemu_log_mask(LOG_UNIMP,
>>                         "%s Unexpected 32-bit access to 0x%"PRIx64" 
>> (WI)\n",
>> @@ -1687,6 +1958,11 @@ static MemTxResult smmu_write_mmio(void 
>> *opaque, hwaddr offset, uint64_t data,
>>   static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>>                                  uint64_t *data, MemTxAttrs attrs)
>>   {
>> +    bool secure_impl = false;
>> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
>> +        secure_impl = smmu_hw_secure_implemented(s);
>> +    }
>> +
>>       switch (offset) {
>>       case A_GERROR_IRQ_CFG0:
>>           *data = s->gerror_irq_cfg0;
>> @@ -1700,6 +1976,31 @@ static MemTxResult smmu_readll(SMMUv3State *s, 
>> hwaddr offset,
>>       case A_EVENTQ_BASE:
>>           *data = s->eventq.base;
>>           return MEMTX_OK;
>> +    case A_S_GERROR_IRQ_CFG0:
>> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
>> +                                       "S_GERROR_IRQ_CFG0", data)) {
>> +            return MEMTX_OK;
>> +        }
>> +        *data = s->secure_gerror_irq_cfg0;
>> +        return MEMTX_OK;
>> +    case A_S_STRTAB_BASE:
>> +        SMMU_CHECK_ATTRS_SECURE_READ("S_STRTAB_BASE");
>> +        *data = s->secure_strtab_base;
>> +        return MEMTX_OK;
>> +    case A_S_CMDQ_BASE:
>> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
>> +                                       "S_CMDQ_BASE", data)) {
>> +            return MEMTX_OK;
>> +        }
>> +        *data = s->secure_cmdq.base;
>> +        return MEMTX_OK;
>> +    case A_S_EVENTQ_BASE:
>> +        if (!smmu_validate_secure_read(attrs, secure_impl, offset,
>> +                                       "S_EVENTQ_BASE", data)) {
>> +            return MEMTX_OK;
>> +        }
>
> Why we don't reuse SMMU_CHECK_SECURE_READ for this and all other 
> similar if below? 


My apologies, I seem to have missed these when doing the macro 
replacement. I will be sure to fix this in the next version. Thank you 
for your feedback.


Thanks,

Tang


