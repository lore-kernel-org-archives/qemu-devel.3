Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF060C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3R9-0001EY-Vo; Fri, 14 Jun 2024 05:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sI3R8-0001EN-Ih; Fri, 14 Jun 2024 05:41:34 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sI3R6-00019l-1f; Fri, 14 Jun 2024 05:41:34 -0400
Message-ID: <8e9e9e21-2d00-49f2-8563-aee494c5bbe5@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1718358087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lCW7ZXf+t8QzQHdfXVaXQ1vxu7+8YHaWGGh0EYQP5Y=;
 b=Qo8herkT1LBZJwKAobmVUT/72ufoh1kJWPDY0bVEZXCK0iMHjRmSsiPHQ7pm03BSL9j7YP
 H/EEqPdbK2c20rhAYqjLdRfEdDQVo0sCwK0UuJQSQF6J4rwmOoCBf28+hzOO9wbmT0+og9
 82rUhA87YRxIBsH7GS4AbPzFk4IrYjE=
Date: Fri, 14 Jun 2024 12:41:27 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest/fuzz/virtio_net_fuzz.c: fix
 virtio_net_fuzz_multi
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: alxndr@bu.edu, sdl.qemu@linuxtesting.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>
References: <20240523102813.396750-2-frolov@swemel.ru>
 <2982b9c8-1325-4ca7-9e91-b1a94178c9d9@redhat.com>
 <ee6ee73c-9714-40b2-9a0a-3f835bcf0c95@swemel.ru>
 <9d456ca1-0a63-483d-bfe1-1ff8ccfbe0a0@redhat.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <9d456ca1-0a63-483d-bfe1-1ff8ccfbe0a0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
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

On 13.06.2024 19:50, Thomas Huth wrote:
> On 13/06/2024 13.59, Дмитрий Фролов wrote:
>>
>>
>> On 13.06.2024 13:08, Thomas Huth wrote:
>>> On 23/05/2024 12.28, Dmitry Frolov wrote:
>>>> If QTestState was already CLOSED due to error, calling 
>>>> qtest_clock_step()
>>>> afterwards makes no sense and only raises false-crash with message:
>>>> "assertion timer != NULL failed".
>>>>
>>>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>>>> ---
>>>>   tests/qtest/fuzz/virtio_net_fuzz.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c 
>>>> b/tests/qtest/fuzz/virtio_net_fuzz.c
>>>> index e239875e3b..2f57a8ddd8 100644
>>>> --- a/tests/qtest/fuzz/virtio_net_fuzz.c
>>>> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
>>>> @@ -81,6 +81,9 @@ static void virtio_net_fuzz_multi(QTestState *s,
>>>>           /* Run the main loop */
>>>>           qtest_clock_step(s, 100);
>>>>           flush_events(s);
>>>> +        if (!qtest_probe_child(s)) {
>>>> +            return;
>>>> +        }
>>>
>>> According to your patch description, it rather sounds like the check 
>>> should be done before the qtest_clock_step() ? ... or where does the 
>>> QTestState get closed? During flush_events() ?
>> To my understanding, the main loop is executed during flush_events(), 
>> where an error may occur. This behavior is legit and should not 
>> produce any crash report.
>> Without the check, the test continues to wait on used descriptors, 
>> and finally fails with message: "assertion timer != NULL failed".
>> Thus, any invalid input data produces a meaningless crash report.
>
> Ok, makes sense now, thanks!
>
> There seems to be another while loop with a flush_events() call later 
> in this file, does it maybe need the same treatment, too?
With this fix, the number of crashes reduced significantly, but I guess, 
you are right...
If another similar crash will occur - I`ll make another patch.
Many thanks!
Dmitry
>  Thomas
>


