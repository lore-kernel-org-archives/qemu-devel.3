Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A66C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk3A9-0003qk-6G; Mon, 17 Feb 2025 10:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1tk39z-0003qJ-Ts
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:35:53 -0500
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1tk39x-0003lB-EG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:35:51 -0500
Received: from [IPV6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c] (unknown
 [IPv6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c])
 by apollo.dupie.be (Postfix) with ESMTPSA id 4452C1520F81;
 Mon, 17 Feb 2025 16:35:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1739806547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqDXzkdwkc4rkSKzUj9+Qe/wC85AbgQ8duyexurXZbE=;
 b=RO8pZAxIl4WicEyleJe1fH6INA3RRQbMjaXgw/kXMI6h36zJ0Zujf1zpJgiV38w5oZlAMC
 6hMreMQdhbFZv147tXSO5rt9bGdGegjgJHJGaby8eTjyBhHT5wOXFroQ9+K8LlpHsCnX1Z
 txW1sHuMvdugUL83Ben54hFq6LwMprVZ3bIbBE3d6way6/G74loZTvp3juM9nfULeflG2w
 Loqq1DAhi0yue7DIw9zCPzJwWdiVSwvyMzkHRYJDhliurE5bfrNXFthqsbpiWT9pUHhFif
 XbfESHeFjnpp+TbgTjoAWVIVG98RXV8g1xz4suDPzXt8OGayHIvk53TBoVojOA==
Message-ID: <339c366e-8dac-4121-9400-6068f395f9b9@dupond.be>
Date: Mon, 17 Feb 2025 16:35:47 +0100
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 2/2] qcow2: don't allow discard-no-unref when discard
 is not enabled
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org,
 kwolf@redhat.com, andrey.drobyshev@virtuozzo.com
References: <20240605132539.3668497-2-jean-louis@dupond.be>
 <20240605132539.3668497-3-jean-louis@dupond.be>
 <5c991b76-dfae-46d2-b896-8e8dafcfd368@redhat.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <5c991b76-dfae-46d2-b896-8e8dafcfd368@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
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


On 7/10/24 15:00, Hanna Czenczek wrote:
> On 05.06.24 15:25, Jean-Louis Dupond wrote:
>> When discard is not set to unmap/on, we should not allow setting
>> discard-no-unref.
>
> Is this important?  Technically, it’s an incompatible change, and 
> would require a deprecation warning first.
No it doesn't hurt, but it's 'cleaner'.
But indeed, if its a hassle to get that resolved, we can leave it like 
this.
>
> (I can imagine people setting this option indiscriminately on all 
> image, whether discard actually plays a role or not.  It may make 
> sense for them.)
I don't think a lot of people use the discard-no-unref option (yet).
>
> Hanna
>
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   block/qcow2.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 50354e5b98..cead5479e4 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1156,6 +1156,12 @@ qcow2_update_options_prepare(BlockDriverState 
>> *bs, Qcow2ReopenState *r,
>>           ret = -EINVAL;
>>           goto fail;
>>       }
>> +    if (r->discard_no_unref && !(flags & BDRV_O_UNMAP)) {
>> +        error_setg(errp,
>> +                   "discard-no-unref is only valid with 
>> discard=unmap/on");
>> +        ret = -EINVAL;
>> +        goto fail;
>> +    }
>>         switch (s->crypt_method_header) {
>>       case QCOW_CRYPT_NONE:
>

