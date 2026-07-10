Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CDCC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi6gl-00071B-Kq; Fri, 10 Jul 2026 04:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wi6gb-00070m-MM; Fri, 10 Jul 2026 04:34:19 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wi6gX-00014e-TX; Fri, 10 Jul 2026 04:34:16 -0400
Received: from [IPV6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1] (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id 187721520DA8;
 Fri, 10 Jul 2026 10:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1783672449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw6clpuHEBdONkM/kPMqS9gHm//7aRPf/tPCidxoklI=;
 b=MfAeurUnx03bVV8M6yJ56ZxuB7MepoLSTUUuwGMS3Wqjcbv8YOHHOoOgKIyzJKpmIyez4u
 VfrErp9ar1n3fXuH/Mq0cJeSd7FGMzaOINzomAYTDIdzQm63ZuPUQ9LYxshNlwiZUdzj/e
 /U8UkZhkxYagd7iLpfTBMC6RdZwiaNIaXOLFi/yTExyRDhr9xVhJvjA4+hHobWGWufqupi
 AISB5rP8srJedi+g8beraU5q5fCuo27/4dk7AEEnSwLO/uQJ43cSC/aakTcnV8AfimBVz4
 yv2S439PCgN4OqgEfjbUds1gNDlCdYhYDB4tDHHq4XaxLBvZ3EFdVS0A5cwMsg==
Message-ID: <7697a2b6-fc26-4de2-8cd6-0b3651b79511@dupond.be>
Date: Fri, 10 Jul 2026 10:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] qcow2: add functionality to repair bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>
References: <20260522224335.1286291-1-jean-louis@dupond.be>
 <20260522224335.1286291-2-jean-louis@dupond.be>
 <93dc8fbe-2346-430d-90f1-ca44b3970cd5@yandex-team.ru>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <93dc8fbe-2346-430d-90f1-ca44b3970cd5@yandex-team.ru>
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


