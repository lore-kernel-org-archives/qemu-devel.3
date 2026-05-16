Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15D5CD4F47
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wR-00058V-EB; Sat, 16 May 2026 04:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9w1-0004zl-Ic
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9vu-00073O-Ea
 for qemu-devel@nongnu.org; Sat, 16 May 2026 03:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iO87o/0YYcEWxdVsD3TnBacBB5QSuCWhHLZQkTvzHEc=;
 b=fZGxJovpAOFAfPONEPxlaRV77nEdlPcXzlKJGHKq7npLxNjzadTj9vzy0XnWjKJJNMEc7q
 xKsUoMseJznhfPaJ0m338z8HxXOF+Wd8veJSTg7NJkvxVuYRrMt1Lbn8alWzIR1sFLUJTW
 5AXo22fbHJXcdJNbOkLfRaBBYJ6pd4w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-PlIQ7_KDMlqjZCpLLk1UTg-1; Sat,
 16 May 2026 03:59:36 -0400
X-MC-Unique: PlIQ7_KDMlqjZCpLLk1UTg-1
X-Mimecast-MFC-AGG-ID: PlIQ7_KDMlqjZCpLLk1UTg_1778918375
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58AB419560B4
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 07:59:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 528B11800576; Sat, 16 May 2026 07:59:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:02 +0400
Subject: [PATCH v3 03/24] chardev/char-socket: handle NULL addr in
 char_socket_get_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-3-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ec79R6dwgSUru8iZAGVoGIdElFOC+Hue6wBEH561cpo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPO0GEi4Oiy0n6tqN9LMDmjOwzfMDX6knQyw
 5o5Gl2b50yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzgAKCRDa6OEJdZac
 5Qc1D/9ZvV8LLPeyRNlnzZzko7MRLhlUuHEcLqG/oLYZT6Ua/aaXxChg5hr3cOOa/EqbonuB909
 N5JKrCI7nP1yXfeY4IivQCbNe6wz2/DQUN/oOVgv062R8nGF6i4T6qgDu6Fh3WrBV03t6aa7KGt
 5d2VWudxFecxX88m4xh9C4LSvE/lJkmovNgY4C2wkarGQJBJuOyKtWlq0SzrcGrqP21U0xWWW0j
 YAViEYQN5dGMUDWnVnSr+UbbKGcelO2twcMtGKP3/bnk6M5H3Swsbo0ymJ96gAZFjRMZh6xSy0A
 bDg+7Tg48gfvLuICq3pR/5cZIFhCFGUEVEMc4OFyYBG0TsXxZT5EFEUo6ldYGmHEXgEjzxvP6A4
 Mf9dzEcDApVqvLIAUt8fDsxByosAknDFGycYdoxLcPbP0AhUPA3kaqKh62UcJ6IbzWzP2PW/QoT
 eJ+2JiezfCOBxXrVU1y4tJvZFka9mAdOdmMJHEplOmIeLRoUmsVtOFnmeVexX/m2mgs+ZJj3hpJ
 0HkdnGFpqFiGt9nE9EhCT48ycoVp0GUOkKtBpX8HTpjwS+Obfql27zgVoYu5WuyfG08Wx9xeGmM
 n9Veu09k0uZShfix1gghGO0u4+qc56NKxFJDM2ZztitMSmyK2bWXRlDxKEm1yqhLe0HhztolNg9
 ORAJVPy1fH3bKXw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.54.0


