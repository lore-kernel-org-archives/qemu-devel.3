Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20213C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsfT-0007qe-9V; Thu, 27 Jun 2024 13:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsf8-0007YM-Gf
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:12:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsf6-0002DM-Km
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:11:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4256aee6d4fso204585e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508314; x=1720113114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0++Ogxou44hWy9HUie+kN/Bmub/+XHfRbLoibWWU/Qg=;
 b=IdOqfydyCFesLcZeKuLplamobxVDKpxSLyWjQTxRv6HTc+XK4TrvfeBPNx9OMZDnUY
 Vnjsin00hJya379PnnrxshpTbtDvYrvwLyUZqr0UxuLU7H5XeeY7HoLZ4iG4y7PiRdZG
 OUKarL3Ki6wD2p9sVC3lMQ7tJmP1diga24oJ+S9wynCYtqA98qjJxa2ZTM6R70l33h2b
 IsVpkmfwK3OGIsfxRxb/g3fb+5n3xXKRRN115gYnSZl0OCfecEtsqy1aykaYjy6FcfZh
 CsX5Bxp0C0u/Hai1z9mhHsJXRfnG14OzNECcpZjui5QCf43r8A6N8aQQdaJAnXbMqDou
 UqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508314; x=1720113114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0++Ogxou44hWy9HUie+kN/Bmub/+XHfRbLoibWWU/Qg=;
 b=PnUephiZ2YL2EgUFrL/mPgOkVlydmrHtK6hqpdv9twNanJgMAYECe5cnoQivVucDaj
 G/V88JUnWN60BDs4piaquXr2E8QHopPY/2eyCh15nX3XJyMWpcn7YZcR8xfZ2L59Y222
 yavVAN88+eqdjeay2GycJ93gcQUCGbBAZK/hY1pFXWGBScsZdm5B6hSw0P/nYxs3oZbk
 RE3r5k2pYK3AW4j11qT0RkW1YlLWddtpGCkXV9XfCNwhfyso7gpiMcMGVbm9hZuK+rcA
 FLP+BDwHCuvtc+OfhiJUl32YO6t/jWfZJWPGzVY9jiMnMMv93kbY6IumSdiYKDkczdFs
 UWsA==
X-Gm-Message-State: AOJu0YyY4JyBqO/S7NTrRCu6DJ+eT3FzhHssHjtPOxhuGmNNTvl5I9rc
 i320ayKgVPCG71Cvbu+QkjTUSrf5ZudaUWvgDFywAwp4R3+xKgfH6W16wArmJ9Gd82tmfasZn4R
 wDxE=
X-Google-Smtp-Source: AGHT+IGY+k9n3kTugxO+U2sqWiH7I/kN46agg24tch5AvgN/I63LV8z/sZmnR5dkRrjwkZQj2TAQEA==
X-Received: by 2002:a05:600c:5715:b0:421:5609:115d with SMTP id
 5b1f17b1804b1-4248cc78a09mr88582175e9.41.1719508313949; 
 Thu, 27 Jun 2024 10:11:53 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55e61sm893975e9.20.2024.06.27.10.11.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:11:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 04/19] hw/sd/sdcard: Register generic command handlers
Date: Thu, 27 Jun 2024 19:10:44 +0200
Message-ID: <20240627171059.84349-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
---
 hw/sd/sd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 249fad0468..ebcd8c1e43 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2383,6 +2383,28 @@ static const SDProto sd_proto_emmc = {
     /* Only v4.5 is supported */
     .name = "eMMC",
     .cmd = {
+        [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
+        [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
+        [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
+        [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
+        [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
+        [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
+        [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
+        [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [35] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
+        [36] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
+        [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
+        [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
+        [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
     },
 };
 
-- 
2.41.0


