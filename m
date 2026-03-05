Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5511AEFCE56
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 01:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxxyb-0004RH-90; Wed, 04 Mar 2026 20:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxxyZ-0004R8-87
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 20:58:07 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxxyV-0004FA-Vy
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 20:58:06 -0500
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6251vJjq076488
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 5 Mar 2026 10:57:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BotU5G3RZeA3B1eTmZlICT+wPIrhpzeqttwr6VXTzb8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772675858; v=1;
 b=Zjq9ktxdEe1tYK4YLQ4G8relS4w5UKOceZ1U/niMc8MyYLcpZMM37g2h4EIrlk45
 ijiltKIF4z7J1utMhy59nq3sR2YxnZt0b+Ie8NJR1TtTarwNFJHWHla9VNqgkziQ
 y47j0Wssv8YmFaHpX8T97O8/KJZ9Abw/Z6/1VzuFNlkPk0oeZfpXAcARcCuf4cxU
 UTSaMjjVEphMRZDE0DNCoDSsTciW3H9T6aVjAFkQKgvxXd/lmIuOxpoJyrrAo61D
 KdMswpMVjSxY3jc4vkei0xaa1WWaJNWvqgPYdpLy8HByZtnGk8WHGXWSyRG62ZEb
 m6QAbLLRnYg6NfoeW/Cvtw==
Message-ID: <420d013c-8cf3-447a-84b0-58f0f0f04a87@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 5 Mar 2026 10:57:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] memory: Factor out common ram region initialization
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <cover.1772572714.git.balaton@eik.bme.hu>
 <3122a5855dffd8df81f7552d4a11190c4d0a0403.1772572714.git.balaton@eik.bme.hu>
 <3fd2bad5-5df3-463d-a12b-c3a61ca1c4ab@rsg.ci.i.u-tokyo.ac.jp>
 <4b9a2efc-905a-335d-940b-a2d89e330689@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4b9a2efc-905a-335d-940b-a2d89e330689@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/04 20:38, BALATON Zoltan wrote:
> On Wed, 4 Mar 2026, Akihiko Odaki wrote:
>> On 2026/03/04 6:47, BALATON Zoltan wrote:
>>> Introduce internal helper functions to remove duplicated code from
>>> different memory_region_init_*ram functions.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   system/memory.c | 132 ++++++++++++++++++------------------------------
>>>   1 file changed, 50 insertions(+), 82 deletions(-)
>>>
>>> diff --git a/system/memory.c b/system/memory.c
>>> index e8c4912a60..1b26c6b5a5 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -1589,19 +1589,16 @@ bool 
>>> memory_region_init_ram_nomigrate(MemoryRegion *mr,
>>>                                                     size, 0, errp);
>>>   }
>>>   -bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>>> -                                            Object *owner,
>>> -                                            const char *name,
>>> -                                            uint64_t size,
>>> -                                            uint32_t ram_flags,
>>> -                                            Error **errp)
>>> +static void memory_region_setup_ram(MemoryRegion *mr)
>>>   {
>>> -    Error *err = NULL;
>>> -    memory_region_init(mr, owner, name, size);
>>>       mr->ram = true;
>>>       mr->terminates = true;
>>>       mr->destructor = memory_region_destructor_ram;
>>> -    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
>>> +}
>>> +
>>> +static bool memory_region_error_propagate(MemoryRegion *mr,
>>> +                                          Error *err, Error **errp)
>>> +{
>>>       if (err) {
>>>           mr->size = int128_zero();
>>>           object_unparent(OBJECT(mr));
>>> @@ -1611,6 +1608,18 @@ bool 
>>> memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>>>       return true;
>>>   }
>>
>> I think the optimal way to factor out error propagation is to use 
>> ERRP_GUARD().
> 
> I don't think ERRP_GUARD applies here as we do not dereference errp and 
> this does more than just propagate the error so I don't see how 
> ERRP_GUARD could help here.

include/qapi/error.h has an extensive documentation describing how 
errors should be passed around:

 > Call a function, receive an error from it, and pass it to the caller
 > - when the function returns a value that indicates failure, say
 >   false:
 >     if (!foo(arg, errp)) {
 >         handle the error...
 >     }
 > - when it does not, say because it is a void function:
 >     ERRP_GUARD();
 >     foo(arg, errp);
 >     if (*errp) {
 >         handle the error...
 >     }
 > More on ERRP_GUARD() below.
 >
 > Code predating ERRP_GUARD() still exists, and looks like this:
 >     Error *err = NULL;
 >     foo(arg, &err);
 >     if (err) {
 >         handle the error...
 >         error_propagate(errp, err); // deprecated
 >     }
 > Avoid in new code.  Do *not* "optimize" it to
 >     foo(arg, errp);
 >     if (*errp) { // WRONG!
 >         handle the error...
 >     }
 > because errp may be NULL without the ERRP_GUARD() guard.
 >
 > But when all you do with the error is pass it on, please use
 >     foo(arg, errp);
 > for readability.
 >
 > Receive an error, and handle it locally
 > - when the function returns a value that indicates failure, say
 >   false:
 >     Error *err = NULL;
 >     if (!foo(arg, &err)) {
 >         handle the error...
 >     }
 > - when it does not, say because it is a void function:
 >     Error *err = NULL;
 >     foo(arg, &err);
 >     if (err) {
 >         handle the error...
 >     }
 >
 > Pass an existing error to the caller:
 >     error_propagate(errp, err);
 > This is rarely needed.  When @err is a local variable, use of
 > ERRP_GUARD() commonly results in more readable code.

But looking at the code, the functions generating errors (e.g., 
qemu_ram_alloc()) return values that indicate failures (NULL), so I now 
think we should use the first pattern I cited (i.e., check the returned 
value instead of err) and remove the err variable and error_propagate() 
altogether instead of factoring them out with 
memory_region_error_propagate() or ERRP_GUARD().

Regards,
Akihiko Odaki

