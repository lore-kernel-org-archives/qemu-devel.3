Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED5710775E1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2u0J-0006ir-Mt; Wed, 18 Mar 2026 12:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2u0H-0006i6-VY
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 12:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2u0E-0006PN-Et
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 12:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773852251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UA63hmKg84npnsscASkCdHsTVjRESYIZeFpzR6rWNd0=;
 b=fdd2qEka9Y0S4SVwcB3RfgrhegQwA0Vd1EXG6/YjswlxWbK887goKh9QqHqSUdjcigNkzW
 BbI0l1Xu1OR2m3uOY9Vm26tlz3DmxaSHKoLVpMyCPDm7rgd61cWdDDMAkVgxOz3coh5ZRK
 hxaCFhFPBfBUuL1JkdQ656KSApwE2r8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-JKyGzuMfOJK_33ik6UJu4g-1; Wed, 18 Mar 2026 12:44:10 -0400
X-MC-Unique: JKyGzuMfOJK_33ik6UJu4g-1
X-Mimecast-MFC-AGG-ID: JKyGzuMfOJK_33ik6UJu4g_1773852249
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439bab2d095so340053f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773852249; x=1774457049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UA63hmKg84npnsscASkCdHsTVjRESYIZeFpzR6rWNd0=;
 b=SYdeReCmFRzwCr7b0YhCu42Hk2qOMmSj2KcfKjULe2xpwMY0/WGIFiQMvFU2pAdrzv
 rv7sa31rMJXkNBLxhiZxYi+9xF+UWCarAbYTp1tv1XULdfezpvKSBdxlgvyqGv6OBn/d
 wkNKExsBGX872QB4j6nI8znm3nZ8ZIzkdUXCHlj0TOqJTeAc8gJdryu+R98N3uXfCYKl
 /kAzlScg049O3V258aTattA8LiHZPT5Y7fceAZyx3wQbyz1m0a/N/NFOq+NWV3o9Ucbt
 qTWTvZaFugJi00d0Mvc+E7FL6eurfNq4sy4lsCcfhcwdRgHgUK56FpVGeO7z6AJXXSFE
 yvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852249; x=1774457049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UA63hmKg84npnsscASkCdHsTVjRESYIZeFpzR6rWNd0=;
 b=DydlJ300Dp6Jc9M5+HlkNpdYZJ587e8lrloIw9O7XbYIYomtj6Ku3eKxH3gXx4Zvnp
 ARjGJzwcrSC79xrBiWIDAnKVzKQNXambst8xJmMf/Ypp1H4K8jLn7R8MQYViDLxBulMC
 ZRZ/JEkOXb/eyji0z1fT2GUOdEVp1aHXxeeAGC+SPss3VyEx0RTOoBwGPDFuyR8v2dwc
 nH9FWXzcQjmSwKWeuq8JkA7VvR1QBd7zmIBWhOOdpQOO5LqaPhp9scM6EoQZzT7zVnpQ
 Xbn16VH4TGopL8S7edUaYbLGxosB7lw65KqH4d+TVCIg0q0mhO2fmAacBhUwlX2LnmKU
 EiVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkI+HGbXSP6cwk7bgs9z+7iibeIvKjrPQ8txoAUhG2TGFEb3gcKCheLnICYBZWPh2SLUl70N8ANy7H@nongnu.org
X-Gm-Message-State: AOJu0YyUCnhAH0K/3BOxS/hl9HJVPRqdigFdmwWjilHDWMToPcySCHTF
 CcbhMmxMa4qYfDJ1eCWgll7QRxUk/UkaO32lirjb+i4z6K4GJ1dXLkoA8UfO6qzyTbjsYHMOdPD
 v92Uyg+S5lS6pyLgvLXoGwscTyFrijOUnEd3EHf50i21o5cGMfR1kvzoT
X-Gm-Gg: ATEYQzxKim9H8lG4a9DbkhtyzOoBxUABVvNinJunAMCXpqfsChwRGWHFc0hznZDPsDI
 E/Dte/QMoqJXWDvX7wkw2JwNmAb4/AZrV2g6VzxInwlrUj/B7VopzxKgq1rpfkU5cvxQ3PGS9yv
 g1PUnSgqshnDYvq4dLIWQinYOSrBjj8yU+0d3s6846SlLrRlAetKRCr48EruuJMF4jURcFh++Ji
 tZIocMP+D/S0ZFmDeViSS9FYfZdAb/zRmFYQAoHQ88kvZK7oNOEAYxKHPK0Ina0eJ2CVA8v/B1c
 dyBy2d81haC1BnqEMB9vJsp5TMnJOyg4I6cM20e21edwr7i7X1aoYSRHCjN5b4tiUevy/Khb4sq
 oe/JWSd2Qb3sywcPlhKxEjEHBj2bzBZspZanWC7kMvq8L6lgnkKxg6fP4rSAO1YAAlr3cRpI7lr
 Yv5CR6n2hlOJWegcitAVOFazm2Zjx8Pm/k7vQ25umieHZ0WzUd
