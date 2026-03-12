Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385AA106ACE4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0lqK-0003nh-2L; Thu, 12 Mar 2026 15:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0lqH-0003n5-Vz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:37:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0lqF-0000r4-Px
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:37:09 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso11523875e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773344225; x=1773949025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UctRSirzFG8GXMIPdFfAisXH3galatR9fY1aLQ7GmcM=;
 b=Vj9ofzr84LePWj/meYbeN+KEJ3U1q0JizaVIxniGHMDEOGP377cLCm815dfUPjwsnS
 AdaLlLu7bMCckbf/7FzdRRPih8FYCSCSg0ryz79ca/kztBJvFhcRv0x0R0ZLscWcrEiR
 OanvWt33mVj/WcH4nmYM2C5t9IEjTL2t8bttwAiA8GAqVIGcp1YLRsIWFBLYp5PGw1Ga
 lz0J5ofUm5LJgjy61y/DXvOzDFr2kpVzQR6YnEYrkqTFOEhtzdiDdRGbVtGqPObxPY8k
 1pkFcPLdM0nGVoGlHYyOugJO5RYx0gqSyX8HIE7/l2WrvNSMtu2BggbkxRsZTXxTKtFL
 d85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773344225; x=1773949025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UctRSirzFG8GXMIPdFfAisXH3galatR9fY1aLQ7GmcM=;
 b=DdCL7KTiPilHNtNx72ee9JHCEiLZryNZbqT47Yt/bEHAzkwroxIZVkiwIQByyTXP6X
 Nzu/+b71UGy3REze346iZkPma7Z+iCbN1fVHB82nDAMLQSZ6Jf/KOVnhwbijh+ks3SML
 AVsleLWtSmF3o/wPA7P1lHZcuKLPzpYOMIW5hDtWf7j+7YV1D03FPInStETqoMWUhbfr
 jhOz5Q9ak7dTLxUMvSKfJDlly8cl+oJbrfThKC68P5KTjdMYcoAVywmKOfcnh//2bYX4
 alHLsxafoP6haDOQMUdG30aHwsyIkVcD7SIOetQ52XJDOB1iPtVJauhW+weaT6FkEiAW
 FapQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu8Kuo6mL1VGch8skth9BwNpDu2pliC2mX8lpsHIktDgLk6q4odjpQcsE4Ggxx/B45fI9T6uVtTnvq@nongnu.org
X-Gm-Message-State: AOJu0YzY4B4cakVsoy0aGqlt7ks7VTEl4t5ziHSBbzk2wgs9TcFXXwdV
 vfC/lYdfPyZmQ764p/sxXLixv8/LQio6PK0L9pPKYx6tXeGkvVVNc80FevEtCHbgtDc=
X-Gm-Gg: ATEYQzyJDbG8CZ8kQcgaAZZ0BtLRZJJbqIqsWVFJ6pJLR1EFtPFa86C4TmUmJ2j4Sdv
 q3rRpqnqeOd9kNbQIW54DGT00LOZh119vbdlMZnV0/19q0Q4SjKkIPUe0yTm2VnoIeQr+94wOU4
 r8nDdRfd3Os4XTfKSX1jQK2yEGsmIHgaWW4D6DHGtCIkHEe8Q+Rge86Lw/GNfnhxu7M4nZib8EX
 69+pxxrm5A/NgyzCvcamribqWCiaLtOZemc9MN/5m5MtgT6hkVkan3Tc1oi0ydNHfQ9AxUzOPOj
 dwYrJ6lmQEVi5pkE2cZ8oK5DhCdZZpyK71ojS5yEL4YZFbmeUHVsA6Xxs/ZiFgqbJ5Eo9USA9tL
 ZOuB0jHqbdb5whTjuv2LHS5FKUciaXhhWTp6tJTqP+2gpMiETEeKV0F8SMKOkX9kwoovCtjUUNk
 zQIiMVP4KmEBs/ONYH8nMB+X20IXhsqP1KGuShIj4FewIMerJ4b9VJTWpy6/rRrw9gZTHjrOQvp
 szz
X-Received: by 2002:a05:600c:3553:b0:485:3a27:a961 with SMTP id
 5b1f17b1804b1-4855649fdafmr10254665e9.0.1773344224548; 
 Thu, 12 Mar 2026 12:37:04 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541ad1e4esm254444295e9.8.2026.03.12.12.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 12:37:04 -0700 (PDT)
Message-ID: <80ad84b1-0c4d-45de-93d4-90a471f7f751@linaro.org>
Date: Thu, 12 Mar 2026 20:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
 <bde55593-a51d-421c-bfa5-4a0c774f4b61@linaro.org>
 <CAFEAcA_Qvo86Ek2W7xGQqGP94400c7wx-C0=zpBUF5NoM2jhfQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_Qvo86Ek2W7xGQqGP94400c7wx-C0=zpBUF5NoM2jhfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/3/26 20:30, Peter Maydell wrote:
> On Thu, 12 Mar 2026 at 19:29, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 11/3/26 17:27, Martin Kröning wrote:
>>> These functions are needed to support semihosting on CPUs that support
>>> runtime-configurable endianness. They should not be used in other contexts.
>>
>> Another note is these function are not target-specific, which is great!
>>
>> These can also be used outside of semihosting.
>>
>> Matter of taste I'd have named them using this shorter pattern:
>>
>> cpu_internal_tswap16() -> tswap16_cpu()
> 
> We specifically didn't want to use a name that might tempt
> people to use them -- these are only wanted for the very
> few niche use cases that are outside the CPU but need to
> know information about the CPU's internals, which is basically
> legacy-virtio and semihosting.

This was the missing piece to make qtest target-agnostic:

-- >8 --
diff --git a/system/qtest.c b/system/qtest.c
index cf90cd53adb..392c1394656 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -523,18 +523,15 @@ static void qtest_process_command(CharFrontend 
*chr, gchar **words)
              address_space_write(first_cpu->as, addr, 
MEMTXATTRS_UNSPECIFIED,
                                  &data, 1);
          } else if (words[0][5] == 'w') {
-            uint16_t data = value;
-            tswap16s(&data);
+            uint16_t data = cpu_internal_tswap16(first_cpu, value);
              address_space_write(first_cpu->as, addr, 
MEMTXATTRS_UNSPECIFIED,
                                  &data, 2);
          } else if (words[0][5] == 'l') {
-            uint32_t data = value;
-            tswap32s(&data);
+            uint32_t data = cpu_internal_tswap32(first_cpu, value);
              address_space_write(first_cpu->as, addr, 
MEMTXATTRS_UNSPECIFIED,
                                  &data, 4);
          } else if (words[0][5] == 'q') {
-            uint64_t data = value;
-            tswap64s(&data);
+            uint64_t data = cpu_internal_tswap64(first_cpu, value);
              address_space_write(first_cpu->as, addr, 
MEMTXATTRS_UNSPECIFIED,
                                  &data, 8);
          }
---

QTest is already dubious by always accessing the first CPU AS, so
using the first CPU endianness is good enough for me IMO. (Ideally
QTest would support multiple address-spaces).

