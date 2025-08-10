Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D5CC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 17:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul9Pj-0006Da-4W; Sun, 10 Aug 2025 13:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ul9Pg-0006CU-Ry; Sun, 10 Aug 2025 13:00:52 -0400
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net ([167.99.105.149])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ul9PZ-0007Y9-Vx; Sun, 10 Aug 2025 13:00:52 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHj8850JhoqA4tBg--.778S2;
 Mon, 11 Aug 2025 01:00:41 +0800 (CST)
Received: from [192.168.31.34] (unknown [113.246.234.235])
 by mail (Coremail) with SMTP id AQAAfwAnsgkE0Jho0WQPAA--.21925S2;
 Mon, 11 Aug 2025 01:00:08 +0800 (CST)
Message-ID: <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
Date: Mon, 11 Aug 2025 00:59:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
 <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAnsgkE0Jho0WQPAA--.21925S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQASBWiXooAA6wAFsl
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3tF1rAw4xKrWxCryfZr4rAFb_yoWkZFW7pr
 1kJryUJry5GFn5Jr1UJr1UJFyUJw1UJ3WDJr1UWF1UJr4UAr1jqr1UWr1jgr1DGr48Jw1U
 Jr1UJrsrZr17Jr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=167.99.105.149;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmty3ljk5ljewns4xndka.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On 2025/8/7 05:55, Pierrick Bouvier wrote:
