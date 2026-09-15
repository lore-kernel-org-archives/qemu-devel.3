Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A63EC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6TmN-0000hH-Qz; Tue, 15 Sep 2026 10:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1x6TlS-0008J8-9G; Tue, 15 Sep 2026 10:04:05 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1x6TlN-0002Ci-0Z; Tue, 15 Sep 2026 10:04:00 -0400
Received: from [IPV6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1] (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id EB36A1520F75;
 Tue, 15 Sep 2026 16:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1789481033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XiJz0m1wygC5b9dvN97I5pqwzV6hZMl3PC9/B9wx1zg=;
 b=LrFex63TnZhV2tM+21o0yGH70+fnS/N9jZP/iloucAcU5EVVY1Np27f5ct556kXNBEzxMv
 tvX/FbaBMQ6NEgsBNzvswHdNJXo7n3PMeQ+co43CzyuZzkoWmlMQ5FPddwDT4sRyFpqgEU
 K1n2chh1diNeF6YTj07W2r/HzKLeajA40+L3eXdbI6rhLzidkca9MHoquA1FbdalmlWFIH
 rmh6gMkcetUOq7FtyB373Dx1IxykegZ9wvwoEcJYJe1MGuMGlUMTNwUgNXyheHjgNWynOu
 5DHXnrP6CNM0oYpd+uSLb3fVJCuYWHfN8Ve44W55cMZLey2qL/WZhmIAXH5J6g==
Message-ID: <8bd4159b-afde-46ad-9373-cfc90766960b@dupond.be>
Date: Tue, 15 Sep 2026 16:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: add bdrv_open_backing_chain_until
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 John Snow <jsnow@redhat.com>
References: <20260608110346.3231998-1-jean-louis@dupond.be>
 <20260608110346.3231998-2-jean-louis@dupond.be>
 <7ccc4f77-147b-4f4b-8a4c-d8f61f5cc2a5@yandex-team.ru>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <7ccc4f77-147b-4f4b-8a4c-d8f61f5cc2a5@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
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

Found some time to work further on it :)


