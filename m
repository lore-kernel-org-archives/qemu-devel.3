Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0C9E6F086
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 20:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6xzV-0007ur-Oz; Fri, 01 Nov 2024 16:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6xzU-0007ua-93
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 16:11:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6xzR-0008EM-33
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 16:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=3KDv5rIFyph+Ev4uDuNOLGT0kgMo0h7nOk2682XAxDs=; b=tuCWBmmqbLLA4aM1Ux9H1cOspN
 PFfUzM8VHT/n1qKjqxLBPvvlNr8dP7RRMLKP7SiKyDZqmzH7KJZeTwnV9IY1UrQAJj7x/fgz4Bu+w
 P9IzsAqd7Ev+d5HsqEezMN4Gv+V/ORRFM6mcg4L0rrm9eZ9zDhpDUhcay3hVi5NxKXavGX+wALYWy
 IE70aYps47KuZdPiBR9ki2h7GXi0hHr5J4ayn2AUhNfCxSJsrsqH3bSPWSWxiiEY3Kj5hjtxdzoHf
 SIITzYoORxhuvBnvk2Tl9AQPAm0nc8NRkOymyNHPtwxuKj5dVENBCh3f5INkXevfTIgbOEgS6oWlo
 PInB8YChiJkJlKl0Jqhb5AhTUiDJ8H63+GV5VB6z44JaJbS8QqIfxV4cxcyD5BymAE9iRxGeeRn5/
 kKF6yL78pw+8tuPBLp16lIR6P27EzkrjYNsSdR8vEdHY6wIngIsAKQj29ncw9PjSaGrcx4pYmeOAP
 TuE0K5h8ejNZbcIP7yZXHoIzHNCJWVkOMOMcp7bGS0P2EmchRn4nKeU4HugL6gCbxjmWW/1E4RPW+
 PI4woHcfd+JZGnNLI6cM04mCqKhgqdQk9QzifBdCdqO8VHhU/Alb8PuZrEn5LlfBCjHu+43N/g3Xj
 mjTtCOGg7Wbs4pSROPgCia4dZgjFS5UmLskny9yP4=;
Received: from [2a00:23c4:8bb8:f600:91a1:336d:3931:745]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6xz0-0002Im-1U; Fri, 01 Nov 2024 20:11:02 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri,  1 Nov 2024 20:11:04 +0000
Message-Id: <20241101201106.1432336-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:91a1:336d:3931:745
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 0/2] next-kbd: convert to use qemu_input_handler_register()
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

v3:
- Rebase onto master
- Use Q_KEY_CODE__MAX for the size of qcode_to_nextkbd_keycode() array
- Fix shift key logic using example provided by Thomas
- Fix spelling of NEXTKBD_NO_KEY
- Add R-B tag from Alex for patch 2

v2:
- Rebase onto master
- Add patch 2 to remove the legacy qemu_add_kbd_event_handler()
  function


Mark Cave-Ayland (2):
  next-kbd: convert to use qemu_input_handler_register()
  ui/input-legacy.c: remove unused legacy qemu_add_kbd_event_handler()
    function

 hw/m68k/next-kbd.c   | 166 +++++++++++++++++++++++++++++--------------
 include/ui/console.h |   2 -
 ui/input-legacy.c    |  37 ----------
 3 files changed, 111 insertions(+), 94 deletions(-)

-- 
2.39.5


