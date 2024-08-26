Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5522C5472E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sibgN-0002VO-Av; Mon, 26 Aug 2024 11:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sibfu-0000hl-Gx
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:30:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sibfq-0003gD-Lw
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:30:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-714226888dfso3999304b3a.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724686229; x=1725291029;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmHRx8s/W32kMwfWaFprt4Qicp4zWaDvYB7fNr0JPCQ=;
 b=QDcE22P6ZrhG3aLZMADRlECD5YxSfFnV1cu/xm4yquqygzTSH1zCG5GUr0Vcho3jR1
 O7ODshj2aespQY2Lc/59Hs+YJZSAWCSCCBtZ3rIMzkN5YvE7i48KYGctav4BEJZQP3Dc
 KGCxSw79bsusHGf1473w4Gas29Sj/Ya+EN7a9i14lMSHUiLPS87KaSc3HtEaTBuRgyXL
 9kcM6p9gP1LzhO64ahVVtZItFt1ikB22y4vwCq6Tld/FDItQPOrFWzeqEy/2FZNlrQfv
 Ww41VMI4nn0G400rd3/AyeOtR4ZWNUDKYp6Ir97y1XA+N+X8d2BtKGdRNqwXRWcSGsP+
 tieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724686229; x=1725291029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmHRx8s/W32kMwfWaFprt4Qicp4zWaDvYB7fNr0JPCQ=;
 b=iCaCcOzAv7KjfRYbGKBKHkqagYforZ5J1i7tfdRzzpGHD4iLBMpIBs20oNLbHxywcL
 GjdnHoXmARJFA0wQDcPNGXgL32DkLQSRUeNRKV4eWyVCk9CTdiTXW3QrtLmYYqes/5gx
 2gzwxVZJjfhqUhxy7WbNEiseCHItBNd0hAW3KNLDAH959GulsPTDje1HE0K/USZS2dyV
 3aZmi00oCreaD83xSOPcGL13/hEjJ3KQA4cDFV7gW1oEZaep8lDYfqz7wWb/Zg463PVK
 rfbKcTDG4sVKFMKj25RGH9diJJHREtg/hDV29VOgvdR3h9CFG3L5ghMt4sONYEqz+8sm
 lL4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVajq57MwioQvT05EOBlYIKfO9/Ff6M6iY+M1FZI0ZxRFpcG+QS5C1xhGuRDv1XI3p01ZwMe4IA+yDB@nongnu.org
X-Gm-Message-State: AOJu0YxfRKKEAGh+6KLdWgGAZBzaEnuj4ZIUtwy5dL6fPveWmkClFUZT
 TrlHd5l3EbvX341U0jgsyeG+Fqxi5Y+02+Y53jVmH7vr6V6QytdGKGcIKeTubss=
X-Google-Smtp-Source: AGHT+IHvS+jW3nPSNvl5yWY07+f8UFZBD+qNzPtfGzfVQ6lIKEqeYP7hpy4D/uY5Ak31I+PcF4Wy6w==
X-Received: by 2002:a05:6a20:c909:b0:1c6:ae03:670b with SMTP id
 adf61e73a8af0-1cc89d29dadmr13222715637.9.1724686229058; 
 Mon, 26 Aug 2024 08:30:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422eaabsm7396525b3a.12.2024.08.26.08.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:30:28 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v9 15/17] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Mon, 26 Aug 2024 08:29:47 -0700
Message-ID: <20240826152949.294506-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826152949.294506-1-debug@rivosinc.com>
References: <20240826152949.294506-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x432.google.com
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


