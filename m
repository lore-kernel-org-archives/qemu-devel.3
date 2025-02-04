Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74062C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMk6-0006Lu-ET; Tue, 04 Feb 2025 12:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tfMk4-0006Li-40
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:29:44 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1tfMk1-0005EO-UN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:29:43 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so47999426d6.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738690179; x=1739294979; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BAfNmL7y6wqJRaNH76LKIZ30Wit9wiWMhdHHjS65G34=;
 b=BNeAVXbVOlyPsaTXMMmqDot+W8GgiCXTxTTTvia+l+hJ5T03OumjHYucIe5LfOvgVS
 /bvr7V2yPZYDArWr/J6QfvyUSCZaHsCa2e2DbKuc+ipXTXtTeIA204LI5SGbUrZCCsQm
 ITN+kRN/VlxCJiA8CW6kDOBPMuDTRyJTc4jtr0lFzrC4UdrleOwCB84CgWvXUD3EQZvt
 +9xhsiTFDsJ14W3sID2OQI0VcPwCtoQlCjFC66PbWoqJMpoY6FsptjdH9JXMs/W/gHdr
 Y8Lxm33txg7oAC3N/X2iEFy4wAm1YF/IBGWknK8UvJ2Yd1SZOln4xsT9pWXR2IjT2oSG
 t0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738690179; x=1739294979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAfNmL7y6wqJRaNH76LKIZ30Wit9wiWMhdHHjS65G34=;
 b=ZhxXeiv+uV8XNfM6Envsao/njtugwzbX78xaw6V30gCYFS67zm6Lby6xu1MHVW0aZT
 0MZ6J45rRQPBaNROBGnGkgx3og5CDNgbjo+r63LG5BWFhuqv2iuZQdQgiyqlSDawfgdp
 CfDikC6Ah1DfI3JqmUTqhvW65bFm9Ds+WkX9zs+DwKTp4o2pQx/Jzl9JsFMMhpXvtpx0
 m0KDRI4450nZO85bwIXz0DyMZIwjHxjYUTsvwLC/KwTOICaMVqhtesv7jwBFrn4dncT1
 zgm2nGpbZLiCgdVwtZqBbRvtEPyn2uAoW830EGOhpHrgWR5xIp7f7jNf9JbwtiPIDLCZ
 2X5g==
X-Gm-Message-State: AOJu0YzObOZGfpP9aC9xu/PyWpEznJRRxxDj1K5ssgiGZLT0JjbVGM0N
 DhMMzBD3gjA4p0u3uQKmtH9uVLUpzuP/Q4uNL7CQDBpDWgpdLAPO7UapLQ==
X-Gm-Gg: ASbGncsk0KLHcNaP/vLD8lpjDvo1q79UC0S25D74S7Khd0po/9x7G8oCT/njrcDuIm6
 pN6dzfH6D6qVBpyQojXgPf82wSDrkMjyFrHtWUeBZNdZwHjzwAARqQpjXL/BWKec5cHQklH+2So
 pvd1mVacHyKGMkY5O3u3DFBF2Bpvr5+UqQRIlXvIqsBcg2dRUTuR1pIaqP5to8b+uTzwQNj8xkP
 nyjoQpMZe5EEFzUT/oZmEE4ibN7C4CVLKzh+nV+vl1WiZlVw5PPcS+0cBQ2Apy3zyHnpu+SjMi9
 50qrQjFoxZ2gj1Tdof8=
X-Google-Smtp-Source: AGHT+IEzVSoodXM/NCXHXNDDu+T9eC6RNtpXM2WfpfVSvj6NLj+iqlBUqHhss1en6YCgO1QSj6XV4w==
X-Received: by 2002:a05:6214:2607:b0:6e4:2b39:3602 with SMTP id
 6a1803df08f44-6e42b393b7amr29048936d6.15.1738690179206; 
 Tue, 04 Feb 2025 09:29:39 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f0e00sm64203856d6.24.2025.02.04.09.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:29:38 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 4 Feb 2025 17:29:35 +0000
To: Sweta Kumari <s5.kumari@samsung.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 1/1] Added support for get/set alert configuration commands
Message-ID: <Z6JOfy74ujK6r_UB@smc-140338-bm01>
References: <20250203114445.64088-1-s5.kumari@samsung.com>
 <CGME20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611@epcas5p3.samsung.com>
 <20250203114445.64088-2-s5.kumari@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203114445.64088-2-s5.kumari@samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=nifan.cxl@gmail.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 03, 2025 at 05:14:45PM +0530, Sweta Kumari wrote:
> Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
Hi Sweta,
Since this series only have one patch, you do not need a cover letter.
Move the commit comment in the first patch to this one and remove the
first one.

Fan
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 91 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 20 ++++++++
>  include/hw/cxl/cxl_device.h | 24 ++++++++++
>  3 files changed, 135 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..7a054c059d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -86,6 +86,9 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_ALERT_CONFIGURATION 0x1
> +        #define SET_ALERT_CONFIGURATION 0x2
>      SANITIZE    = 0x44,
>          #define OVERWRITE     0x0
>          #define SECURE_ERASE  0x1
> @@ -1625,6 +1628,90 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.1 Section 8.2.9.9.3.2 Get Alert Configuration (Opcode 4201h) */
As mentioned by Jonathan, use r3.2.
> +static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLCCI *cci)
The code indent here is not right.
+static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)

> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLAlertConfig *out = (void *)payload_out;
> +    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
> +    *len_out = sizeof(ct3d->alert_config);
> +    return CXL_MBOX_SUCCESS;
> +
> +}
> +
> +/* CXL r3.1 Section 8.2.9.9.3.3 Set Alert Configuration (Opcode 4202h) */
> +static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLCCI *cci)
indent issue.

Fan
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
> +    struct {
> +        CXLValidEnableAlerts valid_alert_actions;
> +        CXLValidEnableAlerts enable_alert_actions;
> +        uint8_t lupwt;
> +        uint8_t reserve;
> +        uint16_t dotpwt;
> +        uint16_t dutpwt;
> +        uint16_t cvmepwt;
> +        uint16_t cpmepwt;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +
> +    if (in->valid_alert_actions.lupwt) {
> +        if ((in->lupwt > 100) || (in->lupwt >= alert_config->lucat)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +
> +        if (in->enable_alert_actions.lupwt) {
> +            alert_config->lupwt = in->lupwt;
> +        }
> +        alert_config->enable_alerts.lupwt = in->enable_alert_actions.lupwt;
> +    }
> +
> +    if (in->valid_alert_actions.dotpwt) {
> +        if (in->dotpwt >= alert_config->dotcat) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        if (in->enable_alert_actions.dotpwt) {
> +            alert_config->dotpwt = in->dotpwt;
> +        }
> +        alert_config->enable_alerts.dotpwt = in->enable_alert_actions.dotpwt;
> +    }
> +
> +    if (in->valid_alert_actions.dutpwt) {
> +        if (in->dutpwt < alert_config->dutcat) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        if (in->enable_alert_actions.dutpwt) {
> +            alert_config->dutpwt = in->dutpwt;
> +        }
> +        alert_config->enable_alerts.dutpwt = in->enable_alert_actions.dutpwt;
> +    }
> +
> +    if (in->valid_alert_actions.cvmepwt) {
> +        if (in->enable_alert_actions.cvmepwt) {
> +            alert_config->cvmepwt = in->cvmepwt;
> +        }
> +        alert_config->enable_alerts.cvmepwt = in->valid_alert_actions.cvmepwt;
> +    }
> +
> +    if (in->valid_alert_actions.cpmepwt) {
> +        if (in->enable_alert_actions.cpmepwt) {
> +            alert_config->cpmepwt = in->cpmepwt;
> +        }
> +        alert_config->enable_alerts.cpmepwt = in->valid_alert_actions.cpmepwt;
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* Perform the actual device zeroing */
>  static void __do_sanitization(CXLType3Dev *ct3d)
>  {
> @@ -2859,6 +2946,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>          ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
> +    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIGURATION] = {"GET_ALERT_CONFIGURATION",
> +        cmd_get_alert_config, 0, 0 },
> +    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIGURATION] = {"SET_ALERT_CONFIGURATION",
> +        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>      [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
>          (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>           CXL_MBOX_SECURITY_STATE_CHANGE |
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5f365afb4d..ce5a4962da 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -956,6 +956,25 @@ static DOEProtocol doe_comp_prot[] = {
>      { }
>  };
>  
> +/*
> + * Initialize CXL device alerts with default threshold values.
> + */
> +static void init_alert_config(CXLType3Dev *ct3d)
> +{
> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
> +
> +    memset(&alert_config->valid_alerts, 0, sizeof(CXLValidEnableAlerts));
> +    memset(&alert_config->enable_alerts, 0, sizeof(CXLValidEnableAlerts));
> +    alert_config->lucat = 75;
> +    alert_config->lupwt = 0;
> +    alert_config->dotcat = 35;
> +    alert_config->dutcat = 10;
> +    alert_config->dotpwt = 25;
> +    alert_config->dutpwt = 20;
> +    alert_config->cvmepwt = 0;
> +    alert_config->cpmepwt = 0;
> +}
> +
>  void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -1030,6 +1049,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
>          goto err_free_special_ops;
>      }
>  
> +    init_alert_config(ct3d);
>      pcie_cap_deverr_init(pci_dev);
>      /* Leave a bit of room for expansion */
>      rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25..6acae7d74d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -581,6 +581,28 @@ typedef struct CXLSetFeatureInfo {
>      size_t data_size;
>  } CXLSetFeatureInfo;
>  
> +typedef struct CXLValidEnableAlerts {
> +    uint8_t lupwt:1;
> +    uint8_t dotpwt:1;
> +    uint8_t dutpwt:1;
> +    uint8_t cvmepwt:1;
> +    uint8_t cpmepwt:1;
> +    uint8_t reserved:3;
> +} CXLValidEnableAlerts;
> +
> +typedef struct CXLAlertConfig {
> +    CXLValidEnableAlerts valid_alerts;
> +    CXLValidEnableAlerts enable_alerts;
> +    uint8_t lucat;
> +    uint8_t lupwt;
> +    uint16_t dotcat;
> +    uint16_t dutcat;
> +    uint16_t dotpwt;
> +    uint16_t dutpwt;
> +    uint16_t cvmepwt;
> +    uint16_t cpmepwt;
> +} QEMU_PACKED CXLAlertConfig;
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -605,6 +627,8 @@ struct CXLType3Dev {
>      CXLCCI vdm_fm_owned_ld_mctp_cci;
>      CXLCCI ld0_cci;
>  
> +    CXLAlertConfig alert_config;
> +
>      /* PCIe link characteristics */
>      PCIExpLinkSpeed speed;
>      PCIExpLinkWidth width;
> -- 
> 2.34.1
> 

-- 
Fan Ni (From gmail)

