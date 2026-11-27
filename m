Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16609606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Dz2Ng083
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6n-0004zq-Fk; Fri, 27 Nov 2026 01:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5n-0000jq-PS; Fri, 27 Nov 2026 01:05:56 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5m-0006Zk-04; Fri, 27 Nov 2026 01:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759046; bh=6r6nfvj5g0Pb9Rf4Ck6LuUTc5RX+dYc28ZOztZyiHk0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Dz2Ng083CSlrdhE0nyKvx/L+ttBmRui0hEpbPIkfoZSzyMsnVntEveujBjs0jtIkF
 ObBE+2oHfMg2SHokS6zTje3Uz2Dj+mtLws7AdO7uKRF8SBVuhB1J0kwuid1+4spVZB
 p9bkIhzDtUBhwAgsYASpWT2NpfpL4j8ZNVrp5HPJ+wer156QWcKpUieizBhEgwmd4g
 EjjOxV3cg2hZtqdwHfUBJ7auW8wBDrn+QOpqBWQTFk8ICArqpX4JxFLWJ//nltCEn/
 ++hZANbXvnDKEu002SLUY5tdvndA3hxxOroR0BaliF/3IBp4lAKZt7jVaOzimOFmio
 nBfl4KXnuZoKQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC59C1EA352;
 Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E9C0D46997D;
 Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E3667CF2F2; Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tommaso Califano <tcalifano@redhat.com>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 096/152] hw/usb/dev-mtp: Stop processing
 SendObjectInfo after an error
Date: Fri, 27 Nov 2026 08:53:54 +0300
Message-ID: <20261127055709.39630-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tommaso Califano <tcalifano@redhat.com>

When SendObjectInfo fails its checks, usb_mtp_command() queues an error
response and then falls through. It still allocates s->data_out. The
data phase is then dropped because a result is pending, so s->data_out
is never released.

Return right after queueing the error response.

Cc: qemu-stable@nongnu.org
Fixes: 53735bef108c ("usb-mtp: Advertise SendObjectInfo for write support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
Tested-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261112174907.158825-10-tcalifano@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit fe2a7966db94e9ed37a0dc4b40ad79a0e6041ecc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 92dc9a9e21d..a8b89c938b7 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1393,14 +1393,17 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (!FLAG_SET(s, MTP_FLAG_WRITABLE)) {
             usb_mtp_queue_result(s, RES_STORE_READ_ONLY,
                                  c->trans, 0, 0, 0, 0);
+            return;
         } else if (c->argv[0] && (c->argv[0] != QEMU_STORAGE_ID)) {
             /* First parameter points to storage id or is 0 */
             usb_mtp_queue_result(s, RES_STORE_NOT_AVAILABLE, c->trans,
                                  0, 0, 0, 0);
+            return;
         } else if (c->argv[1] && !c->argv[0]) {
             /* If second parameter is specified, first must also be specified */
             usb_mtp_queue_result(s, RES_DESTINATION_UNSUPPORTED, c->trans,
                                  0, 0, 0, 0);
+            return;
         } else {
             uint32_t handle = c->argv[1];
             if (handle == 0xFFFFFFFF || handle == 0) {
@@ -1412,9 +1415,11 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
             if (o == NULL) {
                 usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE, c->trans,
                                      0, 0, 0, 0);
+                return;
             } else if (o->format != FMT_ASSOCIATION) {
                 usb_mtp_queue_result(s, RES_INVALID_PARENT_OBJECT, c->trans,
                                      0, 0, 0, 0);
+                return;
             }
         }
         if (o) {
-- 
2.47.3


