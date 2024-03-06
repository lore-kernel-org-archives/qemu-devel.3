Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6158AC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 15:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsqc-0007rU-St; Wed, 06 Mar 2024 10:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhsqa-0007r8-Vy
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:06:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhsqY-0003ga-5b
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:06:20 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqbHF3SMqz6K64d;
 Wed,  6 Mar 2024 23:01:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 59B4B14206D;
 Wed,  6 Mar 2024 23:06:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 15:06:04 +0000
Date: Wed, 6 Mar 2024 15:06:03 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>, Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PATCH v2] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox
 output payload space zeroing
Message-ID: <20240306150603.0000207e@Huawei.com>
In-Reply-To: <20240221221824.1092966-1-nifan.cxl@gmail.com>
References: <20240221221824.1092966-1-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 21 Feb 2024 14:18:11 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> The whole mailbox output payload space is already zeroed after copying
> out the input payload, which happens before processing the specific mailbox
> command:
> https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Good point.

I've applied this to my local tree - not rushing on this one.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index e5eb97cb91..fda88470a3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -226,7 +226,6 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>      log_type = payload_in[0];
>  
>      pl = (CXLGetEventPayload *)payload_out;
> -    memset(pl, 0, sizeof(*pl));
>  
>      max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
>                  CXL_EVENT_RECORD_SIZE;
> @@ -264,7 +263,6 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
>      CXLEventLog *log;
>  
>      policy = (CXLEventInterruptPolicy *)payload_out;
> -    memset(policy, 0, sizeof(*policy));
>  
>      log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
>      if (log->irq_enabled) {
> @@ -363,7 +361,6 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
>      QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
>  
>      is_identify = (void *)payload_out;
> -    memset(is_identify, 0, sizeof(*is_identify));
>      is_identify->pcie_vid = class->vendor_id;
>      is_identify->pcie_did = class->device_id;
>      if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
> @@ -597,7 +594,6 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
>      QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
>  
>      bg_op_status = (void *)payload_out;
> -    memset(bg_op_status, 0, sizeof(*bg_op_status));
>      bg_op_status->status = cci->bg.complete_pct << 1;
>      if (cci->bg.runtime > 0) {
>          bg_op_status->status |= 1U << 0;
> @@ -636,7 +632,6 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>      }
>  
>      fw_info = (void *)payload_out;
> -    memset(fw_info, 0, sizeof(*fw_info));
>  
>      fw_info->slots_supported = 2;
>      fw_info->slot_info = BIT(0) | BIT(3);
> @@ -792,7 +787,6 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>      }
>  
>      id = (void *)payload_out;
> -    memset(id, 0, sizeof(*id));
>  
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>  
> @@ -1079,7 +1073,6 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
>      out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
>      assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
>  
> -    memset(out, 0, out_pl_len);
>      QLIST_FOREACH(ent, poison_list, node) {
>          uint64_t start, stop;
>  


