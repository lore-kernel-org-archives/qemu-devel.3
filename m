Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1743ECAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvydB-0005md-4u; Tue, 09 Sep 2025 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uvyd7-0005lq-Vf
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uvyct-0003eS-UT
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425391;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFlYB42wJ8kJFXxA9WYxifFI+VLpy2q4pxAH/cCCi38=;
 b=fPM2slSV7xuR0gpYlWFCwV4Ueqip2tu+eubFhhUMqT+EjH9RTeK6OaYuF3s+TMd7FgRO+h
 FFuaYtbHJHKTA58aLNQZtyrZZomx1Tx+UafgwlZT4Sk63tBKtwevc9x1IZdRTxXKuic2os
 4WtlXzuR+eUGFDGFSK/eI3JmFhxdaRc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-dR1C7zDlPEO_BIXxwPewrw-1; Tue, 09 Sep 2025 09:43:10 -0400
X-MC-Unique: dR1C7zDlPEO_BIXxwPewrw-1
X-Mimecast-MFC-AGG-ID: dR1C7zDlPEO_BIXxwPewrw_1757425389
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-807056330b6so676766485a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 06:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757425389; x=1758030189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qFlYB42wJ8kJFXxA9WYxifFI+VLpy2q4pxAH/cCCi38=;
 b=jXqOwMhLSbabaJDMaqkCYbqqQyjsFlgbAGjAznOZQ5IwXJKFoGo/5yv3Xnhy370Pqx
 jhzLGSJTOgohlQLpfnMpAmSHOxapn4ASDuOxXNMdj+Hj5lBL6kFewpPqhnRLAWIjvRL7
 Q4nXVerwMXnZbJK+uCXHQE2KJDd9TgFAblHbwDl0tMv0ZlXLFkE1rcpiCkpGi8KD8lOE
 2j+vrMrNMu7wlGrBNCXoRaAo3R9VC9BACkWfqjqZxkV0oxxjuUfszmdPxwi9DQZBq7QC
 aWuo/ecOc/NXe8RzmNWDeqdUiSJHAh9l/BH79Cp/2Ailcab67pypW6mBqb/ilZdpF0z1
 6SOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU35B3R9EgVefvyFeHbr9ZgQHKG2jpyqFdtHCv4tfYPTaIzetTaoJaJW6PiRrnqRCGwwJobOHo/IJRS@nongnu.org
X-Gm-Message-State: AOJu0YxcWGm8apHAg9OmUnIt1j7/KKirxkVLeV/xYn47AvDn5YbIj7NP
 qhoFZkdMpzLxIOyvesKoc6aOE4/gMhjhEOgPkFW5UIigsFoH/b2WlSQg0XGsGNrmp/keFhhWREU
 N71z1aPtaeXl/4cBPekIwv/OroujJ+q7t/3Mno5+dvqr4JW2TsJtpaqXq
X-Gm-Gg: ASbGncv7N7RutWtJm/lZ28Ibdiv8ZlFi/UGbn5EwrWX53FO8v93EvHlcTMP/e89n1IH
 oQHDk6YQi6r30cqmIJJJSqoCBH9iLVDehumvraGelWS5jOcHYl+uBoKD0hYoRz88atSmzEUh0Z/
 zDR0gCSOi/u0niOVhWVYdI9jy8/+1TqG0QNix3Dj1MywhwNFpP6OPrFZwtQ9Ke8STfHc8v9dMsQ
 fxjDURJfGH8p1OlBoWsFUxX3za/3/CNku5I3n0/WENSJPcywxBMG+MHNKkHg0AGli7kv+0+wwEz
 EeOHh2pYMBf7enaJ93qWZRAr4UHZPSlk/MXa2xqBggZ0lU4=
X-Received: by 2002:a05:620a:1a99:b0:803:85cb:2cba with SMTP id
 af79cd13be357-813bf8aa868mr1166711285a.26.1757425389146; 
 Tue, 09 Sep 2025 06:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpo5CD7SAY/TVrV70jhKvuxwKQkgABVqzUInH83+F7CHsEujU38+dxy4WG7A/Bfx0ai/ULJg==
X-Received: by 2002:a05:620a:1a99:b0:803:85cb:2cba with SMTP id
 af79cd13be357-813bf8aa868mr1166707785a.26.1757425388619; 
 Tue, 09 Sep 2025 06:43:08 -0700 (PDT)
