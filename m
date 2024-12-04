Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21DDE77176
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIowy-0007zx-Qm; Wed, 04 Dec 2024 07:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIowl-0007z1-HP
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:39 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIowg-0007WZ-R2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:36 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so4467711f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733317053; x=1733921853;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FnTMiXuPkhQQ6QNckrBef68BYhMTfBUPg6gnsrR5Ck=;
 b=0ElfBWAUAgE7f9PZhz7G9CWRXGOH+MlN4ADTz0XBtSHRYFymppJV1T7vDU39acTDmc
 kXncucj8WZTKz+IvCCDK48HOO4JmuYDNgjzY20InUxPlmqEkM+2KC3frENQCkX9i3yLc
 y9HxgT/HRH9z3Zxm7bnl5weesHcp0L5tmELBzF844koXrWe1/CudU5od1+hAcHTD7FQF
 tT8sPePT8ZYfhyxXz2X4f/8aPlBJ9sVCJPOsMIbGB5lj9nsFSvwxlfLmOENnbiwzAC5Z
 9LPc8xdD4RT5MgMOhxqEP9Cv5yRcDWmX31+A76UdHjHXyCG9xhynlTwgVLBoYEx5TQza
 J+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317053; x=1733921853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FnTMiXuPkhQQ6QNckrBef68BYhMTfBUPg6gnsrR5Ck=;
 b=IHTVSQ+ZajQatswHKG2xBQtmSEFYEN/kgAQbQPtHKfjOzR+8LkJX9uS5PzHzsUWThp
 r3p3cs4SnzD4V9yWIQPItjzXKX7Uh+JMhJ0283DzKUn28CDqsKd6EXaLNufr3wGJYsno
 4zc6ELkU9PrHzc/w4A5mDn83UNT5jT79D3hISZDSunhCXCG5yH4HUEhtlA7vY6Ba4lv+
 9zYrBjhHIiofHsRxb64DTLQ0WGW4WCskQHg8YipaKa7d6sDGiyH8XcX4CF7pq+RP4YFX
 Y7fEcAd4k9RoWpWIPAOhSG+N01EVuassdnNPAGL1bZapVDgFBwvVOE9shNZnUW/zdJ/6
 h6TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5aPaiORTHqWdUriZeLye7wrIfr5HGoqanFuH9t4pmFQwTgJw2aBo3MUJbM6DtQ74e9eUIRq++L7WM@nongnu.org
X-Gm-Message-State: AOJu0Yz+xLrztPa89QSKPiF1mnaNpNBclNltMgs8pHPktBRCSphSRbry
 k4NWARsvpRIqIG4zvmXfChrN2POOtXWWbr5P9DAPyPHURLuNR+j1SPkdIh4uLho=
X-Gm-Gg: ASbGncvXxo7gN0NEZ8YeWTAIIndQAxtJ7zEQDYFzTvLSc1NYxlw+Cczke8iKUqP08E9
 sKxStXGSbjNUWyrMR+frtEMZ3lUw24WPTB9QIIuZ453nXS+9oUTnRaR8ZyGVklCtDLE5HwHaMoO
 M+T0mndjN4TRnDA1fl02O7nHLcl9rjB0+GYTQAkpfmek6UVY08aDRKzBTDyIlelg1Zc1UPzMVGv
 4RtHfE/upfL/aUQ9XzdgE94V8kUk0ywS9NVBH53kE4erfGVtt0FOhyT5dytFc7dCQ9X9Uu/zBj2
 I+57DA==
X-Google-Smtp-Source: AGHT+IHXkLFcZy8q0ESesZOdwe4vvvKXPZsJb8jBgsIgEB9bwXOOGSqTey68BE/qrv5v89z2J7N7Ug==
X-Received: by 2002:a05:6000:70d:b0:385:e17a:ce6f with SMTP id
 ffacd0b85a97d-385fd3e9d2fmr6051925f8f.24.1733317053279; 
 Wed, 04 Dec 2024 04:57:33 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385deeb6acdsm15826428f8f.81.2024.12.04.04.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 04:57:33 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com, richard.henderson@linaro.org
Subject: [PATCH v4 1/7] target/riscv: Remove obsolete sfence.vm instruction
Date: Wed,  4 Dec 2024 17:56:39 +0500
Message-Id: <20241204-b4-ctr_upstream_v3-v4-1-d3ce6bef9432@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
References: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
---
 target/riscv/insn32.decode                     | 1 -
 target/riscv/insn_trans/trans_privileged.c.inc | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e9139ec1b9cfdb2dc5029dd28430933a2b4e1442..a2b4c0ddd47ad9464b4b180fb19e6a3b64dbe4e5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -119,7 +119,6 @@ sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
-sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index ecd3b8b2c9e6c698f63c9bd3b3e5758426fcfe63..0bdfa9a0ed3313223ce9032fb24484c3887cddf9 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -127,8 +127,3 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 #endif
     return false;
 }
-
-static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
-{
-    return false;
-}

-- 
2.34.1


