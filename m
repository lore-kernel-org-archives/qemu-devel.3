Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99058C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkc-0002V7-0j; Sun, 27 Sep 2026 05:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkC-0002Q1-Aq
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkA-0007Oz-Qt
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:24 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so1005735a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499621; x=1791104421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Sr+K96+xI+B2pMxR34wWsKT2YCMzZp1diez6d83aOk=;
 b=iNMQry+E4yGFaQ7fSE3scrP35zybY1Pqew8yDZmmeZisu4N21HNkes7eXmxCFt/YMU
 D+zAs4olT7RyDWVhdjlDPw3FZyLMri43z/jfWTiz8p5SNrq+/DmFSaEf6PLtm4yAcXYd
 WlYHztt5YsVvQPqoWTRG5sxUwGLxXdJzbxqrjh9xgRdvLO7jCnQaJi+6LJcviXQ1QJk2
 6v0U6x3LJQlDJRKN8+V7tnHpDNVzmyyFcH/yYWhpu+H3z7kKp0e/P6e0u8Q9h468UamP
 4SdqypDEjWWmpxu6a5A+rasIuq3OKzoe6iZiNbkIZKBuKCmNOMO8mmlaJN8FMXMaswMz
 H+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499621; x=1791104421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Sr+K96+xI+B2pMxR34wWsKT2YCMzZp1diez6d83aOk=;
 b=rDYka2qtqGYFne2QXbplHbNSgojmuS6iJwFPcBfZ3wl1vDTIU2QQBpYfoWIt0zZtRc
 kslbiFAdt+WKa2da2d28xgSsMUTeuqaaupYngGnazctoz0js3YuzPVBPaJN7VJ75ALQn
 S4DQxEdQ5NmYc/BFjcT9k4ACl7ffiD5iZaeXkQOQkiTW1QgrLGT8IvknecB7HVyvXPGn
 SlJnHgRIl2OwFhWg0pqd9I5QYA2A62ZJSSaL6TmwRMKA1i6tZDp9GRGZE1hgAkRA9kev
 VnM3S/tPS/oKomYw+1FZlU0tbgTVLSmrUz1UpnEpkp8/51C/2tOZ6fqh0D46kgF4GvLM
 0yDA==
X-Gm-Message-State: AFq9FYKvFT0QRBolSFzvagKSeadiClRMCzzFXCl/XAGin89vmokNfRBi
 6+NOTwRp6FpW3hlKPIhpyUiUq9vPc5U1TIo/yjsC3q0grTIUC9RRPvxlAF1bVi0HZCy83k0OJPE
 YM6NT
X-Gm-Gg: AYBFou1Ul8CTCc4zS094D5EkzAgmL/GMof9VNjuX/tcORqZZPYp8cETr/1qMckpY6KN
 H+MFEa1ufnsY20rybhD78KBtiTfP82gBb8UowspRoG3zt9+vcQ96PdHcJVOB0TkGZoRfWGFsf5k
 +MsTBLRyukK4uxyVArwXRkCtqJk5PD5n7TlXUh9oGtswtg5F9dDVEu6sn1jebPdLzDsu/NYzhD2
 C69ouSSYjkJEbnNFQ2kmoAO6DFr6XOnKq6V48aabg/xp25dU6dlVRxL7u5/tqGgU0qNRTZc1hz4
 0fOOnu/myjr71PTR+4SnLIlJtzpCZUe0xO5Ej9HxTILECLjdHIgpJrr3z+VOFVfknl9pO1x3TxG
 GHirCZR6AHhhAHU2JN3WVpaC71+nMiX7kh9zEFkw9zMYTTq2fqGI2ishMk/urSEQ7vyXEmI5BzY
 FD3TXmIbPHeLI/wbI0u+QDrRdKOYMixpKnTiesJg+r5h877GAfxQN6V7rgXEPjIxdw7+xxyDLAz
 FjaRwYITc9q7vSm9UdReQmYKO4+qA==
X-Received: by 2002:a17:90b:5686:b0:3a2:b04e:8085 with SMTP id
 98e67ed59e1d1-3a2b04e839fmr401585a91.43.1790499620518; 
 Sun, 27 Sep 2026 02:00:20 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 008/101] tcg: Prepare for easy temp lifetimes
Date: Sun, 27 Sep 2026 01:58:38 -0700
Message-ID: <20260927090011.10724-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-temp-internal.h | 2 ++
 tcg/tcg-internal.h              | 5 +++++
 tcg/tcg.c                       | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/include/tcg/tcg-temp-internal.h b/include/tcg/tcg-temp-internal.h
index 98f91e68b70..932ad1aeebe 100644
--- a/include/tcg/tcg-temp-internal.h
+++ b/include/tcg/tcg-temp-internal.h
@@ -31,6 +31,8 @@
 
 void tcg_temp_free_internal(TCGTemp *);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(TCGTemp, tcg_temp_free_internal)
+
 void tcg_temp_free_i32(TCGv_i32 arg);
 void tcg_temp_free_i64(TCGv_i64 arg);
 void tcg_temp_free_i128(TCGv_i128 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 2620c23b448..d480d10878c 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -74,6 +74,11 @@ bool tcg_target_has_memory_bswap(MemOp memop);
 
 QEMU_RET_NONNULL TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
 
+static inline TCGTemp *tcg_temp_new_ebb(TCGType type)
+{
+    return tcg_temp_new_internal(type, TEMP_EBB);
+}
+
 /*
  * Locate or create a read-only temporary that is a constant.
  * This kind of temporary need not be freed, but for convenience
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ecc1f54c1bf..9f2f929e273 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2201,6 +2201,10 @@ void tcg_temp_free_internal(TCGTemp *ts)
 {
     TCGContext *s = tcg_ctx;
 
+    if (ts == NULL) {
+        return;
+    }
+
     switch (ts->kind) {
     case TEMP_CONST:
     case TEMP_TB:
-- 
2.53.0


