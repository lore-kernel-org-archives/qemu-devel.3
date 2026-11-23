Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F1606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUL7-0005R4-2Q; Mon, 23 Nov 2026 08:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuwei@sangfor.com.cn>)
 id 1xVUKz-0005QV-O8; Mon, 23 Nov 2026 08:44:06 -0500
Received: from mail-m81230.xmail.ntesmail.com ([156.224.81.230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuwei@sangfor.com.cn>)
 id 1xVUKw-0002vY-E6; Mon, 23 Nov 2026 08:44:05 -0500
Received: from [172.16.212.10] (unknown [43.247.70.81])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55ae9b5a9;
 Mon, 23 Nov 2026 21:34:42 +0800 (GMT+08:00)
Message-ID: <72d2d90f-fcac-40f7-9abb-d665c6923ba1@sangfor.com.cn>
Date: Mon, 23 Nov 2026 21:34:41 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1 ] block/monitor: fix BlockJobInfoList leak in
 hmp_info_block_jobs()
To: Eric Blake <eblake@redhat.com>, Zhu Wei <zachwade.k@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@pond.sub.org>, niming <niming@sangfor.com.cn>
References: <20261122114849.1672198-1-zhuwei@sangfor.com.cn>
 <20261122114849.1672198-2-zhuwei@sangfor.com.cn>
 <awQ_SF5DsUNmztdP@redhat.com>
From: zhuwei <zhuwei@sangfor.com.cn>
In-Reply-To: <awQ_SF5DsUNmztdP@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa2089db2e403a9kunmaef5df549c9043
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkJMVk4dGU1CHk0eSUpKSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
Received-SPF: pass client-ip=156.224.81.230;
 envelope-from=zhuwei@sangfor.com.cn; helo=mail-m81230.xmail.ntesmail.com
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



On 2026/11/23 21:28, Eric Blake wrote:
> On Sun, Nov 22, 2026 at 07:48:49PM +0800, Zhu Wei wrote:
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
>> Fixes: fb5458cd10a1 ("qmp: add query-block-jobs")
>> Signed-off-by: niming <niming@sangfor.com.cn>
>> Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
>> ---
>>   block/monitor/block-hmp-cmds.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Sorry,
the v4 update progress is as follows:
https://lore.kernel.org/qemu-devel/20261123132344.3154080-1-zhuwei@sangfor.com.cn/

