Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E03C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1PG4-0005M7-Js; Tue, 01 Sep 2026 10:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1PG2-0005LK-LS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:14:38 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1PG0-0008GV-Dn
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:14:38 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a5dce0aacdso11106a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788272074; x=1788876874; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ORN0TMZisVC23muS1c3JYxzcPdyL+MIULjxNmGOBbV8=;
 b=pdeMVzFaKN0BvlDv68EpSR1jEJvN4Lzc1e92h356LGUBlVXbn60/OOyVLc8nmv/Oq/
 gV/IPo7ufqmCQijymowI/szg0ODvirhrbKKLlQC+icIWXnzK8DWTEY2c9u0SS4TYW027
 jxqQdwgFNAs311nz1Vq9/RIRlBKXrqn2kca7OB1WMQJi0RZGqW4SuJEjrS5WEeuLi+CA
 BMtQsiP+Ehz6PSrYp5YZo7TqI1URWKHy/MKKp862s/F40rHbBxYokTBlcFeO/wWjfhfN
 ZFGHw5KS0A9LjjrFyMT/18LrLgygjiJIpKefnw3EzvbkYspYqusSTKQhYtcd62UI1Kiu
 k0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788272074; x=1788876874;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ORN0TMZisVC23muS1c3JYxzcPdyL+MIULjxNmGOBbV8=;
 b=OmfoGgkIWBVeaxPklPP9gLvqMaBz+bWpqxWBzZr3HZ9mVoAdQ5hwJ8gWT1afFtHMkE
 mKrcAWeH9NkYNP4L/lHbkmBxtFS9Xaun5lAi8DbEULp9rNbs4C5EtpvqVRuWB3vTyCKm
 UAd6h1KxlduIcydzxmj9fdn6DOtC8Hu9oibb3QyKQMu2bSL/ZnRySV9Hf6DftlC7VWgn
 AnrQbSkJ/h5hOn8Suz6bfXFMV6bUbWN99ISlu+HKMlGOJ3b9M9Ha9N7gKy0ET4jjPpxR
 7hLnTfQa7O5XEyCzSwD2HGo1tDq2mervcgL3P9UrpKsICKTrzMkN+eZLc1ed9ruKogy6
 rK2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6/JMFKqGg6zePTbZrApEXOwyU7P7MmIBVkAusfa5UMjh4EK2eo1DB0zLKZcrMcS/ciYnU+XRHMDRH@nongnu.org
X-Gm-Message-State: AFuF++mH/sjdInHQP/GfjZq7G3dgL9f9Inco4IbWKzPah6agm0egFSn4
 IeF8UHCe5ryu7/cCRvLzQn20bKoygieHe4HB2n+4SYqiOxxr90ZhZKJyJUP/VMcIhQ==
X-Gm-Gg: AYBFou2v3K6gBilAYxJtU/EHv1byNFJ9o9CGhm8sC/9sJJSOIMSEikTU57Vb1vdNdUv
 xdjyHX3remXnx+eNLfhVil5JbU8Q10/eVzZ65TmebTpxbWfO7BP3jzP8LUl0aCg299I2HV84WXh
 SQjSt5xic5HcZ8SqciaRZDnwcddCUKGHhlnohVmtD7GTw3+ngwBw6gboTRc2bLsb/py/19GVa+t
 XNGimumF8fgKvTZETxnRXUBvWl4lH297jMK+NCJNmI0eokT9lt0+l6/pDB5Wl/o/dkyCv4wqN7N
 J35fy/OpLmoB0PG+bcPtGG5UY4LeS1XAgaI2SdKRKm7zxeqgKWzcurGTgAMG56bfUS4f6MlHtoF
 vc/vl9Dp0MXuOSfgk3iiw7xQsALoD796dh9IRdQmadHqP5E45pIWwJvB/CstVQnofF4W9rrKhNz
 MqkpAAMBTAgGAetVz1XxC0hPWr8VWHtNNdz+nOeKVphYGiBzKOlQ3BRVlvOs+v9CJlCrW1ZMFcr
 x99D1K/tDwGqUcpxQm7oPPjJl8SRg==
X-Received: by 2002:a05:6402:c247:b0:6a6:32f5:b170 with SMTP id
 4fb4d7f45d1cf-6a66a19221cmr53548a12.14.1788272073531; 
 Tue, 01 Sep 2026 07:14:33 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a66cf4b582sm945404a12.18.2026.09.01.07.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:14:32 -0700 (PDT)
Date: Tue, 1 Sep 2026 14:14:28 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 13/28] hw/arm/smmuv3: Pass sec_sid into cmdq consume path
Message-ID: <apbdxGI0DrK8bsJX@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162512.2807281-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=smostafa@google.com; helo=mail-ed1-x530.google.com
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

