Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89E2CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOo-0005Em-4L; Sun, 04 Oct 2026 06:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOX-0004ge-LQ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOW-0002v2-C1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dC/CDto9fL0LRopdq+XIc/hNnaQcD5kaIHxR9N206jI=;
 b=Cxpcy8cu4d1CrSSi73udtnlFwRJfDaTB+FE7ln3/7RY2AqaI9LHblwsL7EZ03sbwevp97v
 SHsaWZZKptlVCqA3Y8kK+Lpb/3UTGtdyrqn/5dZ6xlpeG41R6UkEPumdkjxHleLaqs9LEV
 29M+W604wPgtU8s3wktv1EYbjH08P3Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-y7fym_BmNIqkPtInuj41wQ-1; Sun,
 04 Oct 2026 06:24:28 -0400
X-MC-Unique: y7fym_BmNIqkPtInuj41wQ-1
X-Mimecast-MFC-AGG-ID: y7fym_BmNIqkPtInuj41wQ_1791109468
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08D9E195410F; Sun,  4 Oct 2026 10:24:28 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12DB9180034F; Sun,  4 Oct 2026 10:24:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:28 +0400
Subject: [PATCH 14/63] ui/console: skip empty update regions in
 qemu_console_update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-14-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=968;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qO49z7dI2W2A/oljaL3RWZblE9lkp4hjySBAyopTVFc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiki/mUrATL4sPgXIvMpXNdsD36JlVYCdMdM6
 WmT5EhpA3aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5XsUD/91fsYv4LRk5qfEANEez27xHF+TwbCMYZywjrDf2lRJwEGjXrwPdOtccPGWgW7ZY85e75z
 Cl0MegJKsNpPS330YkjbQpfEykTFChYjscf95ZlQrLSHfPXfDHOKZq1Z8I7AuzCJevwEEW2jkR1
 jiSESMQuagv9fpYcVwIca/YzwGI5MVzwmaoNk9k60lzK+16yEzNn8XV6Ldd4sdS4k3KY32ECfwy
 bIMPgj9nVK+EmCCol1yxWAo0/cspA6f/pxBD/zQttJybcUyXuJMyR5WtdlpA7ipQRlRuCVFMWw+
 z0AGWIPeyDzS+LSay/OBswuSSEAeRT/MqUDdcFp3b3VsDOffcpZtCm0n7PBVUKbQkN3/JAJHt/q
 VjDI3f2oJUlLumqVl53xL0AQuB68uEydcvL4RGwE5SgIjx0sBLubrvcUGhYF11BhnWRafJlLVut
 fQFI9SuIIvZHqZ9tXtOrLGnN3OHO0rKGPAO7xPCpdg3stVatvazfiM0txT2FnlOQvv5AlS6TIsB
 LUhu1AExUcn11HGUKSfMXTyFXUIAE8HLLZ2YpDcwZ25nXzscA8V++DnbVGA/aVW6F9qBSaCwNxO
 R8505fQ9JMW0PdBWoZawx4XB8WU7iZrXp8795pRX3j77hCJhHbwxqJPVRMqM5wUU4xcyiDSxTAF
 maLMekUE52ZHpZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

After clamping coordinates to the surface dimensions, the resulting
width or height can be zero. Proceeding with such values would pass
degenerate rectangles to display listeners. Return early to avoid
useless work.

Fixes: 7c20b4a374d0 ("console: fix displaychangelisteners interface")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 14f148118e37..795c9857de82 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -740,6 +740,9 @@ void qemu_console_update(QemuConsole *con, int x, int y, int w, int h)
     y = MIN(y, height);
     w = MIN(w, width - x);
     h = MIN(h, height - y);
+    if (w <= 0 || h <= 0) {
+        return;
+    }
 
     dpy_gfx_update_texture(con, con->surface, x, y, w, h);
     QLIST_FOREACH(dcl, &s->listeners, next) {

-- 
2.56.0.rc0.29.g47ce80527c56


