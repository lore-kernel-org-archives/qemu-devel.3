Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B03E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9WZ-0005V3-Tx; Thu, 05 Dec 2024 05:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9WY-0005Rd-2k
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:58 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9WW-0003Wa-El
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:57 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-72577d3b026so757481b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396155; x=1734000955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghEpwFv0jtfaUZx94fv8Kp850KMtaEVl4DsECiLC2bQ=;
 b=OmrfDtcgdMuKuSvjHSApC61x4JGlGT5VyLZI9Wb8GhfV5d37gcVdZmZi3JLJ0m3u0k
 NgHrEVAbvH6OWmHHAjC6WYYA9HD7eDoKsNcni6QaemjY9fGLSC+22aCihv4NCazdAc//
 blmlodX8e/MpWnDtrhXg9ZUj1mM3aFPA+T8R1MDyoHUSWScjQ5Ni2+dnWJXLtWB/Cb+U
 25xsNDf935dQTPPyeoV5/ova4elJxrESg9AYpEhRlgdmWg6AoJYEEWY/b8VUCzd8wJif
 8lE0XHoheIsDU7tUlNjvWPl703PIhEiqWFuoiMjEOf1TQM7yWxFW+3EyABIhx+20x1cw
 y/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396155; x=1734000955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghEpwFv0jtfaUZx94fv8Kp850KMtaEVl4DsECiLC2bQ=;
 b=BuIC7po4ttbbw7ze2UsMzXGi+smVfBQr/pEsde3O0NOETzudzdV3riasIFpdB0Fn5b
 yVDHwlAvaF7fGA315HsdCsyYi6THFWNdal+99t9Ca+GIr28n0/65TWCCYrGZan6xCoeZ
 DFIIMMQ6ARJzCmSRalOMxgKU1P63EIBD8jH5qPX9Qrp16f60aXjjSQ5Ewbrgou0oOiC8
 8mZS9lpAgp1qACXkhoh3fHGO8ybeRpOoUhDY6HRni0FKhk7y42Tu/CximOVrYT7CypSM
 8R0VLWQmxN4ky22C856eJ+PWgJVWdmyYo5aeHUO5fMp2QEQOyXcI8Bd3Z9YiaHGD5LMh
 Y4og==
X-Gm-Message-State: AOJu0Yy0BvKOvaBRStSM66uaH/it6k+FCsTVBCL6uNGmbfe6SR9ejeb9
 nt4giQWwNm73DmuqFjKZLwOu6dQjG05ps44iMp5cOyDxKA4gp9glpQeYr7T1zg==
X-Gm-Gg: ASbGncuHq2Ah1lTOu4AlRnF6pULDyEsQBphvmIlrzu/excOqkpceNizD2dTE/q88niY
 nQwJg799hXkCuN80KMKcSKO9n+rPgTuvT2v6h+DHsxKER7qymyhZjxX85hrKm6GmqmCeGL0+jsV
 1GvhRUJyjj7Qcvfi0pj30HB0Tqn7yFnnNjrzqw8eaHJ8e3e9P12nF+ybRVvst23XXmh5n2BZGGR
 SdMOpA9dEB+HZBvGBdpA9k3BgsS7aqZcSl9tM8xDgniR+sxcCqwls6vDA==
X-Google-Smtp-Source: AGHT+IFuyEe8INiWEufKz4O5JZ3qooFvS1rePLxsDNcAOHeM9T634/dg2GJOhDtNR/JSieRjcaVJcg==
X-Received: by 2002:a05:6a00:3cd5:b0:725:9ec3:7ed9 with SMTP id
 d2e1a72fcca58-7259ec3812bmr2472414b3a.21.1733396154832; 
 Thu, 05 Dec 2024 02:55:54 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:55:54 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 03/10] vfio/igd: fix GTT stolen memory size calculation for
 gen 8+
Date: Thu,  5 Dec 2024 18:55:28 +0800
Message-ID: <20241205105535.30498-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On gen 8 and later devices, the GTT stolen memory size when GGMS equals
0 is 0 (no preallocated memory) rather than 1MB [1].

[1] 3.1.13, 5th Generation Intel Core Processor Family Datasheet Vol. 2
    https://www.intel.com/content/www/us/en/content-details/330835

Reported-By: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 18d179bc83..09bd4e5383 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -259,7 +259,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
     ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen >= 8) {
+    if (gen >= 8 && ggms != 0) {
         ggms = 1 << ggms;
     }
 
@@ -669,7 +669,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* Determine the size of stolen memory needed for GTT */
     ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen >= 8) {
+    if (gen >= 8 && ggms_mb != 0) {
         ggms_mb = 1 << ggms_mb;
     }
 
-- 
2.45.2


