Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C744C5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 06:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNQhF-0006m9-Qp; Fri, 06 Jun 2025 02:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNQh0-0006if-99
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:36:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNQgy-0008L6-6o
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:36:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d54214adso14962055e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 23:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749191798; x=1749796598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EclWRtcrb0Q+hON4p4OsPSgCqUPpnAb49ByzGYVoxKM=;
 b=fI+Ukaj+cDEFr7WgNtR35DjDcUv1v+vGXleyezekobRnYzGPPDFkl9R+OsUACg4LZv
 wMAtbs3DE84MrSMIWkqdbThw8Qdpr/O76V6pCrjD8XdeVPRXJ1HzewXSPeNLH7xuTU3B
 xAoeebhTA9MGuCTI9RC6cFDK6t4mOqksQPOf4R0hsZz/7R9GH74FxhmVoxpG5OapbQtM
 tiL1+h4jwYgt0QD4/T38RSijbVpR+MGqCdd6EhggtDTTO6F5htvxCCkvNCXc9tvbagps
 eKC0A6zkDuW3ZFjXjl9P39XvRjSroZIbnzZhsi1ElComufrUyVB8EvBf8j07bd0pACE/
 6Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749191798; x=1749796598;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EclWRtcrb0Q+hON4p4OsPSgCqUPpnAb49ByzGYVoxKM=;
 b=oFLPGY175Q+p1i2r4WsJTVyhwX376V6RUH7LM1QsuIgVC4Tf7T2VEMx8eOqP1UXumW
 U1LHUBflzHd4NNs8k0Xd6E9toPyw+5yb0l12JXCK0hC04T72o0/IPQkBIpgie2QV5Dzv
 SCB4kDKEkPMN9Ja0c9okL5v2nnfVgyDPKd7lxeuaKPe44Z6qZ8mVsB3sNSnH2qk0jpCy
 TarUSyzV/QvIK2+D6cCCJVLM3rmCLnCyo3PX1hZHoweQi2QIOYZOCq2ubSv+F0qvtZKf
 XKN/nyKSQwNqzvPucxeJXh6koeYaMvrN2u4F7aBCSI9mJioFnPEa4n3r3FtpixRdNRHM
 nsyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXywz2LXvmXHimjsD/oamPHl6g0Gxj3FbU7Yn4zFf4KbEoofKncaHBuQJdfpv8KmHFSghLtOCju8dRx@nongnu.org
X-Gm-Message-State: AOJu0YzUwAA5S0JaZu5oGKV81cn7ejUUi0B6kw0IZpzIeQd9BCcs2JU7
 nYIx+VFvnvKtSfX5ueBHayg9gPkwyFas8ntKsOr6XupOsAtZDbzAWmBY3zjpmTtQCwM=
X-Gm-Gg: ASbGncsq3SDRVmn+1LNHp/38bCLUUtt3L6H4baGjdM7yOu1NT7pm7UVlhfr2MXre1Sj
 AKsTZxp7lWUNQuQ+zsTIZbSe516RwALVrhNFxO0T48KBj7zXQgkc/YXr3Fd+qZPpfy4KcWJ6Keh
 V23KF4Ocs0a3d53Gl7A5kFmyjH6IZJbSa7ZjBqL5ZH6V8djqSrn16CoyT2pJRoODY//itsFNUe6
 vjBSWrNvJgOD+wGapGuMHwV2wU0ZxCm6BkcooG744fKgjOgzYpg2XqG8rPr3Fmx2RAOLWDVU8Qe
 RUPIzxj8upeCegMlZlPigGBmtCGQtPmw6nCgaJvPBJVElDOK7Mw9Gu/qQKRQATF6e9qFpbJC+Gr
 u0riRc6LRrjYw18rm1zMkgzeaOWnBVw==
X-Google-Smtp-Source: AGHT+IFs0/QF9CQbWuE57HiMq2FF0ML2pdnEGYzrPyrY+l/wG1jpU0TK5jHGYqeIuYqXSCAkm9kYCQ==
X-Received: by 2002:a05:600c:3e85:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-45201337374mr26827435e9.4.1749191797787; 
 Thu, 05 Jun 2025 23:36:37 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209ce17f9sm14152595e9.11.2025.06.05.23.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 23:36:37 -0700 (PDT)
Message-ID: <7439ff0a-7e38-4b26-ba15-3770148f0694@linaro.org>
Date: Fri, 6 Jun 2025 08:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ramfb: Add property to control if load the romfile
To: Shaoqin Huang <shahuang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250605030351.2056571-1-shahuang@redhat.com>
 <746b078e-bd06-4361-aec7-2301412abb18@linaro.org>
 <kep5frpl24d74evoyf367pqkyoj6xez2pirk7xlzcoompyzq4c@ouxab77sdm55>
 <68f4f244-db07-4f65-9ca5-3cb9b70c9e61@linaro.org>
 <27ea9c1e-61eb-4ea4-b3e4-e9d06b4b4ce5@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <27ea9c1e-61eb-4ea4-b3e4-e9d06b4b4ce5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/6/25 05:20, Shaoqin Huang wrote:
> Hi, guys
> 
> Thanks for all of your suggestions.
> 
> On 6/5/25 11:11 PM, Philippe Mathieu-Daudé wrote:
>> On 5/6/25 14:21, Gerd Hoffmann wrote:
>>>    Hi,
>>>
>>>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but 
>>>>> only
>>>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>>>>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>>
>>>> Simpler to directly pass the ROM path instead of using a boolean,
>>>> so board (or CLI) could pass path to non-x86 rom.
>>>
>>> The rom is loaded into a fw_cfg file which only seabios will look at.
>>> So this rom logic is x86-specific.
>>>
>>> edk2 ships an EFI driver for ramfb, that is how ramfb is used on !x86
>>> platforms today, and I don't expect that to change.
>>>
>>> IMHO a bool is perfectly fine here, I don't think we will ever need the
>>> flexibility to specify some other rom here.
>>
>> Understood, better then! Maybe name the boolean "use_legacy_x86_rom" and
>> add a comment explaining EFI driver is expected on !x86?
> 
> I think the "use_legacy_x86_rom" is good, I will change the name to it. 
> And I will add a comment to explain it.

Maybe even better could be to only register (expose) this property for
x86 machines. We'll discuss that on your v2, no need to hold.

