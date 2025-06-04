Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A9BC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIW-00027T-Ud; Tue, 03 Jun 2025 22:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIV-00026y-5w; Tue, 03 Jun 2025 22:56:11 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIT-0000P3-Ms; Tue, 03 Jun 2025 22:56:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2352e3db62cso45450195ad.2; 
 Tue, 03 Jun 2025 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005768; x=1749610568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=trWsim9P8VoeUTyxM6i3oLW4qplPzfRCJw14dYpxdW8=;
 b=Uf2U72wuDZRXq4i7VlyoXpUOLWLzu4vbGQ+29xlZnB2Ie22cNqmu7axtIb7kG/hDKf
 5kgj8D2yekZEnGLRGXfLiRlIoVKS/tDsU7U/rgKhA7viLp0su37R4mfhQnANriFRu2h+
 DpeRNDkYJACq1GeWEjqdC3VM9jZvIeGLIo7vpPeoNgCgB/enL546/PvN+Fgg2LsNoJQX
 lKGad8nnUHXng1mNB8pcRaA/n4ncpdiQfRY1OtP160yYTG3pVi+kFFebxEaClyWAnPDe
 gk3NTClKxD2ed99T287bsnRhAmYQ0rxNHknCUB0qOqedGINGugllnUOIxK5uFBPWioMl
 E37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005768; x=1749610568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=trWsim9P8VoeUTyxM6i3oLW4qplPzfRCJw14dYpxdW8=;
 b=EwBxOZa6aV9Al/sp/OJtHs5AfCWNfUs5ePbQmq0EDJyiOAR90CmUUeBP4fTVhG5ny8
 y4Vp1Rdn/gYmK0ziXTLLKSEI+0FIKl8Hf6ABqb4lINIQ6ERh0OiZyUQ8Uy2bGo04lLsu
 FB2oDBr4vAtSRMOY9oQ8DpFi9IgDcjwu8spZxks5z1/hSXj4hGSKyxl9Tj94s5dqlHKE
 WqJsW2vHGl/DSSllJxH3Pt8ocdaRDXLiGZieHK2uI5QxgqvtAUA9t+odqIkzlywosD1V
 LKfaILikopN6oUEvql7rKEFd9cycvcqtLFrGyP2iAo/egFbS0KoRj868vbj54ehuahUT
 +cGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvdxC4yWmllog6Fdnl3KFy/iu+NHhPnK5zzDpvsio9PgJx7ibey2+JYHVuaCUD3xm5+qfVG6boL+Q0@nongnu.org
X-Gm-Message-State: AOJu0YwyCP3waotV0DEF4hH0Y5wXYC5sVzxXwoJikLoDfqwo3ZVzDdCr
 oSYfdph/MPemZ1uX+QOL0qx1URCCbpFInH5C008jLbhR8m0PZWSupBb0
X-Gm-Gg: ASbGncvjdGtuSJaZ0m1AtwP42mApDrkjQMk0Oh57VX/luW4h1O3NM1UOC8g+5LKXEaq
 3giLXIHkYRhakeb8jIaWWk3oYyDgnTITahQ48kp0uUUhDoDbxoUpVZHqZQLp3LpHQXDvYXSbN8J
 OskbbC2OxpjYIPWDmcPbUbzHYcURvoENYcKdu13U+j41d5fkIvC5Dh2mQ25KiGiVgrSO62PE7n5
 gm/rlsrYOIHN9OQgc8EQZySrrt4odQkupCGZVBtEkwnGLu0nfgcAGzL+xQEXgsfzGqralBk6WDR
 my0HQiZ1kPB/siJI7Mk0u42lKZGFf1qJbmwI1j0A1K83eKAiHwpgLufVot8JnVvu7tY8Q3Mh
X-Google-Smtp-Source: AGHT+IEgWP5CfQZOKawlyNQMyeptgcxlhdwqOxDdDDV1ajwVTv/Wj7QfZP9bpwAMlmOnyOhJUuExGg==
X-Received: by 2002:a17:903:2349:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-235e0f2c875mr17881135ad.0.1749005768053; 
 Tue, 03 Jun 2025 19:56:08 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:07 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] hw/riscv/virt: Use setprop_sized_cells for aclint
Date: Wed,  4 Jun 2025 12:24:41 +0930
Message-ID: <20250604025450.85327-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 205fa6e44f29..4fd966a34277 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -387,8 +387,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible",
             "riscv,aclint-mswi");
-        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-            0x0, addr, 0x0, RISCV_ACLINT_SWI_SIZE);
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+            2, addr, 2, RISCV_ACLINT_SWI_SIZE);
         qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
             aclint_mswi_cells, aclint_cells_size);
         qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
@@ -410,11 +410,11 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "riscv,aclint-mtimer");
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, addr + RISCV_ACLINT_DEFAULT_MTIME,
-        0x0, size - RISCV_ACLINT_DEFAULT_MTIME,
-        0x0, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
-        0x0, RISCV_ACLINT_DEFAULT_MTIME);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
+        2, size - RISCV_ACLINT_DEFAULT_MTIME,
+        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
+        2, RISCV_ACLINT_DEFAULT_MTIME);
     qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
         aclint_mtimer_cells, aclint_cells_size);
     riscv_socket_fdt_write_id(ms, name, socket);
@@ -428,8 +428,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
         qemu_fdt_add_subnode(ms->fdt, name);
         qemu_fdt_setprop_string(ms->fdt, name, "compatible",
             "riscv,aclint-sswi");
-        qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-            0x0, addr, 0x0, s->memmap[VIRT_ACLINT_SSWI].size);
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
+            2, addr, 2, s->memmap[VIRT_ACLINT_SSWI].size);
         qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
             aclint_sswi_cells, aclint_cells_size);
         qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
-- 
2.47.2


