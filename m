Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD01C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNN9-0000Re-9d; Mon, 31 Mar 2025 18:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNN7-0000QP-4k
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:12:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzNN5-00074P-Hp
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:12:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4206237f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743459161; x=1744063961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/2djY+Ipfb5bt5gWpZJXDDTqZrYNZiOz6PXhVA3G2is=;
 b=p+YwqHaA829q1REl4pftgKjRRIHvruyPvGM2cSjfkS5q3OR6FGesFEQon6Ldy9PARG
 CPw/DeKicMQzvwDSe5bVHHC2rHmwDfxGdAUq0rHmj8QoGGACBuUXc9qfJUJH9LU9mPzq
 kGA2nQDzl4/j+8PAbbI4BZXS7ew24EZJ7KBUVnDrBygoRK3Ke0KlYbNs1vgY2gZK/BKb
 J4895Y9JZ9yaxlYLV9t0oYE61FbVIhqHGtLrDpPXEadfvMIwVioyv7AI89fTEb+6DvG9
 AFivZsPs13+oas2HM/sF2ACAbjDsnMd32TK05xGvNNaV19N/8GJIbCRy94N3IWWcd1hf
 rohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743459161; x=1744063961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2djY+Ipfb5bt5gWpZJXDDTqZrYNZiOz6PXhVA3G2is=;
 b=UTq+lu4Vx4aD6IbofCv99Bva/m82ayhI4+EmA7UJxw/GyWLkUQMag1dDDTNRUo0VvG
 fxy4DKqEIpT7raiNk2BU4xYSmUib3oRD0h9tB4GvkKwuh7MRGvCPpn9XBJX5n5n+YpZA
 OLfJnIaYyfy56ZRGvINoutitJwL6E/+hg2PxfilJ7iZ1QkaN0soJPn7Y6LizpxJvYaIn
 5BImn17Vstv01vY+yORdGl/FagwSwQb7Icy4D1bqsal2+verYgr+vBHDzEHMpaC5qg+d
 r4HHBE+72dg5Cc4xJcWYIi/2ZWJt973HlQwfiDYPoBbRJ7lZWwYVPjgct4+iClBpFG5W
 OOaA==
X-Gm-Message-State: AOJu0YwwgCu1RL9S+scbJ7rTJ//T4pPOz3a4+fRuURe2qLh+LrE9XIVP
 ozW7McuFd2GnPcJIvwQgj6eBpylBNONucxXg0RDFotvzNBr2W+4T6jKZZzXnugZ4iB6T7Q5PiJo
 E
X-Gm-Gg: ASbGncuLdBoT+pu4c+UCeFzh8wTWvqCd4b4uZAZERoCMhMuxlaSIfuDCbVYYS3ZezI1
 GQ504r3ukDPslBsVzENzk+zFJrgh7JRIY/hZMOpwbZ7xcYS4fmeSGrcsOvxaZ1ZAMpVux6gP5v+
 BMf3HKFegGz8a4NOb+9zjBfmHdgEuqFNwnEa2vfUTJS5f2jqOc9RG7C1+sWb3fidT4uah5VOlvc
 ZCbA1LTSVGlFMb4NoeNdR4obTyqpKkINOP11b2x8BYRkY7QTbqEUSd9qPPfNdAyqRvuUR1tZ4HO
 dOPg/cR1pjtVhDjQ/cuM7hLNHAaFmB+geSO6D9MsxYpPAkONFwTYv3L7S/xdh1nbZGcgB2YUTb2
 V/y0viOjkIWppi9dOSuUZp9gd1537Cg==
X-Google-Smtp-Source: AGHT+IH13GqQsSiHztAMbjEPPDbY5+VFftXmzsCmEAn+WOU2JjUiY9lqfuimltA2KSMO1AHFpCUJOQ==
X-Received: by 2002:a05:6000:400c:b0:391:a43:8bbd with SMTP id
 ffacd0b85a97d-39c120deba4mr9061943f8f.21.1743459161515; 
 Mon, 31 Mar 2025 15:12:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d90000a09sm133627225e9.35.2025.03.31.15.12.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 15:12:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 0/5] hw/arm/virt-acpi: Do not advertise disabled GIC
 ITS in MADT table
Date: Tue,  1 Apr 2025 00:12:34 +0200
Message-ID: <20250331221239.87150-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

GIC ITS can be disabled using '-M its=off'.
When that occurs, it shouldn't be advertised in ACPI tables.

Philippe Mathieu-Daudé (5):
  qtest/bios-tables-test: Add test for -M virt,its=off
  qtest/bios-tables-test: Whitelist aarch64/virt/APIC.its_off blob
  hw/arm/virt-acpi: Factor its_enabled() helper out
  hw/arm/virt-acpi: Do not advertise disabled GIC ITS
  qtest/bios-tables-test: Update aarch64/virt/APIC.its_off blob

 hw/arm/virt-acpi-build.c                  |  12 +++++++++---
 tests/qtest/bios-tables-test.c            |  22 ++++++++++++++++++++++
 tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 164 bytes
 tests/data/acpi/aarch64/virt/FACP.its_off | Bin 0 -> 276 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 236 bytes
 5 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

-- 
2.47.1


