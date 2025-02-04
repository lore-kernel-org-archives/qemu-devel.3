Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D83BC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 22:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQyV-0001MU-TV; Tue, 04 Feb 2025 17:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1tfPGu-0004If-SO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:11:49 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1tfPGt-0006qq-5A
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:11:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D4C79A42D98;
 Tue,  4 Feb 2025 20:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A85CEC4CEE2;
 Tue,  4 Feb 2025 20:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738699894;
 bh=n903QA//BBYKpY4cOT1+2ldqqv5Gmu9LPXH4tfYVe+M=;
 h=From:Date:Subject:To:Cc:From;
 b=X0cVKyykFPgFYOo3dDvgLfl5FNFub693RuAPV7nu4GVgs69DHHeA//1TwN2ccEtZ3
 qlPJVeDhw6yqm96CGKUQttH441T8X4ppwZfWhXehCPrkDA4pTQgYts8E/TkFMn3YTF
 VCaZQgfgTQeFRwhXCSCZFjKj2zDzRoPeJ/4w3BOBHeYKtm8Pdhr+dRLat6X32H7vxD
 ald5SqILyBWvtX50q1Sreyf65Z4VSmfixruVxUH6H/YgCu+kG29v5P68ot55u7+2rR
 ZZepapIsRtZUa6JGwiCES3wxYliBzj3gHdj9mU6a+m6lhpoFHAV1m5nB65WszefBTD
 SXXZuzGElOsEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDC7C02193;
 Tue,  4 Feb 2025 20:11:34 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 04 Feb 2025 21:10:34 +0100
Subject: [PATCH] build: Replace meson introspection argument with a
 builddir
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-jag-fix_meson-v1-1-ecb6bdb1db51@kernel.org>
X-B4-Tracking: v=1; b=H4sIADl0omcC/x2MWwqAIBAAryL7neDzo64SEZabbZCGQgTS3ZM+h
 2GmQsFMWGBgFTLeVCjFBrJjsO4uBuTkG4MSygolDD9c4Bs984klRW60X4xXvdDSQmuujE3+v3F
 63w/xCzuaXwAAAA==
X-Change-ID: 20250204-jag-fix_meson-43db4d290315
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.15-dev-64da2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=n903QA//BBYKpY4cOT1+2ldqqv5Gmu9LPXH4tfYVe+M=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGeidEdVR4Y+ouemPf1zTZjEMaNRJFn89bnt4
 dgnUdtMIAj4A4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnonRHAAoJELqXzVK3
 lkFPuDUL/3uPcT7NKjoHmxwSq470mQp0rmGM0CqaKYBCZWBSJxdaQw6uhViGUT1C8PXWp/kWY+O
 tEtyUyhiD5V3HIc5i7X8bveN4A+potmEJaJ2LWf8sIJcMWFPlENh2wOzk1DpGRy0Y/8c1Y0B4Wv
 fJteBBO9XAICnim88PhzpXkt9ia0KeNHKrbq7nhE2p2WXDjIB4wCrUyR1tM55A4FTKTLoxDP3nh
 qJLgK2VRbJOkuRx4UfTl0VYfQiar5UT/9m60YXg4/ueighvMAOUhbt4JoRlrRjZ6OIBil8x6y5D
 W21VwLubidLzKf5MiZDlo8T260HqhklvaDh+WGSdC8hd96Q5exgKjC1FCiUzkPyzlaqQsMP48ta
 QY5Gt+HbPbK5NUSCBJ/3kAkwi2rL7Da3vYcU4n7Q2/zuKwbQh5KAJ2VcLF4MJLUgMMYyTv0rTy0
 8Cvza78hO4HNoZyg1c3yR4ipwtxExlQQb/fm9UKcG+Gd5bG73T6AhlXON1peDDiYxBj3kajTEU7
 HA=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=joel.granados@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Feb 2025 17:00:37 -0500
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

Replace the meson introspect argument with the build directory instead
of the meson.build file. The introspect command accepts an optional
build directory not a file.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
For some reason this causes an error when I "remote" compile qemu.
In any case, the introspect only accepts directories, so having it point
the to the meson.build file is a mistake.

Comments are greatly appreciated
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b65b0bd41a..da88d9bb31 100644
--- a/Makefile
+++ b/Makefile
@@ -129,7 +129,7 @@ Makefile.mtest: build.ninja scripts/mtest2make.py
 .PHONY: update-buildoptions
 all update-buildoptions: $(SRC_PATH)/scripts/meson-buildoptions.sh
 $(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt
-	$(MESON) introspect --buildoptions $(SRC_PATH)/meson.build | $(PYTHON) \
+	$(MESON) introspect --buildoptions $(BUILD_DIR) | $(PYTHON) \
 	  scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
 endif
 

---
base-commit: d922088eb4ba6bc31a99f17b32cf75e59dd306cd
change-id: 20250204-jag-fix_meson-43db4d290315

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



