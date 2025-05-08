Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C927C3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3un-0008AY-9b; Thu, 08 May 2025 12:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3uk-0008AF-Fr
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3ui-0007cG-Nm
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746720960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vk3jkct9NqEWi40WO0BjLvlM0IgMbodWmh1YSw0hSs0=;
 b=JpvpSHJOo51fj8+0M5UVmXCPZ3bxXVjGzWnxjVKYIKeyGCcs8ncmwLLY+Wvs962lfBsRhL
 0UmfChpN7VoJdsa6pWOUhMp3hXBIf6wiYm4xuyhpS8ue1WJh0uvnrjLczr+QvD59LeZbxh
 6LE3hjHu3GUIpdvSoFwFv02Z6il6Fyc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-vWeumtVXNV6L6WBZwAziGQ-1; Thu,
 08 May 2025 12:15:56 -0400
X-MC-Unique: vWeumtVXNV6L6WBZwAziGQ-1
X-Mimecast-MFC-AGG-ID: vWeumtVXNV6L6WBZwAziGQ_1746720955
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B831800261; Thu,  8 May 2025 16:15:54 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1609180049D; Thu,  8 May 2025 16:15:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/6] Revert "include/hw: temporarily disable deletion of
 versioned machine types"
Date: Thu,  8 May 2025 17:15:32 +0100
Message-ID: <20250508161536.865866-3-berrange@redhat.com>
In-Reply-To: <20250508161536.865866-1-berrange@redhat.com>
References: <20250508161536.865866-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


