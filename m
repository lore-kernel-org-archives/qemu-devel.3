Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303A6C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU2f-00016W-Gl; Fri, 09 Aug 2024 14:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2d-0000xy-5e
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2a-0007C5-Tt
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3684407b2deso1263620f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226919; x=1723831719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9H8W0O0b1Ww323Eya3NUzzCuyPiKzt+1Rqu3lq0GOBs=;
 b=Z2YPnO3BEUFXgX0OUNHn4jXBqVYCdz/hk4bdotPv8j76VDRxtP+bLAbjO6QF5x+TeT
 TZVidLI+h8cBUbDQyJGPnb4aAnZLstG6yRINDZ3pwP3DvCLuWUpqJ94Uamji125tr46p
 Qv8OA0LBD+oExy/8wDbg9VvLFz14ZOOPTM96YHRZhFAHDyN59AHiCagmwPDlH8vw3tJK
 B65kRsY7yt8Mz4Q3Umr+B6tvwLoPy4LHJRBVxzIIhbSqoS7kGnuOGQ5RSmy73rTWorI3
 WHb5fCVMzWhpytMqyPl88WoLXrEGzDfcxKjibvIOjgnKumGXwGqzOS5zVYAffy5q3MCl
 pQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226919; x=1723831719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9H8W0O0b1Ww323Eya3NUzzCuyPiKzt+1Rqu3lq0GOBs=;
 b=PO5GZRQbfmPx2TRZIb16QxfmBH6UTZz4QsRn8OKte2vxbRcmlLMJxCTVz2ZqRgvYgb
 bITe9looHr1xmzk1PxYtoYpm/Mbuk+a7SXD6FHO4Uju/aeAWjGHYBvqi+2JVJ38wxB0H
 6YrWemgvWyEi0xx+kqgtkdI7GY33KqAoImTQBNW8ohVUZPmaCtpAKXDj6fW8q0kBkiBc
 PvQBlF3abecQP6MevFjAsDsooyR9p/N9e458LfkqCbb8/Trk7GzWHGZzUfBOVH7tunsr
 uVLQPUtF50fh5GCiOh+ynLVvgajvZk+9+9WWyYSu0CXyJqylC/zoNRx/6mOGuRvlts7f
 mjgQ==
X-Gm-Message-State: AOJu0YyEcL9vP9pkXkJw33xS7OT22F+GF6XQXVVI5kQi+R89LDHVoXXo
 bdXi7leACp2cGTZ696JqMPEC3/I+Xq13dowNTfBrQK3UdQkY9UhE1YJiI5bAwu+lzepBy0wErjJ
 j
X-Google-Smtp-Source: AGHT+IGyIqLACViZKl7GbGD+tUL/2MFBIOkiBElfrunkUJCM0KzRQSFKZ2fl2FhPy2YBzcKdVJdLRg==
X-Received: by 2002:adf:fb46:0:b0:367:96d6:4c2d with SMTP id
 ffacd0b85a97d-36d5e4d2ad4mr1756404f8f.25.1723226918692; 
 Fri, 09 Aug 2024 11:08:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.08.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:08:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] include: Fix typo in name of MAKE_IDENTFIER macro
Date: Fri,  9 Aug 2024 19:08:26 +0100
Message-Id: <20240809180835.1243269-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240801102516.3843780-1-peter.maydell@linaro.org
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
index 4cc4c32b144..fe7c3c5f673 100644
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


