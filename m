Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E92606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 01:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTUKM-0000UC-J0; Tue, 17 Nov 2026 20:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuwei@sangfor.com.cn>)
 id 1xTUKH-0000R8-OC; Tue, 17 Nov 2026 20:19:05 -0500
Received: from mail-m1093.netease.com ([154.81.10.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuwei@sangfor.com.cn>)
 id 1xTUKE-0000uj-GQ; Tue, 17 Nov 2026 20:19:05 -0500
Received: from [172.16.212.10] (unknown [43.247.70.81])
 by smtp.qiye.163.com (Hmail) with ESMTP id 550d2e3a8;
 Wed, 18 Nov 2026 09:09:46 +0800 (GMT+08:00)
Message-ID: <99786c66-3217-4c7f-b406-9b3bcb241e95@sangfor.com.cn>
Date: Wed, 18 Nov 2026 09:09:45 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
To: Markus Armbruster <armbru@pond.sub.org>, Zhu Wei <zachwade.k@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 niming <niming@sangfor.com.cn>
References: <20261117144548.3252867-1-zhuwei@sangfor.com.cn>
 <20261117144548.3252867-2-zhuwei@sangfor.com.cn>
 <8733szjpra.fsf@pond.sub.org>
From: zhuwei <zhuwei@sangfor.com.cn>
In-Reply-To: <8733szjpra.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1ec33e44603a9kunm745cc833515303
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR0YVkgeHkxCThkZTxhDSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
Received-SPF: pass client-ip=154.81.10.93; envelope-from=zhuwei@sangfor.com.cn;
 helo=mail-m1093.netease.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/18 2:07, Markus Armbruster wrote:
> Zhu Wei <zachwade.k@gmail.com> writes:
> 
>> From: zhuwei <zhuwei@sangfor.com.cn>
>>
>> hmp_info_block_jobs() uses 'list' both as the head of the BlockJobInfoList
>> returned by qmp_query_block_jobs() and as the iterator of the while loop.
>> Once the loop finishes, 'list' is NULL, so the call to
>> qapi_free_BlockJobInfoList(list) at the end of the function frees nothing
>> and the whole list returned by qmp_query_block_jobs() is leaked.
>>
>> Keep the head of the list in a separate variable and free that one after
>> the loop, so the entire list is released as intended.
>>
>> Fixes: 2bcad73c4b9b ("monitor/hmp: move hmp_info_block* to block-hmp-cmds.c")
> 
> Pure code motion.  Please try again :)
> 
>> Signed-off-by: niming <niming@sangfor.com.cn>
>> Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
>> ---
>>   block/monitor/block-hmp-cmds.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
>> index 7bae4d425c..d3f404146a 100644
>> --- a/block/monitor/block-hmp-cmds.c
>> +++ b/block/monitor/block-hmp-cmds.c
>> @@ -760,7 +760,7 @@ void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
>>   
>>   void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>>   {
>> -    BlockJobInfoList *list;
>> +    BlockJobInfoList *list, *head;
>>   
>>       list = qmp_query_block_jobs(&error_abort);
>>   
>> @@ -769,6 +769,9 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>>           return;
>>       }
>>   
>> +    /* Keep the head: list is NULL once the loop below is done */
>> +    head = list;
>> +
>>       while (list) {
>>           if (list->value->type == JOB_TYPE_STREAM) {
>>               monitor_hmp_printf(hmp, "Streaming device %s: Completed %" PRId64
>> @@ -791,7 +794,7 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>>           list = list->next;
>>       }
>>   
>> -    qapi_free_BlockJobInfoList(list);
>> +    qapi_free_BlockJobInfoList(head);
>>   }
>>   
>>   void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
> 
> Patch looks good to me, but I'd drop the comment.
> 
I'd be glad to.

