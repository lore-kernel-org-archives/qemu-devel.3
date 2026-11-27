Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B794606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=M0nNHfQ/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6b-0004il-GM; Fri, 27 Nov 2026 01:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5S-00083I-3q; Fri, 27 Nov 2026 01:05:35 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5P-0006LK-KJ; Fri, 27 Nov 2026 01:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759046; bh=66B+5IWNTIIs/oBTTaqSrdxOIqK8ZqhBD7MiRfgpahA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M0nNHfQ/EiKRSVU44i3K8sXV/b3/VKu17mDF2W5teodF8N6UOvmsjTTx1K3LEJqs3
 S3LL+SxG8ueAOK1WG6gq0ZJJgA7gttgxEPeclMybpgXkHaZwoINAVoiHAYTx9FBjOa
 UevaKTbcAUrzAb91tae8fmyrH325wNxzxP/cK5x9QR6fypRLcYutOQc/hiISNeEsV7
 zvDtP0mBfBthIls4g8mgU2TeGRwXg9HXYuxiWNdiG7XnNxbKDYSwprhOSIS91TLS8g
 BEnmtlUX8EL/ydsQHhy9tPA+8Run3Jwafhp8UPwK2dqE+Fi+p/Z7IZtYTjm59Cy0ht
 94onlvjicuo+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 390AC1EA351;
 Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 36A7346997C;
 Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2FD7ECF2F0; Fri, 27 Nov 2026 08:57:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tommaso Califano <tcalifano@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 095/152] hw/usb/dev-mtp: Check length of class
 control request
Date: Fri, 27 Nov 2026 08:53:53 +0300
Message-ID: <20261127055709.39630-32-mjt@tls.msk.ru>
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

usb_mtp_handle_control() reads a 16-bit event code from the request
data without checking that the host actually sent it. A request with
wLength < 2 makes the device act on stale bytes left in the control
buffer.

STALL requests that are too short to hold the event code.

Cc: qemu-stable@nongnu.org
Fixes: 47bff13cea8d ("dev-mtp: add support for canceling transaction")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261112174907.158825-4-tcalifano@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 69aedf407d94012a7580155bd760e0aa24b6f76b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index bc5a6f08917..92dc9a9e21d 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1516,6 +1516,10 @@ static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
 
     switch (request) {
     case ClassInterfaceOutRequest | 0x64:
+        if (length < sizeof(*event)) {
+            p->status = USB_RET_STALL;
+            break;
+        }
         if (*event == EVT_CANCEL_TRANSACTION) {
             g_free(s->result);
             s->result = NULL;
-- 
2.47.3


