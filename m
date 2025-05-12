Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C052AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETuF-0006bY-4y; Mon, 12 May 2025 10:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uETuD-0006ay-9j
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:13:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uETuB-0005CN-2L
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:13:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so47237215e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747059197; x=1747663997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BlKtln6YL8TAnbPPJhP85Er80ca3JBTlWVq9fmjfKbQ=;
 b=X02qNzzqUnrGagZ8coG4d6I/PAaavCzuXzB2eVWqmOIyumX7qzEH6jBk25uiIDsEyg
 MaMp6aE1JXF+w7j8MWgsJYOqGjCDCnrtCJAqqP8k+yjPuX8B6fCMgX2oAwtUn1UBCkq6
 HxuGQlP+xGGBEj8XwIxmuTYuwWyb0+qTdHMXF16un1No+LFy9GOaHUeDDH76biJx6R3+
 543aUyzyU3jHDREa9N8nK2Y8CFsg2gJFN7s/2/O2TqyobSMtHWP7o9pRX2S+qlaatNLW
 LaNewkzbyTIGyHo9VETly9gdoaWOBeFIkGJ7JWS7jKS6bSxFLl+d8B08R3wR5gtynpxY
 nN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747059197; x=1747663997;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BlKtln6YL8TAnbPPJhP85Er80ca3JBTlWVq9fmjfKbQ=;
 b=c0xMrVP4wSPz6ENHof5zpPlsh1yaS2vMgJiv0UxBcVkJqr7ycnBFaTbG0vJc2FwAfr
 xB7/BChlpaKj3oWHyUDSu6wwQ1bYyfcRUvGqAUTOFzT+uGxFcGk2B5AJc7zBZ2t6hDw1
 pc+9ElcAbr5ShFDpprsghUB2V955et4LkO26zZQgYunEsHfaflnGa1xpYtd8jvhfY5wa
 XX61xKvm4/K9J9qnUKtcYUO8W7nhK+xAJOswAOIgQo80ANCOA68hF5/Ws9YfWG4lJZ5g
 OGSr+y3HBDltKQRdbwTDinSyQ49jYqdAI5dQ//CvsTVkaKMYuzD9ouVHYjFE6n7EiG+g
 yT3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK8HoXHLL7QeOcfSR6TznUHYLWhq/kNJICCAw3i56EBU1ZWMVpJ3IUP/9xMMQW+tGZOE+lsvkdhk87@nongnu.org
X-Gm-Message-State: AOJu0Yx+eWIKECSFplP6o7ZzONdTgciJUPFGZ9bUbd8JkOyT3N2YybwF
 P/d3pn4aZHv2sdrGAklRNxySBFKFTd+db3OEEecSH3NOZLl+YsEyEAhrCT2StVI=
X-Gm-Gg: ASbGncvmZjxEO00NGAtG29srD+Ld4K0QPKCmyEFaoFIB7ALG6vF1eH3qEb/TGflaQi2
 FGRKWUpB6+fOXNKlt/U4trN4GQZLQ7G0TMfMusmxxrZGir0fuTcZSOPdVoJXqQgtQ1jMC0m5g+g
 LdHmZ17oLUbOYkwabl4zBp1Akr9auS/NIyx6WpZ+y1JanS80IqYJZ2rwfCtzfg5gg7EIhtxnCuh
 BT3QO7z5lBjnh7TGdyEft7v0KAZr8w4FqRK2ypKD9TH/joWncJ9Orh+JH4pIcLKZPnWSLdPUmg3
 8p5ovKMdeE+USAUpHIrYa+dBvuhZ4TV/0d/JagQN5QNjRZVYl+LH9Zt4JuoYH2QUHwnzago36vo
 /WyFng/Kbgd5pgZqjJ9Bk2moqA+Xx
X-Google-Smtp-Source: AGHT+IHk2HYN9h9QXFtZSK4+p61t5LSVAsp8l50WHK7VhhgyexOLSrzM5JTqKW2kAFEGGjWhOw1HdQ==
X-Received: by 2002:a05:600c:8707:b0:442:ccfa:fa with SMTP id
 5b1f17b1804b1-442d6dde8fcmr105865105e9.27.1747059197054; 
 Mon, 12 May 2025 07:13:17 -0700 (PDT)
Received: from [172.19.170.213] (90.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c5b9sm12689007f8f.91.2025.05.12.07.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 07:13:16 -0700 (PDT)
Message-ID: <1cd816d0-5808-4caf-b38b-9e4ba10680b6@linaro.org>
Date: Mon, 12 May 2025 16:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Fix leak in machine_set_loadparm
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250509174938.25935-1-farosas@suse.de>
 <7a850346-8ae5-4dd2-b4ce-7ffb1cfeabd1@linaro.org>
Content-Language: en-US
In-Reply-To: <7a850346-8ae5-4dd2-b4ce-7ffb1cfeabd1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/5/25 16:07, Philippe Mathieu-Daudé wrote:
> On 9/5/25 19:49, Fabiano Rosas wrote:
>> ASAN spotted a leaking string in machine_set_loadparm():

What about ccw_device_set_loadparm() in hw/s390x/ccw-device.c?

>>
>> Direct leak of 9 byte(s) in 1 object(s) allocated from:
>>      #0 0x560ffb5bb379 in malloc ../projects/compiler-rt/lib/asan/ 
>> asan_malloc_linux.cpp:69:3
>>      #1 0x7f1aca926518 in g_malloc ../glib/gmem.c:106
>>      #2 0x7f1aca94113e in g_strdup ../glib/gstrfuncs.c:364
>>      #3 0x560ffc8afbf9 in qobject_input_type_str ../qapi/qobject- 
>> input-visitor.c:542:12
>>      #4 0x560ffc8a80ff in visit_type_str ../qapi/qapi-visit-core.c:349:10
>>      #5 0x560ffbe6053a in machine_set_loadparm ../hw/s390x/s390- 
>> virtio-ccw.c:802:10
>>      #6 0x560ffc0c5e52 in object_property_set ../qom/object.c:1450:5
>>      #7 0x560ffc0d4175 in object_property_set_qobject ../qom/qom- 
>> qobject.c:28:10
>>      #8 0x560ffc0c6004 in object_property_set_str ../qom/object.c:1458:15
>>      #9 0x560ffbe2ae60 in update_machine_ipl_properties ../hw/s390x/ 
>> ipl.c:569:9
>>      #10 0x560ffbe2aa65 in s390_ipl_update_diag308 ../hw/s390x/ 
>> ipl.c:594:5
>>      #11 0x560ffbdee132 in handle_diag_308 ../target/s390x/diag.c:147:9
>>      #12 0x560ffbebb956 in helper_diag ../target/s390x/tcg/ 
>> misc_helper.c:137:9
>>      #13 0x7f1a3c51c730  (/memfd:tcg-jit (deleted)+0x39730)
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   hw/s390x/s390-virtio-ccw.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


