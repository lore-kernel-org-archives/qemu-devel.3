Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32523C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 09:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV5i7-0000jo-Nt; Fri, 27 Jun 2025 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uV5i5-0000jZ-Hv
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:49:29 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uV5i1-0005uC-Tx
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 05:49:29 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bT9g33btfz6L5FJ;
 Fri, 27 Jun 2025 17:46:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 8F7A1140277;
 Fri, 27 Jun 2025 17:49:01 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 11:49:00 +0200
Date: Fri, 27 Jun 2025 10:48:59 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [HACK QEMU PATCH v1 1/1] hw/cxl: Fix MCTP Binding Check
Message-ID: <20250627104859.00003cbe@huawei.com>
In-Reply-To: <20250626235102.1902427-2-anisa.su887@gmail.com>
References: <20250626235102.1902427-1-anisa.su887@gmail.com>
 <20250626235102.1902427-2-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.213]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 26 Jun 2025 23:41:15 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> Per the spec, FMAPI commands (0x51-0x59) must be bound with
> MCTP_MT_CXL_FMAPI. Fix the conditions ensuring this in i2c_mctp_cxl.c
> and dev-mctp.c
> 
> Move the opcode enum from cxl-mailbox-utils.c to cxl_mailbox.h to
> allow i2c_mctp_cxl.c and dev-mctp.c to use the enum instead of
> hardcoding the values.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Why HACK in the patch title?

