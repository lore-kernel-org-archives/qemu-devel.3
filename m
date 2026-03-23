Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAB0F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ii8-0007hk-6L; Mon, 23 Mar 2026 13:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ihr-0007fK-Ns
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ihp-00020H-JL
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774285484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HmyevSYYbYiSldgunmcLQbxE92ZsBLdj7Awks5QpXo0=;
 b=NObE//78lvsSm/G0CGqknDBCSagVy7zOgr5Fi/SmmBLG2mAcdieTtoAdCbWoRXFEqk8YGD
 TCG6hh2S+a76yB8p735lo3A8Lc8o2uGrqxZOuhE37HcY1zQTFIQ4YE8oWzeBsZyHce0m4j
 PuZWVxbPP/9Zd6hOaN4ASUp+ioko2S0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-Pe0fpGYwOAGVTU_zm8WhOA-1; Mon, 23 Mar 2026 13:04:43 -0400
X-MC-Unique: Pe0fpGYwOAGVTU_zm8WhOA-1
X-Mimecast-MFC-AGG-ID: Pe0fpGYwOAGVTU_zm8WhOA_1774285482
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fb142205so38211755e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774285482; x=1774890282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HmyevSYYbYiSldgunmcLQbxE92ZsBLdj7Awks5QpXo0=;
 b=dfkNabG6v4mseUvLZxBplqaP7RH/LsxU5BbFd7zws2GuCovPi+jK8XFM3O0oFgAEH0
 8Ct43Ep4g8uDUCO8khCRZMPXuR3gNPYyVMRrZizOx+StGnicmfUQ+hnmBV4i2VjI3CE8
 Ts97ncUnJf5rFpGnwl1P1eQmrEN8IKr+XN54VdJU6MmNDS8wDg3aaXwfFTu+S5mUkSpW
 DgufFVtH803Ga2RjPNuHM4NDTX3FAzM7iNCdesmht2MT1TRCXdbwFab85byQq5JayZDl
 i6JzkAlQbA0DQzrh+JWj9wSQeOVHTvNJPHJwBM8aSiX5l56dUdTDkB1i0t3MmxP30eHQ
 zV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774285482; x=1774890282;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HmyevSYYbYiSldgunmcLQbxE92ZsBLdj7Awks5QpXo0=;
 b=fRqsXRAMUOyXC72mD5eQ0K0z9dQY/hDX1xykzw+DLovVqLD1GL1U8uUDvLm/KUWaJJ
 54w0yX0NuRpqVIZ7/l0dKG0aDajerLGQRQniXIl/cNd9G2QgRErsc9IOxZpg4svLrhsm
 srNSSvVNoQP6pELH48XRmj9uxyrRklXP14hRJ/rYEMp5QsInB/8ir7Uot1pt6i4WyIUR
 Fc0PleFpHqnaW7sNU2o7hMisUfsPZ9llFCRO4Zmg0fV9GEC1Ff2lk72OUFHPUzFVYYcY
 uSCUiG3ZVxSJtvakW+kXdnsZa+B1/b4c4WE3FgDfs1kaNuM0tIamFgwoFQv98q4nbfmv
 nKnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1DDXRmSrWnD9aTa9OE+PvVMgXmXcYZRWJj6YyOuxp8X8q2nTRdvP+yZ8KeQMlaChy7Ibyx0k6qyT5@nongnu.org
X-Gm-Message-State: AOJu0Yx3bkIXJwd7Xi26TyuUhuiUesZ0DBl8/FMuV0NpmzVqTDw0vCud
 F1hokTW7PuBypd7WTrSmu9LYtMqtKjwU23FJ6XuYDvtjd/RpgjcjW5Bcijv2rt3KxaJdFUjArIY
 8jFsryAJRpL2Ih+9cGUiT9jtA6jBgL5+cnPRJqgLR92vD0nLT72xqNslV
