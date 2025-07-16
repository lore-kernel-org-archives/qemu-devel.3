Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C8BC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 03:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubsuK-0004Qg-Gc; Tue, 15 Jul 2025 23:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubsuI-0004Nb-2d
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 23:34:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubsuG-0005ej-DB
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 23:34:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4560add6cd2so3738275e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 20:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752636846; x=1753241646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O0uu2R9wSkrSHt+q9Z9YDpvlwtpQ6MzTcEiqh/9ZmUI=;
 b=RYgmoQ2EZSqewqxsTLB8GY+AZzddw7tBZAx3Oh8vMx939pH8kY0gudXovEXLCmIHhH
 1BU8+i0NrlnyIDALGzxm0mBRcMHPjobqpe9nANYHtDlkQlE6F0/QR2kPPlFPpMlIVHaE
 OORM3l+3WIIow/EDxnZeuDgwAoE4iGqeBBlgjh5BjW27AW9uiIVOdEMYkwwcdYoeNKHH
 1e9/lsE9YrqGmA6XhMe3KisufiWVKzZwhxHBig3o6jtHABu608ArV4l9M0po28AZnrGL
 oWdI9Oexlc/Yyc6oiIS+r3oF+hft2t/laQQpHnpTDg5VVMDecSjPO6RZ8b1pINPxv3U+
 Zxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752636846; x=1753241646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O0uu2R9wSkrSHt+q9Z9YDpvlwtpQ6MzTcEiqh/9ZmUI=;
 b=rtwvew89hj2qfh04sCZDXG9FXjxddV+DEn5HcaTxef0fp9WrBX3umapt7q6QDtj+39
 99huAQjAEYzaMRMl7nUWCq8BXcC8ntu7Wo1sJHR6p07KbOQGbjMbwSta32mht4uQvlKH
 OEgZ5CXUO12pM1Gpj3BPOqbTeUsNfPXUaY27M8FVZVZ9fyismXnZ6Ydi0mNDtCX1UB7r
 sLTKaMmz3Ii0Mel2uAgalOSgGdy1AaAbR4HoSq7993zMWNRhxaZbmOixvMUKQq8dVZ0H
 0vDLgxuW5zazGTapFZ5N4b7m0J9pwXLkE3FudV0+BZ5Qqs1s3jDbV6ih2+oGYCGlSGUF
 YKWg==
X-Gm-Message-State: AOJu0Yx4FhQjQsbfgxL6cRAYeoBmDGo9tAXx+rhaGQXMDkbTX5Rx+y2p
 hqp1UjvOcWVuTo1seN5hFkmAoXJXPfnMgsP9K9ma2xNO+Z3rTz5EHCKAPCWxJSqXS/4=
X-Gm-Gg: ASbGncvTAoUG7QMA86cXGsFfKJj9FLbdBMIL3EsWsxlHLYU0RhmMjIuHh2FrHq8znxH
 PKWz8q63jVqnSPOcwF9drZCoAO87/TMOcZu/eSqXrGAPze89oBO//fxsEbVAV7H7PJYk9kcrDk+
 +ODkAWVAWExIzsm7yqBu5vqSmOLy1gvyyFqERqnmb1azYP0/7+nF2DiMd2WlviSCyY7SFyQPZPy
 eTYoh4VD26qQydVj9b1K2dfTpDTUHsQ45zTRpveYX/vOs7aGDkHv2BQFQ/zBVxaG1hkPyZZzi+J
 ZdHYqOFrxgcryZ282SJQVTI7ro4XHk9yJmRpqW6icMiEfihsdeghNBpZ9TLtYSZW2KW81lE2ugq
 3589wlUBx63O6EjqKfKxYWYZA1+aXIvqTDlyTXMvaUwfWxFG5m4y2nupKUFqxyhtgpg==
X-Google-Smtp-Source: AGHT+IGhMk/PUeTNrn64GC9qdpb4Pp3YBrgnd/Vggg7Rz1p82odMxI8Y9nu8cBSjHTvTT+pQwfUb5A==
X-Received: by 2002:a05:600c:190c:b0:456:1281:f8dd with SMTP id
 5b1f17b1804b1-4562dcc2f81mr12490315e9.12.1752636846498; 
 Tue, 15 Jul 2025 20:34:06 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e7f2bb4sm7450015e9.8.2025.07.15.20.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 20:34:05 -0700 (PDT)
Message-ID: <931257f1-4d52-48e6-b98e-69273bda234d@linaro.org>
Date: Wed, 16 Jul 2025 05:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qdev: Remove pointless NULL check in
 qdev_device_add_from_qdict
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250210121045.38908-1-philmd@linaro.org>
 <CAFEAcA9NWRDNEEJpAY8gm+yrHdY-UeaE0i43wu0CJBq+SKKrmQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9NWRDNEEJpAY8gm+yrHdY-UeaE0i43wu0CJBq+SKKrmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 10/7/25 16:48, Peter Maydell wrote:
> On Mon, 10 Feb 2025 at 12:10, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Coverity reported a unnecessary NULL check:
>>
>>    qemu/system/qdev-monitor.c: 720 in qdev_device_add_from_qdict()
>>    683     /* create device */
>>    684     dev = qdev_new(driver);
>>    ...
>>    719     err_del_dev:
>>    >>>     CID 1590192:  Null pointer dereferences  (REVERSE_INULL)
>>    >>>     Null-checking "dev" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
>>    720         if (dev) {
>>    721             object_unparent(OBJECT(dev));
>>    722             object_unref(OBJECT(dev));
>>    723         }
>>    724         return NULL;
>>    725     }
>>
>> Indeed, unlike qdev_try_new() which can return NULL,
>> qdev_new() always returns a heap pointer (or aborts).
>>
>> Remove the unnecessary assignment and check.
>>
>> Fixes: f3a85056569 ("qdev/qbus: add hidden device support")
>> Resolves: Coverity CID 1590192 (Null pointer dereferences)
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Looks like this got reviewed but never picked up by anybody.
> I'll add it to my target-arm.next tree.

Thanks!


