Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58ACCD6E55
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjP2-0002kq-PV; Sat, 06 Jun 2026 01:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOv-0002d5-Pi
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjOu-0008Fd-4m
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rI5KnFxPWO5qKPfQ5O52dnwywt+Y80Snw/Kjs9EvUlU=;
 b=eXAQ5n04PxBeRbZQwcClq/zA2FCiP9WP8qkmZvu8cKL28PzpD/ElUPmkULWZBKRoUD8ngd
 n8kd9uIzRmQ3SKGcAUuWD7tL/zV5OJz921rnqm1Il3DfcciwhSvW4zKmisfzYRiLJDQz3z
 RiXOfnnOBGD2TCoUPh1aaMuz0OsYTTo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-BMWnyOKpMwyOl4GGekx9yQ-1; Sat,
 06 Jun 2026 01:16:49 -0400
X-MC-Unique: BMWnyOKpMwyOl4GGekx9yQ-1
X-Mimecast-MFC-AGG-ID: BMWnyOKpMwyOl4GGekx9yQ_1780723009
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BE811800473
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:16:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 363F6763; Sat,  6 Jun 2026 05:16:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:45 +0400
Subject: [GIT PULL v2 13/23] target/i386/sev: add finalize functions and
 fix leaking setters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-13-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=4141;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KGDSEH4kXjPQ4/HoJgAVzmsrW3Gsd6zdda1I7EVwqgE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z0tFI31t+V3+ANWsJ65VES1gSHwL/qq4Jp7
 QXj7OqH/POJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9AAKCRDa6OEJdZac
 5TLzEACnz8Mz9QaDv01DsyjZWz4XrC30zqVFCyAY+HemFuQnUUn+97SW1l73r1TLdtn56QXYJTE
 PKbahIvOwV1RMPjseVp0puChuTl29nAhHosU8dvNvXwfOGFsWRTnjTdozc2PUiWkOodqHHtcq8q
 BdZ5VckTwPR3jLy/gY3ezcZXw6iXlqCsLtmEThvI47GD2sZnYgFquBWybPI/r6+G0PI/iUMNPKg
 7PtVclzpj89FpY5jlGfEPFQ8cnuQTFg7FJefOn9suMoSfdnp0e7q1k6DANDQiA+aHiTdEJeHDw4
 mWQ+Dph1AUHf6VN3OqsJ1pFIaDxKrBJhzuSS7TdOPwe/fB/xD50Jf2SKU+DYa9N3V93FATvx/lW
 SzYoOHXpBwFw6y1FkbbSgc0D34fAHIQiwluqT/GJPTBVPhVmIFy7phwxo+Udi1rvh9JgSTRmGZB
 HKX4IkcPBL6cptugFYYwTWIP1wHkTKLtttvjI9gx3dN+S/LuleewR4AcHuVMlUjKIG4/LFycoWO
 88OnBilQqEh9kCp+XT7pKuG+fabes5JskvyW9q3JQLVLiUqh6asWjyukRcxj6g8XEDRDTP5vqv4
 UrygWSZ//WhUoeiWEXGqE4WnjFSIiL+5P5eye/ZUkncn0fOt5Opxq+zhklUGSwn/VND1qSHuwdS
 eUgBcl948CwGk+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

None of the three SEV types (sev-common, sev-guest, sev-snp-guest)
had instance_finalize functions, so all string fields allocated
during init or by property setters were leaked on object destruction.

Add sev_common_finalize, sev_guest_finalize, and
sev_snp_guest_finalize to free the allocated fields.

Also fix sev_common_set_sev_device, sev_guest_set_dh_cert_file,
and sev_guest_set_session_file to free the old value before
replacing it.

Fixes: a9b4942f485 ("target/i386: add Secure Encrypted
       Virtualization (SEV) object")
Fixes: 7b34df44260 ("i386/sev: Introduce 'sev-snp-guest' object")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/sev.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b44b5a1c2b9..99cf30806be 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2526,6 +2526,7 @@ sev_common_get_sev_device(Object *obj, Error **errp)
 static void
 sev_common_set_sev_device(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_COMMON(obj)->sev_device);
     SEV_COMMON(obj)->sev_device = g_strdup(value);
 }
 
@@ -2830,12 +2831,21 @@ sev_common_instance_init(Object *obj)
     QTAILQ_INIT(&sev_common->launch_vmsa);
 }
 
+static void
+sev_common_finalize(Object *obj)
+{
+    SevCommonState *sev_common = SEV_COMMON(obj);
+
+    g_free(sev_common->sev_device);
+}
+
 /* sev guest info common to sev/sev-es/sev-snp */
 static const TypeInfo sev_common_info = {
     .parent = TYPE_X86_CONFIDENTIAL_GUEST,
     .name = TYPE_SEV_COMMON,
     .instance_size = sizeof(SevCommonState),
     .instance_init = sev_common_instance_init,
+    .instance_finalize = sev_common_finalize,
     .class_size = sizeof(SevCommonStateClass),
     .class_init = sev_common_class_init,
     .abstract = true,
@@ -2855,6 +2865,7 @@ sev_guest_get_dh_cert_file(Object *obj, Error **errp)
 static void
 sev_guest_set_dh_cert_file(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_GUEST(obj)->dh_cert_file);
     SEV_GUEST(obj)->dh_cert_file = g_strdup(value);
 }
 
@@ -2869,6 +2880,7 @@ sev_guest_get_session_file(Object *obj, Error **errp)
 static void
 sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_GUEST(obj)->session_file);
     SEV_GUEST(obj)->session_file = g_strdup(value);
 }
 
@@ -2936,12 +2948,23 @@ sev_guest_instance_init(Object *obj)
     sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
 }
 
+static void
+sev_guest_finalize(Object *obj)
+{
+    SevGuestState *sev_guest = SEV_GUEST(obj);
+
+    g_free(sev_guest->dh_cert_file);
+    g_free(sev_guest->session_file);
+    g_free(sev_guest->measurement);
+}
+
 /* guest info specific sev/sev-es */
 static const TypeInfo sev_guest_info = {
     .parent = TYPE_SEV_COMMON,
     .name = TYPE_SEV_GUEST,
     .instance_size = sizeof(SevGuestState),
     .instance_init = sev_guest_instance_init,
+    .instance_finalize = sev_guest_finalize,
     .class_init = sev_guest_class_init,
 };
 
@@ -3194,6 +3217,19 @@ sev_snp_guest_instance_init(Object *obj)
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
 }
 
+static void
+sev_snp_guest_finalize(Object *obj)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    g_free(sev_snp_guest->guest_visible_workarounds);
+    g_free(sev_snp_guest->id_block_base64);
+    g_free(sev_snp_guest->id_block);
+    g_free(sev_snp_guest->id_auth_base64);
+    g_free(sev_snp_guest->id_auth);
+    g_free(sev_snp_guest->host_data);
+}
+
 /* guest info specific to sev-snp */
 static const TypeInfo sev_snp_guest_info = {
     .parent = TYPE_SEV_COMMON,
@@ -3201,6 +3237,7 @@ static const TypeInfo sev_snp_guest_info = {
     .instance_size = sizeof(SevSnpGuestState),
     .class_init = sev_snp_guest_class_init,
     .instance_init = sev_snp_guest_instance_init,
+    .instance_finalize = sev_snp_guest_finalize,
 };
 
 static void

-- 
2.54.0


