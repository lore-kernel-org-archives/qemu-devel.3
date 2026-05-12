Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CE7CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuT8-0001te-Qr; Tue, 12 May 2026 17:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuSZ-0001Tg-B4; Tue, 12 May 2026 17:16:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuSX-0006Sm-4y; Tue, 12 May 2026 17:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619306; bh=eCM7vXILxrJ1WoMGxOFmd/DjA6B0QwwTpBYgsE7b4/A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TNcWGhLDHr/2Uh4vJzTvN+OXskZerldkVJJWhwmc77y/NQbY4XAsfiq5VUV37usU6
 P4NPH69cYr/QEQgjbf+WfFk/tH2sYPP9DNMisB4cBEIb1Rx7IS1Fcd/HnhxztmxlTR
 4npVCNDUb7ExLTFvR39HkavgoKWOI+WabOjRAB7tE6tZhJ4zLd4LzKiNgypYXxxWA/
 E0GK0I6t2pvx6RM6ao80Ovs0EWOjoef0rZS/5KTcjWNqBf+zPkBeHF1Irt+LVx10+h
 SPBg6x09HmYEZRRomVRgLTlDcX9zeN491Zk5w6a4ABlnP1ZePK6+SviulWUzgS5c0n
 G6+pbDgBvGxgw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 693791AA3A1;
 Tue, 12 May 2026 23:55:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 779493ABD10;
 Tue, 12 May 2026 23:55:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 099/117] linux-user: Add missing CDROM ioctls
Date: Tue, 12 May 2026 23:54:41 +0300
Message-ID: <20260512205503.361097-99-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Add the missing CDROM ioctls and bring them in same order as
documentation.

Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit dcb6e96257eea926aef16854bed0871b0605a8b9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 5b7d00e92f..aa485ee6e5 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -416,19 +416,18 @@
 #endif
 
   IOCTL(CDROMPAUSE, 0, TYPE_NULL)
-  IOCTL(CDROMSTART, 0, TYPE_NULL)
-  IOCTL(CDROMSTOP, 0, TYPE_NULL)
   IOCTL(CDROMRESUME, 0, TYPE_NULL)
-  IOCTL(CDROMEJECT, 0, TYPE_NULL)
-  IOCTL(CDROMEJECT_SW, 0, TYPE_INT)
-  IOCTL(CDROMCLOSETRAY, 0, TYPE_NULL)
-  IOCTL(CDROMRESET, 0, TYPE_NULL)
   IOCTL(CDROMPLAYMSF, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(CDROMPLAYTRKIND, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(CDROMREADTOCHDR, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(CDROMREADTOCENTRY, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(CDROMSTOP, 0, TYPE_NULL)
+  IOCTL(CDROMSTART, 0, TYPE_NULL)
+  IOCTL(CDROMEJECT, 0, TYPE_NULL)
   IOCTL(CDROMVOLCTRL, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(CDROMSUBCHNL, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(CDROMEJECT_SW, IOC_W, TYPE_INT)
+  IOCTL(CDROMRESET, 0, TYPE_NULL)
   /* XXX: incorrect (need specific handling) */
   IOCTL(CDROMREADAUDIO, IOC_W, MK_PTR(MK_STRUCT(STRUCT_cdrom_read_audio)))
   IOCTL(CDROMREADCOOKED, IOC_RW, MK_PTR(TYPE_INT))
@@ -438,16 +437,22 @@
   IOCTL(CDROMREADALL, IOC_RW, MK_PTR(TYPE_INT))
   IOCTL(CDROMMULTISESSION, IOC_RW, MK_PTR(TYPE_INT))
   IOCTL(CDROM_GET_UPC, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(CDROM_LAST_WRITTEN, IOC_R, MK_PTR(TYPE_LONG))
   IOCTL(CDROMVOLREAD, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(CDROMSEEK, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(CDROMPLAYBLK, IOC_W, MK_PTR(TYPE_INT))
-  IOCTL(CDROM_MEDIA_CHANGED, 0, TYPE_NULL)
-  IOCTL(CDROM_SET_OPTIONS, 0, TYPE_INT)
-  IOCTL(CDROM_CLEAR_OPTIONS, 0, TYPE_INT)
-  IOCTL(CDROM_SELECT_SPEED, 0, TYPE_INT)
-  IOCTL(CDROM_SELECT_DISC, 0, TYPE_INT)
-  IOCTL(CDROM_DRIVE_STATUS, 0, TYPE_NULL)
+  IOCTL(CDROMCLOSETRAY, 0, TYPE_NULL)
+  IOCTL(CDROM_SET_OPTIONS, IOC_W, TYPE_INT)
+  IOCTL(CDROM_CLEAR_OPTIONS, IOC_W, TYPE_INT)
+  IOCTL(CDROM_SELECT_SPEED, IOC_W, TYPE_INT)
+  IOCTL(CDROM_SELECT_DISC, IOC_W, TYPE_INT)
+  IOCTL(CDROM_MEDIA_CHANGED, IOC_W, TYPE_INT)
+  IOCTL(CDROM_DRIVE_STATUS, IOC_W, TYPE_INT)
   IOCTL(CDROM_DISC_STATUS, 0, TYPE_NULL)
+  IOCTL(CDROM_CHANGER_NSLOTS, 0, TYPE_NULL)
+  IOCTL(CDROM_LOCKDOOR, IOC_W, TYPE_INT)
+  IOCTL(CDROM_DEBUG, IOC_W, TYPE_INT)
+  IOCTL(CDROM_GET_CAPABILITY, 0, TYPE_NULL)
   IOCTL(CDROMAUDIOBUFSIZ, 0, TYPE_INT)
 
 #if 0
-- 
2.47.3


