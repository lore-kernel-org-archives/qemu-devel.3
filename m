Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD28606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=efh5ML0p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp1G-0002tP-0M; Fri, 27 Nov 2026 01:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0x-0002D5-RX; Fri, 27 Nov 2026 01:00:58 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0u-0005BW-Vr; Fri, 27 Nov 2026 01:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=/vVgEW1wzYzjH15327erUqj3J54NwS1GNfndbgjzEsA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=efh5ML0pvUcfkDLDG5Ejf9F42xRFyWtHGr1fLzthi3q8HEjB1rfNvocrbaPb2zkgA
 b5w0YipTMZ7jg9LNvzEL5ZLMbalP6O9pVJ4O7ltb6WFw6trzHgAe57lCnOeVgrZyLm
 rIrAojT4OAGqcYd90VtBfuXcRjLEhqFjjUUMBDR+k6ObhcA5N0DQIDj2GKLQZSFa7D
 VWk9txcz3fHsMmcriIlhOwvH8o4OwUIWXbJN8uOKSEH16V51ZafUwiq5jONnamDYg6
 ArvkQgUl0BA6uqE9+U0KenCb3wjVtu9cRZ45klcESXJIQ3+2yl+tDTwzwhSl6gx0et
 tFpmZibOqBzZw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B0AEE1EA30A;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE697469944;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 945FDCF294; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 127/140] hw/sd/sdcard: Reject zero block length
 (CMD16)
Date: Fri, 27 Nov 2026 08:53:53 +0300
Message-ID: <20261127055421.39015-68-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

SET_BLOCKLEN (CMD16) accepts a zero block length. A following
READ_SINGLE_BLOCK (CMD17) on a Standard Capacity card then reads 0
bytes from the backing image and enters the sending-data state with
the data size of the previous transfer, so the guest reads back
stale SDState::data[] content, such as the password sent by a
previous LOCK_UNLOCK (CMD42):

  CMD42 (set password "secret-password!")
  CMD16 0
  CMD17 -> data block contains "secret-password!"

The spec only requires BLOCK_LEN_ERROR above 512 bytes, but a zero
length cannot carry any data. Reject a zero block length: set
BLOCK_LEN_ERROR and keep the current block length.

Cc: qemu-stable@nongnu.org
Fixes: a1bb27b1e98a ("SD card emulation (initial implementation)")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261123225349.54981-2-philmd@oss.qualcomm.com>
(cherry picked from commit 3ff2400ba1a9b9ec70a8b965fc42818332cf716b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 700041b5db7..ea5a3c0e018 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1641,7 +1641,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
     if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
-    if (req.arg > (1 << HWBLOCK_SHIFT)) {
+    if (req.arg == 0 || req.arg > (1 << HWBLOCK_SHIFT)) {
         sd->card_status |= BLOCK_LEN_ERROR;
     } else {
         trace_sdcard_set_blocklen(req.arg);
-- 
2.47.3