On Fri, Aug 14, 2026 at 12:25:10AM +0800, Tao Tang wrote:
> Make smmuv3_cmdq_consume() security-state aware by passing sec_sid
> from smmu_writel() call sites (CR0/GERRORN/CMDQ_PROD paths), instead
> of hardcoding non-secure state. The related AddressSpace and MemTxAttrs
> are also obtained based on sec_sid.
> 
> Also move CMD_SSEC legality checking to a single early check before
> command dispatch: secure commands are rejected on non-secure queues
> (including future Realm queue) with CERROR_ILL. This removes duplicated
> per-command checks in CFGI handlers.
> 
> Finally, extend cmdq trace output with sec_sid so command processing
> can be correlated with the correct security bank.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  hw/arm/smmuv3.c     | 47 +++++++++++++++++++++------------------------
>  hw/arm/trace-events |  2 +-
>  2 files changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 087112ba4b6..fa13191fc3b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -112,14 +112,14 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>      trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
>  }
>  
> -static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd,
> +                                     AddressSpace *as, MemTxAttrs attrs)
>  {
>      dma_addr_t addr = Q_CONS_ENTRY(q);
>      MemTxResult ret;
>      int i;
>  
> -    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
> -                          MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_read(as, addr, cmd, sizeof(Cmd), attrs);
>      if (ret != MEMTX_OK) {
>          return ret;
>      }
> @@ -1391,14 +1391,15 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>      }
>  }
>  
> -static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
> +static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      SMMUQueue *q = &bank->cmdq;
>      SMMUCommandType type = 0;
> +    MemTxAttrs attrs = smmu_get_txattrs(sec_sid);
> +    AddressSpace *as = smmu_get_address_space(bs, sec_sid);
>  
>      if (!smmuv3_cmdq_enabled(s, sec_sid)) {
>          return 0;
> @@ -1413,19 +1414,30 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>      while (!smmuv3_q_empty(q)) {
>          uint32_t pending = bank->gerror ^ bank->gerrorn;
>          Cmd cmd;
> +        SMMUSecSID ssec = SMMU_SEC_SID_NS;
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
> +        if (queue_read(q, &cmd, as, attrs) != MEMTX_OK) {
>              cmd_error = SMMU_CERROR_ABT;
>              break;
>          }
>  
> +        ssec = CMD_SSEC(&cmd) ? SMMU_SEC_SID_S : SMMU_SEC_SID_NS;
> +        /*
> +         * A command with SSec == 1 is illegal on Non-secure and Realm Command
> +         * queues and raises CERROR_ILL, as specified by (IHI 0070G.b) 4.1.6.
> +         */
> +        if (ssec && sec_sid != SMMU_SEC_SID_S) {
> +            cmd_error = SMMU_CERROR_ILL;
> +            break;
> +        }
> +
>          type = CMD_TYPE(&cmd);
>  
>          trace_smmuv3_cmdq_opcode(smmu_cmd_string(type));
> @@ -1445,11 +1457,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>              uint32_t sid = CMD_SID(&cmd);
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>  
> -            if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> -            }
> -
>              if (!sdev) {
>                  break;
>              }
> @@ -1469,11 +1476,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>              uint8_t range = CMD_STE_RANGE(&cmd);
>              SMMUSIDRange sid_range;
>  
> -            if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> -            }
> -
>              mask = (1ULL << (range + 1)) - 1;
>              sid_range.start = sid & ~mask;
>              sid_range.end = sid_range.start + mask;
> @@ -1492,11 +1494,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>              uint32_t sid = CMD_SID(&cmd);
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>  
> -            if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> -            }
> -
>              if (!sdev) {
>                  break;
>              }
> @@ -1720,7 +1717,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          bank->cr[0] = data;
>          bank->cr0ack = data & ~SMMU_CR0_RESERVED;
>          /* in case the command queue has been enabled */
> -        smmuv3_cmdq_consume(s, &local_err);
> +        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>          if (local_err) {
>              error_report_err(local_err);
>              local_err = NULL;
> @@ -1743,7 +1740,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>           * By acknowledging the CMDQ_ERR, SW may notify cmds can
>           * be processed again
>           */
> -        smmuv3_cmdq_consume(s, &local_err);
> +        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>          break;
>      case A_GERROR_IRQ_CFG0: /* 64b */
>          bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
> @@ -1801,7 +1798,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          break;
>      case A_CMDQ_PROD:
>          bank->cmdq.prod = data;
> -        smmuv3_cmdq_consume(s, &local_err);
> +        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>          break;
>      case A_CMDQ_CONS:
>          bank->cmdq.cons = data;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 6a8716e8041..ccc0ab50164 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -36,7 +36,7 @@ smmuv3_trigger_irq(int irq) "irq=%d"
>  smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
>  smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
>  smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
> -smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
> +smmuv3_cmdq_consume(int sec_sid, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "sec_sid=%d prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
>  smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>  smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>  smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
> -- 
> 2.34.1
> 

