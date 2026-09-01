Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C70BC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1PYP-0001qd-5D; Tue, 01 Sep 2026 10:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1PYM-0001pu-W5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:33:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1PYK-000413-Qz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:33:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4996e2575dbso58035e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788273211; x=1788878011; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3dx06ZQ88A8yshj8imQPf1gLzKKQA0hwr+mNSgHM4xU=;
 b=Qk9e/YRlHzBfShb1u6YLg6ufEAuyjVEbPj2DINiW2dJASeP9rJzhIOLgJuuyFxbrur
 4nVcEBWijKXSGygLN8Bp8AgddwgQ/4qWfYCN0oPYCONylEmtWYXd06AiBaws+30dFGft
 17GZO7DYx60IB5/bmdaQDCz/giDbt+EqU7aFY15Hcf8lr1KyzWpVeUHmSzPvEYP8Rj2P
 T7zc5/l+OaItZw+WxSQTXVSKJWxDpjOcSe6NqHHK0LQiaho2S//Z/DjT+yii7lDi1982
 SsO2bJP8+5MONWEDBwy86ET/4fU1+kmQoBE5RRE0tfJQ1cPjMDj3XZOs//lgBPuAjpxo
 iRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273211; x=1788878011;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3dx06ZQ88A8yshj8imQPf1gLzKKQA0hwr+mNSgHM4xU=;
 b=Lmc+Oql5QTdTO5bNwNcmZJQhacMCsTw5u4OEeVVjAxUgEqsfAFqGZ88dY4wJnyxyFL
 NenBk5vAmoG/Q4LYWah84WE0ff5/ChmXhLyqGQJRgYMiJog6/eKDv/CHYxw/voxuQt05
 XzzHyho+xPOAhbHEX0AEQUC3SjqHjEr7MGdsniGDnqox9+SqB23IcbJV2yIDo6xL4xOj
 gSN0caIfLuhIK0vTeMY6zTwe+386rz+gns434KW/lcDsTbSDzilAdR9Rmf0ghtr4SeRk
 ia+9aBNjznVLE7rctdJ6aY2TTnwZ6ayp1M6XWM11YNm4P5rI+CJbZBYwxsA3pXo19I0S
 5xVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmCak1ypJo7HWjU1yKYzZyfIvukpVKyoCcI/HMvAlsBJEY8Ws5aPd4+oHwz+HaXTgbWxwgDBXfswpU@nongnu.org
X-Gm-Message-State: AFuF++nCySZ5bG6Cp53uPTLxFMf5yeLcb8yzJg8GtV18ZxGYMw4WmkrQ
 Tl6GDixGsWu4utI0GCb495s4AiLuuWXVNBm3INXK3+UvIp4gWsKAEgkqrzaiBgLSFw==
X-Gm-Gg: AR+sD11ajZt10iTEYe8gL8m/rTnw89dPn9tiG+NIKb/BPtAFC+JAboA/y5tAewjQ46o
 nOpWLglyLJzfQAi/nLdgk8rEU8v3yS2+nuZCl9DntnniGix+f2j6vUH/5u1t6a+cCzSGVvU5Vkm
 coWeqnwtDIcxWoDoYW+2/0PKDZYrS0owLNgj0bHeLQKEMBoU9/P4IVOYmK/8exlvcRp9OPUOTtJ
 ftQmJIfiaNEAw0O5+dUL6hvuKku0cCYJEpLW6xyoEoa5+Z7k5dOpgZlQigoLnUNxBFaEIe9ZjoS
 BpwuF27fSp2BpmeAjohRqbItn9gntKAo95nnuam3U5Yegscrn+TPH3XcTZSa1mDQ7ST71i+V1Y6
 tQuDUU7jOLyU6B7vekuQ0k0and+JBPXItV5j7Tiiu696oDZcmpmGp5/xOMB2mSA/5j4xXSa0DNP
 Wjg7J/26YrjQLca4d1glxdeXd9zjPWL3A1fvod7veS+Doj/h1J0JfG5RzsTG2mgTnU31rwP/NyI
 iZAYmvi3yq938WUgUlbIpjqJZMHtQ==
X-Received: by 2002:a05:600c:c088:b0:499:c4db:2ea9 with SMTP id
 5b1f17b1804b1-49cde7bdfaamr576235e9.9.1788273210263; 
 Tue, 01 Sep 2026 07:33:30 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d36e9csm5660424f8f.3.2026.09.01.07.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:33:27 -0700 (PDT)
Date: Tue, 1 Sep 2026 14:33:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 20/28] hw/arm/smmuv3: Route IRQ and GERROR handling by
 SEC_SID
Message-ID: <apbiMt6x_PUrhluf@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-5-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162558.2808607-5-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=smostafa@google.com; helo=mail-wm1-x333.google.com
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

On Fri, Aug 14, 2026 at 12:25:58AM +0800, Tao Tang wrote:
> Interrupt and global error handling currently always selects the
> Non-secure register bank, even when the event or command originates
> from the Secure programming interface. This splits CMDQ_CONS.ERR from
> GERROR.CMDQ_ERR and prevents Secure software from acknowledging the
> error through S_GERRORN.
> 
> Pass SEC_SID through the IRQ and GERROR helpers and all queue call
> sites so interrupt enable checks, global error reporting, and
> acknowledgement use the originating programming-interface bank.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b36bc4a54e0..d69fc0898af 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -49,11 +49,11 @@
>   *
>   * @irq: irq type
>   * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
> + * @sec_sid: security state of the programming interface
>   */
>  static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
> -                               uint32_t gerror_mask)
> +                               uint32_t gerror_mask, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>  
>      bool pulse = false;
> @@ -90,9 +90,9 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
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
> @@ -173,7 +173,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>      }
>  
>      if (!smmuv3_q_empty(q)) {
> -        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0, sec_sid);
>      }
>      return MEMTX_OK;
>  }
> @@ -187,7 +187,8 @@ void smmuv3_propagate_event(SMMUv3State *s, Evt *evt, SMMUSecSID sec_sid)
>      QEMU_LOCK_GUARD(&s->mutex);
>      r = smmuv3_write_eventq(s, sec_sid, evt);
>      if (r != MEMTX_OK) {
> -        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
> +                           R_GERROR_EVENTQ_ABT_ERR_MASK, sec_sid);
>      }
>  }
>  
> @@ -1645,7 +1646,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>          switch (type) {
>          case SMMU_CMD_SYNC:
>              if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
> -                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
> +                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0, sec_sid);
>              }
>              break;
>          case SMMU_CMD_PREFETCH_CONFIG:
> @@ -1879,7 +1880,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>      if (cmd_error) {
>          trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
>          smmu_write_cmdq_err(s, cmd_error, sec_sid);
> -        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
> +                           R_GERROR_CMDQ_ERR_MASK, sec_sid);

Won't we need a new line for the secure smmu instead of sharing
the same one in this function "qemu_irq_pulse(s->irq[irq])"?
The spec says:
	The SMMU has the following interrupt sources. Depending on the
	implementation, each interrupt source asserts a wired interrupt
	output that is unique to the source, or sends an MSI, or both.
		- Event queue
		- Secure Event queue

The way I read it, they have to be different.

Thanks,
Mostafa

>      }
>  
>      trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
> @@ -1996,7 +1998,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          bank->irq_ctrl = data;
>          break;
>      case A_GERRORN:
> -        smmuv3_write_gerrorn(s, data);
> +        smmuv3_write_gerrorn(s, data, reg_sec_sid);
>          /*
>           * By acknowledging the CMDQ_ERR, SW may notify cmds can
>           * be processed again
> -- 
> 2.34.1
> 

