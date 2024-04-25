Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54FDC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzvza-00062v-UP; Thu, 25 Apr 2024 06:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rzvzY-0005wt-Kk
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:06:12 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rzvzU-0000Jf-9p
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1714039568; x=1745575568;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9ui7yF4xCi0s7W9PYYbpmr3fDfYDVJD2/IAdjVVo60E=;
 b=rqKy6JGJ6MIhHj7Ndj1mDjA2pZBtbEmNiZ7vktNqXOHR0mm4H8H7LhTP
 XoUEyE438Lt+yHjk9fK1H1DYvhvVjz97r3LOy3j/JYzH7S3J8YVvdVTYT
 C6kAIeox6qkOg5rozWv5v4FnRwY6CPNp6Nh8o43bszxdjRbri0yDwze0S
 sjwTveHc+Ss70lykjUiUiiLc7a2AHjf3VHD/+RKXJZp5X8hjCIrSqBOVM
 sOJTFJ6hHTdr+rCnt3hWRgO7jau/HKWIFWBPPNeFV73YXzuZP29VG5kPu
 oMDYiYSPrLC4epFAztGtckPAqfNexC4FoAi2FSaXEeDkh+vJzooeIpfno g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="157008415"
X-IronPort-AV: E=Sophos;i="6.07,229,1708354800"; d="scan'208";a="157008415"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 19:06:03 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9166DC68FB
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 19:06:01 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D3172D560D
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 19:06:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5A1162030EE48
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 19:06:00 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1AF301A000B;
 Thu, 25 Apr 2024 18:05:58 +0800 (CST)
Message-ID: <5563b68c-48ab-48e3-bbc9-b93236ea0543@fujitsu.com>
Date: Thu, 25 Apr 2024 18:05:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
To: Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 stable@vger.kernel.org
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
 <ZifzF8cXObFiDiIK@aschofie-mobl2>
 <66282269c8d4e_d2ce22941e@iweiny-mobl.notmuch>
In-Reply-To: <66282269c8d4e_d2ce22941e@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28342.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28342.006
X-TMASE-Result: 10--8.769000-10.000000
X-TMASE-MatchedRID: ehvrJQ9m4PCPvrMjLFD6eHchRkqzj/bEC/ExpXrHizxBqLOmHiM3w9vx
 x0ntQKyZIvrftAIhWmLy9zcRSkKatdgW4k6aveo4JmbrB1j4Xwqu2GmdldmiUFAoBBK61BhcDNg
 h8//LFqcY75YLBQacDDXZ4YiSvO26P0DBdQeKlX30hv/rD7WVZAGo1vhC/pWj1tmGB7JU9CMQGU
 caieHP20ky3+YDnnncWtxX1bZT1YKPaFHMfVTC4IMbH85DUZXyudR/NJw2JHcNYpvo9xW+mI6HM
 5rqDwqtdBt/JsWxNYMojJSc3dcGBinRbTgBFGIc+/ubgugAYE5DfpC/4XnsQAPA0m6VHcLNwMzJ
 Pwl8jS0FTjdoGJlwifD71DijxXcjgokLZRKLKVGdC4HNoe3rP7Iyum16+pyZ1elfyC1yu6+FK45
 C57CBPA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.117;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa4.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



在 2024/4/24 5:04, Ira Weiny 写道:
> Alison Schofield wrote:
>> On Wed, Apr 17, 2024 at 03:50:52PM +0800, Shiyang Ruan wrote:
> 
> [snip]
> 
>>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>>> index e5f13260fc52..cdfce932d5b1 100644
>>> --- a/drivers/cxl/core/trace.h
>>> +++ b/drivers/cxl/core/trace.h
>>> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>>>    * DRAM Event Record
>>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>>>    */
>>> -#define CXL_DPA_FLAGS_MASK			0x3F
>>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>>>   
>>>   #define CXL_DPA_VOLATILE			BIT(0)
>>
>> This works but I'm thinking this is the time to convene on one
>> CXL_EVENT_DPA_MASK for both all CXL events, rather than having
>> cxl_poison event be different.
>>
>> I prefer how poison defines it:
>>
>> cxlmem.h:#define CXL_POISON_START_MASK          GENMASK_ULL(63, 6)
>>
>> Can we rename that CXL_EVENT_DPA_MASK and use for all events?

cxlmem.h:CXL_POISON_START_MASK is defined for MBOX commands (poison 
record, the lower 3 bits indicate "Error Source"), but CXL_DPA_MASK here 
is for events.  They have different meaning though their values are 
same.  So, I don't think we should consolidate them.

> 
> Ah!  Great catch.  I dont' know why I only masked off the 2 used bits.

Per spec, the lowest 2 bits of CXL event's DPA are defined for "Volatile 
or not" and "not repairable".  So there is no mistake here.

> That was short sighted of me.
> 
> Yes we should consolidate these.
> Ira

--
Thanks,
Ruan.


