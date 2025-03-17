Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAFBC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2xE-0006eX-4t; Mon, 17 Mar 2025 01:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xC-0006eK-M0; Mon, 17 Mar 2025 01:23:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xB-0007nW-2d; Mon, 17 Mar 2025 01:23:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223594b3c6dso76633905ad.2; 
 Sun, 16 Mar 2025 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742189035; x=1742793835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKory0aORXHwx2AW1UJ2qnqZAC9gkLCaJS83bjYZRC0=;
 b=GLZDdHe0eCEQrQ2rknTkySm2w0P5nXbxwp9uxHo374Iw7yc8bCMo9p2hJkNJZW6QYy
 Yph/twuhWRrEOk9An0e9A8dEZ3EuphBiMU/kjizf7pwVqtBhcxGe63C7f1LegpLJ8Dbf
 8RLxE5XXFjz62IcrmpNNjGkkOMwTeS6dJ9lTzMm/TitHg1Hs3XOgFCpAFAYqiSQYpeCG
 oVqCPb1oLdKLG6/FpjxpX0hNAylQ1Q/7RiPmuLmBtGQRNn0yDYQv0Jilp6lkYtAfJ0t3
 lWXo7Fow3QD4fyDhvLG8mpojfDUnwXihN/myfdxbN4iPdZRfXtv0DBsh9CurpeWrIHOU
 pzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742189035; x=1742793835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKory0aORXHwx2AW1UJ2qnqZAC9gkLCaJS83bjYZRC0=;
 b=YMRp5N0KzLHIbzKZJ3IeC5GuxtbELB6XMx/suODE/mNmzMd5pvxJWTXlWIKay9wKmh
 70xsaHMbv6oKIHx9+gJzp8ry2I0M6rUqwyjxQ2zazsr8utixaPbAsilN00Spn7OtHHhw
 Sv2P5nKgbicD2At/IMnwr/V7fU9kh2t98eBANtiaKFAIcdRXBYoosmfPDgvYc7OEbh9K
 A3izPvI/7XGTesbpTXgpgIiBtT7nzoSWeVp0Su8lLm/1Uc59LgAaN7jMkeCa0rRKu7Cq
 cK9CypFa3E0vlblip5dPz4k6EtCw9j4cM1XeiDyOhaYkrFFXWUxDRCKChARGlv/Hti80
 7DKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2MzYBY3P397Gyd+iYVy6mY/TAb3tVmTAMFmon6fkJTILnbYAycNBea0YXOhDCtgwKpu6pMUeBNw==@nongnu.org
X-Gm-Message-State: AOJu0Yyz/hlTo8k4f5sIpRp8T0hGYa+CZtEHZVSqgxEkIQFoqElbj92X
 AarIpozpOdpnB4GH6uZCEtwR9EmrkIl1hjeMXmGinBQ1jgX09xNG5VzWQQ==
X-Gm-Gg: ASbGncu44QLtjJQnvkZY7pCVPHbTBu6qU/rgFFqDwZF/HxLiCFojzXuqcppK9gwO1UK
 vqplGUw5Ogm3CjWvZ1v18OkvbAs+CACB8Y3AstPYZ3IkSN5+Yx+PFQxx4OAP1ovn5vVpQcKmLZw
 aciMVJayTdRdBxNU1f3LloRLrMnBxbTQ9RpXTNQVN/6OrmmdRtsE3bzVM4mX/7fLFlPUvV9afKE
 jUQVhg4YBA/ujaCvCkiS1qITtGShq6TQoXqGk/BRIMx0ZDls4BFYKQhK3oeeynW2lLOrfq3c1dU
 yKqbUb2mT4LmzOcBjf2VMnzheflPhLGGZtrvYSkK3BuGgdh3pA==
