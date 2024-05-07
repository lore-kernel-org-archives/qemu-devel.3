Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7026C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Ire-0005lM-Dm; Tue, 07 May 2024 07:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s4IrI-0005eo-2B
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s4IrF-0004c5-Br
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715080780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ky8IruZieVkUmRXWfInPf4DGq58II5GXG4RE+oRT9VY=;
 b=itQ8J5pw/HjMevc2H9lxh7yW7/ijimBbct5mwQBtofjb3CVUFGCqbMrAb/jcynT/hFu77p
 V5E8dnJ2Jhf1yT/wfJBmL56yp1hCEcU8zmPR7T/PdgB0kkrcQR7pGIPn6wsq+HN+dtdMgU
 0tAwConFVClHO8L8TtibVoBJcK83HtA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-mqEWSXM6Opi2NCnJAnN71A-1; Tue, 07 May 2024 07:19:36 -0400
X-MC-Unique: mqEWSXM6Opi2NCnJAnN71A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D761800262;
 Tue,  7 May 2024 11:19:35 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F7DB200AD74;
 Tue,  7 May 2024 11:19:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/4] include/migration: add VMSTATE_VSTRUCT_TEST_VARRAY_UINT32
Date: Tue,  7 May 2024 15:19:18 +0400
Message-ID: <20240507111920.1594897-3-marcandre.lureau@redhat.com>
In-Reply-To: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a macro to declare a VMState field which contains an array of struct
with a specific version.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/migration/vmstate.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 294d2d8486..eaff3c8ff2 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -634,6 +634,18 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
+#define VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(_field, _state, _test, _field_num, _version, _vmsd, _type, _struct_version) { \
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .struct_version_id = (_struct_version),                          \
+    .field_exists = (_test),                                         \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
+    .vmsd       = &(_vmsd),                                          \
+    .size       = sizeof(_type),                                     \
+    .flags      = VMS_VSTRUCT|VMS_VARRAY_UINT32,                      \
+    .offset     = vmstate_offset_varray(_state, _field, _type),      \
+}
+
 #define VMSTATE_STRUCT_VARRAY_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-- 
2.41.0.28.gd7d8841f67


