Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DF0CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 07:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1untz1-00079y-HT; Mon, 18 Aug 2025 03:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1untz0-00079c-NX
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 03:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1untyy-0004eE-RB
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 03:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755500919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ReDQaIm8uDJju81+8Yx+AiSi8IKvdN0z+YOICZ91CLs=;
 b=LnNVkeJmHXrE72X0SlB5RcJ/UAuRApi42l8psCuDdSyZe5Mlocn0r984t2FnaZF+E6fRIP
 yiqpZKR1U8mWVBebnPVYwfUIK/D44uwf3rrf9R60si99H71AvQl3MOqtw5p1B3dOlDu5wW
 s72rGxtd9zrWg3DPBBbyTKJjH+ecqbs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-W19tP3qXNymWX1DJdULgDA-1; Mon, 18 Aug 2025 03:08:37 -0400
X-MC-Unique: W19tP3qXNymWX1DJdULgDA-1
X-Mimecast-MFC-AGG-ID: W19tP3qXNymWX1DJdULgDA_1755500917
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70a927f570eso89296526d6.1
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 00:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755500917; x=1756105717;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ReDQaIm8uDJju81+8Yx+AiSi8IKvdN0z+YOICZ91CLs=;
 b=EOkp0A8HxEqfQeIZolJTNw1riODXEEohMJr76/q/26GvMU1hSZhtmEJlJdYok8j0go
 qAZxCA4D0W+UcnmDdCS1jdtwkt1CFGH7TJW3ggAM32Lq8ryNkp5OlqU22mPoY1hikSwo
 7FzxJ5zOIIzMliZFV9/peWF9EIlYwEVE90RvvZsxSv8qYmLy6yfhDHfuaJNPeTgnaDs7
 6VLylJAuZ6+0DCVSxoy49vpd4f8kuCxoWmzsPbYgicJjkwLflTV8HM3WuxLagfdtnHrH
 I3DA64ZJfHxbUyvdYeRQm1N2GrVVVfODsGEwduAVMkFaV2oruVljIgo2ISzvfDJ5BmSZ
 Nf+Q==
X-Gm-Message-State: AOJu0YwI8eSTzCJH9Yt2RtYyQRvqXcGcxfKXaXicICXZvzdJab7P201s
 rLFHNo2GZeGEdMuBw6b4bTOunHyhckVp0bICi51HIPpw+CHQ2GGzLyOP3NS1Tr/F7D+6z8VpOgF
 SkPggQqLWt9N3tpFd0B3cvnNkOzetTqkuY1CPkOZsT2yCC+4NKUflnbrXsaEGLsfS
X-Gm-Gg: ASbGnctP8Vw1wVbHRlBNtJIsm8jkcMU8sEQWDoDLbu53cWOj1/SOJRL92QD37fan2Ia
 aZTforjobvzpJaoD+v8wXn+D0ry3HG0plRNyFUJELtXWhEDZdY89PYuHA38dyX7X6sDqZnK/9U3
 ygs19XDVhuIChOGkSsQHiJYhG9SDitO3HAr64A9a6NFpjOUyDv9b+pjLIfe6iYxuKRslevNA6az
 ti4jiAHSiELKrQahN2+tBmcT5duDEUz2H4qMEkpOEODNp6Qp32Fg0EhV6ns4KQAo07FM8s/a1VA
 Yc1ClSZQdZpUd+6TM5qbBQ0z/NPP5Oevfn5Fma+eRRYEkyate2pIM/QLF8dr9TzbBsOPrFohHVg
 P7b0=
X-Received: by 2002:ad4:5c6f:0:b0:709:96c8:1c28 with SMTP id
 6a1803df08f44-70ba7c5086dmr130597626d6.41.1755500917073; 
 Mon, 18 Aug 2025 00:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXn5lccZLU5kIWavjV/wQcAR87kmKcKp0IJgI0cv/NvoEpVYSehw18C09ERUKnuXYEHSU3FQ==
X-Received: by 2002:ad4:5c6f:0:b0:709:96c8:1c28 with SMTP id
 6a1803df08f44-70ba7c5086dmr130597386d6.41.1755500916558; 
 Mon, 18 Aug 2025 00:08:36 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-055.pools.arcor-ip.net.
 [47.64.113.55]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba90b8dc7sm48486296d6.30.2025.08.18.00.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 00:08:36 -0700 (PDT)
Message-ID: <238d094b-105e-4efd-8209-ce35697a2ebb@redhat.com>
Date: Mon, 18 Aug 2025 09:08:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] CI: Use mingw-w64-x86_64-curl-winssl instead of
 mingw-w64-x86_64-curl for Windows build
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <c4bcc116-bd15-4c86-9e7b-3bf33b31e792@weilnetz.de>
 <e2efea97-9cdb-4dac-bf9b-324e77a2817f@redhat.com>
 <cc8db062-a467-4b56-9ca7-c2da9890ec74@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <cc8db062-a467-4b56-9ca7-c2da9890ec74@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 18/08/2025 09.02, Stefan Weil wrote:
> Am 18.08.25 um 07:49 schrieb Thomas Huth:
>> I'll queue your patch for my next pull request ... just wondering: Did you 
>> run into any real issue here? AFAIK we're not running any related test on 
>> Windows in the CI, so there should not be any big difference?
> 
> Hi,
> 
> HTTPS connections don't work unless the server certificate can be validated. 
> Binaries with mingw-w64-x86_64-curl won't find the common CA certificates, 
> so server certificates cannot be validated and HTTPS connections fail. 
> With mingw-w64-x86_64-curl-winssl, the installed CA certificates from 
> Windows are used and HTTPS works fine.
> 
> The difference is therefore for any protocol which uses SSL.

Sure, but I was just wondering whether you observed a failure in a CI job. 
AFAIK we don't run any QEMU binary in that CI job, so the CI job itself 
should not hit the problem. And we don't publish the binaries as artifacts 
of the job either, so there's also no user that could run into this problem 
with the generated binaries there.

But anyway, it's better to fix it, in case someone uses the list in the yml 
file for their local installation to build QEMU, or in case we ever decide 
to publish the binaries from the CI job for consumption by the users.

  Thomas


