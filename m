Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADC1D2F7C9
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 09:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRSLG-0006Rx-Ag; Fri, 05 Dec 2025 04:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRSLB-0006QM-Ow; Fri, 05 Dec 2025 04:43:05 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRSL7-0005Hv-Qc; Fri, 05 Dec 2025 04:43:05 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHy5caqTJp9ysTAw--.326S2;
 Fri, 05 Dec 2025 17:42:50 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwC3DesXqTJpDsAJAA--.4270S2;
 Fri, 05 Dec 2025 17:42:47 +0800 (CST)
Message-ID: <4936993e-122e-42ba-acb2-f28c313de35f@phytium.com.cn>
Date: Fri, 5 Dec 2025 17:42:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 17/21] hw/arm/smmuv3: Pass security state to command
 queue and IRQ logic
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151420.4130577-1-tangtao1634@phytium.com.cn>
 <bab3001e-b756-48e3-894a-4b4c43521069@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <bab3001e-b756-48e3-894a-4b4c43521069@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwC3DesXqTJpDsAJAA--.4270S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAPBWkx6ywEIgAAsy
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3ZrW5Aw18Cr18KrWUJw47Jwb_yoWDXrW7pr
 48A3Z8GryrGF1fJF1Iq3yUuFy3Jw17Kwn8Jry5Ka4fA34DAr1Fqr1DWr1Y934Dur4rZw4I
 yayUGrsxuF17ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Eric,

On 2025/12/4 22:46, Eric Auger wrote:
>
> On 10/12/25 5:14 PM, Tao Tang wrote:
>> The command queue and interrupt logic must operate within the correct
>> security context. Handling a command queue in one security state can
>> have side effects, such as interrupts or errors, that need to be
>> processed in another. This requires the IRQ and GERROR logic to be
>> fully aware of the multi-security-state environment.
>>
>> This patch refactors the command queue processing and interrupt handling
>> to be security-state aware. Besides, unlike the command queue, the
>> event queue logic was already updated to be security-state aware in a
>> previous change. The SMMUSecSID is now passed through the relevant
>> functions to ensure that:
>>
>> - Command queue operations are performed on the correct register bank.
>>
>> - Interrupts are triggered and checked against the correct security
>> state's configuration.
>>
>> - Errors from command processing are reported in the correct GERROR
>> register bank.
>>
>> - Architectural access controls, like preventing secure commands from a
>> non-secure queue, are correctly enforced.
>>
>> - As Secure Stage 2 is not yet implemented, commands that target it
>> are now correctly aborted during command queue processing.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c     | 61 +++++++++++++++++++++++++++++++--------------
>>   hw/arm/trace-events |  2 +-
>>   2 files changed, 43 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 432de88610..4ac7a2f3c7 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -46,11 +46,11 @@
>>    *
>>    * @irq: irq type
>>    * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
>> + * @sec_sid: SEC_SID of the bank
>>    */
>>   static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>> -                               uint32_t gerror_mask)
>> +                               uint32_t gerror_mask, SMMUSecSID sec_sid)
>>   {
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>   
>>       bool pulse = false;
>> @@ -87,9 +87,9 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>>       }
>>   }
>>   
>> -static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>> +static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
>> +                                 SMMUSecSID sec_sid)
>>   {
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>       uint32_t pending = bank->gerror ^ bank->gerrorn;
>>       uint32_t toggled = bank->gerrorn ^ new_gerrorn;
>> @@ -109,7 +109,7 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>>       trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
>>   }
>>   
>> -static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
>> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd, SMMUSecSID sec_sid)
> why this change as sec_sid is not yet used?
> besides the q is already specialized for a given sec_sid
>>   {
>>       dma_addr_t addr = Q_CONS_ENTRY(q);
>>       MemTxResult ret;
>> @@ -167,7 +167,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>>       }
>>   
>>       if (!smmuv3_q_empty(q)) {
>> -        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
>> +        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, sec_sid);
>>       }
>>       return MEMTX_OK;
>>   }
>> @@ -263,7 +263,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>>                                 info->sid);
>>       r = smmuv3_write_eventq(s, sec_sid, &evt);
>>       if (r != MEMTX_OK) {
>> -        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
>> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
>> +                           R_GERROR_EVENTQ_ABT_ERR_MASK, sec_sid);
>>       }
>>       info->recorded = true;
>>   }
>> @@ -1457,11 +1458,10 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>>       return smmu_irq_ctl_evtq_irqen_disabled(s, sec_sid);
>>   }
>>   
>> -static int smmuv3_cmdq_consume(SMMUv3State *s)
>> +static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>>       SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>       SMMUQueue *q = &bank->cmdq;
>>       SMMUCommandType type = 0;
>> @@ -1480,14 +1480,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>           uint32_t pending = bank->gerror ^ bank->gerrorn;
>>           Cmd cmd;
>>   
>> -        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
>> +        trace_smmuv3_cmdq_consume(sec_sid, Q_PROD(q), Q_CONS(q),
>>                                     Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>>   
>>           if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
>>               break;
>>           }
>>   
>> -        if (queue_read(q, &cmd) != MEMTX_OK) {
>> +        if (queue_read(q, &cmd, sec_sid) != MEMTX_OK) {
>>               cmd_error = SMMU_CERROR_ABT;
>>               break;
>>           }
>> @@ -1500,7 +1500,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>           switch (type) {
>>           case SMMU_CMD_SYNC:
>>               if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
>> -                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
>> +                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, sec_sid);
>>               }
>>               break;
>>           case SMMU_CMD_PREFETCH_CONFIG:
>> @@ -1512,6 +1512,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>               SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>>   
>>               if (CMD_SSEC(&cmd)) {
> when reading the spec I have the impression SSEC is common to all commands
> 4.1.6 Common command fields
> Can't you factorize that check?
>> +                if (sec_sid != SMMU_SEC_SID_S) {
>> +                    /* Secure Stream with Non-Secure command */
>> +                    cmd_error = SMMU_CERROR_ILL;
>> +                    break;
>> +                }
>>                   cmd_error = SMMU_CERROR_ILL;
>>                   break;
>>               }
>> @@ -1532,6 +1537,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>               SMMUSIDRange sid_range;
>>   
>>               if (CMD_SSEC(&cmd)) {
>> +                if (sec_sid != SMMU_SEC_SID_S) {
>> +                    cmd_error = SMMU_CERROR_ILL;
>> +                    break;
>> +                }
>>                   cmd_error = SMMU_CERROR_ILL;
>>                   break;
>>               }
>> @@ -1551,6 +1560,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>               SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>>   
>>               if (CMD_SSEC(&cmd)) {
>> +                if (sec_sid != SMMU_SEC_SID_S) {
>> +                    cmd_error = SMMU_CERROR_ILL;
>> +                    break;
>> +                }
>>                   cmd_error = SMMU_CERROR_ILL;
>>                   break;
>>               }
>> @@ -1618,7 +1631,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>                   cmd_error = SMMU_CERROR_ILL;
>>                   break;
>>               }
>> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
>> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, sec_sid);
>>               break;
>>           case SMMU_CMD_TLBI_S12_VMALL:
>>           {
>> @@ -1628,6 +1641,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>                   cmd_error = SMMU_CERROR_ILL;
>>                   break;
>>               }
>> +            /* Secure Stage 2 isn't supported for now */
>> +            if (sec_sid != SMMU_SEC_SID_NS) {
>> +                cmd_error = SMMU_CERROR_ABT;
>> +                break;
>> +            }
>>   
>>               trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
>>               smmu_inv_notifiers_all(&s->smmu_state);
>> @@ -1639,11 +1657,16 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>                   cmd_error = SMMU_CERROR_ILL;
>>                   break;
>>               }
>> +
>> +            if (sec_sid != SMMU_SEC_SID_NS) {
>> +                cmd_error = SMMU_CERROR_ABT;
>> +                break;
>> +            }
>>               /*
>>                * As currently only either s1 or s2 are supported
>>                * we can reuse same function for s2.
>>                */
>> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
>> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, sec_sid);
>>               break;
>>           case SMMU_CMD_TLBI_EL3_ALL:
>>           case SMMU_CMD_TLBI_EL3_VA:


