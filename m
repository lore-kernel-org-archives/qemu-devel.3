Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EB2C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6leG-0007g8-V5; Wed, 16 Sep 2026 05:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6leE-0007UH-Vd; Wed, 16 Sep 2026 05:09:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6leD-0007Vh-2m; Wed, 16 Sep 2026 05:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=4BAAZ5J13oAfcQOn4licbUGM9NvyUpA3Ch790R8g+pM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qHOQpOihymrkwdHGWFTjXijBTG3I+wUaAMc83Owd5jb1hUNHxt0SRbSSG1Qjn4oBM
 n8A6U9DpkFJwleJlZHq82Fi33iMIvGYhU14LvUzw3IOjwM0rsjsEsOvpBdRNQLa1Ix
 /sk7v4RxjYhpwE8S0e9AKHQB2KwmI3EwhYhHSu4oMvO4hFphukbReiq3rOQl2UFnSu
 BDWcGpAt7Zbq1M8eWknatugi0u+ZLV02MO1cHx4lpVk9CAtfvy7v96Lo/sjy8vMk1r
 74t8XgGq+Q/eLYyJ3P7r7UkeKSzyDUBoTGkOIpoPeagi5xFa8REx/7vhtPhgfvJPz5
 RoA6wIJ8OT37w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2ED2E1D56DF;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CE773429E3B;
 Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C68DE5A7AD; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 42/57] hw/cxl: Fix guest-triggerable QEMU exit on
 reserved interleave ways
Date: Wed, 16 Sep 2026 12:04:06 +0300
Message-ID: <20260916090516.677749-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Junjie Cao <junjie.cao@intel.com>

A buggy or malicious guest can program a committed HDM decoder with a
reserved Interleave Ways encoding (e.g. 0x5-0x7, 0xb-0xf).  Two call
sites pass &error_fatal to cxl_interleave_ways_dec(), which calls
exit(1) on the reserved encoding before the subsequent decoded_iw == 0
guards can run:

  - cxl-host.c update_non_interleaved(): called at commit time from
    hdm_decoder_commit() via cfmws_update_non_interleaved(), so a guest
    writing COMMIT with a reserved IW terminates QEMU immediately.  This
    is the primary trigger on the current tree.

  - cxl_type3.c cxl_type3_dpa(): called on memory access while iterating
    past committed decoders to accumulate dpa_base.  Once the commit-time
    exit is removed, the decoder stays committed with the reserved
    encoding, so a later guest access outside that decoder's range would
    otherwise hit this second &error_fatal; both are fixed here.

Pass NULL instead of &error_fatal at both sites so that the reserved
encoding returns zero and the existing guards handle it gracefully.

This can be reproduced by writing the HDM Decoder 0 Control register
with a reserved IW encoding and the COMMIT bit set (e.g. IW=0x5,
COMMIT=1).

Cc: qemu-stable@nongnu.org
Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Fixes: 48461825af1b ("hw/mem/cxl_type3: Fix potential divide by zero reported by coverity")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260618104316.557306-1-junjie.cao@intel.com>
(cherry picked from commit 713e7e85a2b43e9d4e58d91643aef230d2c30b07)
(Mjt: drop changes to hw/cxl/cxl-host.c for code introduced in
 v11.0.0-1291-g680935c9a6ff "hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e39a85cde8e..91db48570d2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1196,7 +1196,7 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
         }
         if (((uint64_t)host_addr < decoder_base) ||
             (hpa_offset >= decoder_size)) {
-            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
+            int decoded_iw = cxl_interleave_ways_dec(iw, NULL);
 
             if (decoded_iw == 0) {
                 return false;
-- 
2.47.3