X-Gm-Gg: ATEYQzzg/kuyH1SuIHGsjIBCOB4yaLyf94Uf/OwDEWo0JIponoPkuS439dV8XdJF7v9
 EG+4R6fRc89Mdp37oWRIRjoCXkU3kIdJE4RGbeNGz5UkX9jlkm1uEkZKZkWzuQInApDoIwAwOgZ
 /kSHBKT/900OLvrSBXbrhCUo6OoIE1nMsypHZVtKatpQmLSzNJ5HR8m4GjdX+OY8rsb2s4VWr6F
 0iEBNYpM34ib15akkgGddFE0eAiD91kYut3FQJ8VubO8Xj6y0ObNlfr1J9BVLBItDBkSBhA8oe6
 t/icU6tIDFr8M39KMWo/C/sycxJFDhqy8SI8JgJ2WAP0mY2RjBZI353zxtZDepMF7TxLgZ6AiiA
 PfhPxMy5WDKp8FC5GpkXgtyZGkUZUUuHhpPH/XcTq9h+BIEJEy2T+sSfD62xppIN/CUKenwv6hC
 fDntPtYohNgiHsFABcI18FtRG/4EAqpemJt4YFP/+dG9pjQpdV09o=
X-Received: by 2002:a05:600c:4848:b0:486:ffa3:592 with SMTP id
 5b1f17b1804b1-486ffa30bf0mr100037115e9.24.1774285481860; 
 Mon, 23 Mar 2026 10:04:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4848:b0:486:ffa3:592 with SMTP id
 5b1f17b1804b1-486ffa30bf0mr100036825e9.24.1774285481313; 
 Mon, 23 Mar 2026 10:04:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d03c:df99:cbc9:b444:8cfa?
 (p200300cfd737d03cdf99cbc9b4448cfa.dip0.t-ipconnect.de.
 [2003:cf:d737:d03c:df99:cbc9:b444:8cfa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487004e7bc4sm120822885e9.2.2026.03.23.10.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 10:04:40 -0700 (PDT)
Message-ID: <236ef551-05c3-4bf4-8b0e-6e52106ca7ff@redhat.com>
Date: Mon, 23 Mar 2026 18:04:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 1/3] linux-aio: Put all parameters into
 qemu_laiocb
From: Hanna Czenczek <hreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
 <20260318153206.171494-2-hreitz@redhat.com> <acFqulONusPdbQHY@redhat.com>
 <d6622d0b-9198-47cf-8f80-42c4384a8883@redhat.com>
Content-Language: en-US
In-Reply-To: <d6622d0b-9198-47cf-8f80-42c4384a8883@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23.03.26 18:02, Hanna Czenczek wrote:
> On 23.03.26 17:36, Kevin Wolf wrote:
>> Am 18.03.2026 um 16:32 hat Hanna Czenczek geschrieben:
>>> Put all request parameters into the qemu_laiocb struct, which will 
>>> allow
>>> re-submitting the tail of short reads/writes.
>>>
>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>> ---
>>>   block/linux-aio.c | 35 ++++++++++++++++++++++-------------
>>>   1 file changed, 22 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/block/linux-aio.c b/block/linux-aio.c
>>> index 53c3e9af8a..1f25339dc9 100644
>>> --- a/block/linux-aio.c
>>> +++ b/block/linux-aio.c
>>> @@ -40,10 +40,15 @@ struct qemu_laiocb {
>>>       Coroutine *co;
>>>       LinuxAioState *ctx;
>>>       struct iocb iocb;
>>> +    int fd;
>>>       ssize_t ret;
>>> +    off_t offset;
>>>       size_t nbytes;
>>>       QEMUIOVector *qiov;
>>> -    bool is_read;
>>> +
>>> +    int type;
>> If you put fd and type next to each other, you'd avoid a hole in the
>> struct.
>
> And I assume pulling dev_max_batch forward, after qiov, yes.

Noticed while sending: I missed `.next` for some reason. So no reason to 
pull dev_max_batch forward, and I guess there will always be a hole, but 
I suppose it is still best to put all 32-bit ints next to each other 
(fd, type, flags) so filling that up in the future is more likely.

Hanna

>>> +    BdrvRequestFlags flags;
>>> +    uint64_t dev_max_batch;
>>>       QSIMPLEQ_ENTRY(qemu_laiocb) next;
>>>   };


