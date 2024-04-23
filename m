Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255BEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHne-0007Kn-AG; Tue, 23 Apr 2024 11:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmw-0004Wh-7P
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmu-0000DK-LS
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/djvnyJ3G6gPXkBG8EvhWuhVdBWgADMbB39ElX9mpc=;
 b=eU4eMpXqXP0NXcPAeBHeNxIDWyGjg4HCD8gINrTA1kIDYeSa1A39ileq9CcmvOzRVOMLh2
 j9rMI4MOsDuSLly322IkgqoJzI1TfnZLv1Dwc/HWSZvFbiX0I9EViOFFqEaLCQQvd6R0SV
 iEfWO132zMT/DhIbOAGN4xT1gvBNEXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-dR4necVZMkG3922FPYbx4g-1; Tue, 23 Apr 2024 11:10:23 -0400
X-MC-Unique: dR4necVZMkG3922FPYbx4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AED98104B502;
 Tue, 23 Apr 2024 15:10:22 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E550200E290;
 Tue, 23 Apr 2024 15:10:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 28/63] target/i386: Export RFDS bit to guests
Date: Tue, 23 Apr 2024 17:09:16 +0200
Message-ID: <20240423150951.41600-29-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Register File Data Sampling (RFDS) is a CPU side-channel vulnerability
that may expose stale register value. CPUs that set RFDS_NO bit in MSR
IA32_ARCH_CAPABILITIES indicate that they are not vulnerable to RFDS.
Similarly, RFDS_CLEAR indicates that CPU is affected by RFDS, and has
the microcode to help mitigate RFDS.

Make RFDS_CLEAR and RFDS_NO bits available to guests.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <9a38877857392b5c2deae7e7db1b170d15510314.1710341348.git.pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c295491d8ae..eda15b0d4c7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1158,8 +1158,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "pbrsb-no", NULL, "gds-no", NULL,
-            NULL, NULL, NULL, NULL,
+            "pbrsb-no", NULL, "gds-no", "rfds-no",
+            "rfds-clear", NULL, NULL, NULL,
         },
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
-- 
2.44.0



