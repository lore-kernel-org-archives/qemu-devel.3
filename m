Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC03CCD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 14:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs239-0005Iz-CE; Wed, 03 Apr 2024 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rs237-0005IW-Jq
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 10:57:13 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rs235-0006sv-5r
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 10:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712156232; x=1743692232;
 h=message-id:date:mime-version:from:subject:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=wGVG9UoQIH9HATg63O7PLJz1eHZyUcRz7fmo8PRFMm0=;
 b=ZHeoxFrVm+rT3vmzkDCzeNl32KV9aPhIvreo/OelhpQbGmLIEn9mmQbJ
 gd+9GHQT5Ga8ja+F3HOo3FauAFfje1HWQTZYJFDqk4DE4MeJ1LX6rBsGz
 eb/yFXFRLxkfOnyc9ZVZdZuiZVAVcfiI9JlzhKGbLX+BCf84ajavZcHAY
 2joRVjbWF1NzH7kJx+vCbSb3l36NxDCfLERl1gl6W0ZmQOG8KNtcim+9x
 DZ7TLojstfhxJ1LNs7+L1eftOo9doQxkweiUha/+oOftHX8TrynQm5q/q
 32gxboQR6lqgiw9VXuk2zPMTcb+lXIQJelEdEd3mr2v8zn0LoWRt1BInl g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="154492946"
X-IronPort-AV: E=Sophos;i="6.07,177,1708354800"; d="scan'208";a="154492946"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 23:57:06 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D9998A3449
 for <qemu-devel@nongnu.org>; Wed,  3 Apr 2024 23:57:01 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D9E0D5620
 for <qemu-devel@nongnu.org>; Wed,  3 Apr 2024 23:57:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8DE4F200932D8
 for <qemu-devel@nongnu.org>; Wed,  3 Apr 2024 23:57:00 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 95B881A000A;
 Wed,  3 Apr 2024 22:56:59 +0800 (CST)
Message-ID: <7c8e36f1-4c16-43cd-a39b-fe02fa1756cd@fujitsu.com>
Date: Wed, 3 Apr 2024 22:56:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/6] cxl/core: add report option for
 cxl_mem_get_poison()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-4-ruansy.fnst@fujitsu.com>
 <66076fd957c4b_19e0294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <66076fd957c4b_19e0294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28296.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28296.000
X-TMASE-Result: 10--16.441900-10.000000
X-TMASE-MatchedRID: 9xvWjox81uOPvrMjLFD6eJTQgFTHgkhZQTMEQWnELEU61nHU3L1mvwYE
 LASKZobWjhyWkMlRInD9k/FBDAgpqGRByQkQLdDaN70wXhI0DX6Uq+GQ/zyJdOjMOEZ5AL0SDBr
 boYDj/cng2LxpMMc9Px6xprZaWb235AnOPTFB1DiZUG41i0Kjm20Zqaz0+DLChg/Tt7otYdhpik
 /9hPBw3c+43AGKwmcORX+6bCskindQ6gu3nooYNzo39wOA02LhNpy6NoTePCFD9iPiuXvzgYUOm
 GTb5yG/WjOVO3UV6ptftuJwrFEhTbeQq6mF2S4/udR/NJw2JHcNYpvo9xW+mI6HM5rqDwqt3Slh
 3kNKPebQS/EOAE16XukMOPzp0BhG/M8Or3cw2XfpN/z5pkap7A==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.49;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa3.hc1455-7.c3s2.iphmx.com
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



在 2024/3/30 9:50, Dan Williams 写道:
> Shiyang Ruan wrote:
>> The GMER only has "Physical Address" field, no such one indicates length.
>> So, when a poison event is received, we could use GET_POISON_LIST command
>> to get the poison list.  Now driver has cxl_mem_get_poison(), so
>> reuse it and add a parameter 'bool report', report poison record to MCE
>> if set true.
> 
> I am not sure I agree with the rationale here because there is no
> correlation between the event being signaled and the current state of
> the poison list. It also establishes race between multiple GMER events,
> i.e. imagine the hardware sends 4 GMER events to communicate a 256B
> poison discovery event. Does the driver need logic to support GMER event
> 2, 3, and 4 if it already say all 256B of poison after processing GMER
> event 1?

Yes, I didn't thought about that.

> 
> I think the best the driver can do is assume at least 64B of poison
> per-event and depend on multiple notifications to handle larger poison
> lengths.

Agree.  This also makes things easier.

And for qemu, I'm thinking of making a patch to limit the length of a 
poison record when injecting.  The length should between 64B to 4KiB per 
GMER. And emit many GMERs if length > 4KiB.

> 
> Otherwise, the poison list is really only useful for pre-populating
> pages to offline after a reboot, i.e. to catch the kernel up with the
> state of poison pages after a reboot.

Got it.


--
Thanks,
Ruan.

