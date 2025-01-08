Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769C2E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 08:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRh4-00063T-G9; Wed, 08 Jan 2025 03:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRh2-000638-SS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRh1-0001ln-8g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736325934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rVndIHt+bgwpmrRLpq+1zhzSYm1zDxASyD9TwhDfzM=;
 b=Ou/eKNQqWN34xaxip0yQiFHgOgJCjsiXKtxJzoca8NvYO/SlTIRdtbQRaY38S8f4mC/bv8
 OaNG/P6soQo2AstgyEHvdOyzEvQfSdxuW/v6cfm93IVI/M2s9hNjzQHm/L56GpCagu0L94
 0ThU+W8sBMIvK9t0K/v0yu6u5WW3Xck=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-mcSj9YGDOSC82txXEzUDgA-1; Wed,
 08 Jan 2025 03:45:29 -0500
X-MC-Unique: mcSj9YGDOSC82txXEzUDgA-1
X-Mimecast-MFC-AGG-ID: mcSj9YGDOSC82txXEzUDgA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E319A19560B2; Wed,  8 Jan 2025 08:45:28 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C09419560AA; Wed,  8 Jan 2025 08:45:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 06/14] hw/s390x/ipl: Remove the "iplbext_migration" property
Date: Wed,  8 Jan 2025 09:45:03 +0100
Message-ID: <20250108084511.238458-7-thuth@redhat.com>
In-Reply-To: <20250108084511.238458-1-thuth@redhat.com>
References: <20250108084511.238458-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Now that the old machine types that used this property have been
removed, we can remove the property and the corresponding code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20250103144232.520383-6-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.h |  1 -
 hw/s390x/ipl.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d7d0b7bfd2..8e3882d506 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -80,7 +80,6 @@ struct S390IPLState {
     uint8_t cssid;
     uint8_t ssid;
     uint16_t devno;
-    bool iplbext_migration;
 };
 QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 3a946be7a5..4aa21c91fc 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -49,13 +49,6 @@
 #define BIOS_MAX_SIZE                   0x300000UL
 #define IPL_PSW_MASK                    (PSW_MASK_32 | PSW_MASK_64)
 
-static bool iplb_extended_needed(void *opaque)
-{
-    S390IPLState *ipl = S390_IPL(object_resolve_path(TYPE_S390_IPL, NULL));
-
-    return ipl->iplbext_migration;
-}
-
 /* Place the IPLB chain immediately before the BIOS in memory */
 static uint64_t find_iplb_chain_addr(uint64_t bios_addr, uint16_t count)
 {
@@ -67,7 +60,6 @@ static const VMStateDescription vmstate_iplb_extended = {
     .name = "ipl/iplb_extended",
     .version_id = 0,
     .minimum_version_id = 0,
-    .needed = iplb_extended_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(reserved_ext, IplParameterBlock, 4096 - 200),
         VMSTATE_END_OF_LIST()
@@ -297,8 +289,6 @@ static const Property s390_ipl_properties[] = {
     DEFINE_PROP_STRING("cmdline", S390IPLState, cmdline),
     DEFINE_PROP_STRING("firmware", S390IPLState, firmware),
     DEFINE_PROP_BOOL("enforce_bios", S390IPLState, enforce_bios, false),
-    DEFINE_PROP_BOOL("iplbext_migration", S390IPLState, iplbext_migration,
-                     true),
 };
 
 static void s390_ipl_set_boot_menu(S390IPLState *ipl)
-- 
2.47.1


