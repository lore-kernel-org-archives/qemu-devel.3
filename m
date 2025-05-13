Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0787AC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpg3-0007CO-32; Tue, 13 May 2025 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEpfV-0006fI-CR; Tue, 13 May 2025 09:27:42 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEpfR-000790-0G; Tue, 13 May 2025 09:27:35 -0400
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id DCBFC1520BB6;
 Tue, 13 May 2025 15:27:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1747142851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6jxRhm2BBQz8CLpjjhJ20WZa2cSa6qmql/muBZxp/jg=;
 b=cl+L1i6W6V5UAuQBescA2uqmWLurAxmrcKInVrj//ZijTXjViIa/hUaDghdbOxTXIIxYUf
 t//A211km/GJbwZHoCftbL2oLzzH8fqAwJittI8y1yBpgry9FOeXStK295sgi/Wz3mJHBp
 ryKWgshGF0F6oK3wFYQOhYra4oz/kt0txX0qte2tdyUW4T/1fosSa/tQBP2k2y1sgg8VlB
 Z51gDenjqC2D9ldI5MYsvMR1DfzlrOn0bNQnu0tPUYzWiS0eyktSuvjovZtgM/IX+yRrUO
 1rUkcIj9cHxQOci92d30mAit3pJ4LsjGhH6j2Khsh0LrC5gaeAfcn/jyE61Xvg==
Message-ID: <3143e992-b3e8-4ae4-90ec-39a8eb3e02f7@dupond.be>
Date: Tue, 13 May 2025 15:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qcow2: put discards in discard queue when
 discard-no-unref is enabled
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
References: <20250429103110.761910-1-jean-louis@dupond.be>
 <20250429103110.761910-3-jean-louis@dupond.be>
 <c43d6a3b-ac4e-4cee-b034-7ddcdf7dedf8@redhat.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <c43d6a3b-ac4e-4cee-b034-7ddcdf7dedf8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 5/12/25 14:28, Hanna Czenczek wrote:
> On 29.04.25 12:31, Jean-Louis Dupond wrote:
>> When discard-no-unref is enabled, discards are not queued like it
>> should.
>> This was broken since discard-no-unref was added.
>>
>> Add some helper function qcow2_discard_cluster which handles some common
>> checks and calls the queue_discards function if needed to add the
>> discard request to the queue.
>>
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   block/qcow2-cluster.c  | 16 ++++++----------
>>   block/qcow2-refcount.c | 19 ++++++++++++++++++-
>>   block/qcow2.h          |  4 ++++
>>   3 files changed, 28 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index ce8c0076b3..c655bf6df4 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -1978,12 +1978,10 @@ discard_in_l2_slice(BlockDriverState *bs, 
>> uint64_t offset, uint64_t nb_clusters,
>>           if (!keep_reference) {
>>               /* Then decrease the refcount */
>>               qcow2_free_any_cluster(bs, old_l2_entry, type);
>> -        } else if (s->discard_passthrough[type] &&
>> -                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
>> -                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
>> +        } else {
>>               /* If we keep the reference, pass on the discard still */
>> -            bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
>> -                          s->cluster_size);
>> +            qcow2_discard_cluster(bs, old_l2_entry & L2E_OFFSET_MASK,
>> +                                  s->cluster_size, cluster_type, type);
>>           }
>>       }
>>   @@ -2092,12 +2090,10 @@ zero_in_l2_slice(BlockDriverState *bs, 
>> uint64_t offset,
>>               if (!keep_reference) {
>>                   /* Then decrease the refcount */
>>                   qcow2_free_any_cluster(bs, old_l2_entry, 
>> QCOW2_DISCARD_REQUEST);
>> -            } else if (s->discard_passthrough[QCOW2_DISCARD_REQUEST] &&
>> -                       (type == QCOW2_CLUSTER_NORMAL ||
>> -                        type == QCOW2_CLUSTER_ZERO_ALLOC)) {
>> +            } else {
>>                   /* If we keep the reference, pass on the discard 
>> still */
>> -                bdrv_pdiscard(s->data_file, old_l2_entry & 
>> L2E_OFFSET_MASK,
>> -                            s->cluster_size);
>> +                qcow2_discard_cluster(bs, old_l2_entry & 
>> L2E_OFFSET_MASK,
>> +                            s->cluster_size, type, 
>> QCOW2_DISCARD_REQUEST);
>>               }
>>           }
>>       }
>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>> index d796018970..e1f830504d 100644
>> --- a/block/qcow2-refcount.c
>> +++ b/block/qcow2-refcount.c
>> @@ -1205,6 +1205,23 @@ void qcow2_free_any_cluster(BlockDriverState 
>> *bs, uint64_t l2_entry,
>>       }
>>   }
>>   +void qcow2_discard_cluster(BlockDriverState *bs, uint64_t offset,
>> +                           uint64_t length, QCow2ClusterType ctype,
>> +                           enum qcow2_discard_type dtype) {
>> +
>
> QEMU coding style requires putting the { on a separate line.
>
Fixed
>> +    BDRVQcow2State *s = bs->opaque;
>> +
>> +    if (s->discard_passthrough[dtype] &&
>> +        (ctype == QCOW2_CLUSTER_NORMAL ||
>> +         ctype == QCOW2_CLUSTER_ZERO_ALLOC)) {
>> +        if (has_data_file(bs)) {
>> +            bdrv_pdiscard(s->data_file, offset, length);
>> +        } else {
>> +            queue_discard(bs, offset, length);
>> +        }
>> +    }
>> +}
>> +
>>   int qcow2_write_caches(BlockDriverState *bs)
>>   {
>>       BDRVQcow2State *s = bs->opaque;
>> @@ -3619,7 +3636,7 @@ qcow2_discard_refcount_block(BlockDriverState 
>> *bs, uint64_t discard_block_offs)
>>           /* discard refblock from the cache if refblock is cached */
>>           qcow2_cache_discard(s->refcount_block_cache, refblock);
>>       }
>> -    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
>> +    queue_discard(bs, discard_block_offs, s->cluster_size);
>>         return 0;
>>   }
>
> This hunk should go into the previous patch.
>
Fixed
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index a9e3481c6e..547bb2b814 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -880,6 +880,10 @@ void GRAPH_RDLOCK 
>> qcow2_free_clusters(BlockDriverState *bs,
>>   void GRAPH_RDLOCK
>>   qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
>>                          enum qcow2_discard_type type);
>> +void GRAPH_RDLOCK
>> +qcow2_discard_cluster(BlockDriverState *bs, uint64_t offset,
>> +                      uint64_t length, QCow2ClusterType ctype,
>> +                      enum qcow2_discard_type dtype);
>>     int GRAPH_RDLOCK
>>   qcow2_update_snapshot_refcount(BlockDriverState *bs, int64_t 
>> l1_table_offset,
>
> With the above done, for both patch 1 and 2:
>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>
Send v2 patch with comments addressed.

Thanks
Jean-Louis

