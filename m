Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4E606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=hFOasD9L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpCz-00019W-8Y; Fri, 27 Nov 2026 01:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAu-0007NQ-Lk; Fri, 27 Nov 2026 01:11:12 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWpAs-0000LI-9Y; Fri, 27 Nov 2026 01:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=977kz/5jxrSPY3ZKj7bjkh7b/Wf55QSqJGzB69PqNAQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hFOasD9Lstoj8QLAM/CWKaq8yTK1hy/mJfWkQ/yeZelLpqDig5N5+t1WbAawd7zLY
 d5XDuKsLIWN5nLLSoZDLfZUp+brDtAprpFLzlR5TWZU7U3leqHtCVrqlAIuBAxXi1F
 QEGk84Mr+c31JbuNd5TZETX9JiRfrZhyw7k8tV7gJK8DAcz/fmJA5xc9iwwYCHJ0wu
 qLx6TdP05nKvztAJAVHQ1S4Y9t8MpFZ9Y7QqghCIiCuya5eOxO8XsaNuefeiXwFinj
 F/gtawlxfiXEu1Vc9hw/xjBXOKhiBtCtH1A5r6CkO3pbizuuK3UwGeXsc3VkoZoscY
 Lb9vNGRR/oakw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B66081EA384;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B3C9E4699AF;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8CD4BCF356; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 146/152] hw/display/vmware_vga: Reject attempts to
 set resolution outside VRAM size
Date: Fri, 27 Nov 2026 08:54:44 +0300
Message-ID: <20261127055709.39630-83-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The vmware_vga device limits the maximum width and height of the
screen, but the maximum total resolution those limits allow (2368 x
1770) can be too large for the configured VRAM size, if the user has
set that to something smaller than the 16MB default.  We don't check
that, so we will set up a display surface bigger than the backing
VRAM and QEMU will crash when we try to draw it.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4898
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124095719.4126146-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 555c5af38c76cae5b68d648095367ddb9afc65a4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 353cef408d2..d4fff461981 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1136,6 +1136,11 @@ static inline void vmsvga_check_size(struct vmsvga_state_s *s)
         pixman_format_code_t format =
             qemu_default_pixman_format(s->new_depth, true);
         trace_vmware_setmode(s->new_width, s->new_height, s->new_depth);
+
+        /* Ignore attempts to set a resolution too large for the VRAM */
+        if ((uint64_t)s->new_height * stride > s->vga.vram_size) {
+            return;
+        }
         surface = qemu_create_displaysurface_from(s->new_width, s->new_height,
                                                   format, stride,
                                                   s->vga.vram_ptr);
-- 
2.47.3


