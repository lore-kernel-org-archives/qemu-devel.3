Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF31C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnO-0005kM-VB; Tue, 23 Apr 2024 11:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnK-0005Jt-QA
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnJ-0000Lq-2A
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBmnXuBpjnc81Gq2MR5tg8WIKRNSzy52xwv04f31Lgg=;
 b=SGLTGAldd36/ize16UE2QE9ayOH+I/sfFdkyQoX13qdzcf5B9zM7/b5B1ErvHezA2F4JKv
 qZUjjN9CE2GwqnxBJVSg+o33TVm6ClRTjxid3xo0vsKIXzOvPT8wRYbr0BKEu/hiACLz8n
 ZkYn3syA76q6opUFuzbj75ExLTsqcRw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-CgToX6NaMcuHGhTVoRtZ7g-1; Tue, 23 Apr 2024 11:10:50 -0400
X-MC-Unique: CgToX6NaMcuHGhTVoRtZ7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D79680D0FA;
 Tue, 23 Apr 2024 15:10:50 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12D92200E290;
 Tue, 23 Apr 2024 15:10:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 58/63] target/i386/host-cpu: Consolidate the use of
 warn_report_once()
Date: Tue, 23 Apr 2024 17:09:46 +0200
Message-ID: <20240423150951.41600-59-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Use warn_report_once() to get rid of the static local variable "warned".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240327103951.3853425-2-zhao1.liu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 92ecb7254b8..280e427c017 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -55,18 +55,15 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
 {
     uint32_t host_phys_bits = host_cpu_phys_bits();
     uint32_t phys_bits = cpu->phys_bits;
-    static bool warned;
 
     /*
      * Print a warning if the user set it to a value that's not the
      * host value.
      */
-    if (phys_bits != host_phys_bits && phys_bits != 0 &&
-        !warned) {
-        warn_report("Host physical bits (%u)"
-                    " does not match phys-bits property (%u)",
-                    host_phys_bits, phys_bits);
-        warned = true;
+    if (phys_bits != host_phys_bits && phys_bits != 0) {
+        warn_report_once("Host physical bits (%u)"
+                         " does not match phys-bits property (%u)",
+                         host_phys_bits, phys_bits);
     }
 
     if (cpu->host_phys_bits) {
-- 
2.44.0



