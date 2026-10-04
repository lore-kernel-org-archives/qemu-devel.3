Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCDACA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPv-0008VE-JY; Sun, 04 Oct 2026 06:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPN-0007Ee-B4
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPL-00038A-Qd
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaFCs7lE4/I/Lt12U6WDIaY5UfCf1XuG1kBL0bqbZg0=;
 b=NfG0Coj/M5Uq40rc/cqp+sjhRt8YRzefPUE1VH7RVwxYInNTX2921JWRaPXwRsSMAbLl9I
 3eWT4Cc3Wo5EAhxaav1SBwIouPLj/7tLF0SyrX321ntnpWmxzZ19dOQgHNzv2k1ZcD8If7
 ZK5KHvO9b8RSrQ1VnJAytx9Z6wneDco=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-LtiIQx7SM5iV36a2RihNGQ-1; Sun,
 04 Oct 2026 06:25:22 -0400
X-MC-Unique: LtiIQx7SM5iV36a2RihNGQ-1
X-Mimecast-MFC-AGG-ID: LtiIQx7SM5iV36a2RihNGQ_1791109521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2964518089B6; Sun,  4 Oct 2026 10:25:21 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F3F330000E5; Sun,  4 Oct 2026 10:25:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:43 +0400
Subject: [PATCH 29/63] hw/char/cadence_uart: fix post_load return value for
 invalid baud rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-29-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NfS9sXmYe40U6m+E7dk6aeNn8oVAGG56/B9uaTvVBi0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikj2huwpN+GmOwKvh+HIPgQ+U0ogK7NcA7T7
 cVFBDdnKBSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5YQhD/9co+/MGPZjP4pVoZNEB87wACI3JlyCsa+8XMe1ze6edQtmsWoa+3rcgqbIBhH8mJ+10Xc
 gOXkJFN3k8Bqj1CScUUVKMy++heyIo8dZH/UekppUsudrmhQ2ejC0V2yhSUI3CFrlvCcDhSs2rE
 i+qLJAPZCuxiruWMbqSrDy8G3wQ8bSMYpAsXPlCblwAsIoBBMiwOXB79opFTwqtZXnPlmTdyIOy
 6cAClGmKzTTZmR7aASjs4yB1M/M9i/Ckog+p9dckTlqTIuFCDSdYJlxB5pClSwLuhbFte0fygD2
 gTDx3PGZOhELPjbZ12UBKnAGAiX75BHe6+sn9Kik5snwGSpuk3dfSKcRZmfBj1dYO+6UIC8cZji
 00UZ8SfuqvyG3mKuP4+QjTJKJEt9LE91yH8pAekWlJRIlKjNE9gTZb4X07thgGC3ZdBos+ycSiJ
 +2ZAWf8rwQMXfOL+MCdswaAWWoAlzaoTM/N5J5EyLupy8dYBchn+sdXJes8eteahD6ylmIoQQgG
 75UxPZdLHEm0TlUP1nhFah5KfKGfeN78yJoaAo28AULL6uemLrfk0HgNztN3ZIIWhq+5qd7jrHo
 ha0YEWbD72h65U28eaWgBnZ/Bp3H+HGeY2uS8jT+pDi+H2wKlBvOi0P//J0yTO7hf61YTOkeks1
 qwumlE/msSj1cbw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

post_load must return a negative errno on failure, but the BRGR/BDIV
validation was returning 1 (positive), which the caller treats as
success. Return -EINVAL instead.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 6e29651c5e3a ("char: cadence: check baud rate generator and divider values")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/cadence_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 1a065e2429eb..263c28bb7197 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -594,8 +594,7 @@ static int cadence_uart_post_load(void *opaque, int version_id)
     /* Ensure these two aren't invalid numbers */
     if (s->r[R_BRGR] < 1 || s->r[R_BRGR] & ~0xFFFF ||
         s->r[R_BDIV] <= 3 || s->r[R_BDIV] & ~0xFF) {
-        /* Value is invalid, abort */
-        return 1;
+        return -EINVAL;
     }
 
     uart_parameters_setup(s);

-- 
2.56.0.rc0.29.g47ce80527c56


