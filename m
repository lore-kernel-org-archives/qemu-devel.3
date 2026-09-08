Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E851C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQ7-0003u4-Mp; Tue, 08 Sep 2026 11:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ6-0003tu-KJ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ5-0007e0-4p
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mc9WWxagH6BIKpm9sPBl1zrbQ71D51GLQin1RXp0VbY=;
 b=TV3dXWW+dBlUNE0f8CNrGrBJsU30Eb32m1xgT0ezHICUHHTgrzJ6f543iBfN9yH8b1S3fo
 abRMolNh9HOgKyGbyXgyMWBNJqStyIgRwgjtKUTwWbwqiIBcJM8/XszXu8PUTkVd8fssVc
 ntYxCZ2qphaTloQc5LLkQRSv64Fe0HQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-fFQrVZTsOYyvLhfZMlm6fw-1; Tue,
 08 Sep 2026 11:07:31 -0400
X-MC-Unique: fFQrVZTsOYyvLhfZMlm6fw-1
X-Mimecast-MFC-AGG-ID: fFQrVZTsOYyvLhfZMlm6fw_1788880050
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 035AC184A082; Tue,  8 Sep 2026 15:07:30 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BB137D5; Tue,  8 Sep 2026 15:07:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:52 +0400
Subject: [GIT PULL 09/15] target/i386: fix CPUID version properties
 typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-9-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kP3Te0YRR83ny2MmXoL4HxVifgr/hleQYiwK4LsgbZM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSP0R36rM89jZQHaoQXkfuSCpKHmenkGi2iW
 Eih4HatiE6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5dfmEACV+JzFQQE44aim6JQL3rFIDv/EydgYCTCCXof4l4h+ZHaip+o3IpHdX7Av41Y69LaWa1q
 /ha/o4u94+EV6XW+3SvIe132QFVHdbGh91U2eQJEyHTFxQujBirHv/lniE3sdQBQmPnXFBD91xY
 ty0SlJGHtDZHcf5UFi00XYs/scfYm9JLTyGzTO3fH2a7B9TetTWY6eylTyeCk5VtbSrXrzVTlNO
 KxEm+tdc6qXsDezLTJhqhdjPY1GyEdGJZ3MWY7Y27q4qtRezd+66mNkcFf8NhkdAywrG6p01U8h
 W3c0/j7uRqUX5JUOv2hU/ivAgjmaVLB712xsCMj06TXJ55KSsPg2lfllABq58I4EZhhi0m44p1I
 l44CcSQEfUHBKGEGrhml2hz5Sj50fbPdT3K8IXZGQVabhrTTQTFhValD8/vWtBD6ufS8p2R91sa
 5EGx6bLTmZhaIWgN4NvXwgCUWyUfcNcJWPy6SuHWG9+iYML/mlto/IGcrJyjf6Y+s7cP1/qiSLR
 lBiPFETaka0PkeqXCb3IpF/pF/+oy9pZqsNs+KE6NidZMgU3pRMZGj2zwODtKCmWD9Xn3sg7v5i
 8EaGpaAo5VYq9mD8vKT8waoOsh+CL1TlrgO0GOqDQqCwP2mgySBctd1QA7+mVXrDlaNp5+2gWhT
 ws/MgL6B/TuJzxg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d01ff1948e5e..b97f144aea5a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10946,13 +10946,13 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 
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


