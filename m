Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC42F9D0F6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 01:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCozd-0003zg-BR; Tue, 14 Apr 2026 21:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wCozX-0003z4-Oi
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 21:24:32 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wCozU-0007sT-TJ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 21:24:31 -0400
X-UUID: cdaa65d8386911f1aa26b74ffac11d73-20260415
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:838ace5f-8f5c-4dc6-a8c8-f8f6d1ca7cc3, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-INFO: VERSION:1.3.12, REQID:838ace5f-8f5c-4dc6-a8c8-f8f6d1ca7cc3, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:a73e5dc2a6387b21f940792dbf995a6c,
 BulkI
 D:260415092410WP6HJ0RW,BulkQuantity:0,Recheck:0,SF:10|66|78|101|102|123|12
 7|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
 il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
 E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cdaa65d8386911f1aa26b74ffac11d73-20260415
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1546656504; Wed, 15 Apr 2026 09:24:09 +0800
From: zhaoguohan@kylinos.cn
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] ui/vnc-clipboard: validate decompressed text length
Date: Wed, 15 Apr 2026 09:23:36 +0800
Message-ID: <20260415012336.964736-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

The decompressed clipboard data starts with a 32-bit text length.
Check that the advertised length fits in the payload after that
header before passing it to qemu_clipboard_set_data().

Otherwise a malformed VNC clipboard message can make QEMU read past
the end of the decompressed buffer.

Fixes: 0bf41cab93e5 ("ui/vnc: clipboard support")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 ui/vnc-clipboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 124b6fbd9c23..85851a632dba 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -281,8 +281,8 @@ void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t
         if ((flags & VNC_CLIPBOARD_TEXT) &&
             buf && size >= 4) {
             uint32_t tsize = read_u32(buf, 0);
-            uint8_t *tbuf = buf + 4;
-            if (tsize < size) {
+            uint8_t *tbuf = buf + sizeof(tsize);
+            if (tsize <= size - sizeof(tsize)) {
                 qemu_clipboard_set_data(&vs->cbpeer, vs->cbinfo,
                                         QEMU_CLIPBOARD_TYPE_TEXT,
                                         tsize, tbuf, true);
-- 
2.43.0


