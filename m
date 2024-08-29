Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E587EC83F0F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sje6x-0001wd-0r; Thu, 29 Aug 2024 08:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sje6t-0001vn-Ff
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:18:44 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1sje6p-00086n-Qn
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:18:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c00:2588:0:640:36aa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B8C1360B16;
 Thu, 29 Aug 2024 15:18:31 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6::1:2d] (unknown [2a02:6b8:b081:6::1:2d])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id NIVwGX1XleA0-WbXSqgGw; 
 Thu, 29 Aug 2024 15:18:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1724933910;
 bh=whDKoX+cDWWO7+wguBr7L+KzicQncCI7EcuLEMq1skE=;
 h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
 b=Mp+xvwHZYr070UBaukPiAyzrY0ueAbDdue+ddAU/OLgx4sNett5YqdTOcJ9fB9v9b
 YqrgzII4saMxneLA5KO2xnHF8GldCaHdp4qFWRoKHl1qJbp02Ldo2JTQc2aCTdSr1A
 T3SXFzVM26VCsHV2DUhkF8U5bRnjLoJwPiVpxVnc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <849fa448-42d3-4438-84d0-1bf4872ecb85@yandex-team.ru>
Date: Thu, 29 Aug 2024 15:18:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: Re: [PATCH] chardev: allow specifying finer-grained reconnect timeouts
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Peter Krempa <pkrempa@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
References: <20240816100723.2815-1-d-tatianin@yandex-team.ru>
 <87v7zjleys.fsf@pond.sub.org>
Content-Language: en-US
In-Reply-To: <87v7zjleys.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 8/29/24 2:56 PM, Markus Armbruster wrote:
> Daniil Tatianin <d-tatianin@yandex-team.ru> writes:
>
>> The "reconnect" option only allows to specify the time in seconds,
>> which is way too long for certain workflows.
>>
>> We have a lightweight disk backend server, which takes about 20ms to
>> live update, but due to this limitation in QEMU, previously the guest
>> disk controller would hang for one second because it would take this
>> long for QEMU to reinitialize the socket connection.
>>
>> Make it possible to specify a smaller timeout by treating the value in
>> "reconnect" as milliseconds via the new "reconnect-is-ms" option.
>>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> Your use case demonstrates that a granularity of seconds was the wrong
> choice for the reconnection delay.
>
> [...]
>
>> diff --git a/qapi/char.json b/qapi/char.json
>> index ef58445cee..61aeccf09d 100644
>> --- a/qapi/char.json
>> +++ b/qapi/char.json
>> @@ -272,8 +272,13 @@
>> # (default: false) (Since: 3.1)
>> #
>> # @reconnect: For a client socket, if a socket is disconnected, then
>> -# attempt a reconnect after the given number of seconds. Setting
>> -# this to zero disables this function. (default: 0) (Since: 2.2)
>> +# attempt a reconnect after the given number of seconds (unless
>> +# @reconnect-is-ms is set to true, in that case the number is
>> +# treated as milliseconds). Setting this to zero disables
>> +# this function. (default: 0) (Since: 2.2)
>> +#
>> +# @reconnect-is-ms: The value specified in @reconnect should be treated
>> +# as milliseconds. (default: false) (Since: 9.2)
>> #
>> # Since: 1.4
>> ##
>> @@ -287,7 +292,8 @@
>> '*telnet': 'bool',
>> '*tn3270': 'bool',
>> '*websocket': 'bool',
>> - '*reconnect': 'int' },
>> + '*reconnect': 'int',
>> + '*reconnect-is-ms': 'bool' },
>> 'base': 'ChardevCommon' }
>> ##
> I don't like this interface.

Indeed. After discussing this more internally we have actually settled 
on one of the alternatives you have mentioned below.

> PRO: compatible extension; no management application updates needed
> unless they want to support sub-second delays.
>
> CON: specifying a sub-second delay takes two parameters, which is
> awkward.
>
> CON: trap in combination with -set. Before the patch, something like
> -set chardev.ID.reconnect=N means N seconds no matter what.
> Afterwards, it depends on the value of reconnect-is-ms, which may be
> set far away. Mitigating factor: -set is obscure.
>
> Alternatives:
>
> 1. Change @reconnect to 'number', specify sub-second delays as
> fractions.
>
> PRO: compatible extension; no management application updates needed
> unless they want to support sub-second delays.
>
> CON: first use of floating-point for time in seconds in QAPI, as far
> as I can see.
>
> CON: QemuOpts can't do floating-point.
>
> 2. Deprecate @reconnect in favour of a new member with a more suitable
> unit. Error if both are present.
>
> PRO: after @reconnect is gone, the interface is what it arguably
> should've been from the start.
>
> CON: incompatible change. Management application updates needed
> within the deprecation grace period.

This is the one we decided to go with. We simply added a new 
"reconnect-ms" option, which doesn't replace the old one for backwards 
compatibility, but also disallows both to be specified at the same time, 
making them mutually exclusive. I think deprecation would be the way to 
go here.

>
> Let's get additional input from management application developers. I
> cc'ed some.

Sure, sounds great. Thanks!

>
> Related: NetdevSocketOptions member @reconnect.
>

