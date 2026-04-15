Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC07BFA0C32
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 05:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCtEb-0007Gi-8m; Wed, 15 Apr 2026 01:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2026041505460849760da85e000207cb-5jPIr4@rts-flowmailer.siemens.com>)
 id 1wCtEY-0007FO-4p
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 01:56:18 -0400
Received: from mta-65-225.siemens.flowmailer.net ([185.136.65.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-2026041505460849760da85e000207cb-5jPIr4@rts-flowmailer.siemens.com>)
 id 1wCtEW-000507-0o
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 01:56:17 -0400
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026041505460849760da85e000207cb for <qemu-devel@nongnu.org>;
 Wed, 15 Apr 2026 07:46:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ljlMNRxDeYe3LJA5qlN/A4oHLI+j+bfEkm76penXCXI=;
 b=ZY5x6augZl5yoNpVC6gEv3o+A2o9HVXu1K57XDFY1vTSNYG350Ufz3RxTDKeHYX8+N2L9e
 897KwQ3g9ow5AqsczW5JHvOBnWEWkwMWcPkjbcEqOOMwgWr/SFvwtexuxD3fxiawKtxf7ChJ
 4kZqGsbatEXsmQ/Zhwy1yzbF5OOm3BDQ1cLaLvVyCNNwVy6A9omaO+fteqMbpinRz87OtoxL
 sntRWl4OFmqgq/dVV+UpZikYWw97o5OTFB3dIchYZx3KblMq4giS5+MxmXTtm8ry3zIid0r0
 I8Pbh7YayTh5+Koxy04SfdpzLDU/HrxR73KkirdpMwsam/D0EXKlVxeQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 1/2] scripts: mkemmc.sh: Fix output pollution on missing images
Date: Wed, 15 Apr 2026 07:46:06 +0200
Message-ID: <b9d603b7396719f38e03cd969a4ac1b48f5ea96a.1776231967.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1776231967.git.jan.kiszka@siemens.com>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.65.225;
 envelope-from=fm-294854-2026041505460849760da85e000207cb-5jPIr4@rts-flowmailer.siemens.com;
 helo=mta-65-225.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Reorder the redirections so that the 2>/dev/null can actually take
effect.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/mkemmc.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
index 429388213c..3d8546cdaa 100755
--- a/scripts/mkemmc.sh
+++ b/scripts/mkemmc.sh
@@ -40,7 +40,7 @@ process_size() {
     alignment=$3
     image_arg=$4
     if [ "${image_arg#*:}" = "$image_arg"  ]; then
-        if ! size=$(wc -c < "$image_file" 2>/dev/null); then
+        if ! size=$(wc -c 2>/dev/null < "$image_file"); then
             echo "Missing $name image '$image_file'." >&2
             exit 1
         fi
@@ -102,7 +102,7 @@ check_truncation() {
     if [ "$image_file" = "/dev/zero" ]; then
         return
     fi
-    if ! actual_size=$(wc -c < "$image_file" 2>/dev/null); then
+    if ! actual_size=$(wc -c 2>/dev/null < "$image_file"); then
         echo "Missing image '$image_file'." >&2
         exit 1
     fi
-- 
2.47.3