On 29/06/2026 11:18, Vladimir Sementsov-Ogievskiy wrote:
> 23.05.26 01:43, Jean-Louis Dupond пишет:
>> In some cases, it might happen that bitmaps become corrupt.
>> For example when adding/removing bitmaps on a live image.
>>
>> Of course this should not happen, but in case this happens, the image is
>> corrupt and even cannot be opened anymore. You'll get something like the
>> following:
>> qemu-img: Could not open 'disk.qcow2': Bitmap '' doesn't satisfy the 
>> constraints
>>
>> So the image becomes useless, and cannot be repaired. This while in fact
>> only (one) bitmap entry is corrupt, and the rest of the data is just
>> intact.
>>
>> This commit adds a way to fix this corruption, by just replacing the
>> bitmap list in the qcow2 image with the valid bitmaps, and dropping the
>> bitmaps that are corrupt.
>>
>> $ qemu-img check disk.qcow2
>> qemu-img: Check failed: Invalid argument
>> qemu-img: Lost persistent bitmaps during inactivation of node 
>> '#block147': Bitmap '' doesn't satisfy the constraints
>>
>> $ qemu-img check -r all disk.qcow2
>> qcow2_free_clusters failed: Invalid argument
>> Leaked cluster 3 refcount=1 reference=0
>> Leaked cluster 26 refcount=1 reference=0
>> ERROR cluster 983214 refcount=0 reference=1
>> Rebuilding refcount structure
>> Repairing cluster 1 refcount=1 reference=0
>> Repairing cluster 2 refcount=1 reference=0
>> Repairing cluster 32768 refcount=1 reference=0
>> ....
>> Repairing cluster 983214 refcount=1 reference=0
>> The following inconsistencies were found and repaired:
>>
>>      2 leaked clusters
>>      3 corruptions
>>
>> Double checking the fixed image now...
>> No errors were found on the image.
>> 983056/1048576 = 93.75% allocated, 0.05% fragmented, 0.00% compressed 
>> clusters
>> Image end offset: 64437878784
>>
>> And the image is valid again!
>> Worst case you lose all bitmaps, but at least the image and the data
>> itself is useable again.
>>
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> (some nit-picking and notes below, but the patch is OK for me as is)
Thanks!
>
>> ---
>>   block/qcow2-bitmap.c   | 42 +++++++++++++++++++++++++++++++++++++++---
>>   block/qcow2-refcount.c |  3 ++-
>>   block/qcow2.c          | 16 ++++++++++++----
>>   block/qcow2.h          |  3 ++-
>>   4 files changed, 55 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 256ec99878..91bd82a9f5 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -100,6 +100,9 @@ typedef enum BitmapType {
>>       BT_DIRTY_TRACKING_BITMAP = 1
>>   } BitmapType;
>>   +static int GRAPH_RDLOCK
>> +update_ext_header_and_dir(BlockDriverState *bs, Qcow2BitmapList 
>> *bm_list);
>> +
>>   static inline bool can_write(BlockDriverState *bs)
>>   {
>>       return !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & 
>> BDRV_O_INACTIVE);
>> @@ -655,12 +658,14 @@ fail:
>>   int coroutine_fn
>>   qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult 
>> *res,
>>                                 void **refcount_table,
>> -                              int64_t *refcount_table_size)
>> +                              int64_t *refcount_table_size,
>> +                              BdrvCheckMode fix)
>>   {
>>       int ret;
>>       BDRVQcow2State *s = bs->opaque;
>>       Qcow2BitmapList *bm_list;
>> -    Qcow2Bitmap *bm;
>> +    Qcow2Bitmap *bm, *bm_next;
>> +    bool bitmap_modified = false;
>
> (I'd call it bm_list_modified, as we don't modify any bitmap..)
I slightly modified it to also address comment below.
>
>>         if (s->nb_bitmaps == 0) {
>>           return 0;
>> @@ -677,12 +682,21 @@ qcow2_check_bitmaps_refcounts(BlockDriverState 
>> *bs, BdrvCheckResult *res,
>>                                  s->bitmap_directory_size, NULL);
>>       if (bm_list == NULL) {
>>           res->corruptions++;
>> +
>> +        if (fix & BDRV_FIX_ERRORS) {
>> +            ret = update_ext_header_and_dir(bs, NULL);
>> +            if (ret >= 0) {
>> +                res->corruptions_fixed++;
>> +            }
>> +            goto out;
>
> I think, "return ret" is better here.
>
> at "out:" we only free the bm_list, which is NULL here anyway.
>
> And on the next line, we do "return -EINVAL", not "goto out", better 
> be consistent.
Fixed
>
>> +        }
>>           return -EINVAL;
>>       }
>>   -    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> +    QSIMPLEQ_FOREACH_SAFE(bm, bm_list, entry, bm_next) {
>>           uint64_t *bitmap_table = NULL;
>>           int i;
>> +        bool bitmap_valid = true;
>>             ret = qcow2_inc_refcounts_imrt(bs, res,
>>                                          refcount_table, 
>> refcount_table_size,
>> @@ -695,6 +709,12 @@ qcow2_check_bitmaps_refcounts(BlockDriverState 
>> *bs, BdrvCheckResult *res,
>>           ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
>>           if (ret < 0) {
>>               res->corruptions++;
>
> This maybe called several times per bitmap, but finally we calculate
> corruptions_fixed as bitmaps count.
>
> Still, I don't think it's important.
Modified to bm_list_fixed. Which counts the corruptions fixed.
Value is then used to increment corruptions_fixed.
>
>> +            if (fix & BDRV_FIX_ERRORS) {
>> +                QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
>> +                bitmap_free(bm);
>> +                bitmap_modified = true;
>> +                continue;
>> +            }
>>               goto out;
>>           }
>>   @@ -704,6 +724,7 @@ qcow2_check_bitmaps_refcounts(BlockDriverState 
>> *bs, BdrvCheckResult *res,
>>                 if (check_table_entry(entry, s->cluster_size) < 0) {
>>                   res->corruptions++;
>> +                bitmap_valid = false;
>>                   continue;
>>               }
>>   @@ -720,9 +741,24 @@ qcow2_check_bitmaps_refcounts(BlockDriverState 
>> *bs, BdrvCheckResult *res,
>>               }
>>           }
>
> Note, that if qcow2_inc_refcounts_imrt() fails, we'll fix nothing.
Indeed. Then we have deeper corruption.
I don't know if we could just ignore the failure if in BDRV_FIX_ERRORS 
mode and clear the bitmap table if call fails?
>
>>   +        if ((fix & BDRV_FIX_ERRORS) && !bitmap_valid) {
>> +            QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
>> +            bitmap_free(bm);
>> +            bitmap_modified = true;
>> +        }
>> +
>>           g_free(bitmap_table);
>>       }
>>   +    /* If fixing, update the bitmap directory with the repaired 
>> list */
>> +    if ((fix & BDRV_FIX_ERRORS) && bitmap_modified) {
>> +        uint32_t initial_bitmaps = s->nb_bitmaps;
>> +        ret = update_ext_header_and_dir(bs, bm_list);
>> +        if (ret >= 0) {
>> +            res->corruptions_fixed += initial_bitmaps - s->nb_bitmaps;
>> +        }
>> +    }
>> +
>>   out:
>>       bitmap_list_free(bm_list);
>>   diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>> index 6512cda407..df7f6d2f23 100644
>> --- a/block/qcow2-refcount.c
>> +++ b/block/qcow2-refcount.c
>> @@ -2305,7 +2305,8 @@ calculate_refcounts(BlockDriverState *bs, 
>> BdrvCheckResult *res,
>>       }
>>         /* bitmaps */
>> -    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table, 
>> nb_clusters);
>> +    ret = qcow2_check_bitmaps_refcounts(bs, res, refcount_table,
>> +                                        nb_clusters, fix);
>>       if (ret < 0) {
>>           return ret;
>>       }
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 81fd299b4c..adfb7ee37a 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1927,11 +1927,19 @@ qcow2_do_open(BlockDriverState *bs, QDict 
>> *options, int flags,
>>       if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
>>           /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management 
>> layer. */
>>           bool header_updated;
>> -        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, errp)) {
>> -            ret = -EINVAL;
>> -            goto fail;
>> +        Error *local_err = NULL;
>> +        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, 
>> &local_err)) {
>> +            /*
>> +             * Allow this to fail in check mode
>> +             * because otherwise we can't open the image at all.
>> +             */
>> +            if (!(flags & BDRV_O_CHECK)) {
>> +                ret = -EINVAL;
>> +                error_propagate(errp, local_err);
>> +                goto fail;
>> +            }
>
> Should we at least print local_err (I mean error_report_err())?
As we do an error_propagate this shouldn't be needed?
>
>> +            error_free(local_err);
>>           }
>> -
>>           update_header = update_header && !header_updated;
>>       }
>>   diff --git a/block/qcow2.h b/block/qcow2.h
>> index 192a45d596..2d9c6929a7 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -1034,7 +1034,8 @@ void qcow2_cache_discard(Qcow2Cache *c, void 
>> *table);
>>   int coroutine_fn GRAPH_RDLOCK
>>   qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult 
>> *res,
>>                                 void **refcount_table,
>> -                              int64_t *refcount_table_size);
>> +                              int64_t *refcount_table_size,
>> +                              BdrvCheckMode fix);
>>     bool coroutine_fn GRAPH_RDLOCK
>>   qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
>
>

