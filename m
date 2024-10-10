Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E7DD2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 23:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz2HQ-0000Xq-8n; Thu, 10 Oct 2024 19:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sz2HO-0000Xf-7N
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 19:09:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sz2HL-0003mO-S1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 19:09:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71dfccba177so2097951b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728601745; x=1729206545; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eoOIefwcl2zyGqbInaCBGQitWpP7kAS3EJcvu7ps+iU=;
 b=ljwjVZDyhdXgezmPbowMKe4JzM8j9eYBfylDwWmmZQ4bUxzEMzA8t/r2qgZpT3wFgQ
 E5NbE4+TOHap3plgpDIyl8HmLVXiDfE9leB1exY58DTG0lAABVFW+eRzLrTjBjvltuQX
 S/RMZp2Ltvsw3dEnvL5iRGcREX6y61nKfQnDmOOLCd4V5RMwwQVHs+RyAcFeSOGf2nTT
 6vnPDEhFi9g6oDjLWJr9QU3eOw/NxMBze4KdMvFx0sesuFYxBsJa71cn8IIy5/aRkzV/
 QoGqDqAmJdddpvDOCh1sPQABrgfrAWgXir7GNfHeCxzuYv5btLD/uBjcztyWKQEk2N31
 mp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728601745; x=1729206545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoOIefwcl2zyGqbInaCBGQitWpP7kAS3EJcvu7ps+iU=;
 b=q4murfEMPiVtb4wAofkYVEH57801J3SKP+aGGVT3JIP9EZY4qgcxTQolmmBTRB77yU
 4GQ/jMCFaQbjUbdIVB7encW0g6ZX14bTLhIB5OHFGkcM9YBmTSoU2mw65cbEikb7cFTv
 augT3UcGFO/A4ngGeJfN7+V4b1PcwMxs4U1iYTSNd+MRaWlmjVAO0xDngEfTozMEtbET
 F+XT1ASb5yeYQabYpCXBAC9D4tdH9G8aIiZswIk9iVbgn8qznEm3LyzZsVdjhBXG7rXj
 5b8yuRW8XdzwVt6iEzv4d9IQrJIwzs3kLPw8q0y5UBXzL8HV1yfmihVv7EOqAfa/KIJa
 x6QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4XvM5LkAyKytrKgNXbj+aqP9i4AKg9X9wC3/jAnUyAdfrBL35OAyN2xteH2BivHjbairllwe7+poM@nongnu.org
X-Gm-Message-State: AOJu0YxCElC5KXTY/RQIyDUADlHsIM0uS4fuayDio63hTjvpG+lTLT89
 hgiLWV53SQcHEkuQZgaVvxFYaXFpDIoG6/FZE97nq7VJ+Y2qXBaN
X-Google-Smtp-Source: AGHT+IEnssj6iLPq8FvP3tyJbWCzWYVHNFcOJBhMOpVp2twnK6mEBduZuY76xG+FeTMmbAdxBpA6uA==
X-Received: by 2002:a05:6a20:7f9f:b0:1d7:86c:189e with SMTP id
 adf61e73a8af0-1d8ae0cfe7amr7855544637.12.1728601745487; 
 Thu, 10 Oct 2024 16:09:05 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:c165:c800:4280:d79b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea44907c42sm1531066a12.39.2024.10.10.16.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 16:09:05 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 10 Oct 2024 16:08:51 -0700
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH -qemu] hw/cxl: Support get/set mctp response payload size
Message-ID: <Zwheg1hFMG_MYggX@fan>
References: <20241010014157.175548-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010014157.175548-1-dave@stgolabs.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42f.google.com
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

On Wed, Oct 09, 2024 at 06:41:57PM -0700, Davidlohr Bueso wrote:
> Add Get/Set Response Message Limit commands.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

The commit log may include the cxl spec reference. Otherwise,

Reviewed-by: Fan Ni <fan.ni@samsung.com>


> ---
>  hw/cxl/cxl-mailbox-utils.c | 68 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c2d776bc96eb..98416af794bb 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -7,6 +7,8 @@
>   * COPYING file in the top-level directory.
>   */
>  
> +#include <math.h>
> +
>  #include "qemu/osdep.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
> @@ -56,6 +58,8 @@ enum {
>      INFOSTAT    = 0x00,
>          #define IS_IDENTIFY   0x1
>          #define BACKGROUND_OPERATION_STATUS    0x2
> +        #define GET_RESPONSE_MSG_LIMIT   0x3
> +        #define SET_RESPONSE_MSG_LIMIT   0x4
>      EVENTS      = 0x01,
>          #define GET_RECORDS   0x0
>          #define CLEAR_RECORDS   0x1
> @@ -393,7 +397,7 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
>          uint16_t pcie_subsys_vid;
>          uint16_t pcie_subsys_id;
>          uint64_t sn;
> -    uint8_t max_message_size;
> +        uint8_t max_message_size;
>          uint8_t component_type;
>      } QEMU_PACKED *is_identify;
>      QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
> @@ -422,12 +426,58 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
>          is_identify->component_type = 0x3; /* Type 3 */
>      }
>  
> -    /* TODO: Allow this to vary across different CCIs */
> -    is_identify->max_message_size = 9; /* 512 bytes - MCTP_CXL_MAILBOX_BYTES */
> +    is_identify->max_message_size = (uint8_t)log2(cci->payload_max);
>      *len_out = sizeof(*is_identify);
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.1 section 8.2.9.1.3: Get Response Message Limit (Opcode 0003h) */
> +static CXLRetCode cmd_get_response_msg_limit(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t rsp_limit;
> +    } QEMU_PACKED *get_rsp_msg_limit = (void *)payload_out;
> +    QEMU_BUILD_BUG_ON(sizeof(*get_rsp_msg_limit) != 1);
> +
> +    get_rsp_msg_limit->rsp_limit = (uint8_t)log2(cci->payload_max);
> +
> +    *len_out = sizeof(*get_rsp_msg_limit);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.1 section 8.2.9.1.4: Set Response Message Limit (Opcode 0004h) */
> +static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t rsp_limit;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    QEMU_BUILD_BUG_ON(sizeof(*in) != 1);
> +    struct {
> +        uint8_t rsp_limit;
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    QEMU_BUILD_BUG_ON(sizeof(*out) != 1);
> +
> +    if (in->rsp_limit < 8 || in->rsp_limit > 10) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    cci->payload_max = 1 << in->rsp_limit;
> +    out->rsp_limit = in->rsp_limit;
> +
> +    *len_out = sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
>                                    void *private)
>  {
> @@ -3000,6 +3050,10 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>  
>  static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
>      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> +                                           cmd_get_response_msg_limit, 0, 0 },
> +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> +                                           cmd_set_response_msg_limit, 1, 0 },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
>                                0 },
> @@ -3035,6 +3089,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>  
>  static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
>      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
> +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> +                                           cmd_get_response_msg_limit, 0, 0 },
> +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> +                                           cmd_set_response_msg_limit, 1, 0 },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
>                                0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> @@ -3055,6 +3113,10 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
>  
>  static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
>      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> +                                           cmd_get_response_msg_limit, 0, 0 },
> +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> +                                           cmd_set_response_msg_limit, 1, 0 },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> -- 
> 2.46.1
> 

-- 
Fan Ni

