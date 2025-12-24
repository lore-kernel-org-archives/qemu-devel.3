Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48CEE776C2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQiK-00033j-Li; Wed, 24 Dec 2025 10:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQiI-0002fl-F7
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:23:46 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQiG-0004iJ-6b
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:23:46 -0500
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-64b92abe63aso8951871a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589822; x=1767194622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giWdPoxyT7GeYpAJXZMpfomroD+LhNldKaXalY7TMhs=;
 b=Mn0YKBb538sGECJP6U2po9IX+mkpaTJrOJLCm6A/A7IpVn+mmX3z/KqSRw/jPPy3jt
 Oa9uo3fe4M7jBAOY7231VFrVXDBtaOYpTTJnAsmHhCrNI6gsReKFCELx4+AkStV/DhbJ
 6kuWrOEfNnhyBue3xvQoP51zpFoGoCxk4VPED/Oy2zwfJcx5IPWEywxW+Xw56qG/M5NL
 2aanYSjsm2P7KF8eMU970IcyRdfQZBHiiCL2Z4MOa2kaDBKhD28RzeAxq32TTjtg5sK0
 ZCT1HNmUEvUTYk3nVNWh2uFhV9EY6M9VoTn2w0q4FrdiskWvRJy4PGf16w5j+c+Zi0T0
 UQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589822; x=1767194622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=giWdPoxyT7GeYpAJXZMpfomroD+LhNldKaXalY7TMhs=;
 b=QNzxInpXTSXCAj/edea9sEm6sYICSBAkkUj6vp+OitbwI94Nc8Bpk4p+30p7LobYHI
 TTnu/h8fda2LkEkgwGR+TL/pQmPizfGJY4ajOdkYK7Hnh9XFOcC4XL/dMYy0Gx9aYTNc
 40V0YW4YX2lgOIOiXZs200heVCI4sSwKWNkJ+GvNkBIIBGJsEyPf3oqpYEoaDVQt9dzD
 EN0X6qjW9J4yoQBciAwKINK1IrajxTX5ADOToUyaauW9waSuWpnq3X8zD81hoxUjx7PF
 r2xpkaQ6IUCAVQGNKHBm7mFPIOwaBAYZ2mMgFnOaepo/AW38C2ILFrMLf4vNfiBdeVJH
 ng6A==
X-Gm-Message-State: AOJu0YzkUXx1lC6QKjCLBWR2kEMrpYGBIxrRKzxnFHKO0rZgpQ53yBDc
 pGCe3iEDrD4A4LP7DbstZiWs03xTxlyfWeZn3IALT8YkapgJ0y/NC+tf1KS5S+VOJMkJqyUZN9S
 /ETt3IhM=
X-Gm-Gg: AY/fxX7ZYJjZXF6XzcF3cIv6Z9RRGO/7a4/AYL39W1stbPsARe/mH01FuKIAlTClSI0
 oBPxKjBNMxiM9NGkI94qkzvzn04vnBu5WCMWWzT/kcpaICnISxnPMl+2izTgBE82MZil/Abq6eD
 jAiVYQFXUk0YlBmF8yzy+UdCp4NB8v5fG5AjqXeGTg8qt7mKcMuy1MajvohVkORKwkb+mex94Js
 F97oT8LQX8HIv73TNVf8M67QgidXeNvIQxTWF4lNQPXCo9iy2eVHXmt5V5HszVKvKAJevoWLpay
 sOfdLHk/AxlW3qbZdj4B1Vy45e6LsKZw63OH9QyG3wOK8dbBSyEyGGBnj7ulMhJfptVZPnMOHhM
 wnSnR+hrGLzmXjhoC0VHcBVH7KD+IHZRlQDneOL5Fo7g1kgaKn248/ncZswdrzAHoDqgzCQ6x51
 QHgrgj/b8stPfnJBrUbpfaydwFZ1aNcYbPfXgt/S6DSKjJPhn7ykcdpgiy4ISV