Thanks for the pointers on 4.1.6. After reading the spec, I realize I 
did not clearly separate two related concepts in my initial implementation:

- the security context of the command queue / register bank, and

- the security state of the target stream described by SSEC in the 
command payload that the command is meant to operate on.


I plan to split the command queue’s security state from the stream's 
security state. The command queue bank (NS/S) still drives which 
register bank sees the GERROR/CMDQ state, while a small helper now 
interprets SSEC so every opcode automatically targets the right stream 
security state, which is pointed by SMMUSecSID *stream_sid (NS-only for 
the NS queue; Secure vs Non-secure selected per SSEC on the Secure queue).



static bool smmuv3_cmd_resolve_stream_sid(SMMUSecSID cmdq_sid,
                                           const Cmd *cmd,
                                           SMMUSecSID *stream_sid,       
   /* Output SEC_SID that point to the target stream and will be used in 
the subsequent code */
                                           SMMUCmdError *err)
{
     uint32_t ssec = CMD_SSEC(cmd);

     switch (cmdq_sid) {
     case SMMU_SEC_SID_NS:
         if (ssec) {
             *err = SMMU_CERROR_ILL;
             return false;
         }
         *stream_sid = SMMU_SEC_SID_NS;
         return true;
     case SMMU_SEC_SID_S:
         *stream_sid = ssec ? SMMU_SEC_SID_S : SMMU_SEC_SID_NS;
         return true;
     default:
         *err = SMMU_CERROR_ILL;
         return false;
     }
}


static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid) {

.......

         if (!smmuv3_cmd_resolve_stream_sid(sec_sid, &cmd,
                                            &stream_sid, &cmd_error)) {
             break;
         }

         qemu_mutex_lock(&s->mutex);
         switch (type) {

.......

         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, stream_sid);  /* 
Use the output SEC_SID that returned from smmuv3_cmd_resolve_stream_sid*/
             break;

}


Could you please take a quick look at the helper before I fold it into v4?


Also I'll remove `SMMUSecSID sec_sid` in queue_read.


Thanks a lot for your time!

Best regards,
Tao


