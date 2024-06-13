Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FBCC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 11:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHj6o-0004nw-Pw; Thu, 13 Jun 2024 07:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sHj6m-0004mi-Cz; Thu, 13 Jun 2024 07:59:12 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sHj6k-0001QF-4s; Thu, 13 Jun 2024 07:59:12 -0400
Message-ID: <ee6ee73c-9714-40b2-9a0a-3f835bcf0c95@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1718279942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGrJtclYJDvgqE+5CVk0pr8PPkeG5i5OfPYP1FU9Cr8=;
 b=QP3J/tPlbgsRHA/DSImu8oo+O8uCNDgW9zaf14Pcv4m4UPrzDoMchp2WUIe1pb9T0TvRPo
 U5i9QG+t4F870QAYKf3DfrF9MY0O6/H8GmPS48n1+epL22ecvYF+yq6HBTn2mR69868xdx
 u/ZWSHwSkMYpfmXmKbY69cBLlNdoHQI=
Date: Thu, 13 Jun 2024 14:59:02 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest/fuzz/virtio_net_fuzz.c: fix
 virtio_net_fuzz_multi
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: alxndr@bu.edu, sdl.qemu@linuxtesting.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>
References: <20240523102813.396750-2-frolov@swemel.ru>
 <2982b9c8-1325-4ca7-9e91-b1a94178c9d9@redhat.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <2982b9c8-1325-4ca7-9e91-b1a94178c9d9@redhat.com>
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



On 13.06.2024 13:08, Thomas Huth wrote:
> On 23/05/2024 12.28, Dmitry Frolov wrote:
>> If QTestState was already CLOSED due to error, calling 
>> qtest_clock_step()
>> afterwards makes no sense and only raises false-crash with message:
>> "assertion timer != NULL failed".
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>> ---
>>   tests/qtest/fuzz/virtio_net_fuzz.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c 
>> b/tests/qtest/fuzz/virtio_net_fuzz.c
>> index e239875e3b..2f57a8ddd8 100644
>> --- a/tests/qtest/fuzz/virtio_net_fuzz.c
>> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
>> @@ -81,6 +81,9 @@ static void virtio_net_fuzz_multi(QTestState *s,
>>           /* Run the main loop */
>>           qtest_clock_step(s, 100);
>>           flush_events(s);
>> +        if (!qtest_probe_child(s)) {
>> +            return;
>> +        }
>
> According to your patch description, it rather sounds like the check 
> should be done before the qtest_clock_step() ? ... or where does the 
> QTestState get closed? During flush_events() ?
To my understanding, the main loop is executed during flush_events(), 
where an error may occur. This behavior is legit and should not produce 
any crash report.
Without the check, the test continues to wait on used descriptors, and 
finally fails with message: "assertion timer != NULL failed".
Thus, any invalid input data produces a meaningless crash report.
>  Thomas
>


