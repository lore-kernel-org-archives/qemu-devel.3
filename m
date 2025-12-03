Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBB0D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 07:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhTs-000808-Fx; Wed, 03 Dec 2025 02:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQhTk-0007yR-9b
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQhTi-00031f-Gd
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764747645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cDzepYrRfqrPnahNj+ZYP64d9c9UwUQEVVAKAV+buyE=;
 b=dSlrzJIr5rmlpcRCMXOn/vf8VLHLMgA4cpQp6WDB+6Z5GlIwNlNyuaukaUb6FWGvId3yoW
 4VC8dhgBb5MmoPsbbAmUGfRLKWUut8Ig82ysC6/U/trJW0zXEV97X1m646jr3BKHq0E5HC
 zGJT03XJqHemD+kZI7qvJMMK4UcqshY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-UPgWgk22NvilKnAdR12iCw-1; Wed, 03 Dec 2025 02:40:42 -0500
X-MC-Unique: UPgWgk22NvilKnAdR12iCw-1
X-Mimecast-MFC-AGG-ID: UPgWgk22NvilKnAdR12iCw_1764747641
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2c8fb84fso3784974f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 23:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764747641; x=1765352441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cDzepYrRfqrPnahNj+ZYP64d9c9UwUQEVVAKAV+buyE=;
 b=iT/2CoRILZVXHhgV1NO6GHwk2OsdxYrdP+ttSWn+lGwZG2DE7s9wYb+e/faSUqZ1zI
 WcK5QDMsne5qFke9Glk/bBtweH73DDoVRgDaeCmlVp1CTY/eOmaoIDiafi3QWIBs4Onv
 zUDRNlmtEBhZ/iiOBYyyB8oAdQ23Tmc5IdmfExwy/ASrYiGLARCb3a2WdSbeNNbpA9oT
 yrv0bDH4y8tZ/f0D/YxZApGB1ry5gAgr7HCVHo2TW3G3frp9RCHHkK1hDERKunzkVmcp
 WOKUr+83OfNBlrz39FJFtpGpwQGAoyv5z3KuB/IauE13s1OI/JZ7uQNr7KWRQAnNitUx
 BcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764747641; x=1765352441;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDzepYrRfqrPnahNj+ZYP64d9c9UwUQEVVAKAV+buyE=;
 b=QnFinzM2vtWfm72e2aIV4ijNaFov2W/LP0s568KBd1knwElSqZ0/EK8inxUrUYl6ne
 6uFbOVt2kkl4ZmGLQicQR+rbuhDVciiEr4a4ipnZsQxhsjFl8Sc5uez9oeH4zD3lLDoH
 2vSmje/Je97jRiltr0ri4OsrSo/mIH9RjTX0oqvLSei5CcCCA9YGMK/fGY/NdqPi/xNe
 117qClJP2tcitIItAjxmqorpTLcAITe92uArEomzGwMWi1ujPCnBtHUJB5IU1AtaczcN
 TCbA9LoMo3JDrUlOC61tqCQaRbh/8Wpo7hAeqAtfer+xWmvKYBMNjVjF7pRm8gsvfU5/
 fAzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQklsG8dpv/MW+ZOzn323Y/GerdXns1hMDo1wX48tgKiQ0PhAb+/Wr4y0ifA1BhxGFn4gwF5P0eOqr@nongnu.org
X-Gm-Message-State: AOJu0YxxYmiF/SKtQbhHegtBjs4s1Dx9RCLOv/Ec4mhgho9R0lwwPcNU
 IzPCbeb9iDYCwDh/rwmhaZVd5J+da6TYtOnW23V9v7ecbRmR4qVu6k2zgzv69uHEh2eFshwl1h/
 croUD7LT0gk/dgujlGvKtdnbymUtkq4+7hWMly08Nt0jqL3c2Lq2Lwvo8
X-Gm-Gg: ASbGncsbEeVVdu9ByjmBOGIOtJBFhg2ZhNrjzJ67Nh+n93O69XyFkjZpyL6QwjpMHyu
 IhkfblQWj/P6DVlnj8wyUqLQeK9vJhj4D3Z9tYf0wDEu09QxTfN/ZPQ3yG1oUrW2IacQBFo/Jw6
 ja5daj8RCdiE6SRNCfcgbqth3brL9RdKBdPkMfZSGlR0qcW9GpmYtR6bKKXsd0fCqzS3bs+sNUS
 448XqHblQswti14N9UDXi/ypzr8rva3v0lAFv6cFYKISpw7UW6K7ijLwzbwxjmjHFnCoA8EhU8T
 4Klt08KAGIsOnWOk/Oj+wCPLM2Dkm1f0B2iggj5X4rRO2NWc2Dx7Ctrm6ZvvH/X/hqTvvmNGrp9
 jp3n6YL374b6WYAyHE2gndaggbgR8pCHAzQt63UV8wnMNh+/H
X-Received: by 2002:a05:6000:615:b0:42b:39fb:e87f with SMTP id
 ffacd0b85a97d-42f731a39d2mr1185774f8f.49.1764747640766; 
 Tue, 02 Dec 2025 23:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv1iJynUt3XNclYGaq/pKC0WrXB3O4yu+iVxRK7i7LzD7HwWvtQMDzYWT3ulTiUrtVDzutUg==
X-Received: by 2002:a05:6000:615:b0:42b:39fb:e87f with SMTP id
 ffacd0b85a97d-42f731a39d2mr1185758f8f.49.1764747640342; 
 Tue, 02 Dec 2025 23:40:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f6ffa18ffsm6692381f8f.5.2025.12.02.23.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 23:40:39 -0800 (PST)
