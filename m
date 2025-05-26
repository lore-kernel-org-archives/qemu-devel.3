Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CFDC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJU9g-0006oS-EV; Mon, 26 May 2025 05:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU9f-0006oJ-9M
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:29:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU9d-0004Dr-Gk
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:29:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so28536125e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748251795; x=1748856595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BIE1tsHAC5bOg2rTrmfJi9vPEFVbj/k5P/3qkGkou7k=;
 b=Y5K6V7bviBorKO1wFwEJ7yYw51EhCkJfjl4ehxj/T3C3MixewwtRbTwywniMMtVaxs
 tlZPSG5jENui2wSC5AaeR/2DwPigveJvzmmw+ewzR99ADhqXz1j3FQ586AKUCCnt+ZoD
 5BMfPhel96zAMApYKWvmXaG2rz6gtenohkrrZ52hN86g/TYDj7GshuMLAcSoPax5JCaI
 j1xCNtNOSw4Wd6EuMTVJXPYYli/w75U6etPZfC4ZCLdI2qpYhgJCiTPWvhF5zWLR2F+q
 3MWnJSAJZS/YGtcDHNLyAmu7uHhSX8S9jMjMLQULeEbuCFvTdU66R7voxGpW6DEX1ZJ4
 QdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251795; x=1748856595;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BIE1tsHAC5bOg2rTrmfJi9vPEFVbj/k5P/3qkGkou7k=;
 b=qYj9ZbAK5k2uQdjp2Rrnx0XXT9UgDQY/b568WqTLC/kr1ZZXLNh4fgXuGsvWyHcOtI
 gi8sA0sbk4kOLdYE21XNIxSpqL+lI9kxOMvPSovaVy4ruR2gwhAqlsBLnlmxqZyEzkfT
 iHpTWe1wqjke2riIav6vkjXRgcqx5V2ZCmXt/jWNWojfj6qSem4lPoV5FS2W5muqCmz4
 4FTSuemZ2jPjVmkjYoWzv7Bo2fzNc3Zd3eLbC+ILHGU70ClD4gO8WMxWbnCUmxjCoxtc
 h1oeDfL+BJaMOHlX6CqTmAuiUKYZEKJbZ6dw7fQcPl9TRxkrgFq/dLZ1GqDHkVFkGeli
 uoTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQKQdsdszAdWFfozk2TcNwwgIHkXQe0sN3vLr3oX7UJz1p/jCpY4dKYNT60DMjdDQ2xz1pyeN6bI3m@nongnu.org
X-Gm-Message-State: AOJu0YwQ/inORhvfMzChuqh1KJsbHAXXByqUbJgbVevOV4QEoYu9kGWX
 fHApIgJOf7HRQcu1TCcCXc2CuBj7YXLqgQDFpl051LvyyxyFUBYGb5zKz/mEQ3Hqy9Q=
X-Gm-Gg: ASbGncuhMyVMVCzfkLVoHA3q5+gNaayy6OY9vKyDasDT46/0GIt8UWiY6j5OjUJ6YcZ
 w3zvh0abZ2hwUhZDwfB1hK9WkLrny6ABd9etQzJ1wJq8vVl4fQdH8EdVwCVY6SWmoLNr7tKLmCM
 IlKBephFkuafa+Q2juEzABqJig6QsVlKzIVylAjCKlNbjc62r8j/gxaZ4rpulYVb7XLqdIK37cY
 L4kb5qMNtPOl/hp/cGOTWObt6WX+wlOPIJ4Vm3g0jwbJ9T3asEZEFBdYB2WFktI7MvjtVzZ9MkE
 5XlDLdWGfr20lwFHWDJNYiVvm2f9QshhnRXcJbbV9YFOiVes8Mv+JBzluhhwziKcty/gHmH5RIB
 T23xLC362oQbflL7fwgZibMq2
X-Google-Smtp-Source: AGHT+IH8JxhBc/HUx9zeS11/dffWL5pnFY4oBQzZmgB3Q147l03pZsLFvqthO2aHH+fNWV9L9ETVeg==
X-Received: by 2002:a05:600c:4f42:b0:442:dc6f:4a07 with SMTP id
 5b1f17b1804b1-44c917f3f5fmr77244055e9.4.1748251794442; 
 Mon, 26 May 2025 02:29:54 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d1ed8740sm4855426f8f.83.2025.05.26.02.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:29:54 -0700 (PDT)
Message-ID: <eb4b90f7-eeff-4491-8b9b-3545aa87ff00@linaro.org>
Date: Mon, 26 May 2025 11:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] hw/display/apple-gfx: Replace QemuSemaphore with
 QemuEvent
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <20250526-event-v4-11-5b784cc8e1de@daynix.com>
 <8905dbb0-a6b0-42e3-98e6-095ac2b9e8d7@linaro.org>
Content-Language: en-US
In-Reply-To: <8905dbb0-a6b0-42e3-98e6-095ac2b9e8d7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 26/5/25 11:27, Philippe Mathieu-Daudé wrote:
> On 26/5/25 07:29, Akihiko Odaki wrote:
>> sem in AppleGFXReadMemoryJob is an one-shot event so it can be converted
>> into QemuEvent, which is more specialized for such a use case.

BTW it would be nice to document that in "qemu/thread.h" API.

>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/display/apple-gfx.m | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