X-Google-Smtp-Source: AGHT+IFop+lMLtmUwqVSFMRq8l5cGwGRY2WDfGXMe7wtrRaCCwffHD4+Sad+KDzkiBxQ9m+AvrZvkQ==
X-Received: by 2002:a05:6a00:808:b0:730:9502:d564 with SMTP id
 d2e1a72fcca58-7372238490dmr14020131b3a.14.1742189034947; 
 Sun, 16 Mar 2025 22:23:54 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b6bsm6879495b3a.148.2025.03.16.22.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:23:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/6] pnv/xive: Fix possible undefined shift error in group
 size calculation
Date: Mon, 17 Mar 2025 15:23:34 +1000
Message-ID: <20250317052339.1108322-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317052339.1108322-1-npiggin@gmail.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Coverity discovered a potential shift overflow in group size calculation
in the case of a guest error. Add checks and logs to ensure a issues are
caught.

Make the group and crowd error checking code more similar to one another
while here.

Resolves: Coverity CID 1593724
Fixes: 9cb7f6ebed60 ("ppc/xive2: Support group-matching when looking for target")
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c  | 27 ++++++++++++++++++++++++---
 hw/intc/xive2.c | 19 ++++++++++++++-----
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index e86f2749328..3eb28c2265d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1662,12 +1662,20 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
      * (starting with the least significant bits) in the NVP index
      * gives the size of the group.
      */
-    return 1 << (ctz32(~nvp_index) + 1);
+    int first_zero = cto32(nvp_index);
+    if (first_zero >= 31) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group index 0x%08x",
+                                       nvp_index);
+        return 0;
+    }
+
+    return 1U << (first_zero + 1);
 }
 
 static uint8_t xive_get_group_level(bool crowd, bool ignore,
                                     uint32_t nvp_blk, uint32_t nvp_index)
 {
+    int first_zero;
     uint8_t level;
 
     if (!ignore) {
@@ -1675,12 +1683,25 @@ static uint8_t xive_get_group_level(bool crowd, bool ignore,
         return 0;
     }
 
-    level = (ctz32(~nvp_index) + 1) & 0b1111;
+    first_zero = cto32(nvp_index);
+    if (first_zero >= 31) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group index 0x%08x",
+                                       nvp_index);
+        return 0;
+    }
+
+    level = (first_zero + 1) & 0b1111;
     if (crowd) {
         uint32_t blk;
 
         /* crowd level is bit position of first 0 from the right in nvp_blk */
-        blk = ctz32(~nvp_blk) + 1;
+        first_zero = cto32(nvp_blk);
+        if (first_zero >= 31) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd block 0x%08x",
+                                           nvp_blk);
+            return 0;
+        }
+        blk = first_zero + 1;
 
         /*
          * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not supported.
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index f8ef6154878..311b42e15d3 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1153,13 +1153,15 @@ static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
 
 static uint8_t xive2_get_vp_block_mask(uint32_t nvt_blk, bool crowd)
 {
-    uint8_t size, block_mask = 0b1111;
+    uint8_t block_mask = 0b1111;
 
     /* 3 supported crowd sizes: 2, 4, 16 */
     if (crowd) {
-        size = xive_get_vpgroup_size(nvt_blk);
-        if (size == 8) {
-            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of 8n");
+        uint32_t size = xive_get_vpgroup_size(nvt_blk);
+
+        if (size != 2 && size != 4 && size != 16) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of %d",
+                                           size);
             return block_mask;
         }
         block_mask &= ~(size - 1);
@@ -1172,7 +1174,14 @@ static uint32_t xive2_get_vp_index_mask(uint32_t nvt_index, bool cam_ignore)
     uint32_t index_mask = 0xFFFFFF; /* 24 bits */
 
     if (cam_ignore) {
-        index_mask &= ~(xive_get_vpgroup_size(nvt_index) - 1);
+        uint32_t size = xive_get_vpgroup_size(nvt_index);
+
+        if (size < 2) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group size of %d",
+                                           size);
+            return index_mask;
+        }
+        index_mask &= ~(size - 1);
     }
     return index_mask;
 }
-- 
2.47.1


