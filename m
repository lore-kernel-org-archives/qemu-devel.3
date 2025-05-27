Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508E8C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 14:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvOG-00060X-DX; Tue, 27 May 2025 10:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJvO3-0005yY-JS
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJvNj-0002VV-JU
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748356456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mk1fXbk81YdLtCsSDKMZTpfd63H0PVVPW2BS//swE6o=;
 b=NSLEyy/Ae+NLDbIlrZCMMB+AYqgT7GCEr35UYQsQUO2RCL5/4M8KI47PlNssopWT+Ae3Lk
 VjrFEhPx8jBsdNyuWeVTMrVkV9aasyJFWyNsOQOtApz1FFWi/uqcEkVVEUmtQCDRvNa1N1
 dwUlj9F/O0wN0zsOB+WQbMwVyzsv1iY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-ltNGb3d9Pue_CP2rls9hHw-1; Tue, 27 May 2025 10:34:14 -0400
X-MC-Unique: ltNGb3d9Pue_CP2rls9hHw-1
X-Mimecast-MFC-AGG-ID: ltNGb3d9Pue_CP2rls9hHw_1748356453
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad55e9a80acso265390466b.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 07:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748356453; x=1748961253;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mk1fXbk81YdLtCsSDKMZTpfd63H0PVVPW2BS//swE6o=;
 b=TkeqYjssGQH3vYZrqxoKaPxI0zbU0UTngYn5LlmCxWs30r6N7bxgeFXq0xHNMhIh/7
 lNHHGIlNJR7mvmc/GDbiv6FCiUnFfntAQEZmy1O8gg16Q1dTQ/kLEL8uNLpfvLdYjUIS
 zk3epi1QvgstEun1tfEV2RU/y3zooshiCqp0198B4QZqC35GNIz7CI5WNGytUr3xEuJY
 qbF8l5ai0MNGFRk4ANuJZ+kYtPXL4jw20OT6+ZhXehhLVDpSr97Q2r9c1zgUdG13c7bb
 386bXHJ7DswpHGAb3TFA2tB9Xq6P/2B73BboSYkMAHeXa86mCvsSM2Hl0aFSwgReoZNX
 sj4Q==
X-Gm-Message-State: AOJu0YxXzFDpoBa8NC4pNT+tfYiZ/JNNYQuHILOxrkd7n/xOUzNhiKSq
 IIcDWRVVHEO1VCH1KQU5dyUIlVVByWqcylmn9dP6Ah1gWvYfNn9UL0EtanG7EpEzjE8LnC5BECk
 2baC26eXY0eWjH9XsZu6W70CLKz89UqEcCU+WbbbYwzb6vxk/B8xTvlIh
X-Gm-Gg: ASbGncs6OUMuuwXpJBh1SfC7MZLP/t6bXmTxg01887llm8AZZqDUob41awz9ufAKgsY
 N3EYqTzriUPEUXRDPKlLvpVp8VDvLeXMm6byBAz5pv2kmv8TYv5QRj84y0RPj9ihkQahzV4czUL
 DtsOj0DHXHwM3/3C9DolmIG3thR1Lqzj1Ieh3x0pCCY7SqgbflKgtQ9oxRVn6kcABtzL+HTiGyB
 +Kj1AtAsIbFNI4XHky0bfoL0BLsPECv5Vy6iT9exL3/c5uO6u1/wtWlcUwNobX68GMtfkdtcSgU
 avkgjoupAnPX4A==
X-Received: by 2002:a17:907:971d:b0:ad8:9811:c0c2 with SMTP id
 a640c23a62f3a-ad89811c2acmr102878266b.61.1748356453235; 
 Tue, 27 May 2025 07:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEem5YfwEj6pamo7GYwyxFuYkaO6YqPZMB0x5wx56szzRm+Snw/QZYE2AbF/Ul23Y+7B1JMOg==
X-Received: by 2002:a17:907:971d:b0:ad8:9811:c0c2 with SMTP id
 a640c23a62f3a-ad89811c2acmr102875666b.61.1748356452712; 
 Tue, 27 May 2025 07:34:12 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d278290sm1844489066b.78.2025.05.27.07.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 07:34:12 -0700 (PDT)
Message-ID: <feb8251e-715f-4de7-a390-eb5b053de0f6@redhat.com>
Date: Tue, 27 May 2025 16:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] util/error: allow non-NUL-terminated err->src
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-5-pbonzini@redhat.com> <87sekqmapy.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87sekqmapy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/27/25 15:42, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Rust makes the current file available as a statically-allocated string,
>> but without a NUL terminator.  Allow this by storing an optional maximum
>> length in the Error.
>>
>> Note that for portability I am not relying on fprintf's precision
>> specifier not accessing memory beyond what will be printed.
> 
> Can you elaborate on the portability problem?  I figure ...
> 
>>   {
>>       if (errp == &error_abort) {
>> +        const char *src = err->src;
>> +        if (err->src_len >= 0) {
>> +            /* No need to free it, the program will abort very soon...  */
>> +            src = g_strndup(err->src, err->src_len);
>> +        }
>>           fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
>> -                err->func, err->src, err->line);
>> +                err->func, src, err->line);
> 
> ... you're avoiding the simpler
> 
>             fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
>                     err->func, err->src_len, err->src, err->line);
> 
> because of it.

I couldn't find anything that says %s is allowed to not be 
NUL-terminated if a precision is given.  That is, whether something like 
this:

    char foo[] = {'H', 'e', 'l', 'l', 'o'};
    printf("%.5s\n", foo);

is guaranteed to work.

This is opposed to:

1) strnlen 
(https://pubs.opengroup.org/onlinepubs/9699919799/functions/strnlen.html), 
which is guaranteed to examine no more than the number of bytes given by 
the second character;

2) strndup, for which I found at least a clarification at 
https://www.austingroupbugs.net/view.php?id=1397.

3) g_strndup, which guarantees that the allocated block is of length n+1 
and padded with NULs (though in the case above there will be just one 
NUL anyway)

And also, for strndup/g_strndup it would be quite asinine to implement 
it using some kind of min(strlen(s), n) but for printf the complexity is 
greater so you never know.  I erred on the side of caution because 
avoiding an allocation before an abort() isn't particularly interesting.

Paolo


