Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FC8CF6482
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIrv-0001Ye-Ar; Fri, 27 Sep 2024 17:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrm-0000vG-Tr
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:51:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrk-0004Wk-BL
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:51:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cdb6ebc1cso557105f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473865; x=1728078665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncMwuXMgt8w0SPLSq4FNQgB95v0Fxit0yyRMSKvDcb8=;
 b=scF2UBIIBiYiLDbYDnsB3QYay6mBwhBxAgIghWKzonYoLiGLKitRMA8Oi9rm7OkZau
 StavgAwciko8YWhNNPF4zLopqce67vrrXmAsZQmPVEfh6tuobs/DEY2lB4ahCaGoODG5
 3EoqZINZAfL8MrXZ7hr72/e0tE5u3yzMVqw8XXndflzsTVVPCNyxhC3+H8A+sP4V+Wrt
 GCEmM0aQwOvxyXiqPkCL9LgZB6G93g+ldLCPNcV1046Qy7CUh9SpA7G9dOVkiTCUQvU9
 bR5ekydBwGTOKEoYSxKE0gPfkCIWI8anFXPf3ccZruY7MspXJLdBnK1lkST9XlyZdr+B
 E1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473865; x=1728078665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncMwuXMgt8w0SPLSq4FNQgB95v0Fxit0yyRMSKvDcb8=;
 b=eLZ9UiJW6ePYEDuUuqsC8iV+7OY3pNmjlsIjMaKZCrM5OdZGauqNdOoj1/YI3jJ0j5
 Hiar4iWnVrJNps3RXBKw65qcgSKqXBNoyOxoQjaUO5UAqQVl4ZyNgn+LC10EcRoSzf7T
 DlH+8rYsnpDZH5s6Vo57BPQ2OK1K4HTpcTdYaUZ1K6JAADwnVPTnLaWnbf4iIKtV37L1
 yehzYGms/8VwQd1uAaQD52Te3eMCKraFyUHi0nxCs37+ceKfoSLLtRebOZpO6z27cJ/X
 A2f8E74rOpEQNOnF24UChsPzf+zolE/1g35LDNHy6WZ0+Y4ak3mjAbNVI9Fw65Far9X8
 MQog==
X-Gm-Message-State: AOJu0YwB5lDF+w8PVweCO6l482qufhBcLUqYK4gjiMYf1W5frOaSnJ5b
 loh/3FUMZkrlEFzVYe2jaWZJnnbliaQWKmAaFBYo4u7hZSyp0c7/w6+3/TiB8lCNkGiv7hByQ8B
 +
X-Google-Smtp-Source: AGHT+IEBAbxD2guHS7kxHuoSHqUr9V2OViIGn0xcMxSiEVBN4ZIL2QhZTS4108ZUqyKQMoygrsHxSQ==
X-Received: by 2002:a05:6000:52:b0:37c:d244:bdb1 with SMTP id
 ffacd0b85a97d-37cd5ad83c8mr2643155f8f.26.1727473865525; 
 Fri, 27 Sep 2024 14:51:05 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd565dd86sm3420517f8f.27.2024.09.27.14.51.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:51:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] hw/ppc/vof: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:50:39 +0200
Message-ID: <20240927215040.20552-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927215040.20552-1-philmd@linaro.org>
References: <20240927215040.20552-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Instead of be32_to_cpu (equivalent of ldl_be_p) and ldq_be_p,
use ldn_be_p(). Similarly instead of cpu_to_be32 (equiv. stl_be_p)
and cpu_to_be64 (equiv. stq_be_p), use stn_be_p().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/vof.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index b5b6514d79..e2549ab786 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -628,6 +628,7 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
     const uint8_t *mem0_reg;
     g_autofree uint8_t *avail = NULL;
     uint8_t *availcur;
+    size_t elsz;
 
     if (!fdt || !claimed) {
         return;
@@ -645,11 +646,8 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
 
     mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
     g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
-    if (sc == 2) {
-        mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);
-    } else {
-        mem0_end = be32_to_cpu(*(uint32_t *)(mem0_reg + sizeof(uint32_t) * ac));
-    }
+    elsz = sc * sizeof(uint32_t);
+    mem0_end = ldn_be_p(mem0_reg + sizeof(uint32_t) * ac, elsz);
 
     g_array_sort(claimed, of_claimed_compare_func);
     vof_claimed_dump(claimed);
@@ -674,18 +672,12 @@ static void vof_dt_memory_available(void *fdt, GArray *claimed, uint64_t base)
             size = mem0_end - start;
         }
 
-        if (ac == 2) {
-            *(uint64_t *) availcur = cpu_to_be64(start);
-        } else {
-            *(uint32_t *) availcur = cpu_to_be32(start);
-        }
-        availcur += sizeof(uint32_t) * ac;
-        if (sc == 2) {
-            *(uint64_t *) availcur = cpu_to_be64(size);
-        } else {
-            *(uint32_t *) availcur = cpu_to_be32(size);
-        }
-        availcur += sizeof(uint32_t) * sc;
+        elsz = ac * sizeof(uint32_t);
+        stn_be_p(&availcur, elsz, start);
+        availcur += elsz;
+        elsz = sc * sizeof(uint32_t);
+        stn_be_p(&availcur, elsz, size);
+        availcur += elsz;
 
         if (size) {
             trace_vof_avail(c.start + c.size, c.start + c.size + size, size);
-- 
2.45.2


