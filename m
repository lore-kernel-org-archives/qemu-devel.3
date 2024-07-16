Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82548C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn7o-0000JZ-HS; Tue, 16 Jul 2024 14:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn7k-0008UX-9Y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn7i-0007L8-PO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266fd39527so43704785e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155320; x=1721760120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25d8r/+FljDN61432gFDtIj9k/AKYUKw9R2OfNlM2/Y=;
 b=lkUt3VNWtIVDPyy9lW8YeeFGFswrLc66ezotrtvNxvJsqbxjsd9jcW87Vg5ThyKbz9
 ft+2usm6W5aBbXjTTZD9iTZ89DqZln1X8Deo3CSecnE42iPk/iX/2cwka0BATfbGs9fq
 S+7sa8i8C0ztiXwkebq4Yv6zwt8JoQLiZ/PvOSKptKNzzXqWu1srYkNe86t8ruPLY/94
 lTXOQj+xCoaG2QJD13VAHt9WjBvgJjuv2fFNLRKlNJeXEygWAxvMG2odxAg0Txs78RX/
 bwA5KuEwPMDzpx/6DEroPxt7UqCNkqDm5/KvnqXG4OoBvBhUSk0b8NHNSk8qps9g7rqz
 dJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155320; x=1721760120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25d8r/+FljDN61432gFDtIj9k/AKYUKw9R2OfNlM2/Y=;
 b=Bu6I+e/7U8oB8mFFMjsMKBq6OnaQga9ojwW5M+FuFTECyayOItVqYxF7uCtPXtZYdA
 i3bTR6VSyV2EH5q8ybXD2NP5Z4evDF3MqUw0EMrQ2K9XT2LuiAKU3+lGWXVPGPX2EwkV
 prbgylDkjEZOI69FhelFDqTFLs6JRiwfAkjCyl+g+eZxhlfs5BJK3mVpxsWsYd0K1OR4
 RKgUFYOrFsEteIiNe0ONkxkBSRD8YvhGC11+0advCq/DKDERxGFibaozg71Fh6DmCpTJ
 8Gh+hEtRo4PypQfYHm4n34ZofcTGbQrI02CgBdlEKzWXbQoG78gbvmAhuGlMUkhrBKKg
 IEHw==
X-Gm-Message-State: AOJu0YxAtz78Fvw7ry7f3BuSXTerk4KJW/Y5xlMUc4wysxSBNWnz9PRf
 4++dSj8+U4yv3N+4LplWljty3BASJUWoW1Zjp+SJMxDeg+qn3Cd23CT49TRCgacT5s5nsP8xQXd
 AN67kLw==
X-Google-Smtp-Source: AGHT+IEEoaRLnDm6/kaRws9zdI+TKhU18bBeBSd+bS1rifA2wHqwT/JUwywb+4Rjx4DwOm0yTYaNTA==
X-Received: by 2002:a05:600c:4fd5:b0:426:5546:71a with SMTP id
 5b1f17b1804b1-427ba656518mr19501355e9.2.1721155319826; 
 Tue, 16 Jul 2024 11:41:59 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a14d32e8sm165818145e9.17.2024.07.16.11.41.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:41:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 02/11] hw/sd/sdcard: Register generic command handlers
Date: Tue, 16 Jul 2024 20:41:35 +0200
Message-ID: <20240716184144.42463-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716184144.42463-1-philmd@linaro.org>
References: <20240716184144.42463-1-philmd@linaro.org>
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240712162719.88165-3-philmd@linaro.org>
---
 hw/sd/sd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ea01bf6e28..0093bbab3e 100644
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


