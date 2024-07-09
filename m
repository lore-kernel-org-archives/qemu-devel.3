Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E159C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCk6-0005P3-1d; Tue, 09 Jul 2024 11:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCk4-0005E3-1n
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCk1-0006Ib-Db
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-367975543a8so3581553f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538810; x=1721143610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=achqB7NVcZRX2FNdfvoM8hvaB6H3FSzVjdNn3nYAeTY=;
 b=lxCqDIA7QawU7oy+j8DXnkQC9jguJPLeW16eHCIRzOSFPnPfRdMzzG7ROu46tpsBLb
 YrgRfjrGfbdXObgqyZhxsBpTPwajK0KTS5sizY5SpqicSzX85MbGgAkMsWTwha0DZw63
 C4s78J7o2PnpdndD5ZGU90ciM/WAtzAQKMhQNYg5lPMIBTJuwYbZWDIBtu9HPe5NW6Nz
 g/wkxmvbsONtOdVH3VUH8NrKiUa0I/5To0GsDi5iQQQlZcEkMbfpfGo1F9JJ8km/Gkyj
 2ZKPQirvfeA6WfcVVPg+/bgKdj495VhBBy6Xt3b/3+cBO11hp1BYxomaP2+1FeTd2ztA
 Ef5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538810; x=1721143610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=achqB7NVcZRX2FNdfvoM8hvaB6H3FSzVjdNn3nYAeTY=;
 b=OSnCj/xEHPcTkOixmjfPa+/lPepge7TDgZ6e6a9Z9Wbi/6jmOuqqUBOtbbXMUiH+6p
 HD1FNHCFy4V6kJklwYqKDHx3Hf/gJcgOArF486g4q7rpMkkP9lCbhAmWHZTR0D6emI6g
 YIUP0N5udwKi+L/rc5eeEgrFaSlKwGcu9JXuaMPhj3nrD+nVgfF0gMw/rTG3Gc+E3hoq
 SK7tJstm/89EGnxEfMXCoypnj/RWVZiQUZf9+iVuiHPmORS8MGDsDgq2f0rv6ZL6jCq1
 6/uP9TsYgejhtDMkYiNx2fZ1+dZrkoTFemLgoDRHYMzUQvxgmbV1KIwHpihBU4FRK1UB
 2Hdw==
X-Gm-Message-State: AOJu0YyIJhvrKG8D2yZoEgJjAa5Rxtjyr4AgBpjZH0vBeJDRJp/B/GFp
 IbFedvn90Wqm6BcbB5++RuS4harZ8Ut4Jw83bRvcGwwT+R3mqbutGE0stoxFGSxl/9oAKMt889l
 B
X-Google-Smtp-Source: AGHT+IGJAcqBtsD7DHHHAcYNxCg8efAllPTOVpUvB5fYqfXMlIpHJJgnPyjJ7HoiMuFusdb8LLCOug==
X-Received: by 2002:a05:6000:547:b0:362:d875:6dab with SMTP id
 ffacd0b85a97d-367cea73626mr1964117f8f.25.1720538810415; 
 Tue, 09 Jul 2024 08:26:50 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa06d3sm2835401f8f.75.2024.07.09.08.26.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:26:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v47 08/19] hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler
 (CMD26)
Date: Tue,  9 Jul 2024 17:25:45 +0200
Message-ID: <20240709152556.52896-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Message-Id: <20240628070216.92609-89-philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 216d4dfa89..05c1b85476 100644
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


