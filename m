Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490EBCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfoq-0003pY-BS; Mon, 05 Oct 2026 06:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmL-0002HF-8t
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:45 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmI-0000wp-H9
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:39 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b05fdb2f9so1271905f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195516; x=1791800316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=07cFrgUM6cjvx6tpFpm8bpJgkAMQMVUlJURJV9H4y9I=;
 b=H4dzUn+eiX/NbdzkOGzgUe/PQTFsq8kAQvTeWzMruFCAewweJpHYj6wL+2PQN1OKyA
 zKz0ZySAc+m+QBJjpRWYP5lKpxjIs1V8+L6KoxDqT5HDCv5BR+9y8ahqlItX0ykN25R/
 +59B4I5XUKej5R4dMTbFdda+wtJrauAxHOuWfItz1zHtr9grHoo5mcoq8I/h8G6BxgMj
 UifEAoL6s8dl4IxrdpynQvviQZWHdgn8CCegLPBUTWP4SMYWXDWf6MvGHI7HhuARDKMA
 91+JrfdWNyU1aTCwrvx6JKCIB+MHY+sNkvkBR7sRTZ7b5SGz65grDFxgRuviQGYCS2Tk
 lD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195516; x=1791800316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=07cFrgUM6cjvx6tpFpm8bpJgkAMQMVUlJURJV9H4y9I=;
 b=YFRd581il67iH2dgk906GH7G1UjOU6wpeYIsQPcJvjOpZ26PnJnbSus04OXihtvRWf
 EZX4TQpCrWthC4i47zO2IvbW3jhUzSqapwQBsJBlOa14G6ykIYhHCT/bfo5BTv07Iiqv
 vY5fAWz7F+FwNYFoU4s17TNocyqT3wtTbSq5KoHN9XjjQwYwyzw8sWBZhQ3GaO0l5HNP
 ZBNjrr8DjN9DcmVLFTz3QPNEtL4IJGzjvfADFIn+C/Y2amCk8P4hYigbr2BXEirnd0ER
 mxhD05i7E0z6IsOauWk8pnLKeSc+PdITJd38aD64QY4xKXyn2LDH+Qpz2VwjfMnLouU9
 1i5w==
X-Gm-Message-State: AFq9FYJl1Lm7/EbxS6u1nSJEgxFPBAz+/Mxj51QUM4Wo6EnQGKBstjIP
 qBn5aKBtXUCcFaFo2rGZdKUNl9iBhx7qmttzAFCScKvft46rvLGLMY/26rELRQ==
X-Gm-Gg: AYBFou1OqWJamYOjUzAnjEF7daqu5rByj4w71gYnG9pt5Kmb3Y2UDaOaR09XJLg8jXi
 RzI7EOKn2tItQkxchNPmLRabaD43YgFqCWs2Vlu3os9tE1ljCw52hnL5uPK8nn+7oOmUaUlYNNp
 n5/CSRRrRl7SdFvMMg+iJZ5XXIgsAWI/RQczWkzyYGyArc8+KYGN4wPNLg4W0ZRcOd6OfG2/VnX
 BpyuKnRzNO7i4FnpOZEWOuI2dT/EF3ZSFwwIzwTCQx0sGPYWXAXPJUHuR26Yze8C1ZMps9WcQrk
 E+kAf57FgTGdHqznL98T/fGyBCeeyKyXVWUd/Uw4R3Kyk/vyKNJCNgkWiHzQqGMWmAAiu2SJr33
 nrjniauxE/DoMZFhiJUSDYc5DULd3mhbIiUpQnRrmOXfueadiHgWcEZmNbM2OD2vOVpkKyVofz/
 yF+bs9uRTG8LOynuaYGFLsya214EvIixtXLctff6wKNxZ8f3cLcalr7zUvgMMgP0deWVzxRamz3
 fJB7SG6OGEhYQTZd7OodcoOqiJv9dB0uWbytg==
X-Received: by 2002:a05:6000:2210:b0:48b:1276:72e7 with SMTP id
 ffacd0b85a97d-48b1276737dmr17461108f8f.13.1791195516454; 
 Mon, 05 Oct 2026 03:18:36 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:36 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 10/31] hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM
 by default
Date: Mon,  5 Oct 2026 12:17:37 +0200
Message-ID: <20261005101800.10821-11-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Having two CPUs and 1 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-smp 1 -m 128M` needs to be passed on the command line.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/mcimx7d-sabre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 65fdb19c06..47744e66a4 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -81,6 +81,8 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "mcimx7d-sabre.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.56.0


