Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2836FC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzA6n-0007up-EU; Wed, 26 Aug 2026 05:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzA6l-0007he-Cx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzA6j-0003PE-S9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787737185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9NW8uY0H3t/xMF0HVs8RIaDYTYa9wgmnjlDh5j8iNs=;
 b=PJOlYetlX5l0NvLAyzgQwbfoFtV5UORJcs1uWwBc2bn5xbaLXGWAWIEcSbgBVqoY9ugI4i
 XHBTcSKN/P23kYm12QioN99Kvwyd6wfKDEaxd0YGZvwcwBGGeQpZ57EZ0GbC5dew79rGVP
 tlNO4srs5FwtyTKwVliE82GeQH7YyyI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-WoproYHEMNCcFKubrG-GRA-1; Wed,
 26 Aug 2026 05:39:39 -0400
X-MC-Unique: WoproYHEMNCcFKubrG-GRA-1
X-Mimecast-MFC-AGG-ID: WoproYHEMNCcFKubrG-GRA_1787737176
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A64180AEFB; Wed, 26 Aug 2026 09:39:36 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 745A11955F05; Wed, 26 Aug 2026 09:39:30 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [RFC PATCH v8 15/20] target/arm/kvm: Ignore and trace unexpected
 writable reserved fields
Date: Wed, 26 Aug 2026 11:36:20 +0200
Message-ID: <20260826093747.1670077-16-eric.auger@redhat.com>
In-Reply-To: <20260826093747.1670077-1-eric.auger@redhat.com>
References: <20260826093747.1670077-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

KVM currently reports some bits as writable whereas they are
RES0 or RAZ. The code easily allows to do some sanity checking
for such inconsistencies. Let's add a trace event when this is
encountered and skip the field

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm.c        | 8 ++++++++
 target/arm/trace-events | 1 +
 2 files changed, 9 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 2557d7b0d9..8ec9bc51cd 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -433,6 +433,14 @@ decode_idreg_writemap(Object *obj, ARM64SysReg *reg)
         }
         lower = field->shift;
         upper = field->shift + field->length - 1;
+
+        /* Sanity check the field is not a reserved field */
+        if (strstr(field->name, "RES0") || strstr(field->name, "RES1") ||
+            strstr(field->name, "RAZ")) {
+            trace_unexpected_writable_reserved_field(reg->name, field->name,
+                                                     lower, upper);
+            continue;
+        }
         prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
         trace_decode_idreg_writemap(field->name, lower, upper, prop_name);
         object_property_add(obj, prop_name, "uint64",
diff --git a/target/arm/trace-events b/target/arm/trace-events
index d72ad6b671..e67730de6b 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -19,6 +19,7 @@ decode_idreg_writemap(const char* name, int lower, int upper, char *prop_name) "
 get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
 set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
 nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
+unexpected_writable_reserved_field(const char *reg_name, const char *field_name, int lower, int upper) "Unexpected writable reserved field: %s.%s [%d,%d], skip it ..."
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.53.0


