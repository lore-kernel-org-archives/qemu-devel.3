Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98E2F30937
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6KW-0002E0-10; Thu, 05 Mar 2026 05:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6KR-00020e-Hk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6KQ-0005XG-1J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+6jyk7poB0UCekuUq+atl80jUksDmTZW7oSmAcUmYY=;
 b=VoOw6wlQuFmzHR4Ojgp/m2AJYjCr0TRHiLO4KEyuHYPeoP5mjeo81o+J2FO+QnHVpBNKLC
 z70yzd274UxjjafPpgzaUqxdbuuGMlwvItPUi0wzNCHll6FL6+6hQNN6bxCaO3nkHE89Ve
 O9V28dUACa0zRZYvzBlt9FkNbC8y1VY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-FlTQ2tkqOza3tECSVDtfcA-1; Thu,
 05 Mar 2026 05:53:12 -0500
X-MC-Unique: FlTQ2tkqOza3tECSVDtfcA-1
X-Mimecast-MFC-AGG-ID: FlTQ2tkqOza3tECSVDtfcA_1772707991
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25202195608E; Thu,  5 Mar 2026 10:53:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D4BE3003E9C; Thu,  5 Mar 2026 10:53:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 16/28] tests/qtest/test-x86-cpuid-compat: Remove the test with
 the i440fx-2.9 machine
Date: Thu,  5 Mar 2026 11:52:03 +0100
Message-ID: <20260305105215.302571-17-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The machine has been removed, so the related test can now be removed, too.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260225092024.794595-17-thuth@redhat.com>
---
 tests/qtest/test-x86-cpuid-compat.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 5e0547e81b7..c534e764f82 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -343,17 +343,6 @@ int main(int argc, char **argv)
                    "486", "xlevel2=0xC0000002,xstore=on",
                    NULL, "xlevel2", 0xC0000002);
 
-    /* Check compatibility of old machine-types that didn't
-     * auto-increase level/xlevel/xlevel2: */
-    if (qtest_has_machine("pc-i440fx-2.9")) {
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
-                       "Conroe", NULL, "pc-i440fx-2.9",
-                       "level", 10);
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/on",
-                       "Conroe", "erms=on", "pc-i440fx-2.9",
-                       "level", 10);
-    }
-
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
                      "486", "+arat",
-- 
2.53.0


