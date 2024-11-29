Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2401D6EC00
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 11:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGyjA-0001I3-T4; Fri, 29 Nov 2024 06:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGyj9-0001Hg-AW
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:59:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGyj2-0004fP-DS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:59:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434aa472617so15739035e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732877990; x=1733482790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SJf5XdQbXEL1Sgw2WOEw0Ahz9e21x47iqJyxEyLC4FA=;
 b=GY1scEJc/GxjYAezzflHYyk1Bd8AdPv9U+ufGYcUeXuM04ovbYsYfB6IIzhweXvT5y
 PPGdD62yU+NczG0lOkflk218+xeZZoruUppcXptaqIiT+YfOqOOuRseVhmrV+n07h0wN
 M460eEVmiIlWuVmFjO/ZEzOAm+3zTFyvOWsJ3o/BtCip88c3yNEZUYHSj0JHfpbyBTJX
 cWlJvdjiLOm1KFLDrnUCXUX2pYPxt2F0RiE4ZaABR8CI2fpDbN04u2ku9zTbAp/Gu/5q
 Jlza2swWBYs2mJ3sxfEkApQpirnfAmqVOHScK5wjUQ2nUYOI38UqDOe/wyS5BPsehi4d
 87dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732877990; x=1733482790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SJf5XdQbXEL1Sgw2WOEw0Ahz9e21x47iqJyxEyLC4FA=;
 b=caj/jnss8HIuER2d4qyqGAy6XbZMeurr7JJ6CFFz+0SvKM9h6VXiC8wwSF3tot3whM
 UDsZVxFLOBAirinpKAJ+BwIkn6OJF78+EYf6+jRl9DeiGE/+6yJXDzPoZXETmjN04sFm
 /po9keyC3TKZ067oStro6igRIUJw97XKUo89xnOH9SEyQVplCZFNIDQCTKOyuMs9Vi0z
 /bCFJLL4bzKfnhuPtdQfngLuuxX5D/CFuCILAQI85/5JBbhR1oeIMknPhKKVe7G6I2oF
 BUX8O/71PLeFyY9bjfKIHf/fFCsJ/R4jjtX6pGMNCnjDgU+by5TZpf/gUON7uol4yeoB
 pMtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhGo5r7IUFnVcfrXE8pMFKtRPM/1ibJ9KGnUiFIhxg5oLNzBrIh6hv6S/WHZxQvRz/OY575CKp80IC@nongnu.org
X-Gm-Message-State: AOJu0Yy7jNNM3lLQO93tUgIImDvWl01qPOSP39lWt1H67Vv2Aw3Q0TI2
 FlVhPw2LoYXdUsPIYMgyYnYkU/xY9kTCXQsEQuNEVgt00HbCmtTkypbDG1KsECQ=
X-Gm-Gg: ASbGncuK2764ISzlAtbssM02viguCA6bNUW5Sq1RL+YRz/MNnLUtwVj/oxJLyhVTWwB
 TOVKMzkfEj/zjBtVyjGDLhVVvyOEwEWm8BmR+QGOenZxfNi7khsE2wM2Q1entCmi8Gn9SqyS7F1
 FobZVa+aJEx+g0AqXz2Xk+AyDNnnRhox5J1BTZqox83XetutzSyieMArhZewhwaM1LA5AL6n2j3
 uEsG/FE2JRk8ix3Uq91aTE/Y0ux7n+vlu3FsHbSyf6wqLPvflqRgf1eZPooWzcKdpawbvWk5prl
 oy2QkRJE1mmQsLzI/qq9
X-Google-Smtp-Source: AGHT+IEFvlBaAGrXmQ1f53t1gNO9ZXDjgXJ7+Z1T1Y6D6ANh0a3wVCJfUlsp51urZAZYyjm84XXQSg==
X-Received: by 2002:a05:600c:1988:b0:434:9f78:17d2 with SMTP id
 5b1f17b1804b1-434a9df09bfmr91315735e9.29.1732877990325; 
 Fri, 29 Nov 2024 02:59:50 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74f18bsm83023605e9.4.2024.11.29.02.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 02:59:49 -0800 (PST)
