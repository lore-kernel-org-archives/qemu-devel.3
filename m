Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B02F33817
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QAq-0007Ba-Pd; Tue, 17 Mar 2026 04:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9a-0005q8-UW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9Y-00033n-Rm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktQKPvUEkRhNvH7YblXNHrNMBIa+G6h1E8k2vkvue1c=;
 b=HLe+QVvQwX9CgB7zUD92rlrJPsDiFrDsZbkAK8LcdxITnepCgWzSOJ27XvMv2ludUVin97
 s4jZQw753Zewm1Q1FAm1V+xu0fauTcUlWmsJuud8hHyGe9Bp/kbBv76AQycpv7RgqOR3IU
 rFLZJIB3MILHtYa/MDem1bJRV0++Px8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-mQBgW8A2NZucFq7FbK_w3w-1; Tue,
 17 Mar 2026 04:51:50 -0400
X-MC-Unique: mQBgW8A2NZucFq7FbK_w3w-1
X-Mimecast-MFC-AGG-ID: mQBgW8A2NZucFq7FbK_w3w_1773737509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C20F195609F
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 421A819560AB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:26 +0400
Subject: [PATCH 12/60] ui/console-vc: ignore string-type escape sequences
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-12-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=f/b+Vqp3tW85Fl5OGNgo2S0lc795EiiBKc5ilwNVUQ4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXa2q0aMN3gjFKxSCMunvPRkI6bSKaDQQb5L
 KxQFhOwC+mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5VQKD/96ytkx6sHIS3nh/TnogVSIOVzpAPJ4jFPWrkJRlLCjknA0aNnS8SIldyqFTRG+qyB2CJQ
 qxw3NqiGmoy36ceRcDzu2jSWhhYI59DTGnYlFC4+Os7V1RVHU1N/yTuZJZgc3LiMDT/0ZUbR0pE
 twHRwTto/pmUrwIpTpZMItKF+08G/GVnCUGQk3z+c5Fp6SdIp1rEmrYLT2SXRYMnP/Rp2EfJLD8
 2GHMuKUOw3buMlFeM7YkP8cRfx4WOGefA/VcxuiKWPFPbcKkxUfTYktO1qy5nQGIPY9IgljEacG
 HNnHTXlYM6qx/mUhF9LZRJVNmgml+/n+enxklWK3FsnNvC/7+TSI8EY3JUOhDv5GTMNF+hjd9KW
 pYfULwmPUENEeo7AWOHvh/aKU4UEJxTxat9OezR8j19x48aA0E/sPlaHGQTYVJCkDvE4Ozzvz86
 ggLxx4Bu9yznaB2xd+VHNkKqTV4k8AoI0yLetbQFX18Eu++CUO2ay6HA0CDyTzQ6oe1H1jXUkoa
 CYXe6zSYM/c1tC/1fZyGycpzWkMDw6ckW/v8MNhlva2ceiY1UJjEh3WrlzSAZvNKyuX5A3zHmOA
 /0zVRun0H3b9IS5iPE/Lpe/G6ijnWn9DtHYrkT2lP0dGcjGY6dNTE8p+xxvO9LFKt47R7wSsrAX
 foSpkwdxQI+iz7Q==
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

Modern terminals and applications emit OSC (Operating System Command),
DCS, SOS, PM, and APC escape sequences (e.g. for setting window
titles).  The text console currently does not recognise these
string-type introducers, so each byte of the payload is interpreted as
a normal character or a new escape, producing garbage on screen.

Add a TTY_STATE_OSC state that silently consumes all bytes until the
sequence is terminated by BEL or ST (ESC \).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 7bbd65dea27..5eca9a5c004 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -45,6 +45,7 @@ enum TTYState {
     TTY_STATE_CSI,
     TTY_STATE_G0,
     TTY_STATE_G1,
+    TTY_STATE_OSC,
 };
 
 typedef struct QemuTextConsole {
@@ -869,6 +870,10 @@ static void vc_putchar(VCChardev *vc, int ch)
             vc->state = TTY_STATE_G0;
         } else if (ch == ')') {
             vc->state = TTY_STATE_G1;
+        } else if (ch == ']' || ch == 'P' || ch == 'X'
+                   || ch == '^' || ch == '_') {
+            /* String sequences: OSC, DCS, SOS, PM, APC */
+            vc->state = TTY_STATE_OSC;
         } else if (ch == '7') {
             vc_save_cursor(vc);
             vc->state = TTY_STATE_NORM;
@@ -1027,6 +1032,16 @@ static void vc_putchar(VCChardev *vc, int ch)
             break;
         }
         break;
+    case TTY_STATE_OSC: /* Operating System Command: ESC ] ... BEL/ST */
+        if (ch == '\a') {
+            /* BEL terminates OSC */
+            vc->state = TTY_STATE_NORM;
+        } else if (ch == 27) {
+            /* ESC might start ST (ESC \) */
+            vc->state = TTY_STATE_ESC;
+        }
+        /* All other bytes are silently consumed */
+        break;
     case TTY_STATE_G0: /* set character sets */
     case TTY_STATE_G1: /* set character sets */
         switch (ch) {

-- 
2.53.0


