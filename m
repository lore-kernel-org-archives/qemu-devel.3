Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639E0C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eDI-0001kk-0w; Tue, 29 Apr 2025 02:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eDB-0001VY-Rk; Tue, 29 Apr 2025 02:12:57 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u9eD9-0005OL-RP; Tue, 29 Apr 2025 02:12:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227d6b530d8so60778495ad.3; 
 Mon, 28 Apr 2025 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745907174; x=1746511974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=MbwimO4EqZ7sgOqFY8zyCqt9fX1bmrn547vhHkSRXAY=;
 b=MLDr2GgadhHBLLR7o+f+Zlfg1vV6kxlIsumr9R0JwipCV6aoT4S+1te8Hb/xGEpgis
 eWR6S0dyvUcTiFIv163hQzCZS41IR9JRmIJgrpM1RJRkZzBHL2eO6ND57yECpMSgRUHA
 /OBF2K4Po7AfH1ZiFDPmhTTVCXBs9gVZMPAxnm5vJs2SFEtDjTMkM8SzTvgf5C14VKWw
 YWI1f6JIghml3cx08AYKuyr6f4v7QMYqjHlBJR8sTU2CJUEQrJ2K//fvmMj8RElBAw+P
 JacEE033+OcJVHKh/pTZkanJWpVyfMhGO5VyZJ+zUP7AZJTxGiN22zjsUk6y6gP35zYB
 rgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907174; x=1746511974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbwimO4EqZ7sgOqFY8zyCqt9fX1bmrn547vhHkSRXAY=;
 b=CZTANZ2fmAA+Kx53TZz2Kc8jiXeuJVx+o5i2zIMs1tsj+b/2vOKjxKE4i2Pcl7JPi5
 POtbOuNnw7lZBDbuuoykTzv+9rILy7mAECFw3CYl1HwywudyDIFIRYYrbY05mJ2ZJ0Br
 kbNqKNAsxgzHhHdOVYETfYPtys1vSPL+Ws24uzGBhkxJ/8tMCuA1ZdKwGa7dKco24FHM
 KSMzMu5uW5hgd3Nz7Syi4xIq81q2dk41RIRIXsgw5e1lt95GFac2ELzxyw074J2CUNqR
 449bGf1F4NJbJbVLzTlZoIx7bjDqww8+l7g9XjS+ZmFoDlo6U71npl5LttYwb4b2Ar4N
 9MTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvSI5VBAgVejg0u/jAseAqy5iT5sJKBnwY3bEBxOgd6DfU755qr2+pE4UPX11FJL3lj2vuxNs9mrG+@nongnu.org
X-Gm-Message-State: AOJu0YxDNWxGUQGJquqRMMcHYTICtqLcBEGbGWnR0wQNFLjTOf/155aY
 02FLANEE+qUYIZgwJD0+bNf9FvMi0Xfpt3FJHQl0pcBbbO+UopxZPoPm3w==
X-Gm-Gg: ASbGncvRnbyvCBEIGCgSUg7u9q7dBIYRTnh2SMp4PfaQkN6p37rBt+31FMyvlIxtiPS
 bsTClnLo1w1znidcav8Zg2HhKi4vNtwrvyKMF5+6XM0Dnu9jjU3JEY1g3bj4T6DOC+Aj33s3FRI
 ZufGhF7vjHX2TFK8TlZ22nXn8CnV54HLUq0XREjGj7KITHcUlD4cYj/VnywVQ7usk0DrxWnKaPe
 xC7RqIONJnI5s8cIl2ChxyHHNiGxi8P8zGrwhYzq4IQ+JQegH/bWarP/sI0Qo/q1iCgLjlaUlEt
 1v9whYVNlU3lAn0wwPewgF+UB6ENQzKH3BKn8Q2y1BQwchql+sU=
X-Google-Smtp-Source: AGHT+IEavuBjj7LDUhSQm0zWcQ/fNQoLZfMkhtFQPQOhPktWN21/k0OzNU65SJO8ihGwTD/ufOSJRA==
X-Received: by 2002:a17:903:1948:b0:22c:3609:97ed with SMTP id
 d9443c01a7336-22de6eb552bmr23405705ad.30.1745907173836; 
 Mon, 28 Apr 2025 23:12:53 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52169casm93947765ad.238.2025.04.28.23.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 23:12:53 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/13] hw/riscv/virt: device tree reg cleanups 
Date: Tue, 29 Apr 2025 15:42:08 +0930
Message-ID: <20250429061223.1457166-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

This is a set of cleanups for the riscv virt machine device tree
generation that apply on top of Daniel's recent series. 

Using dumpdtb the old and new device trees are identical for -M virt and
-M virt,aia=aplic-imsic.

The final patch is not meant for merging, but demonstrates bugs in the
existing code when the reg property describes an address > 4GB.

Based-on: 20250423110630.2249904-1-dbarboza@ventanamicro.com

Joel Stanley (13):
  hw/riscv/virt: Fix clint base address type
  hw/riscv/virt: Use setprop_sized_cells for clint
  hw/riscv/virt: Use setprop_sized_cells for memory
  hw/riscv/virt: Use setprop_sized_cells for aplic
  hw/riscv/virt: Use setprop_sized_cells for aclint
  hw/riscv/virt: Use setprop_sized_cells for plic
  hw/riscv/virt: Use setprop_sized_cells for virtio
  hw/riscv/virt: Use setprop_sized_cells for reset
  hw/riscv/virt: Use setprop_sized_cells for uart
  hw/riscv/virt: Use setprop_sized_cells for rtc
  hw/riscv/virt: Use setprop_sized_cells for iommu
  hw/riscv/virt: Use setprop_sized_cells for pcie
  NOMERGE: virt: Adjust devices so everything is > 4G

 hw/riscv/virt.c | 108 ++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

-- 
2.47.2


