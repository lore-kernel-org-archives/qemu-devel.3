Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CC3C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1PKM-0006US-V2; Tue, 01 Sep 2026 10:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1PKM-0006UJ-6l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:19:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1x1PKJ-0000pZ-Il
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 10:19:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-498012a61f6so51255e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788272341; x=1788877141; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LFQm9x3Io7LbTU4H+xdgCppdZHTWlDVq/Gw5YajH9iA=;
 b=BN6iq7XRxWlbbRQpIm2Jzsnoy9FOv7BAlKao79d/zv2tRYbbdQrQpgUbTBvbAe+5LP
 UCEkpdI3ZG9w2JfMk6SPQVKZvrEyPHBOxbn43jHvs1mW2KSAjJIvhoDd5klcMgpUVZYW
 cDzJMsbMCWC9aj5Dh5Gq6S5tMbmIVkuF007g5brBXmXCdxSf1r0Yjk7XqAaj8SIdVq0n
 DxZWIg68slIFOEPuSLWiR2hRcjFqYQU+u/aKNx6RhC9dwMHKVUfBC0xRuUm8WI1x1ltC
 7mb6cX36EZvdMmm5jGrd8Nw0c3qg+YnJj5l5BYd0YBmacKF4+48m6uK7ZBrarD4V7r2e
 AY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788272341; x=1788877141;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LFQm9x3Io7LbTU4H+xdgCppdZHTWlDVq/Gw5YajH9iA=;
 b=cS7f3jzqfjfaVnF2ERBNDXZLpegJCUJpWbotrZKYzhyKbkP//zR4MoMv68PfkaYs4l
 R+sDcN3rq/Wu+RnOtCCGmXcdKPwOYq3T3TrApPksUacJI9P7VZ9g8cG2Mg3em2ggXRh7
 a6pl5rux+ftYySe/P3k0DGDzAflbcVmICOW9iP6cLs5hPVtEaDnSTOE7LOGkL2SJgE9Z
 e96SVUo+KzDwETy8gFL/mH7F/rXTdRm2F9ctVV5dVwchrPSwloNqlhTa7+iCz+9D9U2b
 Pk2DJ9pI1E7//1VPonksuDkNU38D5lYZhN2o7PDNCyouOYaTd3tTAkx9V985noW92Ox9
 oXaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmjatAChPEhekLd7hS+bRB0QmQV9T/VHv4jmSNgDlhqmeJ29EItWzrikfKETFnq0ZoV/c2GazTVmFr@nongnu.org
X-Gm-Message-State: AFuF++mACeXRLtOJSEyERWZW808p4Qgzd+7NNArNjSG5VHVIjxSdhu0f
 RCVpuauZq89TgoTIM1PrrciTbfPhmNGXwdRfZXNY6ZlnXBxCzCJdxw0DRXyN5OtHGg==
X-Gm-Gg: AR+sD10fKLwoCuLS7/zuuk8tfzyMhJ/NlMWtNtddz9CjVjSe242KzNGzJlmEkJknhKF
 uA2N7Qvx9cW7MHM/keoEGK30PnUPLWgSLaWxVUErDTJTeY+QqVefwK6YTc6FuEastPKPbOQ2DZX
 mjLjaEVZ5HURNPV9Nd68pCl5xhqcTjOfbXKp60fDB5mx9EfE65YOQHJljozCbioiGy9a5ODp6Fs
 RMIuZbQKg3rRH6CyXBdBZ7CR4d4YyPkUdrtPhtrB60/EWy387Phg8Tjya32iX8YahULb5SSDMK0
 HhIWauO1r1O4ViSXKPlyW7tbLg/FYi5RKm1N+LTefpiRKSZzinA8aItmJqN4KHCv7avNzcoe+3i
 BKo701kHy8Q3bg9/7O1exbckPRQ2e3plGEB27c4Y0vy24Y7Kjr/Q6WzQQHiytOwuqBUrF8NTdD3
 26P0KL4qI5ADhRm+42Rm/ZMHgHKJWh/A7rSP3yazQPQoBAjhPJOx0Su9okf3ZDUxF9A27Re7CVZ
 DZHwLfR+J6FkF/+D2OtO6dsHxXyRw==
X-Received: by 2002:a05:600c:5791:b0:49c:df56:d3ed with SMTP id
 5b1f17b1804b1-49cdf56d436mr549275e9.14.1788272340735; 
 Tue, 01 Sep 2026 07:19:00 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm773824135e9.2.2026.09.01.07.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:18:59 -0700 (PDT)
Date: Tue, 1 Sep 2026 14:18:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [RFC v5 16/28] hw/arm/smmuv3: Add access checks for
 GERROR_IRQ_CFG registers
