Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA0DC5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 00:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyIds-0007xN-QW; Sun, 23 Aug 2026 20:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdo-0007wj-KE
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 20:34:20 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdn-0007iE-0b
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 20:34:20 -0400
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdh-000MWV-38 for qemu-devel@nongnu.org;
 Mon, 24 Aug 2026 02:34:13 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wyIdh-0004I3-0S for qemu-devel@nongnu.org;
 Mon, 24 Aug 2026 02:34:13 +0200
Received: from localhost (localhost.eb.localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id BE12C48015A
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:12 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id AbNiCe8gLtao for <qemu-devel@nongnu.org>;
 Mon, 24 Aug 2026 02:34:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 574E2480153
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.embedded-brains.de 574E2480153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embedded-brains.de;
 s=34EE5404-8E36-11F0-B577-2ECCAB4968F5; t=1787531652;
 bh=3NmoQHE5UxLIEdquTHSgEAvi1QEWK+HXLVGgAxbTDdE=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=sua6p2TNtSWHZeZEJCnBcT7Y7CF77Njs37Sh+SWNy67jd7NruslKWNbp2o98KNSJS
 WRaxPsGLm+nrHSHsb9k2fXC3WMeum6LbAt5/l2ddaeJxOIPn8yRHUqW5rLlEvcdVXU
 ti75XiZptaoVefDwZzQ/OWoyNX5jvi1S9uayMiWtQ2LWS6Tm5XeOgxr/BLa8fN2+Ho
 KHfM7Ai/7Z+t9EqcccIamERTFx53X2KcBqS0ismvyKut+2UXwk/BHrCSvDGmtSt8oR
 FO1f1fS0lqdC+LiTEiyNeQoxpyqMeAseOoZNq2YNZ0/yANsI+1hCyuEX69jcdXg+6s
 gRN0HBsPyCcwg==
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id VzxTi-OV8-l1 for <qemu-devel@nongnu.org>;
 Mon, 24 Aug 2026 02:34:12 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id A9B1B48006F
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:34:11 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix two Xilinx Timer issues
Date: Mon, 24 Aug 2026 02:34:03 +0200
Message-ID: <20260824003405.616297-1-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-DKIM-Status: pass [(embedded-brains.de) - 78.47.166.52]
X-Virus-Scanned: Clear (ClamAV 1.4.3/28101/Sun Aug 23 08:26:53 2026)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
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

Sebastian Huber (2):
  hw/timer/xilinx_timer: Start on the enable edge
  hw/timer/xilinx_timer: Reload at the expiry

 hw/timer/xilinx_timer.c | 48 ++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

--=20
2.51.0


