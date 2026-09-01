Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67278C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Oqu-0005bf-H6; Tue, 01 Sep 2026 09:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1Oqn-0005am-Rq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:48:35 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1Oqk-0008A0-8M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:48:33 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a5f95a879cso12534a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788270505; x=1788875305; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K63IKdxpRkj+wSeMXuT09ZZ6TDwRyJQNycnmcr30AI0=;
 b=A8KuVJ0ixJMCPC2Fk3sBTt6L+n9dw/46U6hc73eh9ijm6aWwWjWYop1F/g7h5KuR2i
 3Kgjjvd2r8U+Sv3xYi7j7zv13CFIm5nuM8B551eybPPOlBwh0hZr0AHxVShoR8BoEksx
 SMGXDVZHCtUrZTBs1hunNtb+M9AI0WnIIN0DqPj4MwNIoylPSQ0OGCvEFU8J0uZGkFNa
 C+uYiLhOJzlQapGuRJKQxA76ivgkgBrvH9LLeQTP0YLGUCXXAsyW9GPFvglrhKT0BlYi
 LNk9vomLFI1SZS80vgq4fU80kYak+F8GRXZXYLrEFhB/0v6ZUMdeYrHF4oH4tDpCwcYG
 vupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788270505; x=1788875305;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K63IKdxpRkj+wSeMXuT09ZZ6TDwRyJQNycnmcr30AI0=;
 b=VGlgSJlIXwiZuQ9gjgNuSuicqy/SOACBZ303MFmc5mrfIR0ILZiIDdr17OTLkIA6gM
 EJP5Jahx0140tzpxSh4oT3j9ydnFRmsiUPd9Ag8Xfsn4xrmxHotDsrswo3mzYu03qN9L
 OIKEvHcPJFACpZ4Nt/BX+R38KzKoXCky1C/nzQIEy2NVzEbu8O+7sA5i0xebaX3QzbPN
 dSKvC1y2h97aQZd9K0xeUY8JLI4hJTRW70H1moPNZklQw8VjAng/F9NQ5UiWQqjrE3dk
 IaY4Si6NOHmT0GGLckSmr45nb1rFGiLIlAxNE/WNZdZbV1mM3ZnQgZh6iYC6Ydc9czfB
 ZDaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSAxWk9yNbKheEb+VrgLpW0oOYd55MGfNHBcL1vMpmJJ8idCrAqnZrR1WE0uEbcXaq0rgYIZcpj7My@nongnu.org
X-Gm-Message-State: AFuF++ksNUELjeU6Kshh8Eg8XUgfBoysbnyrzEkKJUQosWZEPFz6MMm5
 sfCf9cDGKTJDc8YIA6lt3rBZ5JrTgZAPvTNvkKHK95Ds92v21jpo8IaQzmWer7AN5g==
X-Gm-Gg: AYBFou1FYsZFyHsfL7EoBw1MTA6qmWiXkmhthlWXr+5cQe8dqUthOOsZxoNLQf2CX5x
 TSIAS7blJmokMZqcw8HyDhsVUgDyS+2esgRILIugvUYztVcRCw88yjAfZyNYH6PFdHpw7SlmrQ0
 ZunbCCxjbnbUwr5d2g3UKCUbwzuY2vZllg87nZd+sbsgXtxYEaHoaRZtFQ7h6o89oZLS4lX+XIn
 lPBeVFhFIFlGCQ4xSfLYBejf/DqhyP0r0EC3y84wAMHYetmbFkl3mhMpXcscFOU3h48bujXERF8
 MZFVeK+/DYsvCNk0f3BMEvuC5h7TGGFbFxGGfpxkspfA3CimWfhNF3oFnbBrk5OpeJTy3Ygg7Nz
 lmkvi+3hm+PXY2xGPOvv+ZG7aSxNaZDKbNDsV7ZmKmAXQt20rCO4ovtREGjCemMsHEuD8qfKm7i
 DV/GJA4bhKtLQyxiV/y0C8JMSnUsIO3Tl9LFO/zNB3VP9c1ZIO2skY7G3fOVMSkQ+RZJFnblDnk
 N4xFdNOpc4YyDBDdY7kW5jLgfjlAg==
X-Received: by 2002:aa7:c417:0:b0:6a6:32f6:2841 with SMTP id
 4fb4d7f45d1cf-6a66a293d1cmr52768a12.14.1788270504403; 
 Tue, 01 Sep 2026 06:48:24 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee0b330sm592472866b.1.2026.09.01.06.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:48:23 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:48:19 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 03/28] hw/arm/smmuv3: Thread SEC_SID through helper APIs
