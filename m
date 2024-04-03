Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFA6CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 15:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs2DD-00019S-TH; Wed, 03 Apr 2024 11:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rs2DB-00018m-9r
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:07:37 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rs2D8-0000lF-Vi
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712156855; x=1743692855;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KP4FSDYX2aMqZv+pIlNyTSll1k/A7gW/cPjAnaZSoy0=;
 b=UWCQskKYTq/7fwqVFDUvG0aT0nV+3NktatorTY/8a7aQbj1mFVp6B0ZN
 KSwr2744kvtLzNX8lZFfNm+5LPavkfZQEZDmzgbvha0E2Ms5hBgUKEKcC
 /S/JOIi13sUE3S8cZy0gYfqOeUQLhoNU+flllfrqqneOwcsbPHnlgKwFm
 QPS+UGp5a19cSErh2xIJNWPnKRIIXsg/TkcclHJEtCchQIeocPHeuKno5
 eZtfH05dwIgoTCmVI65kVL+jGl8oYT5W05c9AoTUBi5nnpoAr6uBpBCG3
 rUnCtX8hCYIZKVmQa9OvJc9TJm53dwOz7lw7aNldDSlyGL+GWkQt6o4/s w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="154537484"
X-IronPort-AV: E=Sophos;i="6.07,177,1708354800"; d="scan'208";a="154537484"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 00:07:31 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 363C3D3EB2
 for <qemu-devel@nongnu.org>; Thu,  4 Apr 2024 00:07:29 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 75F5FEA0AF
 for <qemu-devel@nongnu.org>; Thu,  4 Apr 2024 00:07:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1616222001B
 for <qemu-devel@nongnu.org>; Thu,  4 Apr 2024 00:07:27 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 4EC671A000A;
 Wed,  3 Apr 2024 23:07:26 +0800 (CST)
Message-ID: <ae5c692f-695a-460b-91e2-6f06fd7f7a05@fujitsu.com>
Date: Wed, 3 Apr 2024 23:07:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] cxl/core: report poison when injecting from
 debugfs
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
 <6607704e65437_19e0294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6607704e65437_19e0294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28296.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28296.000
X-TMASE-Result: 10--4.980400-10.000000
X-TMASE-MatchedRID: J/NqXV0mzJePvrMjLFD6eCkMR2LAnMRp2q80vLACqaeqvcIF1TcLYLBk
 jjdoOP1bmC+wH+KoDcqrpDDtyGscHMhblrt58Tvtlu85dvadcXUWqeZpZ9fc87Xl40gTGJ5pOiw
 t/WQfkJ9aM5U7dRXqm1+24nCsUSFNo15kJcETr3kE5D6PipCVdPoLR4+zsDTtjoczmuoPCq3PYP
 bCwt2AFNOepa69rWvf6wqJXNoGNOpDREfkwEJZkZFNs5Eh8tEZYUQsh3/i8KsV28zrYASWFI6x6
 pFVNL4fV/09m+gxY2iCiQtlEospUZ0Lgc2h7es/sjK6bXr6nJnV6V/ILXK7r4UrjkLnsIE8
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



在 2024/3/30 9:52, Dan Williams 写道:
> Shiyang Ruan wrote:
>> Poison injection from debugfs is silent too.  Add calling
>> cxl_mem_report_poison() to make it able to do memory_failure().
> 
> Why does this needs to be signalled? It is a debug interface, the
> debugger can also trigger a read after the injection, or trigger page
> soft-offline.

I was thinking that the poison injection should trigger a chain of 
events.  So, for debugfs they should be independent, right?  I wasn't 
aware of this.  Will drop this patch.


--
Thanks,
Ruan.

