Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2888DC79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5p-0005Ml-CM; Fri, 04 Sep 2026 16:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5n-0005GB-4H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5l-0008MN-Ac
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Emw5udw/hAqZHIGzxhMNpVnsgLj93r4j1DXVLXU5PSI=;
 b=gamvrMmP7igScGYanCE3bQrparhtpM4T49RG7xp61M9Ha3vPTcOGzjachrVyfH7JC8602W
 Q+DsnDls9fvIQIdpnPQnxnd+Ymh6qJ4SbmHpP5VBMu93Ikz5/yHgph2nqm9QR5OAqsSfxk
 TGlVyqhApT9xisTOGGgf5YpJ9SbVQro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-R3dKHu7oM7O7qmbWd6gBQA-1; Fri,
 04 Sep 2026 16:00:49 -0400
X-MC-Unique: R3dKHu7oM7O7qmbWd6gBQA-1
X-Mimecast-MFC-AGG-ID: R3dKHu7oM7O7qmbWd6gBQA_1788552048
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 049F118D6343; Fri,  4 Sep 2026 20:00:48 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F35481955F0D; Fri,  4 Sep 2026 20:00:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:27 +0400
Subject: [PATCH v4 44/75] net/colo-compare: fix max_queue_size setter
 visitor type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-44-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Jason Wang <jasowangio@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gH4V4GYmKlKV9gTVHip9VTPSlJHQiKGxkIO6FkOUkhE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKk00d8G+B+kvKvgbKOeexR1nQEaROD/qme
 DvDIWmsvb2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5QByEACO2JIk1o+Ht7qrZve9/HYOqO4SMsi6CUbHZ+cOy0Q0faVQQ/7w270ShMzEGXGbrEJX42E
 KejrnHlC5X3DgMFyFu8WbivZA50x2IgDeZ9tDqZqNTPQW4x6lb5nfA1rg6oRVnQobF7PeWmsUJD
 +gKv9jEbCtlh4TAe/3lvMSeNGnzF497RWucdJqLgssj789r3Pt/7kvJqmXswb2zGGhjh0zzZGAg
 Mj8mKOVsHGIwGORgn13Bv4wHiXFngMPbMi2tsW1vtuw7946nIiBNJkYHalvlyBR5FfEdyk7zjKD
 edZetqIxQ5DK+0hh8DiE2v/xZexIb/4B7qsV7iIaWW4vrP37RIXsmYdL/ZvIH7YO77EpzAMlw9O
 JDCMvdFI26Wects7vU9LE9M1cOJF4agPFSggZYllH6roUEGZB/3e/6dnSi0qgTuJ+YUaPb/L3SH
 5h+BAKiCB+O6ZXu0p7rdc1xqE1DeJSuHAY+BoYc4Aa7SSCBLpgfC7cxdoZfMqLKnj0s5+7tJ1pj
 7QUP+JNYC2BOmUMIiDwk8d0UrbgoKP8o0xu7PAihj5ucGXAn9QvkDdPhRvITN0C73HB/sWSq0Bz
 SwsuB6+6v7JITEhidKFpu/cKbsbbRn37LCttyAi4PQ7KCM/3CNmR40Khf4pTBeI45zoEhT2y3lH
 fCGkGq73kkVdfbQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The setter was using visit_type_uint64, accepting values wider than
the uint32_t field. Use visit_type_uint32 to match the getter, field,
and typename.

Fixes: 0c4266ef2690 ("net/colo-compare.c: Fix compare_timeout format issue")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 948a2f7f9e4b..a6910de869ff 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1129,9 +1129,9 @@ static void set_max_queue_size(Object *obj, Visitor *v,
                                const char *name, void *opaque,
                                Error **errp)
 {
-    uint64_t value;
+    uint32_t value;
 
-    if (!visit_type_uint64(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {

-- 
2.55.0.543.g5ebe2ebe4ea8


