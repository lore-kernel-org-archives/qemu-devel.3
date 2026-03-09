Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEC6FCA187
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPD-0004fp-Jz; Mon, 09 Mar 2026 16:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP2-0004eP-2K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhOm-0007gV-0O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pYJpSgxPPO+v1EgJ+isO2WJIuGRkEiiV4/Qldt+i+AE=;
 b=M2rcAGF81ecpXw2RON/UPdTKXGPYNQccaMGwDKbnSBuXNCJvXsqz5TRRjXihTgFi4zQqVZ
 1p2185EQvlpdAjmgbnGp6e770fDdCcihjhTaMbPZe/+yG4anRCQQ8/wx+n2eeCZtmxt88E
 OFBliDkwWSen9Xm9HE+M/zecj/nuyYY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-AWeMLBmKOR6gYCz4sRIcYA-1; Mon, 09 Mar 2026 16:40:18 -0400
X-MC-Unique: AWeMLBmKOR6gYCz4sRIcYA-1
X-Mimecast-MFC-AGG-ID: AWeMLBmKOR6gYCz4sRIcYA_1773088817
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd76ff19d5so1339196185a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088817; x=1773693617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYJpSgxPPO+v1EgJ+isO2WJIuGRkEiiV4/Qldt+i+AE=;
 b=DJaDPLwH23wtIMQU5FKjNbxA8EnlpEiPeZoggP/Elqt0Bf0AavmhajodbLR+bEEg5F
 FEQNACRxm7sntI9LJRdXQM1MEU+hVT681nBcdBNXvgy+ahy+46pQX9We9qrru8yE1pyy
 jlKFbVKD2kmBhXygs3hm3Iao5R+QSlUd4iojJVyAIvgmeHs49UpIMT/m6HHGyDnoWeOI
 NAmVgPFCB9No1J+ssxcWbtGIjZfm3J9SOUX7vhNhEv63lznAOPB5ilM2jThOAxD10snR
 jb3jWNQBiC3IMV06uj/NfJJHCuDs4RQtbI8K5Gnp1DTC0RdClg6m9Z+zHBjbewCu8goe
 Q+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088817; x=1773693617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pYJpSgxPPO+v1EgJ+isO2WJIuGRkEiiV4/Qldt+i+AE=;
 b=lfpPIA/nVhI3T7waRkLxbI8bn1xe8R3QxQwg+FtFWKc4JDFMDgr2981KpeGVDp+vgI
 z/0933ckxsLLoK0Js0nV6DAlC7Rd2ZAOwTEKnxvHvGx5RaqstFjfqm4sZYYIRx96QATz
 eiyazFelEYhMFLiwwqcrEk4csQg1AFogD3Ef78DhLa+PDrZEXbx0ICblYuuuQguwByUC
 XhnzPDTIMMytzRf5hXyBOceU14Ogdfh89IiH4rWC5pY+dAXNMSB+a9ewQIZVmQrZDjl8
 UEGwmWCoCOTglePx2SrDZPmq9iWTI0y8FeXz2cEZ+Y8Kus9JNCSQhYTR6jrNhU3ootxE
 iiFA==
X-Gm-Message-State: AOJu0YwXrq5NM7Qjfp/tZHhMEWUoeAlsZzFvOFifl/hP1mE+yriiWImI
 6zOVKVC9JuhpdlMUb0bk3UGksStAz7f8+8AAx/BKdjk0vO9aY7AuUHeNyFcpHTpcAwzr6Dg+1lc
 vR9GS/gC/DSt0inma9iX1IhYmAj3d83NciyOB68VFTwQh8J+2WjSKbNlFanjmeNorU3ix96s5++
 a2CM5uBdaDMA/DU7RI9cD8Glrg6JPlvF7semrdNg==
X-Gm-Gg: ATEYQzxcBUP4Lr7US1Sbn0l4TkOAE6qdkAKe+IKqSjW6QwsPDErXq7EQwlyJYK+VNfc
 5mHjbwPRI8Sh3+LDQDtZCEpVyll6wQ6Be0OaWxOqggZs3B3jW/EA7zbkPS4ni6ASSiM3R2M1ILF
 IOTy2p0yZpO22JBCZ4rmpsDLDkAw+SIrxUGDYJ69d/NOgZaxykfdA3tM6cdsO4DRaqVXNN/WpZv
 x1nAN9YeThQa6mYcgh3WS9sXpEmVWUX6uiGHIricToBvqKwRDY8yNtlNyz9Kck+1m20LSn/DWr+
 i47rXw6B8KkgqLO+FnyDUQjyoAYNHct2M8lLoiVMXxbGwMx2YfF5/4PtPqUgT0dIkWc1jEyTwgX
 61kmYr2+KNriLl/hrX1jSWO6LtpKPQxLInffCot5sz8p9VDjx3v6QgtgvlkjoyJcNmfvFfnT+vS
 dkjy3Ihw==
X-Received: by 2002:a05:620a:29c2:b0:8cd:80e1:5a0e with SMTP id
 af79cd13be357-8cd80e15eb1mr891701085a.63.1773088817097; 
 Mon, 09 Mar 2026 13:40:17 -0700 (PDT)
X-Received: by 2002:a05:620a:29c2:b0:8cd:80e1:5a0e with SMTP id
 af79cd13be357-8cd80e15eb1mr891696785a.63.1773088816500; 
 Mon, 09 Mar 2026 13:40:16 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 01/18] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
Date: Mon,  9 Mar 2026 16:39:50 -0400
Message-ID: <20260309204007.1709441-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Use memory_region_init_rom() instead which is what other devices do.
This breaks migration but these devices are only used by sparc Sun
machines which have no migration compatibility guarantee.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/819df754e359b024bc9bf8f971ecd26816552559.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/display/cg3.c | 5 ++---
 hw/display/tcx.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 568d6048a6..61bdb0552e 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -282,8 +282,8 @@ static void cg3_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     CG3State *s = CG3(obj);
 
-    memory_region_init_rom_nomigrate(&s->rom, obj, "cg3.prom",
-                                     FCODE_MAX_ROM_SIZE, &error_fatal);
+    memory_region_init_rom(&s->rom, obj, "cg3.prom", FCODE_MAX_ROM_SIZE,
+                           &error_fatal);
     sysbus_init_mmio(sbd, &s->rom);
 
     memory_region_init_io(&s->reg, obj, &cg3_reg_ops, s, "cg3.reg",
@@ -299,7 +299,6 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
     char *fcode_filename;
 
     /* FCode ROM */
-    vmstate_register_ram_global(&s->rom);
     fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, CG3_ROM_FILE);
     if (fcode_filename) {
         ret = load_image_mr(fcode_filename, &s->rom);
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 36cad82abd..16114b9bb8 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -756,8 +756,8 @@ static void tcx_initfn(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     TCXState *s = TCX(obj);
 
-    memory_region_init_rom_nomigrate(&s->rom, obj, "tcx.prom",
-                                     FCODE_MAX_ROM_SIZE, &error_fatal);
+    memory_region_init_rom(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
+                           &error_fatal);
     sysbus_init_mmio(sbd, &s->rom);
 
     /* 2/STIP : Stippler */
@@ -822,7 +822,6 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     vram_base = memory_region_get_ram_ptr(&s->vram_mem);
 
     /* 10/ROM : FCode ROM */
-    vmstate_register_ram_global(&s->rom);
     fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, TCX_ROM_FILE);
     if (fcode_filename) {
         ret = load_image_mr(fcode_filename, &s->rom);
-- 
2.50.1


