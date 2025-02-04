Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDC9C02198
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 11:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfGoW-0001nz-Nd; Tue, 04 Feb 2025 06:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfGny-0001jD-PN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 06:09:22 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfGnw-0006SM-1n
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 06:09:22 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so2754007f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 03:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738667357; x=1739272157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qRJ+gO3RlqlkJ3uQqro/ScxrHGJgZZMun8MHfO4LoDo=;
 b=MJ006GKLhXfuvL8vON5jSEmaCTIa6Upgi01uQw3dNsP+iKlmQJVz8uz/z2cjZUu62D
 a4alCvsLpirfXpeoX/t3QBO/KBvhPOkmhpda7lXhy2TPrPUxJF/RVP5sltgBm8UzNYeJ
 BaGyBuUcUpzkxouY/zt/XPcAj8z0Bw1bBNMrKC7JPD3vBwyW/3UvVwuQDgP8sKkqU8oT
 fexvrtQfTiCuc57LwjtLn46Wj7rqeGKwdLlxhKeVecPadxQTk7mbA9tnzX8cLNLcfdDH
 KTZx638mXfDhA9mQW3ytDf3oJKrIreLbVMQE2S2jQBEzUQyO+4PbvsMdbhH99I9spFBl
 Gkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738667357; x=1739272157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qRJ+gO3RlqlkJ3uQqro/ScxrHGJgZZMun8MHfO4LoDo=;
 b=P9NS4CHYVGIrmL9ljKWvZSlMMCsg4j0Vsx/oA7iObfPcDvE0fMkke47x1+yachZljb
 ivKDkkwMYvaRoxryEH1vlNNPodj6s629c76Yjg3LejL6rKAwaqyZaKi8JNwzns3hadvN
 L4rdM03ixAPZCTbN7sp2u3ta4yw/G4xArotOVzb4431+OZgoiwPANvZ+CbhqN5i6QW6j
 7qmZMmKJapOtZA0VHu5AaK3OeuGBvw1HkQvC5Eu64Dbbq7FHisNtQBz4pWg+2kqZl3SX
 rLBGa2E0CS4o02RZejoKDmUSt7j97gwXN4oqaJeL6aUw/Y78Vu+K/YWZE75iA42ZIhaz
 w5gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNpVCL7yQCeIQ71JTt5UzIaRlySlILx//i7ELG9VHeHJJgKhiqqsJzow8y1Tx81hJVw1EvlLbKfzBz@nongnu.org
X-Gm-Message-State: AOJu0Yx3ah9WbxmCsm6l99jVfjiadA1C+Nn2N7CIUyD+HUn68qgKAW5M
 nDtk+01dJTx1pgBo7MwZi6uuM3CrW/yf/RN79Fn+5NAJF1h1qESueY14qDHstv8=
X-Gm-Gg: ASbGncv5pVwGPNpEg9i1fygAYF3m70Gy9l3nBJsQ8g7ZRWoJGQJPOJegCp/U9kDAXQS
 +GmAlBXd/7B9DNR4cNMr7XsHOiShxuakY3kpJcQmZx6SnZY4jzzRDcLsXbvMYMwgjFVrtJMeQic
 HcQzp1fSDJ4+4eC6C6wXQNnB3MuXPt42jxE9cZRhe+6O2JLOVGaihjYyVsrMR1tYqtacx8DmZ8E
 ee1kaERyyofgL6fPVdIHStQBgFTKXxTeY86yOCW9aJ/GdDkGqk0Jy01Hmvc2SYmrRFXAnlAnbB4
 TI1z0hpI1wOEed/pCXv2GauNk8wYT3dLf7kTPEA5dQfRcPm4tKeUPcrBiGI=
X-Google-Smtp-Source: AGHT+IHlPCY8e+YgV9uSzljvoYX/GOzO/+O+pWDgFI6mI0bjO/ZMiP7LbVZnquDQq3En+TzjQSxjTg==
X-Received: by 2002:a05:6000:1866:b0:38d:a876:845a with SMTP id
 ffacd0b85a97d-38da87684cdmr1356668f8f.47.1738667357262; 
 Tue, 04 Feb 2025 03:09:17 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf53asm15159268f8f.87.2025.02.04.03.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 03:09:16 -0800 (PST)
Message-ID: <04b4c0f6-aa4c-4c95-b93e-7a16d58b5567@linaro.org>
Date: Tue, 4 Feb 2025 12:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/3] hw/boards: Rename no_sdcard ->
 create_default_sdcard_drive
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org
References: <20241125181420.24424-1-philmd@linaro.org>
 <20241125181420.24424-4-philmd@linaro.org>
 <47db9d33-8fa4-4ebf-90c9-db6e252cc38e@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <47db9d33-8fa4-4ebf-90c9-db6e252cc38e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/2/25 08:07, Thomas Huth wrote:
> On 25/11/2024 19.14, Philippe Mathieu-Daudé wrote:
>> Invert the 'no_sdcard' logic, renaming it as the more
>> explicit "create_default_sdcard_drive". Machines are
>> supposed to create a SD Card drive when this flag is
>> set. In many cases it doesn't make much sense (as
>> boards don't expose SD Card host controller),
> 
> This indeed shows the insanity of the previous state, thanks for 
> tackling it!
> 
>> but this
>> is patch only aims to expose that nonsense; so no
>> logical change intended (mechanical patch using gsed).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
> ...
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 86fcf9c81f..5cec73ae68 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -285,7 +285,7 @@ struct MachineClass {
>>           no_cdrom:1,
>>           pci_allow_0_address:1,
>>           legacy_fw_cfg_order:1;
>> -    OnOffAuto no_sdcard;
>> +    bool create_default_sdcard_drive;
> 
> Can we maybe still bikeshed about the naming here? The current name is a 
> little bit long, and maybe we could "standardize" the prefix of the 
> flags here a little bit. We already have one switch starting with 
> "has_..." and some others starting with "auto_enable_...", so I'd maybe 
> suggest one of those instead:
> 
>    has_default_sdcard
>    auto_enable_sdcard

I added "drive" within the name, because this option isn't only
about automatically creating a SD Card device, but also attach
a block drive to it, and 'create_default_sdcard_drive' was shorter
than 'implictly_create_sdcard_if_drive_provided'.

I'll repost using 'auto_create_sdcard' as compromise, also shorter
than 'auto_create_sdcard_for_drive'.

Thanks for the review,

Phil.

