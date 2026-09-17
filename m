Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58896C982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7DQH-00077S-Nw; Thu, 17 Sep 2026 10:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7DPv-00076N-MK; Thu, 17 Sep 2026 10:48:52 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7DPs-000424-7c; Thu, 17 Sep 2026 10:48:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:6522:0:640:3362:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 5335680968;
 Thu, 17 Sep 2026 17:48:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b33::1:33] (unknown
 [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id fmX0I20b2iE0-8xHYUOjC; Thu, 17 Sep 2026 17:48:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789656522;
 bh=ml6BTXyxxpEoPcoaB1m+G+M1uI7l2ORACQSzJGHgRNQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QL4bl2P2+dwDCY7r5/n4d/uNr9nlg1VW8zqBiPSRpVYGUEMhUJJ8w3D12RgWuEA/u
 HVItoS8pGEDf+qb7vAUGshCnoEPEcf1q/c7lQR+/PwrOHxK3qyCb0c6sUj8OM6Pj8w
 2Uc1ET3zqDRXb9tW/Y8jPG4ka/2aWV157EoszFNI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fb65d5ce-8d1d-4dc7-9ad3-4b567a048c64@yandex-team.ru>
Date: Thu, 17 Sep 2026 17:48:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nbd: call reconnect_delay_timer_del with
 requests_lock taken
To: "Denis V. Lunev" <den@virtuozzo.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260916132740.872244-1-pbonzini@redhat.com>
 <20260916132740.872244-3-pbonzini@redhat.com>
 <a5560dcf-a8a8-4ef8-9ede-27993b9700ea@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <a5560dcf-a8a8-4ef8-9ede-27993b9700ea@virtuozzo.com>
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

On 16.09.26 16:50, Denis V. Lunev wrote:
> On 9/16/26 15:27, Paolo Bonzini wrote:
>> This ensures that s->reconnect_delay_timer is written under the lock.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   block/nbd.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 85842e7cdfb..82af55ec4e4 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -207,6 +207,7 @@ static void coroutine_fn nbd_channel_error(BDRVNBDState *s, int ret)
>>       nbd_channel_error_locked(s, ret);
>>   }
>>   
>> +/* Called with s->requests_lock held.  */

I'd add same comment to reconnect_delay_timer_init()
(which is already correct)

>>   static void reconnect_delay_timer_del(BDRVNBDState *s)
>>   {
>>       if (s->reconnect_delay_timer) {
>> @@ -219,8 +220,8 @@ static void reconnect_delay_timer_cb(void *opaque)
>>   {
>>       BDRVNBDState *s = opaque;
>>   
>> -    reconnect_delay_timer_del(s);
>>       WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
>> +        reconnect_delay_timer_del(s);
>>           if (s->state != NBD_CLIENT_CONNECTING_WAIT) {
>>               return;
>>           }
>> @@ -2134,9 +2135,9 @@ static void nbd_cancel_in_flight(BlockDriverState *bs)
>>   {
>>       BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
>>   
>> +    qemu_mutex_lock(&s->requests_lock);
>>       reconnect_delay_timer_del(s);
>>   
>> -    qemu_mutex_lock(&s->requests_lock);
>>       if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
>>           s->state = NBD_CLIENT_CONNECTING_NOWAIT;
>>       }
> Reviewed-by: Denis V. Lunev <den@openvz.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> 
> Added Vladimir + Eric as real maintainers.

Thanks!

-- 
Best regards,
Vladimir

