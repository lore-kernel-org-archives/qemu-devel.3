Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43A6C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgR6e-0000uk-Dc; Fri, 07 Feb 2025 11:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6S-0000sL-LL
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6Q-0007WH-6g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738945273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyuAjPAUeA1HKK8QUbzGtEGxr0V5B53mz4cYKLRd53Q=;
 b=DO2MBtyWUKVelmeIUSZqJwnI1cm8MACHbpdS8TpevI560MLGPCgA2t1cOHfH+R9YVdzPSx
 AzHNjLLTUPfF9D12+jeOlkZZPPMSttGLkB6EYcaICFL1fbZCx+gydd70+9VS3lcZdFCgbu
 uV46nyu6fMAtdG4VPRV6s1hN80ZKkiw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-4UFneXOSOUyTq_sLYdJdEg-1; Fri,
 07 Feb 2025 11:21:12 -0500
X-MC-Unique: 4UFneXOSOUyTq_sLYdJdEg-1
X-Mimecast-MFC-AGG-ID: 4UFneXOSOUyTq_sLYdJdEg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA09D1955D82; Fri,  7 Feb 2025 16:21:09 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13F781800879; Fri,  7 Feb 2025 16:21:07 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 06/10] tcg: drop cpu->created check
Date: Fri,  7 Feb 2025 17:20:44 +0100
Message-ID: <20250207162048.1890669-7-imammedo@redhat.com>
In-Reply-To: <20250207162048.1890669-1-imammedo@redhat.com>
References: <20250207162048.1890669-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

previous commits fixed 2 remaining cases where vcpu might
have had 'cpu->created == false' during 1st vcpu reset (at realize time)
that leads to call chain
      tcg_cpu_reset_hold() => tlb_flush_by_mmuidx()

remove not need anymore check, with cpu->created always being true.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Nicholas Piggin <npiggin@gmail.com>
---
 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3d1d7d2409..6ccb173960 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -75,7 +75,7 @@
 } while (0)
 
 #define assert_cpu_is_self(cpu)                             \
-    tcg_debug_assert(!(cpu)->created || qemu_cpu_is_self(cpu))
+    tcg_debug_assert(qemu_cpu_is_self(cpu))
 
 /* run_on_cpu_data.target_ptr should always be big enough for a
  * vaddr even on 32 bit builds
@@ -416,7 +416,7 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
-    if (cpu->created && !qemu_cpu_is_self(cpu)) {
+    if (!qemu_cpu_is_self(cpu)) {
         async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
                          RUN_ON_CPU_HOST_INT(idxmap));
     } else {
-- 
2.43.0


