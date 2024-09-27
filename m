Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BDCCF6482
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIrf-0000Ql-MU; Fri, 27 Sep 2024 17:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrd-0000HE-Qj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:51:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrc-0004Vs-5l
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:51:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso21653065e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473858; x=1728078658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22wtNkwk6lzPh2EtQj85F8jLpnswm9ZtwKSArURcwyA=;
 b=QkPRz+pLdQLCCNe5nHr11o0PskxIzuY4EDdbERvaQYDHYbQVdeCMQI/DieiTDjkcmI
 yuNnDwzpRw3XpjoJ2psCF3wedv7NNYKUQYfanIFSOah1tEEvoOttj6wOqqIW7YbAsO8R
 u7qbowIJL1IOEzGOOyCvAl9hkkQ8J/vZ+SlKDiLnhXZxQkhXltKLyiwSWxw+IqvS8Y62
 djdUSrZr5wtuVjn/aK+IkjBfA7Oijmzosb3s6XDI1uT77sxmDgtszAHXp0lFzUnfGmCR
 kbc/kp0uMXJz+52HZ+4p2v3cvEwC7m+nya64IpV/47kYrGlbFxPwazguh/Vzrk2PfbxG
 l6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473858; x=1728078658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22wtNkwk6lzPh2EtQj85F8jLpnswm9ZtwKSArURcwyA=;
 b=BVz07ZlZdIZ7EQizuzxa9xoEXYEQDh4Bse6N/+OsnablZH1dvB9rnk81BeMZf5A2Qb
 4uG7giuguMLarVPxeOxeCPZpC3QjVMfxQZnjfcxgHV/JqiAmk3yUoZNEd+XATLIqfakp
 PebZArw5HSUNonzAudUDNN414iKJTVJDz+15wv/4WTKUB31neAe6hCZQJhXlvTqcy7xu
 9hkybcmoFs4RQITnWti1hNETZ2OKPV+BFHGkNO2mlvt39B60qOed2uYa159eDGECnwlu
 pFagjcY8t3U6AzOqeNjofueNnjSufmYJsyhEmytDQ4A30so/68uDE03KOeEUsPsdiJA3
 oStg==
X-Gm-Message-State: AOJu0YyXgpcLXU21KOmWK0pUNYV5HVtqizFCeibMmBN1ZOlv4txQJjjJ
 +hReW5eYgOAVV4mvhjCPWzZCpxAlG9cZ5fpPAdKgsn5D9SjhIYIF3IfnvTfjhWfOxEKB9qxzJE7
 f
X-Google-Smtp-Source: AGHT+IFSzDpLlLLuQHk/1iyS/V0pFwnNOy4PLtvz4GdTzYXXWjp/4VZ7/GCGPZBO+aKp7E/DduA54Q==
X-Received: by 2002:a5d:6802:0:b0:374:c040:b00e with SMTP id
 ffacd0b85a97d-37cd5ae3362mr2642552f8f.39.1727473857983; 
 Fri, 27 Sep 2024 14:50:57 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d2d2sm3476685f8f.1.2024.09.27.14.50.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:50:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] hw/ppc/spapr_vof: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:50:38 +0200
Message-ID: <20240927215040.20552-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927215040.20552-1-philmd@linaro.org>
References: <20240927215040.20552-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Directly call ldn_be_p once instead of ldl_be_p / ldq_be_p.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_vof.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
index c02eaacfed..d238a44d88 100644
--- a/hw/ppc/spapr_vof.c
+++ b/hw/ppc/spapr_vof.c
@@ -136,26 +136,17 @@ bool spapr_vof_setprop(MachineState *ms, const char *path, const char *propname,
             vof->bootargs = g_strndup(val, vallen);
             return true;
         }
-        if (strcmp(propname, "linux,initrd-start") == 0) {
-            if (vallen == sizeof(uint32_t)) {
-                spapr->initrd_base = ldl_be_p(val);
-                return true;
+        switch (vallen) {
+        case 4:
+        case 8:
+            if (strcmp(propname, "linux,initrd-start") == 0) {
+                spapr->initrd_base = ldn_be_p(val, vallen);
             }
-            if (vallen == sizeof(uint64_t)) {
-                spapr->initrd_base = ldq_be_p(val);
-                return true;
-            }
-            return false;
-        }
-        if (strcmp(propname, "linux,initrd-end") == 0) {
-            if (vallen == sizeof(uint32_t)) {
-                spapr->initrd_size = ldl_be_p(val) - spapr->initrd_base;
-                return true;
-            }
-            if (vallen == sizeof(uint64_t)) {
-                spapr->initrd_size = ldq_be_p(val) - spapr->initrd_base;
-                return true;
+            if (strcmp(propname, "linux,initrd-end") == 0) {
+                spapr->initrd_size = ldn_be_p(val, vallen);
             }
+            return true;
+        default:
             return false;
         }
     }
-- 
2.45.2


