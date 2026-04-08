Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E23310F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKe-0004e9-Ol; Wed, 08 Apr 2026 15:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wAYIz-0007NV-H4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wAMdm-0004E0-Ds
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 02:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775630631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vKjwfiMRN1DttXS7V3vFLbpkUzgDlirK3LxuKqQjze0=;
 b=cY97RhscEHNZ88vjwcSmWOpNBRvRRVlxojfe0+7G+9ybWuyc60xwp4jnWLb7nJQB+Qk1Rz
 YM808tAXYWQTuunGncjBV3Tz7BglyiNf5RTYwKrbFkzWdBJYGfVHHl5x7cuzEztlrxyW8W
 xnnnxZPqDf7VEIl74LvKR78dWf92v8Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-aXBDsEUBOUmPuNLAXN3QAA-1; Wed, 08 Apr 2026 02:43:49 -0400
X-MC-Unique: aXBDsEUBOUmPuNLAXN3QAA-1
X-Mimecast-MFC-AGG-ID: aXBDsEUBOUmPuNLAXN3QAA_1775630628
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d1bfbd219so4589321f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 23:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775630628; x=1776235428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vKjwfiMRN1DttXS7V3vFLbpkUzgDlirK3LxuKqQjze0=;
 b=aB8m3fzH5An6SiOnDQiRdBWodXbgN7I9ynAHVU1wwPgCVW9PwAspRb30jOiK9Gcv9K
 rUchr6GtQKBPISifTJeESMInKd875+zXR3f/N4sCqjd5Y1DhFQ+Z0lD5yT8uXEaHPE51
 ypAbKgAeZQjdvYl4DHJ0gH7CrOZguqsDhOS3dgUPQNDXRKnxwHogLkEDzWYdczD8nGwF
 r3OUFt9wtsVx+CXEMY0oVOtZIa3LyEuR0v9vZznGIPEVn2cgVJuQL5eYmd8ag9JB4fFU
 np2i4D4y3EQucXx7vzH5hRKA3zAcdFNNYkar3h5lqXb+9q58PIFz56JU4C/qF0IOwmkO
 PkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775630628; x=1776235428;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKjwfiMRN1DttXS7V3vFLbpkUzgDlirK3LxuKqQjze0=;
 b=ZPOX+Fepse15dgbcst8QjxAH2eYYzlUipBjTXz+XUBId5ySt8I92wbR2MykEts+xtT
 LaG8xHhboNn7QRFwIww/VRddHIFqHeqQwhOCO4ZWayzWNJSH1x2jsU9orl8w5P9kN+KG
 9CSLx4QFKcCT/9jcoZdpP4qmd9OQwNvdHYDDLduJnGYYbO+IfLSeo4bh/appxndSR4PK
 6BM2YGBmJl8923aAzhO0+XSNSLL1fuv4Df/LpoDVB5JjAUg9rtSJtWfaVwbuvhGGwPda
 MdACU0PE8NWopxe3grVIedXC/K10vDkhHLiOoclkXUULtokV0fD8AR0XG93shZLAQI6r
 abYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX4nbW/Ph56pVPhUFNSIIw/TRsusmm4wvR1jk1V4AAnQD5ssBc3AEAhK/KLe48CYN8iU/4JmZGh3es@nongnu.org
X-Gm-Message-State: AOJu0YyEFLDRxR8UX61+Eh7zi6nH7BE6zSIO/vOBYUOyWA0ZeaN6SDL6
 M42ynpsucMlrFkHxid55CYDN9p9BVkOubGymTW4bNZ/49r7YdpgLI+qwQCiKG2fTvComYsiFycz
 zkJ+YwLlJkfmtzT922CezTMvSzQz8/qA/yxuwBxMhl6tTCuALm6HKy5IG
X-Gm-Gg: AeBDietlQZgiL1BMsGjBKbT4v7VgJ6fAydpY4zTCkIIUilu9yOiBYtDYUgZiB9Zx6pd
 rAef/kyDhOh5KrPQwuxpMZv9GavK/1CfmiQS8HZQUbz+Z8yj8q5RotUDy5g3rPXBBDJpfC16rz3
 pbEWr1xHaUSankt79VP1WgeXgdIoRFKj/0kL5rveIS2iZFNDpE9GBTy2bFMu+ZmkAhRkMYTWm4X
 Y3mzJWhs2f0sAfRkaaepbr+kmL2OtW3X4752c6WnXa3AYSWRvU5qE8HtZBVDzE6myF6PN02zTrR
 S6MsvoK5N8EqwvS6AdNzfIHC/1VJDfkJ0+FAp3dljJKThn8MO3yNf2hCjmLqchL24R3RKb93S6m
 Fa8VLz/HY2CTIe/4/8A==
X-Received: by 2002:a05:6000:2902:b0:43c:fad6:9ba9 with SMTP id
 ffacd0b85a97d-43d29305f2amr29049662f8f.45.1775630628305; 
 Tue, 07 Apr 2026 23:43:48 -0700 (PDT)
X-Received: by 2002:a05:6000:2902:b0:43c:fad6:9ba9 with SMTP id
 ffacd0b85a97d-43d29305f2amr29049642f8f.45.1775630627877; 
 Tue, 07 Apr 2026 23:43:47 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f7d4esm48950795f8f.34.2026.04.07.23.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 23:43:47 -0700 (PDT)
Message-ID: <944cccdf-68f1-4565-9647-59cae7fb3fb8@redhat.com>
Date: Wed, 8 Apr 2026 08:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtQQVRDSF0gYXVkaW8vcGlwZXdpcmU6IEZp?=
 =?UTF-8?Q?x_stack_overflow_by_moving_buffer_to_heap?=
To: =?UTF-8?B?5Za75Yab?= <yujun@kylinos.cn>,
 "marcandre.lureau" <marcandre.lureau@redhat.com>,
 odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: "mark.caveayland" <mark.caveayland@nutanix.com>,
 philmd <philmd@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
References: <a1npd7r5807-a1so0q5obt4@nsmail8.2--kylin--1>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a1npd7r5807-a1so0q5obt4@nsmail8.2--kylin--1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 08/04/2026 08.31, 喻军 wrote:
> Hi，Thomas：
> 
> Thank you for reviewing the patch.
> 
> Just using AI to describe it, you know, my English is not very good.

Ok, that's fine!

> I am currently pruning and optimizing qemu with the aim of reducing its 
> memory usage. I happened to discover the large memory allocation of this 
> stack and am trying to propose a new solution.

Could you please still point me to the function where this array is 
allocated on the stack? ... I did not spot it in the code...

  Thanks,
   Thomas


