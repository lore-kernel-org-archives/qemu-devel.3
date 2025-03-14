Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AF6C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 05:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsxOZ-0005hs-AU; Fri, 14 Mar 2025 01:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1tsxOU-0005h1-0y
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 01:15:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1tsxOS-0006t9-HH
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 01:15:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224171d6826so42722115ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741929335; x=1742534135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cRaJn/P+x+6WN/SFVe2m4RS+pjGn4ofoWNcOqY5FHzM=;
 b=Qf+ojujV4bRovx7QdD4C0nIAuro8HKyRiCqW7FW3gNz3uUJRH8xSGFSEIEYltyxjaH
 WCJZeZ48k/o0VfZ+40bPj9OMcToRAg9we4Wz8bRGi3KKJMlbgu56k6/SDGqQVQc9f+cx
 FOm6czHjPgQobvm45KIrG+GjsT9pD1nQO3FKMy6TuwNwSo4nUQ6bueLk04HSna2VKXwn
 b4H2/NOyN2IYzqbbQpty97H8Zmcup7WukYzwAHGKNXD3Mk+g1h+sppItRsyVkuIyRx6D
 StDtLvImfsjJzdC0gexTjYp+IWCxznAHv9IuUozjjZtD2FqW+7Y1tTKO1i0kPLPZlHbt
 D9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741929335; x=1742534135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRaJn/P+x+6WN/SFVe2m4RS+pjGn4ofoWNcOqY5FHzM=;
 b=vzIz8chqStIEI8KXBv/ISQV9E00SHBqWGSGheF2s9RKfohP8eVp/Ctc7rjQUy1mNhj
 zQ9AwsbiL6ZNAoHp2EwTnhb71YuCbGhHtn4g+iY5whzd0YMV/VtKU0qMhsNGB59C9KwR
 XkfQQ2EWL4N7wDnF9b80D/7Or3hiHc73byTwg8ZRps4uIILWPbR3adVeSJJ8S5ksFMWK
 ETzHi7SyNsjf2Vhq8ihG6xMAJccNgXT9pa8keRxSNLsu8zE3tigwUjzR4HBP8JBGJZp0
 5QCM3QBvUd30JP2Myoz2aza5GSHtG68r3L5w4g5HM1V1Gp09cgCNE7+KlWwJ5cVtuq6z
 Lxlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5KZ4PylG+9jTeY50DSM+BBw072jjKslazkZiWhK357ZHSPqC2+pZNYuWeyEC42vNT/Ug7fQwG8DFM@nongnu.org
X-Gm-Message-State: AOJu0YwmH9j5Fj0BS4e8lKap7v5EqRcTNbmegSgFypqUss5VhETyz36S
 ypVarNPXRk8aFUE0rx24dTpMRFwd0lkEYNM49hxvOoFNvQR4cjYVrk6JKiLYK84=
X-Gm-Gg: ASbGncsT15pbVB14hQmnEGTdEzU0Z3p28SqMOiqU95+IkL3sPGRJO9+O1VYCmEzOi+e
 dDFxeqRwxS8prA72j9x5TwqIQ52qd+8kkZ1SK5jLxoHyKjTsiWdy5v2Cxcu45/dQrGZ7uL5w0Pj
 0AfjHXK5/TQUQkFNabqrbDUfYspZ8oZR8CJ0PWy0Cz/kWI+gpOBms5bjd8ddDiwH8NNzuMR6HJ/
 JOJq3fNFGbtHKVSLNTkfmyMR1xZ+I0v9Q5CX1gT7FQbzrmeW89g5gUDEiO4oH5drzFJLfehHeHh
 Ifl9Av/0a8nWLfd9DAaLYrR6tL4oOG9u6T08oeYd9s4Mthxg24olXYs=
X-Google-Smtp-Source: AGHT+IHL3/s1OGomVkiP0UOA6VoDm23gGxk3h1gP2xwWhR/UqusTH5CcSOXaNOeu6s/6AnISrfJitQ==
X-Received: by 2002:a17:902:e5cb:b0:224:1001:677c with SMTP id
 d9443c01a7336-225e0a62fcfmr17249915ad.9.1741929334649; 
 Thu, 13 Mar 2025 22:15:34 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbeb94sm22278225ad.199.2025.03.13.22.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 22:15:34 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Atish Patra <atishp@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 0/2] RISC-V: ACPI: Add support for RIMT
Date: Fri, 14 Mar 2025 10:45:25 +0530
Message-ID: <20250314051527.1892488-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x62d.google.com
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

RISC-V IO Mapping Table (RIMT) is a new static ACPI table used to
communicate IOMMU and topology information to the OS. Add support for
creating this table when the IOMMU is present. The specification is
frozen and available at [1].

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v0.99/rimt-spec.pdf

Sunil V L (2):
  hw/riscv/virt: Add the BDF of IOMMU to RISCVVirtState structure
  hw/riscv/virt-acpi-build: Add support for RIMT

 hw/riscv/virt-acpi-build.c | 215 +++++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c            |   1 +
 include/hw/riscv/virt.h    |   1 +
 3 files changed, 217 insertions(+)

-- 
2.43.0


