Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D66C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 09:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tatmA-0002HA-Ld; Thu, 23 Jan 2025 04:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tatm8-0002GZ-Al
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tatm6-0001uJ-Fe
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737625520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hGTKRlUSztr+9KC4MgLGOzIAbq2yLAadRzmAXxkQRdY=;
 b=IB2q57ZBcZmvH9MVpc+XxgtTUcQr9y10WCxFCiV7xwjv6Dx0Pwaw+yo5sXYqoicIq27Srt
 yVMnlLuIfhFxppvG9O/gcymXT8z7Qei/n62uFf8yx1FvrQ+rooa2mt47K7NEswBZj7XmZU
 A934iHqLDsihIu8eZjRD76UlziBbGGg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-CFfr0ENHPkSGzPpgfNa_sQ-1; Thu,
 23 Jan 2025 04:45:18 -0500
X-MC-Unique: CFfr0ENHPkSGzPpgfNa_sQ-1
X-Mimecast-MFC-AGG-ID: CFfr0ENHPkSGzPpgfNa_sQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62C251955DDE; Thu, 23 Jan 2025 09:45:16 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7D4819560AD; Thu, 23 Jan 2025 09:45:14 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com
Subject: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
Date: Thu, 23 Jan 2025 10:45:11 +0100
Message-ID: <20250123094511.156324-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

QEMU will crash with following debug enabled
  # define DEBUG_TLB_GATE 1
  # define DEBUG_TLB_LOG_GATE 1
due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_async_work]
functions are called not only from vcpu thread but also from reset handler
that is called from main thread at cpu realize time when vcpu is already
created
  x86_cpu_new -> ... ->
      x86_cpu_realizefn -> cpu_reset -> ... ->
          tcg_cpu_reset_hold

drop assert to fix crash.

1)
Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/cputlb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b26c0e088f..2da803103c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     uint16_t all_dirty, work, to_clean;
     int64_t now = get_clock_realtime();
 
-    assert_cpu_is_self(cpu);
-
     tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
@@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
 {
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
-    assert_cpu_is_self(cpu);
-
     tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
 }
 
-- 
2.43.0