Message-ID: <e5d2d505-009e-412e-b032-8b80af493d32@redhat.com>
Date: Wed, 3 Dec 2025 08:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] vfio-user: refactor out header handling
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
 <20251201095621.2786318-4-john.levon@nutanix.com>
 <b7a282bc-bd97-4101-bf88-b69aef59eb54@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b7a282bc-bd97-4101-bf88-b69aef59eb54@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Hello John,

On 12/2/25 11:53, Mark Cave-Ayland wrote:
> On 01/12/2025 09:56, John Levon wrote:
> 
>> Simplify vfio_user_recv_one() by moving the header handling out to a
>> helper function.
>>
>> Signed-off-by: John Levon <john.levon@nutanix.com>
>> ---
>>   hw/vfio-user/proxy.c | 101 +++++++++++++++++++++++++------------------
>>   1 file changed, 60 insertions(+), 41 deletions(-)
>>
>> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
>> index 82c76c6665..87e50501af 100644
>> --- a/hw/vfio-user/proxy.c
>> +++ b/hw/vfio-user/proxy.c
>> @@ -218,6 +218,61 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
>>       return 1;
>>   }
>> +static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
>> +                              VFIOUserHdr *hdr, int **fdp, size_t *numfdp,
>> +                              bool *isreply)
>> +{
>> +    struct iovec iov = {
>> +        .iov_base = hdr,
>> +        .iov_len = sizeof(*hdr),
>> +    };
>> +    int ret;
>> +
>> +    /*
>> +     * Read header
>> +     */
>> +    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, fdp, numfdp, 0,
>> +                                 errp);
>> +    if (ret == QIO_CHANNEL_ERR_BLOCK) {
>> +        return ret;
>> +    }
>> +
>> +    /* read error or other side closed connection */
>> +    if (ret <= 0) {
>> +        error_setg(errp, "failed to read header");
> 
> Can we use error_setg_errno() here to record the real underlying return code in errp? Otherwise with this change it gets lost due to vfio_user_recv_hdr() always returning -1 if there is an error.

Can you please send a v4 with this change requested by Mark ?

I will then prepare a last QEMU 10.2 PR with this series and
the vfio-user doc update I left behind.

Thanks,

C.




> 
>> +        return -1;
>> +    }
>> +
>> +    if (ret < sizeof(*hdr)) {
>> +        error_setg(errp, "short read of header");
>> +        return -1;
>> +    }
>> +
>> +    /*
>> +     * Validate header
>> +     */
>> +    if (hdr->size < sizeof(*hdr)) {
>> +        error_setg(errp, "bad header size");
>> +        return -1;
>> +    }
>> +
>> +    switch (hdr->flags & VFIO_USER_TYPE) {
>> +    case VFIO_USER_REQUEST:
>> +        *isreply = false;
>> +        break;
>> +    case VFIO_USER_REPLY:
>> +        *isreply = true;
>> +        break;
>> +    default:
>> +        error_setg(errp, "unknown message type");
>> +        return -1;
>> +    }
>> +
>> +    trace_vfio_user_recv_hdr(proxy->sockname, hdr->id, hdr->command, hdr->size,
>> +                             hdr->flags);
>> +    return 0;
>> +}
>> +
>>   /*
>>    * Receive and process one incoming message.
>>    *
>> @@ -230,10 +285,6 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>>       g_autofree int *fdp = NULL;
>>       VFIOUserFDs *reqfds;
>>       VFIOUserHdr hdr;
>> -    struct iovec iov = {
>> -        .iov_base = &hdr,
>> -        .iov_len = sizeof(hdr),
>> -    };
>>       bool isreply = false;
>>       int i, ret;
>>       size_t msgleft, numfds = 0;
>> @@ -257,45 +308,13 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>>           /* else fall into reading another msg */
>>       }
>> -    /*
>> -     * Read header
>> -     */
>> -    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
>> -                                 errp);
>> -    if (ret == QIO_CHANNEL_ERR_BLOCK) {
>> -        return ret;
>> -    }
>> -
>> -    /* read error or other side closed connection */
>> -    if (ret <= 0) {
>> -        goto fatal;
>> -    }
>> -
>> -    if (ret < sizeof(hdr)) {
>> -        error_setg(errp, "short read of header");
>> -        goto fatal;
>> -    }
>> -
>> -    /*
>> -     * Validate header
>> -     */
>> -    if (hdr.size < sizeof(VFIOUserHdr)) {
>> -        error_setg(errp, "bad header size");
>> -        goto fatal;
>> -    }
>> -    switch (hdr.flags & VFIO_USER_TYPE) {
>> -    case VFIO_USER_REQUEST:
>> -        isreply = false;
>> -        break;
>> -    case VFIO_USER_REPLY:
>> -        isreply = true;
>> -        break;
>> -    default:
>> -        error_setg(errp, "unknown message type");
>> +    ret = vfio_user_recv_hdr(proxy, errp, &hdr, &fdp, &numfds, &isreply);
>> +    if (ret < 0) {
>> +        if (ret == QIO_CHANNEL_ERR_BLOCK) {
>> +            return ret;
>> +        }
>>           goto fatal;
>>       }
>> -    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
>> -                             hdr.flags);
>>       /*
>>        * For replies, find the matching pending request.
> 
> 
> ATB,
> 
> Mark.
> 


