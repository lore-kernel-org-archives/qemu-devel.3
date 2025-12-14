Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A0BD5B16C
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Dec 2025 17:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUqCf-0004is-7P; Sun, 14 Dec 2025 12:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vUqCZ-0004ho-77
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 12:48:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vUqCR-0003U0-FV
 for qemu-devel@nongnu.org; Sun, 14 Dec 2025 12:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765734480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sIOemJZp/bXXB5qnVTrUduPnKSrTa9UzB/DbXvIW7ss=;
 b=ENiargWvtUtDsT17oViJaJuad5aJ8jc6cGBgE3190J/VMqf1x3a68inf1TJq/yJyG+zBim
 ++Qv9i9ruFk6AZb7VQ5/4f3pUyJAcpEU6e2nzvbNe9ACV2Ch95mVvdSE26XvtzD9F3DRdN
 McIy9BCPABCv7dRyP4jQB5N5xeMBIBs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-03Z5A6AeMzGj3oU9pTkSRA-1; Sun, 14 Dec 2025 12:47:59 -0500
X-MC-Unique: 03Z5A6AeMzGj3oU9pTkSRA-1
X-Mimecast-MFC-AGG-ID: 03Z5A6AeMzGj3oU9pTkSRA_1765734478
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso18741515e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765734478; x=1766339278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sIOemJZp/bXXB5qnVTrUduPnKSrTa9UzB/DbXvIW7ss=;
 b=X7+1KV41X8c3I3sG1oNZO/G8IskT2Yh4krq++qOBcCJK2/bMc/vfW/HOEDwxPJXagv
 IydsEMZHuhFwu5gJYzvapjnJOG4Ow4+mFo9pAFy8iqBFkDX73gOZ0CXtD2YWooBVRxFu
 j32L9zCz8QLol46n2nJmDX50yRaPSoYv91guKdF9mqLXJI1FagbplFcW+3d9//IcGr75
 FCn98RgUn1CWHgRPKArgDDHBreQBwprkq8rhnFVGj+R9B34lYA1fpFvoToBVvzp8tEuy
 Ss3eHp3HnaQqoriQVWDLPU6hpkfT0uKij91KGViG1inHnBCWZ1ewpkJwPn7WcPmawP5S
 mHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765734478; x=1766339278;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIOemJZp/bXXB5qnVTrUduPnKSrTa9UzB/DbXvIW7ss=;
 b=VB94JNOLjLrHVSey+D0J95tQKWloMG3qwr14Ebx4EE6O9hYlheLz93/ldXpXOm/40y
 sL+00uON1ivl4kLh5gMbQjD2q+waH8mdLuxJcj9myAQMjDOcHKT+plbqMwCkJ5ITjhWQ
 XRSB7QHk0TYeqZa7e4vsd9VKR4wbxpt4O3ahZkKiu6hq0hz2pG/DaWoLBC7SVOUF6RfZ
 RC4fpyn/LPPv5y/cKgzaFIt0MZkG3I9DMKEk1gnnM+wNC6y30pGwWo3bD0Eoi0vneOC9
 OnXtzXxX8irrlLHrn3Gkfw/NB0zSPuGp02+97wTbDeG5AoywbQwasShe4aIxpqzVLSX/
 mY4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMASGCcbCqga3BBl11aC9aeVXcq0riRIm209cZLyY8R63tLIf1FrfyJNYvVJz0gCtaCGGfv1I8tH0t@nongnu.org
X-Gm-Message-State: AOJu0YyDKiRNxc3HHGRZPlbbSBOyLiQGT0NGrx2IQ6qc0Gqea2qtAph0
 aMVIg4MQYIuOgTnSZV0ciU6dyV/XSdkKve2ttal/3/w2u6j+HBRw5k/kqrL76G3RobZ1KkVwcHa
 Fh6OKN/HdRI6jY12tJ7G95sy8pCO+xzfvE2n6nxTU9a07X9eC3tJBNVqC
