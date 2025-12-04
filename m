Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5019D21683
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 14:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRAbB-0002L3-2X; Thu, 04 Dec 2025 09:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRAb1-0002Dz-8L
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 09:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRAay-0003pz-Ub
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 09:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764859571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+I8O6uClGYw5qrxVtQVwtKU2mYchXNmWmv5tPFN/ow=;
 b=Ex/K5qpblCs07XF++rOQEfbQqpp/LFr7KHA8/Y5f8berlRDWnHQgdnvOp+hlDcqXEAFfgQ
 2TJfWHc8unxcaTffZWhTKK8ZbFh7IombRfzbKxqID90ZJaBtehZVmq1PNQ/j3LfpPykbLc
 y3djG2Q8NK5NV5VKhro/AYo9yqY+AB8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-kuzEkGZoOomdmUqnqfrw2g-1; Thu, 04 Dec 2025 09:46:10 -0500
X-MC-Unique: kuzEkGZoOomdmUqnqfrw2g-1
X-Mimecast-MFC-AGG-ID: kuzEkGZoOomdmUqnqfrw2g_1764859570
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-787e31befddso13166237b3.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 06:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764859569; x=1765464369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+I8O6uClGYw5qrxVtQVwtKU2mYchXNmWmv5tPFN/ow=;
 b=fwMXVsgjyfPtVifPjGcaAYvHBqxMUk/ZLyK4y9mbWHPb/86aEwfWkyYh1vFGGo/+Bk
 nOzdEYo1QHkGAMrsHn9O9SUKxNqRgcaQylvfxR91HuRH19ccuO2Ou9heZ55lp7a/cKsz
 K5erbnWH2oit/kSHxhD+Qd/v9JgFXYH0MuirdYhV7GkL7yi9NID74OLFCnJaPJwPVs2b
 bj+hhjuht7S4U8SdmDpCoWQN72D/Wn52HZX9uBDIwNYSAVoXkHGvH6PvOpb5lTZH9B/g
 EbOxn/CC+s9UOYy4e2B+dD78Ct5ab5DP8O+pagC8hrrFf86jciTNYs9U7ZSiWVvqZBC6
 Nbxw==
X-Gm-Message-State: AOJu0YxzNu1iy9UxIjvq2IQSXkil2JRfeHC9oX6VG0G4BnKUUWhhSiD0
 ecryOQpkJiOUyeuaSwmWJIk1lcSPpD7/7XRXzyO2QNHpnkmqUOtREegR/v+/sniP/945fPHpOqR
 Pdw7NR/9FE46rMQMxMdJVUhku81ucsCh5yzoia5h5pcGwP/NP/Q39KYjTKznkEuvX
X-Gm-Gg: ASbGncue7UAsjzK5rqVwnXejVnVwH5twmdd7l43/OQr61XEDBfY9Xg3Db4B2CodoZL2
 BDI7CRi7NgQtfGaHxomg2hXGhOyt/TcO4jecj/Az6H1sudv5fhTRb1IMLZXhyvr4m6OXRJiaXXR
 Gip4YyYkm1FX4wMzP6rdwxw8W+PhkHkLa7NyWkNSsmjZVg/4jKftiCkFSUatn4VyeJ2Kuze586L
 7GLpr6SYlntVQrjqbmQYlBGhr9griBP2p6hu/EO5Bb3xwrvfqVm1ySjHqb+dLEPZrjlKAMpE4lU
 7PIbF0HH2o1p0JOWkdEKqOKUlIVkLpPLCcs23k86GXpk1SOTa1dUI6tLzvb5IAHTizTS5gr0jHG
 Dn52ohNBgAdH76fWBsaU4mqkpso/1ib8t1NgFFT0anRE+4mdlzzGIOeT+Ww==
X-Received: by 2002:a05:690c:3805:b0:786:5f03:2b65 with SMTP id
 00721157ae682-78c0c22afc3mr48976807b3.33.1764859569263; 
 Thu, 04 Dec 2025 06:46:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqpvcwgaYq3ttn0SADz1rvEpqzNQEwl5AG9q9pSPcZ6GG8Yk/xWPhwnRO7Nw391/f7HDNsxg==
