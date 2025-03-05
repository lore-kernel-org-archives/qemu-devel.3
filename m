Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B283C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiSC-0001Rn-TY; Wed, 05 Mar 2025 01:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiS9-0001QW-Vr
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiS8-0001hf-1l
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6WtSV2HfPPKPY4jjs82QphitS5TNefKH9Qq4m892qg=;
 b=Mo9pMxXgWw9ATKSJ4OsD8qCkJjAd0zdn6bGhITUG/ROnkgwc2DwuaXwEuR3/re+eOb1Rl8
 GO9GaOgbrI9pelNE12h1ZTZyKWBwbZLf7W4YmLVDxmux8SVq1I59LhiCjHgR9rW8J96AOi
 Ci5kTw7eZTp1VToxf+lPRjH/meel3OI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-BneeBSL_MI6McrXtG-zH-g-1; Wed,
 05 Mar 2025 01:41:49 -0500
X-MC-Unique: BneeBSL_MI6McrXtG-zH-g-1
X-Mimecast-MFC-AGG-ID: BneeBSL_MI6McrXtG-zH-g_1741156908
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97B4E1801A09; Wed,  5 Mar 2025 06:41:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5DA4180049D; Wed,  5 Mar 2025 06:41:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/6] ui/console-vc: introduce parsing of the 'ESC ( <ch>'
 sequence
Date: Wed,  5 Mar 2025 10:41:27 +0400
Message-ID: <20250305064132.87441-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250305064132.87441-1-marcandre.lureau@redhat.com>
References: <20250305064132.87441-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Roman Penyaev <r.peniaev@gmail.com>

This change introduces parsing of the 'ESC ( <ch>' sequence, which is
supposed to change character set [1]. In the QEMU case, the
introduced parsing logic does not actually change the character set, but
simply parses the sequence and does not let output of a tool to be
corrupted with leftovers: `top` sends 'ESC ( B', so if character
sequence is not parsed correctly, chracter 'B' appears in the output:

  Btop - 11:08:42 up 5 min,  1 user,  load average: 0BB
  Tasks:B 158 Btotal,B  1 Brunning,B 157 Bsleeping,B   0 BsBB
  %Cpu(s):B  0.0 Bus,B  0.0 Bsy,B  0.0 Bni,B 99.8 Bid,B  0.2 BB
  MiB Mem :B   7955.6 Btotal,B   7778.6 Bfree,B     79.6 BB
  MiB Swap:B      0.0 Btotal,B      0.0 Bfree,B      0.0 BB

      PID USER      PR  NI    VIRT    RES    SHR S B
  B    735 root      20   0    9328   3540   3152 R B
  B      1 root      20   0   20084  10904   8404 S B
  B      2 root      20   0       0      0      0 S B

[1] https://vt100.net/docs/vt100-ug/chapter3.html#SCS

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250226075913.353676-2-r.peniaev@gmail.com>
---
 ui/console-vc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index fe20579832..90ff0ffda8 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -42,6 +42,8 @@ enum TTYState {
     TTY_STATE_NORM,
     TTY_STATE_ESC,
     TTY_STATE_CSI,
+    TTY_STATE_G0,
+    TTY_STATE_G1,
 };
 
 typedef struct QemuTextConsole {
@@ -694,6 +696,10 @@ static void vc_putchar(VCChardev *vc, int ch)
                 vc->esc_params[i] = 0;
             vc->nb_esc_params = 0;
             vc->state = TTY_STATE_CSI;
+        } else if (ch == '(') {
+            vc->state = TTY_STATE_G0;
+        } else if (ch == ')') {
+            vc->state = TTY_STATE_G1;
         } else {
             vc->state = TTY_STATE_NORM;
         }
@@ -844,6 +850,16 @@ static void vc_putchar(VCChardev *vc, int ch)
             }
             break;
         }
+        break;
+    case TTY_STATE_G0: /* set character sets */
+    case TTY_STATE_G1: /* set character sets */
+        switch (ch) {
+        case 'B':
+            /* Latin-1 map */
+            break;
+        }
+        vc->state = TTY_STATE_NORM;
+        break;
     }
 }
 
-- 
2.47.0


