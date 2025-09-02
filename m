Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB459CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 11:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOqm-0002eG-L9; Tue, 02 Sep 2025 07:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOqk-0002dM-P9
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 07:06:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOqi-0005hW-PC
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 07:06:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d75aso987040f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756811210; x=1757416010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7zk+3vYF/hYcCAGPmUgaHP7bMk2Qh+L2T68W99C9Azc=;
 b=G+/k5xnkZLIsn3YiCfBnWOcwtRTFxBRH0oxkUl5ZskeqsWqFn19MUNw6Jwm/vbPfEt
 0NwnaFm6ZdxNbNp7Ubllrwj9ZoJBGfldFxA51HiJ8hBRTYsdOiEEr8tfix5oj82l1ikZ
 uzbf5ZDE+UyRJtINcagxKsucNdKwLr4s8lFuCRSJgoYAXm+iJ3eJr7tp73huKvl8M/io
 fxpEHJRC3ZEXYMJzVpastThLUEtkMcsbH2A2ETP+EeIkruk6oSAUCRc5JpSEei7IL1p+
 ApFTvz5c6CYvJKpYCHjwQ4m3SLTUFsaJbxfwllsBPhFFkvSK9cdNJl0a6xyKtiZD7LQl
 DtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756811210; x=1757416010;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7zk+3vYF/hYcCAGPmUgaHP7bMk2Qh+L2T68W99C9Azc=;
 b=EL2L/kkdpUkwSfIbKv82VEUUaAZjbQKfgoe8y8AJEzPu/VXQAICwr2ECZh4wnFe6mX
 fTne+VIMko7nAOb0Ilq34Fh8Av/jpN3JCO38PIwm17lbZ9/PtZJ6LkNymBTNyepfdl8p
 nc7zzy5lTs0TSxwyHGJCkl2sX5IiYj0ICjewmQmInnqTjOPHdlQ6Bh1t6hXbu8mxZoVK
 zW46qtwieqyFiHg7clc+oY6n4lHYkus/eZu5/2jA6FWmpIkn877bERyDeKPfPaQjoLos
 LRFLl0Wot9vEnpDuePilV82T7iP2w+LOh9RKUpE3fwdOCD5rMkNafolFesuRN8OG9tkg
 ytxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLtsGdCLA8W4MJeNIX23OKTw+vGPWLIBiXAq10nKXkIOp2fuGDvrvA96Rnb5+ID0LLrNmHmHtox7Mk@nongnu.org
X-Gm-Message-State: AOJu0YycxuVBQh1RjjvMspyu8cpaMCzqjH2ldbOMXYm5j7ruX8pIq5XG
 TBIAN2Wxu1dTGvpkXoQ0aykPiWIzhuRjdUKviAfS2KoQYZLm9bNZXPiMC1yVtQF2JNroEs3OHZh
 dYV0b
X-Gm-Gg: ASbGnctVbvX+YI1A2KV+rDs3M0iiJG/fwcBWCNbIEbE/oiy/6nZZtnmCUj58vhfl9X+
 qZlCBvtcwCOeEc2fbTiowSXnTMHhng663nytOFGLp33q+nXvc6We+e4S0UuXB6qZZ5NXw+RSFyG
 rl+LbukLeXP2anR+8raoMpRQTlSANQ11E3ml9nNwKhKvTZKCKN+UuOBj/ApkLRZAKmSiRs/trug
 Y37dyYhjzuoM4H1jKp/+zoRyawi7MBbkLFwdN9WD+ceVNGjw+KjLeLb2VxcozqjN8hJAFrrZ9VK
 /Zerlzm/5taOusl78g1iAKHubh3YeaZFPcaCSXAWCtMV/BnpazndDEL6wlkRo9AifaHe/a20bsT
 cDXWakX7mMQwgMZqCmAx4tyfyubfddY/ajo4Ynk8g5jvfXDkJpmX25Tv743Rq0sN6wA==
X-Google-Smtp-Source: AGHT+IGauHfzYyXrKcns5WyF1qr5BqYmHiCu1/ms5jUCv8Ok8wgb4osaLjHe38AKJGuijIwMOovU7Q==
X-Received: by 2002:a5d:64ee:0:b0:3d1:abf7:e1d3 with SMTP id
 ffacd0b85a97d-3d1b1aef463mr8033018f8f.20.1756811210453; 
 Tue, 02 Sep 2025 04:06:50 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e68c83asm206779905e9.20.2025.09.02.04.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 04:06:49 -0700 (PDT)
Message-ID: <4cbbede6-0846-4b22-9bce-ec0bc9888e2d@linaro.org>
Date: Tue, 2 Sep 2025 13:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
 <aa71d2dc-ebd8-46bf-8693-4e17da3434ef@linaro.org>
Content-Language: en-US
In-Reply-To: <aa71d2dc-ebd8-46bf-8693-4e17da3434ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/9/25 12:44, Philippe Mathieu-Daudé wrote:
> On 20/8/25 14:25, Aditya Gupta wrote:
>> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
>> with --without-default-devices:
>>
>>      $ ./configure --without-default-devices
>>      $ make
>>
>>      [281/283] Linking target qemu-system-ppc64
>>      FAILED: qemu-system-ppc64
>>      cc -m64 @qemu-system-ppc64.rsp
>>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/ 
>> target_ppc_misc_helper.c.o: in function `helper_load_sprd':
>>      .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined 
>> reference to `pnv_chip_find_core'
>>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/ 
>> target_ppc_misc_helper.c.o: in function `helper_store_sprd':
>>      .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined 
>> reference to `pnv_chip_find_core'
>>      collect2: error: ld returned 1 exit status
>>      ...
>>
>> This is since target/ppc/misc_helper.c references PowerNV specific
>> 'pnv_chip_find_core' call.
>>
>> Split the PowerNV specific SPRD code out of the generic PowerPC code, by
>> moving the SPRD code to pnv.c
>>
>> Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>> Note that while moving the code, the 'target_ulong' type for sprc has 
>> been
>> modified to 'uint64_t'.
>>
>> Based on the discussion happened on [1].
>> Requires patch 1 and patch 2 of [1] to be applied, to fix the build.
>>
>> [1]: https://lore.kernel.org/qemu-devel/20250526112346.48744-1- 
>> philmd@linaro.org/
>> ---
>> ---
>>   hw/ppc/pnv.c             | 86 ++++++++++++++++++++++++++++++++++++++++
>>   target/ppc/cpu.h         |  4 ++
>>   target/ppc/misc_helper.c | 59 +++------------------------
>>   3 files changed, 96 insertions(+), 53 deletions(-)
> 
> Patch queued via hw-misc, thanks.

Dropping, as it doesn't pass on CI:

../target/ppc/kvm.c: In function ‘kvmppc_load_htab_chunk’:
../target/ppc/kvm.c:2763:32: error: ‘buf’ undeclared (first use in this 
function)
  2763 |     size_t chunksize = sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
       |                                ^~~
../target/ppc/kvm.c:2763:32: note: each undeclared identifier is 
reported only once for each function it appears in

https://gitlab.com/philmd/qemu/-/jobs/11214983966
https://gitlab.com/philmd/qemu/-/jobs/11214983979