Received: from [192.168.43.95] ([37.167.152.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbbc302sm8923521cf.26.2025.09.09.06.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 06:43:08 -0700 (PDT)
Message-ID: <54ec4410-373d-4171-9e63-6933a42fe17f@redhat.com>
Date: Tue, 9 Sep 2025 15:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation commands
 to hw
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-14-shameerali.kolothum.thodi@huawei.com>
 <5ab38eaa-b005-432a-9de7-fae3e6096f89@redhat.com>
 <CH3PR12MB7548543A976A65B74DA6EA42AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548543A976A65B74DA6EA42AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/8/25 2:22 PM, Shameer Kolothum wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 05 September 2025 13:46
>> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Shameer Kolothum
>> <skolothumtho@nvidia.com>
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; linuxarm@huawei.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation
>> commands to hw
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 7/14/25 5:59 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> Use the provided smmuv3-accel helper functions to issue the
>>> invalidation commands to host SMMUv3.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  hw/arm/smmuv3-internal.h | 11 +++++++++++
>>>  hw/arm/smmuv3.c          | 28 ++++++++++++++++++++++++++++
>>>  2 files changed, 39 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>> index 8cb6a9238a..f3aeaf6375 100644
>>> --- a/hw/arm/smmuv3-internal.h
>>> +++ b/hw/arm/smmuv3-internal.h
>>> @@ -233,6 +233,17 @@ static inline bool
>> smmuv3_gerror_irq_enabled(SMMUv3State *s)
>>>  #define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> (q)-
>>> log2size)
>>>  #define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> (q)-
>>> log2size)
>>>
>>> +static inline int smmuv3_q_ncmds(SMMUQueue *q)
>>> +{
>>> +    uint32_t prod = Q_PROD(q);
>>> +    uint32_t cons = Q_CONS(q);
>>> +
>>> +    if (Q_PROD_WRAP(q) == Q_CONS_WRAP(q))
>>> +        return prod - cons;
>>> +    else
>>> +        return WRAP_MASK(q) - cons + prod;
>>> +}
>>> +
>>>  static inline bool smmuv3_q_full(SMMUQueue *q)
>>>  {
>>>      return ((q->cons ^ q->prod) & WRAP_INDEX_MASK(q)) ==
>> WRAP_MASK(q);
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index c94bfe6564..97ecca0764 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1285,10 +1285,17 @@ static int
>> smmuv3_cmdq_consume(SMMUv3State *s)
>>>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>>>      SMMUQueue *q = &s->cmdq;
>>>      SMMUCommandType type = 0;
>>> +    SMMUCommandBatch batch = {};
>>> +    uint32_t ncmds;
>>>
>>>      if (!smmuv3_cmdq_enabled(s)) {
>>>          return 0;
>>>      }
>>> +
>>> +    ncmds = smmuv3_q_ncmds(q);
>>> +    batch.cmds = g_new0(Cmd, ncmds);
>>> +    batch.cons = g_new0(uint32_t, ncmds);
>> so you are provisionning space for n commands found in the queue,
>> independently on knowing whether they will be batched, ie. only
>> invalidation commands are. Then commands are added in the batch one by
>> one and you increment batch->ncmds in smmuv3_accel_batch_cmd. I agree
>> with Jonathan. This looks weird. AT least I would introduce a kelper
>> that inits a Back of ncmds and I would make all the batch fields
>> private. You you end up with the init +
>> smmuv3_accel_add_cmd_to_batch(batch, cmd). Then independently on the
>> ncmds you can issue a smmuv3_accel_issue_cmd_batch that would return if
>> there is nothing in the batch. You also need a batch deallocation
>> helper. 
> Agree, at present we pre-allocate irrespective of whether there will any
> Invalidation cmds or not. I will take another look and incorporate your above
> suggestion to improve this. 
>
> I remember I expressed in the past my concern about having
>> commands executed out of order. I don't remember out conclusion on that
>> but this shall be clearly studied and conclusion shall be put in the
>> commit message.
> Yes, you did, and I missed it. Sorry about that.
>
> I think it is safe to honour the execution order of Guest here. From a quick glance, I
> couldn’t find anything related to a safe out of order execution guidance from
> SMMUv3 specification. Also, we can't be sure how Guest will be modified/optimised
> in the future to completely rule out problems if we do out-of-order executions. 
What about if you receive a sync cmd. It is supposed to assure all the
preceding commands were consumed. However in that case you will have
commands that were submitted before that can be executed after. This
looks wrong to me.

This optimization is not requested in the first enablement series. I
would postpone it personally.

>
> Hence, my plan for next is to start batching if we see Invalidation cmds and submit
> the batch If any non-invalidation commands are encountered in between.
looks safe indeed. But again this can come as a follow up optimization.

Eric
>
> @Nicolin, do you foresee any issues with above approach? From the current
> Host SMMUV3 driver, batching of commands is mainly used for invalidations
> (except for certain arm_smmu_cmdq_issue_cmd_with_sync() cases). So 
> I guess we are good from a performance optimisation point of view if we can
> cover invalidations as above.
>
>>> +
>>>      /*
>>>       * some commands depend on register values, typically CR0. In case those
>>>       * register values change while handling the command, spec says it
>>> @@ -1383,6 +1390,7 @@ static int
>> smmuv3_cmdq_consume(SMMUv3State *s)
>>>              trace_smmuv3_cmdq_cfgi_cd(sid);
>>>              smmuv3_flush_config(sdev);
>>> +            smmuv3_accel_batch_cmd(sdev->smmu, sdev, &batch, &cmd, &q-
>>> cons);
>>>              break;
>>>          }
>>>          case SMMU_CMD_TLBI_NH_ASID:
>>> @@ -1406,6 +1414,7 @@ static int
>> smmuv3_cmdq_consume(SMMUv3State *s)
>>>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>>>              smmu_inv_notifiers_all(&s->smmu_state);
>>>              smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
>>> +            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
>>>              break;
>>>          }
>>>          case SMMU_CMD_TLBI_NH_ALL:
>>> @@ -1433,6 +1442,7 @@ static int
>> smmuv3_cmdq_consume(SMMUv3State *s)
>>>              trace_smmuv3_cmdq_tlbi_nsnh();
>>>              smmu_inv_notifiers_all(&s->smmu_state);
>>>              smmu_iotlb_inv_all(bs);
>>> +            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
>>>              break;
>>>          case SMMU_CMD_TLBI_NH_VAA:
>>>          case SMMU_CMD_TLBI_NH_VA:
>>> @@ -1441,6 +1451,7 @@ static int
>> smmuv3_cmdq_consume(SMMUv3State *s)
>>>                  break;
>>>              }
>>>              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
>>> +            smmuv3_accel_batch_cmd(bs, NULL, &batch, &cmd, &q->cons);
>>>              break;
>>>          case SMMU_CMD_TLBI_S12_VMALL:
>>>          {
>>> @@ -1499,12 +1510,29 @@ static int
>> smmuv3_cmdq_consume(SMMUv3State *s)
>>>          queue_cons_incr(q);
>>>      }
>>>
>>> +    qemu_mutex_lock(&s->mutex);
>>> +    if (!cmd_error && batch.ncmds) {
>>> +        if (!smmuv3_accel_issue_cmd_batch(bs, &batch)) {
>>> +            if (batch.ncmds) {
>>> +                q->cons = batch.cons[batch.ncmds - 1];
>>> +            } else {
>>> +                q->cons = batch.cons[0]; /* FIXME: Check */
>>> +            }
>>> +            qemu_log_mask(LOG_GUEST_ERROR, "Illegal command type: %d\n",
>>> +                          CMD_TYPE(&batch.cmds[batch.ncmds]));
>> Can't you have other error types returned?
> Kernel can return EOPNOTSUPP/EINVAL/ENOMEM/EFAULT/ ETIMEDOUT errors.
> Of these, only ETIMEDOUT is related to the actual host Queue when an attempted
> SYNC results in timeout.
>
> So, between CERROR_ILL/ _ABT/ _ATC_INV_SYNC I think it is best to set CERROR_ILL
> here.
>
> Thanks,
> Shameer
>
>> Thanks
>>
>> Eric
>>> +            cmd_error = SMMU_CERROR_ILL;
>>> +        }
>>> +    }
>>> +    qemu_mutex_unlock(&s->mutex);
>>> +
>>>      if (cmd_error) {
>>>          trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type),
>> cmd_error);
>>>          smmu_write_cmdq_err(s, cmd_error);
>>>          smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
>> R_GERROR_CMDQ_ERR_MASK);
>>>      }
>>>
>>> +    g_free(batch.cmds);
>>> +    g_free(batch.cons);
>>>      trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
>>>                                    Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>>>


