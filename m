Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D902FC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIAT-0004Rr-5X; Wed, 26 Aug 2026 14:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIAR-0004RU-2s
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIAP-0005LV-A3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787768163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0gAKwAh67FfmFuiMW0u/q7z7MRLvXTPWhdOZxVQY8I=;
 b=KyS2liogwg6oHZXb1jyEMCiY+WVpPrSN+z4faMYXxLvrzPvW6kAA9fSmM4oXOTugiLDmJK
 A/o0pcb5Q+A8i1gkov4PSpl0iNBnN7L0PbFtWfLqOQFHfpGZXJf6/C9D1xHXxGi2rVQjko
 B0I+KkLkxbBCCpepbgRugHGiu1aWO80=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-HU2sLHOKPCG6II-iaNIiTA-1; Wed, 26 Aug 2026 14:16:01 -0400
X-MC-Unique: HU2sLHOKPCG6II-iaNIiTA-1
X-Mimecast-MFC-AGG-ID: HU2sLHOKPCG6II-iaNIiTA_1787768160
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c160b9c0676so68151166b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787768160; x=1788372960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A0gAKwAh67FfmFuiMW0u/q7z7MRLvXTPWhdOZxVQY8I=;
 b=PwnwvH7ZpogJc2XcY3tqaIUSeUh9TkIMBnonqTwLfHSuCNMN/XhVC+j/u36HXHK3RP
 B+19roBSzybxRWuaOy4TWABGi848dKqH96XqhZwu4QMot8y5k26+HFjShLiFQF36li0E
 eCzC/Z8XCbAvo3o+xxn5k51ysI10F69wf/bcDuyAqjghZ7+7rbLu42yXs65RTlaezTAO
 fU0HcHNbYFNTRLCaSa8g0i8g0VGhRprVNW39cUNCTN9sHIPl4mHy/4gISZhud/hkC7VI
 PcHTvbetZoBXSJGxRn4t/HGyj6W7C/wsW0+cq7ja9lxLFaX6QTXmp65IHY9yNM7wens6
 7vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768160; x=1788372960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A0gAKwAh67FfmFuiMW0u/q7z7MRLvXTPWhdOZxVQY8I=;
 b=X5T8n43TIAlMoyWKSgTfN8bzhyZEbZkb8XoptW2d+UnqRGfoPjSjOzRxR+mpIHuq0B
 kWuY7wQ6dA0++SaPwSyXo7P+60qm4QK4fOk74DaFOZync1+u51o2SMTeODVGXEH1mou7
 UbRVRAi8DIixt05F20rkqSC3CsE7JgrBAaa1O/ktsn68rBYhx8k/y2/QAhD+G5fAtoVM
 0mTe3yTojDjqDC1H+HkGeTEgHq/HLLbj3IM+UDvD3CJQWhHHakzF+OcYaeDVm78zqVt2
 0pJwH+7gnUq4CVnWvB8x6ysqn/2gT2c1lHGDeBjcgMvtzc70JpgHEYYbBwqByEX1R54u
 dOHA==
X-Gm-Message-State: AFuF++nTMUQABicvsKPH3ggn0lB0JaIzGHdgpJJZIK+OuV3tnrjWKQma
 myiwNph5KbBfzkb9slMXkUvY/Mxud9PzzLNl3A3Y8bQAN3P1QqpGI5DYo1a8Z6XybP7jjgmyspF
 Ur13eNd2/ElzdCUBVuuHt0ykU1jPD5YcqhqT6A9V67VxbwX6KXaVdObPY3kZn5PgM5p8WasVER4
 LWstWlir0GAuxV+FSOfo5ACT7o2m0l5SuQsOyhKOK+
