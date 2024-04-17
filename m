Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C83C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 17:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx97M-0001fW-SY; Wed, 17 Apr 2024 13:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1rx97K-0001et-Op
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 13:30:43 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1rx97H-0004sj-Id
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 13:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713375039; x=1744911039;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5mH3cTp6TZtRdu9Nx6lCJ+m7zkZHFOEqCRMyPxsY7kM=;
 b=kUxPKD1btq2RCozKANc++i8P33ztVHivKpBUUdnVGLRHLDhmwnLCs6Vi
 lmwfj87BC+fFFUE+bjL4nn+5XZltdFyuXs6NSmZ/IqlUxcHUSKfNBJ1LZ
 1406NQJ4TlrNSVusS/b7hIDjWxnTEIcKvSu+cNAvnXcCBqXWxAW4OvujW
 sJYzhF/X5XaqmiA0kDLlKZ/X0RlwisktFL3+CEY9AV5AFe91NPBjrZJ8k
 9LWCEefglC4YdN0loZP3f5lSL+T1pCKP24hkEGHVrswCtnYcYbnPLvjii
 KLPPp/lvXQcx8Jmysk/uU68Xfc+vlXqI6NYH4ivh2dyxOkHKz9sV+mNZd w==;
X-CSE-ConnectionGUID: 5BNWMmRiQyi+rr772gHHMQ==
X-CSE-MsgGUID: KCS5uy49Q9SYJxzpW11rfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9005933"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9005933"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 10:30:35 -0700
X-CSE-ConnectionGUID: jX0vY89rQSaPBMPhF80OZQ==
X-CSE-MsgGUID: 357QEn3cQjy6jJyoSzbbIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; d="scan'208";a="23118306"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.69.240])
 ([10.212.69.240])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 10:30:35 -0700
Message-ID: <13652e98-3a70-4946-b8b0-be11032ca431@intel.com>
Date: Wed, 17 Apr 2024 10:30:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net, 
 ira.weiny@intel.com, alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 4/17/24 12:50 AM, Shiyang Ruan wrote:
> Currently driver only traces cxl events, poison creation (for both vmem
> and pmem type) on cxl memdev is silent.  OS needs to be notified then it
> could handle poison pages in time.  Per CXL spec, the device error event
> could be signaled through FW-First and OS-First methods.

Please consider below for better clarity:
Currently the driver only traces CXL events. Poison creation (for both ram
and pmem type) on a CXL memdev is silent. The OS needs to be notified so it
can handle poison pages. Per CXL spec, the device error event
can be signaled through the FW-First method or the OS-First method.

> 
> So, add poison creation event handler in OS-First method:
>   - Qemu:
>     - CXL device reports POISON creation event to OS by MSI by sending
>       GMER/DER after injecting a poison record;

Can probably drop the QEMU changes and this is the kernel commit log.

>   - CXL driver:
>     a. parse the POISON event from GMER/DER;
>     b. translate poisoned DPA to HPA (PFN);
>     c. enqueue poisoned PFN to memory_failure's work queue;
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h      |   8 +--
>  include/linux/cxl-event.h |  18 +++++-
>  3 files changed, 125 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f0f54aeccc87..76af0d73859d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt)
> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,

I think this needs to be changed to __cxl_report_poison() and the function below to cxl_report_poison(). Otherwise it goes against typical Linux methodology of having the __functionX() as the raw functionality function called by a functionX() wrapper. 

DJ

> +			      u64 dpa)
>  {
> -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +	unsigned long pfn = PHYS_PFN(hpa);
> +
> +	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
> +		return;
> +
> +	memory_failure_queue(pfn, MF_ACTION_REQUIRED);
> +}
> +
> +static int __cxl_report_poison(struct device *dev, void *arg)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
> +	u64 dpa = *(u64 *)arg;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		return 0;
> +
> +	if (cxled->mode == CXL_DECODER_MIXED) {
> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> +		return 0;
> +	}
> +
> +	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> +		return 0;
> +
> +	cxlmd = cxled_to_memdev(cxled);
> +	cxl_report_poison(cxlmd, cxled->cxld.region, dpa);
> +
> +	return 1;
> +}
> +
> +static void cxl_event_handle_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +
> +	/*
> +	 * No region is mapped to this endpoint, that is to say no HPA is
> +	 * mapped.
> +	 */
> +	if (!port || !is_cxl_endpoint(port) ||
> +	    cxl_num_decoders_committed(port) == 0)
> +		return;
> +
> +	device_for_each_child(&port->dev, &dpa, __cxl_report_poison);
> +}
> +
> +static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
> +					   enum cxl_event_log_type type,
> +					   struct cxl_event_gen_media *rec)
> +{
> +	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
> +
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_event_handle_poison(cxlmd, dpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
> +				  enum cxl_event_log_type type,
> +				  struct cxl_event_dram *rec)
> +{
> +	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
> +
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_event_handle_poison(cxlmd, dpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt)
> +{
> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> -	else if (event_type == CXL_CPER_EVENT_DRAM)
> +		cxl_event_handle_general_media(cxlmd, type, &evt->gen_media);
> +	} else if (event_type == CXL_CPER_EVENT_DRAM) {
>  		trace_cxl_dram(cxlmd, type, &evt->dram);
> -	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
> +		cxl_event_handle_dram(cxlmd, type, &evt->dram);
> +	} else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
>  		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
>  	else
>  		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
>  
> -static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				     enum cxl_event_log_type type,
> -				     struct cxl_event_record_raw *record)
> +static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +				      enum cxl_event_log_type type,
> +				      struct cxl_event_record_raw *record)
>  {
>  	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
>  	const uuid_t *uuid = &record->id;
> @@ -867,7 +958,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
>  
> -	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
> +	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
>  
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> @@ -979,8 +1070,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			break;
>  
>  		for (i = 0; i < nr_rec; i++)
> -			__cxl_event_trace_record(cxlmd, type,
> -						 &payload->records[i]);
> +			__cxl_event_handle_record(cxlmd, type,
> +						  &payload->records[i]);
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 36cee9c30ceb..ba1347de5651 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -822,10 +822,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt);
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..8189bed76c12 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -23,6 +23,20 @@ struct cxl_event_generic {
>  	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
>  } __packed;
>  
> +/*
> + * Event transaction type
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +enum cxl_event_transaction_type {
> +	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
> +	CXL_EVENT_TRANSACTION_READ,
> +	CXL_EVENT_TRANSACTION_WRITE,
> +	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
> +	CXL_EVENT_TRANSACTION_INJECT_POISON,
> +	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
> +	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
> +};
> +
>  /*
>   * General Media Event Record
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> @@ -33,7 +47,7 @@ struct cxl_event_gen_media {
>  	__le64 phys_addr;
>  	u8 descriptor;
>  	u8 type;
> -	u8 transaction_type;
> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>  	u8 validity_flags[2];
>  	u8 channel;
>  	u8 rank;
> @@ -52,7 +66,7 @@ struct cxl_event_dram {
>  	__le64 phys_addr;
>  	u8 descriptor;
>  	u8 type;
> -	u8 transaction_type;
> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>  	u8 validity_flags[2];
>  	u8 channel;
>  	u8 rank;

