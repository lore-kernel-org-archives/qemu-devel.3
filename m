Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E15BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvk-0002SO-WC; Tue, 04 Jun 2024 05:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvc-0001sq-Kx
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:06 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQva-0002Hh-UZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:04 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so8443741fa.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495080; x=1718099880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhtO+b8xKpbz5dyKFVe313y98g7MQZe0qAfemmQJG2o=;
 b=Ny/YqwUT/L2YSs78/vGsJKV1vSBtQ5AmMqhJu9gQsaScoWSV8s3+ru2LQtsiaVqCMJ
 NuiC1xsisspQj/irZv94ZfcVo2v5/IcaSXmJEVkWHmMA7CHVLJu0pH2IWWcoL6mqLYLb
 LTWRvKnNNDW4Jx0VKxG+H46ZcDPTKv4RskdU+wEtZpipAeZSf3dUbM/0QDUfxrlQZtLa
 VkZaQLT3HAKHxq/sdqwEJZYTKW+pmg8KJ3KFTmU0OuwStQypY1yj1NpYOjOMW5tHgvrI
 qnNEguq3Q1INFBqRVDYpmDTolaQvQf7YdyeMnd+AByGv5NW1scWmAFf6V+cgjzZEw5H/
 k4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495080; x=1718099880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhtO+b8xKpbz5dyKFVe313y98g7MQZe0qAfemmQJG2o=;
 b=wPer/ULnyxr3yGF+8CHX/jm/k1zjsdYHtzqOBZJ+0BiIx7bTo1M8Z4T72CEDJD5FQx
 xjvATgnzf6VWk539b8TcfpI7FdL+HJ/32nTqxFSfqd/nn1RnD4FtH25wvwrOTyNdwmBH
 slPZ6fq3cM0VsLhPnvIwoffhW9qLwRusvdPvWrheJbCfjlPnRikqU1XL6gKoJOGmv+Zq
 HtTiVX3Vf2XUfZ3HZYiuCdy4aRp1fXr2XXxKAJ/gl1hq5IotWXZfrpoLPW62Xuk3Twr+
 0Ic/s7GE5hKFtt20VuQN7SZ9i5pdaZmoWqritg0VJzq4rXqtrxao1Hh5oN++nDos6OPw
 8H+g==
X-Gm-Message-State: AOJu0YztetSL4GfdncSHKMLMNzpJLCldI0ATD8bM1blvTrgBeLIKFYJT
 REKemd2XQZygNnFNK4jyOxevIjPMeoOHVSQzh4OR9wKEtBAN0coOKz1zKAIeNqPY1y84nTnLkVG
 9
X-Google-Smtp-Source: AGHT+IErAEByG+blH4ldyvqDww6GNUxSaTcykxJ/kVYXoj55TqH4GjOyWKIh80aTT64WwxIhvkFeKg==
X-Received: by 2002:a2e:994b:0:b0:2ea:7e5b:98db with SMTP id
 38308e7fff4ca-2ea951f9657mr71594191fa.51.1717495080415; 
 Tue, 04 Jun 2024 02:58:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062ec39sm11105957f8f.89.2024.06.04.02.57.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/32] xen: Add xen_mr_is_memory()
Date: Tue,  4 Jun 2024 11:55:56 +0200
Message-ID: <20240604095609.12285-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add xen_mr_is_memory() to abstract away tests for the
xen_memory MR.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240529140739.1387692-4-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/xen.h    |  1 +
 hw/xen/xen-hvm-common.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 754ec2e6cb..3445888e39 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -49,4 +49,5 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
+bool xen_mr_is_memory(MemoryRegion *mr);
 #endif
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
-- 
2.41.0


