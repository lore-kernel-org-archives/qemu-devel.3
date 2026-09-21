Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC89C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lru-0006To-5q; Mon, 21 Sep 2026 17:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrr-0006RY-VG
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:07 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrq-0000Jq-9O
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:07 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso25345725e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027275; x=1790632075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WFV6HbxHc7vgsxQTiWX5y7npoYO7KlRYRwxtn2DPwzk=;
 b=Z6yvxA32aoWB90hepPEC1CIr07M/qmVH3qS85OVXdvPZjoO+pQRyIODKGkAWd+N/rU
 dAtWbxEr3m4wspLHp+pL8TSY3WSG2eTUWpeZ8T6fR6LyiaEjLqjmMFeTgz0GcF0TUXsp
 9y8noMbgmHOO51SblSJtUMGrouGtuDqfyshiUdN1nk/nlWMr9t63+hb/InjXzXl+5KOn
 J+Um4wiEbksGmZtYS7EUaM/WHES8uZLmUh3Ju0wpwibXSNGfaBM1xmgENwvzYVhTRQ8z
 CcwXzOcx1xvJk3rraDFKtmiKlD7rRiXyIJSUtd2Ii90IPmTEBZKMKa0XKsONuxWmhojj
 7FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027275; x=1790632075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WFV6HbxHc7vgsxQTiWX5y7npoYO7KlRYRwxtn2DPwzk=;
 b=PsZLHUecVf4+M8R3rWK9GlVj5MVNnxmja5f1su2fT6MGevUQAPm/Qz1SMKCVDe+liH
 v0Zpb8+5Dxs4dAL9FDlqeAvubTiRFg4yQ6MTCRYZ8ShH2kZyaRj8Qc9qnxRvuHQh1Idp
 tw9xvm6NRUUOtyjzswoXY1oOZkDSkLoAMEyGuP6wqrWHLHTfzwA3CwzvgaeJdfEOZ68p
 Fz6MboFLpNcrc1FE/oVR2Nap5hqBfMJ27+6ktwwXMW/SR04nhoC/IBl7bdjGEZG5BQAR
 DojC/2Yk8AEUcEYlXfw8oYhAnjZPQxyNfWswkGR6BayscWRZQgFNdUQb3lx7pz/yQTO5
 aYUA==
X-Gm-Message-State: AFuF++nlGIzgLCnDFU27vATbgO7H9cZncw8OtJ4luGmeouod6ZrxXB6x
 p4erYMyV38dwvJ/R65ohj3h7wnNbQr4nes4pgSTuGJh544UVJcu1z3GUhP0q1g==
X-Gm-Gg: AYBFou1zfMC23vbSIm+fQoqAHfKaY8Wk11ejnP3tfbci+TwhgE9puXtkPBTmBvYBfCm
 CgncruGCx37oKwZjNlSflUTwNTfAaAAUpBiND/EqBtvJhSO4LBtJ4eHUWKEwgjIVaQJDC5bE1uN
 8Hk39iTS4590t0csr/ymqohzeNkZP83c56NOBwNIWwP80oQwZD1pWSh7WZBQIXRMLOJ2XTQHU93
 oxhR5OI0OJRoO8Dq/Zl/lJmEqDYcwu6to0H/BJjZzwbN3izHjLdT1xSX/7vzZ+dPhhl9IExWWCu
 3CObRAlCn6jZEQy2T8dybJ5pm3lxbgOtWCl1JRZs6yXvg9Ig3ZVJ8CQKba9DYjTNEB5frVbZkZv
 /3E318vx1jCxDKILVOCWSFG08830NOeLd0dW/TmtBoc2Iz4oal61ENphMYKYNRTojDedWwktbVP
 O+M+0jempvgDY8tRi+x+x57wbx+Z5ZdhoG6jXtR31tMpX2XLlEtaAF/7MpvNxOaZ7REcbvCPTs3
 leeynAhGwEzTTCcUHZ2Ab24QTuqUEOWdX2bVlUSnIJJdl3bairxkGeqzJiE1OGilKyIrzp6y0qo
 0uE9M7ffKIBQqA==
X-Received: by 2002:a05:600c:1c20:b0:49f:bd3c:bc1c with SMTP id
 5b1f17b1804b1-49fc5739f3bmr188253705e9.23.1790027274892; 
 Mon, 21 Sep 2026 14:47:54 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:54 -0700 (PDT)
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
Subject: [PATCH 21/42] Kconfig: Extract config IMX_GPCV2 from config IMX
Date: Mon, 21 Sep 2026 23:46:49 +0200
Message-ID: <20260921214710.29422-22-shentey@gmail.com>
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_GPCV2 to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 2 ++
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0b8414501c..1ea4210ccb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -580,6 +580,7 @@ config FSL_IMX7
     select PCI
     select IMX
     select IMX_FEC
+    select IMX_GPCV2
     select IMX_I2C
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -661,6 +662,7 @@ config FSL_IMX6UL
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
+    select IMX_GPCV2
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 97355f9df7..98dba7efb8 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -8,6 +8,9 @@ config I8259
 config IMX_AVIC
     bool
 
+config IMX_GPCV2
+    bool
+
 config PL190
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 74d84b8ddc..2ac575095f 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -24,7 +24,7 @@ system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
 system_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
 system_ss.add(when: 'CONFIG_IMX_AVIC', if_true: files('imx_avic.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpcv2.c'))
+system_ss.add(when: 'CONFIG_IMX_GPCV2', if_true: files('imx_gpcv2.c'))
 system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'), if_false: files('ioapic-stub.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 system_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
-- 
2.55.0


