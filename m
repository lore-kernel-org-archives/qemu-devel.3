Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536C0C5473F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5Tq-0005a0-49; Tue, 27 Aug 2024 19:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TO-0003rz-Pc
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TK-0000vs-Sy
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-204f52fe74dso3055475ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800773; x=1725405573;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Cl5ZRMk7pbT7QMKFwfdbtGEqWg7VKl5rT980Ov9IbY=;
 b=DU4wPHo1CTfZ2dDQxD19WDRvziwcfBmJctdAK66B3miBUIjIPrKlbje5IH1nxRPr11
 jj6EnU8P06rwUb6P4ylfb/x4VxOyEA7wz6U9oxemlXxqyzIiM5zKXrpgk22c7QaOvFsB
 i6MNq6PvvV3cqCxon86OZ4g5ugtMxKHM33hP2lJ+HZD5JP7prpeei51SGoByrq6Q5yQh
 1TyylWh94+KAOws1BgPVs9ad2JRlRtGyFI1ewJJG2vFHei+IZb1mhOAlIA8mzBqHfVtD
 olYndsg37IGS2WewRqtxBDF7jMljf/QwS30BPQ3Zmw5h586D/dK18TO2Yx1YMqvPS/z/
 kc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800773; x=1725405573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Cl5ZRMk7pbT7QMKFwfdbtGEqWg7VKl5rT980Ov9IbY=;
 b=P8d7N8iCVWx1cc6pEZq9XI5w6m+zTD/UIcN2XfQi/Cc3iV4nCNArwituqQfsCBCy3O
 ajJsv2y1VJY5QyWLsK8G4e7FgUnb2jNf1W1QCO+YeeOtkZW48hmhDxP9tZkXe6aPGsNw
 uXJ93EqNj3rnOhALYpWva3RsTYke2hgHre1NPDGNcCIzv8B4No03QZQdhrd3zjm+zqFf
 S3c6/aWDtt53wTZUyxRJsMsSbE03ANsC64iw7vbtPCtM6McCxCgT7UclWs6VlRSlYo2F
 mjEoOHuqe5ULiW4BWazPXSVjVllUVL5TmgMh03fpaP9NmP8CX6oDpYHsikS0b0ZAO4/k
 UaoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/F5QtoL2ixcybm4DC6C8HWpsYw0RHhRoL+dZOhPoLOTYgdc+aWg88fLgbdmo8tNZAta4goMCUbfhF@nongnu.org
X-Gm-Message-State: AOJu0YwdizI6QKI9RPYk29v5YVOxXUW+OdYet2LwxzqiSP4HEQHGXse8
 Myk24aK3FJ3ifC4iNwjbiw2m99dkTrJtM0rSd+KRFp+WKj+ezaiNRaz5xN5f0kU=
X-Google-Smtp-Source: AGHT+IGMyS2xeV4dfpUDYsoQc7eXN0S8sTA7zeAbjMPkh25dCcTm6dNqreFXiKunFNQLfl2XysLoRg==
X-Received: by 2002:a17:902:d504:b0:202:3762:ff88 with SMTP id
 d9443c01a7336-204f9c88ee1mr3937605ad.63.1724800773193; 
 Tue, 27 Aug 2024 16:19:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:32 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v10 18/21] target/riscv: compressed encodings for sspush and
 sspopchk
Date: Tue, 27 Aug 2024 16:19:02 -0700
Message-ID: <20240827231906.553327-19-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


