Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59761E7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTitE-0002Qx-Sm; Fri, 03 Jan 2025 09:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTitC-0002QP-Qd
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTitB-0007Ev-7v
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735915380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN4B1xZiqUWrf8djpR7r8xvY36CI8IaHfl9B1PGaRP0=;
 b=ZxTtCdlPBoBsIps17OaEUC4aqAh+evMzxkRNNkV0wG7fNj+pKVOAF9mcPIx6rJVfzkYp2m
 U361b1x0nSP45YDZZXaW/N2TqaMkwe/IkaIFOafLJZOwavahtye2PjfgSNx8DvorIDXKtr
 E3gAoCen9e6TW0YVZh3vGX9qVc6fIBQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-I1zBsqiXMu2wgIqLzrkV7w-1; Fri,
 03 Jan 2025 09:42:56 -0500
X-MC-Unique: I1zBsqiXMu2wgIqLzrkV7w-1
X-Mimecast-MFC-AGG-ID: I1zBsqiXMu2wgIqLzrkV7w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00C591955F56; Fri,  3 Jan 2025 14:42:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D53C5300F9B6; Fri,  3 Jan 2025 14:42:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 05/10] hw/s390x/ipl: Remove the "iplbext_migration" property
Date: Fri,  3 Jan 2025 15:42:27 +0100
Message-ID: <20250103144232.520383-6-thuth@redhat.com>
In-Reply-To: <20250103144232.520383-1-thuth@redhat.com>
References: <20250103144232.520383-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Now that the old machine types that used this property have been
removed, we can remove the property and the corresponding code.

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


