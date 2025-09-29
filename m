Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8CACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Iij-0006aT-TB; Mon, 29 Sep 2025 14:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhW-0005Xt-L1
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3IhT-0003bm-1Y
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-414f48bd785so2659459f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170848; x=1759775648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IprTsHK83+//o00MiFkngA2W2onv/YPnwzWQKra2w8=;
 b=bNRgpgLRsMHXHaimbUpFU3mbyIM4U9x/EqnGlZUz5kVU1CX39V/vizT+O35xqoEFlY
 76gPDFhJUnfRH+oirfh9uQhY8dWDWl4CH2PpbwLh99/rYT+v2v8FZ+LKEnCWEzGuj65I
 4SS+j+EIog8695Gu0EOnW7H1UB+uwhL4UvSTTQrmC0FlsD+XTXa06gBDInB1qdFK3BoQ
 iQNi3lBr0zY+wSfGZk9xWVjyfmN6qbWRwSAj+WUrhJMm1Q3KQpVMJjltJHuMH3htL01P
 UBA+OZ2lj7euK0b4qoia8TIfD2D7HOJNeh0RHRNWBi8E1GOZzeHQnmG96cMeHb3yACpr
 nOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170848; x=1759775648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IprTsHK83+//o00MiFkngA2W2onv/YPnwzWQKra2w8=;
 b=e7ifGqn/itLGURq4RWV94ki1M4O6dFD9OdhtldgQ048p4we87ELJ8ylzw+WuDV7cK1
 7ApOX9gsWe4E6BQqHpi23dqio3LSRdwhZgeY6nn8mpEb3qnCN4AorcDQ1uLhx0EcP2oa
 nx7v5KmMKQ015eKBJ55OMw2v+dKUScVKPk4gVIVvjYLyUeCRjyuZBizBRq1mlgAPXaaQ
 l2vF4Gf/ige2qbAJoE8FHk61HWa2s2cSWWOHkLzq+IoHeWx4AeCjXcK5MCmGRSHohnTG
 jhCINO7qLCDZkRI4PFdp+Iscs4Dtg7CX5UvF40LfJq80z7PFtHTVQonZbaAjCfCGPr9z
 whOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4GN3KPsXEsNYwRC4XDKqCzrK17t7OB3IP/T5pbOqBvke0yBD+CLwpUgEqe1h3oihEPYFRbCPCvC1e@nongnu.org
X-Gm-Message-State: AOJu0YwII3+OCvm/2ngUwMmhQmvT8HHp95QGpxv8e+LYT0kVmYWmJR+o
 gSVwSm4BAVBcHUstmaG43s2JkztUsuMLl1Vw5+D6/8FZ9d1nFAtGCPQ73WqfufDv1ZA=
X-Gm-Gg: ASbGncuYzYLhLRkOh3zE7cOknbPsJir3rVwCxPe7KHHbtvdaW69Eh4g66dVHlIOnk9P
 G+/64WOJvT6+pKB5ACVwHHb5UsGkNmqvv6CEEbmnbfPyruZQahYTrgzOTJPbn1vLjLAv1viv1hi
 Jgg+qJox8WvkbQ4UtF5fpCGPPsOixOvhsWZ6R3qXXU4LuHb8xNG5OkiIFZ8eapUu10ML4DfGLZ/
 qf60bz+wlY/2Z2ZSe4d8VH85vHVTjpKmHyMHVucA1XsAESQZFV4wiRcQXETsB8uqXdtOo4QZ4+Q
 s+k0yUc4rpaI6fG1cIijlyupDm685GU/G3MpWAAqkugoWoNw/frgqoqkvoA4FcU88MlZ2B6XmXf
 yD5PTAuCR953gVPaJ6RK6JFnSb6M55lv6itWRUxrlHRBd85WVX00MiDR1jHRT7Y6NikVmXALI
X-Google-Smtp-Source: AGHT+IF/C6oWT8UwF1sEc7lk12OQ3847JVrL7Xi1bCnoAAIGAt33I27+pHrZ0wCfK5j980LBTwOBoA==
X-Received: by 2002:a05:6000:1846:b0:3ee:15b4:846c with SMTP id
 ffacd0b85a97d-40e44682b8dmr16577132f8f.28.1759170848080; 
 Mon, 29 Sep 2025 11:34:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm234657245e9.17.2025.09.29.11.34.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:34:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 13/15] system/physmem: Inline cpu_physical_memory_rw() and
 remove it
Date: Mon, 29 Sep 2025 20:32:52 +0200
Message-ID: <20250929183254.85478-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

After inlining the legacy cpu_physical_memory_rw() in the 2 functions
using it (cpu_physical_memory_read and cpu_physical_memory_write), we
removed all its use: remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst            |  4 +---
 scripts/coccinelle/exec_rw_const.cocci | 22 ----------------------
 include/exec/cpu-common.h              |  2 --
 system/physmem.c                       | 13 ++++---------
 4 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index f9b565da57a..c906c6509ee 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -460,10 +460,8 @@ For new code they are better avoided:
 
 ``cpu_physical_memory_write``
 
-``cpu_physical_memory_rw``
-
 Regexes for git grep:
- - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
+ - ``\<cpu_physical_memory_\(read\|write\)\>``
 
 ``cpu_memory_rw_debug``
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 1a202969519..4c02c94e04e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -21,13 +21,6 @@ expression E1, E2, E3, E4, E5;
 + address_space_rw(E1, E2, E3, E4, E5, true)
 |
 
-- cpu_physical_memory_rw(E1, E2, E3, 0)
-+ cpu_physical_memory_rw(E1, E2, E3, false)
-|
-- cpu_physical_memory_rw(E1, E2, E3, 1)
-+ cpu_physical_memory_rw(E1, E2, E3, true)
-|
-
 - cpu_physical_memory_map(E1, E2, 0)
 + cpu_physical_memory_map(E1, E2, false)
 |
@@ -62,18 +55,6 @@ symbol true, false;
 + address_space_write(E1, E2, E3, E4, E5)
 )
 
-// Avoid uses of cpu_physical_memory_rw() with a constant is_write argument.
-@@
-expression E1, E2, E3;
-@@
-(
-- cpu_physical_memory_rw(E1, E2, E3, false)
-+ cpu_physical_memory_read(E1, E2, E3)
-|
-- cpu_physical_memory_rw(E1, E2, E3, true)
-+ cpu_physical_memory_write(E1, E2, E3)
-)
-
 // Remove useless cast
 @@
 expression E1, E2, E3, E4, E5, E6;
@@ -93,9 +74,6 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
 
-- cpu_physical_memory_rw(E1, (T *)(E2), E3, E4)
-+ cpu_physical_memory_rw(E1, E2, E3, E4)
-|
 - cpu_physical_memory_read(E1, (T *)(E2), E3)
 + cpu_physical_memory_read(E1, E2, E3)
 |
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6e8cb530f6e..910e1c2afb9 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -131,8 +131,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  */
 void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write);
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
 void *cpu_physical_memory_map(hwaddr addr,
diff --git a/system/physmem.c b/system/physmem.c
index 5a0ee3b8e58..93e9550338f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3181,21 +3181,16 @@ MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
     return error;
 }
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write)
-{
-    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
-                     buf, len, is_write);
-}
-
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, buf, len, false);
+    address_space_read(&address_space_memory, addr,
+                       MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
+    address_space_write(&address_space_memory, addr,
+                        MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 /* used for ROM loading : can write in RAM and ROM */
-- 
2.51.0


