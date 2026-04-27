Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57351FF8871
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRr6-0000uZ-QJ; Mon, 27 Apr 2026 15:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRqt-0000qO-MW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRqq-0007hy-KD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777318960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MpZfxbMbvI+LoOauwmGQ7lN3E+YKy7RIysjR5B8VSug=;
 b=JV8GUm8pbR2c+KmSHsNGnN/Hui3wVLeuz75s+T+AdcvmV0wA5dnw91ocANRHg0jM9pDDCb
 6a382HEfsQX74f6rNG3LKqQojU/Qp27j0QBe/ZLrqGxS8rS0dWx8mYDvif9v8WTammrCPq
 HU0WxfcDZp5bFZOghmEfuJ8dK2B8RVs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-A30x2vMEM1abmnukM2kG7g-1; Mon,
 27 Apr 2026 15:42:36 -0400
X-MC-Unique: A30x2vMEM1abmnukM2kG7g-1
X-Mimecast-MFC-AGG-ID: A30x2vMEM1abmnukM2kG7g_1777318955
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D67D71800454
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:42:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DDB0300070A; Mon, 27 Apr 2026 19:42:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:01 +0400
Subject: [PATCH 02/41] chardev/char-socket: handle NULL addr in
 char_socket_get_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-2-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OqoZXlzFf70MD8aVuu81IsB2OfurhLf51jzWd985d5c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUxNaEGAUSFoncgex/xqbAlH89hcs0waV6p
 dDsIi5LKZqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5V9+D/42oppCsFcGimP/mQ10jT/G5+69yF/oXFUc59ryhiXA+GeMCbb67j/yqNnraHKmLG4dc9k
 4tet53MeLMCWDNxh+TOG2/Ta0CClETSTD2Va+8traDjLyKkK8FcfIxfFoEqa2OJ+Urmpv8jP7XA
 kkbQU23JOIPjd+qzKzxKpUuNxn1s2Vgt2ZHHh/tMUYzpxiOGsMgGmnmpOlki8p/C9y9jUm5PVde
 o6+gGig4BvHr1vN9CY2e3mqQZE/Ou8EirTqgUE5Mt0HUmFIOxLHpNmqVxNgDOevXQMJ3goDH+vv
 nOFYYJuvQT8/Je4HtDxnYNQaQ6MKth5FNgs+DuH1Gfju/NjrqS2Uge03nbnTZH39X7UV2U1LaA5
 aNRZjMow9VCuvqTt4u7IsqPP//Mo1HewMGIuCWDRsZVnSruDv/n5A3Zt+sk7bAhPEfIb7mdaIfz
 SoByF5+7CIb01+Q4dnjAZ7cqDZFUNh9ahxieyYlEEjf5DgkAVD+bHCHlSKlauq6HiNhgHoiiB9O
 7p19VPiczrGR0g4oJm/ArqM80LVltWR72lwwtioar3Mk+lQ5Ils82vLC509mf9AavJVurobHMpy
 KU1On7gjT83mMsqOZ8d4dTLcfAgSLUaR7sg08Pqe/HV0ZdiNB/uKBJspIV+gzSchnEmbs/Hy+xq
 5iZM8w4cMgjm4iw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When called on an unrealized chardev (e.g. from
qmp_qom_list_properties), s->addr is NULL. Return an error instead of
assert().

Fixes: 123676e9894f ("char-socket: add 'addr' property")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e064b105c50..b629575fcf8 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1529,6 +1529,10 @@ char_socket_get_addr(Object *obj, Visitor *v, const char *name,
 {
     SocketChardev *s = SOCKET_CHARDEV(obj);
 
+    if (!s->addr) {
+        error_setg(errp, "socket not connected");
+        return;
+    }
     visit_type_SocketAddress(v, name, &s->addr, errp);
 }
 

-- 
2.53.0


