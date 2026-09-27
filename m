Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4C0C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkqK-0001PY-6Y; Sun, 27 Sep 2026 05:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoI-0005Yi-9Q
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:39 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoG-0007ie-Sw
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:38 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 d9443c01a7336-2df90e859e8so6133925ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499876; x=1791104676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MUz4jdu5xIKHnbLeGk9IeooxVgpWMi18K36UZ77MUH8=;
 b=afgPbbf6+XpxIqYebbN42upzg19nzvOay7d3fA0m1MuygoTi80qI0ChrqoxzMyrMS4
 O6lfUA2jA8urwB59ZFzaBNppBXtC/vW+zLOPZpPPtEBcfK9S3CeYpUKuLEBQTclt+ruH
 Ail/vA7i8CXd4t/glpGFx1tDHmsLgG9dafVqG+WxbhwBZycf2qmLEOh4FQ2JnIoCET/M
 nLOAeP8G9diyTyb10euhbi+lsxpgBdhIxmzHbfEFIOZ1sSj7Ql56vbUrt7gfdLz4Fasw
 uxbBj7jQhg+VFATcs80KQhYSpQCXcmwrg/aadADOXuKmMmtgUbLOJ7Lc3fBM/bdzwy8Z
 yn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499876; x=1791104676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MUz4jdu5xIKHnbLeGk9IeooxVgpWMi18K36UZ77MUH8=;
 b=RpXP9x7jaLHWaDXBvYlmV9J4fQvXRCysQtSa2ZuTGyTdYDZlX0XYcXCXfIWbXtiDZN
 K/8NjkG62rb4qqUXMRP6MI0PL7c8lcsOwtD0XkD4E/O+AV/K/HWjk+YKcOutY6Nt4aHD
 mjvJpbpLoZ7LP4Gm6lI/ZT2v91hdjtQMRZuqmovpSPHlgk2YgS85TpsVA7jzd1ICf/lM
 SkLaHxtGHBt3LrefVJ5anF8Tb3wnMD74tW7z9G5j2c0kJ1lumQj7295u0+vlFFEvu5cy
 gpCmw+tpvVD9RY5WlHV0RRsHACY4PSE09DBCn/jqe4gpIK645y6H4Ka1sCvEAVEmeAZ5
 oFUQ==
X-Gm-Message-State: AFq9FYL30xy+zKDLGDv1AKj/l24P/+qN/jzZPDYgKuDpABqnXcqbZs5w
 UyDw9HurcgLl5rWCY+45y/WqLE7XG0BFlBPlW0casaOd9VMFtShmPrVdB4D5fO9XKKVMdrfoofB
 j5c0f
X-Gm-Gg: AYBFou1Hg/qDiwYX8Ek7MMkkTmi5lO2/8IvOj1g2yXqoc6nrrXMgE+oh6nxuaT3KKBb
 1I/2QP9TuJ5fpURejGmBw8C6ad9fp1al/G+Lw8iJ5Nva3k8AEO70wPTeuRqIzuCQSa0kl9ra2Ob
 ajGN+9uFS+JSGF1uErATJCZ4g/VPgZbiO4jRe043OdZx1ji2mOCIBjuXj2geqdwFVxh0pYH7xg9
 5E9Vn9qmlfZOu0k0JTGuZ4hl3iwSozpSV0Gnuo2qubR2yWtgMgzEqyqsGpJxnYAZDI+Mtcl0/lo
 vPu2Z4+1q7Lfol1MdH3rvKiiQIDXc6XX+k3edWKTId/AYZoOTWtWRQKhqaXsGL8mHjtxwtyCIHk
 /Yp9AEkGy6SzVqik/1iiI4QsRpgfA4h0pt2CXx7BoopSuf9tJL7ITt1d8JLkRtjuoW4ARv4VAl2
 QsuRn7IV0xciGZs5QK3AX12PFpz4VtI4nAEbL03A4AfA5U0ogTntbLDpmLlmRPhuY4XtisaMVg3
 MA29LGpxF/CICK28T7AgMTrLf/sFA==
X-Received: by 2002:a17:90b:4f89:b0:39e:6c68:fd92 with SMTP id
 98e67ed59e1d1-3a098b92d1bmr5624044a91.39.1790499875535; 
 Sun, 27 Sep 2026 02:04:35 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 077/101] tcg: Use umax in ussub if available
Date: Sun, 27 Sep 2026 01:59:47 -0700
Message-ID: <20260927090011.10724-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 tcg/tcg-op.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a1c1bfc8912..b7b3451a4f8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1089,9 +1089,18 @@ void tcg_gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
 
-    tcg_gen_sub(type, tmp, src1, src2);
-    tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
-                    tcg_constant_internal(type, 0), tmp);
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        tcg_gen_umax(type, tmp, src1, src2);
+        tcg_gen_sub(type, dst, tmp, src2);
+    } else {
+        /*
+         * While umax can be expanded with movcond, some hosts can
+         * perform movcond with a zero source in fewer insns.
+         */
+        tcg_gen_sub(type, tmp, src1, src2);
+        tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
+                        tcg_constant_internal(type, 0), tmp);
+    }
 }
 
 void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
-- 
2.53.0


