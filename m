Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBEBD3C92A
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 14:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2WbV-0006ty-Hv; Sun, 20 Oct 2024 10:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhipeng@cestc.cn>)
 id 1t2WbT-0006td-Bf; Sun, 20 Oct 2024 10:08:19 -0400
Received: from [1.203.97.246] (helo=smtp.cecloud.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luzhipeng@cestc.cn>)
 id 1t2WbQ-0004iz-SC; Sun, 20 Oct 2024 10:08:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.cecloud.com (Postfix) with ESMTP id C92B17C0112;
 Sun, 20 Oct 2024 22:08:02 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [192.168.0.101]
 (160.24.209.222.broad.cd.sc.dynamic.163data.com.cn [222.209.24.160])
 by smtp.cecloud.com (postfix) whith ESMTP id
 P880598T281472887878000S1729433280922563_; 
 Sun, 20 Oct 2024 22:08:02 +0800 (CST)
X-RL-SENDER: luzhipeng@cestc.cn
X-SENDER: luzhipeng@cestc.cn
X-LOGIN-NAME: luzhipeng@cestc.cn
X-FST-TO: kwolf@redhat.com
X-RCPT-COUNT: 5
X-LOCAL-RCPT-COUNT: 0
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 222.209.24.160
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <cccd49ad7be6f790f0314439f36b7bd1>
X-System-Flag: 0
Message-ID: <af33e20d-22b2-54bc-3082-e8c792549aad@cestc.cn>
Date: Sun, 20 Oct 2024 22:07:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] vmdk:truncate more one sector in init extent
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20240822105237.777-1-luzhipeng@cestc.cn>
 <ZxKNd_KqTJ9p_IIg@redhat.com>
From: Zhipeng Lu <luzhipeng@cestc.cn>
In-Reply-To: <ZxKNd_KqTJ9p_IIg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 1.203.97.246 (failed)
Received-SPF: pass client-ip=1.203.97.246; envelope-from=luzhipeng@cestc.cn;
 helo=smtp.cecloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.958,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



在 2024/10/19 0:31, Kevin Wolf 写道:
> Am 22.08.2024 um 12:52 hat luzhipeng geschrieben:
>> issue:https://gitlab.com/qemu-project/qemu/-/issues/1357
>> empty vmdk only contains metadata, ovftool failed.
>> So it allocates more one sector for empty disk. the ovftool
>> command line: ovftool input.ovf output.ova
>>
>> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
> 
> I think this commit message needs more of the information from the bug
> report, otherwise it seems unexplainable why adding an empty sector
> should make a difference.


I really don't know the real reason, I suspect it's a special 
requirement of the ovftool tool,
but this issue does exist.

>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index 78f6433607..283dee9b49 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -2286,7 +2286,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
>>           goto exit;
>>       }
>>   
>> -    ret = blk_co_truncate(blk, le64_to_cpu(header.grain_offset) << 9, false,
>> +    ret = blk_co_truncate(blk, (le64_to_cpu(header.grain_offset) << 9) + BDRV_SECTOR_SIZE,
>> +                          false, PREALLOC_MODE_OFF, 0, errp);
>>       if (ret < 0) {
>>           goto exit;
> 
> This is not a good fix. It means that we will always leave an empty
> sector after the header, even if more data follows.
> 
> Does the problem really only happen with empty images? I think we don't
> necessarily add an end-of-stream marker for other images either, we just
> align the image size to full sectors at the end of 'qemu-img convert'.

this issue indeed exists.it is not fix for aligning the image size

> I wonder if vmdk_co_pwritev_compressed() should be changed to write both
> a footer and an explicit end-of-stream marker for streamOptimized images
> in the bytes == 0 case.
> 
> Kevin
> 
> 
> 



