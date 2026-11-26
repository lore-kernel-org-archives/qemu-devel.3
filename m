Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790C606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FNwicTCF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWZ0q-0006cU-9I; Thu, 26 Nov 2026 07:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWZ0o-0006bt-Sv
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xWZ0m-0007yh-LB
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 07:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795697739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iz/++PGz2HjBoTtPnTFvamqnpFrP4piWqS/PAD30+Sg=;
 b=FNwicTCFYKG1DYHZd3xFinFoOGLLoTTXlTg6O+uQ/x6fwKgW/EIEI9dMLlrcOtspxGt/PD
 LFj0jj8KguP4JOPrRRZUxWKRKNiypG5MWq+BEzZGPahACn2IXpC48pmI9Q+a1vO1F7KalC
 gWurJcM/EllGTpyjmU7YKjm1HK/H7o4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-5lNb7OsCPQGC50pO1e9NXw-1; Thu,
 26 Nov 2026 12:55:33 +0000
X-MC-Unique: 5lNb7OsCPQGC50pO1e9NXw-1
X-Mimecast-MFC-AGG-ID: 5lNb7OsCPQGC50pO1e9NXw_1795697732
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 594A419560A1; Thu, 26 Nov 2026 12:55:32 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C6B01956087; Thu, 26 Nov 2026 12:55:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, qemu-stable@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 3/4] i386/cpu: Remove AMX-TF32 CPUID bit from Diamond Rapids
Date: Thu, 26 Nov 2026 13:55:23 +0100
Message-ID: <20261126125524.2223648-4-pbonzini@redhat.com>
In-Reply-To: <20261126125524.2223648-1-pbonzini@redhat.com>
References: <20261126125524.2223648-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Chang S. Bae" <chang.seok.bae@intel.com>

A recent update (rev. 62) to the Intel document [1] clarifies that the
feature will not be implemented on Diamond Rapids. Listing it would
result in spurious warnings due to the mismatch. Remove the feature from
the CPU model.

Note [1] (rev. 63) now clarifies that the CPUID bit is reserved rather
than removed. So, the existing CPUID bit enumeration does not conflict
with it and can be retained.

[1] Intel Architecture Instruction Set Extensions and Future Features

Cc: qemu-stable@nongnu.org # v11.0+
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/r/20261119183717.962303-1-chang.seok.bae@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4a..40974bee26c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5729,8 +5729,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             CPUID_1E_1_EAX_AMX_INT8_ALIAS | CPUID_1E_1_EAX_AMX_BF16_ALIAS |
             CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS |
             CPUID_1E_1_EAX_AMX_FP16_ALIAS | CPUID_1E_1_EAX_AMX_FP8 |
-            CPUID_1E_1_EAX_AMX_TF32 | CPUID_1E_1_EAX_AMX_AVX512 |
-            CPUID_1E_1_EAX_AMX_MOVRS,
+            CPUID_1E_1_EAX_AMX_AVX512 | CPUID_1E_1_EAX_AMX_MOVRS,
         .features[FEAT_29_0_EBX] = CPUID_29_0_EBX_APX_NCI_NDD_NF,
         /*
          * Though this bit will be set by avx_version=2, it's better to
-- 
2.56.1



