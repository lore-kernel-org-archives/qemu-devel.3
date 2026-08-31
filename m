Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE34DC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x10Ua-0001eh-Ld; Mon, 31 Aug 2026 07:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x10UY-0001eJ-Lg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x10UW-0008In-Tb
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788176875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gfnpoYznJfyL+QF77Wea+533+l8mzTuh5cmw3j2uiXA=;
 b=RiLi8kos18CH593fh7clpd3GFKAEooRFdZPaJESUSo7XE/MzM2bxczc/F+9F51yRAR6zWo
 nObpv4CunX0S0LmYzuf5pH17O7SD7xj4sCNXj3cYiAPEnX0wW4VzH4zu/lGkaKX77YQb38
 L4nJtGYB8Qa6wcdAq5RDt7d3TYqK7kI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-MNervHgXOtOec2388rQjPw-1; Mon,
 31 Aug 2026 07:47:54 -0400
X-MC-Unique: MNervHgXOtOec2388rQjPw-1
X-Mimecast-MFC-AGG-ID: MNervHgXOtOec2388rQjPw_1788176873
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20ECC195F17D
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:47:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28A9F180049F; Mon, 31 Aug 2026 11:47:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] migration: remove duplicate VMSTATE_STRUCT_VARRAY
Date: Mon, 31 Aug 2026 15:47:49 +0400
Message-ID: <20260831114749.2758129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fixes: 028d4ec43de6 ("migration: Remove duplicate vmstate macros")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/migration/vmstate.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index e72c3fae9a69..21a31ed7053c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -723,16 +723,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
 #define VMSTATE_STRUCT_VARRAY_POINTER_UINT32 VMSTATE_STRUCT_VARRAY_POINTER
 #define VMSTATE_STRUCT_VARRAY_POINTER_UINT16 VMSTATE_STRUCT_VARRAY_POINTER
 
-#define VMSTATE_STRUCT_VARRAY(_field, _state, _field_num, _version, _vmsd, \
-                              _type) {                                  \
-    .name       = (stringify(_field)),                               \
-    .num_indirect = vmstate_field_offset(_state, _field_num),        \
-    .version_id = (_version),                                        \
-    .vmsd       = &(_vmsd),                                          \
-    .size       = sizeof(_type),                                     \
-    .flags      = VMS_STRUCT | VMS_VARRAY,                           \
-    .offset     = vmstate_offset_varray(_state, _field, _type),      \
-}
 #define VMSTATE_STRUCT_VARRAY_INT32 VMSTATE_STRUCT_VARRAY
 #define VMSTATE_STRUCT_VARRAY_UINT32 VMSTATE_STRUCT_VARRAY
 
-- 
2.55.0.543.g5ebe2ebe4ea8


