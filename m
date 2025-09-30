Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE70CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 05:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Sh5-0007Li-Gs; Tue, 30 Sep 2025 01:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Sh1-0007JY-Oi
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Sgr-0007Cc-Ss
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 01:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759209250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rfYRaBbqDNHQ6F8NacsRRD2axBTWz2moGbHA2rCe8hU=;
 b=Fm87X0NZM+zuIJMwShVbg7S9vScJ9gBsotv2k9X/5+JW93YWjm2q1wdeueij7+N8x5CQUh
 5nC2Vo0nNi4WhX4mTrJsSVXi7aQk4KK01K5DjeaMSSqdrg/YpkOwaBEFdWo34MaQUhVYaw
 UyEkIfbCgQVQs3iC8Kmmj0/mn6zAe8Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-x9x5VzoBMPeRKgvw5Cz0ZA-1; Tue, 30 Sep 2025 01:14:09 -0400
X-MC-Unique: x9x5VzoBMPeRKgvw5Cz0ZA-1
X-Mimecast-MFC-AGG-ID: x9x5VzoBMPeRKgvw5Cz0ZA_1759209248
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b448c864d45so18995266b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 22:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759209248; x=1759814048;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rfYRaBbqDNHQ6F8NacsRRD2axBTWz2moGbHA2rCe8hU=;
 b=tS7gINFelRqoL1pSX7cAUAJwDUfWA72Ie2bRC3R3S0/QYSidkUEAddPUEwlr67Iikd
 ZvoLeJXXehkH+/jDcNFTYfzdOHuDal0E60dvN0NzdXXKVezPr42BgfH75nRKIAjCc3FD
 X6+UvC911YwIYdP+Ylg9C3fI7EFCCps9URK8VzWaStvwF4BFaMgOnsu8iqvHueXWCZeV
 UKyqTHixoDQGC2yS8tLd23bG246UR1Ckh9faCJ9ay6UbbxLh+88ZW8wSMHP4hCPrSrsE
 NFXlIyi7t7GKIfzBpJ1qOELoejOwEdK3gzWMIc2uaO6THornG6bw09rt0xRTocv9b4Mg
 OhTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXjhafzOayIHbCnmu2aJy+MIn1MfVjh+DAuLK9S8tL5zrEwZtvaQxA9Hul55R8mpQ60ix5MUwF2kKg@nongnu.org
X-Gm-Message-State: AOJu0Yw1Yt2uMQ0N6qpL7TYZWNipyDwewcRZaBbdBZUissAz2XRh/GOi
 hWXDxiou43gNQoM5UqXrwIK49S3hMCmslFo9M+NOEPxhA2/wsyAGT3NW5Mq64B1WjrQ8yPTN3gX
 kga5tfhuo/NIyFcoAIbgk2whfjvINSsnGkaz6QREeLEvOXqcqCUf4TwR3
X-Gm-Gg: ASbGncunF2/OiWRybScNn2bgWcwEi9CVUamLheHg45eo817xGW+ySv/6UVLUS81sSLI
 /eVQ0b/yEgYdpum2bC8AjmH5yGYhSam4/SgQ0SXeLU1MbrxxkZCWLhLozWDEESNmN7/Ue3/wrrA
 pTzec8mAnXu3d2uAUTrWreJz5G4vKQLZwQnzbUxfMzql0V0pdsrfN4LnXrgeQswxOfWJ97mMKBt
 hmyb2p7y563gDT494tB/JzowuQD9e+vy90y0eFVeZ3Vun6HW+0pEOyhC3mIKKibc3GhZdKzz2W6
 9rAZORvrluqPNQ5sDYjtTWc0+gtImH086a/8POoMXuNT2qjsOimuqGC5qWRTQ7l/cRVgRkW2eX3
 bxOm0MNTDZg==
X-Received: by 2002:a17:906:7312:b0:b41:4e72:30a0 with SMTP id
 a640c23a62f3a-b414e7242e3mr323514366b.56.1759209247823; 
 Mon, 29 Sep 2025 22:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFc+XaDzPUt/AGNCGqtSirrDdGPuml/3dR+xFW9Vk8kdHq0KBMGN7NxdXnzLaK6dYxJdrrkw==
X-Received: by 2002:a17:906:7312:b0:b41:4e72:30a0 with SMTP id
 a640c23a62f3a-b414e7242e3mr323511866b.56.1759209247409; 
 Mon, 29 Sep 2025 22:14:07 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3b9d55a5bcsm568718066b.70.2025.09.29.22.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 22:14:06 -0700 (PDT)
Message-ID: <8496255a-6070-4f20-8885-481d6cf539a2@redhat.com>
Date: Tue, 30 Sep 2025 07:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/28] pc-bios/s390-ccw: Add additional security checks
 for secure boot
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, borntraeger@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-22-zycai@linux.ibm.com>
 <e5faaffd-fb58-4002-817f-ff9e787e8272@redhat.com>
 <ddad9154-ae72-43b3-8d20-3ef4c0a43c46@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ddad9154-ae72-43b3-8d20-3ef4c0a43c46@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/09/2025 22.43, Zhuoying Cai wrote:
> Thank you for all the feedback! I'll address the comments in the next
> version.
> 
> On 9/29/25 9:30 AM, Thomas Huth wrote:
>> On 18/09/2025 01.21, Zhuoying Cai wrote:
...
>>> +    /* PSW points within a signed binary code component */
>>> +    for (int i = 0; i < range_index; i++) {
>>> +        if (comp_addr_range[i].is_signed &&
>>> +            addr >= comp_addr_range[i].start_addr &&
>>> +            addr <= comp_addr_range[i].end_addr) {
>>
>> is it still OK if the address points to the end_addr? Or should that be
>> end_addr - 2 instead (since an opcode has at least two bytes)?
>>
> 
> Using end_addr - 2 seems correct, since it accounts for the minimum
> instruction length.
> 
> Just to clarify: using end_addr - 2 should ensure that at least a 2-byte
> instruction fits. Should longer instructions (e.g., 4 and 6 bytes) be a
> concern in this context?

No clue ... but I guess it should be fine if the instruction at least starts 
in the signed area?

  Thomas


