Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190CCC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvpw-0000aK-Bv; Wed, 03 Jul 2024 04:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvpm-0000Ud-Bm
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:59:26 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvpk-0005rT-Os
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:59:26 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ebe785b234so52939281fa.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719997163; x=1720601963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoWuf0YZY1BQUG+pjDOF1AACF5xUnONjLqdzkftW+K0=;
 b=OOxQi2/3wNaOMu68ciJ/4Fk2+ulNAL0uSVn6IuIZpf2lujQJGIuYNjDYP3JNAXZ4R/
 BNxd8yd09wJYu42rGg55lTclTpO3SUZ2SSfq7+2fw/8biPfeWI76CveceoT0LHF1EzQi
 0JMA9pNM/NzI9C+hXpRHNZasnZMAeDzPH7uZB7khVTo+zJzud1dGPiN2B6g9ACnyUvFx
 Ghsjun1sie4wnloWeUP8C8EL+DkmmFcWJhbhNbDtlfOdq+QuMLWRePa9pMxlkxyalCmm
 sCD4Ci86icZzawywLca9GoguYN4uCur/6g3iuDLwKNvWHAOe0wis9KRD6VQ/jmySwDKX
 jqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997163; x=1720601963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoWuf0YZY1BQUG+pjDOF1AACF5xUnONjLqdzkftW+K0=;
 b=qvOq92nLNL1tVmvrMeFHXAJpi0coHwHgawJ+fRv0JhyTlVSSeOAQeKuMlAk7o+mFwH
 gyY4oD43ieQkQqFLB+U1vuPe+VWP8SDQOUokSz0nMhU5uZUGE6kK67qobSLBrwZj/ilE
 tU2n1GJ9ffiaPoDweWnyPKV5cOUReNJPSPZD3s5xmyW1ODc3p9IftOx1pGZBRbrqWysk
 GKpp/tbT0RFVg5UcHPYjz/18VngC0AYP4GZdsxEcBkammfQXoAkwdIQU7Y9W0EO8kjX8
 2h4V/mRVALIeqZ55hsIB6LdFpBJK9IVUbToegz49jyNdWKV/sqdlNoISCeyKeHn+V1i9
 dD9Q==
X-Gm-Message-State: AOJu0YzCjSFja12peLQoeASRwz2HlrrwsTbzEAcRJnwY6aZGS4Zs3Tbk
 vjPbv7TDjlE/hhKditOZKEv6yngdHmmYzri6jn/5+j1OOWShAQwZ/AQJDmxKu/yx91RFuAu3tnZ
 p
X-Google-Smtp-Source: AGHT+IHjy05Iw1VsbWVASawoqmedlzS+nm6T9p86a/BONXDIDX+M/R5X/IZxbIdOiHsw1O1XjQA3VA==
X-Received: by 2002:a2e:b0d3:0:b0:2ee:811a:54a0 with SMTP id
 38308e7fff4ca-2ee811a55abmr7881571fa.14.1719997162900; 
 Wed, 03 Jul 2024 01:59:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097b77sm226912475e9.33.2024.07.03.01.59.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 01:59:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v45 2/3] hw/sd/sdcard: Use spec v3.01 by default
Date: Wed,  3 Jul 2024 10:59:06 +0200
Message-ID: <20240703085907.66775-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703085907.66775-1-philmd@linaro.org>
References: <20240703085907.66775-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Recent SDHCI expect cards to support the v3.01 spec
to negociate lower I/O voltage. Select it by default.

Versioned machine types with a version of 9.0 or
earlier retain the old default (spec v2.00).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
v43: update versioned machines (danpb)
---
 hw/core/machine.c | 1 +
 hw/sd/sd.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21f..4377f943d5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,7 @@ GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
+    {"sd-card", "spec_version", "2" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 53767beaf8..a08a452d81 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2471,7 +2471,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
 static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
-                      spec_version, SD_PHY_SPECv2_00_VERS),
+                      spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.41.0


