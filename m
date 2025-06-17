Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C0DC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYgQ-000462-Qw; Tue, 17 Jun 2025 11:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uRYVu-0005W2-MV
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:46:20 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uRYVr-0006un-W8
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:46:18 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-31329098ae8so5126057a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750175173; x=1750779973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iiPgBXhS5w6nroHcFxfroCY5tg1lVnA/jypCUUiHWkU=;
 b=RmScbG84WOK0/gMeErEPdRexgFFRLSEJiJA7vV8ILizz0pF2be5UG6CxasvBF8R6ku
 0BNFIs2fbMn49Arg872lvWFSaXcv7mOqKzqdKoYUPPWRy5KyNFG+8PrJKuNv8oYCI42E
 Qz2E+EjmIndQC+VKgc9K4h8QD5F5xyL+2iH3YuOBcr8sSFY6B1fTarcm+TGSjvE9ODD1
 iLld5Ev4DPC4d5teC5rbTv3cLgxfTMk1GXWeSPeJeUW82IDclNAMtKzrI4Y5ZfWg5S5Q
 V3FAPRgWu9dyaTOSvFw40u32GbR8ABsAjkMAdnwoPaR+lE/3XLr1TDsx0F3Tmh64fJSE
 5rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750175173; x=1750779973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iiPgBXhS5w6nroHcFxfroCY5tg1lVnA/jypCUUiHWkU=;
 b=aJkTfuISL8mjPKKrlF13ABI7FHUhihVMiWvLrDcNt0goGkuG55p+avnMpSzCwf/EAS
 Q9YdYwbU/KrcpqSFJXTRuL+APzkn5tCeLR7BnUnz4f/m8hCgdxgT2T/qqtk46jKnF79Z
 V4T3amC/7dDE0aA7x7IyIkYfAlKBl2SgchmirJnTROJiCbNxBGChtqQN1bEhuX0KNKMI
 AHQaL5Wpdvlc/ZUI4nCC+wqzOplJhZTihwLglyWvSHT9Za1eh8TijFvYZJoY2R4FQSpL
 o0kFOJmuyXuu4KT7+Y+Er4DP2f/xM1Ju45ac/njvIYISkZlQuy5M+AmwngfeKUUHlX7P
 jXnQ==
X-Gm-Message-State: AOJu0YzDvZFdYaa4aUVdRMJ96hfi5scUPENQtX++SKC04AOOL53quNF3
 6e/AIq/0Vq80y2dj1MBv2QZ8kftNAk+G+fJH89snhPxqsn1MM4z6tV43
X-Gm-Gg: ASbGncsXGS6pTYpZBU12CKm/RLU7Q7CYvKxuvavs+e0DG6JtusTERaC1C28zLQyDu17
 YgDS3HDGQ7z2DnOasgSb7oUI+9UJuFkaQjKZ/I9t7cexZDG9UZWXyg2PMGeOZcb+SPHpWdRClUl
 e1R/7gQA87ORalZwAyICXl18vLq82hzoKOKUaZV6ESUZMZMbw2pku5+5VC+UDKMvCnu0eUCj9Vm
 cIx2hPehkZMe9oy06QwoEPmdN+J+KDDWZSvVjur7Ctn9uXZKUVWyrO7EPK/IR+XGtbNHGkeXW9v
 O2Okn8SVoyKmZvZ9fTY5F/jye9vaxMMD/C5YY2/npi0AGZVaLoctSDEaSEgyJtnmyvFVVgGY/uj
 s
X-Google-Smtp-Source: AGHT+IHwrNqv7pmGf5okHTc/aecD/U61spqIl7KLB+ulo64ZnwOEaP4DfHH5lhWDJ0m0IZ3aizSNmw==
X-Received: by 2002:a17:90b:28c7:b0:313:f995:91cc with SMTP id
 98e67ed59e1d1-31427ce95fbmr4987304a91.2.1750175172489; 
 Tue, 17 Jun 2025 08:46:12 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3142874a4f3sm1811902a91.22.2025.06.17.08.46.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 08:46:12 -0700 (PDT)
Message-ID: <168f9716-1b1c-42fe-9be8-f6b895a9095f@gmail.com>
Date: Tue, 17 Jun 2025 08:46:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/7] plugins: Add memory hardware address read/write
 API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
 <20250611232409.2936521-6-rowanbhart@gmail.com>
 <87h60evf6t.fsf@draig.linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <87h60evf6t.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> My main concern about the long list of caveats for writing memory is the
> user will almost certainly cause weird things to happen which will then
> be hard to debug. I can see the patcher example however it would be
> useful to know what other practical uses this interface provides.
>
Of course! My main personal intent here is to facilitate introspection 
and manipulation of guest state for security analysis. Some examples of 
why the memory/register R/W primitives are necessary here include:

Fuzzing:
- Read registers and memory for tracing control flow, comparison 
operands, and profiled values (e.g. memcmp arguments)
- Write memory to inject test cases into the guest (for me and other 
fuzzer developers, this is the biggest reason!)
- Write registers to reset execution or skip over complex checks like 
checksums
- Read and write memory, and read and write registers, to do basic 
snapshot/restore by tracking dirty pages and resetting them

Virtual Machine Introspection (for malware analysis and reverse 
engineering):
- Read memory and registers to find kernel, analyze kernel structures, 
and retrieve info like process lists, memory mappings
- Read memory and registers to quickly trace malware execution in VM
- Write memory and registers to test behavior under various conditions, 
like skipping into checks (motivating example: what happens if you skip 
into the kill switch statement for WannaCry)

Runtime patching (as in the example):
- Writing memory to patch critical legacy code in production often can 
no longer be built or patched via means other than by applying binary 
patches (this is a real problem for e.g. the government, to the point 
where DARPA ran a program 
https://www.darpa.mil/research/programs/assured-micropatching to work on 
it!)
- Writing registers to skip over broken code, redirect to patch code, etc.

Ultimately, the caveats boil down to "don't modify stuff that's touched 
by currently executing code". I personally don't think that's 
unreasonable (as long as it's in the doc-strings) because for any plugin 
that needs to write memory, ensuring the write consistency is probably 
the easiest problem to solve and people working in this space are used 
to having way worse and jankier workarounds. These plugin functions make 
life way easier for them. I have been in touch with 20+ people from 
various companies and projects (including Microsoft, where I work, as 
well as other big and small tech) all working on plugins that could be 
better if this feature existed, so there is definitely a user-base and 
appetite for it!

The last cool use-case is that this moves us a long way towards cleaning 
up the large number of QEMU forks out there designed for RE and security 
testing like QEMU-Nyx, qemuafl, symqemu, and many more. Instead of 
maintaining forks of QEMU (many of these are based on 4.2.0 or older!) 
folks can just maintain a plugin, which lets them take advantage of 
updates and fixes without giant rebases. My goal is to kill these forks 
and have these projects write small, maintainable plugins instead, and 
the authors are on board :)


