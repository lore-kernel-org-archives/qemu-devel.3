Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086B0C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1Dn-0004SC-8R; Mon, 19 Feb 2024 05:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rc1Dl-0004R9-8r
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:50:01 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rc1Dj-0001AO-B0
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1708339800; x=1739875800;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=d8UmbUuuAGN5pgeVGQcwfJ3D8MXc0ov8Q4oLVueaUlA=;
 b=kSBEfxib2sBmDekeBqyOZsTXsaBqWNPHb4So9dqlwYymiDAGY7f3dSNP
 1swbmwMT5mlnYCh2srm2tnWMRaqYa8dXO8KoTI37sjWDi88GFht5lmJu5
 b3JUINWu5OKcIxFX5vtRJIUwFdgHmCAJpLjB0FESb81qE4zSOJLIUP4Dv
 WPAONxB3y5N/KuHVxbo/+hw9daSEyQdSx2bOknwzpZPUp5A8lUYQsqIhs
 Pfgy7GbwAC4qvk+cDV3n+f6gKGBASit9VvMprGBW3/UOq2aWke6gVmAah
 vh5DoCLjivcl6edI60HfiT4qkKuLqB1oPP7PHOSYvLaSRJJQcjAMXlsXC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="129157099"
X-IronPort-AV: E=Sophos;i="6.06,170,1705330800"; d="scan'208";a="129157099"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2024 19:49:56 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DAFA64DA87A
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 19:49:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1DF0AD621A
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 19:49:52 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E5BC20097789
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 19:49:51 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E91D71A006B;
 Mon, 19 Feb 2024 18:49:50 +0800 (CST)
Message-ID: <92d66f47-3b03-4128-8243-68f917c692f0@fujitsu.com>
Date: Mon, 19 Feb 2024 18:49:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] cxl/core: correct length of DPA field masks
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-4-ruansy.fnst@fujitsu.com>
 <65c718f786340_d2d4294b9@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65c718f786340_d2d4294b9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28200.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28200.006
X-TMASE-Result: 10--10.905100-10.000000
X-TMASE-MatchedRID: X+fKKgQJwrGPvrMjLFD6eCkMR2LAnMRp2q80vLACqaeqvcIF1TcLYLBk
 jjdoOP1bZ7SNREHYHRG4TDy5Lbm+t/RseJdyxL18Be3KRVyu+k2RgLeuORRdEsC5DTEMxpeQfiq
 1gj2xET/lxQMqjyUzSdgNg9jbo12SkfRhdidsajODGx/OQ1GV8rnUfzScNiR3DWKb6PcVvpiOhz
 Oa6g8KrRSQKMCB3VoeerNzoMmBWtUITClHxqpMBkVnRUzyyyjj3z7RgXDPuz8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa11.hc1455-7.c3s2.iphmx.com
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



在 2024/2/10 14:34, Dan Williams 写道:
> Shiyang Ruan wrote:
>> The length of Physical Address in General Media Event Record/DRAM Event
>> Record is 64-bit, so the field mask should be defined as such length.
> 
> Can you include this user visible side-effect of this change. Looks like
> this could cause usages of CXL_DPA_FLAGS_MASK to return an incorrect
> result?

Ok.  Will change it to this:

The length of Physical Address in General Media Event Record/DRAM Event 
Record is 64bit, per CXL Spec r3.0 - 8.2.9.2.1.1, Table 8-43.  Currently 
CXL_DPA_FLAGS_MASK is defined as int (32bit), then CXL_DPA_MASK is a int 
too, it will be 0x00000000FFFFFFC0 while using "->dpa & CXL_DPA_MASK" to 
obtain real physical address (to drop flags in lower bits), in this case 
the higher 32bit of ->dpa will be lost.

To avoid this, define CXL_DPA_FLAGS_MASK as 64bit: 0x3FULL.


--
Thanks,
Ruan.

> 
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/cxl/core/trace.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index 89445435303a..388a87d972c2 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
>>    * DRAM Event Record
>>    * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>>    */
>> -#define CXL_DPA_FLAGS_MASK			0x3F
>> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>>   #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>>   
>> -#define CXL_DPA_VOLATILE			BIT(0)
>> -#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
>> +#define CXL_DPA_VOLATILE			BIT_ULL(0)
>> +#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
>>   #define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
>>   	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
>>   	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
>> -- 
>> 2.34.1
>>
> 
> 

