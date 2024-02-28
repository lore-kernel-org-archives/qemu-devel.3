Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B55EC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfN6q-0003WN-4l; Wed, 28 Feb 2024 11:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfN6i-0003Qk-2p; Wed, 28 Feb 2024 11:48:37 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfN6f-0002fX-6Q; Wed, 28 Feb 2024 11:48:35 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7449360C0D;
 Wed, 28 Feb 2024 19:48:27 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a519::1:3a] (unknown
 [2a02:6b8:b081:a519::1:3a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Qmchgc1OkeA0-AYqkBFir; Wed, 28 Feb 2024 19:48:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709138907;
 bh=4sbvMl9rAgv7nQR64nbB9UU2QdPtbcxGVKGrN75NgiQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iL3sDZnC6ZjlAPHOet0Z9W3CpZTNZUMIFOJVnkeZPeiFVUcR6b5fAqZs0Q4LKEYot
 MI0+oLYv4TeNgiD8JbYZzAmkIHQAYgWujVPMghDdcYK5yN5fjlEQn5NAHpmHXtOIM5
 mhjTTyAYwvtFtBk/RxtbBKs0UVFhe/I9NUG1flww=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c9aa265d-9b3f-4504-a75b-31e08aef5c2f@yandex-team.ru>
Date: Wed, 28 Feb 2024 19:48:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blockcommit: Reopen base image as RO after abort
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com
References: <20240130091440.2346274-1-alexander.ivanov@virtuozzo.com>
 <fd599353-5d83-46c7-938f-c5ff30c4b647@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <fd599353-5d83-46c7-938f-c5ff30c4b647@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 09.02.24 15:29, Alexander Ivanov wrote:
> Could you please review the patch?

Sorry for long delay.

Honestly, I don't like refcnt in block-driver. It violate incapsulation, refcnt is interal thing of common block layer. And actually, you can't make any assumptions from value of refcnt, as you don't know which additional parents were created and why, and when they are going unref their children.

What was wrong with v2?

> 
> On 1/30/24 10:14, Alexander Ivanov wrote:
>> If a blockcommit is aborted the base image remains in RW mode, that leads
>> to a fail of subsequent live migration.
>>
>> How to reproduce:
>>    $ virsh snapshot-create-as vm snp1 --disk-only
>>
>>    *** write something to the disk inside the guest ***
>>
>>    $ virsh blockcommit vm vda --active --shallow && virsh blockjob vm vda --abort
>>    $ lsof /vzt/vm.qcow2
>>    COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
>>    qemu-syst 433203 root   45u   REG  253,0 1724776448  133 /vzt/vm.qcow2
>>    $ cat /proc/433203/fdinfo/45
>>    pos:    0
>>    flags:  02140002 <==== The last 2 means RW mode
>>
>> If the base image is in RW mode at the end of blockcommit and was in RO
>> mode before blockcommit, check if src BDS has refcnt > 1. If so, the BDS
>> will not be removed after blockcommit, and we should make the base image
>> RO. Otherwise check recursively if there is a parent BDS of src BDS and
>> reopen the base BDS in RO in this case.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/mirror.c | 38 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 5145eb53e1..52a7fee75e 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
>>       int64_t active_write_bytes_in_flight;
>>       bool prepared;
>>       bool in_drain;
>> +    bool base_ro;
>>   } MirrorBlockJob;
>>   typedef struct MirrorBDSOpaque {
>> @@ -652,6 +653,32 @@ static void coroutine_fn mirror_wait_for_all_io(MirrorBlockJob *s)
>>       }
>>   }
>> +/*
>> + * Check recursively if there is a parent BDS referenced more than
>> + * min_refcnt times. This argument is needed because at the first
>> + * call there is a bds referenced in blockcommit.
>> + */
>> +static bool bdrv_chain_has_significant_parent(BlockDriverState *bs)
>> +{
>> +    BdrvChild *parent;
>> +    BlockDriverState *parent_bs;
>> +
>> +    QLIST_FOREACH(parent, &bs->parents, next) {
>> +        if (!(parent->klass->parent_is_bds)) {
>> +            continue;
>> +        }
>> +        parent_bs = parent->opaque;
>> +        if (parent_bs->drv && !parent_bs->drv->is_filter) {
>> +            return true;
>> +        }
>> +        if (bdrv_chain_has_significant_parent(parent_bs)) {
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   /**
>>    * mirror_exit_common: handle both abort() and prepare() cases.
>>    * for .prepare, returns 0 on success and -errno on failure.
>> @@ -793,6 +820,11 @@ static int mirror_exit_common(Job *job)
>>       bdrv_drained_end(target_bs);
>>       bdrv_unref(target_bs);
>> +    if (s->base_ro && !bdrv_is_read_only(target_bs) &&
>> +        (src->refcnt > 1 || bdrv_chain_has_significant_parent(src))) {
>> +        bdrv_reopen_set_read_only(target_bs, true, NULL);
>> +    }
>> +
>>       bs_opaque->job = NULL;
>>       bdrv_drained_end(src);
>> @@ -1715,6 +1747,7 @@ static BlockJob *mirror_start_job(
>>                                bool is_none_mode, BlockDriverState *base,
>>                                bool auto_complete, const char *filter_node_name,
>>                                bool is_mirror, MirrorCopyMode copy_mode,
>> +                             bool base_ro,
>>                                Error **errp)
>>   {
>>       MirrorBlockJob *s;
>> @@ -1798,6 +1831,7 @@ static BlockJob *mirror_start_job(
>>       bdrv_unref(mirror_top_bs);
>>       s->mirror_top_bs = mirror_top_bs;
>> +    s->base_ro = base_ro;
>>       /* No resize for the target either; while the mirror is still running, a
>>        * consistent read isn't necessarily possible. We could possibly allow
>> @@ -2027,7 +2061,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>>                        speed, granularity, buf_size, backing_mode, zero_target,
>>                        on_source_error, on_target_error, unmap, NULL, NULL,
>>                        &mirror_job_driver, is_none_mode, base, false,
>> -                     filter_node_name, true, copy_mode, errp);
>> +                     filter_node_name, true, copy_mode, false, errp);
>>   }
>>   BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>> @@ -2056,7 +2090,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>>                        on_error, on_error, true, cb, opaque,
>>                        &commit_active_job_driver, false, base, auto_complete,
>>                        filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
>> -                     errp);
>> +                     base_read_only, errp);
>>       if (!job) {
>>           goto error_restore_flags;
>>       }
> 

-- 
Best regards,
Vladimir


