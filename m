Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC8DFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRrx-0001TO-O8; Mon, 27 Apr 2026 15:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrX-00019j-D5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrQ-0007mp-Cn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777318995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jsDuVbJMnbV55+CZsRKXWrAKU/qLmpyZfnS+LXbfJaY=;
 b=flVgYHmPT75D0jvzMyVeuIhQuKrRqCl2xOr72SbC//uO57GegAYyNqZnZTKs83Heg68CbN
 nynZHp8dLkv8xBDsYBwx742JxxtB8ZtfvPd8Wjgya0pceTPoHHC3s4Z1me6hVFXVS92gYI
 X3e9bP+gehfXkufGPzihWNVQNr1w5NU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-SzoP2UELNFC540owXlEy3A-1; Mon,
 27 Apr 2026 15:43:13 -0400
X-MC-Unique: SzoP2UELNFC540owXlEy3A-1
X-Mimecast-MFC-AGG-ID: SzoP2UELNFC540owXlEy3A_1777318993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED6E919560AA
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:43:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A20AA300070A; Mon, 27 Apr 2026 19:43:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:07 +0400
Subject: [PATCH 08/41] hw/intc/apic: guard against NULL cpu in set_id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-8-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=H/f0y1ZnM9kksExg6Lf8cmvRVM4vb76ZFVmLHYG2Wgc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUYlNFKpccl4gxJ2U0GJ/9luzgYzhAvxbdX
 Nk0MqWZG5eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5ZkoEACUuA5REwi62+En3zKbTk8/3i/t12qRrpbkH8piICTfxS32qkvA1P/U4agWSacmWTcuaxy
 4Gtq87Zb48YRIxxRiCBBW9dQY8pKKmgIoBSc2vYteW9lRpkS7CQBlyazvpG75LSFznmXh7HGDMG
 Zrlmq4RreXplBPcAe9FKT4Fn8yCJMw9w0VJ1maXwStnFNyYf9XB4aOVpZx9rvw/iirpprXgtA65
 GFsWbLxOYeg3piPyoVSLID4L01fGlovT5gWuoYDtSDau16YvK4QeseXaaeJJTWipqenwsHi3ieD
 SdcK30Np+NeUBgso7abywsme8ocaRQRBh4gqUpkr0VMH8b1y0wO8WtyVUobgfaDMb8iulQtx3eS
 sUwBW0uU11SgRV8HniCKHQqeFITYjLgnS/zP3pCRzpj9Iu2XSm1vLIrmzt2J8emi91xsvNh6d/J
 Js/LvAYcuXrCY+eutgdgl7ZDfwhYfmrHV+GASpaHcTs+dMjYSVLMVxTihtTHsc9q0q3G8DyPSwR
 Xdtb4IsBLLQaXEEjnP/v1gIw13pXGtd+fj2BDjnatqhkSDg1NgRFhPgvE2Y1gg2G9pc5581y0cp
 CrQ2flZaN+wUTXCXX5bst87KNRIYzLUjuVLjFDliFfkZLaxWgExGKZcmkJUzOiVQKo83OTcyUIV
 wh26Y4vgqphxk0g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

apic_common_set_id() dereferences s->cpu to check for x2APIC support
when the APIC ID is >= 255. On a standalone APIC object that has not
been attached to a CPU, s->cpu is NULL, causing a segfault.

Add a NULL check before dereferencing. When there is no CPU, the
x2APIC feature cannot be verified, so reject the large APIC ID.

Fixes: b5ee0468e9d2 ("apic: add support for x2APIC mode")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/intc/apic_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index bf4abc21d7b..874a05e529c 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -421,7 +421,7 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value >= 255 && !cpu_has_x2apic_feature(&s->cpu->env)) {
+    if (value >= 255 && (!s->cpu || !cpu_has_x2apic_feature(&s->cpu->env))) {
         error_setg(&local_err,
                    "APIC ID %d requires x2APIC feature in CPU",
                    value);

-- 
2.53.0


