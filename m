Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E14D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8RyB-0002GR-33; Tue, 05 Nov 2024 17:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8Ry9-0002Fg-3f
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:24:13 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8Ry7-0008Nw-Ft
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:24:12 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so174786f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730845449; x=1731450249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=94I02Y4f7BniTFKEka4dEs3ONi01KkFFcGBXeMVUUJk=;
 b=Wbg9KcVlkXzjsVxUrdj2sGc0TZ6kZpZd6stXDZirYYtYsivxwFYtOEqJn3SbE3TzJ3
 kSapL4y9NcLT3mfYrglXXD0/x1KWa0wbfqqRwAc7w5rgGoKdPIvDvn4/YaUjWMCQ34n3
 nSHH2/PiDiKanyKB8vhHDV1n6cCiL+jcLQszxQCNuTyA1lrxZr3///S7kRX13AJOgvVA
 xoe3B30MerPWqNgu9kZZom3FlP72sInrV75O2UeqaVdhF68naR2yDNtkDc+n5PzgvzL2
 r3KJlOHh3c5azd8zoWYZ7k4se/+VrtzWmfqgf34lKaDxZCjCiCl2OUGWzRixeHGWM0de
 PJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730845449; x=1731450249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94I02Y4f7BniTFKEka4dEs3ONi01KkFFcGBXeMVUUJk=;
 b=GvFPVA+hgaO8SAT/Z87gLAawge/xirb+9fl23Dv0qqD0+AGAwtovopf2k/tfnk4v01
 gguqRwyUWSUGqs6N9KpgYmOMPpVI0ite7LdrVBVOJmD4zsh9jiRmqjzMlP/xDuunBnBK
 kXOsqXex8bXAVWm4EkFOsUq7qAjXXIwIRYev5myHMX/LmKWbNcsFdB6UaUd6LncRxnRn
 vqqxFQoMwWYVSb2c6+HqavGjhuV8i/KQNrpDFAE6f1e/+39cOVOUWiPp8pgxTh3WH5Ki
 kWjD8KOmYG7Yk4h6uME+vk/RpRYFaxbITayJZM+OYBzGlCnc0l2TGiabLZGPxNYKSDV9
 Xl5A==
X-Gm-Message-State: AOJu0YzKzBn1XSh1yXEkRbYOXwFq84VPf4KHom2mKrnjpWepQc9uXgXV
 p0/P++bidU/8UOVnKNXv3qBMCn4eJpS/xa67JmwUrGGDYpQ0yDQl5jAsllGPazhW1X4YQyZixe7
 TJe3OYQ==
X-Google-Smtp-Source: AGHT+IFdnqc9nymgzuqXduoroSJaNnxC7yEdzAWeGE78/Vr3zPXrp1Tt+o5MXWat2F7DTemLP4FtEA==
X-Received: by 2002:a5d:5984:0:b0:37c:fbb7:5082 with SMTP id
 ffacd0b85a97d-381e820a2d6mr270070f8f.25.1730845449178; 
 Tue, 05 Nov 2024 14:24:09 -0800 (PST)
Received: from [172.20.143.32] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ae82sm17312217f8f.93.2024.11.05.14.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 14:24:08 -0800 (PST)
Message-ID: <21b166ef-258c-4497-abf2-135022eb4f0e@linaro.org>
Date: Tue, 5 Nov 2024 22:24:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] hw/microblaze: Restrict MemoryRegionOps are
 implemented as 32-bit
To: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-8-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241105130431.22564-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 5/11/24 14:04, Philippe Mathieu-Daudé wrote:
> All these MemoryRegionOps read() and write() handlers are
> implemented expecting 32-bit accesses. Clarify that setting
> .impl.min/max_access_size fields.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/xilinx_uartlite.c | 4 ++++
>   hw/intc/xilinx_intc.c     | 4 ++++
>   hw/net/xilinx_ethlite.c   | 4 ++++
>   hw/timer/xilinx_timer.c   | 4 ++++
>   4 files changed, 16 insertions(+)
> 
> diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
> index a69ad769cc4..892efe81fee 100644
> --- a/hw/char/xilinx_uartlite.c
> +++ b/hw/char/xilinx_uartlite.c
> @@ -170,6 +170,10 @@ static const MemoryRegionOps uart_ops = {
>       .read = uart_read,
>       .write = uart_write,
>       .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
>       .valid = {
>           .min_access_size = 1,
>           .max_access_size = 4,

To have qtests working I need to squash:

-- >8 --
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 3b92fa5d506..6d9291c8ae2 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -57,7 +57,7 @@ static const uint8_t kernel_pls3adsp1800[] = {
      0xb0, 0x00, 0x84, 0x00,                 /* imm   0x8400 */
      0x30, 0x60, 0x00, 0x04,                 /* addik r3,r0,4 */
      0x30, 0x80, 0x00, 0x54,                 /* addik r4,r0,'T' */
-    0xf0, 0x83, 0x00, 0x00,                 /* sbi   r4,r3,0 */
+    0xf8, 0x83, 0x00, 0x00,                 /* swi   r4,r3,0 */
      0xb8, 0x00, 0xff, 0xfc                  /* bri   -4  loop */
  };

@@ -65,7 +65,7 @@ static const uint8_t kernel_plml605[] = {
      0xe0, 0x83, 0x00, 0xb0,                 /* imm   0x83e0 */
      0x00, 0x10, 0x60, 0x30,                 /* addik r3,r0,0x1000 */
      0x54, 0x00, 0x80, 0x30,                 /* addik r4,r0,'T' */
-    0x00, 0x00, 0x83, 0xf0,                 /* sbi   r4,r3,0 */
+    0x00, 0x00, 0x83, 0xf8,                 /* swi   r4,r3,0 */
      0xfc, 0xff, 0x00, 0xb8                  /* bri   -4  loop */
  };
---

to access the uart by 32-bit instead of 8-bit.

