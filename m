Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AF2C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7CFO-0000dO-5R; Thu, 17 Sep 2026 09:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CF6-0000bU-E1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CEy-0003W4-Ho
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789652006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMqYfTijQ33nsHRqkS6ubKuRUZRkxvpFtxxgFqHHGLg=;
 b=hm1nSxok1B5rle0IU6pIq5TYb3oPK39jWKxFwO1hf8PQwJt6YYMTH2skdmkS0Q2+pmG14x
 onZUpsX8O0D5y3LD42ezw3iR8Wi57A5wm7gUkDJGpB+K/nEIsSPNHr4WTzMHB2IEH34yNg
 o4Wwbp9j1Vlps1K2vMj+W8RhYxu4E10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-JUwrULbWPbGo_T_f18qRCg-1; Thu,
 17 Sep 2026 09:33:24 -0400
X-MC-Unique: JUwrULbWPbGo_T_f18qRCg-1
X-Mimecast-MFC-AGG-ID: JUwrULbWPbGo_T_f18qRCg_1789652003
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F6BF18000A3; Thu, 17 Sep 2026 13:33:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.37])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3284B180034C; Thu, 17 Sep 2026 13:33:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3C3761800782; Thu, 17 Sep 2026 15:33:19 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 4/5] hw/uefi: add require-self-signed-pk config option
Date: Thu, 17 Sep 2026 15:33:17 +0200
Message-ID: <20260917133318.2004317-5-kraxel@redhat.com>
In-Reply-To: <20260917133318.2004317-1-kraxel@redhat.com>
References: <20260917133318.2004317-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Traditional edk2 behavior is to require a self-signed platform key when
enrolling secure boot certificates in setup mode.  In 2023 a config
option has been added (PcdRequireSelfSignedPk) which allows to relax
that requirement, see edk2 commit 566cdfc675fa ("SecurityPkg: limit
verification of enrolled PK in setup mode").

This patch adds a similar config option to the qemu uefi variable
driver.

No functional change, the default value for the new config option
maintains existing behavior.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260904085509.2267560-2-kraxel@redhat.com>
---
 include/hw/uefi/var-service.h |  1 +
 hw/uefi/var-service-auth.c    | 25 +++++++++++++++----------
 hw/uefi/var-service-sysbus.c  |  2 ++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
index 7d84025cd58d..7f74b4423381 100644
--- a/include/hw/uefi/var-service.h
+++ b/include/hw/uefi/var-service.h
@@ -76,6 +76,7 @@ struct uefi_vars_state {
     int                               jsonfd;
     bool                              force_secure_boot;
     bool                              disable_custom_mode;
+    bool                              require_self_signed_pk;
     bool                              use_pio;
 
     /* request + reply capture */
diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index 899444af12df..21fc50f904d5 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -201,16 +201,21 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
 
     siglist = uefi_vars_find_siglist(uv, var);
     if (!siglist && setup_mode_is_active(uv) && uefi_vars_is_sb_pk(var)) {
-        /* check PK is self-signed */
-        uefi_variable tmp = {
-            .guid       = EfiGlobalVariable,
-            .name       = (uint16_t *)name_pk,
-            .name_size  = sizeof(name_pk),
-            .attributes = sigdb_attrs,
-            .data       = data + data_offset,
-            .data_size  = va->data_size - data_offset,
-        };
-        return uefi_vars_check_pkcs7_2(&tmp, NULL, NULL, va, data);
+        /* edk2 config option is PcdRequireSelfSignedPk */
+        if (uv->require_self_signed_pk) {
+            /* check PK is self-signed */
+            uefi_variable tmp = {
+                .guid       = EfiGlobalVariable,
+                .name       = (uint16_t *)name_pk,
+                .name_size  = sizeof(name_pk),
+                .attributes = sigdb_attrs,
+                .data       = data + data_offset,
+                .data_size  = va->data_size - data_offset,
+            };
+            return uefi_vars_check_pkcs7_2(&tmp, NULL, NULL, va, data);
+        } else {
+            return true;
+        }
     }
 
     return uefi_vars_check_pkcs7_2(siglist, NULL, NULL, va, data);
diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index 97a96cae6a2b..c4acdea275ad 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -38,6 +38,8 @@ static const Property uefi_vars_sysbus_properties[] = {
                      state.force_secure_boot, false),
     DEFINE_PROP_BOOL("disable-custom-mode", uefi_vars_sysbus_state,
                      state.disable_custom_mode, false),
+    DEFINE_PROP_BOOL("require-self-signed-pk", uefi_vars_sysbus_state,
+                     state.require_self_signed_pk, true),
     DEFINE_PROP_BOOL("use-pio", uefi_vars_sysbus_state,
                      state.use_pio, false),
 };
-- 
2.55.0


