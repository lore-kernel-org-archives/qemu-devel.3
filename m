Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC53E6ADCA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVh-0005qo-03; Fri, 22 Nov 2024 17:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVe-0005op-Tt
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:18 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVd-0003mR-8w
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:18 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-724d8422dbaso1909840b3a.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315936; x=1732920736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1ctlapp4stEVU38enX8v91wei6PmLR8G4O2Snl9LB8=;
 b=MmJ90kTGJfXagec+Q8HhwtYD3doLez0ka3I8e21t+C6f/oWZp2TZlfZhltBXHBTKbo
 v+al6VL6tsIKm/K2ucPCaWI52csS+p5/RtXklLHA5fpExuoka8QHzzlq+mjSxmp5nUop
 +qsTrl+Clg4MxyUrBqiSoIXCtF847YpsdvDZop2Ct6x6UmRhVUVf+ztGz/Jzyz5jh1gy
 IYxd3mnSAEa++FOvJnI5BlMDeInmxAG07g8AK6pW2XSr6MPrpWeAdzxwsv9j06WK8DKl
 lI7+9n7USPQZr0FYe6pel/SiNqYBSoqFBjxjebSSw1xQEMD3uu+uEQZkK6dsNQTxjjrT
 6hhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315936; x=1732920736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1ctlapp4stEVU38enX8v91wei6PmLR8G4O2Snl9LB8=;
 b=FcCaWArdGJikp64+vuosk3/osT8LlmfLA2V/T+6lz6/4vfnBWIZjaFisfruYd1uHja
 A7hbmMueCGswTLjMIzElc6SY7/GPsL8/ZFSez7H2iO1lrjmB88bWCyrCLxxeLSNtvIYK
 l40ZqdRNHZC30QoMpVYq4qZurgCuGLCltHRjGOOBZIJhMPhius0H4yJTdyRlyZG7NQXR
 dKJnnP5vOULPS1NSJJQxco9jc3mtA3igz6htniKajCAPQQZJV62YVWRcmQY1liqwe4Pd
 012v8ylKC6UDA6056Mprvd58fMZkScsBGknDyq6ptLSFzum0/osSfMUTiw1t558w3MYT
 Ljwg==
X-Gm-Message-State: AOJu0YzFAgq+LsgVgl6d7+jluU4uBfukyx2R9J970nb7J4vdW/T5cPMo
 SmAQYnqx7ryzI0gexSsdaqIT+7tDLrF5zaRD2VEo2p2SE6aJlpcaZrEqlAxgiI93Dt2gmxO1+sB
 y
X-Gm-Gg: ASbGncvJHxHl3NQ8LlFajCfyGGMwwLt9+Lc+rw3twlC9v4gkykZCRBtTll07y0Ir518
 xcVCsc7eMYMfFB2Li73hZ8pmFlSu7iFhIrLo91p6sDLDhBGC26UDdLHIR8xgK2OM6mWFwkwJP0U
 tClWiJMa6Ubb76dVBOCjlAKI47iDYXGd3oYNtF2fSAyDyjNy++7t4Y6dbtb9k0vqMyKR/lwNHwO
 bNZHlkoaPVOWjNh4iVORvHIUo2CaNEp98rWI6gq1cMUz3jrHent9Y7c4aqZqHXptct2EdwL+Qp9
 YYNGO+9T7+qWYg==
X-Google-Smtp-Source: AGHT+IFMAjPxi4stB8Hf9OqS6Sc5DQOnaCJAEKbNQseckW4x31B6Qc1nc4qz55uDEJBH4t0YDlSNvg==
X-Received: by 2002:a17:902:f549:b0:20b:80e6:bcdf with SMTP id
 d9443c01a7336-2129f237d5fmr54963075ad.23.1732315935989; 
 Fri, 22 Nov 2024 14:52:15 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 12/12] docs/system/arm/aspeed: add missing model
 supermicrox11spi-bmc
Date: Fri, 22 Nov 2024 14:50:49 -0800
Message-Id: <20241122225049.1617774-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/aspeed.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 2e9ba12f7ae..d17fe7a4fc8 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``tiogapass-bmc``, ``tacoma-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-========================================================================================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``tacoma-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+==================================================================================================================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -15,7 +15,8 @@ AST2400 SoC based machines :
 
 - ``palmetto-bmc``         OpenPOWER Palmetto POWER8 BMC
 - ``quanta-q71l-bmc``      OpenBMC Quanta BMC
-- ``supermicrox11-bmc``    Supermicro X11 BMC
+- ``supermicrox11-bmc``    Supermicro X11 BMC (ARM926EJ-S)
+- ``supermicrox11spi-bmc``    Supermicro X11 SPI BMC (ARM1176)
 
 AST2500 SoC based machines :
 
-- 
2.39.5


