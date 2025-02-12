Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51980C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFsk-0001mb-3d; Wed, 12 Feb 2025 11:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiFsg-0001lK-3m
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:46:35 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tiFsd-00049g-Pn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:46:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:1286:0:640:6f2b:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9FEB6617FB;
 Wed, 12 Feb 2025 19:46:26 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6513::1:c] (unknown
 [2a02:6b8:b081:6513::1:c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OkSN6D0IlKo0-pKpkhh4H; Wed, 12 Feb 2025 19:46:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1739378786;
 bh=PaDM2m73ZPZbmANoxS0hQKW8RfRaOFklSOrt3DJn9e0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=s2Ac5wdH/MY2xju18P92aC54AWtlCDYeS+U6yBmN4W/UOjLHeFkucOlIDpmCtjTZM
 fzUP0A7T90M50ZKBlfsVDqIHYcbTqGyY/Jhcrt890AJ6xZQhD07tXVRWFxh56PWHx0
 ORdE1esgC/aW1cRnO7FV3kynYsfM3o7lxjFoBTz0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <58010eeb-731a-4c34-8742-c9b2718a59a5@yandex-team.ru>
Date: Wed, 12 Feb 2025 19:46:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] os: add an ability to lock memory on_fault
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
References: <20250212143920.1269754-1-d-tatianin@yandex-team.ru>
 <20250212143920.1269754-2-d-tatianin@yandex-team.ru>
 <Z6y-jdFOCVz8mEXo@redhat.com>
 <c78c911c-d7b3-412b-a6d0-b4bcca070a6b@yandex-team.ru>
 <Z6zPd7DM1yGWXokt@x1.local>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z6zPd7DM1yGWXokt@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/12/25 7:42 PM, Peter Xu wrote:

> On Wed, Feb 12, 2025 at 07:17:45PM +0300, Daniil Tatianin wrote:
>>>> -static inline int os_mlock(void)
>>>> +static inline int os_mlock(bool on_fault)
>>>>    {
>>>> +    (void)on_fault;
>>> Is this really needed ? Our compiler flags don't enable warnings
>>> about unused variables.
>> Hmm, I was not aware of that, thank you.
>>
>> Peter, do you want me to resend, or can you squash remove this as well?
> I'll do, no worry.

Much appreciated!

>

