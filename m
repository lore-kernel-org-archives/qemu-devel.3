Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F712C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIM-00022y-FP; Tue, 03 Jun 2025 22:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeII-000226-NA; Tue, 03 Jun 2025 22:55:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIE-0000N7-V8; Tue, 03 Jun 2025 22:55:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23035b3edf1so57515765ad.3; 
 Tue, 03 Jun 2025 19:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005751; x=1749610551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=BOxyV7A5wkw9VHMD9tX5I+ex7BtKwvVTWy4SVGhvFrk=;
 b=HstHK+Kir9qMh8FQ0AuoyKDUd0HZ4Foa8XrmGJ7VoMx+42gm0f0uffFWkdYd2v8H2s
 HCCRXrvH65V9kOy7vFJ+um/N7C1rZlc3Zgd/okaoAlj/06ws1mPRCJYkh8fIhyapDVQ+
 TTFXJ5eE1nDBo2COqIFDWEJwpBTTL2Tak5s3kYJewx7eixNADk8EzCjGuR0YqsWf3bax
 eEru+5cQ61WHkI3m/8ixwLIJIUsZf2x1CYkUkNfBeK+N6TyPOmVxd/ZdwvSZIpwyeXK4
 +KgJ1mHItwCAK0OxcnYPkcHfMejWIVZzTkfw3+W+g6U56dPWg1xYbHA5ijnwZX4UFO21
 sxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005751; x=1749610551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOxyV7A5wkw9VHMD9tX5I+ex7BtKwvVTWy4SVGhvFrk=;
 b=DIfrb9DzymQcSh1Rkor8qBj+c6nbMuCpSSLE2gc8t6QL359mOehBaAS+4awOFYF/jq
 bEMHpRz7YpEaQgaJPCf5pOduN4CBLsljbNb2kbtw26U9F2saZRwWfU9OuVJyxrzuN+wL
 hSFB31QMX/NupxUs/nQ9NbsZsz4sPo5mnAhIU4zF0WCYVKrRLsRJHZ2ilNKcZxy/P+Cn
 AcbirsdJNQhjwPHX6B9inIzEd3+h8swO7CPgltTUb/eQAIzQ0HofsqzSBhNoRgWoEl+Y
 d1aal1gEbqyrEKhM7Wf0gQDtpQFsqD4aOu2Cgch8OdaknxFSNYSpIaCCf+yBWMZlV9hS
 ncDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZx6gjIMErRqoz67HMrXjJ73gVk+xUoslCvfY1YJMTBsm2up2ogjnJrYZoqMtRFuEQsgOcZeaqqAYl@nongnu.org
X-Gm-Message-State: AOJu0Yys4pu8cOOcab7/jqbsD9EvUX0DYh2u/yDPqyxu2fxrZKx4raiv
 3yKIJOf7HR8pH6yhl7yM9U21Ujk4MKn4aezXugZQi4heatYH6lAsxdgv
X-Gm-Gg: ASbGncs6YxVQHyV4fBhEjRgoaZiZyzRqyiibMO6xnK5/paJRtV2TAW7bvKcLGdV5LuR
 hhF2YADh0bcyGCL/kOlhOb2hWxMSam5+ycLjxai2S/aLcWlB8+xYqzYliNOZqqE5PKaMq7hCceV
 KRrxx35LzweAvOJnpJPQGLPuBTR5P7CNn+G+g3HDa9xKu2I36DbFZd1p+UYH+1F9BXjYuN+9f9U
 uMY1rixu2E602xeEvHJpkR/vuCPbG+f4q3EIx2Ig3+uR0Ls6CuSZ81r2mLeBVnHH27wb10xtS5O
 WkSBhwXibBsHhK1BXRB59Cq1u0koi7XhwuBYwmJXOFE3xlzbQ18MxMu2B3Gsxw==
X-Google-Smtp-Source: AGHT+IEdDm385odiUkgu/TrCJxmJNQPNCkdppCs0yTFP6kXYHH9yZPtm2kuiNgltbCkmz2y/pdobSA==
X-Received: by 2002:a17:902:e84a:b0:234:a139:1210 with SMTP id
 d9443c01a7336-235e151c957mr15703565ad.53.1749005751182; 
 Tue, 03 Jun 2025 19:55:51 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:55:50 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] hw/riscv/virt: device tree reg cleanups 
Date: Wed,  4 Jun 2025 12:24:36 +0930
Message-ID: <20250604025450.85327-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62b.google.com
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

v2:
 - Rebased on master now that Daniel's changes are merged
 - Fixed doubled up patch 1
 - r-b tags from Alistair and Daniel added

This is a set of cleanups for the riscv virt machine device tree
generation.

Using dumpdtb the old and new device trees are identical for -M virt and
-M virt,aia=aplic-imsic.

Joel Stanley (12):
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

 hw/riscv/virt.c | 66 ++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

-- 
2.47.2


