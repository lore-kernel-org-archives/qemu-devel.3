Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C981B10BA428
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 05:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5zLL-0003KY-Ig; Fri, 27 Mar 2026 01:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w5zL9-0003Ge-Bv; Fri, 27 Mar 2026 01:02:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1w5zL3-0006Nb-UV; Fri, 27 Mar 2026 01:02:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF25DG124777; Fri, 27 Mar 2026 05:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Sbj5lW
 Yu4F0HgNcz855pYXRQR4iwDgu7HcPg8tMLQrE=; b=id7UFdlRJ3Wh3PAj4GuDLM
 Vb9/nW6onJtGij0Soh8sFA0PSbaOZpYSD7qH60EitF0D/DO2fSAS5+9hdUlyzVt7
 RrYO3XTZe45DjBpJ1kJIOvGR7nrQhYh6LNlDB182+xzuoXP/UTnjeT4VDU9ullXy
 o3Jfg3r75ZVzb4/gG7lNis8VOUfHS1DjNRSuhhhR9oKEAKe/Jw88gNb13W/KXadq
 slhIaGdFE4E694AwZ7z+Rj3bkDfA8vTZtw0Wy/dnuujdWeOVW/bEg4k3zVHQ67rF
 fvp8m3A3+hnn/CtEZsejp0DdEpmS+x0LfQmh3v3Eax/j2lRc9Oe1f1Rezg9YsYuA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv7f56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 05:02:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R23f8n004399;
 Fri, 27 Mar 2026 05:02:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2dtjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 05:02:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62R52NTU3539876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 05:02:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3614658055;
 Fri, 27 Mar 2026 05:02:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B6D058063;
 Fri, 27 Mar 2026 05:02:22 +0000 (GMT)
Received: from [9.61.246.71] (unknown [9.61.246.71])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 05:02:22 +0000 (GMT)
Message-ID: <ef9756a6-2017-4c4b-89d6-f9afc38b6c62@linux.ibm.com>
Date: Fri, 27 Mar 2026 00:02:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/3] aio-poll: refine iothread polling using
 weighted handler intervals
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-3-jhkim@linux.ibm.com>
 <20260325203716.GD701300@fedora>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260325203716.GD701300@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yQTOVEge3b6tDvvQXr89foHeN9DnuqPp
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c60f61 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZyGberuS7bgLldwtk9UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAzNCBTYWx0ZWRfX0/mCZJ5NiiDd
 YMJgQE53EBkKRIDbZIG7bpnINwvAs7zUCz8nXA9bNX/XZ7FK2sHvgAcTt8wIc7J7+Qtq8rA62ae
 Khxh4G8BRMormJfoMWyET0KUaVkwCBv2+I/I/u6uk+GBwR7B8P+1sCD7SsQeX6RubTbqVDMRE9C
 7D4zgdq436lH4MOYqxBUWApkfh18HIn0zqiuuoZj84RMVjRrxlukqDKpbQ/S+hizfquqmg21ufR
 fcwiovHCKpnnCM75FaS7fE5NcyGNcvuutImihZu1Ci/j/BqEhc7lUD0wKuTM9/lZQJsp47RG1Mg
 hFhNN+1aE6kv2HShyYXs5lmhKE0TQDZqsV1Q2Gote+kO/gM/Jrsn15B5ziyya9D1J0DuC8c2F12
 HqJBLc5zEpmxG5sG6h9M27UCmm7nICB+WC8LPUwSolfLm6pOQnSssXMX5L/2mDyGVeL4SEDOfjr
 sLFrlMMUid7BSigPYUQ==