Message-ID: <apbXozA1-F-FniKI@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813162410.2805113-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=smostafa@google.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Aug 14, 2026 at 12:24:08AM +0800, Tao Tang wrote:
> Extend the register and queue helper routines to accept an explicit
> SEC_SID argument instead of hard-coding the non-secure bank.
> 
> All existing callers are updated to pass SMMU_SEC_SID_NS, so the
> behavior remains identical. This prepares the code for handling
> additional security state banks in the future. So Non-secure state
> is the only state bank supported for now.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> Link: https://lore.kernel.org/qemu-devel/3097d58e-3793-4434-8beb-2e4f4c52f772@redhat.com/
> ---
>  hw/arm/smmuv3-accel.c    |  5 +++--
>  hw/arm/smmuv3-internal.h | 21 +++++++++------------
>  hw/arm/smmuv3.c          | 15 ++++++++-------
>  3 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 3ff3da66acd..fa079c8acea 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -294,6 +294,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>      SMMUS1Hwpt *s1_hwpt = NULL;
>      const char *type;
>      STE ste;
> +    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>  
>      if (!accel || !accel->viommu) {
>          return true;
> @@ -323,7 +324,7 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>       * attach/alloc fails, since the Guest–Host SID mapping stays
>       * valid as long as the device is behind the accelerated SMMUv3.
>       */
> -    if (!smmu_enabled(s)) {
> +    if (!smmu_enabled(s, sec_sid)) {
>          hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
>      } else {
>          config = STE_CONFIG(&ste);
> @@ -558,7 +559,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
>          return true;
>      }
>  
> -    if (!smmuv3_eventq_enabled(s)) {
> +    if (!smmuv3_eventq_enabled(s, sec_sid)) {
>          return true;
>      }
>  
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 10154ca161d..a88743ba9cd 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -39,9 +39,8 @@ typedef enum SMMUTranslationClass {
>      SMMU_CLASS_IN,
>  } SMMUTranslationClass;
>  
> -static inline int smmu_enabled(SMMUv3State *s)
> +static inline int smmu_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->cr[0], CR0, SMMUEN);
>  }
> @@ -69,16 +68,16 @@ static inline uint32_t smmuv3_idreg(int regoffset)
>      return smmuv3_ids[regoffset / 4];
>  }
>  
> -static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s,
> +                                             SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
>  }
>  
> -static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s,
> +                                             SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
>  }
> @@ -123,23 +122,21 @@ static inline void queue_cons_incr(SMMUQueue *q)
>      q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
>  }
>  
> -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->cr[0], CR0, CMDQEN);
>  }
>  
> -static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_eventq_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->cr[0], CR0, EVENTQEN);
>  }
>  
> -static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
> +static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type,
> +                                       SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      bank->cmdq.cons = FIELD_DP32(bank->cmdq.cons, CMDQ_CONS, ERR, err_type);
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index d3baae8a32a..51e970d710a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -60,7 +60,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>  
>      switch (irq) {
>      case SMMU_IRQ_EVTQ:
> -        pulse = smmuv3_eventq_irq_enabled(s);
> +        pulse = smmuv3_eventq_irq_enabled(s, sec_sid);
>          break;
>      case SMMU_IRQ_PRIQ:
>          qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
> @@ -80,7 +80,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>          bank->gerror ^= new_gerrors;
>          trace_smmuv3_write_gerror(new_gerrors, bank->gerror);
>  
> -        pulse = smmuv3_gerror_irq_enabled(s);
> +        pulse = smmuv3_gerror_irq_enabled(s, sec_sid);
>          break;
>      }
>      }
> @@ -156,7 +156,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
>      SMMUQueue *q = &bank->eventq;
>      MemTxResult r;
>  
> -    if (!smmuv3_eventq_enabled(s)) {
> +    if (!smmuv3_eventq_enabled(s, sec_sid)) {
>          return MEMTX_ERROR;
>      }
>  
> @@ -191,8 +191,9 @@ void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
>  void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>  {
>      Evt evt = {};
> +    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>  
> -    if (!smmuv3_eventq_enabled(s)) {
> +    if (!smmuv3_eventq_enabled(s, sec_sid)) {
>          return;
>      }
>  
> @@ -1127,7 +1128,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>  
>      qemu_mutex_lock(&s->mutex);
>  
> -    if (!smmu_enabled(s)) {
> +    if (!smmu_enabled(s, sec_sid)) {
>          if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
>              status = SMMU_TRANS_ABORT;
>          } else {
> @@ -1357,7 +1358,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>      SMMUQueue *q = &bank->cmdq;
>      SMMUCommandType type = 0;
>  
> -    if (!smmuv3_cmdq_enabled(s)) {
> +    if (!smmuv3_cmdq_enabled(s, sec_sid)) {
>          return 0;
>      }
>      /*
> @@ -1617,7 +1618,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>  
>      if (cmd_error) {
>          trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
> -        smmu_write_cmdq_err(s, cmd_error);
> +        smmu_write_cmdq_err(s, cmd_error, sec_sid);
>          smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
>      }
>  
> -- 
> 2.34.1
> 

