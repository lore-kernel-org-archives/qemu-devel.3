Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2970606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ue1c++cS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpDA-00026F-Vr; Fri, 27 Nov 2026 01:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAR-0006NM-LU; Fri, 27 Nov 2026 01:10:43 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAO-0008Ac-Dp; Fri, 27 Nov 2026 01:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=Bfr5OjnXNeT1LcTr9lk1Q22zeNMqxqTLRN5G22bcO50=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ue1c++cSuC9lPRaM7r0ijV+NMYzHAPMijxP3C2XpEnZiellnVqBD/Z8Y+HCusrEc8
 DZ/JWxgfE/0wn8exAD0FlC6rYWj0fmhqbua3UGydvyXxIEYw9zeTz6GHH64gcx7J8n
 9jXFgRWh44fhN5wIUz842Ro5m+qMCrOv9BhWexwBD5cHKjYDab2WT95ioo93PYObak
 FN52/3GGR3E2m4tS9AMbehFOhd6TTjt1bH2clNAYOd45vJ0u6+5cdnCOPM6rwOlm5c
 MKMVqY7QW3tI7VZpZ177+vAkXhHAGceQ3h6RbPHFQ2/AvztUQ1eusqeAFpz3GrIS5W
 MN5C227EO97XA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9B8471EA37F;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 97D8B4699AA;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7DD89CF34C; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 141/152] hw/sd/sdcard: Reject zero block length
 (CMD16)
Date: Fri, 27 Nov 2026 08:54:39 +0300
Message-ID: <20261127055709.39630-78-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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
index dd8e1b46cea..6402355b403 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1974,7 +1974,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCKLEN(SDState *sd, SDRequest req)
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


