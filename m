Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BF8CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 12:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEo1L-0007vI-TL; Fri, 31 Oct 2025 08:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEo1J-0007uw-HR
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEo19-0001XA-7I
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761912841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fF4rLlliWWjQ8tZD2fzHXYjtmsoJfyaEqewXy2v5NTo=;
 b=OCQja1m6MPFVbZriTO7G/+qyId2Ycqyl6KvTRUAY2bwO28TCAmfUyZapTUiCi/rVXZumRB
 wUzN8KZeFUoEr5gisA8BoiL7rkSVfb/pfbsHkQ+9Yv4ITwFevl+uZf1XbkVi+fS2/pqj78
 S0TJdQxHpBNmF169/Sl/M3JBxQnn8N4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-Z3Fb7sp3OUquyOiFCF5oFw-1; Fri, 31 Oct 2025 08:14:00 -0400
X-MC-Unique: Z3Fb7sp3OUquyOiFCF5oFw-1
X-Mimecast-MFC-AGG-ID: Z3Fb7sp3OUquyOiFCF5oFw_1761912839
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4283bf540ceso1165889f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 05:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761912839; x=1762517639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fF4rLlliWWjQ8tZD2fzHXYjtmsoJfyaEqewXy2v5NTo=;
 b=FW6prVPKADZQOKbFaMABWLTG8pO4eChR4EC3H1aITkvvOfKSUdRZH/rHg842C4DxbQ
 phE8Czg+BDzrRqg50n8ulKzQx8hxdjpiwuSeablrlWhJPaWP9rKbHNmUQg5hQc3oU9ND
 qfg4stNmcQa4cX0XAhpbxc3CKPpC0ENlSIBMSsuQpz/6suMkZWQ7uaw2nWYbuJhi4Peg
 +2OqBUvKYFXRivB4trALflx4BSAR8rXucy1v9smNiFv66LiRrs8jCW3mCAejiYg+oF3L
 PkmhvDxcQ6ZHwfkKASai/ACpPIiLzdinfauriIN95pYPDooZ0Z1ZqdAgonIOj7RkJazP
 jecA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVbzQuj3yWJS7ZcyRMCfyt1BEskFnaMLbgys1dsH8i/dmMB09kZ6M/WF5/JsZ0M7sg7Edxsp0U5XwG@nongnu.org
X-Gm-Message-State: AOJu0YzO7qvTAdxBKU4z0kYdVkw1QsC1LrbMpHIK8tBDhRxNUBNt9VHG
 gdXbbnuaDXRgaH/xJAKlJ1ByDjh6pZ+JgGg9xFLGCQp0GuKaDHV7AoNZYqa6OyonqDtCOuxk7GK
 qrQKmtjB6M2TPsNe11euACgR87goU2sVn+hjJHvNMqIcm3N9ajK0P86wP
X-Gm-Gg: ASbGnctDIDK4yvo1MKNls/N5wC9GSZQ6UCQOOhkT7TrV1+m4WVLYQFE4jLnStRloL8L
 pNWualkHwMUrHilbpKte6IUoqXxQj6S7FbP+Gsu3TeIG29CoI606nA0ZuLMTTjnBJyw9QXc8dDP
 Yi8P7A5XbHy+KMCtP0RM8jU4zyrPn7DsBYTVW2F/KHbcLyP4TUHHOD4qo0Cm3//EBqSrgLErHUj
 cqq7zstAoZ9cyUdUhZf6QphHptjy9j9YOSmnlM9hhSLByjP9iGG0Adrgrw8PuTNBkU8KgGV5DVk
 L3X9+fjCG88Qk7P6idn/79kxL/OkAT7jNuM52ULHwnsVbhwcs5rmXUORH52JZbefDXJGxahuEB/
 Rw7xsUpOUXkW14QCYdCg+R5BrZjxfFRPlbYK5f25PqnovVNzLokYgNsIdjzp4s1FoFahFnqNaDl
 5RK2LIyJyojWHE8ZcjGI2r4kcOP491
X-Received: by 2002:a05:6000:290c:b0:427:9e6:3a76 with SMTP id
 ffacd0b85a97d-429bd69910emr2807098f8f.36.1761912838701; 
 Fri, 31 Oct 2025 05:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVsV7304QGlFGHyyOV/tHlIq8evk/LFat112nXRhrXPiUX8OlHfrs/MfbE0XgRc5rw0T0PWg==
