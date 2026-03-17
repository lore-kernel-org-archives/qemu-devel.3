Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18654F3381E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QFC-0001H7-IA; Tue, 17 Mar 2026 04:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCq-0003TY-Tj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCp-000736-BZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e0JR/J6OJK+GQEzT8ir8klbcnwwkITj+TK5vevotDWQ=;
 b=emVIv6+tT938A4bZolbqczFEt2h83fH1lfZq5MWjlbZ/BvEwyy21bDHyytb0Xd6u0mYrFI
 yxQPyQC1haEwwp76JWvrn29ip4AqvHopqsHyP2eHr3RwFQW9sYdbSxPFeZJ5sYK730yDcu
 aZcej1HSqvEicilWny9fYn/RR6lGWnI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-8qPUIYJ4Onmfg1KQCZ2XLQ-1; Tue,
 17 Mar 2026 04:55:13 -0400
X-MC-Unique: 8qPUIYJ4Onmfg1KQCZ2XLQ-1
X-Mimecast-MFC-AGG-ID: 8qPUIYJ4Onmfg1KQCZ2XLQ_1773737712
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D42C18005B0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 508D530002DA
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:55:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:01 +0400
Subject: [PATCH 47/60] ui/vnc: report an error for duplicate display id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-47-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=688;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tbQe9OOb5vcHdHHZ8MKDbxR1oX4ZCQVt+T/ARXPvgwk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXceKPzXZk8scS5cNs6p3M5EnJd/r76sf0eh
 hDzszrGLUOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5clcD/43Vo0dBHwUNJWXMFRdIuyW8LSP8rSCiy65S6EbGbrHI7iKJlArrqxpcqBUhxxh/mclf/2
 E6z1o9yvk7T3U4mj40bJz04OXb8otvddh/tjcXP/wz71gF+nN4uydCah9TYEE4Tgk+gEpAlvvrl
 go6IbRqUNA/wbi7VvA+tMf1l9upqhSuRfOpu/xIU83rk4r99A8H6Go3gfZAu5bClnfRBkPJAHuN
 f7VhUOmSfiBf2Pdx9hv8UBlkPWaaQYaaIVvBJ1Q/m5nMLopT0aaLbeMRteSBjHP9NxNUemUOOdi
 jPjP/wc/0Gwoma3mbCB97d27LJ3iX96fJSKYhHAx7ICqYnFu1cyy6z6j1NYtOEZnLckqlzCP+9+
 /2zkb/0EERFNDONBvKTW8CHPP5yS+6sbwmYS11KG61joRGc2p54UzriCxmQm8QQKEY+y6OaBSLP
 GfZBGRbiHU3svVpAv349T+e9F/CA+Gz8jmIFO4/EOqmqfewtwYjWfYZTXAKwJRUc/XfUvETwVGh
 sKwTUs9OaJfUS/68jLivYYH3hXC+br8Rh5jsYEMAFOdbUNBsvRrLIr/Q5T3YcUavSmG7kJhChPI
 FAEV6Un2tu01+QJ7yJMFLLUAv/chCeK6M5CQua37XRGjy9HHJfuWDLv1sqR4sg0uWD8YzcsqqYm
 E73SGTUXBIFWbwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Returning NULL without setting an error is odd.

Note that we could make this a programming error too, as the duplicate
check is also done during QemuOpt parsing.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 03b99c9e590..2c53c92914b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3428,6 +3428,7 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
     VncDisplay *vd;
 
     if (vnc_display_find(id) != NULL) {
+        error_setg(errp, "Display '%s' already exists", id);
         return NULL;
     }
     vd = g_malloc0(sizeof(*vd));

-- 
2.53.0


