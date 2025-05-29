Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B0DC5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 20:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKjmn-00046D-ST; Thu, 29 May 2025 16:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKjmj-00045I-NC
 for qemu-devel@nongnu.org; Thu, 29 May 2025 16:23:29 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKjmg-00066B-MW
 for qemu-devel@nongnu.org; Thu, 29 May 2025 16:23:29 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4e45a626663so351973137.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748550205; x=1749155005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKU8+wgagP2xmhSVKthNu0gF9sPW1lHUddlhIztOA9Y=;
 b=dUooKqHl4FkN5tD1Sg7NSkLrbi8pssPxL6GAmw5g3bfBo+h2be+ySEkV7OHR9JFVRV
 W5KcisBTvyIDnWJohXAZrg+gdu3w1N8QvjvJGLpqkpNgzDyERdT37aFMpkq9sIaO5Wme
 LLccGnpgbFZZXxpmPEMDVArc8cp59M25ELkXTd2SV/dydf/upmi9jb+6X7TlfW2XSbYf
 A8cSuoVwq2V6SHHNwO6hp6WERuFlusaZkEWIIjdChM5hlp7WmsQDTd5xXEL4FXr0aDi8
 H0rgGYgb2WsHyFXmYmY6tHGZoqq3cPJaw66yOL2g6TihVQDQ907M1pw0HOlFMtP+7/b0
 8s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748550205; x=1749155005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKU8+wgagP2xmhSVKthNu0gF9sPW1lHUddlhIztOA9Y=;
 b=wkZgZ4n0w9SY3sPVTAC3why/6Tzij3gZ69Ni2+jTLtqLMR/hX4FR7EJYLb4hVJ7Zpy
 UYbgNG39CelUVWSrv6WsaYd3GylQ9QoXTSwj1CeaCs22XvuVqmaXskoYEGBD4slnGt79
 q9Whwid3kin5gOWhSgKsj9GXfh+E63LPhdUf7vXYcmxoLp1k6EEVr0Qy5CKt+Js8Twmf
 IP7uO4yiBF7eBrIgfaqInlYMNlmkWOMJFtFtFhLyAJ1xAXI7U7A7SW7W9Hik6yKCJBdK
 V2nsZyo1Q6tRgvqFvOCysu2ZxZ85xKjlwAX9po8iEdNpA1jXB5LsJ+JoxA5HvAvAV5pO
 SFPA==
X-Gm-Message-State: AOJu0YzjgdVw32jGEf7p7IMRpY7ibYO5WNLxJxu1aaIpCIugHlgYUB6x
 bZAHO/CYk2oRKqs//ZrTYmrozO2qvYc8bB3NeSrhLdQHYMfqpGEkPle9/NZ1rUxq42EHyBhxF4H
 7hUS8
X-Gm-Gg: ASbGncsD6yzN2bxCjNlZ7lMUzJ2v8PBr12GB4G9s/smlRRpdZceNV79bBMbGAb6ROAv
 gXE2BMf3/o3km5VBLNecJRGjm73apJtyKkTPqAf9kGlcbvZNI2UUyrWCcfHlxRS8oAXrapxKtIx
 nZ+F+MVFgkuU4O74Xd9z0UIMri5WJV5VPILDCi5aXN/icEEPrY87dez8bcdMU9RhQrmAP1VcUPY
 /z6Af+Vh+ge8HueEXumFyMBYBmwj+4wdWM/6iGpRHEOvgJ8kgWD1B/nzF2QKD/EcNUTC9up7wQQ
 ZHDtOy/YDJFhFZBGAIbePbYCeN58vyzUf5kvYD+jUy4XFTssbU7RzkZcwG2djGzOcd0yL7//9+6
 4khEu6qpx50x4Pw==
X-Google-Smtp-Source: AGHT+IFE6QryUIxLXTBvg58qdiEV4IAAFz2Kqqr4oOfrDQsmtUyI/7RGrDXn9ok2z9/49XlBtiy1JQ==
X-Received: by 2002:a05:6102:38d0:b0:4e4:5ed0:19b2 with SMTP id
 ada2fe7eead31-4e6e40f6e8dmr1401725137.9.1748550204856; 
 Thu, 29 May 2025 13:23:24 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.35.190])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e2a2c774asm1647137241.20.2025.05.29.13.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 13:23:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [qemu PATCH 1/3] target/riscv/cpu.c: add 'sdtrig' in riscv,isa
Date: Thu, 29 May 2025 17:23:13 -0300
Message-ID: <20250529202315.1684198-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
References: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have support for sdtrig for awhile but we are not advertising it. It
is enabled by default via the 'debug' flag. Use the same flag to also
advertise sdtrig.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe21e0fb44..9d6fae72b2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
-- 
2.49.0