X-Received: by 2002:a05:600c:4e46:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-486f44485b3mr63863835e9.17.1773852248863; 
 Wed, 18 Mar 2026 09:44:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4e46:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-486f44485b3mr63863405e9.17.1773852248373; 
 Wed, 18 Mar 2026 09:44:08 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d033:4b9:bf78:3d26:f60b?
 (p200300cfd737d03304b9bf783d26f60b.dip0.t-ipconnect.de.
 [2003:cf:d737:d033:4b9:bf78:3d26:f60b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5184962bsm9160516f8f.7.2026.03.18.09.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 09:44:07 -0700 (PDT)
Message-ID: <8562aca8-c6a4-46a4-843b-43e25ddc9775@redhat.com>
Date: Wed, 18 Mar 2026 17:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iotests/041: add test for mirror with throttled NBD
 export as target
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, qemu-stable@nongnu.org
References: <20260311145717.668492-1-f.ebner@proxmox.com>
 <20260311145717.668492-3-f.ebner@proxmox.com>
 <ad6a2467-3763-4590-8a86-097ab916a4c1@redhat.com>
 <3f4ddd09-a79b-4bfc-93d4-a3f7b6146da0@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <3f4ddd09-a79b-4bfc-93d4-a3f7b6146da0@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 18.03.26 15:51, Fiona Ebner wrote:
> Am 16.03.26 um 6:27 PM schrieb Hanna Czenczek:
>> On 11.03.26 15:54, Fiona Ebner wrote:
>>> Mostly in preparation for commit "iotests/041: add test for duplicate
>>> job-complete with throttled target".
>>>
>>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>>> ---
>>>    tests/qemu-iotests/041     | 112 ++++++++++++++++++++++++++++++++++++-
>>>    tests/qemu-iotests/041.out |   4 +-
>>>    2 files changed, 113 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>>> index 8452845f44..a7e1980f13 100755
>>> --- a/tests/qemu-iotests/041
>>> +++ b/tests/qemu-iotests/041
>> [...]
>>
>>
>>> +    def tearDown(self):
>>> +        os.remove(test_img)
>>> +        os.remove(target_img)
>>> +        os.remove(backing_img)
>>> +        os.remove(target_backing_img)
>> It would be good if tearDown() could still contain the VM/QSD shutdown/
>> stop.
> Will do!
>
>>> +
>>> +    def test_throttled(self):
>>> +        self.vm.cmd('blockdev-mirror',
>>> +                    job_id='mirror',
>>> +                    device='source',
>>> +                    target='target',
>>> +                    sync='full')
>>> +
>>> +        time.sleep(1)
>>> +        result = self.vm.qmp('query-block-jobs')
>>> +        self.assert_qmp(result, 'return[0]/ready', False)
>>> +        self.vm.qtest(f'clock_step {4 * 1000 * 1000 * 1000}')
>>> +        time.sleep(1) # in real time, the rest should now comlpete fast
>> I think the clock_step belongs on the export side, the QSD.  On the
>> other hand, QSD has no way to enable qtest, I believe, so it won’t work
>> well as an export here.  I think it works accidentally because throttle
>> allows a burst, and can allow to write 3 MB in 2 seconds.
> Ah, good catch! I originally did everything with just the VM, but
> draining during mirror completion disables the throttling, so the issue
> with the duplicate complete wouldn't trigger for the test in patch 3/3.
> That's why an external target is needed.
>
>> This whole test is also a bit fiddly. It needs to write 3 MB in one
>> second, I believe, which seems prone to being flakey.  I’d be happy with
>> a null export on the target side, if that still did the job (pun intended).
> The one from patch 3/3 relies on the same kind of behavior. I guess
> using a second VM instance rather than QSD for the export could work?
> And adapting the test to make throttling actually have an effect.

Yes, that’s what I had in mind.

Hanna


