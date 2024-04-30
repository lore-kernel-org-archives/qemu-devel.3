Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150BAC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgg-0000o7-94; Tue, 30 Apr 2024 03:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgd-0000l9-Gk
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgb-0008LU-NW
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WO0cazHO1vt/szaLwBNGrdEVdokAYebHK8BnXwtiomQ=;
 b=UzLTc5NIPVc9ugbZOZR+fSav5JrR5TdTmCLB/zlZrmnpXVr6/Qf7Wv95rkAUYVKeIcyZAy
 Q/YGj6qZ3iQCw085huwvFErmzcLDp2kXaMVM0us5q4cg0Jk75wMHyCeRbmMdjMbNK59jx+
 uxM84pJ9MfP9x8Tu/v79wNCcetCd8rk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-NOJH6XmBOM2YtRO_8bb5og-1; Tue,
 30 Apr 2024 03:13:53 -0400
X-MC-Unique: NOJH6XmBOM2YtRO_8bb5og-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A51F1C031A6;
 Tue, 30 Apr 2024 07:13:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 462F840C6CC0;
 Tue, 30 Apr 2024 07:13:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/19] target/s390x/cpu_models_sysemu: Drop local @err in
 apply_cpu_model()
Date: Tue, 30 Apr 2024 09:13:27 +0200
Message-ID: <20240430071340.413305-7-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

Use @errp to fetch error information directly and drop the local
variable @err.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240425031232.1586401-8-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models_sysemu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index bf855c659d..15be729c3d 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -389,7 +389,6 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
 
 void apply_cpu_model(const S390CPUModel *model, Error **errp)
 {
-    Error *err = NULL;
     static S390CPUModel applied_model;
     static bool applied;
 
@@ -405,8 +404,7 @@ void apply_cpu_model(const S390CPUModel *model, Error **errp)
     }
 
     if (kvm_enabled()) {
-        if (!kvm_s390_apply_cpu_model(model, &err)) {
-            error_propagate(errp, err);
+        if (!kvm_s390_apply_cpu_model(model, errp)) {
             return;
         }
     }
-- 
2.44.0


