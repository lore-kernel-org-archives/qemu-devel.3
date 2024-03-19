Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA15FC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmeFc-0005DN-5b; Tue, 19 Mar 2024 14:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1rmeFW-0005Co-PO
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:31:47 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1rmeFU-000432-Rd
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710873105; x=1742409105;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=J6C41V/nYcmkeLsc41+n8k3LnBrowCWX062IB4aM7xs=;
 b=RaLhQF4CdCqjAiA1C97uzdGSUtf2s6QTmhk/V4kubDpZ/u4u4UC2x7sL
 wUizIsqBK/ngjG2yyIXabSnQeHmCrIejTs51lR2d9orhyCfx51Fa1JU9H
 DM55QB+n+vYSok8rXfK+WQFbb/Q9IHf1darOoD+ApCDmHIyKODoE+9Lnv
 vnNTTE57yD2pWUAKLRiaeEjRMw5XWaerPqWyrT0ZbtpbI9hdUgf3b+mam
 H+BGIHKHzwwPRwuiC8s0PzycfqjQTSSMArqlf9EULR3UyevLLfS/DJise
 uOQUEAa4/W51TDWcei/5Of/kDi3k0gl3vOPh3MXS4RHRqpS/N8z0NaxiM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17173273"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; d="scan'208";a="17173273"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 11:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; d="scan'208";a="13975894"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.108.125])
 ([10.212.108.125])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 11:31:39 -0700
Message-ID: <e589e7d5-c83a-4b33-8504-e3174cc4e534@intel.com>
Date: Tue, 19 Mar 2024 11:31:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/mem: Fix for the index of Clear Event Record
 Handle
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, chenbaozi@phytium.com.cn
References: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
 <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
 <20240318105748.000072c5@Huawei.com>
 <65f8de878e8e1_7702a294f4@dwillia2-xfh.jf.intel.com.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65f8de878e8e1_7702a294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 3/18/24 5:38 PM, Dan Williams wrote:
> Jonathan Cameron wrote:
>> On Mon, 18 Mar 2024 10:29:28 +0800
>> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
>>
>>> The dev_dbg info for Clear Event Records mailbox command would report
>>> the handle of the next record to clear not the current one.
>>>
>>> This was because the index 'i' had incremented before printing the
>>> current handle value.
>>>
>>> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
>>> ---
>>>  drivers/cxl/core/mbox.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>> index 9adda4795eb7..b810a6aa3010 100644
>>> --- a/drivers/cxl/core/mbox.c
>>> +++ b/drivers/cxl/core/mbox.c
>>> @@ -915,7 +915,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>>>  
>>>  		payload->handles[i++] = gen->hdr.handle;
>>>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
>>> -			le16_to_cpu(payload->handles[i]));
>>> +			le16_to_cpu(payload->handles[i-1]));
>> Trivial but needs spaces around the -. e.g.  [i - 1] 
>>
>> Maybe Dan can fix up whilst applying.
>>
>> Otherwise
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I have enlisted Dave to start wrangling CXL kernel patches upstream, and
> I will fall back to just reviewing.
> 
> Dave, you can add my:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...with the same caveat as above.

Applied, updated, and added 
Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")

> 

