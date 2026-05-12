Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195ABCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuhI-0003Fe-6u; Tue, 12 May 2026 17:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuY8-0002I3-OO; Tue, 12 May 2026 17:21:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuXf-0000gj-Fg; Tue, 12 May 2026 17:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619499; bh=fSX8V1GH6cOS7jaYi9WOBY/PGSpp3CPveh4gYDxacBk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KMK/MnkimaHWDFZF1NTs7irLWPxL0s1UH38rCMWuilZWYPixue8sAAATCemo9sDzC
 GR9bdZ9GBOoFZIBkRAylTuL6PdOmataQSQGSaFYoPyQpwmSLiaSKSn9Hyggc7dlM0B
 xifzUuxXiyKpC2GxMMd0ZrZ1U3hetoobu+J0+kkiIVPmWdmbCsPzRHWU8UzIEsTYb0
 3peqUIfDI+pu2uiDAa6rffTHqpTQZCyq7sdKJLo+KoXrrRCtGFjZ+LBa+WRvOt5Vgp
 N1Z2SeXyRAUu+luwljmtLwm0/XrCfog3vkoslt8sMfQBYLb0rr+VHFWO5MwOtSG8d/
 q/76R69ZCy+fw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3E88F1AA3EE;
 Tue, 12 May 2026 23:58:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 474B33ABD46;
 Tue, 12 May 2026 23:58:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 35/58] riscv_htif: reject invalid signature ranges
 (end <= begin)
Date: Tue, 12 May 2026 23:57:56 +0300
Message-ID: <20260512205820.361821-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
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

From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

Prevents huge allocations and crashes caused by malformed HTIF signature
addresses.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3205
Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251209085349.61510-1-munkhuu0825@gmail.com>
[ Squashed with following commit to fix build failures
    hw/char/riscv_htif: Fix format specifier for uint64_t

    Message-ID: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
    Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
]
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 14808578ccbcd17d474c98bb53b60452888f8529)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index e9efab16e9..a53d2ace02 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -171,6 +171,12 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                  * begin/end_signature symbols exist.
                  */
                 if (sig_file && begin_sig_addr && end_sig_addr) {
+                    if (end_sig_addr <= begin_sig_addr) {
+                        error_report("Invalid HTIF signature range:"
+                                     " begin=0x%" PRIx64 " end=0x%" PRIx64,
+                                     begin_sig_addr, end_sig_addr);
+                        return;
+                    }
                     uint64_t sig_len = end_sig_addr - begin_sig_addr;
                     char *sig_data = g_malloc(sig_len);
                     dma_memory_read(&address_space_memory, begin_sig_addr,
-- 
2.47.3


