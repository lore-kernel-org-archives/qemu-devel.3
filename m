Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC6CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJK-00029l-En; Tue, 14 Oct 2025 16:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJI-000288-KD
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:52 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIw-0005LE-1b
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:51 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso5041148a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472447; x=1761077247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zpu5IRwfe4YrqdXSS+oOpwx/X0g7xDWsnfW1zvfAS8=;
 b=c+5fZxKUo6d/b1gM8bWbxe6XEFf1w6mezipRTbOhDI9zESVst0cn27/TlDWg85vcDm
 aTNyzsP+wPyCZfBEK1MfV5KIEmnobzPhon/AowUzV+psaO0L42WHyj5ZjHdDFL11TVAw
 vHi1puRhPyDUy8x9VcWAzmSxA7X/z1i0E7kbdWE5NbVEkPRluoWSYQGSqoan1EIWBJk8
 qm1MkC9KVK5YptB53ty3FOTJfhnN0MBe64YuAse99k0kM9Kzj3htYLvfd+hbLhGrMo/o
 Gm9FBwkq2QxdmvtEDygsDyceDVXbDhdAurJsgEcaQdCr/7MZbqkRlI8dc6U8iyqK/PQp
 /dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472447; x=1761077247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zpu5IRwfe4YrqdXSS+oOpwx/X0g7xDWsnfW1zvfAS8=;
 b=GiJgf10HvrrmUhhcrhkWIpmWGqCN/gqqdkdRvJdURW7M220mNR0PcBJkBd0XJ8CVzK
 7hiL54oyik43xjOlcdJKl+lKpE0BhdyeeTB2PiLwPGx4/IK0bcIMdlRfN+9/SmVBEgUC
 DsY7n5kZhTpzoYDNPiWzOLoqbX2GOL7PeHC2SU4GOFeCI9TbPkrdqRCV9d6Cxo5EU+BL
 OszeACrUYXRTkr6+Ggd+2oKhnbFF/wZfTp5UvxE2ffJ5cRMz5I4iE3VJE3fd793GKAHr
 BVuDdNOzHCjWt0HKM9jhZ4JJb8HDkNC5vfP/OMRNFOo4Ck/smgFuTiKYXIlURxdSXV5i
 2iJQ==
X-Gm-Message-State: AOJu0YzjYLmcHmzZIFcjUygCpZ/whDXay+VDdqfyBOIXvW7f+sNt14fT
 YV8YaEwXuy7cGBFP+XWGS2kBM6fMCbF3nJ0OXKkJ2S+Y9TWSWmhKXk7aNBzJdNaSLa/Tg701o/L
 3TbGjLnE=
X-Gm-Gg: ASbGncvZYQJBxWc50ADMBbaKa1Y9z0ogCAhM9Jogv1s6k/1XSGVe5JLS2naYGfxjIUP
 lM32WxQy46UrBV/VYSVoP/qo60/FmiZeGV3K3KJZn8baF++v16jWEyJiEpYdAFiywm3r3oUQ/1R
 CqMpoay4azZzuXQWKczuQrCnp+dntyfMrvYSQXWC2w8rnIp1fjIHh+J9UgTn0JvIpkJ8uMW0Jze
 vdnpLv2Vhj7TaMEXvQDtEyPOyKWJ2s/Lj5q/fmSAbq43HrYs+TqeL42GSXTYx8OHQkgCgRV4NrY
 AXbDPHxLjFxKzBkL5b9y+s2HAUWjN4AZgnck16mdzOucwOyjuQzeF7AD10fDzuEzOboQGw3beFj
 We/nF+4y8xG1bc6m0zI/bSPb9qppeS3J9Lj1jugVDqjuhF4iOofI=
X-Google-Smtp-Source: AGHT+IFDW3Z0cfQuZV4eEHZpuhFz/ji5UYT/OmifL2qo8llQU/VuGyJaOIlnf45I/qG9+Oib1an9VQ==
X-Received: by 2002:a17:902:e806:b0:28d:18d3:46ca with SMTP id
 d9443c01a7336-29027402f00mr364975375ad.49.1760472446835; 
 Tue, 14 Oct 2025 13:07:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 11/37] target/arm: Handle ARM_CP_128BIT in cpu reset
Date: Tue, 14 Oct 2025 13:06:52 -0700
Message-ID: <20251014200718.422022-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d2fc17eab6..000fa20bc6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -180,7 +180,7 @@ static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
     ARMCPRegInfo *ri = value;
     ARMCPU *cpu = opaque;
 
-    if (ri->type & (ARM_CP_SPECIAL_MASK | ARM_CP_ALIAS)) {
+    if (ri->type & (ARM_CP_SPECIAL_MASK | ARM_CP_ALIAS | ARM_CP_128BIT)) {
         return;
     }
 
@@ -208,16 +208,24 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
      */
     ARMCPRegInfo *ri = value;
     ARMCPU *cpu = opaque;
-    uint64_t oldvalue, newvalue;
 
     if (ri->type & (ARM_CP_SPECIAL_MASK | ARM_CP_ALIAS | ARM_CP_NO_RAW)) {
         return;
     }
+    if (ri->type & ARM_CP_128BIT) {
+        /*
+         * All 128-bit registers are UNKNOWN at reset.
+         * For qemu, they are all cleared by memset to end_reset_fields.
+         */
+        assert(!int128_nz(read_raw_cp_reg128(&cpu->env, ri)));
+    } else {
+        uint64_t oldvalue, newvalue;
 
-    oldvalue = read_raw_cp_reg(&cpu->env, ri);
-    cp_reg_reset(key, value, opaque);
-    newvalue = read_raw_cp_reg(&cpu->env, ri);
-    assert(oldvalue == newvalue);
+        oldvalue = read_raw_cp_reg(&cpu->env, ri);
+        cp_reg_reset(key, value, opaque);
+        newvalue = read_raw_cp_reg(&cpu->env, ri);
+        assert(oldvalue == newvalue);
+    }
 }
 
 static void arm_cpu_reset_hold(Object *obj, ResetType type)
-- 
2.43.0


