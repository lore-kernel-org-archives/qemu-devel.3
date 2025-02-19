Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F48C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 07:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tke5w-0006zs-VG; Wed, 19 Feb 2025 02:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tke5n-0006zD-Dj
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:02:01 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tke5k-0002vU-SR
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:01:58 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-221057b6ac4so66082765ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739948515; x=1740553315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JzHJszk2+xbU0C0JuY567d7xVowlu4qN92xhcGFKBbM=;
 b=jjSGvLwyrlBxHdLo+JLwNNZuzDQWmKb95e2biR+22SrK1jCckMD2CZQtCXHQo2WHwp
 HoY6sjdhOL92vMdDpK1catEEz2iO80Dw2esXTSs1Id5C/ZZMYmtjkW7BTDWdRQRiJOAq
 1Q08c6V/yldffTyAtEKSTIrfu9m/lnbFW8DP6gqookksKpqWfIPNj97QhYCieTj5KB/Q
 ilW1LnA33UDlo3UlkpFLWPnO0dgRCTWALdOxp5lzFvsbLbkYzZFcsxAyqKIebMQ/yVjd
 VevYcLHwiQIB4Ku0Gj0ofRLYDbl7bV/uHGiQcaBa0sNo4adFfswJZafTuLERG/LlOgPi
 AcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739948515; x=1740553315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JzHJszk2+xbU0C0JuY567d7xVowlu4qN92xhcGFKBbM=;
 b=RV+mpFU+JBiqlUOTMqiRSmBa64QjVZqqq61FPY91VZqJq1AO10MNEbB23LutN8BRl8
 0pY/VPoWlo4f3sEVVpWS8rkq72WKrArOb3oFX7C/hqWbpqGK/ax9W6SUkDlYi/lXCiEY
 yzBa84QPLn/L633PAW23SIRGT8Ptb5/FpoS4nV0BpzD0eSVqZdXGwi9WPt3GPQ5b0Isl
 8+2/dW4WTe4JraZRfXXaCFrgtLM6Y51SyLfcAhcmlZHwVlmx/+JX27ubNh6FJP7cE1hV
 cjdlFV0oaeVRTmZY7y1UeTwt1tyzF6LBBFOatvRgPsqt8NbvpykbBWjCzoCImSwOm1SJ
 Wa8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcR2EVYrhhMeyt81z/mkXt0lUs8iR1GFvTq5EeJ1gF30nfZxYGVN++3xThA2ODNZQd7GkIn0rm7zUx@nongnu.org
X-Gm-Message-State: AOJu0YzqRA17W4rzDPrc7N+qSOqgOrh09ngxpext7cKnwwJzUCQ0B31R
 Ksc/FvtCvniXnSfSarqFkkNReBSZ25wWU8V3FIn4+IIAH4TVfGevbO9PsJgfz3Y=
X-Gm-Gg: ASbGncsY+qqAHCXTJ9F5qtEeVGJURHl8QUhJKn5GaO4LGsElJfvU+b1vx7qf9CVS2Fv
 6uDPCyN7k8leljkSvQ0BZTg/YgKTWO96AkhzHYs21c4k7aNOx0avEVHmceEvrUIQ8vRPMr93WKR
 nj3yJ2iX4FRDeuqvUJm6sJPb8zxwZib0Rrgs+SDI6ZrYNpdFGAk3TgWSZSG7fifgupvlr9U/VxY
 h7/ZY+3p//0suDEafvm3fy4vEyEaQPV07HMJhNkvhf9baBfp7nJJdt2gxqo6fClLDgLAyBZGFEg
 BIZQ/vjsewwO+CTF8V3gW2R3KjVw
X-Google-Smtp-Source: AGHT+IGUgR2brSnlcGlJsMS/bXjXvVj/Ondxs/AVBPTgOe7066P8nO4hvdmmfOspovsbt7piGFPMGQ==
X-Received: by 2002:a05:6a20:2589:b0:1ee:d384:7553 with SMTP id
 adf61e73a8af0-1eed3847728mr4903273637.30.1739948515125; 
 Tue, 18 Feb 2025 23:01:55 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73275ee19b7sm6009821b3a.105.2025.02.18.23.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 23:01:54 -0800 (PST)
Message-ID: <290b3ab2-70a2-4846-a53e-ec18f848d1c9@linaro.org>
Date: Tue, 18 Feb 2025 23:01:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
To: Stefan Weil <sw@weilnetz.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
 <4e788add-ee40-4d98-b065-6745e6e2fce5@oss.qualcomm.com>
 <71254e1d-3e17-4082-968f-db7fe6cea590@linaro.org>
 <4e36d996-7446-4bca-8699-063c3c6d91fc@weilnetz.de>
 <845d324d-833a-4d48-a78e-d384002b17af@linaro.org>
 <dc259719-c030-4c71-bf31-c505ca66bb48@weilnetz.de>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <dc259719-c030-4c71-bf31-c505ca66bb48@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/18/25 22:39, Stefan Weil wrote:
> Am 19.02.25 um 00:17 schrieb Pierrick Bouvier:
> 
>> On 2/18/25 12:59, Stefan Weil wrote:
>>>
>>> I could run a QEMU cross compile on Debian with the llvm toolchain and
>>> msys2 clangarm64 packages installed with pacman. The resulting installer
>>> is here:
>>>
>>
>> Have you installed the msys2 clangarm64 packages on a windows machine
>> first, and then copy them to your Debian machine?
> 
> 
> No, the packages were directly installed on Linux like in this older
> script which shows how this can be done for i686 and x86-64::
> 
> https://github.com/stweil/qemu/blob/master/.github/workflows/pacman.sh
> 
> Newer Debian distributions already provide a package for pacman which
> simply needs the right configuration. For older distributions I had to
> build pacman first.
> 
> I should also have noted that I used a Linux aarch64 build host, so its
> binutils were able to find the DLL dependencies. This requirement will
> be fixed with a pure Python script for the same purpose.
> 

Oh excellent! I wondered if it was possible or not to do this (didn't 
know if some post install hooks try to execute native code).
Thanks for the link.

> 
>>
>>> https://qemu.weilnetz.de/aarch64/
>>>
>>> The only tool which was missing and which I had to build before running
>>> the QEMU build is aarch64-w64-mingw32-windmc.
>>>
>>> It looks like the NSIS installer is i386 code, so I don't know whether
>>> it can be used on Windows for aarch64.
>>>
>>> I also have no suitable Windows host for testing the binaries, so no
>>> test was done.