X-Google-Smtp-Source: AGHT+IF+ALIebe7Ss+OBOttYMD+rHpAFC89ErPxEd+ePsxvR74/wp1UHRkeXxGruMEjt1Y401KwZRA==
X-Received: by 2002:a05:6402:5188:b0:649:227b:42af with SMTP id
 4fb4d7f45d1cf-64b8e82b799mr16623639a12.4.1766589821916; 
 Wed, 24 Dec 2025 07:23:41 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b916adc61sm17346653a12.31.2025.12.24.07.23.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:23:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 09/25] system/memory: Define address_space_ldst[Q] endian
 variants via template
Date: Wed, 24 Dec 2025 16:21:52 +0100
Message-ID: <20251224152210.87880-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x544.google.com
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

Define address_space_ldst[Q] endian variants via template.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory_ldst.h.inc             | 17 ++------
 include/system/memory_ldst_endian.h.inc      |  4 ++
 include/system/memory_ldst_phys.h.inc        | 36 -----------------
 include/system/memory_ldst_phys_endian.h.inc | 10 +++++
 system/memory_ldst.c.inc                     | 42 --------------------
 system/memory_ldst_endian.c.inc              | 14 +++++++
 6 files changed, 31 insertions(+), 92 deletions(-)

diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index 7ccca46f2a9..dd1fb482eac 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -19,22 +19,11 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+             hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
+          hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
index 845ec3b4ad1..f5b6b496be5 100644
--- a/include/system/memory_ldst_endian.h.inc
+++ b/include/system/memory_ldst_endian.h.inc
@@ -18,10 +18,14 @@ uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result);
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result);
+uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
 
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_ST
diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index c3c73419e61..f4c91dc7a91 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -19,54 +19,18 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-static inline uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq, SUFFIX)(ARG1, addr,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldub, SUFFIX)(ARG1, addr,
                                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline uint64_t glue(ldq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_be, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
 {
     glue(address_space_stb, SUFFIX)(ARG1, addr, val,
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
 
diff --git a/include/system/memory_ldst_phys_endian.h.inc b/include/system/memory_ldst_phys_endian.h.inc
index 1589f34e8e4..820e9dd1f13 100644
--- a/include/system/memory_ldst_phys_endian.h.inc
+++ b/include/system/memory_ldst_phys_endian.h.inc
@@ -29,6 +29,11 @@ static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
     return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint64_t LD_PHYS(q)(ARG1_DECL, hwaddr addr)
+{
+    return ADDRESS_SPACE_LD(q)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline void ST_PHYS(w)(ARG1_DECL, hwaddr addr, uint16_t val)
 {
     ADDRESS_SPACE_ST(w)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
@@ -39,6 +44,11 @@ static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
     ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void ST_PHYS(q)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    ADDRESS_SPACE_ST(q)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #undef LD_PHYS
 #undef ST_PHYS
 #undef ADDRESS_SPACE_LD
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index ab2df6e429b..823fc3a7561 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -115,27 +115,6 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
-uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
-}
-
-uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_LITTLE_ENDIAN);
-}
-
-uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_BIG_ENDIAN);
-}
-
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
@@ -381,27 +360,6 @@ static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(address_space_stq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
-}
-
-void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_LITTLE_ENDIAN);
-}
-
-void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_BIG_ENDIAN);
-}
-
 #define ENDIANNESS
 #define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
 #include "memory_ldst_endian.c.inc"
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 5d46524ec4c..791d041b15d 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -33,6 +33,13 @@ uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                                         DEVICE_ENDIANNESS);
 }
 
+uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result)
+{
+    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, addr, attrs, result,
+                                        DEVICE_ENDIANNESS);
+}
+
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -47,6 +54,13 @@ void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                                  DEVICE_ENDIANNESS);
 }
 
+void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result)
+{
+    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, addr, val, attrs, result,
+                                 DEVICE_ENDIANNESS);
+}
+
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_LD_INTERNAL
 #undef ADDRESS_SPACE_ST
-- 
2.52.0


