Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D37DCD1283
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 09:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrDl0-00063H-S9; Mon, 01 Apr 2024 05:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rrDku-00062q-1Q
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 05:15:07 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rrDks-0001GM-33
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 05:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711962902; x=1743498902;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7BbthviDQ0Ra47LSGIAYHzV26/8roeWxwzBYVgJLFiM=;
 b=lV0f64YJatDUHagfn3EmVCOuxDhuN4uwc8Evx1Y8X5mSYOeyOe3abTdE
 566FGBjIS7myMXFJBRY1AK5f61Jgl/MxkUn/CyhjsQHrpPwMN/3SujbSg
 t1LXfmrf8KdzWtFp2gPzV1G1Wcx4his7qnEHEgeTMBVugsubkogvlSiRZ
 A167CZVd/cwFRJhWmP47koc+oFdsCQOkX4qZAiNHtN2OEVryRgDWKdYB9
 ZnPYkkv9D/geNfAtx3PeRM9RyZk7v+qnIyfuz8BRDabFViBs5iUBqb9gD
 ZladbW+35iS+5m8Pf4JH8Tbw4Jktf9vruZha3pO8m34DMBFRzoX5BsRBE g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="142226933"
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; d="scan'208";a="142226933"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2024 18:14:56 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 94F2BD9F09
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 18:14:54 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D543ED7B6B
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 18:14:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 645582007472F
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 18:14:53 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8C1E41A000A;
 Mon,  1 Apr 2024 17:14:52 +0800 (CST)
Message-ID: <545f7629-2937-42ff-809e-02fdff5f4571@fujitsu.com>
Date: Mon, 1 Apr 2024 17:14:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/6] cxl/core: correct length of DPA field masks
To: Dan Williams <dan.j.williams@intel.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 stable@vger.kernel.org
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-2-ruansy.fnst@fujitsu.com>
 <66076ce2ddec7_19e02946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <66076ce2ddec7_19e02946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28290.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28290.006
X-TMASE-Result: 10--5.278600-10.000000
X-TMASE-MatchedRID: U43YD7H1LvyPvrMjLFD6eCkMR2LAnMRp2q80vLACqaeqvcIF1TcLYLBk
 jjdoOP1baz4aoYHfj+mh3bqxZ6gk+QqU4tmmg3HIi3TrOhAURKEbbhhV65kaY2O0yVK/5Lmc5GA
 Qy8LG5mci+t+0AiFaYvL3NxFKQpq17ZpdgJkP1WLcgUVP3Cp+vXFd5+Cf9M1DCK16zrE94nmkQu
 0/M/TLDg9Mn3iItNtKhgDksK+IVyzHO8eAxCOj9o61Z+HJnvsOfS0Ip2eEHnzUHQeTVDUrIg6wQ
 I72z4YedB0ntd9Tzp7GVuWouVipcobZcWeGK7nSbWo/bGcDJ4NC0x/dJHqjC/pbmb3XVEvJZDeF
 sBl1p6QJJfBDBk+SFcEYB+iaMCoc579tse/QOaV+erPL3QFt0vMMpBf3ZLno9xc4blKmPsG++4/
 U0fKJimxVnQcP2HDau2+pJwc75bs=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
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



在 2024/3/30 9:37, Dan Williams 写道:
> Shiyang Ruan wrote:
>> The length of Physical Address in General Media Event Record/DRAM Event
>> Record is 64-bit, so the field mask should be defined as such length.
>> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
>> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
>> unaffected.
>>
>> If userspace was doing its own DPA-to-HPA translation this could lead to
>> incorrect page retirement decisions, but there is no known consumer
>> (like rasdaemon) of this event today.
>>
>> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
>> Cc: <stable@vger.kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/cxl/core/trace.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index e5f13260fc52..e2d1f296df97 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
>>    * DRAM Event Record
>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>>    */
>> -#define CXL_DPA_FLAGS_MASK			0x3F
>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
> 
> This change makes sense...
> 
>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>>   
>> -#define CXL_DPA_VOLATILE			BIT(0)
>> -#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
>> +#define CXL_DPA_VOLATILE			BIT_ULL(0)
>> +#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
> 
> ...these do not. The argument to __print_flags() is an unsigned long, so
> they will be cast down to (unsigned long), and they are never used as a
> mask so the generated code should not change.

They will only used to check if such flag is set, not used as mask.  So, 
yes, I'll remove these changes.


--
Thanks,
Ruan.

