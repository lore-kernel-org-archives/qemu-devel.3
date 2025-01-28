Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9897C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tciPh-0004cy-Qz; Tue, 28 Jan 2025 05:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tciPd-0004Xh-L4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:01:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tciPb-0002hq-Lv
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:01:41 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so4277134f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738058497; x=1738663297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BgwND6a83VEmaQ6ZUvzb+yjXT1zpOGdQtTBul0CqFkU=;
 b=PMJ9GaGFz5D9vw5+uWS/hWy1QA6uBXIh79+yMOkbgcVBlsSNwslGFMr7LteraOAWIE
 yhcNhJIYK5Vt7UPooHIGg2EwvCihXhQJ6b7tqriETDf9o8nMfCUpaAEkAdzWYST2go2R
 KMIUYPhptAf3Yxgv4GXt3hTHubC3fB4ZE9idlekrKJ+TwRaW30x3Rlul4y2KChRckaR2
 MxQHUt4awDJMztQ1+ivEfKVZjBO5X1OlvAwEsk81PlQlPug1XBncrpIVBEdvCw0rbyk7
 cbd8GgKj0gIE9OayCkiNyXOPlkvB0w0zc0vnMSJcq1mEpjZfzD/ubY9L32+lj97G55is
 baIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738058497; x=1738663297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BgwND6a83VEmaQ6ZUvzb+yjXT1zpOGdQtTBul0CqFkU=;
 b=uJq4K9M6rzdPY0sjQDWWgsQi9WncSfgR/lC+9FjjrnprGAJjnqzY9sC767/+iRS8rv
 lUwSR8uyS6r57qqsrAkbZCxHDJJSqYSouMMxCic5vw8Y01io25DB9BUt/08ZYHqz9Qan
 ofw4oI+s/N+AuvaHEHjQpZ94iHePN+MavjxLGLOQ3r1OeastjS23KW7xtTyLsQjjx/yM
 T83B0Gl4HhWO1VI075xPlcva5zkfakZI32sMayEBxcSPJxJAGXFp44/y+fiQP/l58j1H
 e2B8OphfSYFY5vmNjVUJDE+sBvCQX3ufij+MZrVWLV+e4BiGGIGO2+qWNuNs/fm3w/Kx
 ymVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn1DW9dEirdM5DRL1Co0uBmu6l6asBQH35Eoow4Vgt47o0EOoWG/1RT+8Qe/fUxcSJw46wuL8bAz8U@nongnu.org
X-Gm-Message-State: AOJu0YzU410bLhdoy6eFF1GqCiZBk51qWi8DYgRzbWSGGXuLvIHdb0xL
 cDV5PLZ9u8L/12pOZR+0g5D5GM2Pg1fSXG7mrkETElCO9J2Ua9F1bL5S80jMxRs=
X-Gm-Gg: ASbGncvSJ+5WXqXqlWoAjLAcV2haeNSfa22dvu+n5BNotIqVID2kdwZ0VryTcMVehV9
 F05jkvp3CBcgv4Mqlyp/ETc7mrdgCWq30Gn7voidcxQ+ucd13+qqT3T8JRsEyIvMyWaGxPso64+
 /Cb5ahxV5bhwyW5pgnS9/Bg7SwP7HIxU7+RBI/q0fMQvVydWec1lUlnLu7b3EAuK/wkPJuRfCd2
 109LoqtX3nC6nxGiCj5Y3Tks0p2fy2jR2FsOWQn+eWyLejv6/Q8jK1Lokva1RIiZ6y6bJgsfij7
 NTlOx7ChNkz1G5EcPLtjZvf6oIwTGihVGS6cUoLR1PBodJDcPXQsWhjSdeY=
X-Google-Smtp-Source: AGHT+IHNoYqXZfesSAEoRdimkh49cazFu14WXL+KKMu9Uvpc4l83xwQmb5puUTlMUKbwOQ3CaKitnQ==
X-Received: by 2002:a5d:64a5:0:b0:386:4570:ee3d with SMTP id
 ffacd0b85a97d-38c49a5a754mr2400988f8f.24.1738058496961; 
 Tue, 28 Jan 2025 02:01:36 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764b7sm13863903f8f.10.2025.01.28.02.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 02:01:36 -0800 (PST)