X-Gm-Gg: AY/fxX5uJrBVKSK9IDs5TXKHN78mS8QtW4eR68gEeY0nSfd2CeJcXY8q6JkRDU7uWtu
 cme/cWj/0lOtZHL/IfVxxEcF3buxl9bnJ4JU/n08SXVQVM28lW5EPLBXuReqa27Z8TWewkJIJd7
 srzfDOuzghtbWcFXklfZNs8uhl+S2vnnQlLCf1+1SjOnayrjAXGAqdRL1KA68xF5L1eMSYnyPo7
 tR9+j1CYjiBqg5Vy1u05powTxItIwCizjRQsEDdIwQBYcBALCC7tlopjC1tNyFwJ3VoB/uKvZDS
 l92h5/iwtQMrivIBaRjOWBoVpPsr3iWuHdrEqBoSxPVzDeYo/5x8qXHGGnXevxf9nwA8LCYguMo
 DdAEzKZnPZY0zqzhVVdWY4oH8PRATBWWZ/zW9aMWpcL3ZRRa4
X-Received: by 2002:a05:600d:7:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47a932e5731mr58210345e9.35.1765734477665; 
 Sun, 14 Dec 2025 09:47:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4EWJiyR47oEWBKRxnsV+5onD64NKYtaQLj6ycjySaIWaWmHJo5aN/Chw896YW0V0ZtPPI0w==
X-Received: by 2002:a05:600d:7:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47a932e5731mr58210215e9.35.1765734477208; 
 Sun, 14 Dec 2025 09:47:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f6f26ebsm148719965e9.14.2025.12.14.09.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Dec 2025 09:47:56 -0800 (PST)
Message-ID: <e08dcb25-a258-4e65-bd2c-360c8a08591c@redhat.com>
Date: Sun, 14 Dec 2025 18:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/vhost-user-bridge.c: Fix const qualifier build
 errors with recent glibc
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>
References: <20251210181306.926334-1-clg@redhat.com>
 <20251210181306.926334-3-clg@redhat.com>
 <bc52f621-493d-4df6-8403-1e4c7e2be424@yodel.dev>
 <2a9859fa-1617-4d26-a618-acb63fbe0bb6@yodel.dev>
 <b0a2d9da-1a8d-4352-b761-9b1f604c6894@redhat.com>
 <82fbb148-153b-4d1c-bbe1-89f73318de5a@yodel.dev>
 <11454796-30d2-4a57-85a5-d42ff0dce2e6@redhat.com>
 <9247eb0c-1867-497d-97d0-ad1621d6c24d@yodel.dev>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9247eb0c-1867-497d-97d0-ad1621d6c24d@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+ Thomas,

