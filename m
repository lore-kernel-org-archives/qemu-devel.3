Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83BFE77166
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6f-0001NC-0B; Tue, 03 Dec 2024 18:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6a-0001Iz-Oq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:56 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6Z-0001KO-2d
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:14:56 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7253bc4d25eso251940b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267693; x=1733872493;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LdFNd6tBzEDXZhXA50p/zVov//j7cpToaodVCiWJBjM=;
 b=boTPZ/n+V+wzJC2ma9+vfISsqGUDI3VJOvnsfL7Zt3bIz1AbEufsyLA4pNVMU9d7UP
 V8H44/7k9/0S8V96Ix3RQp6/AUc99ysk2qhBl+bQmU3vKs0yN+DMF6JWb2wZbeSWthUv
 JWNFdJ4CCyeJ8rOeFYh3YXmy+c6tOzc2D2JxfQIBGncWtW4Wvs3/fcrMp/3Ox8qkfScI
 HdQXtEnWhlX7ki/s1joo3dSTkt2KKW1GkHr+FavZUfJRvohT/addsF9GyPFyWubFD2Ez
 Dnd5fo7RciGW2sA6h8XTAoasakkmoXGjmsxRccVBQ43Gxf3WUlTPzCLkkz9iNO3UmMov
 vgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267693; x=1733872493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdFNd6tBzEDXZhXA50p/zVov//j7cpToaodVCiWJBjM=;
 b=haJmgbK4mkIxkeqfdLKbq8Qn9Y1PkWSj/JdhjKW9wwVgfdGRPsiYYWkRB3TgNYkuaY
 86UyADllvQegWEsTNk1ug1csnTN1hZPdeClmmTdh/b4hP62nrgyeNoNR5ghs5EQojFTx
 2/yMkfhGqULMGKJ9ApNUhXUXbaAxMTDet0+xGDCSFzuUBzPdQItH2FRwGsFNwX0Fg58Q
 IwjMYmlrVdafu+Pju+bGDJGtynnqcD0PQeTE+ZEC/O4W1kH4gWSf2FRR1hwLbZ7hEAYu
 k728CiAeBhacFM843X4bLnJRCreEUm7CWcFmqw8roRejrPeJdU7RvHdsJbxEnLDQcRgA
 HZKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFK25jroTeTKVlnXOtb+PzJDFUJrrBLTo9n1E6jQ/Tql8gAg+qbmKxpQxt+UBblxVsecgjtGegbxWf@nongnu.org
X-Gm-Message-State: AOJu0YzvIJqHVAQbwXJZRVI6RDLuFrNhLNNTQQr/v6VfGwy23U6HWSLf
 1rqoSRxJ5i9DL3BNBXXKPXrOAd5T/KytuDVeMS9nP1bpJ6xiBTcdvX81x6vgU9o=
X-Gm-Gg: ASbGncsoe/nDmy4Vp1NDVZJBHfOZ2d4AoMmatYnJCEmFW9qPrmWFoI/IyGgt2AIO6Dp
 ZLyMk1m/GlKSvSD3TI0oX7L30sOOFTO82jY7qKG4HtOBo7/AEInl4nDrKiHPAX3dH4NaBLmkVES
 iMH9fEeWkLnYNnqGmyaN6oOTvH4ondeiXMfoLySZOI4ZcdCnlbokeBcwbtsGN0A9q4ssU6xGd3g
 kfrrNbQZhk6/W37SvePKqSvyt2AUxnoFrMjjF64AbCs7xQfoAnJmCI5COA0FmA=
X-Google-Smtp-Source: AGHT+IHWFzPbwlRhVNYMoWlMbaUjvPXySpHxbh7pbKjgJTNcr4HOVgux2X9xxXjmEBOSG9lQwGGeOQ==
X-Received: by 2002:a05:6a00:4651:b0:725:37a4:8827 with SMTP id
 d2e1a72fcca58-7257f8dbeedmr7575973b3a.3.1733267693484; 
 Tue, 03 Dec 2024 15:14:53 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:52 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:45 -0800
Subject: [PATCH v4 07/11] target/riscv: Add select value range check for
 counter delegation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-7-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x435.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds checks in ops performed on xireg and xireg2-xireg6 so that the
counter delegation function will receive a valid xiselect value with the
proper extensions enabled.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 424e9dbbd4ff..0985dbdca76d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2156,6 +2156,11 @@ static bool xiselect_aia_range(target_ulong isel)
            (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
 }
 
+static bool xiselect_cd_range(target_ulong isel)
+{
+    return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2281,6 +2286,17 @@ done:
     return RISCV_EXCP_NONE;
 }
 
+static int rmw_xireg_cd(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    /* TODO: Implement the functionality later */
+    return RISCV_EXCP_NONE;
+}
+
 /*
  * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2292,7 +2308,25 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
                               target_ulong isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
-    return -EINVAL;
+    int ret = -EINVAL;
+    bool virt = csrno == CSR_VSIREG ? true : false;
+
+    if (xiselect_cd_range(isel)) {
+        ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
+    } else {
+        /*
+         * As per the specification, access to unimplented region is undefined
+         * but recommendation is to raise illegal instruction exception.
+         */
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (ret) {
+        return (env->virt_enabled && virt) ?
+               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
 }
 
 static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,

-- 
2.34.1


