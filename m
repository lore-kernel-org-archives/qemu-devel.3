Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A457CCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBQW-0000Yt-Gy; Mon, 30 Sep 2024 04:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBQS-0000Kk-Sy
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:06:37 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBQR-0004Wi-6R
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:06:36 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbddso5870466a12.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683593; x=1728288393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyfJ60ZwiZ7J7acEGIws/WvnHoIJtgQD50MT+DOE6Vo=;
 b=Iw0cw9jhyQwNqBFrpvhQ77Dxdt+3h42LsCxDc+IX7f0c/GPASvAfsjk4kaFnhcCeD3
 GnEavYHO8gfNS1MyrcRrBc87Er3pWS7bbhdxrDvhIWTM7OeUtFQeS5AtYYYIqhxgJqDr
 l6fqpC+ARHTVUxVUQcm1iZpoj1zCWZYJSJQc2ia+H4Ml1Yn5wZSeTt1IbjqpyspLsd30
 5ObOwj6TBtzbHu5aETkGbPisxZcAZnKnDp0YyMdW6wrm8hRZ0ZFvdf4W/p4N3e9ZS+Yp
 oE2WBWWNaQDNHjQgRojaAjzUEWjQYWRMQQDogSK5r15nhxcWSVDvstjnfcgc/6A5FXJr
 EY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683593; x=1728288393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyfJ60ZwiZ7J7acEGIws/WvnHoIJtgQD50MT+DOE6Vo=;
 b=KLh/E/mcesqWcx266+Iu/eCWQr7ZunnDlZYsUqVWPopRahQHJdUcNVolQERUBx638t
 hRHQ/SvQIPoimpzmNTOjg8/MSiLvMB7FOiUxeglFVxtoZ/JSCkDjYV4TLAh6vKyNBGQY
 mrPIso3R7UfH1dVVhEl8pA52U3teaKLxwagR+OiDBGFD6Cev2WeG0mbegxJMmcfkXXEH
 IgH6APZFr1ofd/FXssB96SROfy2gPwwCh1kxx0DooEIOhC+IG0p8Ew67E5DoiuHA0NuO
 fVdc0BjEKXl+kJWPyX8SfwZDmL+bE6+jXQv2BPA9fjBxD1BczKycrpwYP29S8FoC1px0
 MhsQ==
X-Gm-Message-State: AOJu0YwiBa+FKfcbUmioPRGnGbAtRWO4O992qpnTYzpXy4P7leglapez
 8duLVD0VO8cumw5gn0lsRjCsM+yRF5Ulw782koGmFtY7PS2WYtaFFAGo7Xqq9tEEW70ZF+1gjwT
 vhiM=
X-Google-Smtp-Source: AGHT+IG2gsv4mq4+t28yXE71qvp6d8mpB4wSDB4DPNTelRdnOp6bYuTIvq+usLJM1DB/dwuL1E7PwA==
X-Received: by 2002:a05:600c:45c9:b0:426:63b4:73b0 with SMTP id
 5b1f17b1804b1-42f5849731fmr76872605e9.34.1727681770017; 
 Mon, 30 Sep 2024 00:36:10 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a52308sm141836745e9.43.2024.09.30.00.36.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:36:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 09/13] exec/memory_ldst_phys: Introduce ld/st_endian_phys() API
Date: Mon, 30 Sep 2024 09:34:46 +0200
Message-ID: <20240930073450.33195-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Introduce the ld/st_endian_phys() API, which takes an extra
boolean argument to dispatch to ld/st_{be,le}_phys() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TODO: Update docstring regexp
---
 include/exec/memory_ldst_phys.h.inc | 66 +++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
index ecd678610d..8ea162b40d 100644
--- a/include/exec/memory_ldst_phys.h.inc
+++ b/include/exec/memory_ldst_phys.h.inc
@@ -74,6 +74,16 @@ static inline uint16_t glue(lduw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
                                                MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint16_t glue(lduw_endian_phys, SUFFIX)(bool big_endian,
+                                                      ARG1_DECL, hwaddr addr)
+{
+    return big_endian
+           ? glue(address_space_lduw_le, SUFFIX)(ARG1, addr,
+                                                 MEMTXATTRS_UNSPECIFIED, NULL)
+           : glue(address_space_lduw_be, SUFFIX)(ARG1, addr,
+                                                 MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline uint32_t glue(ldl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
@@ -86,6 +96,16 @@ static inline uint32_t glue(ldl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
                                               MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint32_t glue(ldl_endian_phys, SUFFIX)(bool big_endian,
+                                                     ARG1_DECL, hwaddr addr)
+{
+    return big_endian
+           ? glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
+                                                MEMTXATTRS_UNSPECIFIED, NULL)
+           : glue(address_space_ldl_be, SUFFIX)(ARG1, addr,
+                                                MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
@@ -98,6 +118,16 @@ static inline uint64_t glue(ldq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
                                               MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint32_t glue(ldq_endian_phys, SUFFIX)(bool big_endian,
+                                                     ARG1_DECL, hwaddr addr)
+{
+    return big_endian
+           ? glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
+                                                MEMTXATTRS_UNSPECIFIED, NULL)
+           : glue(address_space_ldq_be, SUFFIX)(ARG1, addr,
+                                                MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
 {
     glue(address_space_stb, SUFFIX)(ARG1, addr, val,
@@ -116,6 +146,18 @@ static inline void glue(stw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint16_t va
                                        MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void glue(stw_endian_phys, SUFFIX)(bool big_endian, ARG1_DECL,
+                                                 hwaddr addr, uint16_t val)
+{
+    if (big_endian) {
+        glue(address_space_stw_be, SUFFIX)(ARG1, addr, val,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+   } else {
+        glue(address_space_stw_le, SUFFIX)(ARG1, addr, val,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+    }
+}
+
 static inline void glue(stl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
 {
     glue(address_space_stl_le, SUFFIX)(ARG1, addr, val,
@@ -128,6 +170,18 @@ static inline void glue(stl_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t va
                                        MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void glue(stl_endian_phys, SUFFIX)(bool big_endian, ARG1_DECL,
+                                                 hwaddr addr, uint32_t val)
+{
+    if (big_endian) {
+        glue(address_space_stl_be, SUFFIX)(ARG1, addr, val,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+   } else {
+        glue(address_space_stl_le, SUFFIX)(ARG1, addr, val,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+    }
+}
+
 static inline void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
 {
     glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
@@ -139,6 +193,18 @@ static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t va
     glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
                                        MEMTXATTRS_UNSPECIFIED, NULL);
 }
+
+static inline void glue(stq_endian_phys, SUFFIX)(bool big_endian, ARG1_DECL,
+                                                 hwaddr addr, uint64_t val)
+{
+    if (big_endian) {
+        glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+   } else {
+        glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
+                                           MEMTXATTRS_UNSPECIFIED, NULL);
+    }
+}
 #endif
 
 #undef ARG1_DECL
-- 
2.45.2


