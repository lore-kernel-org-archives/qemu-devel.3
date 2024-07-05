Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83B4C3DA40
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3f-0003Wi-OG; Fri, 05 Jul 2024 18:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3d-0003OF-Nh
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:33 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3c-0007go-46
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:33 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2eabd22d3f4so22910761fa.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217130; x=1720821930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAlAjAi0la7DLkTry/Utfy2iNkVhe1yyhErZWeYwj/w=;
 b=UasUh2Pv/GJ91TzRNbf/X69usZT2IR5k0Jmoolq8xEE9PQfD+K/x/zLif45SF3i5P9
 CE1Ff96VjRChiyVvmV1v9Jy6rx3eVD87nwaPaOPW9VJUjeL4UlMEpjKKo/bnWUqgl54L
 rCCQd/gBmIXrJ7zwaucp32ixHUmtCUhTMcNWDQThfZXDl/geQ8D6J4BhCVw0xdCFBVin
 Mn6Mp0XeWEsR/RowznjlZGzlxxaYA70CQJt+MYIfoXEdFPvx27wQefo/KXMEA26Kch3F
 3i/QxCzsvX7jYxsd3sLShw+TQgLl7GNLPPpzDoRCAnax25RohbQtNWfVtz+UXagHQYek
 A1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217130; x=1720821930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAlAjAi0la7DLkTry/Utfy2iNkVhe1yyhErZWeYwj/w=;
 b=jRiJU4fxwDUobuQoTtThVDvPsmpOLpIOdwVxC+1qCKzMKAewMPdiRQGUYImMDMwh0L
 p9wQQNgShvyW3yS+I7P0WETS3J1m7MDcry4n7EpIQPwESZfkL+1v72yOzSvd2KCZ4sRd
 vyhygSxEJRcUoNp3ofxZml8Xn4P7tMPBgbIh6ZzI/sC8dhegxnRXqUfdlSVj2ML1VYq3
 ANiQefdX88eoOsNVP5mHIlvl0vtNR1rr6NimKL3dM6Uje/iIjxZqmbGULRQoeg0UIVde
 EkhgIwOZ56wH7i1/zU+MEUs/nlN7GG3tEVpGijaQK83tuU2uDTkPRf0Qix9bByypT88R
 wHXA==
X-Gm-Message-State: AOJu0YxBgmFoxPl+ci9ajLat+ULE2upkzCR6wjO0WRKj+sdCIQEFt+QN
 aUGMfdjREMpPZNIMuuJLD+Vss20te4w5G2eTNV/ewJ3LVa1B7QzDMS0CPHE98groc0TC3ujRpK8
 x
X-Google-Smtp-Source: AGHT+IEcd67+e1RMe3xKI3C+lii41F4GraZqrdtNhPRQdaZH2Y7GMO0HLSjcqm+zN8YMBEri7VMMPQ==
X-Received: by 2002:a2e:b52b:0:b0:2ec:4428:b6fd with SMTP id
 38308e7fff4ca-2ee8ed22717mr37493891fa.9.1720217130092; 
 Fri, 05 Jul 2024 15:05:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca4b7sm75203255e9.37.2024.07.05.15.05.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 10/16] hw/sd/sdcard: Remove noise from sd_acmd_name()
Date: Sat,  6 Jul 2024 00:04:28 +0200
Message-ID: <20240705220435.15415-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

These ACMD names weren't really useful, "UNKNOWN_ACMD" is simpler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-77-philmd@linaro.org>
---
 hw/sd/sd.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 43f60cf089..274a917ba6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -257,23 +257,13 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 
 static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
 {
-    static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
-        [14] = "DPS_spec",                  [15] = "DPS_spec",
-        [16] = "DPS_spec",
-        [18] = "SECU_spec",
-        [52] = "SECU_spec",                 [53] = "SECU_spec",
-        [54] = "SECU_spec",
-        [56] = "SECU_spec",                 [57] = "SECU_spec",
-        [58] = "SECU_spec",                 [59] = "SECU_spec",
-    };
     const SDProto *sdp = sd->proto;
 
     if (sdp->acmd[cmd].handler) {
-        assert(!acmd_abbrev[cmd]);
         return sdp->acmd[cmd].name;
     }
 
-    return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
+    return "UNKNOWN_ACMD";
 }
 
 static uint8_t sd_get_dat_lines(SDState *sd)
-- 
2.41.0


