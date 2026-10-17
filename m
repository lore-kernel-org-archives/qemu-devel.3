Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA87CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB5i-0006Qd-30; Sat, 17 Oct 2026 16:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB49-0003oQ-7u; Sat, 17 Oct 2026 16:31:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB46-0004Ww-Ew; Sat, 17 Oct 2026 16:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268879; bh=7AfG7+RNL0V6vOz1vQPPug5lsrdDIr+Zd/HFDbU6mRI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xqBfo6WK9Ng5h24mKHZ92KwHCH0u6UWcDI4sudVEd8YM10l0M02EP/FQusmHwvMHk
 xgyW120MwNDjWs7ufkc00dpYzZ2SC/vzKQvMGMd3RAPeBIPMaMrnUAzxd6SDxTHErm
 LeToH7rfJhlNH9djE3PvqJNO15GpSZwVVLank36ruD5yDU187liYTllrYnjvLhguOA
 5kv3BppCYEfQnOltgwU4xBn1d+UkjiUPo35bSwLZF7k4+p7YSSMRbG0GeTufbXNiks
 niPYXgQfcNhHjvKkCOgKBLDLfOjcEgi2p/VLEkLZw+thidprQ5wW9neJZ4cko5H3NY
 /W5DmNTkIKdgg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6413D1DE771;
 Sat, 17 Oct 2026 23:27:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 61DF9443445;
 Sat, 17 Oct 2026 23:27:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 51/73] hw/tpm: crb: Do not clear internal buffers when
 backend is busy
Date: Sat, 17 Oct 2026 23:26:09 +0300
Message-ID: <20261017202638.728621-51-mjt@tls.msk.ru>
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

While the backend (thread) is accessing the request and response buffers,
do not clear those buffers upon a command cancellation. Also, per CRB spec
the TPM is expected to either return a normal command response (command
could not be cancelled) or an error response indicating TPM_RC_CANCELED.
So the response buffer must be able to receive a response as normal.

Fixes: 29315d22b259 ("hw/tpm: Add internal buffer state for chunking")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Arun Menon <armenon@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-7-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
(cherry picked from commit 9b206e52655044da7f639c193a6ff3cec21baa02)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 54fa2042b5..daf451aa56 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -219,7 +219,6 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
                 tpm_backend_cancel_cmd(s->tpmbe);
             }
-            tpm_crb_clear_internal_buffers(s);
         }
         break;
     case A_CRB_CTRL_START:
-- 
2.47.3


