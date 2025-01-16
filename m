Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E43C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNZh-0005DS-I3; Thu, 16 Jan 2025 05:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1tYNZf-0005Cj-Ee; Thu, 16 Jan 2025 05:58:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1tYNZd-0007jK-Ou; Thu, 16 Jan 2025 05:58:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21680814d42so10694235ad.2; 
 Thu, 16 Jan 2025 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737025083; x=1737629883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mfbEp2qYxtrBIIbyBCDjoEqzeGlkCi1sJCwdB657Q2A=;
 b=Xvg0CUxCXZ1r/3bZDUxSeUzLVAi73ME1fvOPcdJh4rAakK4q7jgBA1RYtswdzX866t
 /yTG+6BIRPMlwJMCMQT61rc5QTGV6FVOMUxPXAKnV23IaG1Dd0zrI62EJoqXbPBb+X/w
 KkPfJ2JvTm7/XMNlbBehIBjFjp8lPScZrMJxF30UI+3hJPhwOP1H9/7cw+6mDL4HZXDy
 FQ2LUxhiss2vDdHUWj6CjbjuDWXtk30dukpYtqYEbOs5jhg2QZ+5zFmU26znzG8WJFHj
 AFyF6xwWlhBo30GC4YJcTDXmTrim5+jje5UXhUs3RNYOjedHAm6OeGo2jC+3LwFpO6LO
 06gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737025083; x=1737629883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfbEp2qYxtrBIIbyBCDjoEqzeGlkCi1sJCwdB657Q2A=;
 b=eL3i6BLrrcrPgNRyWvcL/BhDZptzPqYI4iViCftNztt2fPoj2u7rw4YvYbiO1k4Mgc
 XI0V8/w2KqWWr3YZwf2EyBDFztiKKDeMU17AmuXghwCAfFee6wZ36c8xM0VgjIqbH4jr
 0v42rZtHh0xyxlxpvx+BZ8yYmzJmwArC0Ra4DOSZvNXhJ9KFtW+vedSyMzo3+gQmH4bW
 r5IEdkTOQnswXjcCl+susDVLYO9C0z1/xce3UUpBIDFbWG7DZ01xrtB4A7CwojRpeAeO
 nviCrP3J+ujXIS4Fl+yUzG+fx8zMeOGizREZItzgWUpfBu5+40chhzlvQSHk3ro3RhQe
 pZaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl4FsnU7e/AWfh9rqeKvPNgEyyHiqAIrgq1LGXFMv6KUnSy5k3VIJXLYFscqxalCZ6x9SnZ4C0plqM@nongnu.org
X-Gm-Message-State: AOJu0YxuVyyHC+peUz0e9UM098f+hapa+LpSi1ByrDNJwnYjrpQItYDv
 Mjp4CJxMSnB++32/GrVNiD5JnNC866HyoTBel+0zRk8MgOSh1J4f
X-Gm-Gg: ASbGnctzzciMhyPghESKupILRv428C1nKKk8i+yo8T55glGd2YebsTBdIKkns7pQC4+
 jvKvPwpJR19eH+YTYNOqFRCfKFgJDbXowQPT3OkHKOyT/HfpvoZTZvoqonGmcSM2BeDuMjt5Ae1
 jLgVEPofXpeGP+nbMPEQphixryG8RCFUFw3O0qQEabpNDyYqQJOELKcXpxLQrDQddZpLdY9c3yw
 N0iVBK/DYWb4sWv1zYg7lnXLgBGiY0l3qIXs4cdEexUBqogaBVg4ADZXS/5fFX6Zg==
X-Google-Smtp-Source: AGHT+IHo4uqU7Q94psZC02VFyR7gvA+prqi1bvmTBZ86rCM3PvrWGicu1YlKvhHbTU27o6P0A/2HMQ==
X-Received: by 2002:a17:902:f70f:b0:212:4c82:e3d4 with SMTP id
 d9443c01a7336-21a83fd90e6mr501215705ad.46.1737025083495; 
 Thu, 16 Jan 2025 02:58:03 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f253a7bsm95021185ad.222.2025.01.16.02.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 02:58:02 -0800 (PST)
Message-ID: <482d9d0c-e112-49c1-8102-f263d11127e4@gmail.com>
Date: Thu, 16 Jan 2025 07:57:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
To: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On 1/14/25 4:11 AM, Nicholas Piggin wrote:
> On Sat Jan 11, 2025 at 2:25 AM AEST, Richard Henderson wrote:
>> On 1/10/25 08:15, Philippe Mathieu-Daudé wrote:
>>> Hi Cédric,
>>>
>>> Cc'ing Laurent & Richard for user emulation.
>>>
>> ...
>>> The deprecation message (see previous patch) was about the
>>> "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
>>> for user emulation?
>>>
>>> $ qemu-ppc -cpu help|fgrep 405
>>> PowerPC 405d2            PVR 20010000
>>> PowerPC 405gpa           PVR 40110000
>>> PowerPC 405gpb           PVR 40110040
>>> PowerPC 405cra           PVR 40110041
>>> PowerPC 405gpc           PVR 40110082
>>> PowerPC 405gpd           PVR 401100c4
>>> PowerPC 405gp            (alias for 405gpd)
>>> PowerPC 405crb           PVR 401100c5
>>> PowerPC 405crc           PVR 40110145
>>> PowerPC 405cr            (alias for 405crc)
>>> PowerPC 405gpe           (alias for 405crc)
>>> PowerPC npe405h          PVR 414100c0
>>> PowerPC npe405h2         PVR 41410140
>>> PowerPC 405ez            PVR 41511460
>>> PowerPC npe405l          PVR 416100c0
>>> PowerPC 405d4            PVR 41810000
>>> PowerPC 405              (alias for 405d4)
>>> PowerPC 405lp            PVR 41f10000
>>> PowerPC 405gpr           PVR 50910951
>>> PowerPC 405ep            PVR 51210950
>>
>> Up to the ppc maintainers.  I don't know of anything interesting at the user-only level
>> wrt these cpus.
> 
> Just getting back to things after the break...
> 
> We are looking at modeling some microcontrollers on the POWER
> chips. There is an OCC power management controller which is a 405
> and some other weird cut down 405 derivatives, we're not up to
> those yet but we want to model them.
> 
> We should be able to remove a bunch of boards and CPUs, I just
> haven't started looking, so might be easier to wait for a bit.
> If it's not causing others too much problem, could we leave this
> in for the time being?


That's fine, but then we need to at least mark you as a maintainer here:

PowerPC Machines
----------------
405 (ref405ep)
L: qemu-ppc@nongnu.org
S: Orphan  <----------------
F: hw/ppc/ppc405*
F: tests/functional/test_ppc_405.py

Either with "S: Odd Fixes" or "S: Maintained" (or S: Supported, if that's really the
case). And perhaps re-visit the deprecation notice too.

I'm being petty here because, right now, all 405 code is marked for deprecation, has no
firmware images and Linux support and etc like Cedric mentioned, and it fits exactly
the criteria everyone else uses for removal. If we want to keep it around we'll need
at least MAINTAINER changes to indicate it.


Thanks,

Daniel


> 
> Thanks,
> Nick


