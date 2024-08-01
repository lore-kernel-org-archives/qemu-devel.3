Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1E5C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSzt-00011g-KX; Thu, 01 Aug 2024 06:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZSzr-00010O-UO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:25:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZSzp-0007qW-9L
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:25:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso46990405e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722507918; x=1723112718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LGj9xUPuFQKz+iRXpwtcPvUOjN63NyRT7V4lFqRZMPE=;
 b=lnDH/I+MBS2wiQxqQYWNhuO82uZqCvsZcMH0gFWTWVXhbhspNWv4pkjhStk+5QzeCf
 1sHcjSJx2UxCsspYQNfSKKDIAgAdTA3lDLMDqmNoFrlyku43M4xTZXyXEuzCiBPVF3W6
 CUlzqHXci4yBK6Q7uEWn545SyCbN+Q1IpMoIvM2K1ZSy6r7ZYqpwsgAibDkrQzS6cZg0
 Vmf6SJMEDHtuGvyhqa9hpP/VNkep31KQbcw2Af+1/22M0SOOKhtt28wWhTDWkb8JBz0C
 EKAvhYrvyfDkskWoFhXztXq7Vu9H1B+I47jCuL167Nan7qleLn1KxPXpa+Nf9RA36dTm
 bytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722507918; x=1723112718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGj9xUPuFQKz+iRXpwtcPvUOjN63NyRT7V4lFqRZMPE=;
 b=IsQw3PFosRAy6/aG+OmTfKJp7CO4lafEgQ2RpukcM6PnkDZYcrdCVYTT9849WULj0I
 6PTHQpXGsCT9d6Dm8zu19CffOCBnMAez+PIC71H7CxZmGtxdEU5m6dpytWfddUZ+ClGv
 Khq8CzkwfhuliB3QWTXSFmaWuI7eNcvBjsA7G2ToDyv6v0r7Wgq5KcnGimfWBGoZ+Aa7
 DszN2Tt3als4mpW5DKasBSJjFygwCCrfkVxB8xVTKkpqSPUhp+ukSE7ZJZ5OXk8j1a5M
 d9RiBrqDDGb9937NT+aEjeOb/If+IgBuhQ8ix8OiwGBcgR9s4uK+4deI0LfDOoypf/KF
 l1FQ==
X-Gm-Message-State: AOJu0YxIHIWmo3t3x67WAvXHiBdkAIK8eZ55HbvjD/+93ChcUJ4o1D7h
 kaiuObr31iziemtXcRkYGOds7CbqZb6pKmGIPx4OAHxSL6kMPwAbVlpKZuQ4YC2ho4/N74OzL05
 v
X-Google-Smtp-Source: AGHT+IHf748LX2HEdOtRqhDU6nTzs5Npe0Q4NkH3ErpYw0aDqYLV2uKT96BX+DBA2Z5/4L8rb9GuTQ==
X-Received: by 2002:a05:600c:46c9:b0:426:593c:9359 with SMTP id
 5b1f17b1804b1-428b8a2a666mr20757835e9.32.1722507917829; 
 Thu, 01 Aug 2024 03:25:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb223f6sm52381275e9.45.2024.08.01.03.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:25:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] include: Fix typo in name of MAKE_IDENTFIER macro
Date: Thu,  1 Aug 2024 11:25:16 +0100
Message-Id: <20240801102516.3843780-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In commit bb71846325e23 we added some macro magic to avoid
variable-shadowing when using some of our more complicated
macros. One of the internal components of this is a macro
named MAKE_IDENTFIER. Fix the typo in its name: it should
be MAKE_IDENTIFIER.

Commit created with
 sed -i -e 's/MAKE_IDENTFIER/MAKE_IDENTIFIER/g' include/qemu/*.h include/qapi/qmp/qobject.h

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qapi/qmp/qobject.h | 2 +-
 include/qemu/atomic.h      | 2 +-
 include/qemu/compiler.h    | 2 +-
 include/qemu/osdep.h       | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index 89b97d88bca..256d782688c 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -54,7 +54,7 @@ struct QObject {
     typeof(obj) _obj = (obj);                                   \
     _obj ? container_of(&_obj->base, QObject, base) : NULL;     \
 })
-#define QOBJECT(obj) QOBJECT_INTERNAL((obj), MAKE_IDENTFIER(_obj))
+#define QOBJECT(obj) QOBJECT_INTERNAL((obj), MAKE_IDENTIFIER(_obj))
 
 /* Required for qobject_to() */
 #define QTYPE_CAST_TO_QNull     QTYPE_QNULL
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index dc4118ddd9e..7a3f2e6576b 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -128,7 +128,7 @@
     _val;                                               \
     })
 #define qatomic_rcu_read(ptr) \
-    qatomic_rcu_read_internal((ptr), MAKE_IDENTFIER(_val))
+    qatomic_rcu_read_internal((ptr), MAKE_IDENTIFIER(_val))
 
 #define qatomic_rcu_set(ptr, i) do {                   \
     qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 554c5ce7df7..c06954ccb41 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -38,7 +38,7 @@
 #endif
 
 /* Expands into an identifier stemN, where N is another number each time */
-#define MAKE_IDENTFIER(stem) glue(stem, __COUNTER__)
+#define MAKE_IDENTIFIER(stem) glue(stem, __COUNTER__)
 
 #ifndef likely
 #define likely(x)   __builtin_expect(!!(x), 1)
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 720ed21a7e4..38a127a699e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -399,7 +399,7 @@ void QEMU_ERROR("code path is reachable")
     })
 #undef MIN
 #define MIN(a, b) \
-    MIN_INTERNAL((a), (b), MAKE_IDENTFIER(_a), MAKE_IDENTFIER(_b))
+    MIN_INTERNAL((a), (b), MAKE_IDENTIFIER(_a), MAKE_IDENTIFIER(_b))
 
 #define MAX_INTERNAL(a, b, _a, _b)                      \
     ({                                                  \
@@ -408,7 +408,7 @@ void QEMU_ERROR("code path is reachable")
     })
 #undef MAX
 #define MAX(a, b) \
-    MAX_INTERNAL((a), (b), MAKE_IDENTFIER(_a), MAKE_IDENTFIER(_b))
+    MAX_INTERNAL((a), (b), MAKE_IDENTIFIER(_a), MAKE_IDENTIFIER(_b))
 
 #ifdef __COVERITY__
 # define MIN_CONST(a, b) ((a) < (b) ? (a) : (b))
@@ -440,7 +440,7 @@ void QEMU_ERROR("code path is reachable")
         _a == 0 ? _b : (_b == 0 || _b > _a) ? _a : _b;  \
     })
 #define MIN_NON_ZERO(a, b) \
-    MIN_NON_ZERO_INTERNAL((a), (b), MAKE_IDENTFIER(_a), MAKE_IDENTFIER(_b))
+    MIN_NON_ZERO_INTERNAL((a), (b), MAKE_IDENTIFIER(_a), MAKE_IDENTIFIER(_b))
 
 /*
  * Round number down to multiple. Safe when m is not a power of 2 (see
-- 
2.34.1


