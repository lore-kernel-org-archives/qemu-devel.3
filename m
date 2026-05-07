Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EDECD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL28x-0001ec-O7; Thu, 07 May 2026 13:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL28r-0001d9-Tn
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL28l-0005No-RY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778173437;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBbDuAKWNq6vxsxytQTB6e1y0xj2M0FbXNW45x08AoE=;
 b=EP3TCHLr1EWWbhHChacYlNDM3jeV4jjxgn3X3V5DQryivuzzz7xcLjSlfnWu7nywRMAnva
 xfBuR1+d4yqRwh6KviuhqZ36v68yGrzbysRG3Q57bwU963IMQf82mzCmmeLNASZxZylEev
 8VUe7E5SLGknRWrXMUqqRoK8E1aSNXg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Myj3xN9DOj-nwE5OekcuvA-1; Thu, 07 May 2026 13:03:55 -0400
X-MC-Unique: Myj3xN9DOj-nwE5OekcuvA-1
X-Mimecast-MFC-AGG-ID: Myj3xN9DOj-nwE5OekcuvA_1778173434
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48d046fac74so6169565e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 10:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778173434; x=1778778234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBbDuAKWNq6vxsxytQTB6e1y0xj2M0FbXNW45x08AoE=;
 b=NTF+x5KIbtLXZRmDF32zBA8vbQsUt0ZierNPVqcyPMHLPpQZAQlmHIykc2y860c884
 wHfRALjh9i/KUZofNXUDhDdLRcfWeFIXTDSU4ll8MPyjaJ7W++vYykqTyMlDxZHARHvb
 2cjIsGhUyYhSBT6OujUm72tQsyxOpQeN1kKEyy0OA6OQ6wRtuWdOry2njVWQCud0zDU+
 d6DybFJ8/uBaJ1SREVSJ+/axiT1aHNy11te7m5GQ6mxxyxAJ9sIEqXDa55yrIxgbSxHQ
 DUX+N9yMxOP/i6B8WeLm/rLLL0iCW070MTVeV7oAUVC+oJlf6LiUiWdrX7asTUUCdN1U
 RkMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Rpd+9flL8d5/ImVVDoH0lIX8I8nNKq1Ulh/cBC2B/tTWq7dv0CobAmoCSbpsjsjxgymPWloLDfrZx@nongnu.org
X-Gm-Message-State: AOJu0YwVqs+WSWrTKTBTvX6DNAl/4U5vhjZ8lk+RQfhUxChnHaPKScKB
 afMz4TpsvwsCu4djTaZ46QM0TPrtqBNyAAkfCHW0c0B8hMiVxNrM6/rKhiXdwpug3gpLQlqhpuO
 wn/E81CY4HjWuezK2o26q/jSqS0YqBCo1YuCR9Y2MK6NRiP3JS9PYD33L
X-Gm-Gg: AeBDies6sG1UwesRXWPOhCL9wYpNzQZJDwwqWn5JOImDCjCtMiknFkBQ5UbRMNzMTY+
 EnJ2pRJDJCcDjAKtnKyXGYA98yy11AYQX6qBVa2fQUT/9i0UrTFXSv4sVXfScJa9SFB5Uohap1F
 kxE2bCa0GY+lqa0Sihccsoj82Dc0Ji44stCPg+IPCrTfAD+oHDEvVHn8AUYb8TMQXWl0nJH9MIr
 NyuVu7lJ0JhikKU/9WezuGJqGVeD1L4AtvpDzA750GCPM6WagI99RMB3xLU484x0JOf3i50z9hT
 SHqIcy6e35+4b/Pbgypd01M1bsVoZFMLvSU2UcSZYpRt2kKIOoFCWPqqwS7Fc1ORxtggPNT2h4w
 By0YBokJZqkZrvnQW705ViK60DmGN0/qYikPCJUv6vUwFmj+ghUy5/wrO6rr3RnNiBLNqug==
