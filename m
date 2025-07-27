Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5928CC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRe-00049C-RZ; Sun, 27 Jul 2025 04:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPc-0002tk-Hd
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPa-0004pU-RW
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2350b1b9129so23723175ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603633; x=1754208433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arVF9tN72BhPKd2O49ekxCQ+4ux1mZKYZhH3GMQy8Vw=;
 b=XoRI0inAFbVcu+4iHCptVU+UyQ7kaFjCeimZ7v8xC9g84nHv+OzT3NB4X3OglUwmd1
 266T0oIaKs2ahdf04jQuY1kaYIpwM2s/EuSn7dI28XHQYWHvhaUKqqN98l63qyVqjUbL
 VNmBTXT3oxgfLR+qgFArxjAiFJXPFpiHFRxioXYwecEMlLuJzAOnrTdUdxDWvqNidxam
 FvBcTMUmgW30SdiOYi/V0hMVrOnRwgfHNeyUo24rj2wHu/1PcN52llcSCaaB4d8Fv+zY
 Y2azzYPBW6uBeo40LdB60vO8fX2n/OrwLUOBF6jW+9J0XOuTHsvRYG7THK7SLqzSuXBE
 sfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603633; x=1754208433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arVF9tN72BhPKd2O49ekxCQ+4ux1mZKYZhH3GMQy8Vw=;
 b=p4IQmNLpTZnEy4TcGBDn9pxIUFH7dT7fBYmQ5+5YaoT2EVyE8Cjxt6B4o3jelbCJPa
 jSMV8DglIjU1uRS8i2yfG8mIUi/oTsh3I8UGXXSSyPx6laePezGD8uureuuNCJ870SFr
 3s0LhaRPWU+5JtSREIXvbvUNNa8JjUmZfX9qbWxFwVCPtRhiR8B0DpEw2iEYS22Bsx2L
 3vDaWZWBE3Vz2XKfi7fVN+POa0APkbsI4GaJCoJIp9QSD95LVZCVy61I0IXNgtyYRKRL
 ApVkFgDldhOiQhBkXrIuWqN8AL4QoWNfyuS8WwaeOWM/fU7OrJOpSVWrqXCt17NtKqh1
 U1OA==
X-Gm-Message-State: AOJu0YyYhKXvdP2v6PpYIFeZTCdyXmRbWhuTBsGuxTcsdJT5WpuXTx8U
 35hLxkWJdln8t2k754FPPMS2WjVSDldRcG4p3B32462rA+kydh5MJYkrc57DDshSX2nw4dRGClD
 /r5cw
X-Gm-Gg: ASbGncs/jRS3vbV19vTvTd4UpVwbqiFIRxM2LdFKal4WBjQFIU/REdg5w/o6g3wiY6j
 08rYcLpqEK5knVOUg9cjJLLoUPAD7WBIO+PZJc7Wu2VfWN68yxhqF2ymlKWxjHz1CjdOQ/RR9Vv
 Iy2YAcUxupIPX2owwOYtCP8qO8njTKnAAlyQsPt7s2RBTJhoKZw+2ww64xcyGp4Sknqz7ZLgNWW
 Jp9biJd2IlCgnlLv+bCxw0lLW5biNg01Mu6EHr2r/DnPXPCp+iRg1MjK9S62X49UuhzaLBV1/mB
 CZtQ7090ui2j3LyimaPIoHdAJAHYvtb55NVcNSCrmYtrRXXjBqpbB33YME7Hqbd7U4KY1Fg8BSK
 wW973LiT4ajB2jVB8pf3nf9UVxkqycFjocJ5MHN7VaTbtrbYkg7NuWAt099WlDp5EZOWxA0HXEP
 IKbvP3hjD3aw==
X-Google-Smtp-Source: AGHT+IF3kFx4OSDvA+Bf8eqDWdtPyShqYUixsaFKMSMMPKtJ8UDYCVeKAuX5YbZC6UMtR1f6SiWtCQ==
X-Received: by 2002:a17:903:41d1:b0:240:2145:e51d with SMTP id
 d9443c01a7336-2402145e8c6mr588745ad.31.1753603633593; 
 Sun, 27 Jul 2025 01:07:13 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 63/82] target/arm: Add gcs record for BL
Date: Sat, 26 Jul 2025 22:02:35 -1000
Message-ID: <20250727080254.83840-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/arm/tcg/translate-a64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 88fe5ac4ef..6fd3032613 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1667,7 +1667,14 @@ static bool trans_B(DisasContext *s, arg_i *a)
 
 static bool trans_BL(DisasContext *s, arg_i *a)
 {
-    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     reset_btype(s);
     gen_goto_tb(s, 0, a->imm);
     return true;
-- 
2.43.0


