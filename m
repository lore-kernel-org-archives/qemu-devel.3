Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE50FC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmqz-0002c5-Iz; Mon, 08 Jul 2024 07:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqx-0002SK-6A
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:48:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqs-00011C-Kw
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:48:18 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70b04cb28acso2436630b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720439292; x=1721044092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4vibiRM2Ycijj39xNhYMRluwpiZKY+DashjwuFIx1pE=;
 b=mbfaaYDBucueC15Jq1E/PJfaB3XGgprjChqHc7XUWIaTd3gMg6Up94gtPORTHQCD/c
 CpkH1TPYX3NztBqa79U39cP66nVotnmrcxvwpPyyuVr7UvzNWBeEHCPunNTBfBRkilmE
 aIE4VtZW00ayon5foPy9LmjTeUI1LRNDkom5O3MHDOyu2eQBx+z5qFCYTuysGlqWQYl3
 EYWqTVxYxepRor85bzl7nC4RDeQaRRX71wjg3QXffYee5ar7ubPmtJXVsGQtjaWWJPFi
 vdVPaPo5X0bW/LdaigUCLKn5TqY9Bpr43+8fSihAPc848bipYjMZ9/BCzrQnu4V7R5nX
 AseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720439292; x=1721044092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4vibiRM2Ycijj39xNhYMRluwpiZKY+DashjwuFIx1pE=;
 b=FAg6vrf0tTXEwEwZ+Vg8e9vSgJ5U3uUtz9Vn7+u6mogUzITpziUDRSgU/IF5juyswb
 Uso9imY5/AHh+TXb588aq9JwshI7Sw1ELrNYrXKwHTXR1EXkjYz3Jd49wc3lUVoFTlpN
 Xb3/LO4YOC9GcaI1+TNprL4KhCrvCTpQTcNuzMEK14Wc9MOMx5IYcQG+/fw+PgVaQwTh
 dY9LC+S/k/J73hW05a9Crl9SfsCdc6sXxmIPBdqGk1gvvSsjUuCOeMmQ1RaaVz2Pfmnl
 Lj4jakdCDL97oejMvHBjcMl8qxNgE4Lu+/09a6pwlcS0pnt38Kc/7gh6Cq7z3bAR7+qM
 /q0Q==
X-Gm-Message-State: AOJu0YylmjEg4v4ROGzweyZamOEfawN+jP19yzgQUF042uXMUf0b48eU
 /bfc0hrErRBgMZDCdlXdHaIuKEv11jiAOO7U8OzWHVTdC5sw6NTlaDOCmPTMKaGcDImvKcAc+oK
 J
X-Google-Smtp-Source: AGHT+IEOWb8i779e6ujRsvtbNIOuwfeLh54eaHFi0UPEGCuVJS0veX3Zkjs45LIjX0COOcLyNwb0xg==
X-Received: by 2002:a05:6a00:17a7:b0:706:738b:2c3 with SMTP id
 d2e1a72fcca58-70b019a52c2mr17200162b3a.2.1720439292443; 
 Mon, 08 Jul 2024 04:48:12 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b2a432ac6sm2769642b3a.94.2024.07.08.04.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:48:11 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 6/9] tests/qtest/bios-tables-test.c: Remove the fall back
 path
Date: Mon,  8 Jul 2024 17:17:38 +0530
Message-ID: <20240708114741.3499585-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x429.google.com
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

The expected ACPI AML files are moved now under ${arch}/{machine} path.
Hence, there is no need to search in old path which didn't have ${arch}.
Remove the code which searches for the expected AML files under old path
as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 tests/qtest/bios-tables-test.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f4c4704bab..498e0e35d9 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -267,15 +267,6 @@ static void dump_aml_files(test_data *data, bool rebuild)
                                        data->arch, data->machine,
                                        sdt->aml, ext);
 
-            /*
-             * To keep test cases not failing before the DATA files are moved to
-             * ${arch}/${machine} folder, add this check as well.
-             */
-            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
-                aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir,
-                                           data->machine, sdt->aml, ext);
-            }
-
             if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
                 sdt->aml_len == exp_sdt->aml_len &&
                 !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
@@ -412,11 +403,6 @@ static GArray *load_expected_aml(test_data *data)
 try_again:
         aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->arch,
                                    data->machine, sdt->aml, ext);
-        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
-            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                       sdt->aml, ext);
-        }
-
         if (verbosity_level >= 2) {
             fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
         }
-- 
2.43.0