X-Gm-Gg: AR+sD10VT5BvTjLbcMfdNL7/LZlAWaxyDyo8ZKtBea+eKgMIzVDcFjSwXS/+Eeq9S+B
 YVOv7Di3dJXU3wk82MzYNxM5Jia05GYZfn/9lsZL1SQRfolbAfIqnFOMTEBxXKb1ET2UJmH0YRE
 V1Tr69NfhI/qK/9zwM0CUb1pkdnevrAcdkeg81zkejInqIzEeXky0tSV+1S3t7rdqieJfqCHGTG
 NU1KFVx0spN/mLuUblAyXFRD+YpOQOlYl0rWNLppUyak1XETV75q6vIW0nTlJ6cZgENO2mT87C2
 N5GdrUS1pnjyIWV6CylKxOSNlaVetCSsuLMMxmXu6kA1pifXkXUoRmC4xmEUPgbKB2O59TPLyqz
 KSfg0yl7xfrQ3NKzJ1dxjI+PsMPYd+VEkU3k6TpA9495cndKqhWtygcIjXJd+dAgBit6tX26hz+
 F2fw==
X-Received: by 2002:a17:906:f591:b0:c15:f4bb:e663 with SMTP id
 a640c23a62f3a-c250bb792f9mr949566166b.10.1787768159976; 
 Wed, 26 Aug 2026 11:15:59 -0700 (PDT)
X-Received: by 2002:a17:906:f591:b0:c15:f4bb:e663 with SMTP id
 a640c23a62f3a-c250bb792f9mr949558966b.10.1787768159465; 
 Wed, 26 Aug 2026 11:15:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm579587666b.21.2026.08.26.11.15.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:15:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] vapic: confine the VAPIC region to 0xc0000..0xe0000
Date: Wed, 26 Aug 2026 20:15:50 +0200
Message-ID: <20260826181552.848617-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826181552.848617-1-pbonzini@redhat.com>
References: <20260826181552.848617-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The VAPIC region is mapped as writable RAM, at very high priority,
above existing memory.  If the guest is allowed to map it everywhere,
it can overlap PCI BARs or even SMRAM.  Ensure that the whole
region first in the 128K of low memory that are reserved to
option ROMs.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4206
Reported-by: Artem Dinaburg <https://gitlab.com/artem35>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vapic.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 78dc2312bca..5c3911cf9c8 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -34,6 +34,10 @@
 #define ROM_BLOCK_SIZE          512
 #define ROM_BLOCK_MASK          (~(ROM_BLOCK_SIZE - 1))
 
+/* Option ROM window on PC/Q35 machines; the vapic ROM must live in here. */
+#define OPTION_ROM_START        0xc0000
+#define OPTION_ROM_END          0xe0000
+
 typedef enum VAPICMode {
     VAPIC_INACTIVE = 0,
     VAPIC_ACTIVE   = 1,
@@ -592,6 +596,14 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     size_t rom_size;
     uint8_t *ram;
 
+    /*
+     * The VAPIC region should be mapped in place, refuse mapping it
+     * outside of the option ROM window.
+     */
+    if (rom_paddr < OPTION_ROM_START || rom_paddr >= OPTION_ROM_END) {
+        return -1;
+    }
+
     if (s->rom_mapped_writable) {
         memory_region_del_subregion(mr, &s->rom);
         object_unparent(OBJECT(&s->rom));
@@ -607,10 +619,11 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     }
     ram = memory_region_get_ram_ptr(section.mr);
     rom_size = ram[rom_paddr + 2] * ROM_BLOCK_SIZE;
-    if (rom_size == 0) {
+    if (rom_size == 0 || rom_size > OPTION_ROM_END - rom_paddr) {
         memory_region_unref(section.mr);
         return -1;
     }
+
     s->rom_size = rom_size;
 
     /* We need to round to avoid creating subpages
@@ -618,6 +631,7 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     rom_size += rom_paddr & ~TARGET_PAGE_MASK;
     rom_paddr &= TARGET_PAGE_MASK;
     rom_size = TARGET_PAGE_ALIGN(rom_size);
+    assert(rom_paddr >= OPTION_ROM_START && rom_paddr + rom_size <= OPTION_ROM_END);
 
     memory_region_init_alias(&s->rom, OBJECT(s), "kvmvapic-rom", section.mr,
                              rom_paddr, rom_size);
-- 
2.55.0