Message-ID: <b89c0b9c-e12a-4915-b657-16d9ba297a86@linaro.org>
Date: Fri, 29 Nov 2024 11:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM
 builds
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Shukla, Santosh" <santosh.shukla@amd.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, mtosatti@redhat.com, suravee.suthikulpanit@amd.com
References: <20241113144923.41225-1-phil@philjordan.eu>
 <b772f6e7-e506-4f87-98d1-5cbe59402b2b@redhat.com>
 <ed2246ca-3ede-918c-d18d-f47cf8758d8c@amd.com>
 <CABgObfYhQDmjh4MJOaqeAv0=cFUR=iaoLeSoGYh9iMnjDKM2aA@mail.gmail.com>
 <CAGCz3vtTgo6YdgBxO+5b-W04m3k1WhdiaqH1_ojgj_ywjZmV7A@mail.gmail.com>
 <e9404dd2-56d2-4c6d-81f2-76060c4b4067@linaro.org>
 <CAGCz3vtxjKH0H8BL4ES_phNK8=Dy4Jzg3d7dLyNxuBQaSjTPQA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGCz3vtxjKH0H8BL4ES_phNK8=Dy4Jzg3d7dLyNxuBQaSjTPQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 28/11/24 20:06, Phil Dennis-Jordan wrote:
> On Thu, 28 Nov 2024 at 17:46, Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     On 28/11/24 17:38, Phil Dennis-Jordan wrote:
>      > Paolo, could we please apply either Sairaj and Santosh's fix at
>      > https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/
>     <https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/>
>      >
>     <https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/
>     <https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/>>
>      > or mine to fix this link error? As neither patch has so far been
>     merged,
>      > 9.2.0-rc2 still fails to build on macOS, at least on my local
>     systems.
>      > I'm not sure why CI builds aren't jumping up and down about this,
>     but
>      > neither the Xcode 15.2 nor 16.1 toolchains are happy on macOS
>     14.7/arm64.
> 
>     Just curious, is your build configured with --enable-hvf --enable-tcg?
> 
> 
> It's my understanding that both HVF and TCG are enabled by default when 
> building on macOS - they both show up as "YES" in the ./configure 
> output, and the relevant -accel works; at any rate, specifying them 
> explicitly made no difference with regard to this link error. Your 
> question did however prompt me to dig a little deeper and check which of 
> my test configurations was affected.
> 
> It looks like the critical setting is --enable-debug. I think that 
> changes the exact optimisation level (not -O0 but less aggressive than 
> the default), so it's not unreasonable that this would change the 
> compiler pass(es) for eliminating constant conditional branches.
> 
> So yeah, when I build latest master/staging with --enable-debug on macOS 
> and my --target-list includes x86_64, QEMU fails to link with an 
> undefined symbol error for _kvm_enable_x2apic. This happens on both 
> arm64 and x86-64 hosts, and with various Xcode 15.x and 16.y toolchains.

Indeed:

C compiler for the host machine: clang (clang 16.0.0 "Apple clang 
version 16.0.0 (clang-1600.0.26.4)")
C linker for the host machine: clang ld64 1115.7.3
Host machine cpu family: aarch64
Host machine cpu: aarch64
   Compilation
     host CPU                        : aarch64
     host endianness                 : little
     C compiler                      : clang
     Host C compiler                 : clang
     C++ compiler                    : NO
     Objective-C compiler            : clang
     Rust support                    : NO
     CFLAGS                          : -g -O0
   User defined options
     optimization                    : 0

Undefined symbols for architecture arm64:
   "_kvm_enable_x2apic", referenced from:
       _amdvi_sysbus_realize in hw_i386_amd_iommu.c.o
ld: symbol(s) not found for architecture arm64


> I have to admit I'm personally not a big fan of relying on the optimiser 
> for removing references to these symbols, but restructuring the 
> conditional expression like in Sairaj and Santosh's patch seems to allow 
> even the optimisation level used for debug builds to do it, so I guess I 
> can't argue with the result. :-)

See related commit 9926cf34de5 ("target/i386: Allow elision of 
kvm_enable_x2apic()").


