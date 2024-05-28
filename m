Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970E0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtpc-0008Kp-1L; Tue, 28 May 2024 06:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sBtpY-0008KX-P8
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:13:21 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sBtpW-00047t-9R
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1716891198; x=1748427198;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=3aTs8dh6vJB0ZGKeLXBETd3JvGhZ0cm+ywEApGb6h98=;
 b=nPbF6C5fGhDSxM5K0nJx0ZYOCcQvFFUjIHdbCE0uBiNnAYX5kty7E966
 GFjGKe/+fizVEnBby8nuZFghiVav/XR7s7OSKvTmTRg0YNYsdeqiK2CJk
 86Ejv3IXbBQ2+lez7K9cIJDHR3FzrDSAcR2hWC0Et+evt/ktSLuisLGKe
 NPMSRf4yyouohltAjrGtOlMMlsq/Clq2iM1EALvhaoCQCDEobRPrbDZAM
 Ka+m1l+fEbiXeLRkU9m64hTCvktTsWggjmtjXMaUA1vC23mKs/80k6n74
 OT5m0/NisMC/aTXv1M9y4psYBJbpGOvuo4wPFCg9n8C/I6y70DGNdsxSa w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="139637808"
X-IronPort-AV: E=Sophos;i="6.08,195,1712588400"; d="scan'208";a="139637808"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 19:13:12 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 72FA4C3F94
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 19:13:10 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A61DFCFAAD
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 19:13:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2FE696BA6F
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 19:13:09 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 330C71A000A;
 Tue, 28 May 2024 18:13:08 +0800 (CST)
Message-ID: <cda2935f-d94b-4d01-a46e-5dd69d766d51@fujitsu.com>
Date: Tue, 28 May 2024 18:13:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <6628008c39e80_a96f29415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <b5eb1017-5f0a-4d68-bb63-41e628706a78@fujitsu.com>
 <b14ed74c-7fc5-461a-9c5f-fbb94df50e7d@fujitsu.com>
 <664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <28c92491-a892-4c9a-8c92-5d039681f817@fujitsu.com>
In-Reply-To: <28c92491-a892-4c9a-8c92-5d039681f817@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28414.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28414.006
X-TMASE-Result: 10--28.214300-10.000000
X-TMASE-MatchedRID: 5jn1KsaTNISPvrMjLFD6eJTQgFTHgkhZ2q80vLACqaeeT9kASxo4MUbg
 XczvLJKOpQJHQvYIR1VvedD3CYSjHdgW4k6aveo4TbFVCYPBTqYimo23ixY4DgUcMWdRj2fqZVh
 gLjSOksa18VsV6lgC4J+qZRE5XDC8dvvbftTsJScLwUwfdPoXvoiuaoNXJrK/rSPg4ph0OILDwJ
 S0XWHAkDLFcdqm3RNLokHVVVZ21OIuRdmDWOweyvwCyINrEjhruoYFb0nRiqPJxEA95JnWHmJo6
 KW+BOMMJK3weEsceTpJ9iwir5XT1WsV28ESZOe8DstQFfLVA/ATzLWUAQyt6P2Pg1z7MRXYtE9h
 falO+MqEju6+OLyeK+8j2/Qpcz48hpgZAljFgxOVOwZbcOalS26Pap1MPdtHMZJ6fLab4266PD0
 Fdea44H3NbsWb+gRT7qiScGBNfGZ3q5Rm8/DlxaoXHZz/dXlxEq8VpxNVVIlBDVeC8J7uwW8GLH
 2U1HrN7hkjCJvdG+GUQWt7uSfhDDoGIAjujgJmvHKClHGjjr0aDE2+94guwZsoi2XrUn/Jsuf7R
 WbvUtz7H+hZKy6/KwtuKBGekqUpPjKoPgsq7cA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.37.100;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa12.hc1455-7.c3s2.iphmx.com
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



在 2024/5/24 23:15, Shiyang Ruan 写道:
> 
> 
> 在 2024/5/22 14:45, Dan Williams 写道:
>> Shiyang Ruan wrote:
>> [..]
>>>>> My expectation is MF_ACTION_REQUIRED is not appropriate for CXL event
>>>>> reported errors since action is only required for direct consumption
>>>>> events and those need not be reported through the device event queue.
>>>> Got it.
>>>
>>> I'm not very sure about 'Host write/read' type.  In my opinion, these
>>> two types of event should be sent from device when CPU is accessing a
>>> bad memory address, they could be thought of a sync event which needs
>>
>> Hmm, no that's not my understanding of a sync event. I expect when error
>> notifications are synchronous the CPU is guaranteed not to make forward
>> progress past the point of encountering the error. MSI-signaled
>> component-events are always asynchronous by that definition because the
>> CPU is free running while the interrupt is in-flight.
> 
> Understood.  In OS-First path, it couldn't be a sync event.
> 
>>
>>> the 'MF_ACTION_REQUIRED' flag.  Then, we can determine the flag by the
>>> types like this:
>>> - CXL_EVENT_TRANSACTION_READ | CXL_EVENT_TRANSACTION_WRITE
>>>                                                 => MF_ACTION_REQUIRED
>>> - CXL_EVENT_TRANSACTION_INJECT_POISON         => MF_SW_SIMULATED
>>> - others                                      => 0
>>
>> I doubt any reasonable policy can be inferred from the transaction type.
>> Consider that the CPU itself does not take a sychronous exception when
>> writes encounter poison. At most those are flagged via CMCI
>> (corrected machine check interrupt). The only events that cause
>> exceptions are CPU reads that consume poison. The device has no idea
>> whether read events are coming from a CPU or a DMA event.
>>
>> MF_SW_SIMULATED is purely for software simulated poison events as
>> injected poison can stil cause system fatal damage if the poison is
>> ingested in an unrecoverable path.
>>
>> So, I think all CXL poison notification events should trigger an action
>> optional memory_failure(). I expect this needs to make sure that
>> duplicates re not a problem. I.e. in the case of CPU consumption of CXL
>> poison, that causes a synchronous MF_ACTION_REQUIRED event via the MCE
>> path *and* it may trigger the device to send an error record for the
>> same page. As far as I can see, duplicate reports (MCE + CXL device) are
>> unavoidable.
> 
> I think my previous understanding about MCE was wrong.  Here is my 
> current understanding after some research:
> 
> Since CXL device is a memory device, while CPU consumes a poison page of 
> CXL device, it always triggers a MCE by interrupt (INT18), no matter 
> which-First path is configured.  This is the first report.  Then 
> currently, in FW-First path, the poison event is transferred according 
> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES 
> -> MCE.  This is the second one.  These two MCEs represent the same 
> poisoning page, which is the so-called "duplicate report", right?  Now, 
> the memory_failure() handling I'm trying to add in OS-First path, is 
> also another duplicate report.

Let me summarize:
CPU accesses bad memory on CXL device, then
-> MCE (INT18), *always* report (1)
-> * FW-First (implemented)
      -> CXL device -> FW -> OS:ACPI->APEI->GHES -> MCE (2)
    * OS-First (not implemented yet, I'm working on it)
      -> CXL device -> MSI -> OS:CXL driver -> memory_failure() (2)
Then (1) and (2) are duplicated.

Looking forward your comment.  Thanks in advance!


--
Ruan.

> 
> So, the primary issue to be solved is the second MCE report.  As you 
> suggested, make it a optional action.
> 
> Please correct me if I'm wrong.  Thank you very much!
> 
> -- 
> Ruan.

