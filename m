Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80F7C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 10:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKbLW-0000N9-61; Fri, 21 Jun 2024 06:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sKbLV-0000Mv-BM
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 06:18:17 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sKbLT-0006r0-Eo
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 06:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1718965096; x=1750501096;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bDC+tKWoCb/DV/ywP3UArJCu2GL4AXjVXl71+53QbMk=;
 b=LV0sj+GFB8+LEt1W1P88ChnXcZJaMqiIfuE1QECNw0yh5DgTpR7madEU
 d3SqfZyx+z4OUVdY3PliBO0hjUeTYtDjK/rNCIDLDCuq6SR39UgOivx/F
 r1y9b/24ya5jChQse4c//KO1Kl8jgUDDbvo+e3D0kh4hztfv+mePblbna
 45Mg6uZfDKHBN941bArboV8Ypn9Zeo/VgrQgpiAotzUlbToj3q6bP6xYc
 vHmj92i9OagzVA0pQxM5CziwGEHHfH5Es2KU9dncV9EW93qBhgqbXGNPQ
 dZb6+M+ZJsqs/RQi7UTq5JQpWjm/g+nYZhlLiTzopI5ppnkcx0uFfdkrP A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="164486457"
X-IronPort-AV: E=Sophos;i="6.08,254,1712588400"; d="scan'208";a="164486457"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2024 19:18:12 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 01534DAE08
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 19:18:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 42BCC15C7F
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 19:18:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C5FA420088EA4
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 19:18:08 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 361FE1A0002;
 Fri, 21 Jun 2024 18:18:08 +0800 (CST)
Message-ID: <cc2236cf-ace2-498d-a0b3-2fbc9f7fc317@fujitsu.com>
Date: Fri, 21 Jun 2024 18:18:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Dave Jiang <dave.jiang@intel.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net, 
 ira.weiny@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
 <b9bbf3bc-9125-4cbb-b127-613b841dc9a8@fujitsu.com>
 <e6b3a936-9c45-4d34-bf7c-2b68e2ad79ae@intel.com>
In-Reply-To: <e6b3a936-9c45-4d34-bf7c-2b68e2ad79ae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28468.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28468.004
X-TMASE-Result: 10--20.375500-10.000000
X-TMASE-MatchedRID: sH5kboBHks6PvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYLBk
 jjdoOP1bp3Z/y3zTL9+zN6XcSN8uuHerlGbz8OXFolVO7uyOCDUXivwflisSrEJsNXD374+pO+W
 Rk1kOc5MCcJ+0x3yT8twnF1a+MpDfC5dVqsgzBjuOFfLQqF6P0tUEOicf335WUoV94zwLp3VJ9L
 43nm/22bqZhYf6F5ZElyW1ZrZx68b/awIuxLRW1EhwlOfYeSqxlDt5PQMgj00zAwv94MqCLh8aR
 hKglPt8mNVEdxRO2BKiQrGQ0QrIUcfdkIlEiI2knVTWWiNp+v9AApRfVHzqNN9RlPzeVuQQunqB
 IQj+1Jm8HpxVQnR8jFIgVt7sAjKWDOQhvAmAT8UDccazfMVOqLFcDzCo2ZtWmWGz8DF0pgYRRLf
 e6UPgvJ7xaTBl9U9ut1K/UeVR3qj3Pg7atDU0/Y61Z+HJnvsOiFg4TY5QPrAGWfDd0b0zMaPFjJ
 EFr+oloTCA5Efyn8C3ApS8cfJcZd0H8LFZNFG7JQhrLH5KSJ0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.47;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa1.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



在 2024/6/20 23:51, Dave Jiang 写道:
> 
> 
> On 6/19/24 2:24 AM, Shiyang Ruan wrote:
>>
>>
>> 在 2024/6/19 7:35, Dave Jiang 写道:
>>>
>>>
>>> On 6/18/24 9:53 AM, Shiyang Ruan wrote:
>>>> Background:
>>>> Since CXL device is a memory device, while CPU consumes a poison page of
>>>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>>>> which-First path is configured.  This is the first report.  Then
>>>> currently, in FW-First path, the poison event is transferred according
>>>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>>>    -> CPER -> trace report.  This is the second one.  These two reports
>>>> are indicating the same poisoning page, which is the so-called "duplicate
>>>> report"[1].  And the memory_failure() handling I'm trying to add in
>>>> OS-First path could also be another duplicate report.
>>>>
>>>> Hope the flow below could make it easier to understand:
>>>> CPU accesses bad memory on CXL device, then
>>>>    -> MCE (INT18), *always* report (1)
>>>>    -> * FW-First (implemented now)
>>>>         -> CXL device -> FW
>>>>            -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>>>       * OS-First (not implemented yet, I'm working on it)
>>>>         -> CXL device -> MSI
>>>>            -> OS:CXL driver -> memory_failure() (2.b)
>>>> so, the (1) and (2.a/b) are duplicated.
>>>>
>>>> (I didn't get response in my reply for [1] while I have to make patch to
>>>> solve this problem, so please correct me if my understanding is wrong.)
>>>>
>>>> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
>>>> to check whether the current poison page has been reported (if yes,
>>>> stop the notifier chain, won't call the following memory_failure()
>>>> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
>>>> page already handled(recorded and reported) in (1) or (2), the other one
>>>> won't duplicate the report.  The record could be clear when
>>>> cxl_clear_poison() is called.
>>>>
>>>> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>>>
>>
>> ...
>>
>>>> +
>>>> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
>>>> +{
>>>> +    struct cxl_contains_hpa_context ctx = {
>>>> +        .contains = false,
>>>> +        .hpa = hpa,
>>>> +    };
>>>> +    struct cxl_port *port;
>>>> +
>>>> +    port = cxlmd->endpoint;
>>>> +    if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>>>
>>> Maybe no need to check is_cxl_endpoint() if the port is retrieved from cxlmd->endpoint.
>>
>> OK, I'll remove this.
>>
>>>
>>> Also, in order to use cxl_num_decoders_committed(), cxl_region_rwsem must be held. See the lockdep_assert_held() in the function. Maybe add a
>>> guard(cxl_regoin_rwsem);
>>> before the if statement above.
>>
>> Got it.  I didn't realize it before.  Will add it.
>>
>>
>> BTW, may I have your opinion on this proposal?  I'm not sure if the Background and problem described above are correct or not.  If not, it could lead me in the wrong direction.
> 
> Patch looks ok to me, but I'm no RAS expert in this area. Lets wait for comments from Jonathan and Dan.

Thanks!

--
Ruan.

>>
>> Thank you very much!
>>
>>
>> -- 
>> Ruan.
>>
>>>
>>> DJ
>>>

