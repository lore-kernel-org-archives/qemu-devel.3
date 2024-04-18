Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CE3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTzE-0000q6-Bo; Thu, 18 Apr 2024 11:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rxTzB-0000pY-32
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:47:41 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rxTz8-0002Ew-D1
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:47:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BBD8C60C25;
 Thu, 18 Apr 2024 18:47:32 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8814::1:9] (unknown
 [2a02:6b8:b081:8814::1:9])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VlHDPU0IWuQ0-YInqQPuy; Thu, 18 Apr 2024 18:47:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1713455251;
 bh=GP/6WgiUb02XvKa5cggi799SY3njI75OgvqAWWGsllk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wZnq8GclzKA/rp0Eq1EjQIDKBoFdlUZYl2W9fUbNZEL95dQpceyct8hVsaosQoQ9L
 9HKyjJP1Z0Z5fUwfg6aaBIlLxHU/Cth1zItSzw6rLuYQ99TSV5edFGyhw/HXkdcp2L
 diqqRqoiiGZExZVfo0SN8NLkjdlyeL0aKx8ttTNg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <985d47bb-3c14-4576-95fa-28649710686b@yandex-team.ru>
Date: Thu, 18 Apr 2024 18:47:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: do not exit on incoming failure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: peterx@redhat.com, farosas@suse.de, yc-core@yandex-team.ru,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, pkrempa@redhat.com
References: <20240417221329.248803-1-vsementsov@yandex-team.ru>
 <ZiEwF0rWlLaKMzqw@redhat.com>
 <0a1d8984-bc01-41bf-9099-0ef426e848ca@yandex-team.ru>
 <ZiE_n7qwvRCz3vjE@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZiE_n7qwvRCz3vjE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 18.04.24 18:43, Daniel P. Berrangé wrote:
> On Thu, Apr 18, 2024 at 06:40:38PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 18.04.24 17:37, Daniel P. Berrangé wrote:
>>> On Thu, Apr 18, 2024 at 01:13:29AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> We do set MIGRATION_FAILED state, but don't give a chance to
>>>> orchestrator to query migration state and get the error.
>>>>
>>>> Let's report an error through QAPI like we do on outgoing migration.
>>>>
>>>> migration-test is updated correspondingly.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>
>>>> Doubt: is exiting on failure a contract? Will this commit break
>>>> something in Libvirt? Finally, could we just change the logic, or I need
>>>> and additional migration-parameter for new behavior?
>>>
>>> There's a decent risk that this could break apps, whether
>>> libvirt or something else, especially if the app is just
>>> launching QEMU with '-incoming URI', rather than using
>>> '-incoming defer' and then explicitly using QMP to start the
>>> incoming migration.
>>>
>>> I'd say that with '-incoming defer' we should *not* exit on
>>> migration error, because that arg implies the app explicitly
>>> wants to be using QMP to control migration.
>>>
>>> With the legacy '-incoming URI' it is probably best to keep
>>> exit on error, as that's comparatively more likely to be used
>>> in adhoc scenarios where the app/user is ignoring QMP on the
>>> dst side.
>>>
>>> None the less, I think we need to check how libvirt behaves
>>> with this patch to be sure of no surprises.
>>>
>>
>> Sounds reasonable, thanks! I'll rework it to behave the new
>> way only with "-incoming defer", and check how libvirt behave with it.
> 
> If there are problems and/or we want to be super safe wrt
> backcompat, we could add a new  '-incoming managed' as
> being equivalent to '-incoming defer' but without the
> implicit exit.
> 

Probably, that's the best variant. As I can check libvirt in some case, but not at all cases. And libvirt is not the only vm manager finally.
And we can in the same time deprecate "-incoming defer" in favor of new behavior.


-- 
Best regards,
Vladimir


