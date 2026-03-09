Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C766FCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPJ-0004lG-3U; Mon, 09 Mar 2026 16:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP3-0004f6-NX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP1-0007iA-NG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ln9f0V7PnAMgCBfotMt4QR41AJsGNe4HewJnIjGquU=;
 b=DBLL66lkETp/K5hXyxXmRx5E86Ptllgoa/Uv7NDt36sKLQ7AawSr8a6bCgdT1NZazOu8cz
 cND13h5AiaFS53alfaB52PQFGi4ssuNpjloFcxtYZBaITTzTl7RuIJoSJ14403iC4WeKF/
 bClwsFF4hNcQY8qpuQzbWGaYcmzJXKw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-8OXwUvfDMhe3ml7v5tVXNg-1; Mon, 09 Mar 2026 16:40:29 -0400
X-MC-Unique: 8OXwUvfDMhe3ml7v5tVXNg-1
X-Mimecast-MFC-AGG-ID: 8OXwUvfDMhe3ml7v5tVXNg_1773088829
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-506a07740bdso27727631cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088829; x=1773693629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ln9f0V7PnAMgCBfotMt4QR41AJsGNe4HewJnIjGquU=;
 b=GLaNfjHe7pJjxX8Ri7c4DtbaBdIK3oRiKe1L7oXSj7gom1pT4HYMMJyU+AnZSi3LnQ
 PQIYV3JEZP2EJZenjmPisezwqbSne/rWoXMnuCW8chF287YIVn74XzFHMZymQN8/T/K/
 /V9mdgUw+Gs5uUzEgQqLlELcsdbGmFB7dshUtO2SwjVIXlZn5GeV4YiZCwQ+yhCPP5Ol
 kjdKePbDKGdn6Nh59vVNFtmFnlX6MDUi6eP62ot2RDgDMM4Lrfs7uSZ9fwjsXhvFsue+
 5v+K5os+HZMHgeJ43FW8wradBWreq0k+L737s/dLT5jUmltdpdpPn3Cps3H7g0Oc4rdq
 0yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088829; x=1773693629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Ln9f0V7PnAMgCBfotMt4QR41AJsGNe4HewJnIjGquU=;
 b=GNkL2eJe3FrjHRg+asQoNTo/HnHXjM/L2Zh60T11hXoe9NIQlEb7zI5WyyIaJSG4eC
 e2Dzfaqf9MD3eu3spxKyzhHuQOFRR9GgoxkCycllDvKJlntHPqN/l4NxBFUQFA9jLHeo
 vjDNObk6JCrmxoI2AkEuNWrhnqyaaf2Jn00exV0FQsy4xkHRntXu2/2c2Rnt+Sy6FiXk
 lKEsLUJjMnrgJmF/TeUqYbudWT5DILhUAi+qDtvwnFJkiEqti000NlCO5G2CWUdtalkk
 qiDD8LpvvmaoWZ0gqq1NDC6CYmpScnQFrQ5h8W0dpxa6+cDayM5ev/inLAwHcQFMjtT6
 IFrw==
X-Gm-Message-State: AOJu0Yynz/+5Z4FWgsJqk0A6Lx46uxtmQ0IDZh61ybosLd2xq91ZIUxT
 6oWWJ07WR+H3yhROi1v6VI3d2rs3vCBfWg+KM0YkvHDfQZkUbb1QzH5SdcALnB4Uqc8eNGwIKZX
 /k6YO+01Cxh+HhB+ooVEK0XHw7ji8vJdK2Bc24dvVsgDtkRXYb3VsSL54GEkt8FB9wdi3gHqBTo
 Vlm8RmKa/Kj8Hn+U1tsCact2rFF5jnyoQkW1rgkw==
X-Gm-Gg: ATEYQzwLT2AcYzdT+btYmDg5qUd1YCXj+jBuZqVanIqhAOZPmX1TuF8qcCkXPjd7hVP
 1Vgsaj/C+yws/vqKvfUyOMPSoOc0quxFUgqvQV9kw95WNKIeRGKJykR8gEWfpjg3sbsT80LnimH
 opqDLg465AESjn48LhVEtpiHyVnE8/+VharG8ImD5UBcdXGtn72QgoJYROf/9Ufx7kWZZ0XJXVU
 0y81rq+hf+WYkRF2p4F7EkdktzpJuaIzAG8nklRKc6ggp0UF571oaEMx1d1Ds28oS/jJyZQ9QxU
 I8uehhEap2gtw/PiL7vvSo2AN70H7qedleOcqxh4x/d+xOc3L9JuJzbv/xAC02ByaQrFJajleGn
 qZnrZD6wHE3UTERmvNIk9gSusC+M+XuE6NrZjN5ecfhuEYxmgOvNtbEvaNwTLn6D4ikiG9Y9wMa
 dItaP0Rg==
X-Received: by 2002:a05:620a:904b:b0:8cd:7ba1:ad with SMTP id
 af79cd13be357-8cd7ba10695mr715239485a.63.1773088828870; 
 Mon, 09 Mar 2026 13:40:28 -0700 (PDT)
X-Received: by 2002:a05:620a:904b:b0:8cd:7ba1:ad with SMTP id
 af79cd13be357-8cd7ba10695mr715235785a.63.1773088828164; 
 Mon, 09 Mar 2026 13:40:28 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 09/18] memory: Factor out common ram ptr initialization
Date: Mon,  9 Mar 2026 16:39:58 -0400
Message-ID: <20260309204007.1709441-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

Introduce internal helper function to remove duplicated code from
different memory_region_init_ram_*ptr functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Link: https://lore.kernel.org/r/7c5a31fc2202e6927437ed57cb9ce08a224f2a50.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 2cda814bd6..f1db72eb42 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1649,31 +1649,30 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
 }
 #endif
 
+static void memory_region_set_ram_ptr(MemoryRegion *mr, uint64_t size,
+                                      void *ptr)
+{
+    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
+    assert(ptr != NULL);
+    RAMBlock *rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    memory_region_set_ram_block(mr, rb);
+}
+
 void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
                                 const char *name, uint64_t size,
                                 void *ptr)
 {
-    RAMBlock *rb;
-
     memory_region_init(mr, owner, name, size);
-    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
-    assert(ptr != NULL);
-    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
-    memory_region_set_ram_block(mr, rb);
+    memory_region_set_ram_ptr(mr, size, ptr);
 }
 
 void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        const char *name, uint64_t size,
                                        void *ptr)
 {
-    RAMBlock *rb;
-
     memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
     mr->ram_device = true;
-    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
-    assert(ptr != NULL);
-    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
-    memory_region_set_ram_block(mr, rb);
+    memory_region_set_ram_ptr(mr, size, ptr);
 }
 
 void memory_region_init_alias(MemoryRegion *mr, Object *owner,
-- 
2.50.1


