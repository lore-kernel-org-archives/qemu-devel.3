Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD459C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxA-0001ZW-It; Tue, 04 Mar 2025 20:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdx8-0001WH-Aw
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:42 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdx6-0008NF-79
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:41 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223959039f4so69718165ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139617; x=1741744417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dkc5ddvWfoQOqT3KthD041K6FqhmDenBClaITSYqFo=;
 b=AwcjmHB92PBXj9JqSCsblOKwnaxAG0R+MyubUs9M6lWJhhlkxySiKzRNpcu2s80i7M
 +6BDKiRGniBBpG5BArIVP5jXW3V/10Y4HGzkZu7WHee7k7gwMydkeW0tJm3uN3OkVFAN
 NzRBcmnBeHPJDfss7p/5biDKAkVNWgeOLtOX98QxRf7yagjmu78KbNaFzj4mqRxWYs53
 v4VB4geUbm44kebHcKFaLneUaGbiT6pxKOTa6wFFwEDdcHtHy7awh3huODUKL/4xW0cX
 WAFydWOUE4LuxP2G/go+iZasdv0Kr60Pu8IPzYPH7bhGJ/oMNsfH6nFdSKDGoEMSTHyI
 z6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139617; x=1741744417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dkc5ddvWfoQOqT3KthD041K6FqhmDenBClaITSYqFo=;
 b=e4XsvLjjositOOnQLeTdwlXBLhJMbMxe2ridgJL7Z6JRNMfkeaiVIA+LgirfBxD/KG
 mncxTjB7N1TDoiQElzpJ2pt909kG0vw/XV8zrfMk8VB8NAfQp59PWv6HD3cH4TVUtF+i
 KkkBJYWXJ6ycoocl2TewreLRPNbHrU/HcBex2D7zDL51HKxmxE8/tYwHPeQg8CvYSTBS
 HNnHLP09oYVxb2tYQLs+noBvDeHDHAmFDBbKn4F19Z8crVkIeMCls2bWPZiOhf8BxSqr
 K5JiGZDfrikjtVZWTJz1bMF1wqTA11MXMIKwyexQ04qiNgc7h5c2CvsheVDqsUVdfnT9
 D19g==
X-Gm-Message-State: AOJu0YwlxMJ60p5kDsjUcsehdtgQZxpWVP5th1ZWGCbEqb/38NcIagsX
 gLwFn50GbjECjRVE+/CMvmLqTVQGnyhzR5fB4u/gPXrO6HJjbKr95ZxF0+JIbFg=
X-Gm-Gg: ASbGnctOHry9gBV7belN2payMoAIBoDShyw3Evbf66T3ILFKyZp7EsbHbP4ZKOzWzY+
 PYzGyELlZq/dYvHC91g1VMFKkzh4Mw6Z0uzIVBKVCKwoXFymRWH9Ccu3ona+FjCzjEmbnRhMxk7
 U5HH5oDcd3t4ZfevZ7QmRPkdER/+7WzwkoKmu0u1KTxlal0n4RZEto816p339v9Tqt8g60hEfWu
 E/q5kf5lU6E48Q7jYXwaG+DUL2VWHA0quwD/xUq2NiqSsN4z/00eEilDWGmeDl/+VdnysGh0LSi
 b1Qn/Fh7GZSpr6Ej1+q2O/aDxgQd8DPvto4OG1ERf+qjuobnSDVBViMkPCtkTOdBXbnn2hEPS5O
 wi/MxtDo3Isgjt5JRNULOs6uK1FO3FRL0TBEk2LIoIfgJSJ+R2eA=
X-Google-Smtp-Source: AGHT+IGAc5XTNgg4SdVSTWLU9g+8Oqr+s2/3gYgzYQbZ/SE0QyUq8nW7NBPhTb0zGJYKlhY3PyqZ1Q==
X-Received: by 2002:a17:902:cf09:b0:223:5e54:c521 with SMTP id
 d9443c01a7336-223f1b85fabmr18290445ad.0.1741139617125; 
 Tue, 04 Mar 2025 17:53:37 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:36 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/59] target/riscv/debug.c: use wp size = 4 for 32-bit CPUs
Date: Wed,  5 Mar 2025 11:52:16 +1000
Message-ID: <20250305015307.1463560-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

The mcontrol select bit (19) is always zero, meaning our triggers will
always match virtual addresses. In this condition, if the user does not
specify a size for the trigger, the access size defaults to XLEN.

At this moment we're using def_size = 8 regardless of CPU XLEN. Use
def_size = 4 in case we're running 32 bits.

Fixes: 95799e36c1 ("target/riscv: Add initial support for the Sdtrig extension")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250121170626.1992570-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index f6241a80be..9db4048523 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -478,7 +478,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
-    uint32_t size;
+    uint32_t size, def_size;
 
     if (!enabled) {
         return;
@@ -501,7 +501,9 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
             cpu_watchpoint_insert(cs, addr, size, flags,
                                   &env->cpu_watchpoint[index]);
         } else {
-            cpu_watchpoint_insert(cs, addr, 8, flags,
+            def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
+
+            cpu_watchpoint_insert(cs, addr, def_size, flags,
                                   &env->cpu_watchpoint[index]);
         }
     }
-- 
2.48.1


