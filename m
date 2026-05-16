Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141B9CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9vn-0004xe-EB; Sat, 16 May 2026 03:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9vl-0004x8-Bb
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9vk-00070V-3Q
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqHaON9sRM1sYUEPXCKTDAIBSwAYfKHnhxW62Uz/IzA=;
 b=ALBXwURsu+sOswWbQn1vq0ZLR5b4r9ddqaTZTHQYCXygJjb3J8U9XJID9nZTzDjrx8S7cR
 rPsJwFC7DwGOLVG2FNWjvGGT1fBRaM56f0Sm/cjJTA3JZQ8B+mYeYuFXEzE8GgMYh5nw6m
 Ng3ER/SVv3xgwOlia0iJ0LatdL4NFOA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-IdZXFMHHNYmli2Hvmd7QOQ-1; Sat,
 16 May 2026 03:59:24 -0400
X-MC-Unique: IdZXFMHHNYmli2Hvmd7QOQ-1
X-Mimecast-MFC-AGG-ID: IdZXFMHHNYmli2Hvmd7QOQ_1778918363
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90420195608F
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 07:59:23 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 333D61800349; Sat, 16 May 2026 07:59:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:00 +0400
Subject: [PATCH v3 01/24] ui/vt100: add vt100_fini() check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-1-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=731;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bfEx1K4mAI08LjIUdjB/lCDfLpaBYwml12JdZ6Td3rA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPOzxbOLCh96lR9HhZSwUlmTdddn+o4yFBH4
 llKjNnBqGyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzgAKCRDa6OEJdZac
 5XKYD/4vYIFpRtOjAbyaH6PavxXP2t3rfg2fvqTHlbburoLx+azCNNsfVsQ2294A9YJb9jT6/UI
 bz8v/2TG6ikBZkEk/k927yelFynTYoP9VA5KKcNZocSfwa7WoRFglqjdWQ20G+6veCGkaqdqR9u
 eiSpET+SXFUUqlEFWzRZQm1FmV3XUoce5TTbUMexptcViwaxF+FdIm+yssy8uG2cb88xkHnB1Ln
 1y8MK+JfuC9iX9GTFHtsB0j3JFleySU30zjpXVQIezRnsL9USNNwJEtOMaIcbOr1ZdV1/zUXvWb
 LVElFf1dHBWFZXEE2xA+7toAepI6yy10Te26KkJ8n6XhSR569tuGcHMWfvDRIpMHERGaj5gEKAs
 7o65QpJHUDn7gtwFvMrKSZsYcbjQN4pimqwlutq9EklA+i5QRWW55lwpVqoVpbMsyz5cU/NbkVc
 IF/MTiAJBHTh0k8OAjZWrhfR2yui5+I0xRG0j9tGSK8JcrMIeuzdbZ1asghswjn5ptH9QnX+WD2
 gtm9bmjNF22u2VQjKoJLYZ0enh5NySoiJRC6JpIemKE9VsK1x1vz2+1fpkI6cRzpk+7TXBZVsuC
 uqkadOwFsyAaCfwqheG5ydClj3tOIr7EGK1vLfl8wvaMVNKJAw0E520HCmxm9cZwMsmOG6EWSrG
 yAsm7hVq/EB3HrQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

vt100_fini() is called unconditonally from qemu_text_console_finalize(),
but it may not have been vt100_init()/opened: fix the crash in that case.

Fixes: 8fa294482eb ("ui/console-vc: move VT100 state machine ...")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vt100.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vt100.c b/ui/vt100.c
index e2fba822523..e5ad978bc8c 100644
--- a/ui/vt100.c
+++ b/ui/vt100.c
@@ -978,6 +978,9 @@ void vt100_init(QemuVT100 *vt,
 
 void vt100_fini(QemuVT100 *vt)
 {
+    if (!QTAILQ_IN_USE(vt, list)) {
+        return;
+    }
     QTAILQ_REMOVE(&vt100s, vt, list);
     fifo8_destroy(&vt->out_fifo);
     g_free(vt->cells);

-- 
2.54.0


