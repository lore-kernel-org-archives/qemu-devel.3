Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5A5E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 11:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXHQU-0003h9-FG; Sun, 21 Dec 2025 06:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXHQR-0003fl-Ii
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 06:16:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXHQO-0007Rr-W4
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 06:16:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso24669185e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 03:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766315791; x=1766920591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K+JqG1dpVPXEHeVjXWwxoJrpStoaekHAHNvFBOCNMFg=;
 b=cPgZrc+dDFC+X11JJQ363ECIQT+wQ/OMYEoanDoRiNQkCH/Nlc+V7djaHsD5MpfF9/
 H3mXWTacbu8csGiQXaKV7BEDGiTHDIfP4DQJ9rMS8KcsSSfxyOSyqjyuB2W5yZ9PUdCk
 V8HJTxEQnebbOd0eBNq5z2HszgeSrUAKofGfG7oTbJFbmz0Ipet+wDTrrcPZiPRH4x0b
 32UW4e3OR7Vm8tz+0nkwy7ojGqs8U0Xqcn8919qEp50Jin4Mv+d5bxxgalKP/bZtzzd+
 HFS5ibaOR/XEEmUHIU0ZHLHal43bGJ+CJP575BgG62zEG4KPew24CXtUmzfgRKgqe/HF
 1b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766315791; x=1766920591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K+JqG1dpVPXEHeVjXWwxoJrpStoaekHAHNvFBOCNMFg=;
 b=vst59QmO6gRr0NPnkUAFCp/ClKuEyxjb/JqVNp1YxsLiZoC8Q9TsQ267pBS/7sw4eh
 JtUnkCN80CDwywiVCgNG3RPWAwllUCXi9IxlE63WIzde6s4hJoNn+IrhniRUde1jThUI
 M4T7ENsq++wnCibk1VVlocUu18cB2N68frUXFJiuE+SjdQJdVDraQOwyo0jVQWp1n6bP
 EDiMJDhjCfiT8wqToSmFPFjiVscV1ybZ88e04HJnAUkglw/4sm7A7ZpF8IOSs0UxNZuR
 nXohAoYqaflA9XFFTXQhfnG3XSkljP6MrZWOwcMnS+ONZ6rDNuR9csdPCnFCZBsWOEFd
 6GLQ==
X-Gm-Message-State: AOJu0Yw89L3Ll4VB/oTVmyUzOhNiUpvs5kCLfBQJ1c91fayIwtk+kzqN
 ScHAI9+oJwT9xwa9loaz8CPTvVRbjpsIsej6/t/VCJHV8H3TEw5BZeuwFePhknYSrWc=
X-Gm-Gg: AY/fxX7CO3e/hcvYdc/mdUswsPoPZB00KFhzvobHw6AcDqiEOVWs5sPmcWc8xN7g2Eu
 lb3qcNOF9K6CCpK+2CIIBRMfdp/JI1fjU+OgJuN1r5fIJFS9PvbIntifu9+2sUdkbyzHByOqvLP
 u4AC8FrDfZpg9c2+BHpZaYE03Dg5UAso/UZ/c3Sc5+uO8Utr6vpBq77ibsxfjw/uP9Zlqpsa0wR
 6BzzT1rWtudbSMVwCC5o/4BAadFonOIobtqc4nMce5mqWHFnZ0ziMw9QQoTxh4gnPBIioFRc6qL
 63Htg4Iu6Oc8StwQl6NXzL7vGpglefCdbJlTJKqyjLC8jL8KXhXEdGhW8f2sCF5Q9psDgieFCqy
 2WGuDwrpi5obOjXotEmqgOuOw85hSuZesSKNkW7VgG99wr4RYkuGSnzJL7W3RgbyFX/xAgNKY97
 kfXScoszRzoDeKkHkNTsCQpAlcfJfc0O1pbltludhgyR8hAXVj/Ixztw==
X-Google-Smtp-Source: AGHT+IFlYdeiUvXEUe/dfEL6ej5XRliCaXz5lhuEUCmtfmv109lSOckVUpZ1XbN8fibOB+0+xbydKQ==
X-Received: by 2002:a05:600c:6610:b0:477:a219:cdc3 with SMTP id
 5b1f17b1804b1-47d18bd56b8mr80040145e9.12.1766315791445; 
 Sun, 21 Dec 2025 03:16:31 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be274e407sm187085955e9.8.2025.12.21.03.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Dec 2025 03:16:30 -0800 (PST)
Message-ID: <8e9cc465-fc3a-4665-b754-6d5e20bc3651@linaro.org>
Date: Sun, 21 Dec 2025 12:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAX78000 machine needs a maintainer
Content-Language: en-US
To: Jackson Donaldson <jackson88044@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <87ike27ucd.fsf@pond.sub.org>
 <CAMyd1rQ6CLN2FPic=4pNpZtcw46io2xftkBDSLfd8V9S+Jyu0A@mail.gmail.com>
 <878qex3ac7.fsf@pond.sub.org>
 <CAMyd1rR9HLwn-fzWfgqu=ZdtOq_Ae6Den-0oCmZpXAjxbup87A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMyd1rR9HLwn-fzWfgqu=ZdtOq_Ae6Den-0oCmZpXAjxbup87A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Jackson,

On 20/12/25 15:51, Jackson Donaldson wrote:
>  > Out of curiosity, what was your motivation to add the machine?
> 
> I wrote the implementation for my university team in the 2025 MITRE 
> embedded capture the flag challenge

My understanding of Markus question is not why you implemented this
machine, but why you decided to contribute it, if you are not going
to maintain it, because then this is more burden for other maintainers.

