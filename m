Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143B3CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN79-0002lZ-DF; Wed, 07 Oct 2026 04:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEI3t-00015b-4W
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:36 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEI3f-0000eI-Lh
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:15 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5bcd17f3a93so38841e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791342626; x=1791947426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e8TB0ZtYp24WPs3mqNNFoiQRZJQqozvFbAYX81zZos4=;
 b=b4Av6QzRErUwFbgSMXxIDFkZW4bPYPx87IWdNONZTcWiE5gncgU2q6UoakdpagKhKt
 +Jz6b49vMprQwsbSWZKyabV/rvT0opCpPOw2++OLYgyODaTmEvfqmtfCOT40F3hCAlDZ
 TP6oLGT91jWxGisFeFJdF7041LZ5QoJqg7tivCW9/thJhfVrgunkUFDZ6dGyfftMKXrf
 VJAGjzMOU2FKs938Geuw3w4MxpWTX1HFl8NmLLNwhBQys7qIN/4YnLbACQ7T6k9zBcHu
 LMFl6IfGNV9IS0b0IxhnBewYuCxC0LEVmgt211vQKAFSuU0oAFyxoA4uHxdEwRKh5oIw
 G4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791342626; x=1791947426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e8TB0ZtYp24WPs3mqNNFoiQRZJQqozvFbAYX81zZos4=;
 b=BKgiJaHZygauP2sunPki6vQPoTXOr8QWqCpxmkUDbekT7ozvr/ox5aMeHWvoxb/l04
 NP42OPVL9z79P8os149pZPsU8AGAPsD8GXZFrDu2f+iWG0qoAT2A+7n/6KtnZ6HIsk53
 KttI2Uck0oJkqankpKzbGtRPdKOYu5mU/FOi1WUduM+4z4gWS4ClemNDnFJxis7udpo3
 Lm2nzC1yDxqzPNVOIc1mA7P6kdizQ15r4QniMpuDoAnjFTjcH/uDYpPN5Nx4CD0Qr3V0
 tPMt+H80GrzRbrCRnRp/UQzrnqh0N5ZvMoMF+77hH6cPJ7CNqRsMvQp5SxprOuATkddo
 YYAA==
X-Gm-Message-State: AFq9FYJ4NoOROjuzNuuHuVm2G+ELukNrENXSyydOXiwQsUqr6jFeSgYM
 987iLbs4EQYQkl/uAVdoxQWYcdg2jz+YgMoHvHyznK4vscUayxJjjDc6Qp7IBQ==
X-Gm-Gg: AYBFou0e/QVRvy5/7tfgM2QA9vtgUr4SzP6Cj1EUNb8T4ESZ5cbx5lmWAnExl91I6m3
 7gNxTvjaQ6MDjluZgsCOKoo4oNYWDxLVyzwFlIyekEQhm2vAr+BTGWe8wr2FsL7kEWqNACbIiMS
 uFSpd1tnARR/wRSPdi5l/heoC5AbEAYk9g+t15DWa38+lh4IjGM9t446o2CsFnZs59Vbb7NWKfF
 eVtBVKoLKZc5PbogoQM/rBNS/6l2JjyDPHgXzlZsgbbK19nXhZiMe0AXfZPSsDQrfRmgh8mGnr4
 KbnbNu0zyWTMLgxiCSbMHrgwn6ZNkJrAJNAsi4nDEL3aJILBhdQNEfyLI0xEZXx9Egszx7eqF+2
 i/onUAYAXZoPsoWhN1kKDDXtQ7AqLYAqgQI6dcmGTjhBNJBOOlER4FCXgEDMjL9MB2HvICoL1pW
 zfNscLDiVE8X0TSuNu+SJhSx9E0cFEoPw5HA7vZXW4n29rKHAQz5753kb+1htF+mixj3ieL1ohf
 Fl/k/I3yKHrmdJrqX+NrLrhIyuEKv5rhYJuIx4JXVCofepR
X-Received: by 2002:a05:6000:1844:b0:48c:4eea:4712 with SMTP id
 ffacd0b85a97d-48c6d1b01a7mr1215793f8f.53.1791275730611; 
 Tue, 06 Oct 2026 01:35:30 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:30 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 09/31] hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
Date: Tue,  6 Oct 2026 10:34:21 +0200
Message-ID: <20261006083445.30362-10-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x132.google.com
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

Having 512 MiB of RAM matches real hardware. Fix the machine
default to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-m 128M` needs to be added to the command line.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/mcimx6ul-evk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 40071d2c7b..4964cb9345 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -73,6 +73,7 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex-A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
+    mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "mcimx6ul-evk.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.56.0


