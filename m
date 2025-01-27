Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA37C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 12:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcOHN-00049T-LI; Mon, 27 Jan 2025 07:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcOGt-00041X-53
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 07:31:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcOGr-0003MO-C4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 07:31:18 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso30560035e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737981075; x=1738585875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KSwYm9Ifvrp3w/cECG9Gy3rSjhlrv0zcjhWArVvCSig=;
 b=EfUFLFQ2TC9YW1K/ijIvCWWl0pUxa7X5P5DpAT9xuN4y5G5Ys1wEd3Tq7XZVRBS3Ow
 eEa6pFt391O5PvoCM9KGf2Vb1/FBqKUtoUsYqBzUMJOfVAr6EBkEb/ZweyJCMCyWh6V2
 ncDHvHoET0TSOXbOxwzhs31/g5Q9EM8Eowfw5R3clXo1O3RSAMwbffdyBh+LO2O2nnxl
 G+gJr/rq0+uqHnCvu+DHHIvTchLAbmi6XhziuF3XKATW82slSWk54OFKmeBqmqqZwsVt
 /+gNWGB2vt/Qx37FFx8fLVEyzjpIWgcKJ/i/p8IIQ91ZfwhRdzPPQSjCrqtOS+E+2Pc8
 VOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737981075; x=1738585875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSwYm9Ifvrp3w/cECG9Gy3rSjhlrv0zcjhWArVvCSig=;
 b=kUWMg9frI4ii01WDTJ1LIgfR00dIsdGFbMaWmY0brAezy4aDVXyoHBU8BedlpJHDwc
 1cyuOdeWJ6ZZgsmzWPLl88Ctu258h7mu9T2fDygsdLOblZvA66ocA25gVIDpfR4nq2kL
 WM8lYezxlmbWgGVT486ZXx596WpfyOZ1f1ehRphwkcBMkY77Z6SOIDejyu95LAfJuTRc
 78zI4i1nwipIl3jtlH4+5o+xU2/6qoYgAFzlFv2LLa3dARBlg1UwGrYreuRNd7NQZJG3
 T90+iTI5XquWY8vUf60CpCfs3vRYADWCG2pxIA5ofgJ0wlyrIYdyj9iJSlNfxi8lleYI
 RuRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQagtswAPmUdEtbL5BpaeJWULJYtXNRhy69tsscywVC2tehEvxtrgy+VYwIjr8rTitxSjmRR4xqJ78@nongnu.org
X-Gm-Message-State: AOJu0YwLzKrf2p5bLNM+Q6y/MgXRZUOcQF3AZtpFtJ+zS/l9LU+gesRt
 0bWOS4A/7wOea5XuMmdg3xIp24n1kkNmlKIxe58oHqhVAdPdOU1rA2EzSHqhCls=
X-Gm-Gg: ASbGncu99eTnlrdwHm/pmjnFeKK+DaxbeU9dnjtwhM9ZCWeDX48sc479BLz1TJmW/c3
 kiMT9lv6R2taJcaewkivvR2WMnHZQBT+vIJ44hlNm4vU4jjnAGr/BRPGvBx6kxLati/GpFS6njW
 ts+f0Evy474fbjVF2WKZxpQMkag7by1bvf8V+G2kk8XS3XOTmk5vkb7RGIP0eMFIoF2dXykHBbd
 a8KxcEEL9+7ewJTbxkOT17+i1aL5V33y/AZDzDWtQQ+gQzWc9222UAHfKtpjkBY+KZ6xYHptF4T
 z5k9GzJPeg==
X-Google-Smtp-Source: AGHT+IHxEvC1D1UUTu26xAWuzJiUvw5hk4nIKkBi+PJs3DH+w6tVD6vveRkbHdY8fnQb4QCNRx1QzQ==
X-Received: by 2002:a05:600c:1e8b:b0:434:f609:1af7 with SMTP id
 5b1f17b1804b1-438913bf885mr386127875e9.4.1737981075421; 
 Mon, 27 Jan 2025 04:31:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4857b8sm129052505e9.15.2025.01.27.04.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 04:31:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] qemu-options: Deprecate -old-param command line option
Date: Mon, 27 Jan 2025 12:31:13 +0000
Message-Id: <20250127123113.2947620-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The '-old-param' command line option is specific to Arm targets; it
is very briefly documented as "old param mode".  What this option
actually does is change the behaviour when directly booting a guest
kernel, so that command line arguments are passed to the kernel using
the extremely old "param_struct" ABI, rather than the newer ATAGS or
even newer DTB mechanisms.

This support was added back in 2007 to support an old vendor kernel
on the akita/terrier board types:
 https://mail.gnu.org/archive/html/qemu-devel/2007-07/msg00344.html
Even then, it was an out-of-date mechanism from the kernel's
point of view -- the kernel has had a comment since 2001 marking
it as deprecated. As of mid-2024, the kernel only retained
param_struct support for the RiscPC and Footbridge platforms:
 https://lore.kernel.org/linux-arm-kernel/2831c5a6-cfbf-4fe0-b51c-0396e5b0aeb7@app.fastmail.com/

None of the board types QEMU supports need param_struct support;
mark this option as deprecated.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 system/vl.c               |  1 +
 2 files changed, 14 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 29de49351d1..a4c7d642236 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -68,6 +68,19 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
+``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``-old-param`` command line option is specific to Arm targets:
+it is used when directly booting a guest kernel to pass it the
+command line and other information via the old ``param_struct`` ABI,
+rather than the newer ATAGS or DTB mechanisms. This option was only
+ever needed to support ancient kernels on some old board types
+like the ``akita`` or ``terrier``; it has been deprecated in the
+kernel since 2001. None of the board types QEMU supports need
+``param_struct`` support, so this option has been deprecated and will
+be removed in a future QEMU version.
+
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/system/vl.c b/system/vl.c
index c5678267182..32ee1ce7041 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3438,6 +3438,7 @@ void qemu_init(int argc, char **argv)
                 nb_prom_envs++;
                 break;
             case QEMU_OPTION_old_param:
+                warn_report("-old-param is deprecated");
                 old_param = 1;
                 break;
             case QEMU_OPTION_rtc:
-- 
2.34.1


