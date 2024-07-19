Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC70C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 10:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUky5-00007d-5X; Fri, 19 Jul 2024 06:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUky2-0008UD-65; Fri, 19 Jul 2024 06:36:03 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUky1-0007pt-8w; Fri, 19 Jul 2024 06:36:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:958d:0:640:7be4:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 18377608EC;
 Fri, 19 Jul 2024 13:35:54 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b721::1:1f] (unknown
 [2a02:6b8:b081:b721::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qZHhsF0IZ4Y0-5F67g3BG; Fri, 19 Jul 2024 13:35:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1721385353;
 bh=27ScshjhJ4IdNOn7uue91iW+ChW7cu+0Eu6dv1FcmEA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=D7iAS+qAw8eh0q9v8AQj5R5r1/zHcUYs0HJXPyMPP45kfx81vkVdNhAyTgYd3dIH8
 wuwn4MxcY/tHwLTHvtIrpGl/t7vjOUjSroDd49VflpFUllMuPq9Pwi+LHWdAkfYrCK
 iQFvWg09xZ5eqtzUEwzgE8w7qiONRAkeynjQS044=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c4ae737c-853d-4a0d-8f7c-e5502c824bd7@yandex-team.ru>
Date: Fri, 19 Jul 2024 13:35:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block/commit: implement final flush
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com, den@openvz.org, f.ebner@proxmox.com
References: <20240626145038.458709-1-vsementsov@yandex-team.ru>
 <20240626145038.458709-2-vsementsov@yandex-team.ru>
 <ZplrhoVskeiK0R4c@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZplrhoVskeiK0R4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 18.07.24 22:22, Kevin Wolf wrote:
> Am 26.06.2024 um 16:50 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Actually block job is not completed without the final flush. It's
>> rather unexpected to have broken target when job was successfully
>> completed long ago and now we fail to flush or process just
>> crashed/killed.
>>
>> Mirror job already has mirror_flush() for this. So, it's OK.
>>
>> Do this for commit job too.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   block/commit.c | 41 +++++++++++++++++++++++++++--------------
>>   1 file changed, 27 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index 7c3fdcb0ca..81971692a2 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -134,6 +134,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>>       int64_t n = 0; /* bytes */
>>       QEMU_AUTO_VFREE void *buf = NULL;
>>       int64_t len, base_len;
>> +    bool need_final_flush = true;
>>   
>>       len = blk_co_getlength(s->top);
>>       if (len < 0) {
>> @@ -155,8 +156,8 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>>   
>>       buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
>>   
>> -    for (offset = 0; offset < len; offset += n) {
>> -        bool copy;
>> +    for (offset = 0; offset < len || need_final_flush; offset += n) {
> 
> In general, the control flow would be nicer to read if the final flush
> weren't integrated into the loop, but just added after it.
> 
> But I assume this is pretty much required for pausing the job during
> error handling in the final flush if you don't want to duplicate a lot
> of the logic into a second loop?

Right, that's the reason.

> 
>> +        bool copy = false;
>>           bool error_in_source = true;
>>   
>>           /* Note that even when no rate limit is applied we need to yield
>> @@ -166,22 +167,34 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>>           if (job_is_cancelled(&s->common.job)) {
>>               break;
>>           }
>> -        /* Copy if allocated above the base */
>> -        ret = blk_co_is_allocated_above(s->top, s->base_overlay, true,
>> -                                        offset, COMMIT_BUFFER_SIZE, &n);
>> -        copy = (ret > 0);
>> -        trace_commit_one_iteration(s, offset, n, ret);
>> -        if (copy) {
>> -            assert(n < SIZE_MAX);
>>   
>> -            ret = blk_co_pread(s->top, offset, n, buf, 0);
>> -            if (ret >= 0) {
>> -                ret = blk_co_pwrite(s->base, offset, n, buf, 0);
>> -                if (ret < 0) {
>> -                    error_in_source = false;
>> +        if (offset < len) {
>> +            /* Copy if allocated above the base */
>> +            ret = blk_co_is_allocated_above(s->top, s->base_overlay, true,
>> +                                            offset, COMMIT_BUFFER_SIZE, &n);
>> +            copy = (ret > 0);
>> +            trace_commit_one_iteration(s, offset, n, ret);
>> +            if (copy) {
>> +                assert(n < SIZE_MAX);
>> +
>> +                ret = blk_co_pread(s->top, offset, n, buf, 0);
>> +                if (ret >= 0) {
>> +                    ret = blk_co_pwrite(s->base, offset, n, buf, 0);
>> +                    if (ret < 0) {
>> +                        error_in_source = false;
>> +                    }
>>                   }
>>               }
>> +        } else {
>> +            assert(need_final_flush);
>> +            ret = blk_co_flush(s->base);
>> +            if (ret < 0) {
>> +                error_in_source = false;
>> +            } else {
>> +                need_final_flush = false;
>> +            }
> 
> Should we set n = 0 in this block to avoid counting the last chunk twice
> for the progress?

Oops, right. Will fix, thanks

> 
>>           }
>> +
>>           if (ret < 0) {
>>               BlockErrorAction action =
>>                   block_job_error_action(&s->common, s->on_error,
> 
> Kevin
> 

-- 
Best regards,
Vladimir


