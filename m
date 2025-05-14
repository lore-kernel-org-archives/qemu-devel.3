Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84948C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBk3-0007qt-Ez; Wed, 14 May 2025 09:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBi2-0004qH-0s; Wed, 14 May 2025 08:59:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhz-0007wk-Sk; Wed, 14 May 2025 08:59:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB1FA121AED;
 Wed, 14 May 2025 15:57:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5A99F20B85B;
 Wed, 14 May 2025 15:57:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daan De Meyer <daan.j.demeyer@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Valentin David <valentin.david@canonical.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 15/34] smbios: Fix buffer overrun when using path=
 option
Date: Wed, 14 May 2025 15:57:37 +0300
Message-Id: <20250514125758.92030-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daan De Meyer <daan.j.demeyer@gmail.com>

We have to make sure the array of bytes read from the path= file
is null-terminated, otherwise we run into a buffer overrun later on.

Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Valentin David <valentin.david@canonical.com>
Message-ID: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit a7a05f5f6a4085afbede315e749b1c67e78c966b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a394514264..8feb54f229 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
             g_byte_array_append(data, (guint8 *)buf, ret);
         }
 
+        buf[0] = '\0';
+        g_byte_array_append(data, (guint8 *)buf, 1);
+
         qemu_close(fd);
 
         *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
-- 
2.39.5


