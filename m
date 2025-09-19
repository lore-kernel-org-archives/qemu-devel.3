Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5349DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWw4-0000OB-LO; Fri, 19 Sep 2025 04:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzWvz-00009J-Nc
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzWvl-0001AW-Mf
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758272238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bLCgiKFs8RH7Y30WzWkrtJBtQIBerk2lDcJW5T7DT6o=;
 b=d49DR9Jn+9B7XrxFEJTKk9KfYdpX+gsl2mfbOjY52w/P8JOY3pgIgj2fSla2YBiILsggM2
 Ewg2TmZWt9W8P9lCqBfvDdxJMhqdbPWCWlTDryvH12GTnQnmC3PW5qdcB+LkQzPmtT8heo
 Jn/AleFHVJN2bdGh71YcDXI9al/V/48=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-fZhCwAKCOGa1oGSYAuyGdQ-1; Fri, 19 Sep 2025 04:57:16 -0400
X-MC-Unique: fZhCwAKCOGa1oGSYAuyGdQ-1
X-Mimecast-MFC-AGG-ID: fZhCwAKCOGa1oGSYAuyGdQ_1758272236
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45dd5c1b67dso9444345e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 01:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758272235; x=1758877035;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bLCgiKFs8RH7Y30WzWkrtJBtQIBerk2lDcJW5T7DT6o=;
 b=ZhOeEx0nd9Z0ZN+sh0wzfCXyKXg2iSmlmsjEUD4S+ARueBN+xJXb2CqmvoyhV6IMiM
 1syz5wcz9QcBKd8wlmvegahQmtw4TVgfBKcOYFbhTfYV5dAWuZTYo5bP7p+UQJjGBSWS
 ERPkhDa3QkSFgxGTuPbRXUywDw9ohxnNF0Z04MKnOrkx3/8x8a1p+XwaEeIwsXnnzPxf
 77JY5L9wJl1MchJMudNf/bi93rQTT85CO5tbSIT6HUEwVWuRQxa/UN3QlO6GQyqH1YNM
 XO6sYfzIQGTu9qqN5WUJXfsIjl768MzHXmxam8RrNLXzyx7zvtCmRKlyIr3BC4fn7VBi
 yOag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGxit7Y6SfZIF7tXJXPKcx4IDaCDe+XWoAO1UubNRgxW6KFszkAUPktNbkTrhgXXWyDUAvySYo92JM@nongnu.org
X-Gm-Message-State: AOJu0YxfaC47fFO0wfQ2OZHuPAH4W6ux2mBTgzygpO9ooRRsFqLXJN0f
 KKaiRm21/CsnsFLPqRoqHIlYizS6IxelRvKPxz21ImMT6Dwzz2UsETSECzcDr9ecKb5NZLF2f2K
 8Wq4aYKPVYL1EM0zoNIEWOP2Tm3WaLn9TOIMPvCMuZbhCo2rGzmcrLX0r
X-Gm-Gg: ASbGncvZFM4LVldFLdxGr4xerKvWgDykM+3Kz6xVSF1BqO9mMS/sjxmAkPhSnx5/iwI
 UF2tV5Fl5WYUlHzuulw08kohFTb5WiWfpI+u8XWRk7YoDpBuA+APwXmhVThicHbQxPKQl39bJaV
 woshSDJmUILKqtMg84Bs+PkkXku9dFEWEHOZalwqWSmqQuvMFfjiFrbI5+kQ16QUoGqe4p7ivPp
 5wgeFYYFm7kgML6zituD2r7gqBFETkdrGtF1uNt+FFBqkYkfLVLhMYoS61eaJuBarXyyq3WtMM9
 QTSM4GYPQr/czpZb2gDNhbhAIiZz6NPFfmGUGSraNFKVLvnBm15odBErBzLS+QS2Cr2USPw3NJL
 kj4w=
X-Received: by 2002:a05:600c:1f0e:b0:45d:e211:da7d with SMTP id
 5b1f17b1804b1-467f3840538mr14649925e9.35.1758272235468; 
 Fri, 19 Sep 2025 01:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERpRPr2Pi5WvXHyETEkVu0MjWB20G8+vzB+MbADwJMXSmFUsdjNdHeRep0OMk3MpZDxlSaOg==
X-Received: by 2002:a05:600c:1f0e:b0:45d:e211:da7d with SMTP id
 5b1f17b1804b1-467f3840538mr14649535e9.35.1758272234966; 
 Fri, 19 Sep 2025 01:57:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613e754140sm114689255e9.21.2025.09.19.01.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 01:57:14 -0700 (PDT)
