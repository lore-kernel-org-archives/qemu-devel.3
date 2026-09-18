Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C6C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 09:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Urq-00073J-MZ; Fri, 18 Sep 2026 05:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7Urm-00072B-Fo; Fri, 18 Sep 2026 05:26:46 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7Urk-0002Yn-BF; Fri, 18 Sep 2026 05:26:46 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1224:0:640:741a:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 68E9580670;
 Fri, 18 Sep 2026 12:26:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b33::1:33] (unknown
 [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id cQTa8A2XluQ0-Mq19BZrK; Fri, 18 Sep 2026 12:26:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789723599;
 bh=bz4z/Wh0lM8zqaWeubesM3zE+cePkKw0T5YL69Hqy6Y=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VFk05jxL9YFZBjaH1UJ36DNhUzth87nfXxJ+4zNqcJ3BgmRVL4oBFJdsK/Kn+xEcJ
 WRF9oVpWBlhWxLwt+QchQTuMyZVMEQ6qIMkhAy9Os10kHy8r/oFwnfeihkJGyAdQEj
 RJQb7nuQKufv2Gg8g3PR9hSjaTGnQCEGmu89ukZQ=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <935530f3-8295-4716-b31d-789c531e595d@yandex-team.ru>
Date: Fri, 18 Sep 2026 12:26:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nbd: comment on locking for requests[].coroutine
To: "Denis V. Lunev" <den@virtuozzo.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260916132740.872244-1-pbonzini@redhat.com>
 <20260916132740.872244-2-pbonzini@redhat.com>
 <1df6125a-c7e6-469d-831b-19996725f785@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <1df6125a-c7e6-469d-831b-19996725f785@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 16.09.26 17:01, Denis V. Lunev wrote:
> On 9/16/26 15:27, Paolo Bonzini wrote:
>> Explain why it is safe to read it outside the lock.  Basically, if
>> the protocol is followed correctly, the reply header will not
>> appear until after the request has been sent out in its entirety;
>> long after requests[].coroutine has been set and s->request_lock
>> has been released in nbd_co_send_request.  And
>> requests[].coroutine will also not become NULL until after
>> the reply has been read, and that requires nbd_receive_replies
>> to finish.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   block/nbd.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index e5e16722ba2..85842e7cdfb 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -141,6 +141,11 @@ static NBDClientRequest *nbd_request_by_cookie(BDRVNBDState *s, uint64_t cookie,
>>   {
>>       uint64_t ind = COOKIE_TO_INDEX(cookie);
>>   
>> +    /*
>> +     * Once requests[].coroutine is set, it will not be cleared until its
>> +     * reply is read completely; so it is okay to read it as long as a
>> +     * request is in progress or receive_mutex is taken.
>> +     */
> this is incorrect as written nbd_co_send_request could
> clean requests[].coroutine on a fail path. It seems
> not a problem now, but in the future this could be
> misleading
> 
> the second part "or receive mutex is taken" also does
> not stand. Mutex by comment at declaration does not
> protect this field. I am unsure on that
> 


Hmm.. Agree, seems there may be problems with these locks on error paths

Assume we have tow requests A and B in different threads.

1. A goes up to "if (rc < 0) {", after failed write (but assume, that request was (partly) send)

2. B receives reply for A, and goes up to nbd_recv_coroutine_wake_one(owner)

3. A finishes and set .coroutine to NULL

4. B calls nbd_recv_coroutine_wake_one() - nothing happens because req->receiving is false

5. B goes to next iteration, goes to if (s->reply.cookie != 0) again, and nbd_request_by_cookie()
crashes on error_abort, because .coroutine is NULL

Seems possible? Still, I didn't see it happen, and no complaints..


Existing comment that requests_lock protects requests[].coroutine is misleading.. Like many
similar comments in QEMU code, as actually we need protection not (only) for variable itself, but
for the logic behind it (and including another variables). Even if we take requests_lock
around every individual access to .coroutine, this will not fix the race.


> 
>>       if (ind >= MAX_NBD_REQUESTS || !s->requests[ind].coroutine) {
>>           error_setg(errp, "unexpected cookie value");
>>           return NULL;
>> @@ -154,6 +159,12 @@ static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
>>   {
>>       if (req->receiving) {
>>           req->receiving = false;
>> +
>> +        /*
>> +         * Once requests[].coroutine is set, it will not be cleared until its
>> +         * reply is read completely; so it is okay to read it within
>> +         * receive_mutex.
>> +         */
>>           aio_co_wake(req->coroutine);
>>           return true;
>>       }
> 
> May be Vova or Eric will bring some light here.
> 
> Den


-- 
Best regards,
Vladimir

