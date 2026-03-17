Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DA1F3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QDk-0004D1-AE; Tue, 17 Mar 2026 04:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCA-0001T7-TY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QC6-0006ls-S3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLhkKn7+1QU/CW6mOGx1V73AjWJQDotgUmzx8ZNgxNA=;
 b=MriojdKlKt/5j0liwE/AxKNTGyErCS2rNPhNZm4wpBTvbpji6gLfuD66meQILOpNqOfMyr
 1T6NZ9rEKFY9Fa3qgPTe9o0ni39jEp3qVua9mK8WefYBh1piu8ev91bUxhECAISjTa9iH3
 0OCZtDEAEqaHHg0Gxnue9u/2RVzpyo4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-aQ9qyaXiPlCWBjVdsvR6qg-1; Tue,
 17 Mar 2026 04:54:28 -0400
X-MC-Unique: aQ9qyaXiPlCWBjVdsvR6qg-1
X-Mimecast-MFC-AGG-ID: aQ9qyaXiPlCWBjVdsvR6qg_1773737667
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D39E19560AE
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED15F19560B1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:53 +0400
Subject: [PATCH 39/60] ui: make unregister_displaychangelistener() skip
 unregistered
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-39-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=653;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UmkZ3twV9e8nEpmSc6Jg74ouNXvCipF8aGA338TlrOw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcXsiUPubQ4ExGV+zz2Vvhy0NeZT6jo1+gr
 pCIl7w0MsiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5W37EACMRAIdhmc/Er0sHAmvYeDlJ6BnPbqpXmgU16+2eJ4SB7MtFLu2KbErkZFdgbzuLZNloW6
 Ln5isFBBf5mhk/72gcHzaboSKHZ26iJVV7g/dEUvRIq9eTUraQxCqgavX5QGV/nmiuT1+mxRBIF
 FN3g5FKiic29dU39z9EXvZNgGryGkd4lzVt76upthmAhTgKoBqHwbVTCm2k34kghQxheG5Zy7SL
 Yh+6JRkL5b9v6GQiiL3wqqjIXRGstOS+pPfVuqO8RxKGQM2Bvrln7Sz5SncnMNW9cYQU5nkFdqD
 PbOfawQKwmrtKTqRA1fcEWSQjidhpYDTBPq/yzRI37itastvw7HBW3FAmjypYe6q8xTV9YLTPmJ
 sx+fusWEXLQSvDIXPpXkCWZxh2F85JxE7GxoJ6RKPAP5y1C8HCGLPj62mn2DLWM9fFKVrvwzAkC
 4bOZEfYZO01a3BSJ4Ir4K4+Zk0I8Woh+wC1DcPopO1w+uiEfSKzRKkddz/9HHHnnlxCQdtetTRa
 J1EGRD3IRuAlu4EJ6KOSsY6KgRRYNUWw54UgEKhdjOA6x7oND6TiMqVTQA9PHog/NQqhInYmYHf
 X7P0t+sRE77oaiZicAK5xwcLOqPilrJMT+QMeRMHV18uYYH6oUfOmEU7s9LNXNYtQqJDigkz6N7
 jmTcnbAUnuCkS2Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

If the listener doesn't have associate ds / display state, it is already
unregistered.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 78b0ac27827..a9132e09eac 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -677,6 +677,9 @@ void unregister_displaychangelistener(DisplayChangeListener *dcl)
 {
     DisplayState *ds = dcl->ds;
     trace_displaychangelistener_unregister(dcl, dcl->ops->dpy_name);
+    if (!ds) {
+        return;
+    }
     if (dcl->con) {
         dcl->con->dcls--;
     }

-- 
2.53.0


