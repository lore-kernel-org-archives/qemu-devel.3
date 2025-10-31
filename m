Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1033CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEqfl-0004su-Ks; Fri, 31 Oct 2025 11:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEqfj-0004sd-0r
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEqfd-0005WO-Da
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761923039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLTKgbk3e9q9jL/dshwAUizE4N7mSLBivRe4kAhE+8w=;
 b=i31i2JWuyhJwfp0KqwbQrPR/crxBX+XLWcbLov92AjZG6yPA7fr1Fh/ga3GW1UaVaj4MWD
 mkIaTui+xqMoStVoKHoEyP9F8a5xJXb/mFzLaBWUPwiyiXie7CLTcLyXxUGDonk96BYTpj
 ++edooXbLbhIRtlh3Z7F0HQiBQ9FE2k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-EYvWgyceOsqWZuJPWFYjXg-1; Fri, 31 Oct 2025 11:03:58 -0400
X-MC-Unique: EYvWgyceOsqWZuJPWFYjXg-1
X-Mimecast-MFC-AGG-ID: EYvWgyceOsqWZuJPWFYjXg_1761923037
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so2541394f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761923036; x=1762527836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLTKgbk3e9q9jL/dshwAUizE4N7mSLBivRe4kAhE+8w=;
 b=vcFtGGY/i8ADDk1/6koKGbN8h63cZJiEZGOZqip/GG5QZQyx2uPclZ2ObLH4Y4ydh5
 Y4BYMJI5EEYC3cYojJgSnWXkCyzv28kw/86qdB+1MRRCS9B297YPVVhLxUqOvRyfrUv7
 fs92wcJic79u1UugBL11nZmJZub3sCm7fOGav00v53oDXZpaVwTSbW9iL/mZquztQtJg
 QSlPXsrvruXQ65NUW83uPMfLeSShV/EOor7Bd4robwXQsQGCBcnb3HDc1Fqeii80wjXt
 q0NpwZThsuJWkg5mWcZ5eNPDUpdNpKdJMHJ5cJR5qTdD2qEWHBNtekjTu821CdVTaFNz
 mZlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX09Lit8Pi1udrwCXmdb+daYjn94dAfQ2xhyInS0R08+AtiS3H0hXqoC9P1E+90M5Klr0rVkcvYlHbV@nongnu.org
X-Gm-Message-State: AOJu0Yw36aBu5ZW/TZ6uOyUSBtfydR9DpEYdzzrqv0KzMfNvkNWFbDt4
 uzFM4UymfcssZvv8v9MsQp5TRQedsde8XnwAGiBqZyJZvqkDea2au6+Sf10e+mh5IRK3fn4S/eN
 Nl34yNNPhr6va39yDd2/fBz+Zr9JZ8dfC8y6MOyzMBFy53rwkOZgIMmFuTZOJSqiw
X-Gm-Gg: ASbGncujLP85e4hiUCUo/nRkEP9ouPn/VitBADSeKmf/wnljnAD6DnJhV/Uvv8Ch729
 q1SGKy4+PAO5F6WJzyLZhj5AeEK0gRJNdZy/UALzc9OVMnI95GsJFtmMSE1rzyHtQsQ8LfuHS5U
 9T0lAB2eUpMmsHmMkQ7nJyPRROiL4rCpjq/uFiOAPpf/VaNaIR1ee/rQSYw4WlK/r4yxljg06QG
 lh0kvn5fl/QhLTHYZGNF7h0ydD97PHtqnuWhe3nqUzeMW+mMPJ0nK+UpviJT/1cbNMhyztcHxV+
 RYvpsgoWskN+GmsyWETmZdxWnpHPn3wSfBDE2s1P6lgKB+daUEzVFunzZWMzrI4wtqk1VEUbeNn
 IBUFXK5DyhS4F86BsNVPJi8+5ucFkoBvkZ6Wl/0cc7aqdFwm30l5fOj/Z1xQ1Qp9ELCRKFV7OLz
 vU8rU1DOaDHB9ObjZB4xV/lN0HweHp
X-Received: by 2002:a05:600c:4687:b0:46e:4925:c74f with SMTP id
 5b1f17b1804b1-477308725a5mr30696295e9.20.1761923036005; 
 Fri, 31 Oct 2025 08:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFeXpKo+zmgL7gQEcg2wYn8qH40W3U+BgOUAZAhCHZZxRlT8b7JwQjsqJ5Swt0dLQuitR1dw==
X-Received: by 2002:a05:600c:4687:b0:46e:4925:c74f with SMTP id
 5b1f17b1804b1-477308725a5mr30695995e9.20.1761923035521; 
 Fri, 31 Oct 2025 08:03:55 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114ca0csm4785473f8f.21.2025.10.31.08.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 08:03:54 -0700 (PDT)
