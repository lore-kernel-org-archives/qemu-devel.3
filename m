Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C508DCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB5y-00073H-3v; Sat, 17 Oct 2026 16:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB44-0003iT-V1; Sat, 17 Oct 2026 16:31:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB43-0004WV-Ah; Sat, 17 Oct 2026 16:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268878; bh=Yg1IL7YqpvXC+nby5VBGDMk9CnEPTbbgMQJYXxnF2LU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vrl1ypUi3NDZLOx35wbwQ0duWqalzRmNDJTvOTP/+bevBtzbRAwhacUIgarFQ9Boz
 TpRVHI0onITiTUAlZXHDFjQ7VEbdOOyujTDFcUOSL1yjXbSAUDT1eKrjRKUflDlZOG
 TpIVsyMp3wMwSWKAOLD0hwSbwEayTA2lJCDvC4EWMQAqi2+uoOukRPz9azloDgTAy3
 m63TVl9gFQG0pQcXJttyT2kO+TVX7MksCevze5O2aWpUST/QsQAyrsEc44rKY0Ybi1
 2tzc+w+KyHC8N43F0TH2MxJ8/0yfW6UiFDh5qes+zFd9RsuShQf7zeKc5Cowtv8DzU
 6czDGMdcK45EQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 226C61DE770;
 Sat, 17 Oct 2026 23:27:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 240B9443444;
 Sat, 17 Oct 2026 23:27:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 50/73] tpm_emulator: Reject sending commands smaller
 than the request header
Date: Sat, 17 Oct 2026 23:26:08 +0300
Message-ID: <20261017202638.728621-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: Stefan Berger <stefanb@linux.ibm.com>

Reject any TPM request from being sent to the TPM emulator that is shorter
than the size of the request header.

Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-4-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
(cherry picked from commit 6728170d2d081d8aad46807bc5e64520650f2795)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 95d2de2f48..5581f690e4 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -181,6 +181,11 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
     uint32_t to_read;
     ssize_t ret;
 
+    if (in_len < sizeof(struct tpm_req_hdr)) {
+        error_setg(errp, "tpm-emulator: invalid request size %u", in_len);
+        return -1;
+    }
+
     if (selftest_done) {
         *selftest_done = false;
         is_selftest = tpm_util_is_selftest(in, in_len);
-- 
2.47.3


