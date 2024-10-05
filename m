Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D13FCFA742
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fT-00021Q-LS; Sat, 05 Oct 2024 11:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fQ-0001yw-Dl
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:00 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fO-0002Lh-Ux
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b7a4336easo22654155ad.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141957; x=1728746757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMIQXnxelIQ86qxYbOA8sg/WFq9fqYpMUetqZ1DDKfA=;
 b=LL9FfGzlAJTA4MPYk9UKoMqE1mSDqEY9PsTFfA1nY07kgq15e4KJ/NswBtEztVDMEP
 7y5kUv2wNHH5UcC0C/F+kSHZzZZHkec3zGwC54y3PN2Yzp2s2LY+vvqlAqzpHK/1vc6Q
 oh/qtdE7VHV2pLAkpJoVBxqtQMpk+tfv9Y6QODtvPA0R/EubhGgh7TQmPhGYjXO8740G
 4p5s6XrnlXujaLMvdl+tju4RYNVJ1zCATkAOrV2IC9vlvieN0U8izUebCTTWCRCL+Z67
 FrFtNVr6cE3qpJZClhh4Ydbb0/8zni54IZC2LRMLei4gplWnPRNHJxVEq79zQMqKYx6i
 9iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141957; x=1728746757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMIQXnxelIQ86qxYbOA8sg/WFq9fqYpMUetqZ1DDKfA=;
 b=nyLj+dUqodUaGX5RRJU9GskkkTE/MEteUhkVNq+McUyz+pD3vEaS+MtYGp1VTsTfTc
 rxRIGvllC2WOuhtENAI1kY/jay0EF94yStgGw92uJWaAPxyAssq7dS+pfu5wIJiN9j7c
 GrtXv4um8rnSbMVWOg0qAmpvp5Vp5ASVggiBRWXDsxMazaldgMjWZxKAFN4bjTaak4xf
 DO5e0OzhXOMVY0BErzCY/PAcn1zvLEsBdj+P7u6oFpYXtpyHSoRY8irAbkEdpQFY3eF7
 quNU+kwKuqKITwp4lMXhUCKZCUWbisjoDJAJxztXyw0raMTuW9eQdrGS9Yee5T0g53vK
 yJgQ==
X-Gm-Message-State: AOJu0Yx5ONKdF+I2ODrzH7hXFFMZHXWPHHJukPjIQDp8PFSy5z/286Ul
 w3xW8hOQRJiioy2rro541V7Sb0JgxEbjH2NZk/aA7mji7AyxcbkpwkIG0r/hj/Z7RHPxqTh3m3d
 k
X-Google-Smtp-Source: AGHT+IHCfh10FjkbBSOvqXvOBG9PUScOEcA1SfhVDalzVVmPfKmDc9cmv0jmAUjDnTAXUakJpgurmQ==
X-Received: by 2002:a17:902:ec81:b0:20b:90ab:67de with SMTP id
 d9443c01a7336-20bfde594f1mr78046015ad.8.1728141957612; 
 Sat, 05 Oct 2024 08:25:57 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:25:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 05/20] include/exec/memop: Introduce memop_atomicity_bits
Date: Sat,  5 Oct 2024 08:25:36 -0700
Message-ID: <20241005152551.307923-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Split out of mmu_lookup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 24 ++++++++++++++++++++++++
 accel/tcg/cputlb.c   | 16 ++--------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index f53bf618c6..b699bf7688 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -193,4 +193,28 @@ static inline unsigned memop_alignment_bits(MemOp memop)
     return a;
 }
 
+/*
+ * memop_atomicity_bits:
+ * @memop: MemOp value
+ *
+ * Extract the atomicity size from the memop.
+ */
+static inline unsigned memop_atomicity_bits(MemOp memop)
+{
+    unsigned size = memop & MO_SIZE;
+
+    switch (memop & MO_ATOM_MASK) {
+    case MO_ATOM_NONE:
+        size = MO_8;
+        break;
+    case MO_ATOM_IFALIGN_PAIR:
+    case MO_ATOM_WITHIN16_PAIR:
+        size = size ? size - 1 : 0;
+        break;
+    default:
+        break;
+    }
+    return size;
+}
+
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b5bff220a3..f5fca5a118 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1751,20 +1751,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * Device memory type require alignment.
      */
     if (unlikely(flags & TLB_CHECK_ALIGNED)) {
-        MemOp size = l->memop & MO_SIZE;
-
-        switch (l->memop & MO_ATOM_MASK) {
-        case MO_ATOM_NONE:
-            size = MO_8;
-            break;
-        case MO_ATOM_IFALIGN_PAIR:
-        case MO_ATOM_WITHIN16_PAIR:
-            size = size ? size - 1 : 0;
-            break;
-        default:
-            break;
-        }
-        if (addr & ((1 << size) - 1)) {
+        a_bits = memop_atomicity_bits(l->memop);
+        if (addr & ((1 << a_bits) - 1)) {
             cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
         }
     }
-- 
2.43.0