In general this seems reasonable - the complexity is how I merge it
into my tree given the code being modified slips in at various different
points. I'll sort that out though.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 74 +-----------------------------------
>  hw/cxl/i2c_mctp_cxl.c        |  6 ++-
>  hw/usb/dev-mctp.c            |  6 ++-
>  include/hw/cxl/cxl_mailbox.h | 73 +++++++++++++++++++++++++++++++++++
>  4 files changed, 82 insertions(+), 77 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4c01b25110..7f84e147f7 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -37,7 +37,7 @@
>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> - *  1. Add the command set and cmd to the enum.
> + *  1. Add the command set and cmd to the enum in cxl_mailbox.h.
>   *     FOO    = 0x7f,
>   *          #define BAR 0
>   *  2. Implement the handler
> @@ -60,78 +60,6 @@
>   *  a register interface that already deals with it.
>   */
>  
> -enum {
> -    INFOSTAT    = 0x00,
> -        #define IS_IDENTIFY   0x1
> -        #define BACKGROUND_OPERATION_STATUS    0x2
> -        #define GET_RESPONSE_MSG_LIMIT         0x3
> -        #define SET_RESPONSE_MSG_LIMIT         0x4
> -        #define BACKGROUND_OPERATION_ABORT     0x5
> -    EVENTS      = 0x01,
> -        #define GET_RECORDS   0x0
> -        #define CLEAR_RECORDS   0x1
> -        #define GET_INTERRUPT_POLICY   0x2
> -        #define SET_INTERRUPT_POLICY   0x3
> -    FIRMWARE_UPDATE = 0x02,
> -        #define GET_INFO      0x0
> -        #define TRANSFER      0x1
> -        #define ACTIVATE      0x2
> -    TIMESTAMP   = 0x03,
> -        #define GET           0x0
> -        #define SET           0x1
> -    LOGS        = 0x04,
> -        #define GET_SUPPORTED 0x0
> -        #define GET_LOG       0x1
> -        #define GET_LOG_CAPABILITIES   0x2
> -        #define CLEAR_LOG     0x3
> -        #define POPULATE_LOG  0x4
> -    FEATURES    = 0x05,
> -        #define GET_SUPPORTED 0x0
> -        #define GET_FEATURE   0x1
> -        #define SET_FEATURE   0x2
> -    IDENTIFY    = 0x40,
> -        #define MEMORY_DEVICE 0x0
> -    CCLS        = 0x41,
> -        #define GET_PARTITION_INFO     0x0
> -        #define GET_LSA       0x2
> -        #define SET_LSA       0x3
> -    HEALTH_INFO_ALERTS = 0x42,
> -        #define GET_ALERT_CONFIG 0x1
> -        #define SET_ALERT_CONFIG 0x2
> -    SANITIZE    = 0x44,
> -        #define OVERWRITE     0x0
> -        #define SECURE_ERASE  0x1
> -        #define MEDIA_OPERATIONS 0x2
> -    PERSISTENT_MEM = 0x45,
> -        #define GET_SECURITY_STATE     0x0
> -    MEDIA_AND_POISON = 0x43,
> -        #define GET_POISON_LIST        0x0
> -        #define INJECT_POISON          0x1
> -        #define CLEAR_POISON           0x2
> -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> -        #define SCAN_MEDIA             0x4
> -        #define GET_SCAN_MEDIA_RESULTS 0x5
> -    DCD_CONFIG  = 0x48,
> -        #define GET_DC_CONFIG          0x0
> -        #define GET_DYN_CAP_EXT_LIST   0x1
> -        #define ADD_DYN_CAP_RSP        0x2
> -        #define RELEASE_DYN_CAP        0x3
> -    PHYSICAL_SWITCH = 0x51,
> -        #define IDENTIFY_SWITCH_DEVICE      0x0
> -        #define GET_PHYSICAL_PORT_STATE     0x1
> -    TUNNEL = 0x53,
> -        #define MANAGEMENT_COMMAND     0x0
> -    MHD = 0x55,
> -        #define GET_MHD_INFO 0x0
> -    FMAPI_DCD_MGMT = 0x56,
> -        #define GET_DCD_INFO    0x0
> -        #define GET_HOST_DC_REGION_CONFIG   0x1
> -        #define SET_DC_REGION_CONFIG        0x2
> -        #define GET_DC_REGION_EXTENT_LIST   0x3
> -        #define INITIATE_DC_ADD             0x4
> -        #define INITIATE_DC_RELEASE         0x5
> -};
> -
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
>  typedef struct CXLCCIMessage {
>      uint8_t category;
> diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> index 1714f36e8e..3f17779562 100644
> --- a/hw/cxl/i2c_mctp_cxl.c
> +++ b/hw/cxl/i2c_mctp_cxl.c
> @@ -29,6 +29,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/registerfields.h"
> +#include "hw/cxl/cxl_mailbox.h"
>  
>  #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
>  
> @@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
>           */
>  
>          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> -              msg->command_set < 0x51) &&
> +              msg->command_set < PHYSICAL_SWITCH) &&
>              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> +              msg->command_set >= PHYSICAL_SWITCH &&
> +              msg->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
>              buf->rc = CXL_MBOX_UNSUPPORTED;
>              st24_le_p(buf->pl_length, len_out);
>              s->len = s->pos;
> diff --git a/hw/usb/dev-mctp.c b/hw/usb/dev-mctp.c
> index aafb9e7e96..b82a269561 100644
> --- a/hw/usb/dev-mctp.c
> +++ b/hw/usb/dev-mctp.c
> @@ -25,6 +25,7 @@
>  #include "hw/usb.h"
>  #include "hw/usb/desc.h"
>  #include "net/mctp.h"
> +#include "hw/cxl/cxl_mailbox.h"
>  
>  /* TODO: Move to header */
>  
> @@ -504,9 +505,10 @@ static void usb_cxl_mctp_handle_data(USBDevice *dev, USBPacket *p)
>           * onwards.
>           */
>          if (!(req->message_type == MCTP_MT_CXL_TYPE3 &&
> -              req->command_set < 0x51) &&
> +              req->command_set < PHYSICAL_SWITCH) &&
>              !(req->message_type == MCTP_MT_CXL_FMAPI &&
> -              req->command_set >= 0x51 && req->command_set < 0x56)) {
> +              req->command_set >= PHYSICAL_SWITCH &&
> +              req->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
>              len_out = 0;
>              usb_pkt_len = sizeof(MCTPUSBPacket) + sizeof(CXLMCTPMessage) +
>                  len_out;
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 820c411cbb..209a11ecbc 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -27,4 +27,77 @@
>  #define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
>  #define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
>  
> +enum {
> +    INFOSTAT    = 0x00,
> +        #define IS_IDENTIFY   0x1
> +        #define BACKGROUND_OPERATION_STATUS    0x2
> +        #define GET_RESPONSE_MSG_LIMIT         0x3
> +        #define SET_RESPONSE_MSG_LIMIT         0x4
> +        #define BACKGROUND_OPERATION_ABORT     0x5
> +    EVENTS      = 0x01,
> +        #define GET_RECORDS   0x0
> +        #define CLEAR_RECORDS   0x1
> +        #define GET_INTERRUPT_POLICY   0x2
> +        #define SET_INTERRUPT_POLICY   0x3
> +    FIRMWARE_UPDATE = 0x02,
> +        #define GET_INFO      0x0
> +        #define TRANSFER      0x1
> +        #define ACTIVATE      0x2
> +    TIMESTAMP   = 0x03,
> +        #define GET           0x0
> +        #define SET           0x1
> +    LOGS        = 0x04,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_LOG       0x1
> +        #define GET_LOG_CAPABILITIES   0x2
> +        #define CLEAR_LOG     0x3
> +        #define POPULATE_LOG  0x4
> +    FEATURES    = 0x05,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_FEATURE   0x1
> +        #define SET_FEATURE   0x2
> +    IDENTIFY    = 0x40,
> +        #define MEMORY_DEVICE 0x0
> +    CCLS        = 0x41,
> +        #define GET_PARTITION_INFO     0x0
> +        #define GET_LSA       0x2
> +        #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_ALERT_CONFIG 0x1
> +        #define SET_ALERT_CONFIG 0x2
> +    SANITIZE    = 0x44,
> +        #define OVERWRITE     0x0
> +        #define SECURE_ERASE  0x1
> +        #define MEDIA_OPERATIONS 0x2
> +    PERSISTENT_MEM = 0x45,
> +        #define GET_SECURITY_STATE     0x0
> +    MEDIA_AND_POISON = 0x43,
> +        #define GET_POISON_LIST        0x0
> +        #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
> +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> +        #define SCAN_MEDIA             0x4
> +        #define GET_SCAN_MEDIA_RESULTS 0x5
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
> +        #define GET_DYN_CAP_EXT_LIST   0x1
> +        #define ADD_DYN_CAP_RSP        0x2
> +        #define RELEASE_DYN_CAP        0x3
> +    PHYSICAL_SWITCH = 0x51,
> +        #define IDENTIFY_SWITCH_DEVICE      0x0
> +        #define GET_PHYSICAL_PORT_STATE     0x1
> +    TUNNEL = 0x53,
> +        #define MANAGEMENT_COMMAND     0x0
> +    MHD = 0x55,
> +        #define GET_MHD_INFO 0x0
> +    FMAPI_DCD_MGMT = 0x56,
> +        #define GET_DCD_INFO    0x0
> +        #define GET_HOST_DC_REGION_CONFIG   0x1
> +        #define SET_DC_REGION_CONFIG        0x2
> +        #define GET_DC_REGION_EXTENT_LIST   0x3
> +        #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
> +    GLOBAL_MEM_ACCESS_EP_MGMT = 0X59,
> +};
> +
>  #endif


