Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399CDC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9QXl-00047P-RP; Mon, 28 Apr 2025 11:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9QXW-00041U-84
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:37:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1u9QXS-0002NS-5Z
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:37:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso5838635f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745854614; x=1746459414; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OCGJMNCZ/fqqw/GUEMkreeTFhMnnnCHvM4H6nBWrE2k=;
 b=TfQ4vtQMuPyG1OV55cZPgYeJffXxlO/Sxsw5iwfXF4O0AyV1Z/qof7zWo8dfj2H0dj
 Xn1W6YsX7rjtrClN4HtWNzVhYkum1UowCPUxWl3XgqYHpCHSsf0waY59KAUm41cm6vZ6
 Bn3Jpo4cFiHqvlVQzrO15MJGGGZl9VLz4f9wv9oLMI2ZLsu+2kbbZ6J2r450ihNkAxAu
 yya5XYe0KxbggDflaDXKL+bgyH7ch0QEon/g0RmcRLbOa662wHXOYO8wfrotzjPrpNFv
 FmTiEjsi+WPbvwoyhHUEXHocBpDVPKICGpuq+7Pjy4TqAmL9HHlvgTiEAvZqOnOSFe3/
 b08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745854614; x=1746459414;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OCGJMNCZ/fqqw/GUEMkreeTFhMnnnCHvM4H6nBWrE2k=;
 b=luMEwGzEqidJw+SZvrZWdrS3JF9GaMFkPNr1sNwEspwzHyo3M+X4a1mwmZW6pR/tx8
 sOePy7gcTOc6Knp0Tk2OWBRq24SHUjq0lGCaXnN6IkeLAtZ+96r//V5GTz84ujXG6U3W
 hCJs61rKwMOHJ9b1ypynMLGpYBfCteHn3Qkn+wMnAHGMW/obi5W9A+O1OxNaSPrmVDHC
 PRfeiEnGtkCMcUTfU5diXGhRxBBqI35uQTuTHJ7zztWT+z5DYUth90+xkGUFNsL7ma4h
 1kWp7shqpF8GR7uiwgpktMTtxCX+VphYEbNOZPlu52hgO9XBnEcNl6r7D9BxyXLYjrv9
 8oRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXpz6zwaGg02366YtC3gehahp15IM+qKcFbi4xb+YYMdrtjrABa+Sryua66KhWL4WyJEvXPl2cTf5T@nongnu.org
X-Gm-Message-State: AOJu0YzT3pJZgWm6HsgXaa5v74j9OJfPT3pAAyDq8xAgm7gvjnKTDZ+G
 e0Wf85O+2JXKR0hzdziLPDpE/A7QUka/Y2DyjisVt5Y0gvkIwSyPo+88b6ribOo=
X-Gm-Gg: ASbGncswRznZLVVKSs8AzVXxzzjXz8tyjYh7mpQKt7iUoXTmDNmG2kERiWJ0uKG9oi5
 AhNBGj4tjPdHowQ9GSF7rpaHVIvcfTDin6DddF9fC0y6kyxH4ZYyVDM2r3MRl0/ZseV8YehjYpK
 PRmFwHRQiZfdgZz+GynQOqqSWfrQbD+5HyqWKgaVvzTy+qHbjQCc0rRd0W3Q2ha2h3Myw71Xna8
 2acCgA7jOhfJy15OgbLrk5KYPe0mIxB/mkYPhxx6stO8K8iYWHGeSGznlJynF2IOnxi1a23KjxV
 6z9Iy7jt/Qxa9BfQvMlI0CjbCFn+
X-Google-Smtp-Source: AGHT+IGwoQRUG7ti2SoENQDkodAbIuixv4O2EFuC6BJZf2c945ndlNGF+gYMCyCKgGQINYS83AL7Og==
X-Received: by 2002:a05:6000:196e:b0:39a:c9fe:f069 with SMTP id
 ffacd0b85a97d-3a0891abea9mr173740f8f.30.1745854613706; 
 Mon, 28 Apr 2025 08:36:53 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a089debe62sm66650f8f.40.2025.04.28.08.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 08:36:53 -0700 (PDT)
