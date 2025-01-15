Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDE2C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7s1-0005UP-3c; Wed, 15 Jan 2025 13:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qt-0008Sl-9c
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qo-00073p-SL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YTFWj4vrkS7z96ILKG6Zp39DvnbZjnd3FKkrmyKnnqk=;
 b=CHFsJUqMMYKbWByAtqw24GGJOrMtCF+T6oKxnGo31lFa0dsTUZwemR4OIZjsDpuaaKLgOr
 5cdr9poeR6PKOLPeBGfNpPt3ce2ARgniQ8l9Jh1Fsnngq+57HUtEi9KKDlw0CLSzCChgmX
 lWKiyDA0dmFGBb2Wml69OzeDG4MQt6M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-eVgKupWYO9yhAjEkPMEaIA-1; Wed, 15 Jan 2025 13:10:43 -0500
X-MC-Unique: eVgKupWYO9yhAjEkPMEaIA-1
X-Mimecast-MFC-AGG-ID: eVgKupWYO9yhAjEkPMEaIA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so36836955e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964642; x=1737569442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTFWj4vrkS7z96ILKG6Zp39DvnbZjnd3FKkrmyKnnqk=;
 b=qTmv2QtlD39ao5f0iArOrib+XLoP3Bk32gQ4FpyQVBopGAnQqR0V6S4OVJY+ue7EN9
 gIkbbpgm4nWY3j/73X+dNxFTXUoAEM0u8xXJ5785+luUVhwYSWYKdlM7Y4NZsLk6efAd
 aoFqh17YYPx9XCFp102R37S2SqsEtA6e97TCzreLd0i/08gEMM6HrayWIEmSVtAqoNPo
 AofsbUb0sybGfhwBqYZWSWQg/U7472tLAGn5meMGgcY+cRJv9KQnbq3aTMF28PgDx0zE
 K5CCoUWnnpqX39U1GpnzSObYK3cQrckbw2kMyz/degTGM3ZtmfYXG3VX4hnO8Fn99/nP
 mtJQ==
X-Gm-Message-State: AOJu0YwvAEkiHjOlXobjuE8T0U4tm/NDw6cuN9eR3POF0ka0O5Y28OIl
 mh0Mt0qmzoJTPFw1rtAcH4s/SVIFkLjsQQb3V7QQAoQTJdH468lgAoNMXUvugM1Y4e8ZnLwdT1c
 SQ5rSkSRAdl0e7/230E49K1qJ0xEyijH+231koQbvuyM43pgZseeewyFMcjCCgo5EFh2/tRFD05
 8gGfZqoQJKOJ7XPs1g1gVVoJv1YSEWEw==
X-Gm-Gg: ASbGncuFFmzsXMqH/cHdfT7oDwPfJY+dWUGZBQPGlet+/hmrxg2A7UrKKFzOMe8AVlJ
 IhVlzNKw/Q+eKFLSRXv9eVFqsd/Ewwu5/S5ATMt2X3AhsfWfUzuu2n/Lso46g4Gxo8Tp9U9vXHw
 hAag44mBpHZXueY8VxfcephIjYriSc69XsiqWcd5x4owfdw1sAQngeTORmFbS9p92uljBJg7lSD
 BtOUE9VG2ATE4YETUVnIx8FmNWiFasfgeXdR8foYXOT2OV73Xuh
X-Received: by 2002:a05:600c:4744:b0:434:a7e7:a1ca with SMTP id
 5b1f17b1804b1-436e26f043dmr254624775e9.20.1736964642064; 
 Wed, 15 Jan 2025 10:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWW/2mdIrRZrdn0KmsMFg7vNvL2Cp5oP0G16i9jXeuCukrpPekidb68kmwoQKb+U0aittTPw==
X-Received: by 2002:a05:600c:4744:b0:434:a7e7:a1ca with SMTP id
 5b1f17b1804b1-436e26f043dmr254624545e9.20.1736964641713; 
 Wed, 15 Jan 2025 10:10:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ab250sm31338665e9.9.2025.01.15.10.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:40 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 41/48] acpi/ghes: Change ghes fill logic to work with only one
 source
Message-ID: <47935fc1e56f02c892d186ef89be7c923f73c89b.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Extending to multiple sources require a BIOS pointer to the
beginning of the HEST table, which in turn requires a backward-compatible
code.

So, the current code supports only one source. Ensure that and simplify
the code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <66bddd42a64c8515ad98b9975d953b4a70ffcc6d.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/ghes.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index ddb576b940..b709c177cd 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -387,15 +387,13 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
      * As the current version supports only one source, the ack offset is
      * just sizeof(uint64_t).
      */
-    *read_ack_register_addr = ghes_addr +
-                              ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
+    *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
-    uint64_t start_addr;
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
@@ -412,11 +410,9 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     }
     ags = &acpi_ged_state->ghes_state;
 
-    start_addr = le64_to_cpu(ags->hw_error_le);
-
-    start_addr += source_id * sizeof(uint64_t);
-
-    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
+    assert(ACPI_GHES_ERROR_SOURCE_COUNT == 1);
+    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
+                         &cper_addr, &read_ack_register_addr);
 
     if (!cper_addr) {
         error_setg(errp, "can not find Generic Error Status Block");
-- 
MST


