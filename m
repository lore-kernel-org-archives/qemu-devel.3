Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B3DCD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcj-0002k4-9F; Mon, 04 May 2026 07:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcD-0001r1-Kx
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcB-00014k-JJ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ENGPfGHgIxg5og8PJbEFyPyG4amh78c3jp6juMJV6s=;
 b=cC3NhggG6cMHvpthJqvUf1hfmOF0dYDpEYfy2DoFLzmFnH22oaC85TxgnRReiNTK3RRj7G
 8O4h9VUHGY6KRny3arEiijnm6Jk+Tng+SnyINz3upZiagW+giS8kyg2swJigtEF+X/gvH8
 08rdfMyD+D10Tlf8o1WGuS1quQb4w8M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-5IfPf7sbMcyTG7_TmCahuw-1; Mon,
 04 May 2026 07:37:26 -0400
X-MC-Unique: 5IfPf7sbMcyTG7_TmCahuw-1
X-Mimecast-MFC-AGG-ID: 5IfPf7sbMcyTG7_TmCahuw_1777894645
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0799195609F
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:37:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 488511800347; Mon,  4 May 2026 11:37:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:11 +0400
Subject: [PATCH v2 23/46] target/i386/sev: add finalize functions and fix
 leaking setters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-23-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4011;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zRlvvqdJmibrYhLu3KatjR2sweNhvE5A5QyCSWJFiSM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtv9i4nWbqcSRh4XRHK8cZfB8BtohLyh2dW
 Q2OdWn1JpuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5TznEACzfdpLL3CuuNibAHzg2RXB6tM9cTDK18PV7xEVb839s32gfuKVr0GBt0d8LcJTEiyO/SA
 HtdxikEMzXQvDbqxMx42Hmdrdt7WXNO3JhB1ZFjrVhJSU8GFibF1558yZ1exoNDIPcsSoUb5eTu
 wP6kIr03cDzB++GUYh2naX9UGqywWPTcFOylHGKk3zUX+a7b+UowElxfWrQsvRYbs0kk8uyfsnu
 Yrds/p/HgRIDlwE4jfmh4SJlHOTb/SrCe42/7PO/Xuqrz79I465xfnCqf2RBoxn30KinaM/t63C
 8VKx3wbUnqluehKMH8gycEsZbAa9PCosFmRC3xxbnDzeJhZ2aswvVKexlwvC/2iOYim8vK8IHpO
 NpBzTsUZ9zBpYl8F2+kag8n3a5EHNzZBZSnBjgbZRcJrzAXTM3IR/uChMl+sS7BemfcMFR5vDmD
 sYhJUp+3GeBJv10aLMQsnPn/DvMpnK4TDuh61Onx7GEsW9Gkg6dp2eIxXL8j49/FMy0DhadZxp3
 7uLqPC2qDObfXJd7B42Pv6ZfW+MkQ6cP0LNCcPUdp0NOU8CJoD7NxS5J1c4F4o9gcz0WPYZg8Fu
 bXfS4oBGCCqLeXNO6oyESqROMwHJ924G6L8zxUuNTJcRNgcDm379u8syhqD4df3NaJ7v2rIfDp+
 48L3bx8b6B2qN2A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

None of the three SEV types (sev-common, sev-guest, sev-snp-guest)
had instance_finalize functions, so all string fields allocated
during init or by property setters were leaked on object destruction.

Add sev_common_finalize, sev_guest_finalize, and
sev_snp_guest_finalize to free the allocated fields.

Also fix sev_common_set_sev_device, sev_guest_set_dh_cert_file,
and sev_guest_set_session_file to free the old value before
replacing it.

Fixes: a9b4942f485b ("target/i386: add Secure Encrypted Virtualization (SEV) object")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/sev.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 261b6aaa37b..3c2734ad83b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2527,6 +2527,7 @@ sev_common_get_sev_device(Object *obj, Error **errp)
 static void
 sev_common_set_sev_device(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_COMMON(obj)->sev_device);
     SEV_COMMON(obj)->sev_device = g_strdup(value);
 }
 
@@ -2831,12 +2832,21 @@ sev_common_instance_init(Object *obj)
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
@@ -2856,6 +2866,7 @@ sev_guest_get_dh_cert_file(Object *obj, Error **errp)
 static void
 sev_guest_set_dh_cert_file(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_GUEST(obj)->dh_cert_file);
     SEV_GUEST(obj)->dh_cert_file = g_strdup(value);
 }
 
@@ -2870,6 +2881,7 @@ sev_guest_get_session_file(Object *obj, Error **errp)
 static void
 sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
 {
+    g_free(SEV_GUEST(obj)->session_file);
     SEV_GUEST(obj)->session_file = g_strdup(value);
 }
 
@@ -2937,12 +2949,23 @@ sev_guest_instance_init(Object *obj)
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
 
@@ -3195,6 +3218,19 @@ sev_snp_guest_instance_init(Object *obj)
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
@@ -3202,6 +3238,7 @@ static const TypeInfo sev_snp_guest_info = {
     .instance_size = sizeof(SevSnpGuestState),
     .class_init = sev_snp_guest_class_init,
     .instance_init = sev_snp_guest_instance_init,
+    .instance_finalize = sev_snp_guest_finalize,
 };
 
 static void

-- 
2.54.0