On 12/14/25 17:18, Yodel Eldar wrote:
> 
> 
> On 14/12/2025 02:56, Cédric Le Goater wrote:
>> Hello Yodel,
>>
>> On 12/13/25 21:15, Yodel Eldar wrote:
>>>
>>> On 13/12/2025 00:59, Cédric Le Goater wrote:
>>>> On 12/13/25 01:17, Yodel Eldar wrote:
>>>>>
>>>>> On 12/12/2025 17:33, Yodel Eldar wrote:
>>>>>> Hi, Cédric!
>>>>>>
>>>>>> On 10/12/2025 12:13, Cédric Le Goater wrote:
>>>>>>> A recent change in glibc 2.42.9000 [1] changes the return type of
>>>>>>> strstr() and other string functions to be 'const char *' when the
>>>>>>> input is a 'const char *'. This breaks the build in :
>>>>>>>
>>>>>>> ../tests/vhost-user-bridge.c: In function ‘vubr_parse_host_port’:
>>>>>>> ../tests/vhost-user-bridge.c:749:15: error: initialization discards ‘const’ qualifier from pointer target type [- Werror=discarded- qualifiers]
>>>>>>>    749 |     char *p = strchr(buf, ':');
>>>>>>>        |               ^~~~~~
>>>>>>>
>>>>>>> Fix this by using the glib g_strsplit() routine instead of strdup().
>>>>>>>
>>>>>>> [1] https://sourceware.org/git/? p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
>>>>>>>
>>>>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>>>> ---
>>>>>>>   tests/vhost-user-bridge.c | 10 ++++------
>>>>>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
>>>>>>> index a5c711b1de8e9c164dd1614f4329b8e3c05d0402..ce4c3426d3938a0b54195f3e95bb1f1c3c4ae823 100644
>>>>>>> --- a/tests/vhost-user-bridge.c
>>>>>>> +++ b/tests/vhost-user-bridge.c
>>>>>>> @@ -746,14 +746,12 @@ vubr_run(VubrDev *dev)
>>>>>>>   static int
>>>>>>>   vubr_parse_host_port(const char **host, const char **port, const char *buf)
>>>>>>>   {
>>>>>>> -    char *p = strchr(buf, ':');
>>>>>>> -
>>>>>>> -    if (!p) {
>>>>>>> +    g_auto(GStrv) tokens = g_strsplit(buf, ":", 2);
>>>>>>> +    if (!tokens[0] || !tokens[1]) {
>>>>>>>           return -1;
>>>>>>>       }
>>>>>>> -    *p = '\0';
>>>>>>> -    *host = strdup(buf);
>>>>>>> -    *port = strdup(p + 1);
>>>>>>> +    *host = g_steal_pointer(&tokens[0]);
>>>>>>> +    *port = g_steal_pointer(&tokens[1]);
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>
>>>>>> Thanks for addressing this before the glibc change is widely propagated
>>>>>> among distros.
>>>>>>
>>>>>> Acked-by: Yodel Eldar <yodel.eldar@yodel.dev>
>>>>>> Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
>>>>>>
>>>>>> For testing, I built and installed glibc (76 commits ahead of cd748a63a)
>>>>>> in an x86_64 Linux container and built vhost-user-bridge on top of that.
>>>>>> Ran it with:
>>>>>>
>>>>>> ./build/tests/vhost-user-bridge -H
>>>>>>
>>>>>> qemu-system-x86_64 \
>>>>>>      -enable-kvm -m 4G \
>>>>>>      -object memory-backend-ram,id=mem0,size=4G,share=on \
>>>>>>      -numa node,memdev=mem0 -mem-prealloc \
>>>>>>      -chardev socket,id=char0,path=/tmp/vubr.sock \
>>>>>>      -netdev type=vhost-user,id=net0,chardev=char0,vhostforce=on \
>>>>>>      -device virtio-net-pci,netdev=net0 \
>>>>>>      -drive file=linux.qcow2
>>>>>>
>>>>>> and visually inspected the logged traffic.
>>>>>>
>>>>>> Thanks,
>>>>>> Yodel
>>>>>>
>>>>>
>>>>> P.S. To build vhost-user-bridge, I had to modify util/log.c as in
>>>>> the PULL submission "<20251209200537.84097-9-philmd@linaro.org>".
>>>>>
>>>>> For completion, the commands used:
>>>>>
>>>>> ../configure --enable-tools --enable-vhost-user --disable-system \
>>>>>    --disable-user
>>>>>
>>>>> ninja tests/vhost-user-bridge
>>>>>
>>>>> Yodel
>>>>>
>>>>
>>>>
>>>> Thanks Yodel,
>>>>
>>>> My plan is to send a small PR as soon as QEMU 10.2 is out and ask
>>>> Michael T. to include the changes in the stable branches.
>>>>
>>>> C.
>>>>
>>>>
>>>
>>> Glad to hear it!
>>>
>>> Sorry for staggering my testing methodology over multiple emails, but I
>>> should add for clarification and completeness: to exercise your change
>>> to vubr_parse_host_port(), I passed various input into the -l and -r
>>> options of vhost-user-bridge; and, with:
>>>
>>>    tcpdump -i lo -n -X udp port 5678
>>>
>>> while running:
>>>
>>>    ./build/tests/vhost-user-bridge -H -l 127.0.0.1:4567 -r 127.0.0.1:5678
>>>
>>> for example,
>>>
>>> I was able to monitor the traffic (ARP requests) from port 4567 to 5678.
>>>
>>
>> Would you mind providing a test case under tests/ or tests/functional ?
>>
>> Thanks,
>>
>> C.
>>
>>
> 
> Certainly, that's a great idea! Although, I'll need to get better
> acquainted with QEMU's testing framework... Would you be willing to
> answer the occasional question regarding scope, approach, conventions,
> etc. over IRC? 

Sure. The #qemu channel is hosted on OFTC.

I think this test would qualify as a functional test. To run :

   $ make check-functional

You could get some inspiration out of test_virtio_gpu.py I suppose.
Check source [2].

See [3] to send patches.

Thanks,

C.

[1] https://www.qemu.org/docs/master/devel/testing/main.html#functional-tests-using-python
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/tests/functional/x86_64/test_virtio_gpu.py?ref_type=heads
[3] https://www.qemu.org/docs/master/devel/submitting-a-patch.html


> There's a Co-authored-by tag with your name on it if
> you so choose :-)
> 
> Yodel
> 


