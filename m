Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6253C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh38P-0005oN-TU; Thu, 22 Aug 2024 04:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38N-0005d5-Ex
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:31 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38H-00060t-EL
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2025031eb60so4254295ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724315124; x=1724919924;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmHRx8s/W32kMwfWaFprt4Qicp4zWaDvYB7fNr0JPCQ=;
 b=qml+6U4lfTcM8mRJka4VONrU2uL4w92s3MX4RJSL/9tvk/SP48GIj/Np7G8yP31fth
 rtK+fVScMmswuWHzdl4vPQIbwN1+v5+XFPP3nKVAZe8vi/KZ+u2/8mY0koVEkwlq7bBB
 l1xPfJY+IrRuFWusdKia4iO/HchcE0PCIVf3dhkVUPT9aU3UVXFxEx4nJk63PGgQ6U+W
 or87SYrTpyka8h9jWfu9bRo3yIoUHf4xeEQzzkDyCF1BVxilDgAuBwf34lOrxuqZZ1EV
 BmdKz0gIPsMgMAr1iCnOc3UZSAd9TgboWQFOFkC7VQReVQFr8eRcnedJuLAoJDUuF3dw
 gohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724315124; x=1724919924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmHRx8s/W32kMwfWaFprt4Qicp4zWaDvYB7fNr0JPCQ=;
 b=apnSg7itMiQZE6R72iHCPa9aa8RyjUksCDVrNlRxx0FWI4JB7cjJmb5nYGwRs6he9J
 DxluSpCkvIfxAKzaMn3aG3U1lHWqVsTLfCe/BVeizd3BSczrwDBhoh0Kx9lBaR8gk3fF
 5ZV8ZsnL83+aXiyoPUeoVA8A6kKbFvdsM2FI7dvk9JVGuVm3YUNZtCTpuJT8mVkCFzVm
 r6Xx1AzjbtxbrMH79pkQBro0zrJ8l7WjBbTA9dMDVikRNrQXv1q6Q9ToHKFkA63QRsv1
 pSfjhZlGp3YLf1ZOSFOpvOg/dvT6asQNbIzjPawK51nHti4gc8mJ3+P7XMW7CnZYuE2X
 Ms3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVixrzX5MoFEkPrpm9HlhvsQiJZc7gQL/+6Bmxb0NQy4BhJiFrOc/iADVkgGt3Dmp0ovwHWL7LqZRxB@nongnu.org
X-Gm-Message-State: AOJu0YyGvLqQaQUxGZglgrwilfvSHvtjv0R2/SnwOtv/0k1KyOYgOElk
 yzZh6T/4iBl5TjNalH2FM8Wj7Wrr5LfulnTbzgIK6vpuzFYgYYWTeZ7UkvyXmsQ=
X-Google-Smtp-Source: AGHT+IE79r6LjBMfdaCpJHU7bX+MueZQ0Km3HfYxfrUMKCJ6YDIxRbHW01+kFJYD9FeUvKyb3BjtMA==
X-Received: by 2002:a17:903:2288:b0:200:ac2c:6785 with SMTP id
 d9443c01a7336-20367af1b67mr65987285ad.3.1724315124039; 
 Thu, 22 Aug 2024 01:25:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385589225sm7641295ad.115.2024.08.22.01.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 01:25:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v7 15/17] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Thu, 22 Aug 2024 01:25:01 -0700
Message-ID: <20240822082504.3979610-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240822082504.3979610-1-debug@rivosinc.com>
References: <20240822082504.3979610-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

sspush/sspopchk have compressed encodings carved out of zcmops.
compressed sspush is designated as c.mop.1 while compressed sspopchk
is designated as c.mop.5.

Note that c.sspush x1 exists while c.sspush x5 doesn't. Similarly
c.sspopchk x5 exists while c.sspopchk x1 doesn't.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/insn16.decode | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 3953bcf82d..bf893d1c2e 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,10 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  # c.sspush x1 carving out of zcmops
+  sspush          011 0  00001  00000 01 &r2_s rs2=1 rs1=0
+  # c.sspopchk x5 carving out of zcmops
+  sspopchk        011 0  00101  00000 01 &r2 rs1=5 rd=0
   c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
-- 
2.44.0


