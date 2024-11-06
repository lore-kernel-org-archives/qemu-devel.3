Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3DBD44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8erD-0006L8-Qo; Wed, 06 Nov 2024 07:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8er2-0006KR-5m
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:09:45 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8eqy-0007ZE-U1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=jDQksFVh71czgxyQCDtOjtoElAqy4U5LSzu2oG/8G0o=; b=zXQiDN+F2cxGG2LsB/JXap6xN4
 f9Iqgjimqhg0/XPvAKqLA4TdwSaRyskHm7L+Xekf4LPHL0K3RNolhqLFMDqUd3hVdfaUl8loaxjVI
 KfJoZkKDMSXl3ubwcRJNx6+w8iB0CQQYFUIunQHGsN8ZodXkjXvlBls1OT28g7Qardzb+7HPPyD/Y
 eOcV1VKQ7jfl3+oLv/PoNGTH6XSwU3uyzPEJ6tqVo22FBlH7LutZeiDuywTMMT6D1wtYUMCY8990v
 QPMFJpc+YSMCaLZ7oniFLkbqFNiofttUGsn9UIJqdY3WitH6PMtTL8gBRqF3ZaBLur06Nxk8lxjYx
 5QeCtcmtrvDl9hrdijhIi1JP8Z70k6MmNYXe6W9F5lRhhMS11zBBbfwDWU34ZtbrcMK6PRKo0TRch
 uSPouF8CDzvz+Q09EsjcX6oSrl6z20N2MiG4m+EbsV6bYrh/GQpDXrpOF5uOcWoMW2+zH1TjavYAB
 +sucTLFmj1pR2+gDehT1ruzIwJ+bNRVqs6lvbWCMWa1ghl96IgGskb6q3/xnNcP+G0Osnxb0GHToR
 /ckM0GiJiv/vv0w8awFsoyCgycJvDwpV8Jmn23Z0oHlOJLsDFknhJj1sgL+4N4hpg7OzLnqOavMf6
 E7CV9zMnvHIYNXxbA5mk5PH/tevBJd6mCVBRwHKGo=;
Received: from [2a00:23c4:8bb8:f600:73fa:5593:d3ba:8410]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8eqX-0008sS-4j; Wed, 06 Nov 2024 12:09:17 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, huth@tuxfamily.org, berrange@redhat.com,
 qemu-devel@nongnu.org
Date: Wed,  6 Nov 2024 12:09:26 +0000
Message-Id: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:73fa:5593:d3ba:8410
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 0/2] next-kbd: convert to use qemu_input_handler_register()
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

v4:
- Rebase onto master
- Remove extra zero entries from qcode_to_nextkbd_keycode[] array
- Move position of shift key logic as suggested by Daniel
- Add R-B tags from Thomas, Alex and Phil

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

 hw/m68k/next-kbd.c   | 163 ++++++++++++++++++++++++++++---------------
 include/ui/console.h |   2 -
 ui/input-legacy.c    |  37 ----------
 3 files changed, 108 insertions(+), 94 deletions(-)

-- 
2.39.5


