Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED22BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHt8-0001CG-AZ; Tue, 18 Aug 2026 07:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHt5-00018x-4N
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHt3-0006vL-Nq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41+zTX9PYewEXCgoj+8i1yGWshCEvT30KUKjAlCzF0c=;
 b=KH1T46EYesMMLkewW6Pivi0kR+VmXQiEFUsZkebKEEkKiLMLEwb2SCem5UXipyRqKgU5qA
 WNUS5Hs11kP4M+L+ft7UaPDcy3uVzY8tO9gP881bqU+S6ThCdwotyIb0CES5yRGCwuNUWO
 10ABet/1F8pl3a3n9+jPov5TyH9bS4E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-SCPr_m96OrqVDVyMjOLvtw-1; Tue,
 18 Aug 2026 07:21:40 -0400
X-MC-Unique: SCPr_m96OrqVDVyMjOLvtw-1
X-Mimecast-MFC-AGG-ID: SCPr_m96OrqVDVyMjOLvtw_1787052099
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6ABA18001DE; Tue, 18 Aug 2026 11:21:39 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34C363000239; Tue, 18 Aug 2026 11:21:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:05 +0400
Subject: [PATCH v3 38/74] target/i386: fix CPUID version properties
 typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-38-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=583Lvb2dPvaGuNJ8Al1TkNvjTaOLls8qtGDI3WwoRPE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD26Yju7JmQaDh5z+b+hhhUQwi8gmk1ScJeLF
 wnp/WuOYi+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9ugAKCRDa6OEJdZac
 5WHpEACQczrDSymzqfLyqC/nthj7Q7FerypqMZ3/TyxeFDQ7OXgDtAKGKCO3oyAoGw1BdhuN5Vz
 J39Mg+rXbx4r6H5DQq06nHc0W9ceT+inVk7AjQPtYll7lPES7WfSjYWPJOvtvt+XWxHgWrH9MNf
 qvVLExlk40q1/lxjPGcRxQBCIgRJ/G+Lc6T0E8Fv3t3ELKxnAyhX2qJwX/P9uziUVh+NDu6InRh
 S7fDBsPDD3gFvZyZOZvyo/G65TkmgGK/tPMudtzjBHG8jXxIDT9/8dOE8UWc0itAON2qj7DUTBW
 UriZiyz3X8COxKfNRnlEp1GPUQpEUnN+RgqzvrHm+Ads7emSrUisn/zpHYCkz02IeAcu92katxH
 mhlK82aDZI/88mMIZ7wmEovavJXIRRIxk5/DQ1keQbtKKS914MYX5zPGsVyZ9om+j6FShPTgCDr
 hYl6NWrYGGIgmqjgeRSsC8DCSQcwfKKV9yDz3QzWJ67gSa6/W1iX3FEqtXwpFTh4qo6sVa9a1ea
 xfaLNwvCFmEHpvEsVHlp/ylcMzX9IeDJtB9VFPqajGTftzyuZePE/Xi+t1BWPRN9YpJQDQH1xM8
 RKPzVwLiHNDJhw3v164eZRaS0qR1T3AYOGp8bULzWa3FVa/LCWIs9vLt2hN4UCQbKoEJYTsJ6ae
 dQZ28nXi/oGJqlg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The getter and setter use visit_type_uint64, not visit_type_int.

Fixes: 3e0dceaf9450 ("i386: Register most CPU properties as class properties")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3b30ded0cc02..567cbf04ca75 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10947,13 +10947,13 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 
     dc->user_creatable = true;
 
-    object_class_property_add(oc, "family", "int",
+    object_class_property_add(oc, "family", "uint64",
                               x86_cpuid_version_get_family,
                               x86_cpuid_version_set_family, NULL, NULL);
-    object_class_property_add(oc, "model", "int",
+    object_class_property_add(oc, "model", "uint64",
                               x86_cpuid_version_get_model,
                               x86_cpuid_version_set_model, NULL, NULL);
-    object_class_property_add(oc, "stepping", "int",
+    object_class_property_add(oc, "stepping", "uint64",
                               x86_cpuid_version_get_stepping,
                               x86_cpuid_version_set_stepping, NULL, NULL);
     object_class_property_add_str(oc, "vendor",

-- 
2.55.0.543.g5ebe2ebe4ea8


