Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE187CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpEA-0006xT-78; Fri, 31 Oct 2025 09:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpDG-0006o9-8L
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:31:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpD5-0006cj-EJ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:30:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso1396392f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761917423; x=1762522223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=olu0ODVfqAKHcglBBaIsf0B89H4HzmMPwZH6Y2Vps7g=;
 b=ZNdBnDm1jTOkSz/2RaXZ0vpMOPFsuqmwa3ggZkzcR46UIyM9eTPR8Gl8ta8vYgMhdv
 y527LzRftnO5DGW9hJaQajcL59Nx9o8XkxxqacktWAH5+W6nXomSwlgwXWDJPsWcoLei
 oLrIfl8inhhp5eEFrUn9nkw5pUUDLgvm9pExZlheqCYXioohKrOukzoUcokuYiPYGFju
 NAPBeAExZzcIKYkCYRDXzZeNxfB2SBDKInVgQRE3KWhx6NJusBFYHCJgmVxyvcaQtXjv
 bsSzfF3NWd0oEGiLUYOmhHNAYdhpdwJy0Hmk0dC6s1KF9BIkUjPSMGrnwtBQ67lX+bDR
 UcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761917423; x=1762522223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=olu0ODVfqAKHcglBBaIsf0B89H4HzmMPwZH6Y2Vps7g=;
 b=P6bRQLtvnviLcddWsWzIBAFbdhPAh6bR8p29XK9s2Tze/iIPZKMm0uGgFk85qyc8l9
 3U05j5wtMQj5mu0JncR4xAHMmmsMTN/jJv0lvkq/eHLPNyYHrBiPkHU49gkJlsJ9/fSC
 ykUqP0/n9oxF7bjRD/OrWmcaGHqSc/uvgWvbk3BwsFBfn8efPQJF+ClHFmad0XzqDnp4
 fYKEmHF4nEx/lDwQxCb1OKlZXx9ZKKlWLtL1IF55qPj7cdxN3XLgXAUWUxItqFlyeTDz
 vh4qUObLKOlRbYQeDRSJKcVIR3eorXJxnZ42sPIq9qB3mCrUKOztK+6aHfcWd7ZEL6ew
 /E/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7fGFCVdLlC7CFuY/miJljbfHOhFfYgl3dwqWSoF41zsSRh+WrknBRw+u9YYddd2KkbJXHzgP9UJTI@nongnu.org
X-Gm-Message-State: AOJu0Yx+yPDD83DOOPRTf2AUsOGkDJOA7830bgKJZ7zAY4hv6dbg8lHg
 XjOG9qgoJ12hkpQY+KE19JS5jz6NRO9gnVDHD3EFa3DNDAuwWf3wmeNcB3Sqp8Zpwwg=
X-Gm-Gg: ASbGncs2S5bsv+4dwzbJW50stlO+8PURcAx7rJG8uWex1j/pYe3v2idTdEkWu8KMF7V
 xYQJIuVfYjU/6aRBDLA2dFor8xbHSp1oQ8PrxoADnpNLArTeRScTJ2VcSGW/nAlmvxBlYDuSe7B
 G+EI801UVIhcgYko4bqv9rwW5imqoplG3iZAe9XygKR7N+go7Z41ihrG93HAXsJyfP64mBv8/GT
 wxw3TdDORukSoaOA2L3v0aZKgF4YlMT1gc2uVccHnOKLRyQ4hEsdRMW2cTztu1Pt/NP6BN0xECh
 GMEoEIG7D/PQho50gb1nKaXnNz2YEZu+k0GAKOCFQZUdC5oa//9Gnklk1F79E3OYgVpsmpYao9b
 dAaDFFeJHetHbM60V/Sr6E8xbhwjXZt57YshuHIie//max6B8Yh4Opxyhj64WWtGM4qjem6DpUd
 N8aeJUkGgf6FYdC9o+WM+djpeH4sojnGolVu7YXYdsxpLK12FSxE3uvgKmyi4xcOUXGg==
X-Google-Smtp-Source: AGHT+IFe7QIbGFQVzUjM40CiIx0dc+yZsIIW+vgUW6mWYdKRz5Nd8xL6man3a3/bVUJ2ZnvdlQIoWQ==
X-Received: by 2002:a05:6000:40c9:b0:429:b9a1:5bb with SMTP id
 ffacd0b85a97d-429bd6831eemr2210325f8f.9.1761917423050; 
 Fri, 31 Oct 2025 06:30:23 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c10ff20esm3731607f8f.1.2025.10.31.06.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 06:30:22 -0700 (PDT)
Message-ID: <507f6a8f-6d1e-4146-b318-db342e870b3b@linaro.org>
Date: Fri, 31 Oct 2025 14:30:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Mark the MIPS Debian Wheezy tests
 as flaky
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251031094118.28440-1-philmd@linaro.org>
 <20251031094118.28440-3-philmd@linaro.org>
 <171d963f-9543-4a1d-9852-3ba48e9e7310@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <171d963f-9543-4a1d-9852-3ba48e9e7310@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 31/10/25 12:33, Thomas Huth wrote:
> On 31/10/2025 10.41, Philippe Mathieu-Daudé wrote:
>> test_malta.py sometimes times out (likely hang) under GitLab CI:
>>
>>    1/57 qemu:func-thorough+func-mips-thorough+thorough / func-mips- 
>> malta    TIMEOUT   480.11s   killed by signal 15 SIGTERM
> 
> Do you have an URL from a test job where this happened? I clicked 
> through a bunch of failed pipelines in the qemu-project, but I only saw 
> failures of the replay test in recent runs...

I was thinking of https://gitlab.com/philmd/qemu/-/jobs/11869641060

▶  1/21 test_malta.MaltaMachineConsole.test_wheezy 
                    FAIL
  1/21 qemu:func-thorough+func-mips64el-thorough+thorough / 
func-mips64el-malta              ERROR           25.11s   exit status 1

2025-10-28 07:06:59,425: [?25l[?1cSearching for RedBoot partition 
table in physmap-flash.0 at offset 0x1003f0000
2025-10-28 07:06:59,602: 7Creating 3 MTD partitions on "physmap-flash.0":
2025-10-28 07:06:59,603: 0x000000000000-0x000000100000 : "YAMON"
2025-10-28 07:06:59,605: 0x000000100000-0x0000003e0000 : "User FS"
2025-10-28 07:06:59,607: 0x0000003e0000-0x000000400000 : "Board Config"
2025-10-28 07:06:59,876: [1G[[32m ok [39;49mCPU 0 Unable to handle 
kernel paging request at virtual address 0000000000000028, epc == 
ffffffffc00ed234, ra == ffffffffc00ed210

Is it different that the GitLab issue report?

> 
> Also, does it happen for all mips targets, or only for specific flavors?

I can't tell so far.

> 
>   Thomas
> 