Message-ID: <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
Date: Tue, 28 Jan 2025 11:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, stefanha@redhat.com, pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk, Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z5ii-ueFt5-5Brxz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/1/25 10:27, Daniel P. Berrangé wrote:
> On Tue, Jan 28, 2025 at 10:17:33AM +0100, Philippe Mathieu-Daudé wrote:
>> On 28/1/25 10:02, Alex Bennée wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 28/01/2025 01.42, Richard Henderson wrote:
>>>>> Time for our biennial attempt to kill ancient hosts.
>>>>> I've been re-working the tcg code generator a bit over the holidays.
>>>>> One place that screams for a bit of cleanup is with 64-bit guest
>>>>> addresses on 32-bit hosts.  Of course the best "cleanup" is to not
>>>>> have to handle such silliness at all.
>>>>> Two years after Thomas' last attempt,
>>>>>      https://lore.kernel.org/qemu-devel/20230130114428.1297295-1-thuth@redhat.com/
>>>>> which resulted only in deprecation of i686 host for system
>>>>> emulation.
>>>>> By itself, this just isn't enough for large-scale cleanups.
>>>>> I'll note that we've separately deprecated mips32, set to expire
>>>>> with the end of Debian bookworm, set to enter LTS in June 2026.
>>>>> I'll note that there is *already* no Debian support for ppc32,
>>>>> and that I am currently unable to cross-compile that host at all.
>>>>
>>>> IIRC the biggest pushback that I got two years ago was with regards to
>>>> 32-bit arm: The recommended version of Raspberry Pi OS is still
>>>> 32-bit:
>>>>
>>>>    https://lore.kernel.org/qemu-devel/F852C238-77B8-4E24-9494-8D060EB78F9F@livius.net/
>>>>
>>>> And looking at https://www.raspberrypi.com/software/operating-systems/
>>>> this still seems to be the case...
>>>>
>>>> So I guess the main question is now: Would it be ok to kill support
>>>> for 32-bit Raspberry Pi OS nowadays?
>>>
>>> I would argue yes for a few reasons.
>>>
>>>     - you can't buy 32 bit only Pi's AFAICT, even the Pi Zero 2W can work
>>>       with a 64 bit OS.
>>>
>>>     - It's not like the versions shipping in bullseye and bookworm will
>>>       stop working.
>>>
>>>     - Even if we deprecate now there will likely be one more Debian
>>>       release cycle that gets 32 bit host support.
>>>
>>>>> Showing my hand a bit, I am willing to limit deprecation to
>>>>> 64-bit guests on 32-bit hosts.  But I'd prefer to go the whole hog:
>>>>> unconditional support for TCG_TYPE_I64 would remove a *lot* of
>>>>> 32-bit fallback code.
>>>
>>> I support going the whole hog. I would be curious what use cases still
>>> exist for an up to date 32-on-32 QEMU based emulation?
>>
>> Current maintainers don't have spare time to support the 32-on-32
>> emulation. If there is interest in the community for such niche,
>> someone needs to step forward, willing to maintain it.
> 
> I'm not sure that's the case here.
> 
> 32-on-32 is already effectively unmaintained, so we're not suffering
> in terms of keeping the 32-on-32 code reliable.
> 
> We're suffering from the complexity that 32-on-32 code places on the
> rest of the XX-on-64 code that we do care about.
> 
> IOW if someone volunteered to maintain 32-on-32 that's not actually
> solving the complexity problem, just perpetuating it.
> 
> The current maintainers only interested in XX-on-64 will still suffer
> ongoing burden from the code complexity caused by 32-on-32 merely
> existing.
> 
> So again lets be clear...
> 
> Either we...
> 
>   * ...want to kill 32-on-32 code to reduce the complexity on the
>     main XX-on-64 codebase regardless of interest in 32-on-32
> 
> Or
> 
>   * ...want to kill 32-on-32 code because it is buggy due to lack
>     of maintainers, but would welcome someone to step forward to
>     maintain it
> 
> It sounded like we were wanting the former, not the latter.

Yes, we want to former. But as Thomas pointed out, last time
someone showed up, and while the maintainers weren't willing to
keep 32-on-32 [*], they kept maintaining it at the price of restricting
XX-on-64.

[*] back then we proved system emulation XX-on-32 wasn't really useful
anymore, and user emulation 64-on-32 was partly broken, so only
32-on-32 user emulation was functional.

