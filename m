Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F079CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQA-00016j-Rj; Sun, 04 Oct 2026 06:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPc-0007Wa-K3
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPZ-0003LD-Rk
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dp+eTQQpowvqJbb7n0XlhxLHsD3ScVyNygDug1P+lIw=;
 b=ZqIMFomiLiw+M6KwExQ5a/28memndzykmVmc3SXsFo5YZkHxu6uOHpF/lBbSUYvr1mB4PO
 8RWsThgiKLuHgzL3vSXMoP0P2qGwxZp3OE7weTCX/ZDvO+Di2+IhuRwpcWrTNCq4Jqcbpx
 /pr1zXWuXMkevCbCCDSYG8cwnWbnZxQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-s9x1VG2iOTOu5JWLQfXMlg-1; Sun,
 04 Oct 2026 06:25:36 -0400
X-MC-Unique: s9x1VG2iOTOu5JWLQfXMlg-1
X-Mimecast-MFC-AGG-ID: s9x1VG2iOTOu5JWLQfXMlg_1791109535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8071954B01; Sun,  4 Oct 2026 10:25:35 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07CA7180036E; Sun,  4 Oct 2026 10:25:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:47 +0400
Subject: [PATCH 33/63] hw/char/ibex_uart: prevent division by zero on baud
 rate calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-33-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7M1aiGYKZF3529Y7CF3n1zUfXvb5KY5JNB5nTmCnGrQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikj5HocxAzSwzcnET54qfbKFE0gI7r6hvX7K
 8myqQY9xkCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5ZLUD/43Yhyuf6+2RNcwhNwYWDxw23rzOIFF8d5NQabzudPrCqLNQNY39dG0bYv1pb34UYaDVGL
 TcDVu/gCdnkPC7U1mwWaH3qp0/ZGBrtSidJlFDf1/Nnl5E8RZpaCY8T6IGX4Du05S3ROHVQMSnQ
 eo/88XPxlH7vbct4mid+ksDrMjp0p480pDrTG8BgF5nbvM5+MCYeCe2oWpu3Pj0XIbFZFoxzdv8
 GxQjosjLJ5wb43SDv11+xwywkf7DDiVLoi2iL9nLT9u5gm4WdwQH0XDzkmi6zfqH4/IO4+vyYnd
 EgVEXtbBCcWIek8qwwD7ajloSy3hirzRWrbIfRoDCOKzJvdXoEbyOB6inlf7d/S2r+tz91LbpAF
 Gp6J8B/GU5g4ysNE3JjcOBWDJctUHQdzqlruhcdUcU7DsDY6Et7DOdIt/cyMox/QgRCOiX8yJBS
 t+xe+GnDJmQuqUX6bO5tDijrzTMCIcLT4/G9fcILZWr/zTsYy6ebniPxWDUzaVuE3iu0zVeRtlZ
 7Po0w3gOePOFQMLQClAFOBjauq/NFUu6ehxT1IRDAW8C8hvaUbS37nLJ5zxJcCbqYe7ehUKgaFr
 aVbvVMBQsIwTAhFd7L07WG0LIDMZuZhSr1J4EY+C8b6XUscCSB/7Mh98f81D9L73SdnnZJF8i9g
 AQavCIYKM6vQqwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

Guard NANOSECONDS_PER_SECOND / baud with a zero check. The baud rate
can be zero when the NCO field is zero or the input clock is not yet
configured.

Fixes: a7d2d98c5944 ("hw/char: Initial commit of Ibex UART")
Fixes: 940aabb9f477 ("hw/char: Convert the Ibex UART to use the qdev Clock model")
Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/ibex_uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 26ed1aea140b..4c22fb4f58a8 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -395,7 +395,9 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
         if (value & R_CTRL_NCO_MASK) {
             uint64_t baud = ibex_uart_get_baud(s);
 
-            s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
+            if (baud) {
+                s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
+            }
         }
         break;
     case R_STATUS:
@@ -455,7 +457,9 @@ static void ibex_uart_clk_update(void *opaque, ClockEvent event)
     /* recompute uart's speed on clock change */
     uint64_t baud = ibex_uart_get_baud(s);
 
-    s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
+    if (baud) {
+        s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
+    }
 }
 
 static void fifo_trigger_update(void *opaque)

-- 
2.56.0.rc0.29.g47ce80527c56


