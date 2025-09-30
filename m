Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5671CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VKZ-0007Ew-Pc; Tue, 30 Sep 2025 04:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v3VK8-0006uA-LI
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:03:00 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v3VK1-0001hy-I6
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:03:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 21758C016F;
 Tue, 30 Sep 2025 11:02:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:560::1:13] (unknown
 [2a02:6bf:8080:560::1:13])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id c2Zopg2GrKo0-9QqxuLPY; Tue, 30 Sep 2025 11:02:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1759219360;
 bh=hID6LZgZRX7RGkl8kA+zYNHkEI2QaaQsb9NpUg3IEDI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0HdUI6c0sWxDrXIvNZFnqAKDtB0YF8D295ZrbJ5edSUtTJf2lzDojxBOeu1zPZiBx
 SFDhRRPT4H91fJE/B8DOOXZQjvB0KTrGYOlz1INSqe53FzZV+u0BNiYrPcOR16DjBB
 E2eZXnhmidMhtquIqKI5NIwdFTnFcCKjX+6svhHk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <77f8b8ba-911e-4965-bb10-2c0cc31a0d3d@yandex-team.ru>
Date: Tue, 30 Sep 2025 11:02:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] hw/remote/vfio-user: Clean up error reporting
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, Jagannathan Raman <jag.raman@oracle.com>
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-6-armbru@redhat.com>
 <1a10e0d3-17fc-4ec9-aa4c-cdfed13988e6@yandex-team.ru>
 <878qi1so4j.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <878qi1so4j.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26.09.25 09:51, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 23.09.25 12:09, Markus Armbruster wrote:
>>> VFU_OBJECT_ERROR() reports the error with error_setg(&error_abort,
>>> ...) when auto-shutdown is enabled, else with error_report().
>>>
>>> Issues:
>>>
>>> 1. The error is serious enough to warrant aborting the process when
>>> auto-shutdown is enabled, yet harmless enough to permit carrying on
>>> when it's disabled.  This makes no sense to me.
>>>
>>> 2. Like assert(), &error_abort is strictly for programming errors.  Is
>>> this one?
>>
>> Brief look at the code make me think that, no it isn't.
> 
> So the use of &error_abort is wrong.
> 
>>>   Or should we exit(1) instead?
>>>
>>> 3. qapi/error.h advises "don't error_setg(&error_abort, ...), use
>>> assert()."
>>>
>>> This patch addresses just 3.
>>>
>>> Cc: Jagannathan Raman <jag.raman@oracle.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    hw/remote/vfio-user-obj.c | 9 +++------
>>>    1 file changed, 3 insertions(+), 6 deletions(-)
>>> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
>>> index ea6165ebdc..eb96982a3a 100644
>>> --- a/hw/remote/vfio-user-obj.c
>>> +++ b/hw/remote/vfio-user-obj.c
>>> @@ -75,12 +75,9 @@ OBJECT_DECLARE_TYPE(VfuObject, VfuObjectClass, VFU_OBJECT)
>>>     */
>>>    #define VFU_OBJECT_ERROR(o, fmt, ...)                                     \
>>>        {                                                                     \
>>> -        if (vfu_object_auto_shutdown()) {                                 \
>>> -            error_setg(&error_abort, (fmt), ## __VA_ARGS__);              \
>>> -        } else {                                                          \
>>> -            error_report((fmt), ## __VA_ARGS__);                          \
>>> -        }                                                                 \
>>> -    }                                                                     \
>>> +        error_report((fmt), ## __VA_ARGS__);                              \
>>> +        assert(!vfu_object_auto_shutdown());                              \
>>
>> Probably, it's only my feeling, but for me, assert() is really strictly bound
>> to programming errors, more than abort(). Using abort() for errors which are
>> not programming, but we can't handle them looks less confusing, i.e.
>>
>> if (vfu_object_auto_shutdown()) {
>>      abort();
>> }
> 
> assert(COND) is if (COND) abort() plus a message meant to help
> developers.  Both are for programming errors.  If it isn't something
> that needs debugging, why dump core?
> 
> But this particular error condition is *not* a programming error.  So
> 
>          assert(!vfu_object_auto_shutdown());
> 
> and
> 
>          if (vfu_object_auto_shutdown()) {
>              abort();
>          }
> 
> are both equally wrong.  However, the latter makes it easier to add a
> FIXME comment:
> 
>          if (vfu_object_auto_shutdown()) {
>              /*
>               * FIXME This looks inappropriate.  The error is serious
>               * enough programming error to warrant aborting the process
>               * when auto-shutdown is enabled, yet harmless enough to
>               * permit carrying on when it's disabled.  Makes no sense.
>               */
>              abort();
>          }
> 

Looks more readable, yes.

> The commit message would then need a tweak.  Perhaps
> 
>    Issues:
> 
>    1. The error is serious enough to warrant killing the process when
>    auto-shutdown is enabled, yet harmless enough to permit carrying on
>    when it's disabled.  This makes no sense to me.
> 
>    2. Like assert(), &error_abort is strictly for programming errors.  Is
>    this one?  Vladimir Sementsov-Ogievskiy tells me it's not.

:)) I'm not an expert in vfio-user at all. But yes, I said it:)

> 
>    3. qapi/error.h advises "don't error_setg(&error_abort, ...), use
>    assert()."
> 
>    This patch addresses just 3.  It adds a FIXME comment for the other
>    two.
> 
> Thoughts?

Looks good.

> 
>> Not really matter. Anyway:
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Thanks!
> 
>>> +    }
>>>      struct VfuObjectClass {
>>>        ObjectClass parent_class;
> 


-- 
Best regards,
Vladimir

