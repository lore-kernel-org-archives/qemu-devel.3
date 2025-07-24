Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F67C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetkB-0007u3-59; Thu, 24 Jul 2025 07:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uetk5-0007VV-GD
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:04:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uetk3-0000Yx-QQ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:04:05 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so611162b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753355042; x=1753959842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btFGmFwYqMh+p+kjij3lqKQ6Q1D4q7o1PxMUDNdZDnw=;
 b=V4cg4J5xO4L9WzkIktPVPIlQToO7J1xcrwHKC4oO3gNOHGcW+EbpHxf0Lai326gJ32
 9UW4xYHtivviDmhJbUZGbfQCKm0gEwRxJEMLrFRdUX6m2qGZ1tNXFsRTuOkWYExKqbcM
 mMlsVKsdXKVVeFU0LqgorurljElpwVcUs6QrHdD/Jz7a45Z/kIrQK6OB/xqeGU+Q7tmE
 XI2UZgKZzJ0Mvcdpvgm6o6D14X5unv516mudgl6dVIQ2t433jACHii6qYpOlRiadO5RM
 W/wO8QgQtkcr199P5cXthFZCVf8gxhHMs0TisrxQJIbuJPvvWFar+L3Lyw8dJOZhjdzq
 PkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355042; x=1753959842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=btFGmFwYqMh+p+kjij3lqKQ6Q1D4q7o1PxMUDNdZDnw=;
 b=CDleVKKJhip1FD5l6n5VyPZyZ2Mpv27sIR5CfNpb409jYnIVeGDLrZUjwIMAGgXhpO
 BSRa1qixaakPqibfusTXpaKqgD/hfUynoldmG7mVmlOyDBennAIXZllOFsDE60F8I2EO
 0hz+HV2sMv/NSWrODKph8qBU1UI/DsLFsrGHDyMwmXebLLkRLIpe6rj0Sn6RHlFVbQc7
 CbFtI703PsTbt3IrtBvf9rxHIBk7PKpHjB+FGcOXnH5SegK9lEsA1wR9CeN8JejGehKg
 /eQQdIL6D73LpUij+YVNR//8qBXHUYCe/zICEAg8ADddnj/xK8cQrU9Fhkx/Xs5saiz9
 w3Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzTbrTUlcYxCX5utCGnn6xmA25oi+VhV1bEuXb0FDxz1JJ8Bm9bQ+F+33VTva/m6Ey3NhpD9t1EjvR@nongnu.org
X-Gm-Message-State: AOJu0YxsobLip4fRWOI6YSMirJSiq7ujr/Lgd214r2eYGucPIuE0dUow
 MESHC7csWGwAXOBnOkHM49sAlEp7BE859yygCP8pyHx2qqQiyPM/73l2PY6NmKyL0Ms=
X-Gm-Gg: ASbGncs3YLHfCo9OCQa3OuuG/JJoCqIea/isgYlnCvD3mjmrXOFJtCFxKM9xQICdJ2R
 w02fs+yA3Q1p+pr68IuqCIAwvvtHYYc40VxUcDUE407WYMHDVrOEOL5ttQDwvkauH6tAyv6Bk4P
 w1AWiruqd76GfJt3WexY/RewvQBxVoRjfayQahCbJ4x92JnmFtLSv90/fLeXnaSca4bbGp1MoLU
 S555iX+90r4mTh4W1qEzr2mRSdoMFwUynCJy0bBI4Vba0LIsDqYZ4nMEID3AWBWlQ7KxFOTJqAV
 hrIbhQJm4kce8aaVyp0N74Gu6C9bPru+sOlCCOBSRyb125pk+qrBvMWIM0xW/AyYcJRxopAkMAs
 dt9IeiXDs1JCY5ed+gugjx2lG4tWSbssjgWtD5UWP8l6wME1h
X-Google-Smtp-Source: AGHT+IFLvEBq9Lje7ydNczcE+xnPtUf3vb4Abfgp684Md3miws5gwcqPVh+EWfxAuKxkNfOe0QGspg==
X-Received: by 2002:a05:6a00:22c9:b0:751:6771:f76 with SMTP id
 d2e1a72fcca58-76034cd52c4mr9139073b3a.12.1753355042421; 
 Thu, 24 Jul 2025 04:04:02 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.219])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761add64fd1sm1430578b3a.13.2025.07.24.04.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 04:04:01 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 1/3] bios-tables-test-allowed-diff.h: Allow RISC-V FADT and
 MADT changes
Date: Thu, 24 Jul 2025 16:33:48 +0530
Message-ID: <20250724110350.452828-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724110350.452828-1-sunilvl@ventanamicro.com>
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x436.google.com
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

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..0c3f7a6cac 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/APIC",
+"tests/data/acpi/riscv64/virt/FACP",
-- 
2.43.0


