Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D61C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVXv-0005QY-2j; Fri, 07 Feb 2025 16:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXs-0005PR-R5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:52 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXr-0001sy-7c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A54A1A412EE;
 Fri,  7 Feb 2025 21:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DF6C4CEE2;
 Fri,  7 Feb 2025 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738962348;
 bh=QWn+5N4g5u8cXEzZBEZLJId0H4Oo0w+wMEM3Jyb6RQs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ea7Au125xzICaVdKFzSd2ZZZjeNM4gIYjkl54pyWUcSLhV9nKhtgdXXU3pCe5Nf4N
 N7yjgJdqGTLAkCsP3lauYG79KWb37N0UpUxbz8Oyf65OiaiGTvUtMeDuU+KkJrVaEt
 ICs8mFVmkJUxK77pn3bygE//5VtdXi2/Ky6mGrE7zNSM07GPb4+WAx9w5JuOthGm2r
 wl1UZVegXD1gPicKJ7PQuy1Sj3eHD1Ii9SdqkbRj3VVTcChjEYE28eHQnp1PcEMpcX
 4ZBIGN71X4/ILHicvNY7ADsXfNe60wOZQZyMC8e4rfgEkwm8V3oXL/rUhE1U3QYV0A
 OQ9cYjzjt5ksA==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 3/6] artist: Allow disabling artist on command line
Date: Fri,  7 Feb 2025 22:05:37 +0100
Message-ID: <20250207210540.24594-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250207210540.24594-1-deller@kernel.org>
References: <20250207210540.24594-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Allow users to disable the artist graphic card on the command line
with the option "-global artist.disable=true".
This change allows to use other graphic cards when using Linux, e.g.
by adding "-device ati-vga".

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/display/artist.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 8b719b11ed..f24c1d83dd 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -48,6 +48,7 @@ struct ARTISTState {
 
     struct vram_buffer vram_buffer[16];
 
+    bool disable;
     uint16_t width;
     uint16_t height;
     uint16_t depth;
@@ -1211,8 +1212,8 @@ static uint64_t artist_reg_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case 0x380004:
-        /* 0x02000000 Buserror */
-        val = 0x6dc20006;
+        /* magic number detected by SeaBIOS-hppa */
+        val = s->disable ? 0 : 0x6dc20006;
         break;
 
     default:
@@ -1432,7 +1433,7 @@ static int vmstate_artist_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_artist = {
     .name = "artist",
-    .version_id = 2,
+    .version_id = 3,
     .minimum_version_id = 2,
     .post_load = vmstate_artist_post_load,
     .fields = (const VMStateField[]) {
@@ -1470,6 +1471,7 @@ static const VMStateDescription vmstate_artist = {
         VMSTATE_UINT32(font_write1, ARTISTState),
         VMSTATE_UINT32(font_write2, ARTISTState),
         VMSTATE_UINT32(font_write_pos_y, ARTISTState),
+        VMSTATE_BOOL(disable, ARTISTState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -1478,6 +1480,7 @@ static const Property artist_properties[] = {
     DEFINE_PROP_UINT16("width",        ARTISTState, width, 1280),
     DEFINE_PROP_UINT16("height",       ARTISTState, height, 1024),
     DEFINE_PROP_UINT16("depth",        ARTISTState, depth, 8),
+    DEFINE_PROP_BOOL("disable",        ARTISTState, disable, false),
 };
 
 static void artist_reset(DeviceState *qdev)
-- 
2.47.0


