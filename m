Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F43C54E60
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 02:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkxJz-00069R-60; Thu, 14 Mar 2024 22:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rkxJw-000691-V3
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 22:29:21 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rkxJt-0004KW-2f
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 22:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1710469756; x=1742005756;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9hZ9QgaNYwoI99lUQxp/3ftJBswYg/gLMcRjg38Y3Ng=;
 b=eX761rKveklLSpcnVVPpnNn6kdfeMS+fy+huBMv1jn51NBfVT0q0+eL5
 Am58eJg9YPEhTUoa4/mucRVyM/2xWcjQdoUGy6RFDGcBsj4hxct5tYkJc
 RPHr/YR0XLZFW68oxLuzpUeTqk/0MoaOR/4xfeQBPfkcPGbdWbJfWrcvC
 QJJsOElrBel0TOVlrBUOI19YbUSFI4peiIv57InhpG086n69Z0wwrma3J
 hRrh+luVZ7SO8+DZza2EfYwDbUV0mpW4KZxDWzV4OI4uYQJs2o6SQnIWO
 SJUJd/hhnNVLrWRKZBYPjhumxkB36At0cFJev6XYd8AHKMVdXzeDMhxDh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="140310837"
X-IronPort-AV: E=Sophos;i="6.07,127,1708354800"; d="scan'208";a="140310837"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 11:29:11 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 40EB8FBD93
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 11:29:09 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 86629FA5E
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 11:29:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 021B220097E4F
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 11:29:08 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6D72A1A006C;
 Fri, 15 Mar 2024 10:29:07 +0800 (CST)
Message-ID: <48223415-8466-480d-86e1-8b9945782c0c@fujitsu.com>
Date: Fri, 15 Mar 2024 10:29:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] cxl/core: add poison injection event handler
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, dan.j.williams@intel.com
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-8-ruansy.fnst@fujitsu.com>
 <20240213165150.00006d9a@Huawei.com>
In-Reply-To: <20240213165150.00006d9a@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28252.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28252.004
X-TMASE-Result: 10--21.396700-10.000000
X-TMASE-MatchedRID: 5U6uFEJz7+qPvrMjLFD6eJTQgFTHgkhZ2q80vLACqadlEv6AItKWFy/6
 oQ/dDcvKy38TH6dNchXJPxJtAmAiU2tppRWiT/6uZAV3hs6etPpNLPQl0QAltNbZhgeyVPQj0cb
 Kh4SdBY7G9WPCYEtgIpcltWa2cevGRdvJFOk47xeuW2+UBGEpHTVEnbrqmBw7OQ/k0Ia5E6hkcT
 XUAfcQrznpSV66h8LN2r3f3jyDzpOJ/ssfpZm9q95x7RpGJf1awBi8lRTMyBoUnySvXGc7qro8P
 QV15rjgpBGZFKPZXG2nnGms2c1SHC+5NdfXUqybjrVn4cme+w59LQinZ4QefNQdB5NUNSsiDrBA
 jvbPhh50HSe131POnpBlLa6MK1y4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
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



在 2024/2/14 0:51, Jonathan Cameron 写道:
> 
>> +
>> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
>> +			     enum cxl_event_log_type type,
>> +			     enum cxl_event_type event_type,
>> +			     const uuid_t *uuid, union cxl_event *evt)
>> +{
>> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>>   		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
>> -	else if (event_type == CXL_CPER_EVENT_DRAM)
>> +		/* handle poison event */
>> +		if (type == CXL_EVENT_TYPE_FAIL)
>> +			cxl_event_handle_poison(cxlmd, &evt->gen_media);
> 
> I'm not 100% convinced this is necessary poison causing.  Also
> the text tells us we should see 'an appropriate event'.
> DRAM one seems likely to be chosen by some vendors.

I think it's right to use DRAM Event Record for volatile-memdev, but 
should poison on a persistent-memdev also use DRAM Event Record too? 
Though its 'Physical Address' feild has the 'Volatile' bit too, which is 
same as General Media Event Record.  I am a bit confused about this.

> 
> The fatal check maybe makes it a little more likely (maybe though
> I'm not sure anything says a device must log it to the failure log)
> but it might be Memory Event Type 1, which is the host tried to
> access an invalid address.  Sure poison might be returned to that
> error but what would the main kernel memory handling do with it?
> Something is very wrong
> but it's not corrupted device memory.  TE state violations are in there
> as well. Sure poison is returned on reads (I think - haven't checked).
> 
> IF the aim here is to say 'maybe there is poison, better check the
> poison list'. Then that is reasonable but we should ensure things
> like timer expiry are definitely ruled out and rename the function
> to make it clear it might not find poison.

I forgot to distinguish the 'Transaction Type' here. Host Inject Poison 
is 0x04h. And other types should also have their specific handle method.


--
Thanks,
Ruan.

> 
> Jonathan