Message-ID: <b3c29c9c-f495-40f1-b04f-82c7ae41730a@redhat.com>
Date: Fri, 19 Sep 2025 10:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 10/14] hw/pci-host/aspeed: Add AST2700 PCIe
 config with dedicated H2X blocks
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
 <20250919032431.3316764-11-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919032431.3316764-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/19/25 05:24, Jamin Lin wrote:
> Introduce PCIe config (H2X) support for the AST2700 SoC.
> 
> Unlike the AST2600, the AST2700 provides three independent Root Complexes,
> each with its own H2X (AHB to PCIe bridge) register block of size 0x100.
> All RCs use the same MSI address (0x000000F0). The H2X block includes
> two different access paths:
> 
> 1. CFGI (internal bridge): used to access the host bridge itself, always
>     with BDF=0. The AST2700 controller simplifies the design by exposing
>     only one register (H2X_CFGI_TLP) with fields for ADDR[15:0], BEN[19:16],
>     and WR[20]. This is not a full TLP descriptor as in the external case.
>     For QEMU readability and code reuse, the model converts H2X_CFGI_TLP
>     into a standard TLP TX descriptor with BDF forced to 0 and then calls
>     the existing helpers aspeed_pcie_cfg_readwrite() and
>     aspeed_pcie_cfg_translate_write().
> 
> 2. CFGE (external EP access): used to access external endpoints. The
>     AST2700 design provides H2X_CFGE_TLP1 and a small FIFO at H2X_CFGE_TLPN.
>     For reads, TX DESC0 is stored in TLP1 and DESC1/DESC2 in TLPN FIFO
>     slots. For writes, TX DESC0 is stored in TLP1, DESC1/DESC2 in TLPN
>     FIFO[0..1], and TX write data in TLPN FIFO[2].
> 
> The implementation extends AspeedPCIECfgState with a small FIFO and index,
> wires up new register definitions for AST2700, and adds a specific ops
> table and class (TYPE_ASPEED_2700_PCIE_CFG). The reset handler clears the
> FIFO state. Interrupt and MSI status registers are also supported.
> 
> This provides enough modeling for firmware and drivers to use any of the
> three PCIe RCs on AST2700 with their own dedicated H2X config window,
> while reusing existing TLP decode helpers in QEMU.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/pci-host/aspeed_pcie.h |   3 +
>   hw/pci-host/aspeed_pcie.c         | 158 ++++++++++++++++++++++++++++++
>   2 files changed, 161 insertions(+)
> 
> diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
> index 5806505f30..be53ea96b9 100644
> --- a/include/hw/pci-host/aspeed_pcie.h
> +++ b/include/hw/pci-host/aspeed_pcie.h
> @@ -87,6 +87,7 @@ struct AspeedPCIERcState {
>   
>   /* Bridge between AHB bus and PCIe RC. */
>   #define TYPE_ASPEED_PCIE_CFG "aspeed.pcie-cfg"
> +#define TYPE_ASPEED_2700_PCIE_CFG TYPE_ASPEED_PCIE_CFG "-ast2700"
>   OBJECT_DECLARE_TYPE(AspeedPCIECfgState, AspeedPCIECfgClass, ASPEED_PCIE_CFG);
>   
>   struct AspeedPCIECfgState {
> @@ -98,6 +99,8 @@ struct AspeedPCIECfgState {
>   
>       const AspeedPCIERcRegs *rc_regs;
>       AspeedPCIERcState rc;
> +    uint32_t tlpn_fifo[3];
> +    uint32_t tlpn_idx;
>   };
>   
>   struct AspeedPCIECfgClass {
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index 788160d532..a757fd7ec8 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -338,6 +338,11 @@ static const TypeInfo aspeed_pcie_rc_info = {
>    * - Registers 0x00 - 0x7F are shared by both PCIe0 (rc_l) and PCIe1 (rc_h).
>    * - Registers 0x80 - 0xBF are specific to PCIe0.
>    * - Registers 0xC0 - 0xFF are specific to PCIe1.
> + *
> + * On the AST2700:
> + * - The register range 0x00 - 0xFF is assigned to a single PCIe configuration.
> + * - There are three PCIe Root Complexes (RCs), each with its own dedicated H2X
> + *   register set of size 0x100 (covering offsets 0x00 to 0xFF).
>    */
>   
>   /* AST2600 */
> @@ -367,6 +372,31 @@ REG32(H2X_RC_H_MSI_EN1,     0xE4)
>   REG32(H2X_RC_H_MSI_STS0,    0xE8)
>   REG32(H2X_RC_H_MSI_STS1,    0xEC)
>   
> +/* AST2700 */
> +REG32(H2X_CFGE_INT_STS,         0x08)
> +    FIELD(H2X_CFGE_INT_STS, TX_IDEL, 0, 1)
> +    FIELD(H2X_CFGE_INT_STS, RX_BUSY, 1, 1)
> +REG32(H2X_CFGI_TLP,         0x20)
> +    FIELD(H2X_CFGI_TLP, ADDR, 0, 16)
> +    FIELD(H2X_CFGI_TLP, BEN, 16, 4)
> +    FIELD(H2X_CFGI_TLP, WR, 20, 1)
> +REG32(H2X_CFGI_WDATA,       0x24)
> +REG32(H2X_CFGI_CTRL,        0x28)
> +    FIELD(H2X_CFGI_CTRL, FIRE, 0, 1)
> +REG32(H2X_CFGI_RDATA,       0x2C)
> +REG32(H2X_CFGE_TLP1,        0x30)
> +REG32(H2X_CFGE_TLPN,        0x34)
> +REG32(H2X_CFGE_CTRL,        0x38)
> +    FIELD(H2X_CFGE_CTRL, FIRE, 0, 1)
> +REG32(H2X_CFGE_RDATA,       0x3C)
> +REG32(H2X_INT_EN,          0x40)
> +REG32(H2X_INT_STS,         0x48)
> +    FIELD(H2X_INT_STS, INTX, 0, 4)
> +REG32(H2X_MSI_EN0,          0x50)
> +REG32(H2X_MSI_EN1,          0x54)
> +REG32(H2X_MSI_STS0,         0x58)
> +REG32(H2X_MSI_STS1,         0x5C)
> +
>   #define TLP_FMTTYPE_CFGRD0  0x04 /* Configuration Read  Type 0 */
>   #define TLP_FMTTYPE_CFGWR0  0x44 /* Configuration Write Type 0 */
>   #define TLP_FMTTYPE_CFGRD1  0x05 /* Configuration Read  Type 1 */
> @@ -384,6 +414,15 @@ static const AspeedPCIERegMap aspeed_regmap = {
>       },
>   };
>   
> +static const AspeedPCIERegMap aspeed_2700_regmap = {
> +    .rc = {
> +        .int_en_reg     = R_H2X_INT_EN,
> +        .int_sts_reg    = R_H2X_INT_STS,
> +        .msi_sts0_reg   = R_H2X_MSI_STS0,
> +        .msi_sts1_reg   = R_H2X_MSI_STS1,
> +    },
> +};
> +
>   static uint64_t aspeed_pcie_cfg_read(void *opaque, hwaddr addr,
>                                        unsigned int size)
>   {
> @@ -606,6 +645,8 @@ static void aspeed_pcie_cfg_reset(DeviceState *dev)
>       AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
>   
>       memset(s->regs, 0, apc->nr_regs << 2);
> +    memset(s->tlpn_fifo, 0, sizeof(s->tlpn_fifo));
> +    s->tlpn_idx = 0;
>   }
>   
>   static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
> @@ -680,6 +721,122 @@ static const TypeInfo aspeed_pcie_cfg_info = {
>       .class_size = sizeof(AspeedPCIECfgClass),
>   };
>   
> +static void aspeed_2700_pcie_cfg_write(void *opaque, hwaddr addr,
> +                                       uint64_t data, unsigned int size)
> +{
> +    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(opaque);
> +    AspeedPCIECfgTxDesc desc;
> +    uint32_t reg = addr >> 2;
> +
> +    trace_aspeed_pcie_cfg_write(s->id, addr, data);
> +
> +    switch (reg) {
> +    case R_H2X_CFGE_INT_STS:
> +        if (data & R_H2X_CFGE_INT_STS_TX_IDEL_MASK) {
> +            s->regs[R_H2X_CFGE_INT_STS] &= ~R_H2X_CFGE_INT_STS_TX_IDEL_MASK;
> +        }
> +
> +        if (data & R_H2X_CFGE_INT_STS_RX_BUSY_MASK) {
> +            s->regs[R_H2X_CFGE_INT_STS] &= ~R_H2X_CFGE_INT_STS_RX_BUSY_MASK;
> +        }
> +        break;
> +    case R_H2X_CFGI_CTRL:
> +        if (data & R_H2X_CFGI_CTRL_FIRE_MASK) {
> +            /*
> +             * Internal access to bridge
> +             * Type and BDF are 0
> +             */
> +            desc.desc0 = 0x04000001 |
> +                (ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, WR) << 30);
> +            desc.desc1 = 0x00401000 |
> +                ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, BEN);
> +            desc.desc2 = 0x00000000 |
> +                ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, ADDR);
> +            desc.wdata = s->regs[R_H2X_CFGI_WDATA];
> +            desc.rdata_reg = R_H2X_CFGI_RDATA;
> +            aspeed_pcie_cfg_readwrite(s, &desc);
> +        }
> +        break;
> +    case R_H2X_CFGE_TLPN:
> +        s->tlpn_fifo[s->tlpn_idx] = data;
> +        s->tlpn_idx = (s->tlpn_idx + 1) % ARRAY_SIZE(s->tlpn_fifo);
> +        break;
> +    case R_H2X_CFGE_CTRL:
> +        if (data & R_H2X_CFGE_CTRL_FIRE_MASK) {
> +            desc.desc0 = s->regs[R_H2X_CFGE_TLP1];
> +            desc.desc1 = s->tlpn_fifo[0];
> +            desc.desc2 = s->tlpn_fifo[1];
> +            desc.wdata = s->tlpn_fifo[2];
> +            desc.rdata_reg = R_H2X_CFGE_RDATA;
> +            aspeed_pcie_cfg_readwrite(s, &desc);
> +            s->regs[R_H2X_CFGE_INT_STS] |= R_H2X_CFGE_INT_STS_TX_IDEL_MASK;
> +            s->regs[R_H2X_CFGE_INT_STS] |= R_H2X_CFGE_INT_STS_RX_BUSY_MASK;
> +            s->tlpn_idx = 0;
> +        }
> +        break;
> +
> +    case R_H2X_INT_STS:
> +        s->regs[reg] &= ~data | R_H2X_INT_STS_INTX_MASK;
> +        break;
> +    /*
> +     * These status registers are used for notify sources ISR are executed.
> +     * If one source ISR is executed, it will clear one bit.
> +     * If it clear all bits, it means to initialize this register status
> +     * rather than sources ISR are executed.
> +     */
> +    case R_H2X_MSI_STS0:
> +    case R_H2X_MSI_STS1:
> +        if (data == 0) {
> +            return ;
> +        }
> +
> +        s->regs[reg] &= ~data;
> +        if (data == 0xffffffff) {
> +            return;
> +        }
> +
> +        if (!s->regs[R_H2X_MSI_STS0] &&
> +            !s->regs[R_H2X_MSI_STS1]) {
> +            trace_aspeed_pcie_rc_msi_clear_irq(s->id, 0);
> +            qemu_set_irq(s->rc.irq, 0);
> +        }
> +        break;
> +    default:
> +        s->regs[reg] = data;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_2700_pcie_cfg_ops = {
> +    .read = aspeed_pcie_cfg_read,
> +    .write = aspeed_2700_pcie_cfg_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aspeed_2700_pcie_cfg_class_init(ObjectClass *klass,
> +                                            const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 PCIe Config";
> +    apc->reg_ops = &aspeed_2700_pcie_cfg_ops;
> +    apc->reg_map = &aspeed_2700_regmap;
> +    apc->nr_regs = 0x100 >> 2;
> +    apc->rc_msi_addr = 0x000000F0;
> +    apc->rc_bus_nr = 0;
> +}
> +
> +static const TypeInfo aspeed_2700_pcie_cfg_info = {
> +    .name = TYPE_ASPEED_2700_PCIE_CFG,
> +    .parent = TYPE_ASPEED_PCIE_CFG,
> +    .class_init = aspeed_2700_pcie_cfg_class_init,
> +};
> +
>   /*
>    * PCIe PHY
>    *
> @@ -847,6 +1004,7 @@ static void aspeed_pcie_register_types(void)
>       type_register_static(&aspeed_pcie_root_device_info);
>       type_register_static(&aspeed_pcie_root_port_info);
>       type_register_static(&aspeed_pcie_cfg_info);
> +    type_register_static(&aspeed_2700_pcie_cfg_info);
>       type_register_static(&aspeed_pcie_phy_info);
>       type_register_static(&aspeed_2700_pcie_phy_info);
>   }


