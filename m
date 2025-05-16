Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52C3C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFj37-0001EV-Az; Thu, 15 May 2025 20:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFj33-0001B9-D8
 for qemu-devel@nongnu.org; Thu, 15 May 2025 20:35:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFj31-0005SS-Ir
 for qemu-devel@nongnu.org; Thu, 15 May 2025 20:35:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e16234307so17048315ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 17:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747355733; x=1747960533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fGTa+sH3laGk0Za0QUOvjq9LJudy3MFL+U4FIPDyb60=;
 b=p6DIIfUcE+bkErgsBGhlRWJNLlk5nNmeJJZVcDJ9xd9kYoRCD3AJrSN+tiacKKt8QJ
 dTnJQrS/u1jMFCPKhTFxHerxoutFRnutfgOn0z2nGg5e/hGbqArfpvkpgzyLNHrq7cHB
 8C3eaxRfqfhk2SbWGsSWCqjdzdxpCQVY8QoKzAYs1qt6ioZmtHmyzYJhN2yBWX+oG+T1
 N3RkxTc1zauTfcZq1PUw+mZSJIKQ5OBBVYrxppzVC10XUxbAPTL+KpFtT/mWek1vyMpk
 TaGEIohN287cLT22sX9ceSYgYZyD7rRJvUkfA/eBqMJdLykffu9xzrfKG2W/swRZcZwz
 we+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747355733; x=1747960533;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fGTa+sH3laGk0Za0QUOvjq9LJudy3MFL+U4FIPDyb60=;
 b=pfPy5siSe18MpZp6/n/54ghQnyF+h9A3l8oziQ0hmwws0iIj9o8mNfd8zZavc2Tuj7
 NstmcNJbtmUBqY4/3J7ufCAZ8DTESmv2GaBEL1Gw+Us4EL7JyledH1sAJLijVPhQsp76
 AUX+edPkbUqNnvalgvFg1OTTANIlhZSYf+EDdlfI+LxN4DXY8F8MTLJHF3K37FtZyLXe
 SstsYS+8BBugIsuxYcSbxkhaV4AEgGvx/bh9os8uqyEo+ZSKo9yjgsoKDQYhKV0iXNZp
 6XHPjlNgQiabYaoJVfgyKOWF9TmkQQMYt2e/TR/D4eQkoukWqiT6z9wL2mAaQDFKUnG5
 VKGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhn132sdyV9i2FlZI9RFvlJdch2TetBVRr6TSmh3dQWjCqtcUmfPxh2FCwZs2hQJhRDNplSwNvaVTH@nongnu.org
X-Gm-Message-State: AOJu0YyKIch1/tkMyGKqprgUWSitepA82Ojfv9pK7JjpZgwbf8eojnAr
 gvPWZ2MEbUZKUNIwUYgGS/Ue3riMaW6/jAzMoJfc8DdX85bK1Jf3sLoyTiKT6Qu62b8=
X-Gm-Gg: ASbGncsgeSwfI1fX4BXSYHPh8Dc5K12LY36rQVKnoyaRUF6qwkaRhoXI6NLmPHcE1vL
 BQ0XOLC4HfZdxkmLjk83N2CobZPNWPi00Dmlgd/WTgAzXHxU/+PhIyMCyFGzwIZ+E476vwpgbtJ
 tQJN6zOLCXWAuTkWQ9ndx9yYt1xSYBBGc8vE28lkMQX9+t3hkCLjuab1FzE5QwYiZBcn0ZFK1BV
 0p7w6oDN57oBZGZ+wRj6blimD86/Zy5oFOhZxRMheOldUNLTpQQ9NKY9H5DMjrQbKE3JvrXVMbG
 S6tF4xWJWNtcjMdPa/E5miQ3ywykOR09MSGGnLCUawSLwhvLb67AbdoKrzX7PSTC
X-Google-Smtp-Source: AGHT+IFiN8vqp9HJmvqX3nAaZgMB5BmbRGNF1s/4U1xwnyGNbppmqC7romuaJ327ubfHa52+sieZfA==
X-Received: by 2002:a17:903:110f:b0:221:1497:7b08 with SMTP id
 d9443c01a7336-231b39d5c45mr77223205ad.23.1747355733093; 
 Thu, 15 May 2025 17:35:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebb168sm3497405ad.204.2025.05.15.17.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:35:32 -0700 (PDT)
Message-ID: <1a89a793-1db7-4b3e-926f-fbd390d2f714@linaro.org>
Date: Thu, 15 May 2025 17:35:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson.build: Compile hw_common_arch_libs files with
 right header include paths
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Brad Smith <brad@comstyle.com>
References: <20250513115637.184940-1-thuth@redhat.com>
 <d1bf2e99-7320-4a20-a5cb-2e7ce70036b8@linaro.org>
Content-Language: en-US
In-Reply-To: <d1bf2e99-7320-4a20-a5cb-2e7ce70036b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/13/25 4:20 PM, Pierrick Bouvier wrote:
> Hi Thomas,
> 
> On 5/13/25 4:56 AM, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Since commit 6f4e8a92bbd ("hw/arm: make most of the compilation units
>> common"), compilation of some arm machines (like musicpal) fails on
>> certain host systems like OpenBSD 7.6/7.7 since headers like <epoxy/gl.h>
>> don't reside in /usr/include and we currently don't add the right
>> CFLAGS for the common files to include the additional header search
>> paths. Add a loop similar to what we already did in commit 727bb5b477e6
>> to fix it.
>>
>> With this fix applied, we can now also drop the explicit dependency
>> on pixman for the arm musicpal machine.
>>
>> Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> [thuth: Add commit message + changes in hw/arm/meson.build]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>    v2: Change the subject of the patch according to Paolo's suggestion
>>
>>    meson.build        | 27 ++++++++++++++++-----------
>>    hw/arm/meson.build |  2 +-
>>    2 files changed, 17 insertions(+), 12 deletions(-)
> 
> 
> Thanks for the patch.
> I didn't run into any issue when building for {linux, macos, windows,
> freebsd}, so I assumed it was safe to do things this way and specific
> dependencies could just be listed with associated sources.
> It seems like there are cracks in this approach, so adding all the
> dependencies per base arch is a good idea.
> 
> Any chance you could base it on this commit [1] (and add it for new
> libraries as well)?
> 
> This is going to be pulled very shortly (as part of a wider series), and
> the same fix will be needed.
 > [1] 20250512180502.2395029-4-pierrick.bouvier@linaro.org
>

[1] was merged.
I'm working on a series integrating your work, and doing further 
cleanups on meson side, so you can leave it for now.

Thanks,
Pierrick

