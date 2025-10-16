Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42606CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QoV-0003GS-KB; Thu, 16 Oct 2025 12:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9QoJ-00031E-Tk
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9QoC-00052O-Qp
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760631989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RU7Man4KnRGIbs9jMvnj9ufvxV6EUPeaR+Ae0LV/CMk=;
 b=Hu946loDZ9z6tnUuUJO+4hgLFEfyzHxkPx/Azn39BqcbhsPGPUhbNtmqVbUPo2ULje4A18
 qf2bIhjCd/OyatcnJ+8v/PCYpassWjJsmExuhE2xM8hpOUPBSPKQ0gEfVtxyUhWpInqdTa
 hTN/nHB0aiKbhdXtEFIcMaH1XaF5qrs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-GPgSTenWN-SFRTepFfT9oQ-1; Thu,
 16 Oct 2025 12:26:26 -0400
X-MC-Unique: GPgSTenWN-SFRTepFfT9oQ-1
X-Mimecast-MFC-AGG-ID: GPgSTenWN-SFRTepFfT9oQ_1760631985
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 299FF18002C1; Thu, 16 Oct 2025 16:26:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBDDD1956056; Thu, 16 Oct 2025 16:26:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] target/s390x/mmu_helper: Simplify s390_cpu_virt_mem_rw()
 logic
Date: Thu, 16 Oct 2025 18:26:00 +0200
Message-ID: <20251016162601.442557-10-thuth@redhat.com>
In-Reply-To: <20251016162601.442557-1-thuth@redhat.com>
References: <20251016162601.442557-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to simplify the next commit, move the
trigger_access_exception() call after the address_space_rw()
calls. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251008141410.99865-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/mmu_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 487c41bf933..22d3d4a97df 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -541,9 +541,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
     pages = g_malloc(nr_pages * sizeof(*pages));
 
     ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
-    if (ret) {
-        trigger_access_exception(&cpu->env, ret, tec);
-    } else if (hostbuf != NULL) {
+    if (ret == 0 && hostbuf != NULL) {
         AddressSpace *as = CPU(cpu)->as;
 
         /* Copy data by stepping through the area page by page */
@@ -556,6 +554,9 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
             len -= currlen;
         }
     }
+    if (ret) {
+        trigger_access_exception(&cpu->env, ret, tec);
+    }
 
     g_free(pages);
     return ret;
-- 
2.51.0


