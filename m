Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A52CDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKtE-00030k-Uo; Wed, 24 Jun 2026 06:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsm-0002aD-M9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:31:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsf-0007gn-Q8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:30:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso522468f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782297052; x=1782901852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcUw6dVic7iy+SWHCEsbAuTBlDckpX0jLlbUXwwqlgE=;
 b=OflgeGwOul8KzEpstnsoUCL7wtYgLf/Z/rqIUzxNf9mmqXHU86tcq11MfhyUCubB+n
 nMo4ZGVMUcfzIbqTrp6MAuT/JPufp8Glf+V/XaAzBu1wNNYnKaj6osakNwLwkvTfldgZ
 bxh2RpjsfjWAjI1n4MlxO0lFDA8Y/jFNParsoeX7Htu/8wqcvOs8AowQeU3Z+DGRKQFw
 EB+2SQVwcJTjn3LEVm6CBBlPMDdSOABJbI4PR6XQ4O8ps2MeDFTCmE9oCayjzBp2UNnG
 dSCbqD3Aez7+PyZSJKpUxlIL4AqiYBfs9bS+5ea0W7399e9CZ9YWR+h4N1SoyS5IWnEs
 q+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297052; x=1782901852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JcUw6dVic7iy+SWHCEsbAuTBlDckpX0jLlbUXwwqlgE=;
 b=iJyv0uC4tDB6q2c0XRoGDPni/AAfmzjeTTkkleER7nKLUklMN1tTylgRpdGqiiU1q7
 STaHydG0vTURShrDuw9+GPs9GdXrL5KkZeCv4GbTx1fvU9UM/ot1sbv/Y4LorWnxqaAG
 HXiKgYhAmqjLpH5wCHEtQlVxI8DtqCreBHu//MuASiZRAL6aY7O2UVu8yAd+Uo2F5QVw
 rt8QLu+OcP5Y/L9952JkQD73INN52nxYfuFxtlCQ352Qe/+83gC964TeMpQ1i8BuMjpi
 PcmETnRG7vxX+ZST3GKfDK01Dlo09ixvW1i/MhOz/LJgor0JwMwpooLutFiFUHViGEGm
 zOiQ==
X-Gm-Message-State: AOJu0YxpGE/8hdM0P7VuHD2qSlPl1JN5NnQmPwr+3u8xcYwsOhsqEHhS
 lzNbpvffzC31b1G4EvYbaHKxKhybG5GBAJ2Z5Tt60ZHmSW/ja1rvacVRx8B5lEczFuk=
X-Gm-Gg: AfdE7cnP6X6lsUUu7SV95ciFFHS+9MUI6nrUeYgFKQxiT/Q20q7GpTKxx1++ng2VcOy
 /z0BW/7hHyDmANpfEQw7kxZar+t1W+PZvjYdU7R49jmQ8Q+cvuWEvFKMhsKNXFKnh5272OHJh54
 MQ7WqCYVejFaO28BHpAUfOo3fEfdBUd53YyGW2DBigOZVzfDfhkPAyF6yDIlJCejGJNuvPb9Dpl
 kC+cih7+x3O7nou4og8CQzvoDuX4NL6IG3kNHT6Uv50RezBnUsJMBRJm/gkg5Z64lyH5n67leZh
 VD8OzakYYstMJa1sqZexV8UXopwwnV8DBRpSUi1fmyGWyAVUYCQmGBp3vBEar+cubhzhdHwftqX
 x5MSfRmVl2lA00S0q+a+XqllV8v5VNADVTVkLZmzCOZxEfq/l6NGiF0G/GtZzFV4blB4GbEenlS
 O1G/zcTobvkMXC
X-Received: by 2002:a05:6000:1789:b0:46c:dc80:7627 with SMTP id
 ffacd0b85a97d-46cdc8077admr574890f8f.26.1782297052187; 
 Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm5827376f8f.9.2026.06.24.03.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:30:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE8655F8E5;
 Wed, 24 Jun 2026 11:30:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v9 2/7] tests/functional: update anacapa-bmc image
Date: Wed, 24 Jun 2026 11:30:44 +0100
Message-ID: <20260624103049.884930-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

The initial version had the wrong DTB which caused issues with image
corruption [1]. Update to the latest version.

[1] https://github.com/legoater/qemu-aspeed-boot/pull/7

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/arm/test_aspeed_anacapa.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index 27f8bd8b56a..b16c6035c95 100644
--- a/tests/functional/arm/test_aspeed_anacapa.py
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -11,8 +11,8 @@
 class AnacapaMachine(FacebookAspeedTest):
 
     ASSET_ANACAPA_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
-        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
+        'de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4')
 
     def test_arm_ast2600_anacapa_openbmc(self):
         image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
-- 
2.47.3


