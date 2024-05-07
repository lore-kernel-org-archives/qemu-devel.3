Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4074C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Ire-0005mv-Ej; Tue, 07 May 2024 07:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s4IrC-0005aN-3i
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s4IrA-0004bS-Go
 for qemu-devel@nongnu.org; Tue, 07 May 2024 07:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715080775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjD+pLQAzEz3hSpVswv/eVzgjOqKuEXPtf2X1BGzsXY=;
 b=b1AeqDJN2JkrGem6wb0X1CYkoJ95jnXzingK+Nm/gIx6i9AzhqgIX3EEnXFAQg4Z7pMWaD
 P1p950Pxi2T92Vk78kMu8ONgLhM2RhS99QUJgE/7swzQRbWVAerS8osg6IKZkG5mY+1Fdp
 sIKj/7P/oNgDpfTkFMQrmowsiZhco+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-iCDstKqsOgyVoX2yMOHQZg-1; Tue, 07 May 2024 07:19:31 -0400
X-MC-Unique: iCDstKqsOgyVoX2yMOHQZg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D396801719;
 Tue,  7 May 2024 11:19:30 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B60140317A;
 Tue,  7 May 2024 11:19:28 +0000 (UTC)
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
Subject: [PATCH 1/4] migration: add "exists" info to load-state-field trace
Date: Tue,  7 May 2024 15:19:17 +0400
Message-ID: <20240507111920.1594897-2-marcandre.lureau@redhat.com>
In-Reply-To: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/vmstate.c    | 5 +++--
 migration/trace-events | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index ef26f26ccd..b51212a75b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -128,8 +128,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         }
     }
     while (field->name) {
-        trace_vmstate_load_state_field(vmsd->name, field->name);
-        if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
+        bool exists = vmstate_field_exists(vmsd, field, opaque, version_id);
+        trace_vmstate_load_state_field(vmsd->name, field->name, exists);
+        if (exists) {
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
diff --git a/migration/trace-events b/migration/trace-events
index f0e1cb80c7..d327d29ca0 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -58,7 +58,7 @@ postcopy_page_req_sync(void *host_addr) "sync page req %p"
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
 vmstate_load_state(const char *name, int version_id) "%s v%d"
 vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
-vmstate_load_state_field(const char *name, const char *field) "%s:%s"
+vmstate_load_state_field(const char *name, const char *field, bool exists) "%s:%s exists=%d"
 vmstate_n_elems(const char *name, int n_elems) "%s: %d"
 vmstate_subsection_load(const char *parent) "%s"
 vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
-- 
2.41.0.28.gd7d8841f67


