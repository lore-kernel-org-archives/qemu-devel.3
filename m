Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDDC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY5X-0005ux-Tz; Wed, 10 Jul 2024 10:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5W-0005im-0n
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:30 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5T-0003pV-Ne
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:29 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so85008341fa.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720620865; x=1721225665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5A72BhSEgW2r7oVyXyiETrkNoXhVnGhowikXNWfzjCw=;
 b=sZPa7TqLzfYK8tHyPob2zJulumiKbUdkhSpFSYu072oVeQCRab3MLQtu84IQGPnHto
 UQzUms4VXAS4TrUbp0/j0phyRS5zulOAhQ/Mtu07t7Ot16Ap9UkM6Mqwt+rm+23X530V
 AOZ/ebzw0OZBNkSpR1LGIwECksqazE0YcWz8I7Y2tpr2ni2T2JjfTUAbpOGbebh92XTZ
 tKJwolzLl7XXAdpub0/r54OZQ24OaWtYQKr0Qq/NPl5GVC76fGaOF6bnjokKl8/WMudM
 fz8roZRIVVPc8KBUMT4IglfcCBeTaxvrZ4VdJooZU1s4GQi/TyCCflfySNZffX4Hz9GP
 TDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620865; x=1721225665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5A72BhSEgW2r7oVyXyiETrkNoXhVnGhowikXNWfzjCw=;
 b=grgqSDjGtABRoZBE6GAwCPVMOxZyowvBan2Eo4DGDhXhIV4CRQl6a3gUNinL6W3OWV
 ouHJglBLHrgGNOERMkeJDhNDce2tkCFqCQwR5F0wy4w3GQEjqOxrhY/HGLzWNYwlyrj3
 XrohoY0X/gNYCnuSVpoC9Me5rOVgodcY37yKXM/0heIWcdpfcvwUkK5Y04O8mn9nac+e
 yVqsZmtVYdHaQUgCwJjxDkq327ik5v9w15M9hB7hNo+lTq24YbCcLu7anvw1uhqAcgxr
 iN1bg0Pd9/vXKOdgCehZZuo8z/UrLZE+84lyHeqdLeSOq2P3wp1o8Up0uFQfEjfoR4/+
 +AoQ==
X-Gm-Message-State: AOJu0YxtVrD4X1HgogCKjn5BtIYnCVWKvXvNTDfGPbmYjmK2whydv+vZ
 DDhWlEdReInShQf2uvOgKAJYZ0p2deUJxAmnJuQNwXrUcT3H8QdbaYsLUrGzAbK2TIycN5Useal
 I
X-Google-Smtp-Source: AGHT+IFSJ7le+J66OuctsqK0pvTRJajKeWsYal7fWEjH7wvZPN+i9HtR1CWv/17W5OyLQxz62gWppw==
X-Received: by 2002:a2e:8297:0:b0:2ec:6639:120a with SMTP id
 38308e7fff4ca-2eeb30bbb0fmr39555241fa.10.1720620865522; 
 Wed, 10 Jul 2024 07:14:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde84707sm5367623f8f.35.2024.07.10.07.14.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 07:14:25 -0700 (PDT)
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
Subject: [PATCH v48 02/12] hw/sd/sdcard: Register generic command handlers
Date: Wed, 10 Jul 2024 16:13:58 +0200
Message-ID: <20240710141408.69275-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710141408.69275-1-philmd@linaro.org>
References: <20240710141408.69275-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a4b6c7baba..fc78d4e561 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2442,6 +2442,29 @@ static const SDProto sd_proto_emmc = {
     /* Only v4.3 is supported */
     .name = "eMMC",
     .cmd = {
+        [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [1]  = {0,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
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


