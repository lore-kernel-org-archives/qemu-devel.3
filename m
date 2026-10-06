Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1C2CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMaK-0004Zl-Qa; Wed, 07 Oct 2026 04:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEH9x-00026v-B9
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:13:40 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEH9n-0006GG-3l
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:13:28 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso2558773a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791339041; x=1791943841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4YQL5m4zq+Pgk78JS657IhliqFYCX7VRgAFFPt0Enmk=;
 b=C0J0VKKBRS5KAKxCI6C2Uk1y/nFVhFa0lKcCDsWINeCGgIQOdNfNrpa2VpqubOFsWq
 EGhlMPNt9EvGltfhgsXePgYsv9LaBKTw7P4Do6kDnjkRIa5ptqzTtdkyJTWTjGrp6l6x
 GKkS1Jm4o037+vkznQvnvMtLxJ99/oIElO5klcbHKshnO2G0eXQz+XSD4ah5OfiWySLq
 Ct+zoirTXsDCHlHjMnEyDp4Vwo7RKn7a0mYFP3aVi/n0La68StXpm4CzgLLnWWbq3xk9
 h+iLsq0Nm/dqtd0XbstGrLH6VGSrWjXF00VwHCQ+w+WLXnZQzq+lNDQsRbOWGqlq9mHS
 VNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791339041; x=1791943841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4YQL5m4zq+Pgk78JS657IhliqFYCX7VRgAFFPt0Enmk=;
 b=gvG2R51E8xDBPLj+15lIjmEtisv+nSbcsmjboHqIRbB+qgY2Drdg04ohOHBZnh2UGg
 6H6KG7Qroc4ytE5WdbWsAkk/BZGr3VBYq1WWS34X6ySm9A8OGGwaLpmV4oy1kn+NBw4F
 fAJLCfg69fMT2yLraKfBboTD0yXW87+mTwaoajagGCDxZU5yu/m8Cgb4ZlKLPwpiS9YX
 b+Mm9WOJzL6TSY0UWTCMDsyRfT1K/bx0XCZliAcIM870t9UVfkG+UMOPdtoqevy3UdO+
 PcAQGnv/Jiyjj5BTVFtbp514T3h0Dfv7VhqtqL1SqPWdqBPZMxhXqHtabo++//erEiNB
 a79g==
X-Gm-Message-State: AFq9FYLVdbjCyyxQZhcProjkc20ywEqpL4dIrEq/LbL8It/rBwWW9Hhw
 9/CF8z8NPiaS5nleRnFF2EHWL/f9n0gxbL59f9Eub9jTYdyJ1IzHvoYYG+tCHQ==
X-Gm-Gg: AYBFou3zGlls81SRi5HpArb3gNiqJzoEBFlQ0ytrfgXEXSMAU7BtAjlhztFcHZtzeno
 1Hlkorm2EUnuiKwqzJv9dLzwcmKmmDlAM5esupSHvm1DLh6D7jNtkpTsJCpFQGJmUyRqO693WDw
 pyi1uypZeBPJHUl6RO1MuK+zoSdqI2UTmPZFSBTeS2sCmt0gFXRhOh/Kvge5cV7DdYX+34kYjfD
 YaZFKqzadIscSxPr5TguHsX1XolPNqNg5UzIkZ43FHcVOIrr10OvShDsuZuL+N1h/qXSS57b4iQ
 W/tiDFiq8XtsOh0uM7KPjz3gUZ4V7cmsgp2fKR5CVWT/pC+noUKaeJTTjfaYloh9I6mzv0HcJjM
 4ctMzYgZdYZlXqxSy6ZOh1PRrN5mZLgkXG4IAIBssiOKADeFGvVcKIV6RpegRJyuwtWoZ8lFRdQ
 YEwEQ5MBMI+xtznA943qp69sOfInj5YzqQbxwvIyftuBA9mIG/Z7rHRezj8kV7B9lH5joY4dWhf
 Y7VFYy2gLxpk8OlqrJ9GKBFHXrgkv8DnoeRqA==
X-Received: by 2002:a05:6000:4905:b0:487:13f:f612 with SMTP id
 ffacd0b85a97d-48c6d1c9658mr1018354f8f.37.1791275757010; 
 Tue, 06 Oct 2026 01:35:57 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:56 -0700 (PDT)
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
Subject: [PATCH v4 30/31] Kconfig: Remove config IMX
Date: Tue,  6 Oct 2026 10:34:42 +0200
Message-ID: <20261006083445.30362-31-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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

Reviewed-by: Bin Meng <bin.meng@processmission.com>
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


