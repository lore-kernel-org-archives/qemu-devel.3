Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926E6C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJGsw-0002tK-Pj; Sun, 25 May 2025 15:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJGsu-0002sn-SP
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:19:48 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJGss-0006Uq-Vp
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:19:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso17691665e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 12:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748200784; x=1748805584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A5pBbL8dr6vYLY+VVJEcdZ86HtYRJX2M2/J3dHD5Hls=;
 b=ke/JkUSiKkbV2fdUmidxGF3vQgV9cyu7wHYe1Jf8BvPpJZCmRqi4siMlgVMuhuerS2
 1R7pWMhucq3V6ooP3uJz4c9VSMQgdCmZ9bqiCcibdQ7Jw6+UcnGPBxvv0vOBth2X4czH
 jb0vgXewXhJUcjAe9QKrossL1ddCNll+UlKPbBPVbgssFa5biMfoaqwkyntJO6YjCBEo
 oIViT70D/lQ6PbmjI8W3ROKlgiHFJrNPrFkTqwW8ANqcpjW5tjoEpsYs+T1PdrAOBgMf
 BoNDsAwSWgFAJdXhNLiDjF48yFfyeqAwHkvmfnbxkRVyZA4Y9LKO7LCr01OjgLUiDSpk
 7tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748200784; x=1748805584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5pBbL8dr6vYLY+VVJEcdZ86HtYRJX2M2/J3dHD5Hls=;
 b=me7XsIGHqN0Zx3lTWPAdZcXrj7qdkeNQNBCF++q/7A0oan/YFBaa0HLxo8mbo9pUv2
 BLozMB/LzneHUdTY2QtpExErZikP7Su5UxB2vXAGJnc7fGp31+Tr6heGWkcerXLKi7N7
 d0gvVEO5dzHPwWoGM64XucQ3Z0pPjYYC/DytsBPDARbafbZDIeWdxMHNTMwKWxwul3Ex
 klTgYU6UBKzlb2nM7N1zpDKZbGJBHFCWUFzJHwaX/yN71c+JcMQmIkAeaSMu41/UGtgA
 o9RdJwlxt78JoBWj3uEDam6Mn7Br/IDOoB9cfFj2p9UC+GrHe5fPTqpaUsFRksGqBxX2
 /m3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeVUYbj9wcpnlv0M2hnLbwRcIDNfSyNSumHh2UIbyev7fTDueyA0NU27NQD4jt+av3BLXLNrsgrOO8@nongnu.org
X-Gm-Message-State: AOJu0YwPTNBWqhD7XRHSuh6d9FHgSrfKyprcQRXkVUuLz5G1fURZmCEa
 dmr+CDCZVK+5sGvbBuJrx+BZMJeBfXXAf8xcxI5NBwEOyTYSWSYy0k0YIBJloQwvepI=
X-Gm-Gg: ASbGnct5wJeS5rIm/bNVbfnX1D5dcRydUj4KX4TlIBJzuUqgaOXgE86yu1AmW3ASOuh
 yi0zcmjigQ+6NrSoQ6BxZ1BxN+sYOrb19ltEA5RSZf8Y0+1KqsXNBUAwpaK48kNFoaQdrOgYnnI
 kOp2H+kqGrzkAa3Tqk8HMmcVB+V6bdTMy+Aq52a9IUawTeKVVO6K0qKg8dlDQhaWIiqZPH8IF/g
 A28B/Pu/NslDEuqh9/SF5rC7NgKlwp+ULobS+K4/kfeerqlb+WjzU6tyTQ6C9xnjCEtDo/mcm4f
 E4qA4trGvBN+Ws3OaC21z3+SKRYvsAbnqtZs5JJiQNcRK/337QpoEIoRrGMA4jSOMxr84PZdOns
 nl2cHfBDkC7ygjAlXHZy8POGA
X-Google-Smtp-Source: AGHT+IHWUvmTKmC81RyNFte6SwhTdy4+lG3s0pSGn682MEOorA2nRHZx6+TOMVz3y0mDjiFdb3XLYQ==
X-Received: by 2002:a05:6000:18a2:b0:3a3:5ae4:6e9e with SMTP id
 ffacd0b85a97d-3a4cb4613admr5624560f8f.1.1748200784164; 
 Sun, 25 May 2025 12:19:44 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d1ed8740sm3328334f8f.83.2025.05.25.12.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 12:19:43 -0700 (PDT)
Message-ID: <d03581a8-412d-4e3c-adc8-68a94aefd189@linaro.org>
Date: Sun, 25 May 2025 21:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/microblaze: Remove the big-endian variants of
 ml605 and xlnx-zynqmp-pmu
To: Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-4-thuth@redhat.com>
 <d5dbb421-83bc-4ac9-9a88-953ec0f97735@linaro.org>
 <9b75c7a1-b9c1-47cf-b421-0779fad23e5a@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9b75c7a1-b9c1-47cf-b421-0779fad23e5a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 16/5/25 16:06, Thomas Huth wrote:
> On 16/05/2025 17.00, Philippe Mathieu-Daudé wrote:
>> On 15/5/25 15:20, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> Both machines were added with little-endian in mind only (the
>>> "endianness" CPU property was hard-wired to "true", see commits
>>> 133d23b3ad1 and a88bbb006a52), so the variants that showed up
>>> on the big endian target likely never worked. We deprecated these
>>> non-working machine variants two releases ago, and so far nobody
>>> complained, so it should be fine now to disable them. Hard-wire
>>> the machines to little endian now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   docs/about/deprecated.rst           |  6 ------
>>>   docs/about/removed-features.rst     |  9 +++++++++
>>>   hw/microblaze/petalogix_ml605_mmu.c | 15 ++++-----------
>>>   hw/microblaze/xlnx-zynqmp-pmu.c     |  7 +------
>>>   4 files changed, 14 insertions(+), 23 deletions(-)
>>
>> \o/
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks!
> 
>> I won't be able to look at the rest of this series until in 10 days,
>> feel free to merge if necessary.
> 
> Maybe you could at least provide a quick comment on the idea of 
> controlling the endianness of the s3adsp1800 machine via a machine 
> property? (since your original idea was to do it via different machine 
> names instead ... does the property sound acceptable to you?)

IIRC my goal was to remove TARGET_BIG_ENDIAN from hw/, but I was
aiming for heterogeneous binary, trying to not introduce any changes
for users. Now we are only considering "single binary" and we have
the TargetInfo API, so things are simpler.

Using the TargetInfo API, that would be:

-- >8 --
@@ -26,7 +26,8 @@
  #include "qemu/osdep.h"
  #include "qemu/units.h"
  #include "qapi/error.h"
+#include "qemu/target-info.h"
  #include "hw/sysbus.h"
  #include "net/net.h"
  #include "hw/block/flash.h"
@@ -71,13 +83,16 @@ petalogix_s3adsp1800_init(MachineState *machine)
      MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
      qemu_irq irq[32];
      MemoryRegion *sysmem = get_system_memory();
-    EndianMode endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG
-                                              : ENDIAN_MODE_LITTLE;
+    EndianMode endianness = psms->endianness;
+
+    if (endianness == ENDIAN_MODE_UNSPECIFIED) {
+        endianness = target_endian_mode();
+    }

---

(NB target_endian_mode is not on the list yet)

