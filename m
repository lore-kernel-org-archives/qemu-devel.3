Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A601EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhGo-0003Z3-5r; Fri, 04 Jul 2025 10:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGX-0003Tt-9b
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGU-0003N1-SN
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751638786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=foOnlwyv8QrsQ+dZSOjXJBg+bfwZx1Nn38s3GMRWlXU=;
 b=PPrlszPJWyvmibQhQn7bmyTwT+y1F/6Sp40NGSl8dNf2CwZagpwayw9VozA0ihEDX+eEY+
 lkctv7c/ZleU6S9qAwDP4oVYNqpVz4AUF2OnQxjUnQxU6CxqXAAX4uWfOx+hKVsjfOJb+x
 75XFgyGT/YxK3KXSETM/o/4aYINSpnE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-ks_vVw6fMvezY3SJ0inyyg-1; Fri,
 04 Jul 2025 10:19:43 -0400
X-MC-Unique: ks_vVw6fMvezY3SJ0inyyg-1
X-Mimecast-MFC-AGG-ID: ks_vVw6fMvezY3SJ0inyyg_1751638782
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E98601808984; Fri,  4 Jul 2025 14:19:41 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.34.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBF4F195608F; Fri,  4 Jul 2025 14:19:39 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 3/5] arm/cpu: fix trailing ',' for SET_IDREG
Date: Fri,  4 Jul 2025 16:19:25 +0200
Message-ID: <20250704141927.38963-4-cohuck@redhat.com>
In-Reply-To: <20250704141927.38963-1-cohuck@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While a trailing comma is not broken for SET_IDREG invocations, it
does look odd; use a semicolon instead.

Fixes: f1fd81291c91 ("arm/cpu: Store aa64mmfr0-3 into the idregs array")
Fixes: def3f1c1026a ("arm/cpu: Store aa64dfr0/1 into the idregs array")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/tcg/cpu64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 00e12ed44ae8..d2f743fb3913 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -352,7 +352,7 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0x8444C004;
     cpu->dcz_blocksize = 4;
-    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull),
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101122ull);
@@ -426,8 +426,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->reset_sctlr = 0x30000180;
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
-    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408),
-    SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000),
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408);
+    SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64AFR0, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64AFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000001122);
@@ -678,13 +678,13 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
     SET_IDREG(isar, ID_AA64AFR1, 0x00000000);
-    SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull),
-    SET_IDREG(isar, ID_AA64DFR1, 0x00000000),
+    SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull);
+    SET_IDREG(isar, ID_AA64DFR1, 0x00000000);
     SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR1, 0x0011000001211032ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
-    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull),
-    SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull),
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     SET_IDREG(isar, ID_AFR0, 0x00000000);
-- 
2.50.0


