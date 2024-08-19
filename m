Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2D5C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 23:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBdr-0005g3-AL; Mon, 19 Aug 2024 19:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sgBdm-0005fP-Pf
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 19:18:23 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sgBdk-0003ww-Py
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 19:18:22 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id 8F9DE345EA;
 Mon, 19 Aug 2024 16:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1724109487;
 bh=4nK1yXULlVUlPzlUmNI6v169jmuG0uyg1zsAs5CH1Xc=;
 h=Date:From:Subject:To;
 b=InTZUFT6XLCmoCzl8rV2oDI6X2TJB0Bk1i+LQpJJAB6ZOMmU+xr4XqlCEtp9bfdob
 tnGaN9cs4qGLZoQlqDAOTdav0pSBi5wepmubR/YdLFTLLA+YHVFPK836ivVOKek6id
 POtDCYD4DKsJinf1phg4Sa7Ug4t8Ac+jNoGDkKlc=
Message-ID: <cb338cdc-d09d-4513-ba16-5ff3f792bbfe@pullman.com>
Date: Mon, 19 Aug 2024 16:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Carl Hauser <chauser@pullman.com>
Subject: [PATCH] hw/char: suppress sunmouse events with no changes
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=64.126.132.23; envelope-from=chauser@pullman.com;
 helo=secure.fsr.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

 From f155cbd57b37fa600c580ed30d593f47383ecd38 Mon Sep 17 00:00:00 2001
From: Carl Hauser <chauser@pullman.com>
Date: Fri, 16 Aug 2024 09:20:36 -0700
Subject: [PATCH] hw/char: suppress sunmouse events with no changes

Sun optical mice circa 1993 were based on the Mouse Systems
Corp. optical mice. The technical manual for those mice
states that mice only send events when there is motion or the
button state changes. The Solaris 2.5.6 mouse driver seems
to be confused by updates that don't follow this specification.

This patch adds a field to the ESCCChannelState to contain
the button state sent in the last event and uses that in
sunmouse_event to avoid sending unnecessary updates.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2518
Signed-off-by: Carl Hauser <chauser@pullman.com>
---
  hw/char/escc.c         | 10 ++++++++++
  include/hw/char/escc.h |  1 +
  2 files changed, 11 insertions(+)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index d450d70eda..7732141cf5 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -287,6 +287,7 @@ static void escc_reset_chn(ESCCChannelState *s)
      s->rxint = s->txint = 0;
      s->rxint_under_svc = s->txint_under_svc = 0;
      s->e0_mode = s->led_mode = s->caps_lock_mode = s->num_lock_mode = 0;
+    s->sunmouse_prev_state = 0;
      clear_queue(s);
  }

@@ -959,6 +960,15 @@ static void sunmouse_event(void *opaque,
      int ch;

      trace_escc_sunmouse_event(dx, dy, buttons_state);
+
+    /* Don't send duplicate events without motion */
+    if (dx == 0 &&
+        dy == 0 &&
+        (s->sunmouse_prev_state ^ buttons_state) == 0) {
+        return;
+    }
+    s->sunmouse_prev_state = buttons_state;
+
      ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */

      if (buttons_state & MOUSE_EVENT_LBUTTON) {
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 5669a5b811..bc5ba4f564 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -46,6 +46,7 @@ typedef struct ESCCChannelState {
      uint8_t rx, tx;
      QemuInputHandlerState *hs;
      char *sunkbd_layout;
+    int sunmouse_prev_state;
  } ESCCChannelState;

  struct ESCCState {
-- 
2.34.1

