Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1B1C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn8C-00026a-Ll; Tue, 16 Jul 2024 14:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8A-0001v2-6V
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn88-0007Nq-LJ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so40569005e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155346; x=1721760146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zk51wjPZgnSFKW58/RILvklpvjjZlGceP8tUcpMZ6ZY=;
 b=zfRbWnCDsyFJ1s/hcyaNxk22hFx8jjFzYFVrN50oqVVSU9EdR1yKgKaYFmRtR9AiMQ
 3VrhVF6MLCJpbSKJLDxcFCzkXC+J0/ZnWzpmx/aCEc/4oUSOdzr3VrRU5/cOVlqqyqul
 s4YpU/20dtpTfQomJL1OOMBt+U1H3svy99filwqjKE4PUWLeZmUUEj8wErUvLdoBBNdZ
 uYOVJcbbH98BbJ47ExH/AgZ2XAS3T0Mf9XT8WgtgJZiAZM8JrlbWO8J/WMM1wTEP6GwU
 5IjQmgfdbwaDtYhsiw204+57tQmJW3V71ujWRGGx4NZNQdq/9wTYI6cNGihj2tcuV8DR
 mhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155346; x=1721760146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zk51wjPZgnSFKW58/RILvklpvjjZlGceP8tUcpMZ6ZY=;
 b=NSRpjWMa2IGsRxUUpA4Uvq+Wd+a1zB7RYaPNH5CWJIXeOx31nvqUPE+799g06erUg9
 XsUQhPyXn6SwpaCluB+Ywuu777MX15pvt99YPOs3rVQHnUSj+jJbvrGnkOA0/LKVwNGf
 6wKHfDQgrVYvkxe5plrFGfDDNKXuu/aaLRT+r/nl0UXKpuk4kIVgqSeHwkqsBLN5mB5T
 JayVYTyUoexlG4Yuh26UO06TGNVk4JzdE21pNHBNEQBrO1OE4zAAy7nR8usWpqzBFBld
 2t7uWXoqwFJlRD44KTz+QoZzQFqh47vTc+rahAQc4acNhrhP2MjVMehzXdKPqY4h0shY
 +lAw==
X-Gm-Message-State: AOJu0Yzr1YsK4knKScRwxmSbGro4kxbtY/ZwuDC4ZdjBA36orTnELAEJ
 ajAMiZf6GfwNBS2WVUqbKukdRFhcZ7vAOD7x2YReX+iprDurhWWzY1B+oFLtbLz6UGk6CMRmE2r
 zaNWHYw==
X-Google-Smtp-Source: AGHT+IFn8bJGRTEshseoWi6/e4PsdX3oUL+KGJG/9VlyA+Dq0SPuxcqDH6CFhvIT0H9o/zrXE4NLtg==
X-Received: by 2002:a05:600c:c88:b0:426:6089:e503 with SMTP id
 5b1f17b1804b1-427ba687cdamr20380745e9.16.1721155345958; 
 Tue, 16 Jul 2024 11:42:25 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef57aesm135373525e9.45.2024.07.16.11.42.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:42:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 06/11] hw/sd/sdcard: Add emmc_cmd_PROGRAM_CID handler (CMD26)
Date: Tue, 16 Jul 2024 20:41:39 +0200
Message-ID: <20240716184144.42463-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716184144.42463-1-philmd@linaro.org>
References: <20240716184144.42463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Message-Id: <20240712162719.88165-7-philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 09077f0154..a90612af58 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1568,6 +1568,12 @@ static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 }
 
+/* CMD26 */
+static sd_rsp_type_t emmc_cmd_PROGRAM_CID(SDState *sd, SDRequest req)
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
+        [26] = {4,  sd_adtc, "PROGRAM_CID", emmc_cmd_PROGRAM_CID},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
-- 
2.41.0


