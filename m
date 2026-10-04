Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEFDCA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLKS-0006yN-83; Sun, 04 Oct 2026 08:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKO-0006u1-Ql
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLKI-0007FB-Uf
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so8636895e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116900; x=1791721700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LgGp0v9oTRznvsuoY+AnWTbK2P8vfLWEbU2auUJcq5I=;
 b=FOfvPSEHhbvl6NU6CRlHHJzKinBXnWRB8dft9x0g7A/OSADwtV8FvcOV0E5zYF+grP
 d2qcN8ugB0sb/aD3wdCjCtv+UleiK1d2HbtRfywO0XVY2gBS7bqCGVM66Ejo7myCeSsm
 MW/G1wXkkbpWpOB4DLypAVHI0u+Gae36sQkpLW2qGlmCF5PQC4pEE877N8Tui9SxPNKL
 FX5i7/rM22efuvvtYBN8VOjgBvm8qm3jmfk4RTGO1aIBxyZfRiXtULuph4n1Zy7RugOz
 /lAK1rHsmb0E/cOm9/iCe0lGEB3Qu5G6V7WIg4czXrOalh5ogXOuYq6QxYkr49Te4EEr
 GsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116900; x=1791721700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LgGp0v9oTRznvsuoY+AnWTbK2P8vfLWEbU2auUJcq5I=;
 b=t3GtDQgwGlCImEFhb5P5NWUDK+6euMoccbxmqRxfFJjIpZaWZDRVAArCJnI5JEFAX9
 xtV9ipAyZJUkw5p8r6uLiHosTXak/0UfMMNIYBH5J9D2Q3JWeJR65iPZnIeqlpa77Z/s
 fxMYJxNfDrIrEnDeCeicLd0m++xqZZoFcBtMqx5N7F/GEMm1ZJlOxb6RxiauvfnLDgv0
 04my6S4dSO3X62u8uNgjm1mgWIw4m71Fe+EY1DwQH2evgcO5lSli4SZZ043gSms8BJIq
 1MLVQp4IwUhvDlQ50koy4OCYfQNJL7zc6SENZOwlWIvCW4lvsv2l6BtGN+7UuqRttg7y
 brgA==
X-Gm-Message-State: AFuF++mcO76fjsFQUpfDH/RAcpuvr6/RATIJTiF2Lto9k1We1u5u9MJw
 w+maJ3hp8IK7ZGPlFufHE1TJ1p1cVEDuYai2UWH2Bxh4ns0+sSP1boSft9lL2Q==
X-Gm-Gg: AYBFou0fbHXG/8yqcD1diLqPT/bSasnnKCDYvxmEO/q6AnF3O7yS/nR6caL2Qw0Brp+
 4f9g8em7ZDq9SXPnw4MUoW6V748NJdZXQ+USdMI/nVDss+NAQ3ATUQWq56kwBi/mU4DiOopzGqu
 /xi176U94A2cn1nJPkUKwzBgzMGJVcG8D3W3LjoWme8yXDEfQQByItvZJD8UGdZd1DLWj2aDAnX
 KOCrvTelsEnfmaaRdM84mq+Zs0nPbTH+gTCt0E8uKNM72/aAzKl9PcEJ0DJJ0hvMT+6ZuybSmqO
 l6TInoJdFxCfqwvANGEkmBIGxhDiCLtMTFV4KEJJlCpjGsrd5GkvGEG3Z95LR81lmHRtF1IvDMm
 SOg2m/OJlx72rt5Sh+Y7G/y0yH//prbvczg7QowlzhpGle8yo3KKV0Y81HqAX+cG54hAeUd/59Q
 H/MWu6u0+ll3IYe6xNf4fYtiiO1WwhyG9M4e6oKaIg79+//Mr0TJnCke6fkzHMrQzM40ygZr+ju
 vDHANrg3kWlmJjSNlVJoYNnbvMtbxanpUFWpQ==
X-Received: by 2002:a05:600c:3103:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a1680fd804mr68101415e9.30.1791116900174; 
 Sun, 04 Oct 2026 05:28:20 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:28:19 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 29/30] Kconfig: Remove config IMX
Date: Sun,  4 Oct 2026 14:26:45 +0200
Message-ID: <20261004122647.3913-30-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The previous changes removed all uses of config IMX. Remove the now
hollow config item.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig  | 7 -------
 hw/misc/Kconfig | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 543220be6b..642dd86217 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -481,7 +481,6 @@ config FSL_IMX25
     imply I2C_DEVICES
     select FSL_IMX25_CCM
     select GPIO_IMX
-    select IMX
     select IMX_AVIC
     select IMX_EPIT
     select IMX_FEC
@@ -501,7 +500,6 @@ config FSL_IMX31
     select FSL_IMX31_CCM
     select GPIO_IMX
     select SERIAL_MM
-    select IMX
     select IMX_AVIC
     select IMX_EPIT
     select IMX_GPT
@@ -519,7 +517,6 @@ config FSL_IMX6
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
     select GPIO_IMX
-    select IMX
     select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
@@ -603,7 +600,6 @@ config FSL_IMX7
     select FSL_IMX7_SRC
     select GPIO_IMX
     select PCI
-    select IMX
     select IMX_FEC
     select IMX_GPCV2
     select IMX_GPT
@@ -627,7 +623,6 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select GPIO_IMX
-    select IMX
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -657,7 +652,6 @@ config FSL_IMX8MM
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select GPIO_IMX
-    select IMX
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -700,7 +694,6 @@ config FSL_IMX6UL
     select FSL_IMX6UL_CCM
     select FSL_IMX7_SNVS
     select GPIO_IMX
-    select IMX
     select IMX6UL_LCDIF
     select IMX_EPIT
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ab238767b8..93666c4ac0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -89,9 +89,6 @@ config IVSHMEM_FLAT_DEVICE
 config ECCMEMCTL
     bool
 
-config IMX
-    bool
-
 config IMX_CCM
     bool
 
-- 
2.56.0


