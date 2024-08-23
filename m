Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AFAC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 19:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shZYM-0005Kr-BY; Fri, 23 Aug 2024 15:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZY9-0004UV-GZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:02:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXx-0004Ph-Vy
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:02:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fee6435a34so17305905ad.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724439724; x=1725044524;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmHRx8s/W32kMwfWaFprt4Qicp4zWaDvYB7fNr0JPCQ=;
 b=pLMeZ0UK9zimijNoUC6mhD/s9KmZkbVTnXFldb0TattgAH7B2QMsVYm77FJjPJns/R
 9I5NifjkpYZ5ZkkgLnvFKtf355KJVE702dxhVk9tD/32G/jGnnyPCwAZQ9GNSMEhxtIU
 qhWtkzM26LxiwNdSrqEVQNdmfv+4DIMRmfUCX+zcPSV33gSRdO9OlE00h7uSpU6dHa8T
 2chIyzFBE8V3/HjYLIVgVRC285iyvE+IdRPk93Yq5Nqq2dojke+PoYJDxTKItdWqnH6o
 FL2siWdDqB4zyFvxuakssiKREd3a3KVmHtcLchj5CChTat+Y1nT1ueRszGdM9heQRWne
 Z5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724439724; x=1725044524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmHRx8s/W32kMwfWaFprt4Qicp4zWaDvYB7fNr0JPCQ=;
 b=Xwld3o+i7XAVNhxCt4Y22caCrHFwkJXhLNHr4wFadvvTE4nOXDFMRxoGYY9DlqvKGR
 BlzItrDYGhzv8IrfrIIqSmTfwoMrCr2DWFn1wS1jExxy8IELcmGmPyii2dxuvvt8jC3J
 VMrLZKlIcksBGkgb6Wz7kFdbhFHKTqBvTmYIT4lgrSM+yA5SFigg+ITtb+APU3F3lOEj
 9Ka+D+qOqMzUr1gd2mXVVnhqUBmSnnZDEPFbMwy/LNV15bep1ql/wtNZfTBl2Vahp2rF
 ZBF2YYweWj495Xl2l914ZtnnGZyuz4eEg8sELYLMHPPNAtFSJ6W903bqNG6uemB/+CRQ
 LQGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5mKCVfSyAjHiJjvWOsSnOPJciYM61iyDTkAH9IWf5YCV4se+vHP++chGA4zNqkS2gSqX/Qe1O1abL@nongnu.org
X-Gm-Message-State: AOJu0YyPzBUACejJUnyIDQDjOmM6jpQhSud7q6+HXeAxj4YuOTvGZ2G5
 6jO5Tt0qPuqo0UJtZYU7virLCjwqAUqW/USyDl/wqLQ+eAs2nojO8YKv5TVVfN4=
X-Google-Smtp-Source: AGHT+IH4+H64A58VOJnjz/h+DMatLBreAlns/omirE0GS7e0w/Zq/9EHKGjlb68DzTIt/PVc+vfoGw==
X-Received: by 2002:a17:902:db03:b0:202:13c9:f8f1 with SMTP id
 d9443c01a7336-2039e486fbbmr30580405ad.27.1724439724451; 
 Fri, 23 Aug 2024 12:02:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0c37768sm1749885ad.230.2024.08.23.12.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:02:04 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v8 15/17] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Fri, 23 Aug 2024 12:01:37 -0700
Message-ID: <20240823190140.4156920-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240823190140.4156920-1-debug@rivosinc.com>
References: <20240823190140.4156920-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x636.google.com
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