Date: Mon, 28 Apr 2025 17:36:52 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Meng Zhuo <mengzhuo@iscas.ac.cn>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org
Subject: Re: [PATCH] target/riscv: add satp mode for kvm host cpu
Message-ID: <20250428-c071a9089f070c2e6f001d9b@orel>
References: <20250427132557.1589276-1-mengzhuo@iscas.ac.cn>
 <20250428-00fc862d2d2d628ffa4c8547@orel>
 <D9I60P8TG036.2ZHSS9EHW4W8N@ventanamicro.com>
 <20250428-4cb96c7f0226e15a40006dee@orel>
 <D9IB9OMTGUZ7.8UBDDIX7RW0J@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9IB9OMTGUZ7.8UBDDIX7RW0J@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x429.google.com
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

On Mon, Apr 28, 2025 at 03:37:26PM +0200, Radim Krčmář wrote:
> 2025-04-28T14:08:59+02:00, Andrew Jones <ajones@ventanamicro.com>:
> > On Mon, Apr 28, 2025 at 11:30:36AM +0200, Radim Krčmář wrote:
> >> 2025-04-28T09:00:55+02:00, Andrew Jones <ajones@ventanamicro.com>:
> >> > On Sun, Apr 27, 2025 at 09:25:57PM +0800, Meng Zhuo wrote:
> >> >> This patch adds host satp mode while kvm/host cpu satp mode is not
> >> >> set.
> >> >
> >> > Huh, the KVM side[1] was written for this purpose, but it appears we never
> >> > got a QEMU side merged.
> >> >
> >> > [1] commit 2776421e6839 ("RISC-V: KVM: provide UAPI for host SATP mode")
> >> 
> >> KVM satp_mode is the current SATP.mode and I don't think the other
> >> SATP.modes can generally be guessed from the host SATP mode.
> >> 
> >> Can't QEMU use the host capabilities from cpuinfo or something?
> >> 
> >> Do we need to return a bitmask from KVM?
> >> (e.g. WARL all modes in vsatp and return what sticks.)
> >>
> >
> > The widest supported is sufficient because all narrower must also be
> > supported. Linux should be figuring out the widest and capturing that
> > at boot time and we should be returing that info for the KVM satp_mode
> > get-one-reg call.
> 
> Linux has command line overrides for the mode (no4lvl and no5vlv), so
> the active mode in Linux might not be the widest supported by the cpu.
> 
> Let's say Linux decides to use 9 on a host cpu that has 0,8,9,10.
> set_satp_mode_max_supported() will set supported vcpu modes to 0,8,9.
> 
> Should "-cpu host" contain the 10?

If the architecture allows it and the host kernel/KVM is aware of it. If,
OTOH, the boot options / hardware description has hidden the platform's
capabilities from KVM, then it won't know 10 is supported, so it won't
tell the vmm it is and the vmm shouldn't second guess that.

> 
> > If the satp_mode we're currently returning isn't the widest possible,
> > then we should fix that in KVM.
> 
> The numbers are even more complicated... Pasting the values from manual:
> 
>   0      Bare
>   1-7    Reserved for standard use
>   8      Sv39
>   9      Sv48
>   10     Sv57
>   11     Reserved for Sv64
>   12-13  Reserved for standard use
>   14-15  Designated for custom use
> 
> The reserved values make this extra juicy, let's say Linux uses 14 on
> machine that has 0,8,9,14.  QEMU sees 14 and sets the vcpu modes to
> 0,8,9,10 -- it's not even a subset of the host CPU.
> (There might be similar problems even with future standard extensions.)

Currently QEMU won't recognize anything higher than 10 and it knows how
to skip 1-7. If we need to add more standard support (or custom support)
we'll have to modify set_satp_mode_max_supported(). But let's burn that
bridge later. We should probably sanity check the input to that function
with something like the (untested) diff below, though.

Thanks,
drew

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a2c..a9088c7b1770 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -435,10 +435,18 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
 }
 
 static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        uint8_t satp_mode)
+                                        uint8_t satp_mode,
+                                        Error **errp)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
+    int satp_max = rv32 ? VM_1_10_SV32 : VM_1_10_MAX;
+
+    if (satp_mode > satp_max) {
+        error_setg(errp, "satp_mode %s is higher than the supported max %s",
+                   satp_mode_str(satp_max, rv32),
+                   satp_mode_str(satp_max, rv32));
+    }
 
     for (int i = 0; i <= satp_mode; ++i) {
         if (valid_vm[i]) {
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a30317c61781..46d206abba97 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -662,6 +662,7 @@ typedef enum {
 #define VM_1_10_SV48        9
 #define VM_1_10_SV57        10
 #define VM_1_10_SV64        11
+#define VM_1_10_MAX         VM_1_10_SV64
 
 /* Page table entry (PTE) fields */
 #define PTE_V               0x001 /* Valid */

