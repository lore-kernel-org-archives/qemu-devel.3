Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7126BC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFv0-00074R-Al; Thu, 22 Feb 2024 15:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuy-00072X-Vn
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFux-0002cz-9C
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:44 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc139ed11fso10251345ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634621; x=1709239421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaAlM/N1pdfPJQ0AFuX+476ixWIzFXGcl3gsIXYKRec=;
 b=Njeeik9zO19UpleMaIDKuJa5PCejUa3nrDoAGi3qUoDdjdRGOZ4BYwNWjvmuJdEOFf
 nwncKrZt5TXsiQQgu4HClU33N4pj1RcroDvLthoW18tq1BF+ukZCc+GneIPJOghFKiv+
 9SPYd2RoagkVV+6EqXnKelIYuRNhcEKYcVdxuXSSzsIIWVvDoM2O1Z21k/HSPe/YWSrm
 QUMPSO1MZEKGkSNCm0LdtRfEAD4Kb1wL7GbrF5+lTJL3PkxS5lH+4+NKbGoFRVD638nK
 dIh/ut7B4L+C157X1JRujb63xOihyTy7NYSjPVVROjBdQRFU/nKZNU53OzNkpkRRlZlZ
 BQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634621; x=1709239421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaAlM/N1pdfPJQ0AFuX+476ixWIzFXGcl3gsIXYKRec=;
 b=NmpXdLwm0MTDpOvI7qKdprSCZLhNYNTc+qPX4ANpOS+4O/aeT3hBPd54X/cr0Tv2P5
 37Uu9c/a6pGk0+N6BVKUR098Lu9I65lLbG5IlgdD+JztKqRK+ugcLEL5WYpAY+lo9CNJ
 +NYNEJkofwZ6RCXKVYdgrWTqQQQEL6o3UPX/9ff88atN/XidnwsLnyFu5TyGSRkjMCEJ
 A7IPVKjOTB2j47BqCIoqY3VWtaZZSZCT+GFxRPqhxscpWNhjxsUeJYrCzO9fWQOzrcPs
 K8x6ZX6+x0BlfOqZgBWQEnKWtTPCt/M2biFz0C3P2AeBW98jvJ2dlEHPu1Pya7zo+w/6
 SUuA==
X-Gm-Message-State: AOJu0Yyt5wIZKMRB7k26h+nKUZ5j3xZek68lA308HSORTLYZtLXg9mfM
 piRCLfIhMsgUOTdpzSOtrUGWfllNqOrnqjti+7uBbXHTRDPJmAfKSG4NWEcxANq3vq1xa7Gdayz
 y
X-Google-Smtp-Source: AGHT+IEwJziSyEuRCWD5PkVaxtUS+nDgchiFl2JkjU3dNR7mB2TJyn6RO23QS3xB/01LGUzrjNPZvg==
X-Received: by 2002:a17:902:ec83:b0:1db:2caa:6c5e with SMTP id
 x3-20020a170902ec8300b001db2caa6c5emr5538661plg.3.1708634621183; 
 Thu, 22 Feb 2024 12:43:41 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 10/39] linux-user/arm: Remove qemu_host_page_size from
 init_guest_commpage
Date: Thu, 22 Feb 2024 10:42:54 -1000
Message-Id: <20240222204323.268539-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use qemu_real_host_page_size.
If the commpage is not within reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-8-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a9f1077861..f3f1ab4f69 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -460,6 +460,7 @@ enum {
 static bool init_guest_commpage(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
+    int host_page_size = qemu_real_host_page_size();
     abi_ptr commpage;
     void *want;
     void *addr;
@@ -472,10 +473,12 @@ static bool init_guest_commpage(void)
         return true;
     }
 
-    commpage = HI_COMMPAGE & -qemu_host_page_size;
+    commpage = HI_COMMPAGE & -host_page_size;
     want = g2h_untagged(commpage);
-    addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (commpage < reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
 
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
@@ -488,12 +491,12 @@ static bool init_guest_commpage(void)
     /* Set kernel helper versions; rest of page is 0.  */
     __put_user(5, (uint32_t *)g2h_untagged(0xffff0ffcu));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
 
-    page_set_flags(commpage, commpage | ~qemu_host_page_mask,
+    page_set_flags(commpage, commpage | (host_page_size - 1),
                    PAGE_READ | PAGE_EXEC | PAGE_VALID);
     return true;
 }
-- 
2.34.1


