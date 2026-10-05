Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1374CA5FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfoK-000397-26; Mon, 05 Oct 2026 06:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmL-0002HG-8q
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:45 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmH-0000wJ-62
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:39 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so5852765e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195513; x=1791800313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b00qIVQjxzUez6mivBhAzHlvEuKBA7PieDHBj92W3ss=;
 b=quncPJLqy9/O9Lwc6jAKThGc8V9iN+xIb52c+4HG1vvbhi2MknElS58FOL0u8/sLOR
 mQu6fFR01oYeiXrXT1MVNKnx9MarrzvUSnhVBtorq6jE5qJ5F4kQNa9E1lmbbQiF/6X5
 +ZRArpjEHvLl7B0073aqWVaukHY3GhhpF2Hl5f/tm5bxZUHVQEp0if9hm9zV8QnxKGTU
 BpGOOYpZiVdWTmHCeNiUlZkKRO/xfd2FsGird4GyPQbcQSaeUdzjUEpJK50oEozRSyTi
 gQ4hjidm8qbfIJKlmjz6/aBNl8qiobCLpZn3CEG5JITQqBnoGDCB/E5yrzJycfAPQzRA
 TIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195513; x=1791800313;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b00qIVQjxzUez6mivBhAzHlvEuKBA7PieDHBj92W3ss=;
 b=d4QyvKBZ07eluRbtfFKoCmnPw44ItfogB9O5zm4hArtcwb4hBUhgStse7JiI6wfNJY
 2Uxw3rVh4wODhYdV0iYRU90lkGDSsFh2H3jEsXXsxU3bK1gNJbadjD5n6Y458YjCqx65
 HPeXWk7KdYVUV/6ylI2QhJ2J2maE9mQ29Ypn9u2uZwQ92S5rO1NCYPcsVfxFOgSJ2Ue0
 OY8lMLyRyOKIn40pmRbO4Dn/x6PezdB5Zp4eyyEU58CqaPO6JuitUiOoHD1Bw4jbkbuh
 cVhgLP8DFKozFEQBRLec31hpXYy2dOQO8it9pNzJgC8nW1BiPPnAwVkQL59HWdvlfBCz
 oPCg==
X-Gm-Message-State: AFuF++mO0IWL+IzwludTNkTalxEQN46PBTOF7fbTYqT4NtzLeXfhp1lj
 iGqMe01Ukioco65l7EbdnXJUeufd+u/Ywuh1e2NiFk0P1Dqju3wKIwHEQkGoxg==
X-Gm-Gg: AYBFou3Es5zhTfVcALV5/eGkr7qvhugyAArhnGrwzJkUJ6loa3V6ooqYg4kQVSIMLT8
 uYcAICZX333VbGMVLxcQRwoDQ86Zyt0git5f3UDnco55JdNBiQ7qrh9fZcVYvcokeS4BCoe4B8l
 iNAKkPKk2FWhwgpTn2MN6ih7v251nwHZoksZN64mYCQpQ+zvuVwXv4nAPiv/cAQ+eqaXEKCJ3xL
 9oSd9EpjXcuyX9f3mP/BaAq+eMjyg5rMQwC7inORgF6Uss6Ayw/Uxp0r83liC+2PuE/jqD0jCBZ
 qlDjUs4RD5f4jPpxmIRaZjfvVP7C/9+oaPXu6/cSjBw9p5OG7BIUkh50T0yoRL6xV+ugRQ6iWSZ
 BGislSHjElpEbNbrhPw451nHcKAGkKukynNRc03lQNjplzuz9SxBl/lBCnX//f8HGLu+Hf7tlG4
 zdph8lAfkbOgtgB/Bm7997Yjf+Grf98/aBiJ0pEdhDcBmosSHVNfS2y3EZlNO77b3kYI046O+5k
 cKgbxXnP3IcyR1hzaUwRltjzi8Zm/i/V01veNNQ0Ti53S3W
X-Received: by 2002:a05:600c:190d:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a02753fc8emr175863735e9.8.1791195512760; 
 Mon, 05 Oct 2026 03:18:32 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:31 -0700 (PDT)
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
Subject: [PATCH v3 07/31] hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by
 default
Date: Mon,  5 Oct 2026 12:17:34 +0200
Message-ID: <20261005101800.10821-8-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
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

Having four CPUs and 1 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone. Also
reflect this in the board documentation.

To reproduce the old default behavior for e.g. migration purposes,
`-smp 1 -m 128M` needs to be passed on the command line.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/sabrelite.rst | 4 ++--
 hw/arm/sabrelite.c            | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/sabrelite.rst b/docs/system/arm/sabrelite.rst
index d3a3c01dd6..b8ac9548f5 100644
--- a/docs/system/arm/sabrelite.rst
+++ b/docs/system/arm/sabrelite.rst
@@ -55,7 +55,7 @@ To boot the newly built Linux kernel in QEMU with the SABRE Lite machine, use:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -M sabrelite -smp 4 -m 1G \
+  $ qemu-system-arm -M sabrelite \
       -display none -serial null -serial stdio \
       -kernel arch/arm/boot/zImage \
       -dtb arch/arm/boot/dts/imx6q-sabrelite.dtb \
@@ -89,7 +89,7 @@ the -kernel argument, along with an SD card image with rootfs:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -M sabrelite -smp 4 -m 1G \
+  $ qemu-system-arm -M sabrelite \
       -display none -serial null -serial stdio \
       -kernel u-boot
 
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 05dfabd937..34f302f83c 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -17,6 +17,7 @@
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "system/qtest.h"
 
 struct SabreliteMachineState {
@@ -139,7 +140,9 @@ static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
     mc->init = sabrelite_init;
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
+    mc->default_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sabrelite.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.56.0


