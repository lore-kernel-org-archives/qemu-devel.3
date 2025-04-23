Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973F1C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uf1-0003BB-4q; Wed, 23 Apr 2025 03:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uek-000334-EH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uei-0003BM-5W
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYVpO5NqIWhh48UobRgecx4gTGjQhTnDG8PXtrGzc7c=;
 b=e4Gohjmk/HJxZr15IuHMJ4FrIUNgkx+fpJbae47ctLo9pwrYXgF8hnrM4OGpwxsbXxPq8r
 WRK8CYvjUGRIBXc4eQxn0pCet2R/ygwgiy8nAGJjCgcJGqBWOsXX9WxPgegWsfWQekoDmU
 nLvQx6z7qZ7ZGg9g1L2m1I58RtkeyL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-Yu3mJX5hO0-f3g5niN5GIw-1; Wed,
 23 Apr 2025 03:36:24 -0400
X-MC-Unique: Yu3mJX5hO0-f3g5niN5GIw-1
X-Mimecast-MFC-AGG-ID: Yu3mJX5hO0-f3g5niN5GIw_1745393783
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED1891800878; Wed, 23 Apr 2025 07:36:22 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 210A019560A3; Wed, 23 Apr 2025 07:36:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/29] hw/intc/s390_flic: Remove the obsolete migration_enabled
 flag
Date: Wed, 23 Apr 2025 09:35:44 +0200
Message-ID: <20250423073610.271585-5-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

From: Thomas Huth <thuth@redhat.com>

Now that the machine types that set the migration_enabled flag to
false are gone, we can remove it and the related code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250115073819.15452-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390_flic.h |  1 -
 hw/intc/s390_flic.c          | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 85016d5ccc9..91edaaca409 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -42,7 +42,6 @@ OBJECT_DECLARE_TYPE(S390FLICState, S390FLICStateClass,
 struct S390FLICState {
     SysBusDevice parent_obj;
     bool ais_supported;
-    bool migration_enabled;
 };
 
 
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index c20f4c10750..4fae0231971 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -470,11 +470,6 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
     fsc->inject_crw_mchk = qemu_s390_inject_crw_mchk;
 }
 
-static const Property s390_flic_common_properties[] = {
-    DEFINE_PROP_BOOL("migration-enabled", S390FLICState,
-                     migration_enabled, true),
-};
-
 static void s390_flic_common_realize(DeviceState *dev, Error **errp)
 {
     S390FLICState *fs = S390_FLIC_COMMON(dev);
@@ -486,7 +481,6 @@ static void s390_flic_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    device_class_set_props(dc, s390_flic_common_properties);
     dc->realize = s390_flic_common_realize;
 }
 
@@ -515,18 +509,10 @@ static void qemu_s390_flic_register_types(void)
 
 type_init(qemu_s390_flic_register_types)
 
-static bool adapter_info_so_needed(void *opaque)
-{
-    S390FLICState *fs = s390_get_flic();
-
-    return fs->migration_enabled;
-}
-
 const VMStateDescription vmstate_adapter_info_so = {
     .name = "s390_adapter_info/summary_offset",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = adapter_info_so_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(summary_offset, AdapterInfo),
         VMSTATE_END_OF_LIST()
-- 
2.49.0


