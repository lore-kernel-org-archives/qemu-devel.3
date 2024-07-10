Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BE1C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY6r-0002PV-KV; Wed, 10 Jul 2024 10:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5v-0007qj-Rb
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:15:01 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5s-0003yN-2k
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:55 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ec61eeed8eso76269661fa.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720620890; x=1721225690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jntY4rbxkV0U31BLAJxtgRo8uMbZXfthoHz8ocRbQY=;
 b=rlWJczvMR9GC/fTqiQ+YzhLt9cpc4IelvTWnhR7MLdKfPofmg69Go6CEk1F1tPlaCZ
 +iMOXrYXb2DFVqtyQN8c8t1BNDzpaIofLEtNoPBsO6aeg0kx9wEQ9chD1DiOPUOlBL1Q
 5x2eHk7LfWyUy1bNTfWBA1jXoUTgzASeKPqZzbLGprliZcjzodMMou6iev1nzamm7CgZ
 Ao5UZozjyJ5kLBfbThuHXrMGburue0QWlOV7pRYLM4UWBwlAp2wR3kAMK0OZRfOfFwv9
 wBSQ5hpqkd22S8kmiL4t5eNqEfRfqJT1a+sys3HrvO6tgD13z/8a2RX21p0drolVjJA0
 /wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620890; x=1721225690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jntY4rbxkV0U31BLAJxtgRo8uMbZXfthoHz8ocRbQY=;
 b=izfsqSvmvjc8l4VofBeOBARsnsmWf+XQP1BUHUyemmwR6NOB5m2RkXOcGst53Oip0j
 oS8JpSdS1caDKEulqyOPbOWXK1gjR2B5bzMTWVQOttZU7P85C+osHpMmdRTnVfrKj53V
 pjqb2fXr0ypUPM3uGrc2/GVojix9sZ6iwgiQ2Z0EwNhp7cuLhKAElwk2RSPYc6E6o+2t
 2PXx8Vm1LvmJfH86kjAvsFczsTw1Gu944zn7fmiYcc07AnS3P1Mwbitcf7B2GsESQP2B
 hmhILA5hovUE0azJggaBofE8zSCdWZ0g0HaZPJDtuICswwjdLFDyAwoFtrrXJkChtoG3
 CR4w==
X-Gm-Message-State: AOJu0YyPspGcYUR2Zw8X60O66cp63Z5qUcz2sJcuojsGoBt9E9HQwJt4
 WG+nUURkkNRcOFwIIfUSftY4br/VLIT7huLM42BoJOy9ZQ8plhQcMsBy3KHqkDAEIhdrpBOxGpS
 n
X-Google-Smtp-Source: AGHT+IEeo8IzPPhd9ZX/skDWQnPjvz44PmtNZSuFjkEdruohVeAi7cjGlcWI3h1SgWquMUkLtucGsA==
X-Received: by 2002:a2e:9c8f:0:b0:2ee:bd1b:84c with SMTP id
 38308e7fff4ca-2eebd1b173cmr20288141fa.0.1720620890154; 
 Wed, 10 Jul 2024 07:14:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427165c69f0sm60227135e9.30.2024.07.10.07.14.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 07:14:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v48 06/12] hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler
 (CMD26)
Date: Wed, 10 Jul 2024 16:14:02 +0200
Message-ID: <20240710141408.69275-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710141408.69275-1-philmd@linaro.org>
References: <20240710141408.69275-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 550f63418e..3628686832 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1568,6 +1568,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 }
 
+/* CMD26 */
+static sd_rsp_type_t mmc_cmd_PROGRAM_CID(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
+}
+
 /* CMD27 */
 static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
 {
@@ -1917,9 +1923,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 26:  /* CMD26:  PROGRAM_CID */
-        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
@@ -2478,6 +2481,7 @@ static const SDProto sd_proto_emmc = {
         [20] = {3,  sd_adtc, "WRITE_DAT_UNTIL_STOP", sd_cmd_unimplemented},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [26] = {4,  sd_adtc, "PROGRAM_CID", mmc_cmd_PROGRAM_CID},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
-- 
2.41.0


