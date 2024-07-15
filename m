Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681E5C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPFK-0006I7-Vi; Mon, 15 Jul 2024 13:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPFJ-0006AX-Be
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:12:17 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPF6-0007Oe-Cb
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:12:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70aec66c936so3284919b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721063520; x=1721668320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU8GfqelSqXJWaHbA4tCleDNQ3MgjXFsCeI35E4yuvw=;
 b=jcf2jEQ3b3NaWHuawJ15iRXOrbi2EuRE/ZWz2DXDQAY/CtY+pZb0+YhHdcYqDtLZjM
 izua1eW/g3nJ5hkgi2Se7zPq6G2egAsEzfQyA/QcViKGJ00DxZHCz/LgG6/U+9NPBXij
 OmQyAITNxS5ZG19CX4MTF0rgpi5bcDxjL4U+enIsx+q9upDVKPJZ75A1FLTJmByW3gl5
 Euosml3rXiIDk1WuX0dReEsfsKPeADfML1SKRpxa9pPKf1bXBz9SUg7R6nukAUA3nRsc
 xYD0+B00Oj4suRnCAyOWnqjJlYLmFSta6+57xuOXVeByUll/BqZxBIgdeg/97V+YLTbY
 kEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721063520; x=1721668320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SU8GfqelSqXJWaHbA4tCleDNQ3MgjXFsCeI35E4yuvw=;
 b=w2gL7aDGbB5Q9OwhIFxQyihzQ+AC/ror4ia1IynhhJ8agvgqWqwPrll0nQJkK7GvDe
 2kQhpfWgO7bniUFULuy/9V91MVsynLVHO74RDEkZpdVi66Meld3M5UB23lOeArKGg578
 7+gCdQHGherlm+IpdyePx4nx1Ttl+0uAA8nOS6ObMr61/cltUjWvLkOuEq5SdFMSZwK5
 8NuM+x01aq7WSLbzc0FkEhAGXz/TBsKQsKFywL8ieL3i0k3V9bAVAradRnK3R9K4BzZP
 AmFLbqQH7KifK59437yuq6huWvEtKM8ISe6CbKRpoyJmZUmKvM0Q/9drD7T4pAfKrDZz
 RnsQ==
X-Gm-Message-State: AOJu0YwP9UjjvGTbaoKNPuwM1ZUWdAegQ3uHY0c9ogavpEl6OEgT9fCf
 cinZnkiEN0tR6HbdcamK2oXb0C3lWG7lXaenbAukBqNmSJoyO3zFAoRozs6zsQ3APdp1L8pjCj+
 UZ+Q=
X-Google-Smtp-Source: AGHT+IHzUjNTiqIoe06grykEkXT6F1ydZ4/wxtgXr16vTuaRQEgoq1nB0cpGc94v4OQy3zU74/TE6A==
X-Received: by 2002:a05:6a00:848:b0:706:5b9a:b6d5 with SMTP id
 d2e1a72fcca58-70ba4855d7dmr349502b3a.15.1721063519679; 
 Mon, 15 Jul 2024 10:11:59 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca85ccsm4752618b3a.178.2024.07.15.10.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:11:59 -0700 (PDT)
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
Subject: [PATCH v3 6/9] tests/qtest/bios-tables-test.c: Remove the fall back
 path
Date: Mon, 15 Jul 2024 22:41:26 +0530
Message-ID: <20240715171129.1168896-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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


