Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED059E7718C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2bt-00069M-AI; Wed, 18 Dec 2024 17:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZR-0003Go-8t
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:11 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZP-0003Gi-R1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:09 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21661be2c2dso1518125ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561066; x=1735165866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q96eOcWLcysQ07uIP/ggdqasxYbE2mH1LAUugO2htPo=;
 b=GHJw9qwohTmWteVzks9TwQofFJaFMFd6FQxwa7+kmJR1rgkMwzjrL3JLwfApCzcmlV
 ZeWzifXHBWczJuMA2MylnNuEK7D89VJ4jF0APE/PQv1MvecnFxM7pgnXa/JXItBCewie
 tSt8Z37Az4V8QW98x/HSrz114clGOD59AM6MGpBiSXovKkipr0+ThHNU/w3HO1QLn/VP
 eeFNQFKzTsQmKH6n+1vWF4i2rEEELe7ZjpBqT3zj35gYJ/I/4gIx86ufRSmMbvDNTUF5
 GqT9XppkUobQWXHKlGNuqHkzPZU3dnfkGWp6wvGCo8cnSgAFCZEag7+5vqJqIRl1RzKX
 6V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561066; x=1735165866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q96eOcWLcysQ07uIP/ggdqasxYbE2mH1LAUugO2htPo=;
 b=M2UcELByxxoD8Sh+Bq+iyF3GG/P6RC7Ebdbo88BdMhQjjZ/kFbFnkgudDgl6B6tWQY
 NDWb3+wioMUdQQYkGnwkOMB242zhwQfqebBZCA5Kw4mjciyt0HyYUhOKsuh4gcrQ7Rzg
 2PkU7/qr5gmc83u89VTuaeekYcVmeB+6xYD5iuW4BYCP4HEJHRu6C/1wF6QSnwvrIu9E
 WS4RfeosuBv/LR/yUbxVovJbCfY0Za/8K1ZpIrD1Qpq9Uv6HwCV34rk/o3Z3RZDejFaX
 vcTyjw4RbNnIJavao+Btv0LaJaOSIAV9kCmZNbkqgm0IGr/bWdEE2vUmJ23h08f6Akpg
 AS8A==
X-Gm-Message-State: AOJu0Yz8AlM3PRiHwQCPxaDCDOtMz3423jeQzyICtRjy0y3iGl08e/sN
 0kKrxjTHi/U80vpHlh63UnMc7BDAH69usqIOiK1cCV3AagZ0U2ZyvMWeG+Dd
X-Gm-Gg: ASbGncuSZZR7+9VRtsCEfJzI5rr/nKAG+yUxi/AS4/eOQo5pmqcH1bNZY4l0T2zWX8r
 moTGJixJc7wopKEr3zMmgzm0hOnT/F3RIag1nhbdQsQ6/IslAd/r2kBkPQ/7ORVqjDCzO0RAPWO
 bOhnTmvkW5Vu7N8KpdjlHrEq5NZshKco4ix/tv+JFO+qsdtLw/couI9Yyfgj188Te+mH5VKZ7r2
 r6bxEkPC+oKqBZwsRgCcGeb3OZnRi52DPzzSQBUbgD3/SBJviPX45DI3cHMhZH0vXX4+AdSryzE
 qZ9/ITROxZ/alDJlGBysQ9zN+iTvFmPRd6opEXRe48qBpZ6hpQ7073DYyhjt6L4=
X-Google-Smtp-Source: AGHT+IGOFqzCh6UwAdZ+Yt8PsBJUjNlohB45SVF3HRATGGzLIyAowl5VGMAHf3Fnpwmb29exOYnU7A==
X-Received: by 2002:a17:902:fc8e:b0:216:282d:c692 with SMTP id
 d9443c01a7336-219d9652b51mr21243285ad.34.1734561066128; 
 Wed, 18 Dec 2024 14:31:06 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/39] target/riscv/kvm: remove irqchip_split() restriction
Date: Thu, 19 Dec 2024 08:29:47 +1000
Message-ID: <20241218223010.1931245-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Remove the 'irqchip_split()' restriction in kvm_arch_init() now that
we have support for "-accel kvm,kernel-irqchip=split".

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a9680f2447..aaff4a0f42 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1408,11 +1408,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
 int kvm_arch_irqchip_create(KVMState *s)
 {
-    if (kvm_kernel_irqchip_split()) {
-        error_report("-machine kernel_irqchip=split is not supported on RISC-V.");
-        exit(1);
-    }
-
     /*
      * We can create the VAIA using the newer device control API.
      */
-- 
2.47.1


