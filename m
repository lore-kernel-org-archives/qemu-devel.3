Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5890C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzasQ-0004Le-2x; Thu, 27 Aug 2026 10:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzasM-00049T-6S
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzasE-00067O-U0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vcqu0cEIG7651x+/pR2XIM1uoxAS0eAsApwoR2HcxM=;
 b=YVBfr8UQy8oqbkbOf007QZy25vrwcvIv2PXl2ioJt/yO9i5z8aVteIpd9bNw6d/IaVNeG5
 ok5FaxcyQKwMxAtv7q8zhzbbyF02kbZ+zi28X18ou6qIH8trUB7BN+L1npztt9X8TKqPko
 I07ugW9vy88aU2LCpitzPH46ris+pKY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-HGVldTpRPdGYGau6jqL-sg-1; Thu, 27 Aug 2026 10:14:31 -0400
X-MC-Unique: HGVldTpRPdGYGau6jqL-sg-1
X-Mimecast-MFC-AGG-ID: HGVldTpRPdGYGau6jqL-sg_1787840071
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6a5d682e372so974650a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840070; x=1788444870; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9vcqu0cEIG7651x+/pR2XIM1uoxAS0eAsApwoR2HcxM=;
 b=maBAPLwnWwtjhRW+IE51mkZzIIYzsOshe4+Qq2rY5pymsVvBHuN2WAF9RSydvpe/KU
 aa8uI/wi+xjtbmCrdGpAQTvK+NjxRq1FEc7L9iRp2GOVMM2hmNzNFRipqV+nblsGO1O6
 fIS27aubVlTyemsWP2sZwYCrGOrxR2aKKcMORWjrm5fC8WeRjGNWRPPqZPlgKQsSH5qr
 yUPzimxRbsC7dxHXEunfFJ2QF229E5HGwW2m38D4osDaBB/S4wXin4ETVQMaZ/skj+eP
 LjWuWUsB2v6b7D/IByxZWMnJvM/9Tm9xAXnOLxOkrCgVharaeBSjZ2V/fZY3ZogvOOhx
 Fq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840070; x=1788444870;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9vcqu0cEIG7651x+/pR2XIM1uoxAS0eAsApwoR2HcxM=;
 b=CztpFNxvBN/BJ4hV7gzhNLl/NyuxwPHRRH1ZBv8DV1952aM3X9491Jtdj4y8qh5ijM
 T04dH1EEi7jUD+fzlMsmkDcAsSCdN88AJuDT/h94bqSrOr6QBBjWvploPPi+V6k1EWHI
 APinGGcGBQjWBNhpHxvqGhPmNRzjSPwBT/dTh8edpAXlFbZ2eFgeZxkbmtsU3OduzmEn
 FTor1rPx24y+NbHsJTAC3k7O2UzNiGXZj61kHgihsKs+xhrUxDryYE4EPafsEXeyjoGs
 8TmzyudgACYhvfuk6SUOWUj3gInISmJSqLUi1eNTmqtUvWZQ1zQb6j6XdllVZ84kKx8c
 Ef2g==
X-Gm-Message-State: AFuF++k7PgeE/8+Kj6A9BlPTSWKZqwgbR8xDR8WYGy0Bo7GBIsaZIFov
 uaPM4596F9/mq1yok8d+hvEXOs03DUVsoh3Fm/FYMSzPXqZtYXLITOwnn4vSduKnfW5HKxswdpd
 Iypp2ZiBwH5A/W0XoUBwXW3dnURbuhFMmwayQlNvDNvQz97+xRkKwF3YPCykom6od8zwcW/CdPn
 C6kl17CRQYyo1tq2FKIRsyvsrrsegG1S+C0Yaij4Vh
X-Gm-Gg: AR+sD10ySbs2zlSsDERTm2/+iz35wt7kugMOHM6zBe+odsctq6HWgId5764JPOlRaq+
 YzJDlm3src1RoaRDxQJGv29KUY2mugZtpujTt08GcALelHVY4ejyPsRFDAP8f/GZ/8fTbqwuauM
 R4JgoKlc0ZtZKDEJqsQ8pqVNRPknzwUMLgJpaHtXsI5eSP2G6wFqUnhtXPJqxPiCMatgYxXZDhe
 YRdTST5s9//rcBYzyN/QghJmsLLOEoUXzs53olI6SK3a3tdpb2+8tf1hbBKnq4YtsFWRwPwwLGl
 0F34GJ+dmdJOZpr+j4fKyNHCGPC0olXVT2i+mT0/b5mXVGRC/e3KAYUr9L7JNxwUAy+JTuyEy3K
 fI7OShrhqP0FRnS/B4940LwjBpEfCoQb7iHkczku9DGkJbPu3T1Ee4fiiqa0ThVvrHQyj2MSdPC
 YyBnE=
X-Received: by 2002:a05:6402:a18b:b0:6a1:f3b5:f7dc with SMTP id
 4fb4d7f45d1cf-6a5f4f0d63dmr4055539a12.4.1787840070613; 
 Thu, 27 Aug 2026 07:14:30 -0700 (PDT)
X-Received: by 2002:a05:6402:a18b:b0:6a1:f3b5:f7dc with SMTP id
 4fb4d7f45d1cf-6a5f4f0d63dmr4055485a12.4.1787840070119; 
 Thu, 27 Aug 2026 07:14:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b621fsm7186369a12.5.2026.08.27.07.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:14:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 22/23] vapic: confine the VAPIC region to 0xc0000..0xe0000
Date: Thu, 27 Aug 2026 16:13:10 +0200
Message-ID: <20260827141314.1099352-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vapic.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 8dd9188d96f..9adce172621 100644
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
@@ -606,9 +618,10 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     }
     ram = memory_region_get_ram_ptr(section.mr);
     rom_size = ram[rom_paddr + 2] * ROM_BLOCK_SIZE;
-    if (rom_size == 0) {
+    if (rom_size == 0 || rom_size > OPTION_ROM_END - rom_paddr) {
         return -1;
     }
+
     s->rom_size = rom_size;
 
     /* We need to round to avoid creating subpages
@@ -616,6 +629,7 @@ static int vapic_map_rom_writable(VAPICROMState *s)
     rom_size += rom_paddr & ~TARGET_PAGE_MASK;
     rom_paddr &= TARGET_PAGE_MASK;
     rom_size = TARGET_PAGE_ALIGN(rom_size);
+    assert(rom_paddr >= OPTION_ROM_START && rom_paddr + rom_size <= OPTION_ROM_END);
 
     memory_region_init_alias(&s->rom, OBJECT(s), "kvmvapic-rom", section.mr,
                              rom_paddr, rom_size);
-- 
2.55.0