On 24/06/2026 20:44, Vladimir Sementsov-Ogievskiy wrote:
> 08.06.26 14:03, Jean-Louis Dupond пишет:
>> Add a new function called bdrv_open_backing_chain_until.
>> This is used to open a block up until a specified backing chain.
>>
>> Modified bdrv_open_inherit to accept a new arg 'open_backing' to force
>> to to no open the next backing. Adjusting all references to keep the
>> existing behaviour.
>>
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   block.c                            | 65 +++++++++++++++++++++++++-----
>>   block/mirror.c                     |  2 +-
>>   include/block/block-global-state.h |  7 +++-
>>   3 files changed, 62 insertions(+), 12 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index f0a6042e61..a4f4ce1c21 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -83,6 +83,7 @@ static QLIST_HEAD(, BlockDriver) bdrv_drivers =
>>   static BlockDriverState *bdrv_open_inherit(const char *filename,
>>                                              const char *reference,
>>                                              QDict *options, int flags,
>> +                                           bool open_backing,
>>                                              BlockDriverState *parent,
>>                                              const BdrvChildClass 
>> *child_class,
>>                                              BdrvChildRole child_role,
>> @@ -3617,6 +3618,7 @@ out:
>>    * TODO Can this be unified with bdrv_open_image()?
>>    */
>>   int bdrv_open_backing_file(BlockDriverState *bs, QDict 
>> *parent_options,
>> +                           bool open_backing,
>
> "open_backing" boolean parameter for "bdrv_open_backing_file" is 
> misleading.
>
I renamed it to `open_backing_recursively` now.
>>                              const char *bdref_key, Error **errp)
>>   {
>>       ERRP_GUARD();
>> @@ -3695,9 +3697,9 @@ int bdrv_open_backing_file(BlockDriverState 
>> *bs, QDict *parent_options,
>>           qdict_put_str(options, "driver", bs->backing_format);
>>       }
>>   -    backing_hd = bdrv_open_inherit(backing_filename, reference, 
>> options, 0, bs,
>> -                                   &child_of_bds, 
>> bdrv_backing_role(bs), true,
>> -                                   errp);
>> +    backing_hd = bdrv_open_inherit(backing_filename, reference, 
>> options, 0,
>> +                                   open_backing, bs, &child_of_bds,
>> +                                   bdrv_backing_role(bs), true, errp);
>>       if (!backing_hd) {
>>           bs->open_flags |= BDRV_O_NO_BACKING;
>>           error_prepend(errp, "Could not open backing file: ");
>> @@ -3733,6 +3735,48 @@ free_exit:
>>       return ret;
>>   }
>>   +int
>> +bdrv_open_backing_chain_until(BlockDriverState *top_bs,
>> +                              const char *base_filename,
>> +                              Error **errp)
>> +{
>> +    BlockDriverState *base_bs = NULL;
>> +    BlockDriverState *curr = top_bs;
>> +    int ret;
>> +
>> +    GLOBAL_STATE_CODE();
>> +
>> +    if (!base_filename) {
>> +        return 0;
>> +    }
>> +
>> +    while (!(base_bs = bdrv_find_backing_image(top_bs, 
>> base_filename))) {
>
> So we do a downward cycle, and on each iteration call 
> bdrv_find_backing_image(),
> making same downward cycle.
>
> Maybe better to modify bdrv_find_backing_image(), adding boolean 
> parameter "do_open"?
I reworked bdrv_open_backing_chain_until a bit now.
I'll push a v2
>
>> +        QDict *options;
>> +
>> +        options = qdict_clone_shallow(curr->options);
>> +        ret = bdrv_open_backing_file(curr, options, false, 
>> "backing", errp);
>> +        qobject_unref(options);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +
>> +        bdrv_graph_rdlock_main_loop();
>
> I don't know actually, how to use this lock properly, but the only 
> preexisting
> call to bdrv_open_backing_file() is done under this lock.
>
>> +        if (!curr->backing) {
>> +            bdrv_graph_rdunlock_main_loop();
>> +            error_setg(errp,
>> +                       "Did not find '%s' in the backing chain of 
>> '%s'",
>> +                       base_filename, top_bs->filename);
>> +            return -ENOENT;
>> +        }
>> +
>> +        /* Switch to the next layer */
>> +        curr = curr->backing->bs;
>> +        bdrv_graph_rdunlock_main_loop();
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static BlockDriverState *
>>   bdrv_open_child_bs(const char *filename, QDict *options, const char 
>> *bdref_key,
>>                      BlockDriverState *parent, const BdrvChildClass 
>> *child_class,
>> @@ -3767,7 +3811,7 @@ bdrv_open_child_bs(const char *filename, QDict 
>> *options, const char *bdref_key,
>>           goto done;
>>       }
>>   -    bs = bdrv_open_inherit(filename, reference, image_options, 0,
>> +    bs = bdrv_open_inherit(filename, reference, image_options, 0, true,
>>                              parent, child_class, child_role, 
>> parse_filename,
>>                              errp);
>>       if (!bs) {
>> @@ -3897,8 +3941,8 @@ BlockDriverState 
>> *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
>>         }
>>   -    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, 
>> 0, false,
>> -                           errp);
>> +    bs = bdrv_open_inherit(NULL, reference, qdict, 0, true, NULL, 
>> NULL, 0,
>> +                           false, errp);
>>       obj = NULL;
>>       qobject_unref(obj);
>>       visit_free(v);
>> @@ -3986,7 +4030,7 @@ out:
>>    */
>>   static BlockDriverState * no_coroutine_fn
>>   bdrv_open_inherit(const char *filename, const char *reference, 
>> QDict *options,
>> -                  int flags, BlockDriverState *parent,
>> +                  int flags, bool open_backing, BlockDriverState 
>> *parent,
>>                     const BdrvChildClass *child_class, BdrvChildRole 
>> child_role,
>>                     bool parse_filename, Error **errp)
>>   {
>> @@ -4199,8 +4243,9 @@ bdrv_open_inherit(const char *filename, const 
>> char *reference, QDict *options,
>>       }
>>         /* If there is a backing file, use it */
>> -    if ((flags & BDRV_O_NO_BACKING) == 0) {
>> -        ret = bdrv_open_backing_file(bs, options, "backing", 
>> &local_err);
>> +    if ((flags & BDRV_O_NO_BACKING) == 0 && open_backing) {
>
> This looks like you just need to pass BDRV_O_NO_BACKING flag, when you 
> do not want open backing?
The issue with BDRV_O_NO_BACKING is that it completely strips the 
backing info from the image, while we need this info.
So it's not possible to just use that flag.
>
>> +        ret = bdrv_open_backing_file(bs, options, open_backing, 
>> "backing",
>> +                                     &local_err);
>>           if (ret < 0) {
>>               goto close_and_fail;
>>           }
>> @@ -4283,7 +4328,7 @@ BlockDriverState *bdrv_open(const char 
>> *filename, const char *reference,
>>   {
>>       GLOBAL_STATE_CODE();
>>   -    return bdrv_open_inherit(filename, reference, options, flags, 
>> NULL,
>> +    return bdrv_open_inherit(filename, reference, options, flags, 
>> true, NULL,
>>                                NULL, 0, true, errp);
>>   }
>>   diff --git a/block/mirror.c b/block/mirror.c
>> index 089856f4a8..a4dde5d36d 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -785,7 +785,7 @@ static int mirror_exit_common(Job *job)
>>           bdrv_graph_rdlock_main_loop();
>>           assert(!bdrv_backing_chain_next(target_bs));
>>           ret = bdrv_open_backing_file(bdrv_skip_filters(target_bs), 
>> NULL,
>> -                                     "backing", &local_err);
>> +                                     true, "backing", &local_err);
>>           bdrv_graph_rdunlock_main_loop();
>>           if (ret < 0) {
>>               error_report_err(local_err);
>> diff --git a/include/block/block-global-state.h 
>> b/include/block/block-global-state.h
>> index ed89999f0f..c7becd9d73 100644
>> --- a/include/block/block-global-state.h
>> +++ b/include/block/block-global-state.h
>> @@ -110,7 +110,12 @@ bdrv_set_backing_hd(BlockDriverState *bs, 
>> BlockDriverState *backing_hd,
>>                       Error **errp);
>>     int bdrv_open_backing_file(BlockDriverState *bs, QDict 
>> *parent_options,
>> -                           const char *bdref_key, Error **errp);
>> +                           bool open_backing, const char *bdref_key,
>> +                           Error **errp);
>> +
>> +int bdrv_open_backing_chain_until(BlockDriverState *top_bs,
>> +                                  const char *base_filename,
>> +                                  Error **errp);
>>     BlockDriverState * no_coroutine_fn
>>   bdrv_open(const char *filename, const char *reference, QDict *options,
>
>
Thanks
Jean-Louis

