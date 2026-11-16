Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67977606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=W6LRECul
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3D4-0001Ry-Vh; Mon, 16 Nov 2026 15:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ce-00006L-IZ; Mon, 16 Nov 2026 15:21:25 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Cc-0003KQ-4r; Mon, 16 Nov 2026 15:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860372; bh=qJnUEMFFTXlWFc+lOiKw2kJANgq0fKg3Dfjmuag2FT4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W6LRECulnw1yZQJCP7DL6fgVglxvDSvjw90V0vCJBPz6b7f5kHJ8jU0KyATa/BCfR
 D9I5ca2/3YXw5MwpLTOTWoh+wHTvRd8FbwFgnM1KtSgZaYE1nZpSPZ6R09dWbqxNrY
 Gw59Ek0GXQUlKaLySlySwCYRu8fffHoHbKSr6DKE0ls+izVYZSh6xzmE4upRgLH/s8
 zHVHxdzwEDPlfDEWwQozuRypjVjI5/1XRw1mv4JSiA3gwt22yskj+3wRH57AVfy9jM
 yQt/Cf6vIZ5POCUSmvoD1tZze1EGsq46qoR4r5XVqHRwaqt3gUMtn+s5LZJXE7k2FW
 tDv+pTw14YLoA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45DF91E714D;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 435E745FB83;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3CE1EB8DFC; Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@linux.dev>,
 Farid <fa1rid@live.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 23/59] usb-host: reset the open retry count after a
 successful open
Date: Mon, 16 Nov 2026 23:18:27 +0300
Message-ID: <20261116201922.534306-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

From: Junjie Cao <junjie.cao@linux.dev>

usb_host_auto_check() gives up on a matching device once three opens
have failed, and clears the failure count only when a scan finds no
matching device at all. A device that re-enumerates, e.g. after a
firmware reboot, is closed on NO_DEVICE and usb_host_close() rescans at
once, while libusb still lists the old address: that open fails and
counts, the next 2 s scan opens the new address, and nothing clears the
count. After the third such cycle the device is skipped until a scan
finds it absent or the usb-host device is re-added.

Clear the count once an open succeeds. A device that cannot be opened at
all still stops after three attempts.

The source-level fixture attached to #4673 reproduces the same sequence;
its remaining cases expect a failure budget per enumerated device, which
this change does not add.

Fixes: 3ee886c5ba77 ("usb-host: limit open retries")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4631
Buglink: https://gitlab.com/qemu-project/qemu/-/issues/4673
Cc: qemu-stable@nongnu.org
Reported-by: Farid <fa1rid@live.com>
Reported-by: Prateek Rungta <https://gitlab.com/prateek2>
Suggested-by: Farid <fa1rid@live.com>
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261028160727.780978-1-junjie.cao@linux.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit ab46596975c554d7c29cc04efba79f07932c5591)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 410b5e3402a..ce52f0c0c20 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1925,6 +1925,7 @@ static void usb_host_auto_check(void *unused)
                     s->errcount++;
                     continue;
                 }
+                s->errcount = 0;
                 break;
             }
         }
-- 
2.47.3