I now have the following diff since v5, if you confirm it's ok, then 
I'll push a v6:

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 91bd82a9f5..90a109d9b2 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -665,7 +665,7 @@ qcow2_check_bitmaps_refcounts(BlockDriverState *bs, 
BdrvCheckResult *res,
      BDRVQcow2State *s = bs->opaque;
      Qcow2BitmapList *bm_list;
      Qcow2Bitmap *bm, *bm_next;
-    bool bitmap_modified = false;
+    int bm_list_fixed = 0;

      if (s->nb_bitmaps == 0) {
          return 0;
@@ -688,14 +688,14 @@ qcow2_check_bitmaps_refcounts(BlockDriverState 
*bs, BdrvCheckResult *res,
              if (ret >= 0) {
                  res->corruptions_fixed++;
              }
-            goto out;
+            return ret;
          }
          return -EINVAL;
      }

      QSIMPLEQ_FOREACH_SAFE(bm, bm_list, entry, bm_next) {
          uint64_t *bitmap_table = NULL;
-        int i;
+        int i, corruptions;
          bool bitmap_valid = true;

          ret = qcow2_inc_refcounts_imrt(bs, res,
@@ -712,12 +712,13 @@ qcow2_check_bitmaps_refcounts(BlockDriverState 
*bs, BdrvCheckResult *res,
              if (fix & BDRV_FIX_ERRORS) {
                  QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
                  bitmap_free(bm);
-                bitmap_modified = true;
+                bm_list_fixed++;
                  continue;
              }
              goto out;
          }

+        corruptions = res->corruptions;
          for (i = 0; i < bm->table.size; ++i) {
              uint64_t entry = bitmap_table[i];
              uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
@@ -744,18 +745,18 @@ qcow2_check_bitmaps_refcounts(BlockDriverState 
*bs, BdrvCheckResult *res,
          if ((fix & BDRV_FIX_ERRORS) && !bitmap_valid) {
              QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
              bitmap_free(bm);
-            bitmap_modified = true;
+            bm_list_fixed += res->corruptions - corruptions;
          }

          g_free(bitmap_table);
      }

      /* If fixing, update the bitmap directory with the repaired list */
-    if ((fix & BDRV_FIX_ERRORS) && bitmap_modified) {
+    if ((fix & BDRV_FIX_ERRORS) && bm_list_fixed > 0) {
          uint32_t initial_bitmaps = s->nb_bitmaps;
          ret = update_ext_header_and_dir(bs, bm_list);
          if (ret >= 0) {
-            res->corruptions_fixed += initial_bitmaps - s->nb_bitmaps;
+            res->corruptions_fixed += bm_list_fixed;
          }
      }



