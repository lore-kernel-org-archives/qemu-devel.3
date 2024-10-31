Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BFBE67491
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 23:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ehC-0002pu-AW; Thu, 31 Oct 2024 19:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6ehA-0002oy-NJ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 19:35:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6eh5-0004DF-EG
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 19:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=3gS3We5D0bP2IZzSLJNCDAJQrvBKPA2AQrUhtJx8648=; b=oYULOv2ChXaH3MWD08zCoY5mYi
 b3CBr8Ib5BaUbBXb7nUA627CKuGfGhoDLx/oV/g+4PED2iT4BugJkPg/S+wRYhgYmarXDldViamKE
 SotecJAoFibXaiKxTLNyYbE+yYre56Qaco9GFFqc//qlGEk1hR4zTcwZPREcsVM9gv1rL7IfJX+cG
 8vN7O3zXuOZU0wFq/35HLWR0uwv/6HqRhOeQGLtMKfHnlaLR2bIo7CC95kuKQhPvX22hFHGmjaXAI
 K3coboFyctnqYTzh7+hIUoMo7WHIn39Fj2RXuwPSEdejfp+YWc8GJbuX5wl6ei8grW70i/ZD6YsET
 j51bPUwvyKmy3/pHmZTnAXbF4KiNm2izWnunkIqFQYHVG3Ne7vMkB086em1dGT3NCeWie+5AUmWK+
 EnHuR23wxiza+Sjm/0h0ZsTuDzOldw2YceKE9rQLLx4P2s1q/kTZUq4zZbhGHJeVhGzRVDN47Vd+Z
 yvB/sFufceKNYU9gsigj3uFIL0AScHzcJOokGui2T+5AWm/DXWEiVH8v/19B0Vou49myqz3iUUmG6
 VcEpinoL3GJQmk/lAKfdnSVwngzfWVz35++Pk4spcf077O9AdkuGK4ulf+M9xfXhlYs6plgryZyq+
 xp5iCZOvEnLmAZFfnTnNHQwRX0cDZuuyW1eMA/Pv8=;
Received: from [2a00:23c4:8bb8:f600:57e5:6c14:c98a:3cb9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6ege-0008Ee-VK; Thu, 31 Oct 2024 23:34:49 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 31 Oct 2024 23:34:50 +0000
Message-Id: <20241031233452.1388728-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:57e5:6c14:c98a:3cb9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 0/2] next-kbd: convert to use qemu_input_handler_register()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series converts the next-kbd device to use 
qemu_input_handler_register(), and then removes the now-unused legacy 
qemu_add_kbd_event_handler() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2:
- Rebase onto master
- Add patch 2 to remove the legacy qemu_add_kbd_event_handler()
  function

Mark Cave-Ayland (2):
  next-kbd: convert to use qemu_input_handler_register()
  ui/input-legacy.c: remove unused legacy qemu_add_kbd_event_handler()
    function

 hw/m68k/next-kbd.c   | 158 ++++++++++++++++++++++++++++---------------
 include/ui/console.h |   2 -
 ui/input-legacy.c    |  37 ----------
 3 files changed, 103 insertions(+), 94 deletions(-)

-- 
2.39.5


