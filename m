Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2D2FC591C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYCn-0003V5-Ta; Thu, 26 Feb 2026 05:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vvYCl-0003Ta-RY
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vvYCk-0000XJ-Ea
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772100165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fAwlq+9xVqaFn5n00aKeNQJ+WKDlqnxMclidobx3qgY=;
 b=Fjm8ixoK9kVuVUeySKHl4oJwjKnM6L/OgltDQw7f49INGs9VNr6dfSk8uJW+IkiWVapxvw
 9O5R0XGUqMg+5cKesM74P72uIEuCj6SKfxjPTv75oE4jaCM3bdR9EQo965JSBrqz+5Ah5s
 KPcI6gXLIoWpO3OMVAFEA8kjT1bXPPI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-gY4-yE2BOfaO6S4cdCXSnw-1; Thu,
 26 Feb 2026 05:02:44 -0500
X-MC-Unique: gY4-yE2BOfaO6S4cdCXSnw-1
X-Mimecast-MFC-AGG-ID: gY4-yE2BOfaO6S4cdCXSnw_1772100163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C6E21800465; Thu, 26 Feb 2026 10:02:43 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.35.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 021AE1800671; Thu, 26 Feb 2026 10:02:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH 1/5] vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
Date: Thu, 26 Feb 2026 11:01:29 +0100
Message-ID: <20260226100232.500781-2-eric.auger@redhat.com>
In-Reply-To: <20260226100232.500781-1-eric.auger@redhat.com>
References: <20260226100232.500781-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Already existing VMSTATE_VARRAY_INT32 requires an array to be
pre-allocated, however there are cases when the size is not known in
advance and there is no real need to enforce it.

Introduce VMSTATE_VARRAY_INT32_ALLOC as we currently have for UINT32
and UINT16.

The first user of this variant will be the target/arm/machine.c cpreg
indexes/values arrays.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 89f9f49d20a..62c2abd0c49 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -447,6 +447,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
+#define VMSTATE_VARRAY_INT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
+    .info       = &(_info),                                          \
+    .size       = sizeof(_type),                                     \
+    .flags      = VMS_VARRAY_INT32 | VMS_POINTER | VMS_ALLOC,        \
+    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
+}
+
 #define VMSTATE_VARRAY_UINT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-- 
2.53.0