X-Received: by 2002:a05:600c:4512:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48e51f3a538mr142812175e9.21.1778173434186; 
 Thu, 07 May 2026 10:03:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4512:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48e51f3a538mr142811115e9.21.1778173433075; 
 Thu, 07 May 2026 10:03:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45412820303sm479472f8f.4.2026.05.07.10.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 10:03:52 -0700 (PDT)
Message-ID: <4fefb00e-44f3-42ca-8835-38e6bc731cb2@redhat.com>
Date: Thu, 7 May 2026 19:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/31] hw/arm/tegra241-cmdqv: Add reset handler
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-26-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-26-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Introduce a reset handler for the Tegra241 CMDQV and initialize its
> register state.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.h |  2 ++
>  hw/arm/tegra241-cmdqv.c | 50 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events     |  1 +
>  3 files changed, 53 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
> index 2befa6205e..b2a444daef 100644
> --- a/hw/arm/tegra241-cmdqv.h
> +++ b/hw/arm/tegra241-cmdqv.h
> @@ -79,6 +79,8 @@ FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
>  FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
>  FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
>  
> +#define V_CONFIG_RESET 0x00020403
please add a comment to explain what 

0x00020403 value means

Eric

> +
>  REG32(PARAM, 0x4)
>  FIELD(PARAM, CMDQV_VER, 0, 4)
>  FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 9c2fc02b92..af68add2f0 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu/log.h"
>  
>  #include "hw/arm/smmuv3.h"
> @@ -645,8 +646,57 @@ free_viommu:
>      return false;
>  }
>  
> +static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
> +{
> +    int i;
> +
> +    cmdqv->config = V_CONFIG_RESET;
> +    cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
> +    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_CMDQ_LOG2,
> +                              CMDQV_NUM_CMDQ_LOG2);
> +    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_SID_PER_VI_LOG2,
> +                              CMDQV_NUM_SID_PER_VI_LOG2);
> +    trace_tegra241_cmdqv_init_regs(cmdqv->param);
> +    cmdqv->status = R_STATUS_CMDQV_ENABLED_MASK;
> +    for (i = 0; i < 2; i++) {
> +        cmdqv->vi_err_map[i] = 0;
> +        cmdqv->vi_int_mask[i] = 0;
> +        cmdqv->cmdq_err_map[i] = 0;
> +    }
> +    cmdqv->cmdq_err_map[2] = 0;
> +    cmdqv->cmdq_err_map[3] = 0;
> +    cmdqv->vintf_config = 0;
> +    cmdqv->vintf_status = 0;
> +    for (i = 0; i < 4; i++) {
> +        cmdqv->vintf_cmdq_err_map[i] = 0;
> +    }
> +    for (i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
> +        cmdqv->cmdq_alloc_map[i] = 0;
> +        cmdqv->vcmdq_cons_indx[i] = 0;
> +        cmdqv->vcmdq_prod_indx[i] = 0;
> +        cmdqv->vcmdq_config[i] = 0;
> +        cmdqv->vcmdq_status[i] = 0;
> +        cmdqv->vcmdq_gerror[i] = 0;
> +        cmdqv->vcmdq_gerrorn[i] = 0;
> +        cmdqv->vcmdq_base[i] = 0;
> +        cmdqv->vcmdq_cons_indx_base[i] = 0;
> +    }
> +}
> +
>  static void tegra241_cmdqv_reset(SMMUv3State *s)
>  {
> +    SMMUv3AccelState *accel = s->s_accel;
> +    Tegra241CMDQV *cmdqv = accel->cmdqv;
> +
> +    if (!cmdqv) {
> +        return;
> +    }
> +
> +    tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
> +    tegra241_cmdqv_munmap_vintf_page0(cmdqv, NULL);
> +    tegra241_cmdqv_free_all_vcmdq(cmdqv);
> +
> +    tegra241_cmdqv_init_regs(s, cmdqv);
>  }
>  
>  static const MemoryRegionOps mmio_cmdqv_ops = {
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index fd6441bfa7..6f602b9eda 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -76,6 +76,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
>  tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
>  tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
>  tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
> +tegra241_cmdqv_init_regs(uint32_t param) "hw info received. param: 0x%04X"
>  
>  # strongarm.c
>  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"