X-Received: by 2002:a05:690c:3805:b0:786:5f03:2b65 with SMTP id
 00721157ae682-78c0c22afc3mr48976597b3.33.1764859568800; 
 Thu, 04 Dec 2025 06:46:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78c1b78de56sm5874937b3.38.2025.12.04.06.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 06:46:08 -0800 (PST)
Message-ID: <bab3001e-b756-48e3-894a-4b4c43521069@redhat.com>
Date: Thu, 4 Dec 2025 15:46:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 17/21] hw/arm/smmuv3: Pass security state to command
 queue and IRQ logic
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
 <20251012151420.4130577-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012151420.4130577-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/12/25 5:14 PM, Tao Tang wrote:
> The command queue and interrupt logic must operate within the correct
> security context. Handling a command queue in one security state can
> have side effects, such as interrupts or errors, that need to be
> processed in another. This requires the IRQ and GERROR logic to be
> fully aware of the multi-security-state environment.
>
> This patch refactors the command queue processing and interrupt handling
> to be security-state aware. Besides, unlike the command queue, the
> event queue logic was already updated to be security-state aware in a
> previous change. The SMMUSecSID is now passed through the relevant
> functions to ensure that:
>
> - Command queue operations are performed on the correct register bank.
>
> - Interrupts are triggered and checked against the correct security
> state's configuration.
>
> - Errors from command processing are reported in the correct GERROR
> register bank.
>
> - Architectural access controls, like preventing secure commands from a
> non-secure queue, are correctly enforced.
>
> - As Secure Stage 2 is not yet implemented, commands that target it
> are now correctly aborted during command queue processing.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c     | 61 +++++++++++++++++++++++++++++++--------------
>  hw/arm/trace-events |  2 +-
>  2 files changed, 43 insertions(+), 20 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 432de88610..4ac7a2f3c7 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -46,11 +46,11 @@
>   *
>   * @irq: irq type
>   * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
> + * @sec_sid: SEC_SID of the bank
>   */
>  static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
> -                               uint32_t gerror_mask)
> +                               uint32_t gerror_mask, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>  
>      bool pulse = false;
> @@ -87,9 +87,9 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>      }
>  }
>  
> -static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
> +static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
> +                                 SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      uint32_t pending = bank->gerror ^ bank->gerrorn;
>      uint32_t toggled = bank->gerrorn ^ new_gerrorn;
> @@ -109,7 +109,7 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>      trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
>  }
>  
> -static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd, SMMUSecSID sec_sid)
why this change as sec_sid is not yet used?
besides the q is already specialized for a given sec_sid
>  {
>      dma_addr_t addr = Q_CONS_ENTRY(q);
>      MemTxResult ret;
> @@ -167,7 +167,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>      }
>  
>      if (!smmuv3_q_empty(q)) {
> -        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, sec_sid);
>      }
>      return MEMTX_OK;
>  }
> @@ -263,7 +263,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>                                info->sid);
>      r = smmuv3_write_eventq(s, sec_sid, &evt);
>      if (r != MEMTX_OK) {
> -        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
> +                           R_GERROR_EVENTQ_ABT_ERR_MASK, sec_sid);
>      }
>      info->recorded = true;
>  }
> @@ -1457,11 +1458,10 @@ static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
>      return smmu_irq_ctl_evtq_irqen_disabled(s, sec_sid);
>  }
>  
> -static int smmuv3_cmdq_consume(SMMUv3State *s)
> +static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      SMMUQueue *q = &bank->cmdq;
>      SMMUCommandType type = 0;
> @@ -1480,14 +1480,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          uint32_t pending = bank->gerror ^ bank->gerrorn;
>          Cmd cmd;
>  
> -        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
> +        trace_smmuv3_cmdq_consume(sec_sid, Q_PROD(q), Q_CONS(q),
>                                    Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>  
>          if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
>              break;
>          }
>  
> -        if (queue_read(q, &cmd) != MEMTX_OK) {
> +        if (queue_read(q, &cmd, sec_sid) != MEMTX_OK) {
>              cmd_error = SMMU_CERROR_ABT;
>              break;
>          }
> @@ -1500,7 +1500,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          switch (type) {
>          case SMMU_CMD_SYNC:
>              if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
> -                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
> +                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, sec_sid);
>              }
>              break;
>          case SMMU_CMD_PREFETCH_CONFIG:
> @@ -1512,6 +1512,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>  
>              if (CMD_SSEC(&cmd)) {
when reading the spec I have the impression SSEC is common to all commands
4.1.6 Common command fields
Can't you factorize that check?
> +                if (sec_sid != SMMU_SEC_SID_S) {
> +                    /* Secure Stream with Non-Secure command */
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> @@ -1532,6 +1537,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              SMMUSIDRange sid_range;
>  
>              if (CMD_SSEC(&cmd)) {
> +                if (sec_sid != SMMU_SEC_SID_S) {
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> @@ -1551,6 +1560,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>  
>              if (CMD_SSEC(&cmd)) {
> +                if (sec_sid != SMMU_SEC_SID_S) {
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> @@ -1618,7 +1631,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, sec_sid);
>              break;
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
> @@ -1628,6 +1641,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> +            /* Secure Stage 2 isn't supported for now */
> +            if (sec_sid != SMMU_SEC_SID_NS) {
> +                cmd_error = SMMU_CERROR_ABT;
> +                break;
> +            }
>  
>              trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
>              smmu_inv_notifiers_all(&s->smmu_state);
> @@ -1639,11 +1657,16 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> +
> +            if (sec_sid != SMMU_SEC_SID_NS) {
> +                cmd_error = SMMU_CERROR_ABT;
> +                break;
> +            }
>              /*
>               * As currently only either s1 or s2 are supported
>               * we can reuse same function for s2.
>               */
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, sec_sid);
>              break;
>          case SMMU_CMD_TLBI_EL3_ALL:
>          case SMMU_CMD_TLBI_EL3_VA:
> @@ -1680,7 +1703,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>      if (cmd_error) {
>          trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
>          smmu_write_cmdq_err(s, cmd_error, sec_sid);
> -        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK, sec_sid);
>      }
>  
>      trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
> @@ -1772,7 +1795,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          bank->cr[0] = data;
>          bank->cr0ack = data & ~SMMU_CR0_RESERVED;
>          /* in case the command queue has been enabled */
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, reg_sec_sid);
>          return MEMTX_OK;
>      case A_CR1:
>          bank->cr[1] = data;
> @@ -1792,12 +1815,12 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          bank->irq_ctrl = data;
>          return MEMTX_OK;
>      case A_GERRORN:
> -        smmuv3_write_gerrorn(s, data);
> +        smmuv3_write_gerrorn(s, data, reg_sec_sid);
>          /*
>           * By acknowledging the CMDQ_ERR, SW may notify cmds can
>           * be processed again
>           */
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, reg_sec_sid);
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0: /* 64b */
>          if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> @@ -1899,7 +1922,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          return MEMTX_OK;
>      case A_CMDQ_PROD:
>          bank->cmdq.prod = data;
> -        smmuv3_cmdq_consume(s);
> +        smmuv3_cmdq_consume(s, reg_sec_sid);
>          return MEMTX_OK;
>      case A_CMDQ_CONS:
>          if (!smmu_cmdqen_disabled(s, reg_sec_sid)) {
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 0e7ad8fee3..697e0d84f3 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -35,7 +35,7 @@ smmuv3_trigger_irq(int irq) "irq=%d"
>  smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
>  smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
>  smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
> -smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
> +smmuv3_cmdq_consume(int sec_sid, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "sec_sid=%d prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
>  smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>  smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>  smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
Thanks

Eric


