Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83952C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hfo-0005cW-J0; Sun, 13 Sep 2026 06:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfn-0005cH-13
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hfl-0008Aq-Jf
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJkQCQIatVsaPiJOeebh4Zf8nzIyMHM83NavLHCqpq0=;
 b=MwjAcJQvyvWthG0R+EcHxIlvFao5BlJMMksCEfgRfULNIKsKkrOqkutvNaUBxR5NTFTwcg
 dopOYw1Zw8kw+oDO9MHpB2M9AMcNFvKZRkSoJii1tXKPWxAHBmdv2OBCdNtdtbp/yKoNn9
 k1kBxG1zWqCkWuU/EfD0MkkEKhepFMw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223--At99X9vMXOowE-0RaTg8Q-1; Sun,
 13 Sep 2026 06:42:55 -0400
X-MC-Unique: -At99X9vMXOowE-0RaTg8Q-1
X-Mimecast-MFC-AGG-ID: -At99X9vMXOowE-0RaTg8Q_1789296174
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D7C81802167
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:42:54 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6342530001A2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:42:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:20 +0400
Subject: [GIT PULL 02/14] hw/display/qxl: hold ssd.lock while replacing
 ssd.cursor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-2-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ebhqjU8jopkHN1A11WgEVxvOloJVZIhxPQ6IXf3q9pw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4inmjjrrx58hISqgIw1pqNPtOxsdn9Jw/Nq
 J5J7HAgSGCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5T2BD/9lOdG0eqJW9K0RmP7938KiY2LHcL2rdMeJ9IdN/m8Mi7yvnQzVNsXUElA5G0p4Mg34WLu
 CkmBK7DomySXQCIY2TUZsc7j+Of0UNcNrkQMH650qCouvET8ORPY5yV32j1Vn4a+DSz+NWDHyeF
 dloZ1GrkBOV4LitnFv5NmnUiQ05Xh8jdM7OpGjunkUtxg9ZS3FwhMKXOz1xtU3EkrLf4MahQ+fk
 XBVu7Cc1/QkVPNjEcYqbORfLsXmnoaIy+rlzh7CkL4ubUVcnzoM1FUBZxQmI5eSu31LGOOBMk92
 U1/PWvkqzNEx+301Pz7KB7/wR1vUKtUY1Tkp1gBRdP9zbFtdfTfGsj1ZcKrj94+1JI4LOnmGTsp
 QEJuaIykETxwcRzzfY3JoUcnGSb8npQDf0AeyXaT8AZG7u4wFpAiMe+Vcbn/wiPtONOfLqb0Nrk
 IivilnMDUqtVjHHVofq0PVNqfEcR/ETUmFBhxoJuoXMcKOYpHJ7TNtlaOTu8Or02ENu+e2nnp2t
 dZvPCcj1Gk44YUjGwfP/xQj2G5vGdsRZQV3pHsLAYJoLTFrbKzrrFwanow51UW7I7O0t9PpdFbI
 /6UYZml4mK9F7T/bSy5c7tH7OsdmvxX7bxS3QNMtwTVr97QU2QWhm9bBmyx3w6PgihlynnGClkS
 j5imcZzr3+Oxj0g==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

qxl_spice_reset_cursor() unrefs qxl->ssd.cursor and installs the hidden
cursor without holding qxl->ssd.lock. Every other writer of that field
takes it: qxl_render_cursor(), display_mouse_define() and
qemu_spice_cursor_refresh_bh().

The unlocked path runs on a vCPU thread, reached from ioport_write() on
QXL_IO_DESTROY_PRIMARY and QXL_IO_DESTROY_PRIMARY_ASYNC, and holds only
the BQL, which the SPICE display worker never takes. Unlike
qxl_hard_reset(), it leaves that worker running.
spice_qxl_reset_cursor() does round trip through the dispatcher, but the
worker is free again as soon as it returns, so it can enter
qxl_render_cursor() and unref the same QEMUCursor a few instructions
later. Both threads then drop one reference for what is a single
reference, freeing a cursor that another user still holds. The store to
ssd.cursor races the same way, and a guest that keeps this up also ends
up waiting forever in qxl_fence_wait().

A guest reaches this by switching QXL mode while it also updates the
pointer shape.

Fixes: 958c2bceba06 ("qxl: fix cursor reset")
Cc: qemu-stable@nongnu.org
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260903192647.2677279-2-den@openvz.org>
---
 hw/display/qxl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 384b8767b8e6..c4f547e88bd5 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -294,10 +294,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
     qemu_mutex_lock(&qxl->track_lock);
     qxl->guest_cursor = 0;
     qemu_mutex_unlock(&qxl->track_lock);
+    qemu_mutex_lock(&qxl->ssd.lock);
     if (qxl->ssd.cursor) {
         cursor_unref(qxl->ssd.cursor);
     }
     qxl->ssd.cursor = cursor_builtin_hidden();
+    qemu_mutex_unlock(&qxl->ssd.lock);
 }
 
 static uint32_t qxl_crc32(const uint8_t *p, unsigned len)

-- 
2.55.0.543.g5ebe2ebe4ea8


