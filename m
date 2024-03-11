Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F71CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkxh-00057p-Us; Mon, 11 Mar 2024 15:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjkxZ-0004xZ-QV
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:05:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjkxN-00076a-Om
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:05:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33e93514a6aso929470f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710183903; x=1710788703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aBu6Z/9NiuMN0S4Fo9aAmP5R+cJTYf431HkrmOHAp2Q=;
 b=iSfBcGmmXNRwvG576+jJVSPn5cLDEPrpxEbW6172KDAYrlGYABez1nTkcHSrK01ccm
 lf+cGQcd7OimZpNF2FD5p77oYqxl3GawFJn0LYOf8HCw81ygP+itW23+ZVJdNdNdrEdI
 aPsYAz/m27V24Jbus2Ot9VDeM10BIZp64+6Sv1K/LWeLTzAPaRAcGBRakyhmVoCGuCZL
 Jjrcdp7AKBI9Btkxk83eRKuNJOgC1IrbALjFzZPULgh4EY+oKbyF7W0YlUHRHDOlI9mr
 D7ohWRFrODwqtH8yLhxT2ufTTcGf6aQTypZe0hCiBpNOX9wazJGXa3gVws0Bsd0P4qTy
 FfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183903; x=1710788703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aBu6Z/9NiuMN0S4Fo9aAmP5R+cJTYf431HkrmOHAp2Q=;
 b=mMaqBoEzrKHO4Gxd29XX4KrUky4pS9KnU3iGA130/oG69ICre7sEkVRZ/6XcoBVYWe
 +Z0J00PLKNX77ACflUOAndtQTAZIov8Is1X3xeQk82Qa9no/Xsrw+vjey4vuTjKUxPpJ
 TNe/06pnnmEAIN3hCpP/Ok2Cp2YIQtBD/pxOP+ZT87aBCflTkOB1ycnzUtUF0UKlJXLr
 W9JvfUQu+9KDLZBWDw3R18X1f91G4xDgorxwRcaNSFF9EkEfZ+IPcj8qvhedmdQRCNxF
 +FclIAyw8V3K9dg2ak8sZP+k5qp5DHXwvGQDzbArN5im4xIBq62A3diWgpTYcMq1WhBd
 /WoA==
X-Gm-Message-State: AOJu0YyXza1I+zUOFFb+kCZe8CEJe3j9lwzSre41nF0r9e/QsTq7nIkB
 9KpfnD+xMny9wa2zUPp2wktf7GMdxXoAVW7a/u2amKirFjwalZ8yG+qygHSUwnTBdtwOJD8cXFR
 P
X-Google-Smtp-Source: AGHT+IGZjKPMo1dg4RxKgCog2zkJ16EJHJE8chv8ghZgBBASj7YIgXzjM70NVkc4NyjnuTaY4Onpig==
X-Received: by 2002:a5d:45c5:0:b0:33e:790f:5f83 with SMTP id
 b5-20020a5d45c5000000b0033e790f5f83mr5066012wrs.47.1710183902817; 
 Mon, 11 Mar 2024 12:05:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 r13-20020adff10d000000b0033b278cf5fesm7053712wro.102.2024.03.11.12.05.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Mar 2024 12:05:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, devel@lists.libvirt.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0] docs: Deprecate the pseries-2.12 machines
Date: Mon, 11 Mar 2024 20:04:59 +0100
Message-ID: <20240311190459.66334-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

pSeries machines before 3.0 have complex migration back
compatibility code we'd like to get ride of. The last
one is 2.12, which is 6 years old. We just deprecated up
to the 2.11 machine in commit 1392617d35 ("spapr: Tag
pseries-2.1 - 2.11 machines as deprecated").
Take to opportunity to also deprecate the 2.12 machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
In 2025 I'd like to get ride of the code related to:

  include/hw/ppc/spapr_cpu_core.h:31:    bool pre_3_0_migration; /* older machine don't know about SpaprCpuState */
---
 docs/about/deprecated.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dfd681cd02..65111513cc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -237,13 +237,13 @@ The Nios II architecture is orphan.
 The machine is no longer in existence and has been long unmaintained
 in QEMU. This also holds for the TC51828 16MiB flash that it uses.
 
-``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
+``pseries-2.1`` up to ``pseries-2.12`` (since 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''
 
-Older pseries machines before version 2.12 have undergone many changes
+Older pseries machines before version 3.0 have undergone many changes
 to correct issues, mostly regarding migration compatibility. These are
 no longer maintained and removing them will make the code easier to
-read and maintain. Use versions 2.12 and above as a replacement.
+read and maintain. Use versions 3.0 and above as a replacement.
 
 Backend options
 ---------------
-- 
2.41.0


