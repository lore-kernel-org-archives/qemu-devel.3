Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC8AC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn7y-000138-3m; Tue, 16 Jul 2024 14:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn7w-0000wT-Fh
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn7u-0007MC-RW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so1948512f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155333; x=1721760133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ddj9Nfg7HiixSUrxPsTSL9gKvyRW8bVsKrGjjlgbR1M=;
 b=GE0i4UVxHHZ7E6L/7S5Md6ujrPhabsp/Rn76khxF8AqNJtlmMCivK0yUYYsfQxUdV2
 LevtCsAg6LvkEy+pvhfFrVqZyhICZ7O/chbnYFOO4W2MptSdPD105zLZKrUspNZcthMK
 4cgC09AWJeNgshX/DUrPh/5sTAnDUozMD3K/EC7o44C8uvGmg0y7K2g6/arieRJIiiw8
 Ntdmn0eSUXVkLHojMyebTE1USIFkASx6yCll+1F6DGX2WE22tQc/OQxs4hzi8wXWuK0t
 qzvqZxRCVfl/Hxlhk+tR8pcxknlAHHlai0azSCGIohFp2LdEnv+rI3O0woWnCxv1cBDK
 Q+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155333; x=1721760133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ddj9Nfg7HiixSUrxPsTSL9gKvyRW8bVsKrGjjlgbR1M=;
 b=FKX1W5cnM3ylYACJ+WAwvAtimPsyX73NU6SiJw04FukrA5qE5xryRNBX4N/G53FXZo
 WfZpJLkITnBUPZIH/5uzXdLnNBhfVxKtYVGYapwwcXmnIEE0pfD6aFWdqQuTNWBg+fQl
 nmN4ueeDLZduZUR/PdtUXK6ZcgU6zcQ4FasUxoHm1nrT9Lk5rXYPs8JnYdnd0bwknDe5
 ECWYODul4ea32LiPIuzPmvkwBrVws/cxkrY2748PY2uqnkfAAc7dLnippTxM4VCquHjq
 vZXBA96fP3Vz4MYC71FHRqPs8H2AOf53RFsh6GT5+HAgwhqfzqHABm/VHTWoAnEo0pZ0
 Sadw==
X-Gm-Message-State: AOJu0Yw/HLbVm4HrKVrOuGGRdesgxCUyZ9ljtPSwnp28692Dd7Mz0Jue
 DWxXcHPfICLYAVYcNORtMsAD2Aqa54eoGGO438n7r9bPaSBkFHWjaNU1BCfUD5JoRNVVxSX1edA
 1B4F8KQ==
X-Google-Smtp-Source: AGHT+IGz1KNfrHPa57QbcBWMZJ3Fzc/JhsvQq65G2GBnXuPYShI7dwT3epwI9Jhic9CWfBJToXIpTg==
X-Received: by 2002:a5d:4747:0:b0:367:8a3b:2098 with SMTP id
 ffacd0b85a97d-36825f70f1cmr2056230f8f.3.1721155333054; 
 Tue, 16 Jul 2024 11:42:13 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm138512235e9.46.2024.07.16.11.42.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:42:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/11] hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR handler
 (CMD3)
Date: Tue, 16 Jul 2024 20:41:37 +0200
Message-ID: <20240716184144.42463-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716184144.42463-1-philmd@linaro.org>
References: <20240716184144.42463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240712162719.88165-5-philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8a23e9eb23..ab502d19b8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1280,6 +1280,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_identification_state:
+    case sd_standby_state:
+        sd->state = sd_standby_state;
+        sd_set_rca(sd, req.arg >> 16);
+        return sd_r1;
+
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
@@ -2445,6 +2459,7 @@ static const SDProto sd_proto_emmc = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
-- 
2.41.0