X-Proofpoint-GUID: yQTOVEge3b6tDvvQXr89foHeN9DnuqPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/25/2026 3:37 PM, Stefan Hajnoczi wrote:
> On Mon, Mar 23, 2026 at 08:54:50AM -0500, Jaehoon Kim wrote:
>> Refine adaptive polling in aio_poll by updating iothread polling
>> duration based on weighted AioHandler event intervals.
>>
>> Each AioHandler's poll.ns is updated using a weighted factor when an
>> event occurs. Idle handlers accumulate block_ns until poll_max_ns and
>> then reset to 0, preventing sporadically active handlers from
>> unnecessarily prolonging iothread polling.
>>
>> The iothread polling duration is set based on the largest poll.ns among
>> active handlers. The shrink divider defaults to 2, matching the grow
>> rate, to reduce frequent poll_ns resets for slow devices.
>>
>> The default weight factor (POLL_WEIGHT_SHIFT=3, meaning the current
>> interval contributes 12.5% to the weighted average) was selected based
>> on extensive testing comparing QEMU 10.0.0 baseline vs poll-weight=2
>> and poll-weight=3 across various workloads.
>>
>> The table below shows a comparison between:
>> -Host: RHEL 10.1 GA + qemu-10.0.0-14.el10_1, Guest: RHEL 9.6GA vs.
>> -Host: RHEL 10.1 GA + qemu-10.0.0-14.el10_1 (w=2/w=3), Guest: RHEL 9.6GA
>> for FIO FCP and FICON with 1 iothread and 8 iothreads.
>> The values shown are the averages for numjobs 1, 4, and 8.
>>
>> Summary of results (% change vs baseline):
>>
>>                      | poll-weight=2      | poll-weight=3
>> --------------------|--------------------|-----------------
>> Throughput avg      | -2.4% (all tests)  | -2.2% (all tests)
>> CPU consumption avg | -10.9% (all tests) | -9.4% (all tests)
>>
>> Both weight=2 and weight=3 show significant CPU consumption reduction
>> (~10%) compared to baseline, which addresses the CPU utilization
>> regression observed in QEMU 10.0.0. The throughput impact is minimal
>> for both (~2%).
>>
>> Weight=3 is selected as the default because it provides slightly better
>> throughput (-2.2% vs -2.4%) while still achieving substantial CPU
>> savings (-9.4%). The difference between weight=2 and weight=3 is small,
>> but weight=3 offers a better balance for general-purpose workloads.
>>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> ---
>>   include/qemu/aio.h |   4 +-
>>   util/aio-posix.c   | 135 +++++++++++++++++++++++++++++++--------------
>>   util/async.c       |   1 +
>>   3 files changed, 99 insertions(+), 41 deletions(-)
>>
>> diff --git a/include/qemu/aio.h b/include/qemu/aio.h
>> index 8cca2360d1..6c77a190e9 100644
>> --- a/include/qemu/aio.h
>> +++ b/include/qemu/aio.h
>> @@ -195,7 +195,8 @@ struct BHListSlice {
>>   typedef QSLIST_HEAD(, AioHandler) AioHandlerSList;
>>   
>>   typedef struct AioPolledEvent {
>> -    int64_t ns;        /* current polling time in nanoseconds */
>> +    bool has_event; /* Flag to indicate if an event has occurred */
>> +    int64_t ns;     /* estimated block time in nanoseconds */
>>   } AioPolledEvent;
>>   
>>   struct AioContext {
>> @@ -306,6 +307,7 @@ struct AioContext {
>>       int poll_disable_cnt;
>>   
>>       /* Polling mode parameters */
>> +    int64_t poll_ns;        /* current polling time in nanoseconds */
>>       int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
>>       int64_t poll_grow;      /* polling time growth factor */
>>       int64_t poll_shrink;    /* polling time shrink factor */
>> diff --git a/util/aio-posix.c b/util/aio-posix.c
>> index b02beb0505..2b3522f2f9 100644
>> --- a/util/aio-posix.c
>> +++ b/util/aio-posix.c
>> @@ -29,9 +29,11 @@
>>   
>>   /* Stop userspace polling on a handler if it isn't active for some time */
>>   #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
>> +#define POLL_WEIGHT_SHIFT   (3)
>>   
>> -static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
>> -                                int64_t block_ns);
>> +static void adjust_block_ns(AioContext *ctx, int64_t block_ns);
>> +static void grow_polling_time(AioContext *ctx, int64_t block_ns);
>> +static void shrink_polling_time(AioContext *ctx, int64_t block_ns);
>>   
>>   bool aio_poll_disabled(AioContext *ctx)
>>   {
>> @@ -373,7 +375,7 @@ static bool aio_dispatch_ready_handlers(AioContext *ctx,
>>            * add the handler to ctx->poll_aio_handlers.
> This comment refers to adjusting the polling time. The code no longer
> does this and the comment should be updated.
The comment about adjusting polling time is no longer accurate.
I will update it in the next version.
>>            */
>>           if (ctx->poll_max_ns && QLIST_IS_INSERTED(node, node_poll)) {
>> -            adjust_polling_time(ctx, &node->poll, block_ns);
> aio_dispatch_ready_handlers() no longer uses the block_ns argument. It
> can be removed.
I will remove the block_ns argument in the next version.
>> +            node->poll.has_event = true;
>>           }
>>       }
>>   
>> @@ -560,18 +562,13 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
>>   static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
>>                             int64_t *timeout)
>>   {
>> -    AioHandler *node;
>>       int64_t max_ns;
>>   
>>       if (QLIST_EMPTY_RCU(&ctx->poll_aio_handlers)) {
>>           return false;
>>       }
>>   
>> -    max_ns = 0;
>> -    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
>> -        max_ns = MAX(max_ns, node->poll.ns);
>> -    }
>> -    max_ns = qemu_soonest_timeout(*timeout, max_ns);
>> +    max_ns = qemu_soonest_timeout(*timeout, ctx->poll_ns);
>>   
>>       if (max_ns && !ctx->fdmon_ops->need_wait(ctx)) {
>>           /*
>> @@ -587,46 +584,98 @@ static bool try_poll_mode(AioContext *ctx, AioHandlerList *ready_list,
>>       return false;
>>   }
>>   
>> -static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
>> -                                int64_t block_ns)
>> +static void shrink_polling_time(AioContext *ctx, int64_t block_ns)
>>   {
>> -    if (block_ns <= poll->ns) {
>> -        /* This is the sweet spot, no adjustment needed */
>> -    } else if (block_ns > ctx->poll_max_ns) {
>> -        /* We'd have to poll for too long, poll less */
>> -        int64_t old = poll->ns;
>> -
>> -        if (ctx->poll_shrink) {
>> -            poll->ns /= ctx->poll_shrink;
>> -        } else {
>> -            poll->ns = 0;
>> -        }
>> +    /*
>> +     * Reduce polling time if the block_ns is zero or
>> +     * less than the current poll_ns.
>> +     */
>> +    int64_t old = ctx->poll_ns;
>> +    int64_t shrink = ctx->poll_shrink;
>>   
>> -        trace_poll_shrink(ctx, old, poll->ns);
>> -    } else if (poll->ns < ctx->poll_max_ns &&
>> -               block_ns < ctx->poll_max_ns) {
>> -        /* There is room to grow, poll longer */
>> -        int64_t old = poll->ns;
>> -        int64_t grow = ctx->poll_grow;
>> +    if (shrink == 0) {
>> +        shrink = 2;
>> +    }
>>   
>> -        if (grow == 0) {
>> -            grow = 2;
>> -        }
>> +    if (block_ns < (ctx->poll_ns / shrink)) {
>> +        ctx->poll_ns /= shrink;
>> +    }
>>   
>> -        if (poll->ns) {
>> -            poll->ns *= grow;
>> -        } else {
>> -            poll->ns = 4000; /* start polling at 4 microseconds */
>> -        }
>> +    trace_poll_shrink(ctx, old, ctx->poll_ns);
> This trace event should be inside if (block_ns < (ctx->poll_ns /
> shrink)) like it was before this patch.
>
>> +}
>>   
>> -        if (poll->ns > ctx->poll_max_ns) {
>> -            poll->ns = ctx->poll_max_ns;
>> -        }
>> +static void grow_polling_time(AioContext *ctx, int64_t block_ns)
>> +{
>> +    /* There is room to grow, poll longer */
>> +    int64_t old = ctx->poll_ns;
>> +    int64_t grow = ctx->poll_grow;
>>   
>> -        trace_poll_grow(ctx, old, poll->ns);
>> +    if (grow == 0) {
>> +        grow = 2;
>>       }
>> +
>> +    if (block_ns > ctx->poll_ns * grow) {
>> +        ctx->poll_ns = block_ns;
>> +    } else {
>> +        ctx->poll_ns *= grow;
>> +    }
>> +
>> +    if (ctx->poll_ns > ctx->poll_max_ns) {
>> +        ctx->poll_ns = ctx->poll_max_ns;
>> +    }
>> +
>> +    trace_poll_grow(ctx, old, ctx->poll_ns);
> Same here.
I will move the trace_poll_xxx functions inside if condition in the
next version.
>
>>   }
>>   
>> +static void adjust_block_ns(AioContext *ctx, int64_t block_ns)
>> +{
>> +    AioHandler *node;
>> +    int64_t adj_block_ns = -1;
>> +
>> +    QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
>> +        if (node->poll.has_event) {
> Did you consider unifying node->poll.has_event with
> node->poll_idle_timeout, which is assigned now + POLL_IDLE_INTERVAL_NS
> every time ->io_poll() detects an event?
>
> For instance, rename node->poll_idle_timeout to
> node->last_event_timestamp and assign now without adding
> POLL_IDLE_INTERVAL_NS. Then use the field for both idle node removal and
> adjust_block_ns() (pass in now).
Thank you for the suggestion, I think this is a good idea.
After testing, it seems that node->poll_idle_timeout can be reused as 
you suggested,
although a few adjustment are needed.

currently, an event is detected and the AioHandler is added to the 
ready_list in
three cases: run_poll_handler_once(), ctx->fdmon_ops-wait(), and 
poll_set_started().

To accurately track the last event timestamp of an AioHandler, it seems 
necessary to
update the timestamp in the following two functions:

@@ -45,6 +45,7 @@ void aio_add_ready_handler(AioHandlerList *ready_list,
  {
      QLIST_SAFE_REMOVE(node, node_ready); /* remove from nested 
parent's list */
      node->pfd.revents = revents;
+    node->poll_idle_timeout = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
      QLIST_INSERT_HEAD(ready_list, node, node_ready);
  }

@@ -53,6 +54,7 @@ static void aio_add_poll_ready_handler(AioHandlerList 
*ready_list,
  {
      QLIST_SAFE_REMOVE(node, node_ready); /* remove from nested 
parent's list */
      node->poll_ready = true;
+    node->poll_idle_timeout = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
      QLIST_INSERT_HEAD(ready_list, node, node_ready);
  }

In addition, remove_idle_poll_handler() would need some adjustments as well.
If this approach aligns with you had in mind, I believe it can be 
incorporated in
the next version without any issues.

>> +            /*
>> +             * Update poll.ns for the node with an event.
>> +             * Uses a weighted average of the current block_ns and the previous
>> +             * poll.ns to smooth out polling time adjustments.
>> +             */
>> +            node->poll.ns = node->poll.ns
>> +                ? (node->poll.ns - (node->poll.ns >> POLL_WEIGHT_SHIFT))
>> +                + (block_ns >> POLL_WEIGHT_SHIFT) : block_ns;
>> +
>> +            if (node->poll.ns > ctx->poll_max_ns) {
>> +                node->poll.ns = 0;
>> +            }
> Previously:
> -        if (poll->ns > ctx->poll_max_ns) {
> -            poll->ns = ctx->poll_max_ns;
> -        }
>
> Was this causing excessive CPU consumption in your benchmarks?
>
> Can you explain the rationale for zeroing the poll time? Aside from
> reducing CPU consumption, it also reduces the chance that polling will
> succeed and could therefore impact performance.
>
> I'm asking about this because this patch makes several changes at once
> and I'm not sure how the CPU usage and performance changes are
> attributed to these multiple changes. I want to make sure the changes
> merged are minimal and the best set - sometimes when multiple things are
> changes at the same time, not all of them are beneficial.

This snippet you quoted under "Previously" is also reflected in the logic
within grow_polling_time() where a same approach is used.

The difference is that previously. all AioHandler in the reay_list would
update their own poll.ns using block_ns. As in the snippet below,
if block_ns exceeded poll_max_ns, it would effectively be reset to 0 anyway.

-    } else if (block_ns > ctx->poll_max_ns) {
-        /* We'd have to poll for too long, poll less */
-        int64_t old = poll->ns;
-
-        if (ctx->poll_shrink) {
-            poll->ns /= ctx->poll_shrink;
-        } else {
-            poll->ns = 0;
-        }

I think I did not explain this part clearly enough in the commit message.
Here’s a more detailed explanation of the current polling logic problem 
and approach:

Problem:
Starting from QEMU 10.0, poll.ns was introduced per event handler to 
mitigate excessive
fluctuations in IOThread polling times observed in earlier versions 
(QEMU 9.x).

However, in the current design, poll.ns is updated only when an event 
occurs, making it
difficult to treat block_ns as a reliable event interval. Also, The 
IOThread’s next
polling time is determined by the maximum poll.ns among all AioHandlers, 
which means
idle AioHandlers with high poll.ns can have an outsized impact on the 
polling duration.

For io_uring, idle AioHandlers are cleared after POLL_IDLE_INTERVAL_NS 
(7s), but
ppoll/epoll, there is no such mechanism, so CPU consumption due to idle 
nodes can
increase even more.

Approach:
To address this, we treat block_ns as an event interval and update each 
AioHandler’s
poll.ns using a weighted factor. This smooths out polling time 
adjustments, preventing
excessive fluctuations and ensuring that recent event intervals are 
properly reflected,
which helps maintain performance while lowering CPU utilization.

To use block_ns as an event interval, we update polling times for both event
and non-event AioHandlers in each loop iteration. Non-event AioHandler 
do not require
a weighted factor; this allows for rapid isolation of idle nodes, while 
ensuring that
poll.ns can increase more responsively when an event occurs within a few 
subsequent loops.

>> +            /*
>> +             * To avoid excessive polling time increase, update adj_block_ns
>> +             * for nodes with the event flag set to true
>> +             */
>> +            adj_block_ns = MAX(adj_block_ns, node->poll.ns);
> adj_block_ns is not the blocking time, it's the maximum current poll
> time across all nodes. It would be clearer to change the variable name.
You're right. I will rename it to max_poll_ns to better reflect its 
purpose.
>> +            node->poll.has_event = false;
>> +         } else {
> 4-space indentation should be used.
I will also fix the indentation.
>
>> +            /*
>> +             * No event now, but was active before.
>> +             * If it waits longer than poll_max_ns, poll.ns will stay 0
>> +             * until the next event arrives.
>> +             */
>> +            if (node->poll.ns != 0) {
>> +                node->poll.ns += block_ns;
> Why is block_ns being added to an recently inactive node's polling time?
> Here node->poll.ns no longer measures the weighted time until the
> handler had an event.
>
> If the goal is to get rid of inactive nodes, then maybe the idle handler
> removal mechanism should be made more aggresive instead?
>
>> +                if (node->poll.ns > ctx->poll_max_ns) {
>> +                    node->poll.ns = 0;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    if (adj_block_ns >= 0) {
>> +        if (adj_block_ns > ctx->poll_ns) {
>> +            grow_polling_time(ctx, adj_block_ns);
>> +        } else {
>> +            shrink_polling_time(ctx, adj_block_ns);
>> +         }
>> +     }
>> + }
>> +
>>   bool aio_poll(AioContext *ctx, bool blocking)
>>   {
>>       AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
>> @@ -723,6 +772,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
>>   
>>       aio_free_deleted_handlers(ctx);
>>   
>> +    if (ctx->poll_max_ns) {
>> +        adjust_block_ns(ctx, block_ns);
>> +    }
>> +
>>       qemu_lockcnt_dec(&ctx->list_lock);
>>   
>>       progress |= timerlistgroup_run_timers(&ctx->tlg);
>> @@ -784,6 +837,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>>   
>>       qemu_lockcnt_inc(&ctx->list_lock);
>>       QLIST_FOREACH(node, &ctx->aio_handlers, node) {
>> +        node->poll.has_event = false;
>>           node->poll.ns = 0;
>>       }
>>       qemu_lockcnt_dec(&ctx->list_lock);
>> @@ -794,6 +848,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>>       ctx->poll_max_ns = max_ns;
>>       ctx->poll_grow = grow;
>>       ctx->poll_shrink = shrink;
>> +    ctx->poll_ns = 0;
>>   
>>       aio_notify(ctx);
>>   }
>> diff --git a/util/async.c b/util/async.c
>> index 80d6b01a8a..9d3627566f 100644
>> --- a/util/async.c
>> +++ b/util/async.c
>> @@ -606,6 +606,7 @@ AioContext *aio_context_new(Error **errp)
>>       timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
>>   
>>       ctx->poll_max_ns = 0;
>> +    ctx->poll_ns = 0;
>>       ctx->poll_grow = 0;
>>       ctx->poll_shrink = 0;
>>   
>> -- 
>> 2.50.1
>>


