Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A04FF8871
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRsc-0002qh-A8; Mon, 27 Apr 2026 15:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsX-0002HY-8Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRsV-0007yr-RS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mO1Q1PX7LwqKmv4izDa+Ri7d+hEtOWbrxErFRjbh8M=;
 b=Ms4nB/5qcl3A1Qc7Rals0oDREQ3aBgQv7GT+DqX/rZVXzVcyweItxOEz0dNb6E9N6qNh8h
 nMd3NH3ipCZUsJY093fuWBOoKK9MRWNjWFgN+QQX1GIFDTAutLq2eEQvyz3g5tgn39Hsff
 TTyvEA4Fck5UzDmu1HPLzQlIWu1shN4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-0iS2rUBqPbqQ72lXHqwNDg-1; Mon,
 27 Apr 2026 15:44:20 -0400
X-MC-Unique: 0iS2rUBqPbqQ72lXHqwNDg-1
X-Mimecast-MFC-AGG-ID: 0iS2rUBqPbqQ72lXHqwNDg_1777319060
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA2AD19560B5
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:44:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE73819560AB; Mon, 27 Apr 2026 19:44:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:18 +0400
Subject: [PATCH 19/41] ui/console-vc: destroy fifo on text console finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-19-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=699;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/copMMdgfN/IQj7Op8a3U5/jQ7AvugHm22MyFvCxwcs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wVDWc2RTzTdzVaACw0HBTV7aFjGoUZeyq/P
 futjwZkBG+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FQAKCRDa6OEJdZac
 5TKuEACYTWAOJR1BUnf0ErDjRwkFUsggntWcKEhW661y6xonoNUubqd9bT9XDm8ZDPPVhkX7hp9
 NdyFyk5IAnf5Ctjir5T7KHpimpj1EvgOe/qA2my5/oOq/ndXuUfVMJXwnUhjm3hhNr3oKen/3Cx
 2RjkRiojnG8z7S1EG7YINO2qrzgY2KBuf2K6elgSxVnOfVBeOOeIu9uAoF0u2wcE8qQTA9YOy0G
 b+9zBslSRfLrHuHKowdTUXhAkjhNcf9qzDq5uq5okAHRDWEpLZIq+ZhdBdzVV0GYykSsXPv23Bi
 kpGx62E/H13Jk14+vYA5hquDbr/CoJv1K3J1qucS1FA4hXUmYRy4O8a3c3QDk3n+72uFaZKZNXZ
 CpzDhpXfsUPVWI1Y8q9fG0nIX2mELeOsSEOIirWUg6gSXdg3ErIQNtNZKc5jgYLdpErd7hBKGKj
 W1ZY0ySKjekfB1uQ8Z/OQWPkjkL3SxrUfP6cYKiYtgaZepd7Pl4b7d8KvjC8dULkKuBaU0HaN6A
 LfRCApulxDvgX4enDISQb8kluC3hyXE9BSBspx+K2gy3UJ9e2abKsZZt+7auWmBMMsrFcLH57md
 aqWDrOnZMCz7L/Abf6+XrN9MQ3r5W2QLouDQKp0GaBGM7qNa5eOBi+cwFKQPksUQX82U5lNyzvd
 nT7oanfPcuUQP6A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

qemu_text_console_init creates a fifo8 via fifo8_create, but
qemu_text_console_finalize never called fifo8_destroy, leaking the
underlying buffer.

Fixes: 0c9d0641ac ("ui/console: replace QEMUFIFO with Fifo8")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 107294af1cc..89fa9a216e1 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1081,6 +1081,7 @@ qemu_text_console_finalize(Object *obj)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(obj);
 
+    fifo8_destroy(&s->out_fifo);
     QTAILQ_REMOVE(&vt100s, &s->vt, list);
 }
 

-- 
2.53.0


