Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FF6C3DA47
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY5c-0006G1-GU; Wed, 10 Jul 2024 10:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5b-0006D8-Pq
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5Z-0003tD-Fr
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so19081485e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720620872; x=1721225672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3I/yTIseLTK5bt0dkyKiRUKUXbkR7H64cwH+I5yJrCY=;
 b=ZY7dKOF6Hk6YQfYEtJPlbBYCd9BJ2vtPUydxRrm7MGC0JuXjp4OodqjCV0Tnp7oL0m
 RwakwA1GHTeCL2bZ7qUnnRwuy7JNRLOjH/Koc3slugICYN8kXDwqgBtUE71P02ACNWao
 OsmxAPo9XfEqliXMR42rcfDyolXKQmAgNe+qRYUstU5Nu5OsT1wR5w8GyK+eE5f4XTNz
 HJCs6a8jcf3jA/pNBPASmEMpzn8M54QtApps9eI19xMcCbMc7hrY4G3UpXftz039YZk7
 /z/vS1A3l+ClACrsKGMRpEX7VNVA2kq5SEWl+ySDTocBdMpkqgY+VRE1mQm2mvRLS0Fm
 ZkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620872; x=1721225672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3I/yTIseLTK5bt0dkyKiRUKUXbkR7H64cwH+I5yJrCY=;
 b=eopX7UuQSfEGzxV325IUYiaMLcjMPUJ3NpeTjqPpuPfJImBMlS9OSW99eB2AaYNoUe
 Je/eN8PBvXBgQAT17Hr+9kXWslEO9XhxDKmapz0CLf9Zsa/02lo1E6VoV6JBVMuYX10m
 txJ381NOKOLXSSIIzji0qimjDvy0O3DjQhPrg8V89yS9wYluvyuh2JZdy+aRpuoSleZq
 FzighraqzGgzqdJws/5akpyaTv65aYh5iI02uiIZXAJAJkDfQ/ASidR0Hmmdee3hJpe8
 FxshGivfEcn3UVw72lcu2CHqRMp/y+9fVEwgh0VnXidr9pDnUtBJiNeQUFIMR8vZLR/V
 chaA==
X-Gm-Message-State: AOJu0Yxnt2gja5vBTB2l8J7/zl1eQ3wCbgpiSy6wbaTu1P1IhwEEJ9le
 D6T1T5B1iZtgURU6cQGypP+b6f9jOC9coEVTazshYMMRXmQ2l6K/DiVpnFMBN6kl0uL5XT6L6iW
 9
X-Google-Smtp-Source: AGHT+IG+lUZBbSVHdGO0jy1gox7O6Be1AM76DGFVl4UVCceHiNcLV3OGqPdJ1m83AXvoMKvjkYfJAw==
X-Received: by 2002:a05:600c:17d5:b0:426:5fbc:f319 with SMTP id
 5b1f17b1804b1-426708f04b8mr36225415e9.33.1720620871819; 
 Wed, 10 Jul 2024 07:14:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f5a32sm83616825e9.24.2024.07.10.07.14.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 07:14:31 -0700 (PDT)
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
Subject: [PATCH v48 03/12] hw/sd/sdcard: Register unimplemented command
 handlers
Date: Wed, 10 Jul 2024 16:13:59 +0200
Message-ID: <20240710141408.69275-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710141408.69275-1-philmd@linaro.org>
References: <20240710141408.69275-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Per the spec v4.3 these commands are mandatory,
but we don't implement them.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fc78d4e561..0e36b0cc2e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2445,24 +2445,33 @@ static const SDProto sd_proto_emmc = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
+        [11] = {1,  sd_adtc, "READ_DAT_UNTIL_STOP", sd_cmd_unimplemented},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [14] = {0,  sd_adtc, "BUSTEST_R", sd_cmd_unimplemented},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [19] = {0,  sd_adtc, "BUSTEST_W", sd_cmd_unimplemented},
+        [20] = {3,  sd_adtc, "WRITE_DAT_UNTIL_STOP", sd_cmd_unimplemented},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [31] = {6,  sd_adtc, "SEND_WRITE_PROT_TYPE", sd_cmd_unimplemented},
         [35] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
         [36] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
         [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [39] = {9,  sd_ac,   "FAST_IO", sd_cmd_unimplemented},
+        [40] = {9,  sd_bcr,  "GO_IRQ_STATE", sd_cmd_unimplemented},
         [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
+        [49] = {0,  sd_adtc, "SET_TIME", sd_cmd_unimplemented},
         [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
         [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
     },
-- 
2.41.0


