Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268BCC3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 06:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMLkU-0003sx-1P; Wed, 26 Jun 2024 02:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sMLkS-0003sb-38
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 02:03:16 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sMLkP-0000Nx-RT
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 02:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1719381794; x=1750917794;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=m8YTY6GpEs3iSnFV8kd7Br7h+HDW2hkTnhnYCYUuL6g=;
 b=SPqXIPOwI38Sx8XBO8uD5hfZYPTAE4Q1MWA+GaEZkZZQOYRvmIb50iY6
 oxkJjhre8Q9Tyhhn4W9oWDcRWx1Dx8iJhOr+tBjIQPVNChRmErKOhwIx8
 InPxHcmod0wWf5bcyZDsS+ZhzXtWT1ZcuLq5pBbC/UN6LnEgzl5ZmFnRf
 LVlt+JlFD/zxbGrPgc3XZtGbUwhyai4pus9HpPidDQQ+DOaUJZU+L891t
 biifLYaiUhPkdHqF707Nkuetwm1o+45+B6vtJVeuM8H/w3N0hSDHrh1m7
 o36b8yigz/2bPIbVv3OVXGe7aH9iYegQFd36S/ZGOgmnniRmQE9GVlhdb g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="165028310"
X-IronPort-AV: E=Sophos;i="6.08,266,1712588400"; d="scan'208";a="165028310"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2024 15:03:09 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B812BCA1E1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 15:03:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 50170D8B6A
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 15:03:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D3E202007CAA6
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 15:03:05 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 087111A0002;
 Wed, 26 Jun 2024 14:03:03 +0800 (CST)
Message-ID: <bc58d99a-785f-4bb3-a9c9-9cf50ea7e06d@fujitsu.com>
Date: Wed, 26 Jun 2024 14:03:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: "Luck, Tony" <tony.luck@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "Weiny, Ira" <ira.weiny@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>, Borislav Petkov
 <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <20240620180239.00004d41@Huawei.com>
 <6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20240621194506.000024aa@Huawei.com>
 <SJ1PR11MB6083837A8588894E49FEBC7BFCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083837A8588894E49FEBC7BFCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28482.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28482.005
X-TMASE-Result: 10--14.782900-10.000000
X-TMASE-MatchedRID: bdIiGNtle6uPvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYPAF
 43IXaj2gSY/hjDx7hppvUDqCNlsvKH+zsg6kp2C3Q0Xm0pWWLkroUwvpyt4rucg9ufahCGm1l2i
 SdQmYgPCf4Zlhm+r+lc5cp47XA8AiC9QTSuTOQRl+J3gtIe0gA8qspZV+lCSLdBaEtWosUzVYTF
 /5quaSLwftggnq5tKUMTii0wFdgxqOeQ6RXnGCFkX/j4QZJ10NajzNTFMlQCNtfzoljzPXO9F8e
 0i2JFlZ371UTvxX45vRKmOlruuzzop+5WdOMDCgv8fLAX0P50B2ZYwNBqM6IlLvEapiw2T1hXAr
 +h4GfTAIZNHliKo/PSm+XCxBE3RsKgAlgjPhYpaOtWfhyZ77Dn0tCKdnhB581B0Hk1Q1KyIOsEC
 O9s+GHnQdJ7XfU86eOwBXM346/+z07YdcTiNsP7Uv9Q5rrJhWezfWWH34ZgZxRwXGk1PHIsR47n
 50KUDY
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.48;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa2.hc1455-7.c3s2.iphmx.com
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



在 2024/6/22 4:44, Luck, Tony 写道:
>> So who actually cares about recovering poisoned volatile memory?
>> I'd like to understand more on how significant a use case this is.
>> Whilst I can conjecture that its an extreme case of wanting to avoid
>> loosing the ability to create 1GiB or larger pages due to poison
>> is that a real problem for anyone today?  Note this is just the case
>> where you've reached an actual uncorrectable error and probably
>> / possibly killed something, not the more common soft offlining
>> of memory due to correctable errors being detected.
> 
> I guess you really need a reply from someone with a data center
> with thousands of machines, since that's where this question
> may be important.
> 
> My humble opinion is that, outside of the huge page issue, nobody
> should try to recover a poisoned page. Systems that can report
> and recover from poison have tens, hundreds, or more GBytes
> of memory. Dropping 4K pages will not have any measurable
> impact on a system (even if there are hundreds of pages dropped).
> 
> There's no reliable way to determine whether the poisoned page
> was due to some transient issue, or a permanent defect. Recovering
> a poisoned page runs the risk that the poison will re-occur. Perhaps
> next use of the page will be in some unrecoverable (kernel) context.
> 
> So recovery has some risk, but very little upside benefit.

Since the hardware provides the instruction(CPU)/command(CXL) to clear 
the poison, we could make the function work, at least as an optional 
feature.  Then users could decide to use it or not after evaluating the 
risk and benefit.

I think doing recovery is an improvement step, and may need a lot of 
discussion.  I'm not sure if we could reach a conclusion in this thread. 
  Just hope more comments on the original problem (duplicate report) to 
solve in this patch.


--
Thanks,
Ruan.

> 
> -Tony

