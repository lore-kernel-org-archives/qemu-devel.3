Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15718C3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9koI-0000Ll-LJ; Tue, 29 Apr 2025 09:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9koH-0000LR-Na
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9koF-00040U-Sg
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745932538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYS7R6zEdHl6MbeKrXmrsQiG55u3uarQSO6zcHZcyEU=;
 b=bwKZx9x0JdR/RamrtZ63i2jZ0q8Qpv9IvRyrvX0Z9l1WBuDcot6E3sQpmrEpcR9C+os0yk
 q7bKX4Tp2tSAht3Ghn/Sjb+zZg9gawARvRNT9tzPkRpJT73oiefi0fKUErzKG3JIP/CP8s
 XfznMzS0Zf+Cm0rakQcAd+P3dfiPzf0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-7H3a5dhFNK-qLLubdao1ww-1; Tue,
 29 Apr 2025 09:15:37 -0400
X-MC-Unique: 7H3a5dhFNK-qLLubdao1ww-1
X-Mimecast-MFC-AGG-ID: 7H3a5dhFNK-qLLubdao1ww_1745932535
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 697791956086; Tue, 29 Apr 2025 13:15:35 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.98])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6119180047F; Tue, 29 Apr 2025 13:15:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/5] Revert "include/hw: temporarily disable deletion of
 versioned machine types"
Date: Tue, 29 Apr 2025 14:15:22 +0100
Message-ID: <20250429131526.1842130-2-berrange@redhat.com>
In-Reply-To: <20250429131526.1842130-1-berrange@redhat.com>
References: <20250429131526.1842130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

This reverts commit c9fd2d9a48ee3c195cf83cc611b87b09f02f0013.

When we introduced the specialized machine type deprecation policy, we
allow automatic deprecation to take effect immediately, but blocked the
automatic deletion of machine types for 2 releases. This ensured we
complied with the historical deprecation policy during the transition
window. Startnig with the 10.1.0 dev cycle, the old machine types would
be candidates for removal under both the old and new deprecation
policies.

Thus we can now enable automatic deletion of old machine types, which
takes effect by skipping the QOM type registration. This prevents the
machine types being listed with '-machine help', and blocks their
creation. The actual code can be purged at a convenient time of the
maintainer's choosing.

In the case of the x86_64 target, this change results in the blocking
of the following machine types:

  pc-i440fx-4.0        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-3.1        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-3.0        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.8        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.7        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.6        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.5        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.4        Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.12       Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.11       Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-i440fx-2.10       Standard PC (i440FX + PIIX, 1996) (deprecated)
  pc-q35-4.0.1         Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-4.0           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-3.1           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-3.0           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.9           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.8           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.7           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.6           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.5           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.4           Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.12          Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.11          Standard PC (Q35 + ICH9, 2009) (deprecated)
  pc-q35-2.10          Standard PC (Q35 + ICH9, 2009) (deprecated)

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 765dc8dd35..74a8e96b2e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -719,28 +719,11 @@ struct MachineState {
  * suitable period of time has passed, it will cause
  * execution of the method to return, avoiding registration
  * of the machine
- *
- * The new deprecation and deletion policy for versioned
- * machine types was introduced in QEMU 9.1.0.
- *
- * Under the new policy a number of old machine types (any
- * prior to 2.12) would be liable for immediate deletion
- * which would be a violation of our historical deprecation
- * and removal policy
- *
- * Thus deletions are temporarily gated on existance of
- * the env variable "QEMU_DELETE_MACHINES" / QEMU version
- * number >= 10.1.0. This gate can be deleted in the 10.1.0
- * dev cycle
  */
 #define MACHINE_VER_DELETION(...) \
     do { \
         if (MACHINE_VER_SHOULD_DELETE(__VA_ARGS__)) { \
-            if (getenv("QEMU_DELETE_MACHINES") || \
-                QEMU_VERSION_MAJOR > 10 || (QEMU_VERSION_MAJOR == 10 && \
-                                            QEMU_VERSION_MINOR >= 1)) { \
-                return; \
-            } \
+            return; \
         } \
     } while (0)
 
-- 
2.49.0


