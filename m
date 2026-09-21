Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E26C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrq-0006Qp-Ki; Mon, 21 Sep 2026 17:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrp-0006Oz-6n
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:05 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrn-0000JF-Gr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:04 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so20876785e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027272; x=1790632072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TXc2HrPiuM/Mhg6YntPOK+OUKZjiWmJhTHUqS5qMUVo=;
 b=nX1Upg8tjl9rSdofdPNVNVpc/xCaxbVE1SScNOKCd5Q8y7IBDyEmucucZPiS0bMG11
 OR71EFDmaWb01tO3nDD3nBQEefuDt7gev7219Lfy6/O4dZnZfJ+2GtjhHgEY7FwsNHDw
 GgJkxPUue1meyXm5oEi2XggjbmyMJGaO8ChB4Y3+IyJOPYmKwjAXrW3kfKbo/FkDczuy
 HggMx/U2ip5pbw9ehSwpnzq35v86+cE+Kf+WRoA/YEit2NQX+rprNRdpbdw+6dvkvCQG
 00VKtNz/8f0IQ2kn439lUeJqqR7GeA5WLPf/IhH6zGUz5vi5y8cdzaktacHtSQiWmIHY
 nE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027272; x=1790632072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TXc2HrPiuM/Mhg6YntPOK+OUKZjiWmJhTHUqS5qMUVo=;
 b=2MybexIgQVnuM+0fSYjSC75Zppo5EJSFV34DFkfk30L124oJOahd9hUaw0vvhCVkU0
 Jqi85932vapFWDpFDIwoafUkQmdTH/F+qLB1uevvwPRWaRlTXB/KI1VDFMx6CINmV+JX
 6ezad49cOABUPrbJY5KH8I2XrTIAvJhp+2J0wV18mFlTdjVGIcKk0nPjo4Ls+Y1ecAer
 O/a/lhdvFtr2HjRL5MW1V+tquLoxuQZate54A6GhSgJpeNLZwiD9HbAKt8LZUpe1zEmL
 4qyLr+rMvlxDYnQAWSTEFxpWZjKTIfBIEqAMkOpbxuN/doyFko9Xp+l+yFDK4Gp2yr7y
 N2PA==
X-Gm-Message-State: AFuF++k0D4+EJTC5fYjKUDUMuDl4w9QpW2rUJ3EoHnindAOATRTyuJU/
 O7UGxxl+O0Prz9bMartsgJbINu2SvGwNant+7cRMahI5mBHlpFKcd+qZKgmwwA==
X-Gm-Gg: AYBFou14AZlDJoGtGjtPSX0hMNFQa679JZkmC8lzdacz9S+nKqzYu63ZRkKOLxsa33Y
 4PLFsEgw7Zsf9jGqyPRzwAq8Kc3BK6jZSGUdWnuSDUsCdSC3aSqSe3Aafm0upvUUFwo1C1kMttY
 0Tne4dr1mStG5h0HhmHeWIvtZWnwCxk20CXbPLlGCmBc+e87eFGv4gADDtoOW37txdlgK0LUUsc
 fZ0Hb1bSJnZy0E0MlcfixC+/jc3N/PyJJy/abA1PVsoYQGb/Tw3PPFLJaokCzzqhM6TTKACAQ7y
 Cr+kBafU5bYC3+3QDNnSWalqSgQwbn6Nld9gyxfXpfk3YYKxtrW9tctgrS7xkjmimbEKZkzxCgu
 NhHk5F5ulnJV5h4pU+/TleOmpOZ6g43CgDavXhyTYkyn7zR+HTKxvNwGEe8bX4aVVFVKJ644D0e
 NtPwzoFoQ7u9RhmdWfsZRvl5InkPsLDQKoHR5B/Aa1BdcTy3TrVY8ezmckNQ3nLE9bK8iN7E33b
 b3l0H76ijuoktiQr48aE8lTDYY/swC4wQSoqOWSlNqz1MceXtA5F73CqLpDK3I8dOF9wr5ldEpZ
 PODDa1gW1WXz6Q==
X-Received: by 2002:a05:600c:1daa:b0:49c:fc6c:bdfc with SMTP id
 5b1f17b1804b1-49fc574643bmr155295515e9.19.1790027272176; 
 Mon, 21 Sep 2026 14:47:52 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 19/42] hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from
 config IMX
Date: Mon, 21 Sep 2026 23:46:47 +0200
Message-ID: <20260921214710.29422-20-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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

Since commit 464ce71a963b "Kconfig: Extract CONFIG_USB_CHIPIDEA from
CONFIG_IMX" all relevant i.MX SoC models select USB_CHIPIDEA such
that selecting USB_EHCI_SYSBUS became redundant in CONFIG_IMX. Remove
it.

Fixes: 464ce71a963b ("Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 46e3c03cc8..d1711433ef 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -93,7 +93,6 @@ config IMX
     bool
     select PTIMER
     select SSI
-    select USB_EHCI_SYSBUS
 
 config FSL_IMX8MP_ANALOG
     bool
-- 
2.55.0


