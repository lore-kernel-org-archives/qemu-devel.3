Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B3CC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4zFe-0001bQ-7F; Wed, 16 Apr 2025 05:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4zFb-0001aL-IK
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:40:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4zFZ-0005H6-HX
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:40:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so6423045f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744796408; x=1745401208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+swtM5eNoaWowPpJ0+nOSfNZlP6uiC0n2EId8otugg=;
 b=R7IarvScT8lgKrUHL8XiU/QFudxR9ozRuZ6Qoa/nqLwpbxWjjZyqUiFgIOjWgEEq/Q
 XbQeePC+cb8ufTx1suLy8pwjrXTda+E6S5J8bYa7PPJoKHpxxwtOAzcdBde5D8rsJhRD
 I6crwJArd6FoudI0cUuqnnk+qzVtJy55iwOQpR9jz5gKtsY7SKs7ub/SQckmDYn0xjFn
 mR3aNKRwjBVkILPBhwB+EsNgr/0uMJRrpW2M5Yqv5e9iToJdgKCdXqZissWJdPUMp5Bf
 MYBXUDsPGIQOhRfC7/Ymi6g6S0CfVOWdmXme04B6VVnN05HPtxkyzIGaIpXigNEdPgJQ
 Q9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744796408; x=1745401208;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+swtM5eNoaWowPpJ0+nOSfNZlP6uiC0n2EId8otugg=;
 b=PiSQj1tJKUY6t6Wc6bxR9RbgGpe/OUlXCXJvkkegsBkDCGu1KyrxZY+beQFg1V5SYz
 WV+dprrjRc4cQkcGFIpJ0/5iOQZnhbRzjk39Q9voHN8giTjBKAT87U68rnEjXN0BYIAM
 E+L3Ow1x5LFU7ckA96nNI03aJ7Qn5Ek0mwrZxyWb/oKwupYovHb9YqP4s6t/fLPhZBP9
 408kgjbyY8YIbppTsHYdHRAJD1JqxFkMsoqjBO/PUr8WOQMSJmzALglej2JcEzue0Ixu
 6td2o1QwInX8AusypHxqUhB3NngJdmXD8Bw8NLWh8qi8dt+onZtX77BDEgVkCxqEa5tm
 ZnYA==
X-Gm-Message-State: AOJu0Yyeg1eOes8og71DadOaEz2fQDjz6r7WYlruastZv+fz2nj1ShDn
 4HVrhaF0XNCgLTctAawTijLuYcMYdBg/ygojzPSluICkmzVhr43seAIFENb4/n+RgkDs1DT7zHP
 M
X-Gm-Gg: ASbGncvkjOw+ubDzRHUVMkAJ1kP5xcCI/x50gDrfFcHpvjDfjtznOqEnkAODVyZKESq
 TG6uqmmGvjVqOgPF0gim75EaGsDH9MGW3fb7t95UA24pcXVztKIwODkg63cIHDLqO4OxAlHZ3MQ
 NTFt9rLO0Ntvg5pZG1fuMAfp4QavH0CS5/4j0DQg/mJDblhKE2DqMjxosJS8cBv3eNKhVXxGFQp
 NGPlp6/CGYAMSTB3XMhMHfJ0NsWu5MZTXQJnk1NccVOPLCdECPTeg9pWfX/HC4WUbAdzH6j/p5X
 riSiMK6evTalME6eHSRPa6IdnSgUMDq/ko24C0fpJDBwHO3CYtc52sZETVfAiVvdjkpUXQ+OKuq
 4//o4ILca0OvXGsPy475pbZ+D
X-Google-Smtp-Source: AGHT+IE90E6HWILOtCJbOlHcEhOWbqwNUyHDYz8o9dek5kMEJOG1juvohGFu7/FCKx4bgH6sRx8ogw==
X-Received: by 2002:a05:6000:43cc:20b0:39e:cbf3:79db with SMTP id
 ffacd0b85a97d-39ee5b0ff07mr745804f8f.10.1744796407781; 
 Wed, 16 Apr 2025 02:40:07 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96e912sm16889384f8f.31.2025.04.16.02.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:40:07 -0700 (PDT)
Message-ID: <529770bb-3026-403d-b6f2-24efea26122d@linaro.org>
Date: Wed, 16 Apr 2025 11:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PPC MacOS9 SCSI PCI Passthrough
To: =?UTF-8?Q?Andr=C3=A9_from_Negmaster?= <andre@negmaster.com>,
 qemu-discuss@nongnu.org, qemu-block <qemu-block@nongnu.org>
References: <339F0125-96C3-49FD-8088-185570DAE412@negmaster.com>
Content-Language: en-US
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <339F0125-96C3-49FD-8088-185570DAE412@negmaster.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, LOTS_OF_MONEY=0.001,
 MONEY_NOHTML=0.307, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi André,

adding more PPC developers.

On 16/4/25 10:42, André from Negmaster wrote:
> First of all many thanks for your work on PPC emulation.
> 
> I would like to request SCSI/PCI passthrough to MacOS9 if possible.
> 
> I spent the last two days trying to get this working to no avail. To me 
> it seems QEMU can't do that. The PPC documentation is missing 
> information about passthrough. I would like to see some more information 
> there. Because i am still not sure if it would work or not. I passed all 
> hurdles, like IOMMU groups, IRQ issues etc...but still no SCSI card or 
> scanner in the system profiler.
> Something like a HTML table that would describe the possibilities of PPC 
> emulation vs I386/x64 would be very helpful.
> 
> I would like to point out that passthrough is particularly important for 
> OS9, as we have a quite big community of people using old filmscanners 
> (more than 700 people). These scanners were very expensive and are no 
> longer made but require OS8/9 to run on the software they came with. 
> Sometimes they cost up to €150.000 and they are not supported by modern 
> 3rd party software like Vuescan or Silverfast. Thus they are not able to 
> run on modern operating systems.
> 
> Many of these scanners were trashed during the upcoming digital camera 
> era in the 2000s and i'm doing my very best to save and repair the 
> remaining devices.
> 
> QEMU could be very helpful here in terms of sustainability and economy. 
> Also because people often don't want to deal with old G3 or G4 
> computers. Those are getting difficult to maintain, take a lot of space 
> and are not really energy efficient.
> 
> The TLDR is that this way QEMU would be used in a productive environment 
> for earning people's living (film scanning labs and film photographers). 
> So in a way more meaningful than just for retro leisures.


