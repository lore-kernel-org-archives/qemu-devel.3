Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01677D68B07
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZUF-0001TH-P5; Thu, 14 Nov 2024 08:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tBZU7-0001RP-0J
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:02:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tBZU5-0000pn-GL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731589323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+cQHtUOBfbOs30uzCEMVqmO/g4Tbyjvq9PnFhrVzmis=;
 b=ba47n6mtSBlx1XB00g3ECr8C3R/kjV7XkSzj1xLyFSRN06SXgT+vKuWMirPoWu27VJzmvL
 +45b9IwB/ckkxZbIrN4905rPwLfSEYfpnA9YX0Q8MuUiTbvdIXtMwdHnDbtk44v8y0CjxM
 pCPr+pbxwmte86YelEWrVOsxE9XO0oM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-q_fvrEItNjyHDq1-dN6flw-1; Thu,
 14 Nov 2024 08:01:57 -0500
X-MC-Unique: q_fvrEItNjyHDq1-dN6flw-1
X-Mimecast-MFC-AGG-ID: q_fvrEItNjyHDq1-dN6flw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77694195394A; Thu, 14 Nov 2024 13:01:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.10])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0096C1956054; Thu, 14 Nov 2024 13:01:53 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] target/i386: Fix !CONFIG_SYNDBG build
Date: Thu, 14 Nov 2024 14:01:52 +0100
Message-ID: <20241114130152.352009-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Commit bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG
enablement") broke !CONFIG_SYNDBG builds as hyperv_syndbg_query_options()
is missing there. The idea probably was that as "hv-syndbg" is now under
'#ifdef CONFIG_SYNDBG', hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) cannot
be true anyway.

It would have been possible to add a stub for hyperv_syndbg_query_options()
instead of resurrecting '#ifdef CONFIG_SYNDBG' but avoiding
HV_X64_MSR_SYNDBG_OPTIONS altogether instead of zeroing it when
!CONFIG_SYNDBG seems preferable.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG enablement")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm/kvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8e17942c3ba1..11f9526c8f8c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4034,11 +4034,13 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                 kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS,
                                   env->msr_hv_tsc_emulation_status);
             }
+#ifdef CONFIG_SYNDBG
             if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) &&
                 has_msr_hv_syndbg_options) {
                 kvm_msr_entry_add(cpu, HV_X64_MSR_SYNDBG_OPTIONS,
                                   hyperv_syndbg_query_options());
             }
+#endif
         }
         if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_APIC_ASSIST_PAGE,
-- 
2.47.0


