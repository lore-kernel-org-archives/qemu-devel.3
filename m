Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F7FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcY-00027D-NB; Mon, 04 May 2026 07:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrc4-0001Ji-8W
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrc2-00013o-Un
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuKJe960C3JZZMX2EjW66DJfgAaebcTF8mCh47fG1f4=;
 b=QddjaYdBS/bR77PWO/IPkc6JKLgxWB9h4imhVY//FkwG0mm0dBU4P3jK1HC6sKSG2YbxtD
 tcu+M5ISufpGhOt3tjf2V/xuiFmh1Y7oBPrBltctmfhKgTKIvPD0FoydonAzYUpNNflt9p
 aWgQuDgj1Hcj3LO7WKHxJdOzwMyWuQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-lqtieBFCNfCZajFnBsL6Sw-1; Mon,
 04 May 2026 07:37:20 -0400
X-MC-Unique: lqtieBFCNfCZajFnBsL6Sw-1
X-Mimecast-MFC-AGG-ID: lqtieBFCNfCZajFnBsL6Sw_1777894640
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 171C31956089
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:37:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADF9919560B6; Mon,  4 May 2026 11:37:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:10 +0400
Subject: [PATCH v2 22/46] ui/console-vc: destroy fifo on text console
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-22-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=699;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bgNRmMvCBvL1ntBm5XZWmDb8LVMsoFnZArE91z4s6o4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtO7phVAlWYpF4TCjtZwfAj939qgYKLygx7
 0vCCgovMPKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5Y+mD/9Jm+KqyGh4+ef084LUueX7ikGFIUeql7wCvxbqmnZPcphitttwTcblon50pO3P+FdthrP
 dsUamZW79QeHmLkb/q06s6FbKLdRIY2HmrF94aHwb7ZaFQkJuQBJ4bRAMSn3V7DJ+ChpU8Giv7J
 E1dj0mlXwm+JPBbdI5gVbwwRBt16qtdj51mhGrJNTq+jwXjkLmf77CjLMgEMNKbMn0FdL8ZjO70
 tiUR6TzNmMGErjYLJT2+Et+Ii3DxT337dCOX0E+BMAWDBwtGJdJFHkBFzl22Y6uVWs9N6iMSI49
 AAPhtip4AB4yAOGmUHQcURrTlHJQ0bhyA82JYiNyArOONVKkzsRYQsnQoRldataXDkFSo2HHH/h
 ZRMNTMNO5fS4yc5TcSFcX4IDHx5J/sOdVkuFybL6hLzOdK+Sf/1RjYqoZ2Y9+k6qrK0Z2PSNtqD
 DLbA6dzv5WSilW5Re4HqxC/VZXiV8Q1nBckAqWpSxdONXFG73rgYBG5kauzl8AWpOGKqSM0E8gp
 VV3hA2IDPL1KXlpmPoT8Nf5GW26o7IfeWgCuc6cqr/nxZwdyeOgYT0mF4VKUqtSm1SPwIwUl1yG
 +HuI2sQP8OK/XUKkdi0qf1JRGUziTX4WGNKJL6Xf5RwmuZSCxzsPZqqyr/8oGSkw6rEUauV3u1d
 go8H4i2oFoN09XA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qemu_text_console_init creates a fifo8 via fifo8_create, but
qemu_text_console_finalize never called fifo8_destroy, leaking the
underlying buffer.

Fixes: 0c9d0641ac ("ui/console: replace QEMUFIFO with Fifo8")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 6163e21d2c6..3e00d2588c3 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -1082,6 +1082,7 @@ qemu_text_console_finalize(Object *obj)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(obj);
 
+    fifo8_destroy(&s->out_fifo);
     QTAILQ_REMOVE(&vt100s, &s->vt, list);
 }
 

-- 
2.54.0


