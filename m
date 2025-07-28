Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DB8C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNzO-0003PA-5R; Mon, 28 Jul 2025 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugNqo-0000OI-E7
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:25:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugNql-0002CJ-75
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:25:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so3773690f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753709103; x=1754313903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4SIfWPYbShImsqT7HrwVgY0YOYtxv8A2n2sHfqFMaLM=;
 b=RCS97ccPf8AQpiWDrymZ4TjmjJG8DLY0iUg5yLcwEapXsXBSj4MM/vy56ht9B17PU2
 cmvdVyaxXW5dHdJlF+N81r1bbR0Yx8FjbcTQUbiJeESHyGvI2w7FYbbxXYeCZLnNO6w+
 PGv4Wn+ftFV9vXdIEW/lA23+UiOyXUvmua9gOD3SHAxfdF3euiI1rf1JeWw0FQ0n17yC
 pJ3dBcmEP4L3DkDXkOj5fmKdadhmnjoeNBN8jcxJ5jZrT3078m36mVNYf6lO5KvgU0oh
 w+qLShFfqI910btB90Z6qGHLuniMwGwTSRGT6VhXYtEKiW+sffgxp8NMSw3/3moG4RAt
 ZkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753709103; x=1754313903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4SIfWPYbShImsqT7HrwVgY0YOYtxv8A2n2sHfqFMaLM=;
 b=YSmiyO+kV5Fp4iKdS/H3Ri49aokYptGdP9DkFpZUmRhgCBgNpnGkRJ036nLv3EWDzi
 lmDwNWAuupqJrU63thdZAa30dJqPlAYrBT/P8eP0OE2ZCbNnYGVWHDxdSKGvVODkHifc
 tsWb9LfTDdZtu8EejGns6wCXhJDnojAqdj8hxN0/Y3T+GGQ1wkfIWU5W+eUmMmDCFyIi
 wEHU6nKmqNfrGi8ZcoTpRUqFnf7nvw9zEvphST1jgFirTWK3GrkGL5IRCpBjGoFSmkd3
 kng1Z3zqaRleAZ6pO7aXlZB79AI+hRzcqwCp9kDewbWgaukyNK663dbzQLMwJZjFM7TP
 otcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULbdCLPe17yiN0Ds9MYO/l8R7nLI/9b913fKGQcitFSP9JZfniA4oSUqiw3jwtkOxmiODbDWEDH38d@nongnu.org
X-Gm-Message-State: AOJu0YwH6XBRJZG+HE26JxQmfl3Zddu4JBF2D3nykkw6B2H5xCxV7vrj
 kjNIyKc0GivCCe8yhx/h++fhMbCwjqcqrzAwgSEiJsHDqiIWndMLwmcigPGTvwdmR/g=
X-Gm-Gg: ASbGncsD5fQHWloRYh+gxEKnNFzS8HZO3dXFOt+tbzxxXvvbYumDt20rBqLroU6i4qf
 IlsQiyHrE/AjggLaP0egwcj0IACR8m4kWcOTqe64ZaKpQw5vgpqTH26F6U14Iv8NpIFQDyOLGRa
 +JcxpGVDO0RmzedOASTy/7u68qL4xtegKxTmVpPxmfA2tw5aVb8AZi3rrKbwwtOPwhhr48K9zog
 ZWXEeXUwasFeEI+8hR6WkAKm1SH4+ybi3ddWVnx+Wxe/LnZ6hfaskXppo4vSDR5lINmg2rZcnXy
 vwQ3GFG0SK58TOYOir9fz3S1tEuHcZ7L1yJuRO3uikMWoluNZNgSAU9xv1RDufidK9+f0vqynwx
 NMobIiQsWKQ8mkcvKs1F0AclQFU2hXMSpR8yohEfSNs3ugV95HcStmskgdVVoMYXlxMOnruOCrb
 cb
X-Google-Smtp-Source: AGHT+IFlBp8rlNK7Bj+3/EiMxH3Bflfvy8LEFfd13yfKvnTmNrh4Miv8S6o1a+zDrQbRNgdSk3KSGw==
X-Received: by 2002:a05:6000:1a88:b0:3b7:664a:8416 with SMTP id
 ffacd0b85a97d-3b7765f4e98mr7465589f8f.23.1753709103031; 
 Mon, 28 Jul 2025 06:25:03 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705d42b0sm154634045e9.33.2025.07.28.06.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 06:25:02 -0700 (PDT)
Message-ID: <43b37539-e4eb-465c-85e8-b7c83324910f@linaro.org>
Date: Mon, 28 Jul 2025 15:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/malta: Silence warning from ubsan
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
References: <20250728115152.187728-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728115152.187728-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Thomas,

On 28/7/25 13:51, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When compiling QEMU with --enable-ubsan there is a undefined behavior
> warning when using the malta machine:
> 
>   hw/mips/malta.c:1200:32: runtime error: addition of unsigned offset
>    to 0x7fb620600000 overflowed to 0x7fb6205fffff
>   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior hw/mips/malta.c:1200:32
> 
> To fix the issue, check the bios_size whether we really loaded the
> firmware before trying to byte-swap the instructions here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/mips/malta.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
> index cbdbb210568..47dd4016cfd 100644
> --- a/hw/mips/malta.c
> +++ b/hw/mips/malta.c
> @@ -1190,7 +1190,7 @@ void mips_malta_init(MachineState *machine)
>            * In little endian mode the 32bit words in the bios are swapped,
>            * a neat trick which allows bi-endian firmware.
>            */
> -        if (!TARGET_BIG_ENDIAN) {
> +        if (!TARGET_BIG_ENDIAN && bios_size > 0) {
>               uint32_t *end, *addr;
>               const size_t swapsize = MIN(bios_size, 0x3e0000);
>               addr = rom_ptr(FLASH_ADDRESS, swapsize);

What about:

-- >8 --
@@ -1180,7 +1180,7 @@ void mips_malta_init(MachineState *machine)
              } else {
                  bios_size = -1;
              }
-            if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
+            if ((bios_size <= 0 || bios_size > BIOS_SIZE) &&
                  machine->firmware && !qtest_enabled()) {
                  error_report("Could not load MIPS bios '%s'", 
machine->firmware);
                  exit(1);
---

?

