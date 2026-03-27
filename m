Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFAF10BA42F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 06:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w60KK-0001XI-Oc; Fri, 27 Mar 2026 02:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w60KJ-0001Wn-Bf
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 02:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w60KH-0004kA-ND
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 02:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774591544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=le86Uo/V9EzbXiWqgWrfPqf9/JKpngndWxmtw27EEsM=;
 b=CCip1V0L7ncTJrHYCieNkYt0vV0aOODJcfGbzPrPoHbCviSmvSasV+G0Y3xJvw395omTc5
 vzjJbSmB4g9HaY5kNteYUHtYd0yB3YuCp1IX5AyFZ5a/o3GJgublTb5DFwDBNL1S4oyFzt
 xz7Jd9/Cxei0cQVrnSRnAQo4HNdg364=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-bHrQq8bzO-u0nDgL_wO0zg-1; Fri,
 27 Mar 2026 02:05:40 -0400
X-MC-Unique: bHrQq8bzO-u0nDgL_wO0zg-1
X-Mimecast-MFC-AGG-ID: bHrQq8bzO-u0nDgL_wO0zg_1774591538
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC0201956048; Fri, 27 Mar 2026 06:05:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E5C01800673; Fri, 27 Mar 2026 06:05:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA67121E6937; Fri, 27 Mar 2026 07:05:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,  <qemu-devel@nongnu.org>,
 <peterx@redhat.com>,  <farosas@suse.de>,  <lizhijian@fujitsu.com>,
 <eblake@redhat.com>,  <Emily.Deng@amd.com>,  <Victor.Zhao@amd.com>,
 <PengJu.Zhou@amd.com>,  <Qing.Ma@amd.com>
Subject: Re: [PATCH v2] migration/rdma: add x-rdma-chunk-size parameter
In-Reply-To: <7251ce8a-d5d6-491d-b885-44e4424c8b3e@amd.com> (GuoQing Zhang's
 message of "Fri, 27 Mar 2026 12:21:07 +0800")
References: <20260316062308.1240426-1-guoqing.zhang@amd.com>
 <20260326025825.2427332-1-guoqing.zhang@amd.com>
 <87jyuzhybv.fsf@pond.sub.org>
 <7251ce8a-d5d6-491d-b885-44e4424c8b3e@amd.com>
Date: Fri, 27 Mar 2026 07:05:35 +0100
Message-ID: <87wlyxbyds.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Zhang, GuoQing (Sam)" <guoqzhan@amd.com> writes:

> On 2026/3/26 14:57, Markus Armbruster wrote:
>> By convention, we don't post new patches in reply to old ones.  Next
>> time :)
>>
>> Samuel Zhang <guoqing.zhang@amd.com> writes:
>>
>>> The default 1MB RDMA chunk size causes slow live migration because
>>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>>> 1MB chunk size produce ~15000 flushes vs ~3700 with 1024MB chunk size.
>>>
>>> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
>>> faster migration.
>>> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>>>
>>> Performance with RDMA live migration of 8GB RAM VM:
>>>
>>> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
>>> |-----------------------|----------|-------------------|
>>> | 1M (default)          | 37.915   |  1,007            |
>>> | 32M                   | 17.880   |  2,260            |
>>> | 1024M                 |  4.368   | 17,529            |
>>>
>>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

[...]

>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>> index 55ab85650a..3e37a1d440 100644
>>> --- a/migration/rdma.c
>>> +++ b/migration/rdma.c
>>> @@ -45,10 +45,12 @@
>>>   #define RDMA_RESOLVE_TIMEOUT_MS 10000
>>>
>>>   /* Do not merge data if larger than this. */
>>> -#define RDMA_MERGE_MAX (2 * 1024 * 1024)
>>> -#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
>>> +static inline uint64_t rdma_merge_max(void)
>>> +{
>>> +    return migrate_rdma_chunk_size() * 2;
>>> +}
>>>
>>> -#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
>>> +#define RDMA_SIGNALED_SEND_MAX 512
>>>
>>>   /*
>>>    * This is only for non-live state being migrated.
>>> @@ -527,21 +529,21 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
>>>   static inline uint64_t ram_chunk_index(const uint8_t *start,
>>>                                          const uint8_t *host)
>>>   {
>>> -    return ((uintptr_t) host - (uintptr_t) start) >> RDMA_REG_CHUNK_SHIFT;
>>> +    return ((uintptr_t) host - (uintptr_t) start) / migrate_rdma_chunk_size();
>> Double-checking: this function isn't speed-critical, correct?
>
>
> It's not. it is called once per chunk during live-migration. And no performance change is observed when comparing with original implementation.
>
> Should I change it to `>> ctz64(migrate_rdma_chunk_size())` ?

The code needs to divide by the chunk size in a couple of places.

Before the patch, the chunk size, a power of two, is a compile-time
constant.  It's given as a shift count, but that hardly matters;
compilers are good at optimizing division by constant power of two to a
right shift.

Afterwards, it's a function that returns a power of two.  I don't expect
compilers to optimize division by that to a right shift.

Integer division is expensive.  Matters only on hot paths.  I don't
understand the code nearly enough to judge, so I asked.

We can cache the value of the shift count, and use it to shift instead
of divide.  Complicates the code.  Worthwhile only if the speed gain
matters.  You tell me it doesn't.  I have no reason to doubt you :)

[...]