Message-ID: <67b6e046-3175-4d7b-b4b9-3ac56b733987@redhat.com>
Date: Fri, 31 Oct 2025 16:03:53 +0100
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
 <c9339232-476d-4074-9150-ea7c154658b7@redhat.com>
 <aQSsmAOnj2tAeNxx@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQSsmAOnj2tAeNxx@redhat.com>
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

On 31.10.25 13:33, Kevin Wolf wrote:
> Am 31.10.2025 um 13:13 hat Hanna Czenczek geschrieben:
>> On 23.10.25 17:11, Kevin Wolf wrote:
>>> Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
>>>> We probably want to support larger write sizes than just 4k; 64k seems
>>>> nice.  However, we cannot read partial requests from the FUSE FD, we
>>>> always have to read requests in full; so our read buffer must be large
>>>> enough to accommodate potential 64k writes if we want to support that.
>>>>
>>>> Always allocating FuseRequest objects with 64k buffers in them seems
>>>> wasteful, though.  But we can get around the issue by splitting the
>>>> buffer into two and using readv(): One part will hold all normal (up to
>>>> 4k) write requests and all other requests, and a second part (the
>>>> "spill-over buffer") will be used only for larger write requests.  Each
>>>> FuseQueue has its own spill-over buffer, and only if we find it used
>>>> when reading a request will we move its ownership into the FuseRequest
>>>> object and allocate a new spill-over buffer for the queue.
>>>>
>>>> This way, we get to support "large" write sizes without having to
>>>> allocate big buffers when they aren't used.
>>>>
>>>> Also, this even reduces the size of the FuseRequest objects because the
>>>> read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
>>>> the requests we support are not quite so large (except for >4k writes),
>>>> so until now, we basically had to have useless padding in there.
>>>>
>>>> With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
>>>> is easily met and we can decrease the size of the buffer portion that is
>>>> right inside of FuseRequest.
>>>>
>>>> As for benchmarks, the benefit of this patch can be shown easily by
>>>> writing a 4G image (with qemu-img convert) to a FUSE export:
>>>> - Before this patch: Takes 25.6 s (14.4 s with -t none)
>>>> - After this patch: Takes 4.5 s (5.5 s with -t none)
>>>>
>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>> The commit message seems outdated, there is no such thing as a
>>> FuseRequest object.
>>>
>>> I agree with the idea of allocating a separate buffer for the data to be
>>> written. I'm not so sure that the approach taken here with combining an
>>> in-place and a spillover buffer does actually do much for us in exchange
>>> for the additional complexity.
>>>
>>> The allocation + memcpy for in_place buf in fuse_co_write() bothers me a
>>> bit. I'd rather have a buffer for the data to write that can be directly
>>> used. And let's be real, we already allocate a 1 MB stack per request. I
>>> don't think 64k more or less make a big difference, but it would allow
>>> us to save the memcpy() for 4k requests and additionally an allocation
>>> for larger requests.
>>>
>>> The tradeoff when you use an iov for the buffer in FuseQueue that is
>>> only big enough for the header and fuse_write_in and then directly the
>>> per-request buffer that is owned by the coroutine is that for requests
>>> that are larger than fuse_write_in, you'll have to copy the rest back
>>> from the data buffer first. This seems to be only fuse_setattr_in, which
>>> shouldn't be a hot path at all, and only a few bytes.
>> So I understand that first, you disagree with “Always allocating FuseRequest
>> objects with 64k buffers in them seems wasteful, though.” I.e. to just use a
>> 64k buffer per request.  OK, fair.
> I think in practice most write requests will exceed the 4k anyway, so
> we'd already use the spillover buffer. Maybe the most common exception
> is fio, if we want to optimise for that one. :-)
>
>> Second, you suggest to improve performance by having an aligned 64k data
>> buffer separate from the request metadata buffer to save on memcpy().  I did
>> consider this, but discarded it because of I was afraid of the complexity.
>> Actually probably too afraid.
>>
>> I’ll take a look, it actually can’t be too hard.  (Just have two buffers;
>> make the metadata buffer long enough to capture all request headers, but
>> only pass the sizeof(fuse_write_in)-long head into readv(), then check the
>> request opcode.  If metadata spilled over to the data buffer, copy it back
>> into the “shadowed” metadata buffer tail.)
> Yes, that's what I had in mind. Not sure if it's premature
> optimisation...

Just to confirm – this means we will have to do an allocation for each 
write request.  I think this should still be cheaper than the current 
memcpy(), but still wanted to ask back whether you agree.

(We could have a pool of buffers, but that would most definitely be a 
premature optimization – and I hope our memalloc algorithm can do that 
internally just fine.)

Hanna


