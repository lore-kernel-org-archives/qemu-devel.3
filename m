Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C366AC25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dLQ-0008CY-Rl; Thu, 16 May 2024 11:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dLL-000882-Mo
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:32 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dL6-0002uH-FZ
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:30 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e538a264e0so12460501fa.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715874494; x=1716479294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP28Iks2aCd2MOvUAbQc4yYuz/leCz2VtuKFu0fMfns=;
 b=gJqWS2ZFjgmXD3ZgYKzCSNmw4fE2OX77q+aesy8oP5hI4GFL1+7Vgw+Y/ZLfFZmGZj
 sZx63PL2DFH284wyO0MPZ//A0vIWesOYD93wPhQKsyXjBDe6LdpisBW3Fi0/aAzOnyBV
 tAKCSt3l36lWJ4CQurSaKjSG+dVml6sF0vQunB+8/KTGO0ZIB8lRVIarggjtU313wLJm
 hdYgEY1YfWP9c1JAFBG+mzBIOwazms3iLur6s9m6i6yO1Leac5IoeCxEvWGZD0WhEplT
 AoJButML/zc2/GaGXzk89e8JIHntVnqeqWN1F2HDBIvQuRiZp4k576idzcQDCxsDgbdP
 nSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715874494; x=1716479294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP28Iks2aCd2MOvUAbQc4yYuz/leCz2VtuKFu0fMfns=;
 b=qnJOwDGCr2lIm8bFaZyf1CyKu1b7WUVCr9E7MaS949X9X/l/ZhMQrBKCK+3qrj1AR8
 RwNZJxCOI0dHm42nZundC6HrWCtxfRrVNtMR29h3T+r8JwequRSJPRRn0VIzwMORNihq
 5WVscLeaas3F3WOHI0m1yYqV29aERN69tmfpeXkZQBJmBppj/6O+RW0+xB1kigVO8JDi
 JOuuQtBst5UiI1Z6lQftGwaJnV6qQX4fhEdU6yTkFVZ96WhjD+wE0TmF6Lx0VrrwuJbf
 ltVY52ZIrObxnNf4wIQiGYOLShF0wJ77SnE4Y2bWo/fij9SJDWGjYVPOhSzelJpSgOS4
 SzBA==
X-Gm-Message-State: AOJu0YwS7gqAdLl6D4mwGQV/nWsiDQ4y6L9jrhFJQVwxsMdIJ46z8Sr6
 pgpRTikScUZaVKiEx8V/09Yl6WBea5Ou+FYh59S3BNnxLtbS7N9PaIyAjxRo6hw=
X-Google-Smtp-Source: AGHT+IEaN/+VHmkJjv/znpWgW3h0+GqXzWUJj0uCRLf2DykoyCNb/asHTon7nVels7WBBHQIR1MU9A==
X-Received: by 2002:a2e:be9f:0:b0:2e3:ba0e:de12 with SMTP id
 38308e7fff4ca-2e51ff5cf48mr209958761fa.22.1715874494287; 
 Thu, 16 May 2024 08:48:14 -0700 (PDT)
Received: from gmail.com ([213.0.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42016b88f99sm146828625e9.10.2024.05.16.08.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:48:13 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v6 3/8] xen: Add xen_mr_is_memory()
Date: Thu, 16 May 2024 17:47:59 +0200
Message-Id: <20240516154804.1114245-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
References: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add xen_mr_is_memory() to abstract away tests for the
xen_memory MR.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 hw/xen/xen-hvm-common.c | 10 ++++++++--
 include/sysemu/xen.h    |  8 ++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 2d1b032121..a0a0252da0 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -12,6 +12,12 @@
 
 MemoryRegion xen_memory;
 
+/* Check for xen memory.  */
+bool xen_mr_is_memory(MemoryRegion *mr)
+{
+    return mr == &xen_memory;
+}
+
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
 {
@@ -28,7 +34,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
         return;
     }
 
-    if (mr == &xen_memory) {
+    if (xen_mr_is_memory(mr)) {
         return;
     }
 
@@ -55,7 +61,7 @@ static void xen_set_memory(struct MemoryListener *listener,
 {
     XenIOState *state = container_of(listener, XenIOState, memory_listener);
 
-    if (section->mr == &xen_memory) {
+    if (xen_mr_is_memory(section->mr)) {
         return;
     } else {
         if (add) {
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 754ec2e6cb..dc72f83bcb 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -34,6 +34,8 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
 
+bool xen_mr_is_memory(MemoryRegion *mr);
+
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
@@ -47,6 +49,12 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
     g_assert_not_reached();
 }
 
+static inline bool xen_mr_is_memory(MemoryRegion *mr)
+{
+    g_assert_not_reached();
+    return false;
+}
+
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
 #endif
-- 
2.40.1


