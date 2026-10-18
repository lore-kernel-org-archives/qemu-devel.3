Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C208CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 20:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIXok-0006Ew-Qm; Sun, 18 Oct 2026 16:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xIXoh-0006EU-MQ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 16:49:16 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xIXof-0004zM-R8
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 16:49:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 4B868A021A;
 Sun, 18 Oct 2026 22:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792356551; bh=MyMx0oB7W58eUOjX+EmVHV1XlyBThltay5mQtEP3Rak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mnDH6dVLwOM76Gbw6YPC+mjHcZEprv4aOs3nGYosgjdQgGZgAT4Mi+tfJrI5plN0M
 x7T1yu4/xeqcsmSU3sttPJshNDncKuAOZ85hyj2Sps6/Yn9RJtLd69B9vohzoLxrXN
 MbDhtJLoq1aV9HlYJFyoojA0phJ1sUidQLyi/kniSIiKf8gFBrgovvlgKZAsB5rJ8X
 wb3wzGEuuXjxMHgTLFIIte9L0PwP3NMkThaOQRlsu5/qCA5L22yYylqDDxZByloeD/
 Wyqi0+NTzii1mUX7eAklil0LOTwDREq3OT6XU/rKoj8RKPIdA9HVEbbNmmfEtOI0b3
 NXIBfDMXLVs4g==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I8YbGj6jQMC4; Sun, 18 Oct 2026 22:49:11 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 1AEF8A0185;
 Sun, 18 Oct 2026 22:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792356551; bh=MyMx0oB7W58eUOjX+EmVHV1XlyBThltay5mQtEP3Rak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mnDH6dVLwOM76Gbw6YPC+mjHcZEprv4aOs3nGYosgjdQgGZgAT4Mi+tfJrI5plN0M
 x7T1yu4/xeqcsmSU3sttPJshNDncKuAOZ85hyj2Sps6/Yn9RJtLd69B9vohzoLxrXN
 MbDhtJLoq1aV9HlYJFyoojA0phJ1sUidQLyi/kniSIiKf8gFBrgovvlgKZAsB5rJ8X
 wb3wzGEuuXjxMHgTLFIIte9L0PwP3NMkThaOQRlsu5/qCA5L22yYylqDDxZByloeD/
 Wyqi0+NTzii1mUX7eAklil0LOTwDREq3OT6XU/rKoj8RKPIdA9HVEbbNmmfEtOI0b3
 NXIBfDMXLVs4g==
Received: from samy by end with local (Exim 4.100.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1xIXoc-00000002KoL-39OC; Sun, 18 Oct 2026 22:49:10 +0200
Date: Sun, 18 Oct 2026 22:49:10 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alexander Epaneshnikov <aarnaarn2@gmail.com>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille
Message-ID: <atUwxiof87wlNm83@end>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
 <atUU4HpVVI59QcLJ@alex-pc> <atUZr1LP8k5b78I8@end>
 <atUfTcaPUHqBQdno@alex-pc>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yM+iLrKY/J92yVGX"
Content-Disposition: inline
In-Reply-To: <atUfTcaPUHqBQdno@alex-pc>
Organization: I am not organized
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

--yM+iLrKY/J92yVGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Re,

Alexander Epaneshnikov, le dim. 18 oct. 2026 22:35:58 +0300, a ecrit:
> On Sun, Oct 18, 2026 at 09:10:39PM +0200, Samuel Thibault wrote:
> > Does the device sends the cell count first or the device identity
> > first?
> 
> I don't know for sure, as I don't have a real Baum display; mine is a
> HumanWare Brailliant, which uses its own protocol. The comment in
> NVDA's driver lists them as "device id, serial number and number of
> cells", so the identity seems to come first, but that is the only hint
> I have. BRLTTY's Baum driver doesn't use 0x15 at all, it asks for each
> of them explicitly.
> 
> NVDA itself doesn't depend on the order: it stores the cell count and
> the identity separately as they arrive and continues once it has both.
> I tested sending the identity first and then the cell count, and NVDA
> detected the display.

Ok, could you check the attached patch?

Thanks,
Samuel

--yM+iLrKY/J92yVGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/chardev/baum.c b/chardev/baum.c
index 166d6f2f09..db0a4fff75 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -97,6 +97,7 @@ struct BaumChardev {
     brlapi_fileDescriptor brlapi_fd;
     unsigned int x, y;
     bool deferred_init;
+    bool protocol_on;
 
     uint8_t in_buf[BUF_SIZE];
     uint8_t in_buf_used;
@@ -337,13 +338,27 @@ static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
     }
 }
 
+static void baum_send_cell_count(BaumChardev *baum)
+{
+    uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
+    baum_write_packet(baum, cell_count, sizeof(cell_count));
+}
+
+static void baum_send_device_identity(BaumChardev *baum)
+{
+    uint8_t identity[17] = { BAUM_RSP_DeviceIdentity,
+        'B','a','u','m',' ','V','a','r','i','o' };
+    identity[11] = '0' + baum->x / 10;
+    identity[12] = '0' + baum->x % 10;
+    baum_write_packet(baum, identity, sizeof(identity));
+}
+
 /* Called when the other end seems to have a wrong idea of our display size */
 static void baum_cellCount_timer_cb(void *opaque)
 {
     BaumChardev *baum = BAUM_CHARDEV(opaque);
-    uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
     DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
-    baum_write_packet(baum, cell_count, sizeof(cell_count));
+    baum_send_cell_count(baum);
 }
 
 /* Try to interpret a whole incoming packet */
@@ -441,17 +456,18 @@ static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
         uint8_t protocol;
         DPRINTF("SetProtocol\n");
         EAT(protocol);
-        /* ignore */
+        if (!baum->protocol_on && protocol) {
+            /* Switching on, answer with device identity and cell count */
+            baum_send_device_identity(baum);
+            baum_send_cell_count(baum);
+        }
+        baum->protocol_on = protocol;
         break;
     }
     case BAUM_REQ_GetDeviceIdentity:
     {
-        uint8_t identity[17] = { BAUM_RSP_DeviceIdentity,
-            'B','a','u','m',' ','V','a','r','i','o' };
         DPRINTF("GetDeviceIdentity\n");
-        identity[11] = '0' + baum->x / 10;
-        identity[12] = '0' + baum->x % 10;
-        baum_write_packet(baum, identity, sizeof(identity));
+        baum_send_device_identity(baum);
         break;
     }
     case BAUM_REQ_GetVersionNumber:

--yM+iLrKY/J92yVGX--

