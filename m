Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E43AC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqDI-0007sD-VY; Fri, 02 Aug 2024 07:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZqDG-0007iq-Js; Fri, 02 Aug 2024 07:12:47 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZqDE-00070G-OY; Fri, 02 Aug 2024 07:12:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A011560B44;
 Fri,  2 Aug 2024 14:12:41 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b725::1:34] (unknown
 [2a02:6b8:b081:b725::1:34])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eCWwmO1i50U0-LYVbBluM; Fri, 02 Aug 2024 14:12:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722597161;
 bh=pI/v/gsk/i9psjofdTPyP2tExkz6Ncm4IpcpASdlVqU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=AlK1m2tZR4mNfsPzfgaTvb7aGGkHJBmmJGh6O7BqPL8OT075W98h9c6Hn0MlX24ic
 Vgi7ZK/EMdY21IX913nqtKK7TIiSOany7RbEIjki1v4RwuohbclBB23SV2Jj0bmEK/
 f7Q7iMopM2F5BjPOy38O13IAaDhOixKpspI3kTzE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5afaa49a-db2f-4f97-9c7f-2978c0519264@yandex-team.ru>
Date: Fri, 2 Aug 2024 14:12:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block/commit: implement final flush
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com, den@openvz.org, f.ebner@proxmox.com
References: <20240626145038.458709-1-vsementsov@yandex-team.ru>
 <20240626145038.458709-2-vsementsov@yandex-team.ru>
 <ZplrhoVskeiK0R4c@redhat.com>
 <c4ae737c-853d-4a0d-8f7c-e5502c824bd7@yandex-team.ru>
 <ZqeKKCWxhoVnGKWV@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZqeKKCWxhoVnGKWV@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 29.07.24 15:25, Kevin Wolf wrote:
> Am 19.07.2024 um 12:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> On 18.07.24 22:22, Kevin Wolf wrote:
>>> Am 26.06.2024 um 16:50 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Actually block job is not completed without the final flush. It's
>>>> rather unexpected to have broken target when job was successfully
>>>> completed long ago and now we fail to flush or process just
>>>> crashed/killed.
>>>>
>>>> Mirror job already has mirror_flush() for this. So, it's OK.
>>>>
>>>> Do this for commit job too.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    block/commit.c | 41 +++++++++++++++++++++++++++--------------
>>>>    1 file changed, 27 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/block/commit.c b/block/commit.c
>>>> index 7c3fdcb0ca..81971692a2 100644
>>>> --- a/block/commit.c
>>>> +++ b/block/commit.c
>>>> @@ -134,6 +134,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>>>>        int64_t n = 0; /* bytes */
>>>>        QEMU_AUTO_VFREE void *buf = NULL;
>>>>        int64_t len, base_len;
>>>> +    bool need_final_flush = true;
>>>>        len = blk_co_getlength(s->top);
>>>>        if (len < 0) {
>>>> @@ -155,8 +156,8 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>>>>        buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
>>>> -    for (offset = 0; offset < len; offset += n) {
>>>> -        bool copy;
>>>> +    for (offset = 0; offset < len || need_final_flush; offset += n) {
>>>
>>> In general, the control flow would be nicer to read if the final flush
>>> weren't integrated into the loop, but just added after it.
>>>
>>> But I assume this is pretty much required for pausing the job during
>>> error handling in the final flush if you don't want to duplicate a lot
>>> of the logic into a second loop?
>>
>> Right, that's the reason.
> 
> This would probably be the right solution if it affected only commit.
> But I've thought a bit more about this and given that the same thing
> happens in all of the block jobs, I'm really wondering if introducing a
> block job helper function wouldn't be better, so that each block job
> could just add something like this after its main loop:
> 
>      do {
>          ret = blk_co_flush();
>      } while (block_job_handle_error(job, ret));
> 
> And the helper would call block_job_error_action(), stop the job if
> necessary, check if it's cancelled, include a pause point etc.
> 

Agree. Thanks, I'll try.

-- 
Best regards,
Vladimir


