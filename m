Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A59D21690
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 12:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0gjE-0005wR-7g; Tue, 15 Oct 2024 08:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1t0gjB-0005vb-Mx; Tue, 15 Oct 2024 08:32:41 -0400
Received: from forward101a.mail.yandex.net ([2a02:6b8:c0e:500:1:45:d181:d101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1t0gj9-0003kw-PH; Tue, 15 Oct 2024 08:32:41 -0400
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2a:1c1:0:640:adc:0])
 by forward101a.mail.yandex.net (Yandex) with ESMTPS id 49D9260B23;
 Tue, 15 Oct 2024 15:32:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id TWKivoTLgqM0-lvptCVPA; 
 Tue, 15 Oct 2024 15:32:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1728995549; bh=Pcu/U9hXaVEo7TpmW3Ouf8WsQ18wNvWQaSn26AsJ8as=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=FhloQWyODQPGm1OCl4Mqo2MHWBruLpYqKcUTZOmEyDVZSIvN4WYf99mJ7ERWXLKYD
 lU69PqepWj6xVrc8nXjXD0FdaZLQP1QGPK/gHn1+ZaznyhaYiupzWZL8Fqc/8WvPNE
 +Jd3zqm9d6dFgSVqt2uQSQwHXY35nxDvNIhFhWig=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: linux@yadro.com, Nikita Shubin <n.shubin@yadro.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/block: m25p80: support RDID_90 for Winbond
Date: Tue, 15 Oct 2024 15:32:28 +0300
Message-ID: <20241015123228.18692-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:d101;
 envelope-from=nikita.shubin@maquefel.me; helo=forward101a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Nikita Shubin <n.shubin@yadro.com>

Make Winbond support RDID_90 as all winbond SPI NOR Flashes
support Read Manufacturer/Device ID (90h) command.

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 hw/block/m25p80.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index f7123f9e68..27f0cd0487 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -829,6 +829,16 @@ static void complete_collecting_data(Flash *s)
         s->enh_volatile_cfg = s->data[0];
         break;
     case RDID_90:
+        if (get_man(s) == MAN_WINBOND) {
+            s->data[0] = s->pi->id[0];
+            s->data[1] = s->pi->id[2];
+            s->pos = 0;
+            s->len = 2;
+            s->data_read_loop = true;
+            s->state = STATE_READING_DATA;
+            break;
+        }
+        /* fallthrough */
     case RDID_AB:
         if (get_man(s) == MAN_SST) {
             if (s->cur_addr <= 1) {
-- 
2.43.2


