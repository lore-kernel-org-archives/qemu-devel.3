Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138B0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SXN-0004Sj-1N; Mon, 29 Apr 2024 11:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1SX8-0004RO-Tp
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:03:15 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1SX5-0001ul-2w
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:03:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id A1A4F60A8A;
 Mon, 29 Apr 2024 18:03:01 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b739::1:30] (unknown
 [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 03SRob1IkqM0-KHn26Sou; Mon, 29 Apr 2024 18:03:00 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714402980;
 bh=5IHme+c3+ipm1b7Z+uSlc7ltFHCTRDix/frkX//kk+U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=q1ctYe4yz6LJtURO9VI/TcV2QbK1W8BOIMzTajWcdGkBojhfjHCLi00AD3KFQNZ+J
 v0lzasacePYTpkvNCE67V1MAWJnhek6UMw48wopEhNSMapMo6InUZ6y6A+QDsOC4hW
 5X/eTrd0RTfCgXtkaTX8G0ABfCHDzeHjwQdMmFqw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fd9e9e0c-2e2e-4c5b-9d65-c67ab63d6660@yandex-team.ru>
Date: Mon, 29 Apr 2024 18:03:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] qapi: introduce exit-on-error parameter for
 migrate-incoming
To: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
 <20240425181551.1465739-5-vsementsov@yandex-team.ru> <87r0etgp7e.fsf@suse.de>
 <3b6fe3da-04df-4cd1-a428-4b5cae11510a@yandex-team.ru>
 <87bk5s71y0.fsf@suse.de>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87bk5s71y0.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 29.04.24 16:06, Fabiano Rosas wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 25.04.24 23:30, Fabiano Rosas wrote:
>>>> @@ -797,13 +801,18 @@ fail:
>>>>                          MIGRATION_STATUS_FAILED);
>>>>        migration_incoming_state_destroy();
>>>>    
>>>> -    if (migrate_has_error(s)) {
>>>> -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>>>> -            error_report_err(s->error);
>>>> +    if (mis->exit_on_error) {
>>>> +        if (migrate_has_error(s)) {
>>>> +            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>>>> +                error_report_err(s->error);
>>> error_report_err(error_copy(s->error))
>>>
>>> ...because later on you're reading from s->error at
>>> fill_destination_migration_info.
>>
>> No, we immediately do exit() instead. That's just a preexisting behavior, moved into "if (mis->exit_on_error)"
> 
> I meant later in the patch, not later in the execution. Can't
> query-migrate be called during process_incoming_migration_co?

Hmm.. On the one hand, seems no reason to care about it exactly before exit().. On the other hand, we do care about taking error_mutex. And we do release it, which may trigger another critical section.

I'll try to touch up this thing.

-- 
Best regards,
Vladimir