> On 8/6/25 8:11 AM, Tao Tang wrote:
>> This patch enables the secure command queue, providing a dedicated
>> interface for secure software to issue commands to the SMMU. Based on
>> the SMMU_S_CMDQ_BASE configuration, the SMMU now fetches command
>> entries directly from the Secure PA space so that we need to pass the
>> memory transaction attributes when reading the command queue.
>>
>> This provides a parallel command mechanism to the non-secure world.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3-internal.h |  8 ++++--
>>   hw/arm/smmuv3.c          | 55 +++++++++++++++++++++++++---------------
>>   hw/arm/trace-events      |  2 +-
>>   3 files changed, 41 insertions(+), 24 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index 1a8b1cb204..5b2ca00832 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -319,9 +319,13 @@ static inline void queue_cons_incr(SMMUQueue *q)
>>       q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
>>   }
>>   -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
>> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, bool is_secure)
>>   {
>> -    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>> +    if (is_secure) {
>> +        return FIELD_EX32(s->secure_cr[0], S_CR0, CMDQEN);
>> +    } else {
>> +        return FIELD_EX32(s->cr[0], CR0, CMDQEN);
>> +    }
>>   }
>>     static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 0ea9d897af..0590f0f482 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -105,14 +105,17 @@ static void smmuv3_write_gerrorn(SMMUv3State 
>> *s, uint32_t new_gerrorn)
>>       trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
>>   }
>>   -static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
>> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd, bool 
>> is_secure)
>>   {
>>       dma_addr_t addr = Q_CONS_ENTRY(q);
>>       MemTxResult ret;
>>       int i;
>> +    MemTxAttrs attrs = is_secure ?
>> +        (MemTxAttrs) { .secure = 1 } :
>> +        (MemTxAttrs) { .unspecified = true };
>>         ret = dma_memory_read(&address_space_memory, addr, cmd, 
>> sizeof(Cmd),
>> -                          MEMTXATTRS_UNSPECIFIED);
>> +                          attrs);
>>       if (ret != MEMTX_OK) {
>>           return ret;
>>       }
>> @@ -1311,14 +1314,14 @@ static inline bool 
>> smmu_hw_secure_implemented(SMMUv3State *s)
>>       return FIELD_EX32(s->secure_idr[1], S_IDR1, SECURE_IMPL);
>>   }
>>   -static int smmuv3_cmdq_consume(SMMUv3State *s)
>> +static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>>       SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>> -    SMMUQueue *q = &s->cmdq;
>> +    SMMUQueue *q = is_secure ? &s->secure_cmdq : &s->cmdq;
>>       SMMUCommandType type = 0;
>>   -    if (!smmuv3_cmdq_enabled(s)) {
>> +    if (!smmuv3_cmdq_enabled(s, is_secure)) {
>>           return 0;
>>       }
>>       /*
>> @@ -1329,17 +1332,20 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>        */
>>         while (!smmuv3_q_empty(q)) {
>> -        uint32_t pending = s->gerror ^ s->gerrorn;
>> +        uint32_t pending = is_secure ? s->secure_gerror ^ 
>> s->secure_gerrorn :
>> +            s->gerror ^ s->gerrorn;
>>           Cmd cmd;
>>             trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
>> -                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>> +                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q),
>> +                                  is_secure);
>>   -        if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
>> +        if (is_secure ? FIELD_EX32(pending, S_GERROR, CMDQ_ERR) :
>> +            FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
>>               break;
>>           }
>>   -        if (queue_read(q, &cmd) != MEMTX_OK) {
>> +        if (queue_read(q, &cmd, is_secure) != MEMTX_OK) {
>>               cmd_error = SMMU_CERROR_ABT;
>>               break;
>>           }
>> @@ -1364,8 +1370,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>               SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>>                 if (CMD_SSEC(&cmd)) {
>> -                cmd_error = SMMU_CERROR_ILL;
>> -                break;
>> +                if (!is_secure) {
>> +                    /* Secure Stream with NON-Secure command */
>> +                    cmd_error = SMMU_CERROR_ILL;
>> +                    break;
>> +                }
>>               }
>>                 if (!sdev) {
>> @@ -1384,8 +1393,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>               SMMUSIDRange sid_range;
>>                 if (CMD_SSEC(&cmd)) {
>> -                cmd_error = SMMU_CERROR_ILL;
>> -                break;
>> +                if (!is_secure) {
>> +                    cmd_error = SMMU_CERROR_ILL;
>> +                    break;
>> +                }
>>               }
>>                 mask = (1ULL << (range + 1)) - 1;
>> @@ -1403,8 +1414,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>               SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>>                 if (CMD_SSEC(&cmd)) {
>> -                cmd_error = SMMU_CERROR_ILL;
>> -                break;
>> +                if (!is_secure) {
>> +                    cmd_error = SMMU_CERROR_ILL;
>> +                    break;
>> +                }
>>               }
>>                 if (!sdev) {
>> @@ -1706,7 +1719,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, 
>> hwaddr offset,
>>           s->cr[0] = data;
>>           s->cr0ack = data & ~SMMU_CR0_RESERVED;
>>           /* in case the command queue has been enabled */
>> -        smmuv3_cmdq_consume(s);
>> +        smmuv3_cmdq_consume(s, false);
>>           return MEMTX_OK;
>>       case A_CR1:
>>           s->cr[1] = data;
>> @@ -1723,7 +1736,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, 
>> hwaddr offset,
>>            * By acknowledging the CMDQ_ERR, SW may notify cmds can
>>            * be processed again
>>            */
>> -        smmuv3_cmdq_consume(s);
>> +        smmuv3_cmdq_consume(s, false);
>>           return MEMTX_OK;
>>       case A_GERROR_IRQ_CFG0: /* 64b */
>>           s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 0, 32, 
>> data);
>> @@ -1772,7 +1785,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, 
>> hwaddr offset,
>>           return MEMTX_OK;
>>       case A_CMDQ_PROD:
>>           s->cmdq.prod = data;
>> -        smmuv3_cmdq_consume(s);
>> +        smmuv3_cmdq_consume(s, false);
>>           return MEMTX_OK;
>>       case A_CMDQ_CONS:
>>           s->cmdq.cons = data;
>> @@ -1810,7 +1823,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, 
>> hwaddr offset,
>>           s->secure_cr[0] = data;
>>           /* clear reserved bits */
>>           s->secure_cr0ack = data & ~SMMU_S_CR0_RESERVED;
>> -        smmuv3_cmdq_consume(s);
>> +        smmuv3_cmdq_consume(s, true);
>>           return MEMTX_OK;
>>       case A_S_CR1:
>>           if (!smmu_validate_secure_write(attrs, secure_impl, offset,
>> @@ -1836,7 +1849,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, 
>> hwaddr offset,
>>       case A_S_GERRORN:
>>           SMMU_CHECK_SECURE_WRITE("S_GERRORN");
>>           smmuv3_write_gerrorn(s, data);
>> -        smmuv3_cmdq_consume(s);
>> +        smmuv3_cmdq_consume(s, true);
>>           return MEMTX_OK;
>>       case A_S_GERROR_IRQ_CFG0:
>>           SMMU_CHECK_ATTRS_SECURE("S_GERROR_IRQ_CFG0");
>> @@ -1892,7 +1905,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, 
>> hwaddr offset,
>>       case A_S_CMDQ_PROD:
>>           SMMU_CHECK_SECURE_WRITE("S_CMDQ_PROD");
>>           s->secure_cmdq.prod = data;
>> -        smmuv3_cmdq_consume(s);
>> +        smmuv3_cmdq_consume(s, true);
>>           return MEMTX_OK;
>>       case A_S_CMDQ_CONS:
>>           SMMU_CHECK_SECURE_WRITE("S_CMDQ_CONS");
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index 019129ea43..7d967226ff 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -35,7 +35,7 @@ smmuv3_trigger_irq(int irq) "irq=%d"
>>   smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) 
>> "toggled=0x%x, new GERROR=0x%x"
>>   smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, 
>> new GERRORN=0x%x"
>>   smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
>> -smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, 
>> uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
>> +smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, 
>> uint8_t cons_wrap, bool is_secure_cmdq) "prod=%d cons=%d prod.wrap=%d 
>> cons.wrap=%d is_secure_cmdq=%d"
>>   smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>>   smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t 
>> prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, 
>> cons_wrap:%d "
>>   smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) 
>> "Error on %s command execution: %d"
>
> This looks like a reasonable and readable approach to support secure 
> and non secure accesses.

Hi Pierrick,

Thank you so much for taking the time to review and for the very 
positive feedback.

I'm very relieved to hear you find the approach "reasonable and 
readable". I was hoping that explicitly passing the parameter was the 
right way to avoid issues with global state or code duplication, and 
your confirmation is the best encouragement I could ask for.

Thanks again!

Best,
Tang