X-Received: by 2002:a05:6000:290c:b0:427:9e6:3a76 with SMTP id
 ffacd0b85a97d-429bd69910emr2807078f8f.36.1761912838227; 
 Fri, 31 Oct 2025 05:13:58 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e0325sm3275112f8f.29.2025.10.31.05.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 05:13:57 -0700 (PDT)
Message-ID: <c9339232-476d-4074-9150-ea7c154658b7@redhat.com>
Date: Fri, 31 Oct 2025 13:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/21] fuse: Increase MAX_WRITE_SIZE with a second
 buffer
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-22-hreitz@redhat.com> <aPpFogd44fuISVKd@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aPpFogd44fuISVKd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 23.10.25 17:11, Kevin Wolf wrote:
> Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
>> We probably want to support larger write sizes than just 4k; 64k seems
>> nice.  However, we cannot read partial requests from the FUSE FD, we
>> always have to read requests in full; so our read buffer must be large
>> enough to accommodate potential 64k writes if we want to support that.
>>
>> Always allocating FuseRequest objects with 64k buffers in them seems
>> wasteful, though.  But we can get around the issue by splitting the
>> buffer into two and using readv(): One part will hold all normal (up to
>> 4k) write requests and all other requests, and a second part (the
>> "spill-over buffer") will be used only for larger write requests.  Each
>> FuseQueue has its own spill-over buffer, and only if we find it used
>> when reading a request will we move its ownership into the FuseRequest
>> object and allocate a new spill-over buffer for the queue.
>>
>> This way, we get to support "large" write sizes without having to
>> allocate big buffers when they aren't used.
>>
>> Also, this even reduces the size of the FuseRequest objects because the
>> read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
>> the requests we support are not quite so large (except for >4k writes),
>> so until now, we basically had to have useless padding in there.
>>
>> With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
>> is easily met and we can decrease the size of the buffer portion that is
>> right inside of FuseRequest.
>>
>> As for benchmarks, the benefit of this patch can be shown easily by
>> writing a 4G image (with qemu-img convert) to a FUSE export:
>> - Before this patch: Takes 25.6 s (14.4 s with -t none)
>> - After this patch: Takes 4.5 s (5.5 s with -t none)
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> The commit message seems outdated, there is no such thing as a
> FuseRequest object.
>
> I agree with the idea of allocating a separate buffer for the data to be
> written. I'm not so sure that the approach taken here with combining an
> in-place and a spillover buffer does actually do much for us in exchange
> for the additional complexity.
>
> The allocation + memcpy for in_place buf in fuse_co_write() bothers me a
> bit. I'd rather have a buffer for the data to write that can be directly
> used. And let's be real, we already allocate a 1 MB stack per request. I
> don't think 64k more or less make a big difference, but it would allow
> us to save the memcpy() for 4k requests and additionally an allocation
> for larger requests.
>
> The tradeoff when you use an iov for the buffer in FuseQueue that is
> only big enough for the header and fuse_write_in and then directly the
> per-request buffer that is owned by the coroutine is that for requests
> that are larger than fuse_write_in, you'll have to copy the rest back
> from the data buffer first. This seems to be only fuse_setattr_in, which
> shouldn't be a hot path at all, and only a few bytes.

So I understand that first, you disagree with “Always allocating 
FuseRequest objects with 64k buffers in them seems wasteful, though.” 
I.e. to just use a 64k buffer per request.  OK, fair.

Second, you suggest to improve performance by having an aligned 64k data 
buffer separate from the request metadata buffer to save on memcpy().  I 
did consider this, but discarded it because of I was afraid of the 
complexity.  Actually probably too afraid.

I’ll take a look, it actually can’t be too hard.  (Just have two 
buffers; make the metadata buffer long enough to capture all request 
headers, but only pass the sizeof(fuse_write_in)-long head into readv(), 
then check the request opcode.  If metadata spilled over to the data 
buffer, copy it back into the “shadowed” metadata buffer tail.)

Hanna

> All that said, what you have is an obvious improvement over limiting
> write requests to 4k.
>
> Kevin
>


