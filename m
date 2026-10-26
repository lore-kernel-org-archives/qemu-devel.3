Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FAF606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ra1cOYQI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLEG-0003jv-BF; Mon, 26 Oct 2026 09:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLEA-0003ch-0P; Mon, 26 Oct 2026 09:59:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLE8-0000Yj-7q; Mon, 26 Oct 2026 09:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022944; bh=t21KsQ44QOhSVrHR+Ud3K4EGLuhu7HucZTA1uptMvo0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ra1cOYQIThGZZpBOB8U+VE2ACKMX5ClPYHLwxcwVNKh2fB283IUGchPMPWNZoe+c0
 +ccdSeAxHc4r0IwrRclQI/WCfGFPklM6z0ocfzh7CqswIUk/sVyXx9oPLDLwDU99H9
 IJlxU8vTYzL0RzsK3Yc78paZwK/zDADA0sxuWM2VPJS//n6H3PRPSgpdy99y7oMn7C
 nT9ydk4LqnU9WdTznzCVVGuD9JJgCa27boC8PpQ2II/qYKgoNZ5Jwe9/UZS0n/JRM3
 zblF8eTqK0RJ3poWzeg4G0fYbUP48w4E0rCVpvyxliaU83kx6maYAbumwgaKW1c5L0
 cp5rtNr1F7eUA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3D9121E12AA;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3B48E44B8FB;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1793C934DB; Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tommaso Califano <tcalifano@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 93/98] hw/usb/dev-mtp: Fix assert crash on short
 CMD_SEND_OBJECT
Date: Mon, 26 Oct 2026 16:55:20 +0300
Message-ID: <20261026135529.1019772-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
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

In usb_mtp_get_data() there is a guest-triggerable assertion that fires
when a guest declares a large object size in CMD_SEND_OBJECT_INFO but
sends fewer bytes in the subsequent CMD_SEND_OBJECT. The assertion
compares the declared size against the actual bytes received.

If the guest sends CMD_SEND_OBJECT_INFO with size=1000 and then
CMD_SEND_OBJECT with only 50 bytes (short, non-64-byte-aligned
final USB packet) the assertion fires, killing QEMU.

To prevent that is sufficient to remove the assertion, because the case
is handled by usb_mtp_write_data() which returns RES_INCOMPLETE_TRANSFER.

Fixes: 3e096650a64d ("dev-mtp: Add support for > 4GB file transfers")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3993
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261008122936.45081-1-tcalifano@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 1ccf17e9dc6bba38a9bddd3d66fdab458a50c906)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index cbc2be3317f..9048cddaaba 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1813,9 +1813,6 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         d->offset += dlen;
         d->data_offset += dlen;
         if ((p->iov.size % 64) || !p->iov.size) {
-            assert((s->dataset.size == 0xFFFFFFFF) ||
-                   (s->dataset.size == d->offset));
-
             if (d->length == MTP_WRITE_BUF_SZ) {
                 d->write_status = WRITE_END;
             } else {
-- 
2.47.3


