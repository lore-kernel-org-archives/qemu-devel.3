Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EE606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m1NrmLs1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6By-0001Bx-DE; Wed, 28 Oct 2026 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xM6Bp-00017Q-TT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:07:50 -0400
Received: from out-185.mta1.migadu.com ([95.215.58.185] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xM6Bl-00059V-DB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:07:48 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=CC+n9M+e/BqssdwLRIy9oa/TvpyF3v8MjmdKwGPjIAA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793203661; v=1; x=1793808461;
 b=m1NrmLs15iMTkYaqr/Vw+QYHnL1TDN60XK6ijlh3V2/fzipbzDGwqffzhl6fmE/HDJTBZZyg
 bsOorfInTJ+sLzKEYCd6GWyn5aVfpSrzSaGtN7RTGvW7w3Abl6A2CYVMdlYfSp4gy4zRmz+Xha8
 RZFZsdjQRF8qqtEcxH9GxT+A=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id b1889528c61227af;
 Wed, 28 Oct 2026 16:07:41 +0000
X-Mizu-Trace-ID: b1889528c61227af
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, marcandre.lureau@redhat.com, sundayjiang@tencent.com,
 kraxel@redhat.com, fa1rid@live.com, qemu-stable@nongnu.org,
 junjie.cao@linux.dev
Subject: [PATCH] usb-host: reset the open retry count after a successful open
Date: Wed, 28 Oct 2026 11:07:27 -0500
Message-ID: <20261028160727.780978-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.185; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
The source-level fixture attached to #4673: 15 tests, 7 failures on
master d29412cca5, 5 with this change. The two reconnect scenarios pass
(repeated-reconnects, success-resets-own-budget). Of the other five,
four expect a failure budget per enumerated device and one expects a
libusb_get_device_list() error not to reset the count; both are outside
this change.

Farid's attached patch resets the count inside usb_host_open(); this one
keeps it next to the failure count in usb_host_auto_check().

 hw/usb/host-libusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 8f7ced95cf..5a369e2ebf 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1924,6 +1924,7 @@ static void usb_host_auto_check(void *unused)
                     s->errcount++;
                     continue;
                 }
+                s->errcount = 0;
                 break;
             }
         }
-- 
2.43.0


