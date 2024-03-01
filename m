Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1A8C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByB-0005YT-VH; Fri, 01 Mar 2024 18:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy1-00053m-1f
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxw-0004HJ-Fe
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:00 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dba177c596so18018285ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334415; x=1709939215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JJAXHXhKfB2vZUAaBWoHwbme18boXrxvRH2oQhMjWA=;
 b=W8aLEF0FFZRIRnm8H5B7/zzT5KV3eIwplNo5gI5C93sRZ9f0Ty7DM/3rG0t1Us2Rnm
 s+nIH7DYq/SIFenxSJPVy/oYM53SBVdLCp6np8unhhVzavaCy1EYenw0jEpM6rmQHZE+
 LIbUJPeywbk60NMg1kZnGCHAmlESa46vVzk8ipMH/XuQuRC6eh6x45nqc82rQ1arSKVV
 EQvobc6Y5tOY0vvMrHtu58LpXMKN70jqHVv8crxi2jelHHMjbmrmx7BdzpuBQMqCQloB
 OG7IiySpgX4CvqdM/LIeMDsixF0Z7XB3534RwaJrpWQd6ilY2iwLrnJsxa5j0gk5U6e+
 NQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334415; x=1709939215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JJAXHXhKfB2vZUAaBWoHwbme18boXrxvRH2oQhMjWA=;
 b=IYzAqjM8cX4CCUd7L6mRuv6yNrmHZqT8vNPDhThiF+cmGyklKY4yAjdDE3oUaRE6wt
 vJB5zdcarpoO0mqCIBRrlmHGG5mdLu+hIHMRSASi+06Aato3qjbc5ZSQCP5rDDXv7pB5
 k9K+MHprJKDTAYs7MoVyHmWCFdfAtl4hbLW575iBcairUBeFDFeXhngfHaOS2/qEtuIH
 EkdbNmG+7vtTqRU2uA5GVE34enJfrsDwW/mfkp6zv8uYGv8y6BEvaRBGALbjCu6iV362
 Zm+Jj3TiyldKW7EfEi4kaF0uRgyPuhfEcIstgg1idPVYLGmCD+Bf8aROTh6zM6uU/zGW
 YgqQ==
X-Gm-Message-State: AOJu0YyDzrjv/jSUTxLV6BiZ8UmkfRKx3D19av2X1h0h6BNJ/mI5QhqU
 VvPUSzIEwuH3WAQ/xhdYxewgktn8/fdZL7n3t2kKWJM9cp/vxm0bvTX8TSf9vXPmzHPxrNhTHjG
 r
X-Google-Smtp-Source: AGHT+IGxmyhHVz5g7Cxj1Gd3nwTw5z1yRBQqHddsUcfFtbE1kQF5YOYF7kq31oxuXrobk5TFWENiZQ==
X-Received: by 2002:a17:902:a384:b0:1dc:8b82:7f72 with SMTP id
 x4-20020a170902a38400b001dc8b827f72mr3257294pla.16.1709334415290; 
 Fri, 01 Mar 2024 15:06:55 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 24/60] linux-user/arm: Remove qemu_host_page_size from
 init_guest_commpage
Date: Fri,  1 Mar 2024 13:05:43 -1000
Message-Id: <20240301230619.661008-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 479acb4e7b..d2919a411d 100644
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


