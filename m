Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D00CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfou-00044E-2i; Mon, 05 Oct 2026 06:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmK-0002H8-1q
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:43 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmH-0000wg-5s
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:39 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a169d33ef6so8751495e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195515; x=1791800315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e8TB0ZtYp24WPs3mqNNFoiQRZJQqozvFbAYX81zZos4=;
 b=d9sCIUV8FzfeZnapR+lQZbYGG3iwZte3VtbcxUoWBuWf2VUU/xeb5vMfZiF39W5mhD
 S6juZYl+cXYnxQwTn7t85gDyISqQ4g45Lbior1UnyxrAa0y1rHl4sjF7C1PHSm5CxFgq
 vK0B8xnI+T5sCtdK9rf1H/yAWjz5GbX7OMRnQx/rpXjKWa8gsIXyb5XGx17Ni76CAPKg
 6/1w+yFrh1uHCT3fCNr5NERu7NyRDPvpzhsaKdD4Lgirrlukxzid4726G9Gr11qLquch
 g5kElZapyODzkGGJOkWzUjf4bJqK1gR+lL1DxzDWn29mAn74yVd63DFblKD00yc3coKj
 u5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195515; x=1791800315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e8TB0ZtYp24WPs3mqNNFoiQRZJQqozvFbAYX81zZos4=;
 b=HDTl+RdaHm6PTu3RmI8cgR4zixvgsjilSUvfNap+R+ddhobE0HCXd8PdaLOZuzU09V
 PqWCNJOSZpYKw4x0PsjMpXzsQZW4nc832zjubQvxOKlj35oeVIupmdqJvPdKKxSyzr1R
 VDpKrGeA7xtREMXpKJrfyEkJZkkhFKomFR9PwwnO10JG3MdG79/hw8eDKb2jktNfp/J8
 MxMsLZFF9uVijv2zW0yypiYndHP8dgrvfBiwAOUyAPJHJGYDxGviRKWFp1vVu8A4bZNa
 Pr+0pwzieo/WIE7/x89sGfhX2+10p8RvYemFx/AcO+baYBL5WZTXGjanmPFBnDFaSqo3
 BkHA==
X-Gm-Message-State: AFuF++lXCAAbcFf6X79HG4QToZpXvoCXv9dm1ojtOyS0ILfpBX3/sT0c
 J9Rj09LWory1QnPrs2PbHUscNkiGWW7KZcak+yK4dUrBc+LGgKf+R9fhfU1gow==
X-Gm-Gg: AYBFou1kLb6a3Z607MstyY7Pp11qNLc/P3cl6eneaWEr0B95/IdXvyTE3+z44V/Brw4
 HNrMPLq8c+HRLIDxl5V7m3aSd5IsRj9mRNaiDnxIGs0aZjf80XaBQ9TKCa3m5g6WR4VtObWN5Th
 ioWm95UQkQghhAHlRu4+TSpO2oMXUTqaMCjE5IvtdY1zV+9bCxXLN4O6AhuOJ7zCEUgKV357Z42
 DzvcEiGgfxdRobomgxjJSuB8EuifoTb3XVJ5mcL5jXLy9Odjw3Vw+DP1+Zz44QFM05H006ySLCO
 4rqAMF4DzLA0/pfo+tyk0T8TuXw/a1NjA6HaOQPw41BGFcS04eBm63Xrmnb+VeTn7ET5Qch/z1z
 0OPqxAVDkPsGMVogOZqLesnnHWV7k71tAcF2Jy+5vCnE/NaJ69Z3YdTXGi48COCVoboHLFaYN6N
 Dk6IfuoGg4bDQkBazW378XmMGid6e+EwXso8+3V5tI5+L5GUEOOYzZDTszeYOjKGFaYHJVrZE3T
 kWUi1t/ebCnODhtI7/TlrHX1VN4SUjVaegLLQ==
X-Received: by 2002:a05:600c:1551:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-4a0275a229bmr192399055e9.26.1791195515277; 
 Mon, 05 Oct 2026 03:18:35 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:34 -0700 (PDT)
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
Subject: [PATCH v3 09/31] hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
Date: Mon,  5 Oct 2026 12:17:36 +0200
Message-ID: <20261005101800.10821-10-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


