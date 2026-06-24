Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45FBCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFpZ-0002DX-M7; Wed, 24 Jun 2026 01:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFpP-0001ks-Ii; Wed, 24 Jun 2026 01:07:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFpN-0005jO-VC; Wed, 24 Jun 2026 01:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277622; bh=vAyKN8+M9jEln4kJ8vKcewQrLe0bjr8DlYPubHyvRMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qJ6DFJMmuqU6tC+wAFZu/AVwzhTivcKdZbmUXRWAL3PC3nvbsWMX8Yp5tXDvDTTRX
 JicHW5u8cwpVgsX7CEhga1IuyGxEoCoWLTiUKg3OB7eJuLfvJHIMuOBL+y6WmSwP/C
 8sn6GuRpPtpB95gvOpP2JhIcsR/LROz3n91dOXwohyhVLhATWuyOszbBCkTZbtUZs/
 tr4htaRq+NO6LQwZW74xmR5eGHdmkeNAWS+11uZ+GwZa9i4tfdDg7JZixDODKrm+fD
 nrztVdCGue7BD5qkDsCU7OGMU2c9bpbA0atRLaUblMA2XQ0BuTagFj9R3hm3w0gRYh
 2PIPm1BCtdpOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0B12F1BA65C;
 Wed, 24 Jun 2026 08:07:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E58743DDAF9;
 Wed, 24 Jun 2026 08:07:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 62/95] system/rtc: Fix a possible year-2038 integer
 overflow problem
Date: Wed, 24 Jun 2026 08:04:57 +0300
Message-ID: <20260624050541.395079-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

rtc_realtime_clock_offset is initialized with:

  rtc_realtime_clock_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;

And QEMU_CLOCK_REALTIME might be based on gettimeofday() in certain
cases (see get_clock_realtime() in include/qemu/timer.h). So this
counter will exceed 32 bits in the year 2038, thus we should not
store this value in a normal integer variable. Change it to a time_t
to fix the problem.
And while we're at it, also adjust the nearby rtc_host_datetime_offset
variable to be on the safe side in the related code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit ae84c738e40339cc0f22773dd4692de529d88739)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/rtc.c b/system/rtc.c
index 56951288c4..f7eca982b0 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -40,8 +40,8 @@ static enum {
     RTC_BASE_DATETIME,
 } rtc_base_type = RTC_BASE_UTC;
 static time_t rtc_ref_start_datetime;
-static int rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REALTIME */
-static int rtc_host_datetime_offset = -1; /* valid & used only with
+static time_t rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REALTIME */
+static time_t rtc_host_datetime_offset = -1; /* valid & used only with
                                              RTC_BASE_DATETIME */
 QEMUClockType rtc_clock;
 /***********************************************************/
-- 
2.47.3


