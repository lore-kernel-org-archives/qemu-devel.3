Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43421C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 06:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgGOm-0002dq-Hl; Sun, 05 Jul 2026 02:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wgGOV-0002cc-F2
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:31:59 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wgGOT-0002Gd-Fl
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:31:58 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E0633F1F4
 for <qemu-devel@nongnu.org>; Sun,  5 Jul 2026 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783233114;
 bh=dPrdh3Nkx1jwWGWugum2XC76v0VGxZWwpvfpPhu0KAs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=dggZso9gAZfohq1lmCeeQq0yrhVGgirRbMOqiUmx9D86Ol5m20dJ4PCxPyLOlF2QP
 mh6NUlBi9NJmpiizb0wG5cl5USN0kV3x+iqbTzKkYe0MtuuioUFhJkafV8W9KpueZu
 SW3uTPeMp3BSKsuLRYL9i3WkKLIL1nSeH+YuVENg8JzYa5eScPZpUJ7+GwqkHFbDGF
 2a29lScMY22x/BLVLrhdddSIzaJDc8jA8rhykKTGDg6Sbwz7mhi/N3/48FNsoLeAwM
 h2P8Zl/N43TgIna6J3N0fUH5MHDdGBpV3Yih2dQfDkOAhLe/UxYRIibSY4LFRAzJly
 rKWzI3CDJt/l5Vtb/NMm76KbJEUm1HfI6Vx+FLS//GvWMdg8OOk14TRjFZWOc9g5DC
 9zeFbvKhpUXqp4rWdEalq6ogH1dep5YdaiHWiGe5sEk1bagIpt5wqwfvXI6CMpff9g
 +HfLOHuwSZr38QafPvQH+yNEBhXavzAj4vuPKt2jT/Y1qYH1I+RPrwzQ1l1ROINdgq
 fxtSBQljIGFhkzYBC4ynBCprrdZZZ6qhki6eDLCBw+b1hhlAkrRzHjM3+KytK2OywE
 BKpITEuxM3FFaZdjnMoz8MapqMAq/jROhCx3SpbsmmwFskv1c7ufZeIw/jGG5+CvpE
 FiBIrZptGrWZFZaBGEVbd5EI=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so1062238f8f.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 23:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783233114; x=1783837914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPrdh3Nkx1jwWGWugum2XC76v0VGxZWwpvfpPhu0KAs=;
 b=Svj4AluFU/fqt1sqSwdZJU89ewTFncwL/0XleNQhqE7oKd6UR3L9HzpvZP+k4cHBtw
 xPRoZexGDI4uJnREoNDhiDJIP/xQ3/KiJ9rhuanQ7hKgzfWzBm4eMD5c0MkseJPWJUXT
 KZELhsQBB+jNU9kCYyAU4CYoeVPJKw1WSG0OeIgl8AlnGk2wX9h6M3HUdJaCuMtb1zdE
 dj6u3UfMZZ94HC9NUTlHFw13y7aBby1+75fIvVB3jOzWB0O3ea1tFn3ArzcRZ8mgDAmT
 IaqCfTT2GaXZAQ+S3T9cP7hl5Q3X3TfwzAWtLxTUyGpDPlAqVAJ1Tedo6eytZk7rkSG9
 nezg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLjB22I5gdiy2Y3B77beJ5knTdA7D+gaEiZm0iaj0POSgG3GIBcE6RACYKqqk6y7WPYN9JZ/4XULhx@nongnu.org
X-Gm-Message-State: AOJu0Ywu5/pF24azdigLowiaNMcTANAaq7XdH2wnHQIQnMREbviO6IrJ
 nosjIhWsK3HJibq0JJVFk4pdj/4WLdZ/KO9kDBryDnlD5OY1n4TIR2mYuRFClssySmeF/50zSav
 mtMQHH6imphqJndmfzcDhRYbulxm+t3RPz3kCGH4Y1UyIGFvMX+Sn+gHcQOsg06I52RfTYXgi
X-Gm-Gg: AfdE7clkMr8TXS0xlErzSoOi9GT1UYmL129lWlLUAkszK6rei3iUyHzHg/YjsH+dFjj
 YpoUavMNlnkJ5KuHgDfFgHGO/EL6986IZAtio2KYbL83EOWpIHDvS64iUUhrQzXdBu4cid8jEW0
 hWpAQ0gh3/mhFKkPMNvhTGeCI2A1cqZF0GZvCxfu8PGjwl4fcbXQudpahFbghfKFFGJxWqEiNyt
 W00uXyvaDVXx6eXPTTPCveR8LHHtw/RgkZTOvhppEk48dT4fUVz0mX4CKRgH9gc3OVylF5sBOI/
 pZQ0saDko2645VcAQewHBgGEk5/3UD4de3NuaYfbsBjXdJzUkrlIrppEXl2xv7QCo3mmoGdfVNR
 GrtpeCb1Igu05m7D/pgla3IO+Tqp0qLLyaO6T4yL+Ex1xon6sr2hW2fWoPtKiyV2dIw==
X-Received: by 2002:a05:6000:61e:b0:475:da0e:7465 with SMTP id
 ffacd0b85a97d-47aa92c070dmr7143421f8f.5.1783233113757; 
 Sat, 04 Jul 2026 23:31:53 -0700 (PDT)
X-Received: by 2002:a05:6000:61e:b0:475:da0e:7465 with SMTP id
 ffacd0b85a97d-47aa92c070dmr7143395f8f.5.1783233113372; 
 Sat, 04 Jul 2026 23:31:53 -0700 (PDT)
Received: from workstation5 ([2a02:3035:683:e876:a486:6b9b:f6eb:790f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm14293266f8f.26.2026.07.04.23.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:31:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v5 0/3] hw/acpi: correct field sequence in SPCR table
Date: Sun,  5 Jul 2026 08:31:44 +0200
Message-ID: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=0.645 autolearn=ham autolearn_force=no
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

On LoongArch and RISC-V invalid SPCR tables are created:

    Terminal Type : 00
    Language : 03

The correct values are:

    Terminal Type : 03
    Language : 00

This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
SPCR creation to common location") that swapped the fields.

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

This page shows version 1.10. But the sequence of the fields was not changed
since version 1.0.

Our LoongArch and ARM code uses version 1.07 of the specification.
Our RISC-V code uses version 1.10 of the specification.

v5:
	Include 
v4:
	Reproduce the test data changes using rebuild-expected-aml.sh
	creating the same diff as v3 but in two separate patches.
v3:
	Add test data changes	
v2:
	Update commit message

Heinrich Schuchardt (3):
  tests: allow differences in SPCR
  hw/acpi: correct field sequence in SPCR table
  tests: update SPCR loongarch64 and riscv64 test data

 hw/acpi/aml-build.c                   |   4 ++--
 tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0