Message-ID: <apbezrSgVeJy5w96@google.com>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162558.2808607-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=smostafa@google.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 14, 2026 at 12:25:54AM +0800, Tao Tang wrote:
> Add helpers that separate IRQ_CFG register presence from the runtime
> IRQ enable guard. The Non-secure and Secure GERROR_IRQ_CFG register sets
> both use SMMU_IDR0.MSI for presence, while writability additionally
> requires GERROR_IRQEN to be clear. IRQ_CTRL and IRQ_CTRLACK share one
> synchronous backing field in the current model.
> 
> Reads return RES0 when the register set is absent. Writes are ignored
> when it is absent or GERROR_IRQEN is set. Apply the same checks to all
> three GERROR_IRQ_CFG registers and mask reserved bits in CFG0 and CFG2.
> 
> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
> Fixes: 10a83cb9887e ("hw/arm/smmuv3: Skeleton")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 47f0d575817..628911d3f21 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1428,6 +1428,62 @@ smmu_cmdq_stage2_supported(SMMUv3State *s, SMMUSecSID sec_sid)
>      return true;
>  }
>  
> +/* Check whether the selected IRQ_CFG register set is present. */
> +static bool smmu_irq_cfg_present(SMMUv3State *s, SMMUSecSID sec_sid,
> +                                 SMMUIrq irq)
> +{
> +    SMMUv3RegBank *bank = smmuv3_bank(s, SMMU_SEC_SID_NS);
> +
> +    switch (irq) {
> +    case SMMU_IRQ_GERROR:
> +        switch (sec_sid) {
> +        case SMMU_SEC_SID_NS:
> +        case SMMU_SEC_SID_S:
> +            return FIELD_EX32(bank->idr[0], IDR0, MSI);

I am a bit confused about this, there is no configuration where this
is true?

Thanks,
Mostafa


> +        case SMMU_SEC_SID_NUM:
> +            g_assert_not_reached();
> +        }
> +        break;
> +    case SMMU_IRQ_EVTQ:
> +    case SMMU_IRQ_PRIQ:
> +    case SMMU_IRQ_CMD_SYNC:
> +        g_assert_not_reached();
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +/* Check whether the selected IRQ_CFG register set is writable. */
> +static bool smmu_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid,
> +                                  SMMUIrq irq)
> +{
> +    SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
> +    uint32_t irqen;
> +
> +    if (!smmu_irq_cfg_present(s, sec_sid, irq)) {
> +        return false;
> +    }
> +
> +    switch (irq) {
> +    case SMMU_IRQ_GERROR:
> +        irqen = FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
> +        break;
> +    case SMMU_IRQ_EVTQ:
> +    case SMMU_IRQ_PRIQ:
> +    case SMMU_IRQ_CMD_SYNC:
> +        g_assert_not_reached();
> +    }
> +
> +    /* IRQ_CTRL and IRQ_CTRLACK share one synchronous backing field. */
> +    return irqen == 0;
> +}
> +
> +static bool
> +smmu_gerror_irq_cfg_writable(SMMUv3State *s, SMMUSecSID sec_sid)
> +{
> +    return smmu_irq_cfg_writable(s, sec_sid, SMMU_IRQ_GERROR);
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1735,7 +1791,14 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>  
>      switch (offset) {
>      case A_GERROR_IRQ_CFG0:
> -        bank->gerror_irq_cfg0 = data;
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
> +                         "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        bank->gerror_irq_cfg0 = data & SMMU_GERROR_IRQ_CFG0_RESERVED;
>          return MEMTX_OK;
>      case A_STRTAB_BASE:
>          bank->strtab_base = data;
> @@ -1803,16 +1866,42 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>          break;
>      case A_GERROR_IRQ_CFG0: /* 64b */
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_GERROR_IRQ_CFG0_RESERVED;
>          bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
>          break;
>      case A_GERROR_IRQ_CFG0 + 4:
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 + 4 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_GERROR_IRQ_CFG0_RESERVED >> 32;
>          bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 32, 32, data);
>          break;
>      case A_GERROR_IRQ_CFG1:
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG1 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
>          bank->gerror_irq_cfg1 = data;
>          break;
>      case A_GERROR_IRQ_CFG2:
> -        bank->gerror_irq_cfg2 = data;
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_sid)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG2 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        bank->gerror_irq_cfg2 = data & SMMU_GERROR_IRQ_CFG2_RESERVED;
>          break;
>      case A_GBPA:
>          /*
> @@ -1938,6 +2027,11 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>  
>      switch (offset) {
>      case A_GERROR_IRQ_CFG0:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = bank->gerror_irq_cfg0;
>          return MEMTX_OK;
>      case A_STRTAB_BASE:
> @@ -2006,15 +2100,35 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>          *data = bank->gerrorn;
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0: /* 64b */
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = extract64(bank->gerror_irq_cfg0, 0, 32);
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0 + 4:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = extract64(bank->gerror_irq_cfg0, 32, 32);
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG1:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = bank->gerror_irq_cfg1;
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG2:
> +        if (!smmu_irq_cfg_present(s, reg_sec_sid, SMMU_IRQ_GERROR)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
>          *data = bank->gerror_irq_cfg2;
>          return MEMTX_OK;
>      case A_STRTAB_BASE: /* 64b */
> -- 
> 2.34.1
> 

