Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27704CF6483
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suImg-0004B1-M2; Fri, 27 Sep 2024 17:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIme-00041w-E1
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:45:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suImc-0003ul-D7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:45:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so31140305e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473548; x=1728078348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22wtNkwk6lzPh2EtQj85F8jLpnswm9ZtwKSArURcwyA=;
 b=kckBDP6Gj8mRwxqqub8ykpcyjo9SSY8HO2InTJsE555j0cClfcPJckjrJ24KZ98AQU
 83o24sXLCICkhf3uykxlhbqGTcCXJMGtBmiySu0cHK928bCb9axT4eG2HFLZ0+WsEbQJ
 FTTz41TczOF11z9UYtlDAOp9gej0nucMJOMlvF40BFbrTBRJVk97TXykdNgLcc/edTKY
 rm2546QzsSmRueIjv6n/uYy2XoXWdleXrjm3CzXvMlbx7R78ujFnRAF+GRQ0OuTkj6FY
 Cs35ndeETsiI2jQlqMTEYrE3gpKxfvz3akxBfvJPZYgJ1PtjwBXD61T+C14sQ6Waq+nv
 RJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473548; x=1728078348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22wtNkwk6lzPh2EtQj85F8jLpnswm9ZtwKSArURcwyA=;
 b=M9V3JONEa4gPPBVK70xsldO1OvbjauMECKzAj1T1u7CgtmOcj4iBYu6c0xs48Jiw/e
 tLfbKIm7gJXRDZhNf/zy+r1AwMnxqgVwXWAMXBJlHUzcE780WsrqOEp7u41IhF0vuISC
 9B/U1ZA2wRCKvr4+VkKD6NZy50ho/4skY07I980MZLpM34jM8TIcR2JxzxwLRFck276S
 +eF4sIFW5RpjpNWlWGgCtnsdE7UMorGZKLMaOWSFweLuPrTe8P69S1lhgql+EUYx0KQc
 vXZdb76GZFPMr9yYnbxX57i/dBhLC4n6J6lyH7h5k5rBBs7AD/C/C72fF5vtnrgyVNqv
 NWRA==
X-Gm-Message-State: AOJu0YwgLmB9KI+4i70IkHJCJbSS+naK0TCxIurEzOP81xj93hly3n+T
 0p0t3n8JKQD+Haab6rH62vNGF2+W8jl1bmEHhF8nG1JS5/MHyqbHlIptWBnYaTGFAGUuDC0j9LF
 e
X-Google-Smtp-Source: AGHT+IGpYOfRFumm9XZdJwLyZz8guaI/2hF7CixvTFkmE+6dfS5poM0464o5AoPoz4/J6RPtwL0Z+Q==
X-Received: by 2002:a05:600c:1d1e:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-42f584976b0mr42968425e9.24.1727473548533; 
 Fri, 27 Sep 2024 14:45:48 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564ce91sm3460609f8f.2.2024.09.27.14.45.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:45:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/ppc/spapr_vof: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:45:29 +0200
Message-ID: <20240927214531.20242-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927214531.20242-1-philmd@linaro.org>
References: <20240927214531.20242-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


