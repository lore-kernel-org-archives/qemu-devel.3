Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC5606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=V6/B1AbT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp3m-0005f3-5m; Fri, 27 Nov 2026 01:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1p-0003gS-Il; Fri, 27 Nov 2026 01:01:50 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp1m-0008I9-45; Fri, 27 Nov 2026 01:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=6ihIP8ykGmN5Nteu+2pV2lexXDAjzcfmNl/BrF5E1n4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V6/B1AbTCrx7ZPVbjkal2gr5Hd7HSm89bizGjJjlrb2ANtWSfFBAKSqbv73H82LEE
 Iy8/y/nU1vjiIk+Vj8OxrCzrcdjCgHXNCLToZnyWxHVOcmMFSRwrpL7qykq/UBO/w4
 R/fqwR8JrW2cOpAOlhElSj81HGqdFaxNRleXpFxf1YTjwl7mzFuNJiMF8Aw3+OTY+M
 dsX5nlzY8OJYEy7Dk0K9NqG/BmSSiJPThofyIk3sRtcmGvfS4AxU4lMGFMruMusOlx
 9+qrXIu6y/+sDWVD/v97jKl68PUe7VL72sMVf0J0BHA2iLVNujDZB1r1msuJypWPlU
 RMq2OyeBglPrQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D957A1EA312;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D7231469952;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AC2FACF2A4; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 135/140] hw/display/vmware-vga: Check incoming
 migration width and height
Date: Fri, 27 Nov 2026 08:54:01 +0300
Message-ID: <20261127055421.39015-76-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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

The vmware-vga code sanitizes the screen width and height when the
guest tries to set them.  Apply similar checks on the incoming
migration data.  This prevents a manipulated migration stream from
being able to cause us to create a surface that exceeds the size of
vram.

Since we already put in a check against creating a surface that
is too large, the checks here are for:
 * ruling out a negative width and height
 * catching the issue and failing migration rather than letting
   it pass and then coping with the out-of-range values later

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3870
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124095719.4126146-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 808365500e6697b1ee6673dcdb17e56c2fddbede)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index e80338246cf..51f6ef2cff4 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1210,6 +1210,11 @@ static int vmsvga_post_load(void *opaque, int version_id)
 {
     struct vmsvga_state_s *s = opaque;
 
+    if (s->new_width < 0 || s->new_width > SVGA_MAX_WIDTH ||
+        s->new_height < 0 || s->new_height > SVGA_MAX_HEIGHT) {
+        return -1;
+    }
+
     s->invalidated = 1;
     if (s->config) {
         s->fifo = (uint32_t *) s->fifo_ptr;
-- 
2.47.3


