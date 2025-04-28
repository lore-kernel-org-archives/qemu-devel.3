Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAC3C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1w-0006b7-3F; Mon, 28 Apr 2025 03:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1h-0006P8-Ob
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1f-0001Fw-Si
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vI4DnVjNkhsHegIRh504HY8E3e3XL3fmDWImMxQ9guA=;
 b=S6zGtCBWRECVSe7Ji7vRa5NLwItG7r7y9AqhTutW9PbXJl4YEofyKzYZOsKVlpQ2V3Jvoq
 4d/ByWgmuMd5b/nQlbbNYglh1SKAenfTeqvXuTu/MiWlubsR69KYdMzdfqBmWuaJCMf8FI
 y7tMH7TSRovMDCiqtotJ4BzA+rtYo0g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-OoyEIMcFPwu1sew9FgasnQ-1; Mon, 28 Apr 2025 03:35:36 -0400
X-MC-Unique: OoyEIMcFPwu1sew9FgasnQ-1
X-Mimecast-MFC-AGG-ID: OoyEIMcFPwu1sew9FgasnQ_1745825736
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39979ad285bso2015663f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825735; x=1746430535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vI4DnVjNkhsHegIRh504HY8E3e3XL3fmDWImMxQ9guA=;
 b=rwrD49pjaN0SqEYZpkJ1ymfPhInEltbSYj6YfTrEXtXZNueosRb3dMEo5u50C3jm9f
 gz5pdA5LPCo0JuWHZo7NepfRVrAy0AZxT9UM9e8c9Hh6UaxVLddn2l7GpojVyx2Sd+ze
 jLpXFiRRM26hg3uTyQ3mjBHZJCKeRGWw7DrPuhI8rw2nhhODz7JITtv3Sq1uM+Wrm0Pe
 1xWyZ1F8VfM/GySPOZTqlUd31AF5ci2Xwxy8NFHktQrhA0bJ/vj2jbKCRigJi8sBp0Ma
 7b30maLoxDh4JqullxmXN0vnrDiDLNuuvZFJG9njbqB/O+DDc4Ax/BJjdokEXt3iZTzS
 EZwA==
X-Gm-Message-State: AOJu0YwnwjpvP4Ytmm6aWN5LY0T15UqQdnxfoEGqfBQ8l+/3kooJZMvb
 lnBW1U+74ZBYUgBJMF27CppABUaHIODbSbwexj0kBNTAITj3UQsDAOLBRgz2Mp8AprdxMZemRw/
 l4BOcWvUe9v++91nWc80i2Ll/UC1xgZuYTJ+YckjS/1ujhLcJw+2lxE8V4a951dj+XtD3VqZfs6
 Y+jePWy0NmKNtYiDuN38G7RcT8Ihjq/uyo08dY
X-Gm-Gg: ASbGncso3Srfr1/2d0CLrjqFX3JBuU5ajuL5qhWbJL0ob9pcJdPRXY0Mn1G+JOeaqT0
 gEOGB+xSFjCXemviIt8uFUzu/AoLuDFartUj7RToVcnyU0Zbj485lP4oD44rhYALo7E0t7/rIrf
 PgVlyczzhtYUqHV460BDZ6N9tSwJMWc7SVnUr5Dp2ESlstoYokMwqefE8wPIROCwTZsxPJaCU4/
 /EmwgIXQrDCMeV5stWKC7YFkNRg8hz07WtqiOFBprtyQrETrLBH4+oT6+IY/Oh/CWKD6vmM6iQv
 /WfdOkHgb2Hiuw0=
X-Received: by 2002:a05:6000:2207:b0:3a0:839b:f52c with SMTP id
 ffacd0b85a97d-3a0839bf543mr2116761f8f.0.1745825734885; 
 Mon, 28 Apr 2025 00:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsgg2c45KIzdjb//p8F4NcdZJkmEEbAN/XL0QZHdqNH9Otv0Tth1ekIO5tkatzobSnkvLi+w==
X-Received: by 2002:a05:6000:2207:b0:3a0:839b:f52c with SMTP id
 ffacd0b85a97d-3a0839bf543mr2116738f8f.0.1745825734514; 
 Mon, 28 Apr 2025 00:35:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8ca72sm10082753f8f.4.2025.04.28.00.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 20/26] target/riscv: th: make CSR insertion test a bit more
 intuitive
Date: Mon, 28 Apr 2025 09:34:35 +0200
Message-ID: <20250428073442.315770-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation for generalizing the custom CSR functionality,
make the test return bool instead of int.  Make the insertion_test
optional, too.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/th_csr.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 6c970d4e813..969a9fe3c80 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -29,7 +29,7 @@
 
 typedef struct {
     int csrno;
-    int (*insertion_test)(RISCVCPU *cpu);
+    bool (*insertion_test)(RISCVCPU *cpu);
     riscv_csr_operations csr_ops;
 } riscv_csr;
 
@@ -42,13 +42,9 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int test_thead_mvendorid(RISCVCPU *cpu)
+static bool test_thead_mvendorid(RISCVCPU *cpu)
 {
-    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
-        return -1;
-    }
-
-    return 0;
+    return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
 }
 
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
@@ -66,13 +62,12 @@ static riscv_csr th_csr_list[] = {
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     }
 };
-
 void th_register_custom_csrs(RISCVCPU *cpu)
 {
     for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
         int csrno = th_csr_list[i].csrno;
         riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
-        if (!th_csr_list[i].insertion_test(cpu)) {
+        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_test(cpu)) {
             riscv_set_csr_ops(csrno, csr_ops);
         }
     }
-- 
2.49.0


