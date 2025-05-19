Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04995C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrtz-0003cD-5E; Mon, 19 May 2025 00:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnw-0006gp-Va; Mon, 19 May 2025 00:08:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnv-0004Ff-6C; Mon, 19 May 2025 00:08:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e033a3a07so38420355ad.0; 
 Sun, 18 May 2025 21:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627721; x=1748232521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k370jVb1ghYD8wRe4THt85sChP4fM4b7xFJCBveO8zY=;
 b=fT14XRzQdLQyw9Naz4c0GOxUzdhzGubETEbNMlsynKs8FkeinnLBDB8vAh6hkgWNJs
 JdeEK2HGLbSzdZ/9gMc8JM1lx20x/bBkwsdTHdWhRHxlLQfrAo+RAjvHfWYkmtSwMUiC
 96+0DmoNYsxuPXyWgj0WNVkmJBIdneOvuNT0fyOVLzkO7fjpwdNnobytZpafo0bmDwOb
 TpGU8GllEApg1jIK9aEBptMidianjhu711F+vaqQB+XNtqb0HnUCwPL1+R3vR9a/YM5d
 kACyS7QAk/iIdAtLjDTO8xggUk/yVFLn+eVJCPYKlXWXB7tCDUWGJIq6Jn8CpxWGCXNr
 3MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627721; x=1748232521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k370jVb1ghYD8wRe4THt85sChP4fM4b7xFJCBveO8zY=;
 b=OBfQihcxM/fnWEAfT1G0aqJnMTUVBsajM4WPHgLUxrMlSod3pP8DgQ+kHFRqPH2zf+
 aI4hYx2b+45sGwho3B/TJyoCWlqtpmvnN+RJNfEVNupxqnD8Seg4M85HfaKA6MoQ9xD+
 ijCPbC1TXQelOY2g8wheL+MmvU6zaKQnisP0My/SY6bJj0UTP4GhvLMpEfSPYuQcKFwn
 LkgB8IfEkmsppasBurpVJR1hFCu6HjKMcjG5D8su8KmfZ+lMSgE1f3fSb27HNmUdZWew
 fZNXOEMLL+GihAT6F+XBCn/lJRQ+T45hauv/KneMc51GiJMfDxdJj5hdLoWdZ0p9s3tq
 bIFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQcY/fTFc2Hu8v9UhNObotnvU1QLQ9MFYz0FJaj8SZQBf81jFzFE/U7ZtKEXwgfXyBROkbzZlauCkgjQ==@nongnu.org
X-Gm-Message-State: AOJu0YyxVkX5kPVEDGzsZnjw8Ra4BolQ7SP++qtLcacVwt38PJiqy1mr
 inAEkurU2QYAF+qkswwFsfmFOzzRPlOMyya26erH1U8WmWOulkeO2qzQyCfRAQ==
X-Gm-Gg: ASbGnctp4zmhc/7gpLYhDcXuXzUNdyBfLaIuQgeL7dH0nXeGzzDt3US9MS42IsqxO6s
 3VtqICD2Evwj5JBQMTmuM+A3UQo0fLNXvgG6QrX0QjSa6ex08a3qMeVvuWnRly4c550tPQG9Uur
 kLNf5F5pYfQF9Gni8+cnp9Me0aFcaAoX+voNoc0kIAfiiTNd7usxnKSJ3Bk4W3UahR+TlPnxVIF
 Pry7Xoxn3PvJN+RqrsGVYJwJ7h6oiOPC0AKVaXjc2WZTY5XzEJP2b7TEGzTXug7Pe0eBJo/3K3a
 MWv5luTEFelfJGFVOUfvfLh9k+oaTK10saELD97TC7QShg2HKOLyEVyQrzqsr8/Zhu8TyJkcSRC
 sFo5mauj7XxD0QZlkQ3JqoKasVS6fODqmyHtZj3A+MbfRMjrm0YvmVjoY
X-Google-Smtp-Source: AGHT+IEuVhGAj13/pN41u6qhci19IqI2oHyY1paqsA8+80oAPhkZ6bqbkZ1Wv5Qu1IcKMTmjHwb0dw==
X-Received: by 2002:a17:903:2ec8:b0:224:1943:c65 with SMTP id
 d9443c01a7336-231d44e64e6mr163563695ad.14.1747627720835; 
 Sun, 18 May 2025 21:08:40 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 29/56] target/riscv: Fix the rvv reserved encoding of unmasked
 instructions
Date: Mon, 19 May 2025 14:05:26 +1000
Message-ID: <20250519040555.3797167-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Max Chou <max.chou@sifive.com>

According to the v spec, the encodings of vcomoress.vm and vector
mask-register logical instructions with vm=0 are reserved.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-11-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn32.decode | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6d1a13c826..cd23b1f3a9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -703,14 +703,14 @@ vfredmax_vs     000111 . ..... ..... 001 ..... 1010111 @r_vm
 # Vector widening ordered and unordered float reduction sum
 vfwredusum_vs   110001 . ..... ..... 001 ..... 1010111 @r_vm
 vfwredosum_vs   110011 . ..... ..... 001 ..... 1010111 @r_vm
-vmand_mm        011001 - ..... ..... 010 ..... 1010111 @r
-vmnand_mm       011101 - ..... ..... 010 ..... 1010111 @r
-vmandn_mm       011000 - ..... ..... 010 ..... 1010111 @r
-vmxor_mm        011011 - ..... ..... 010 ..... 1010111 @r
-vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
-vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
-vmorn_mm        011100 - ..... ..... 010 ..... 1010111 @r
-vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
+vmand_mm        011001 1 ..... ..... 010 ..... 1010111 @r
+vmnand_mm       011101 1 ..... ..... 010 ..... 1010111 @r
+vmandn_mm       011000 1 ..... ..... 010 ..... 1010111 @r
+vmxor_mm        011011 1 ..... ..... 010 ..... 1010111 @r
+vmor_mm         011010 1 ..... ..... 010 ..... 1010111 @r
+vmnor_mm        011110 1 ..... ..... 010 ..... 1010111 @r
+vmorn_mm        011100 1 ..... ..... 010 ..... 1010111 @r
+vmxnor_mm       011111 1 ..... ..... 010 ..... 1010111 @r
 vcpop_m         010000 . ..... 10000 010 ..... 1010111 @r2_vm
 vfirst_m        010000 . ..... 10001 010 ..... 1010111 @r2_vm
 vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
@@ -732,7 +732,7 @@ vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
 vrgatherei16_vv 001110 . ..... ..... 000 ..... 1010111 @r_vm
 vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
 vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
-vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
+vcompress_vm    010111 1 ..... ..... 010 ..... 1010111 @r
 vmv1r_v         100111 1 ..... 00000 011 ..... 1010111 @r2rd
 vmv2r_v         100111 1 ..... 00001 011 ..... 1010111 @r2rd
 vmv4r_v         100111 1 ..... 00011 011 ..... 1010111 @r2rd
-- 
2.49.0


