Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E9CC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguV3-0000TJ-FH; Tue, 29 Jul 2025 20:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFO-0001rO-I2
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFM-00044G-Nx
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:42 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so4315005b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833639; x=1754438439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aE8T8VB3X2aZ5pXjUX7SLaXyPUjl2/XnllRFHeUFwMo=;
 b=FgJ1iIWZdkuvlKJkLV5ocObrxHCRWKCOB3uIc/JdSlwhw+fT44vwj9Z0Ttymtxkkze
 Qw/neCo9JZGJc6Tgki3NpBfaZQCKNLnpbUhvB/mE3FoimcdI7gQ8D+shO3CwXDzB9RbY
 3kLGTur/W/03dEFSX7jctBkU44fmduf92X5cED0eBqMHtcj1rUiXMPZn9mf2C2zzwiN/
 UMGtkSOVHex1bcbZ3SLJt7LklqF8J7pqC8LCimgu4aCLb4iBEUkUIdKb7eYK0Z/lyrXF
 LvLbsx6KK2PIC8C/lsM3IPCul1E28ILs8IPQNpDkUiBD8bVUe8KTb1BoEoD5nY24YUZY
 5mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833639; x=1754438439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aE8T8VB3X2aZ5pXjUX7SLaXyPUjl2/XnllRFHeUFwMo=;
 b=qnVtPDzzkQuOeq6jinT6slabefEPDXGzM0SZ7xkf1nALYyZKQGFCd3zUHz7HyB38ZK
 8KOZuYsuurnitJaG+Imu/Srv28wD/ygAHIkU16hME5p/Gp61uTkXECFXcQO9v1KHC/am
 k2QHaunZ8MQEhm8Xo2u+vMzKM21d+DBqZve/eDvpXGdvrPsTcgrHco+Ul+Vw/IN47YQy
 TYruBMQUvoB7qivEqX2v+C7ryzs3/IlqR3xCnDGyWXmlyIxqjpfOT73NlP1KIPpmY2qu
 GGYK6zELC43M6mm0t99Ursc1aTNZJud4JHM+n1rXEjtC6Rggfb1H0pt0RUaOCXc2XTzC
 BkxQ==
X-Gm-Message-State: AOJu0Yy+NDuwrn43KpOrT4oSxwTI+u6JcYS0RYdq1eieQnXjd84a1GWb
 4KTNaCYB8OzcYAH8nirO35mKFUE2B+T8yKDYrk4XXjEU5QH+f1fEyUHX2X/hyHmzf1MBSDwPccw
 Avofs
X-Gm-Gg: ASbGncuM4U7aIWkOyqAnP9Z3W7SsjrN2pKea+ILIKvnh6r6h59ixJkCxPjrAu25mr3D
 oJegRXKZQtShuHS/8g7ZO69FIsqvpRGliyww4SCYVv3WNsxCaQUS6MrzM7m+SuBZpChNnozdkZ2
 ybrOu++W4VT+fXDqYd7BQMTOJ/COEDSVWbloX1XEKi30pJzX3hPItNCt4WQhdwdRMLbkdFYY2vg
 Lp7oD1NL37UgOwMw5AqB11v0R2P371WMnO38SkVAQen3AzL9gityccf5ry3aGE7gBzHRn8nC5fU
 izvNfgxji6sBD0NdkHWlYvGsDGId0kF+yIm5CtjA2uMGdO0cAjdrhjtA1AYnjhTnuEaqgUhXbsw
 gRoI9G0fa2jPq4fmUzrg9flBpi0FnfQSzqv4qqrdP1vTOERYHl8voFHF0bih0w4xqsWkBfSqSPK
 PGJLl30fk7Jg==
X-Google-Smtp-Source: AGHT+IGMPPIgkq5oyJwu/Z2KdhyCG+Uzs0nb/jDvTDx7w0vj9oyqHfuJ/RR+VhNSUxBnkyNzGCWy6A==
X-Received: by 2002:a05:6a00:cd5:b0:742:a0cf:7753 with SMTP id
 d2e1a72fcca58-76ab082cba0mr2007481b3a.3.1753833638090; 
 Tue, 29 Jul 2025 17:00:38 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/89] linux-user: Move target_cpu_copy_regs decl to qemu.h
Date: Tue, 29 Jul 2025 13:58:53 -1000
Message-ID: <20250730000003.599084-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The function is not used by bsd-user, so placement
within include/user/cpu_loop.h is not ideal.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/cpu_loop.h | 4 ----
 linux-user/qemu.h       | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index ad8a1d711f..346e37ede8 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -81,8 +81,4 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code);
 #define EXCP_DUMP(env, fmt, code) \
     target_exception_dump(env, fmt, code)
 
-typedef struct target_pt_regs target_pt_regs;
-
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
-
 #endif
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 0b19fa43e6..6c97ab221f 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -365,4 +365,7 @@ void *lock_user_string(abi_ulong guest_addr);
 /* Clone cpu state */
 CPUArchState *cpu_copy(CPUArchState *env);
 
+typedef struct target_pt_regs target_pt_regs;
+void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs);
+
 #endif /* QEMU_H */
-- 
2.43.0


