Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3278CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvs1-0002YD-Uo; Wed, 18 Sep 2024 10:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqvrz-0002XE-RM
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:41:27 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqvrx-000830-TF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=duIpVja2IciimkjsL6ZlCIrh1k+IkfpZ8i92Aao3lcs=; b=D221AUGTWrSuWbvq
 FKip+YIX2EASZm1dPBMJw0CxxC+hU0Cvj5hfd+JpLWuK2ptoZRbIxalMwMm5Lb6VeJ+Gi5VkqIfUo
 LW1t24uhPNe6SzfryEfNtwVf6Q1GEvFx+lA0oAZelGm19jfYjTsiE/tiY+uDaoheGP9UNHBaIrQke
 QDfElfdc22lJ1fmF2e6AEFsJRgf98+W4Q58L7MWq5uv4Q6HoSAfET1g7yZARu4/8PSesnWhViTs7Y
 oCbKnPeeNteZJ46Mt0J0W4ygNjnH0O/f1ERGXaFWHPuSSYYWRjSjiFIyrmxA8RIzuAwzCrH3IiL3/
 MyeL5DzCPma1iPgoFQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqvru-006J2w-39;
 Wed, 18 Sep 2024 14:41:23 +0000
From: dave@treblig.org
To: mst@redhat.com,
	pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] hw/char: Remove unused serial_set_frequency
Date: Wed, 18 Sep 2024 15:41:22 +0100
Message-ID: <20240918144122.155351-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

serial_set_frequnecy has been unused since it was added in 2009:
  038eaf82c8 ("serial: Add interface to set reference oscillator frequency")

It looks like the 'baudbase' is now a property anyway so the wrapper
isn't needed.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/char/serial.c         | 7 -------
 include/hw/char/serial.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index d8b2db5082..6c5c4a23c7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -951,13 +951,6 @@ static void serial_unrealize(DeviceState *dev)
     qemu_unregister_reset(serial_reset, s);
 }
 
-/* Change the main reference oscillator frequency. */
-void serial_set_frequency(SerialState *s, uint32_t frequency)
-{
-    s->baudbase = frequency;
-    serial_update_parameters(s);
-}
-
 const MemoryRegionOps serial_io_ops = {
     .read = serial_ioport_read,
     .write = serial_ioport_write,
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 6e14099ee7..40aad21df3 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -93,8 +93,6 @@ struct SerialMM {
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
 
-void serial_set_frequency(SerialState *s, uint32_t frequency);
-
 #define TYPE_SERIAL "serial"
 OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
 
-- 
2.46.0


