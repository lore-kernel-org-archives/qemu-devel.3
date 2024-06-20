Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E842DC2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKK4k-000473-5n; Thu, 20 Jun 2024 11:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1sKK4h-00046v-7T
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:51:47 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1sKK4d-0005LF-DF
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718898704; x=1750434704;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=agCwqOeNiTlCBNAJlb/Z1ovWMBbWxNCSgy7+apBHXNs=;
 b=TAdmv7ElkEvxPizVvFwIiVEtdiTVdGUr1fjREU6E7JkCy2f0dWRqDNHJ
 8oOOvbGg3We2mjfDzgI52ZygeiYbYCSTbRQ686Yp0BHLtNVtCSKr1U+DM
 tomdTtlp/U6FzzMFVIMlKaW5Oz1JHTvRz3zDqCZllfhtGN5LzYBrs2U0f
 pic/jAg6HLLEfUCocuWdFua525qXbY2HGubd8m33hrW7NMKu76xKITxc9
 ZP2DcX/chD/E5Cw2w7Hhh/1yUSDp6MSa4pH7TgiVbzJ3KRt06FplRNrV9
 5RGaalqDXdvWUnPyKkzfCAwMr0X1lLFkCZSwLjck8yvxFL+mcuhNKgGPp w==;
X-CSE-ConnectionGUID: W+J7ecwtS0q2GbytSpiGmA==
X-CSE-MsgGUID: UqcMbdTbQ3W8qbl/K8yfzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16120105"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; d="scan'208";a="16120105"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 08:51:39 -0700
X-CSE-ConnectionGUID: 7uaMk55MQxiho9lCN0+/jA==
X-CSE-MsgGUID: Qo6DET4hSGWqdbX+PQo4hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; d="scan'208";a="47234517"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.70])
 ([10.125.108.70])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 08:51:38 -0700
Message-ID: <e6b3a936-9c45-4d34-bf7c-2b68e2ad79ae@intel.com>
Date: Thu, 20 Jun 2024 08:51:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net, 
 ira.weiny@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
 <b9bbf3bc-9125-4cbb-b127-613b841dc9a8@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <b9bbf3bc-9125-4cbb-b127-613b841dc9a8@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/19/24 2:24 AM, Shiyang Ruan wrote:
> 
> 
> 在 2024/6/19 7:35, Dave Jiang 写道:
>>
>>
>> On 6/18/24 9:53 AM, Shiyang Ruan wrote:
>>> Background:
>>> Since CXL device is a memory device, while CPU consumes a poison page of
>>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>>> which-First path is configured.  This is the first report.  Then
>>> currently, in FW-First path, the poison event is transferred according
>>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>>   -> CPER -> trace report.  This is the second one.  These two reports
>>> are indicating the same poisoning page, which is the so-called "duplicate
>>> report"[1].  And the memory_failure() handling I'm trying to add in
>>> OS-First path could also be another duplicate report.
>>>
>>> Hope the flow below could make it easier to understand:
>>> CPU accesses bad memory on CXL device, then
>>>   -> MCE (INT18), *always* report (1)
>>>   -> * FW-First (implemented now)
>>>        -> CXL device -> FW
>>>           -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>>      * OS-First (not implemented yet, I'm working on it)
>>>        -> CXL device -> MSI
>>>           -> OS:CXL driver -> memory_failure() (2.b)
>>> so, the (1) and (2.a/b) are duplicated.
>>>
>>> (I didn't get response in my reply for [1] while I have to make patch to
>>> solve this problem, so please correct me if my understanding is wrong.)
>>>
>>> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
>>> to check whether the current poison page has been reported (if yes,
>>> stop the notifier chain, won't call the following memory_failure()
>>> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
>>> page already handled(recorded and reported) in (1) or (2), the other one
>>> won't duplicate the report.  The record could be clear when
>>> cxl_clear_poison() is called.
>>>
>>> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>>
> 
> ...
> 
>>> +
>>> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
>>> +{
>>> +    struct cxl_contains_hpa_context ctx = {
>>> +        .contains = false,
>>> +        .hpa = hpa,
>>> +    };
>>> +    struct cxl_port *port;
>>> +
>>> +    port = cxlmd->endpoint;
>>> +    if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>>
>> Maybe no need to check is_cxl_endpoint() if the port is retrieved from cxlmd->endpoint.
> 
> OK, I'll remove this.
> 
>>
>> Also, in order to use cxl_num_decoders_committed(), cxl_region_rwsem must be held. See the lockdep_assert_held() in the function. Maybe add a
>> guard(cxl_regoin_rwsem);
>> before the if statement above.
> 
> Got it.  I didn't realize it before.  Will add it.
> 
> 
> BTW, may I have your opinion on this proposal?  I'm not sure if the Background and problem described above are correct or not.  If not, it could lead me in the wrong direction.

Patch looks ok to me, but I'm no RAS expert in this area. Lets wait for comments from Jonathan and Dan. 
> 
> Thank you very much!
> 
> 
> -- 
> Ruan.
> 
>>
>> DJ
>>

