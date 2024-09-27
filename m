Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76898CF6484
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIrZ-0008L5-Gn; Fri, 27 Sep 2024 17:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrW-00088w-7v
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:50:54 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIrU-0004UU-Iq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:50:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37cc810ce73so1644250f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473850; x=1728078650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tq/WU8YFou4tlFTr5oZ2aHrtwQxQNFO3jd7/jY9s2dw=;
 b=gO8VdGVwugSaYnGG2iLdKLBJBxCENa8edM8l5Y8LsDmKhK5uTlJ23tdCyxDLZSei91
 ji+9Ij1oTd936JniIXZUkNt/VnTjNHyDZ0s+RKCZeALF6ZndHbBz/fKXpfV7RUVoQ3pP
 qFQKukP5vJYe6TKsY/yWo/0uLxjlVUpQBAzwx/VPlsojrM2MH4dPCFigW/6pXIt9GC1l
 MrrFbirzDaOw+0yeFQ/gLIxruV8cU1nrnZ+GtosL6cbYx54QuZP88LUfp9suR9cNT0dY
 UKvz4XmxANGgV6R4a5ZWCbODL8FC556YcpklrNlYXyelwlBMGCDzNxIAS9bBFap7RiJp
 6Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473850; x=1728078650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tq/WU8YFou4tlFTr5oZ2aHrtwQxQNFO3jd7/jY9s2dw=;
 b=SOMFpWVwmmTNDOMjmtj4cx7TINP84UOvuE88O1FTQLo57K+OUex+ZqxVjzxh3ABENQ
 YTV7nT+P0J2ZIFAQJojrM2obq9lTEB+3N8hdj7ypnQ1Q29pZT8Tk8yJTJE0XohlwyDhV
 8lRfKPV6nLYUFhPAN66Rb6cCiM1zHzlWK7C0YwMLw0OsV7IrerOf5NxnoHIWCgNGNNDC
 3M8Eq13f5Bn4picG+7V2pjeZzxU2VZrIlnxuFbrk6zegsdi5L+imSdsoDSdYEfXrKyfE
 XAdb5LmTuAnC+k5tt1MHaJyHxEZCUspIRsYCKA4AKwMvl9rmZ74CBuip84oSHJL8/drb
 481g==
X-Gm-Message-State: AOJu0YwzUY7et29pvJilHWYKj1/fN+vmAPzM3J50gFkwi06pXxFEkRu1
 f6fzAepn5agHNe0g4jgFQb1wcldVOSbHG38cA97b9w7F1KJByMo4hstYU8tPGpGn4Se6Z4/dIR6
 o
X-Google-Smtp-Source: AGHT+IEVwEgQvC4F+8Df9CeQLSgcoSH6yYWo6zfqSSVNv/ADwbOLK0c08Kdeho8xUJNkJDLKltPAZg==
X-Received: by 2002:a05:6000:bd0:b0:36b:bb84:33e2 with SMTP id
 ffacd0b85a97d-37cd5b1255cmr2402385f8f.37.1727473850434; 
 Fri, 27 Sep 2024 14:50:50 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5730e92sm3386868f8f.80.2024.09.27.14.50.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:50:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] hw/ppc/spapr_nvdimm: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:50:37 +0200
Message-ID: <20240927215040.20552-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927215040.20552-1-philmd@linaro.org>
References: <20240927215040.20552-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ldn/stn methods handle the access size, no need for the switch case.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr_nvdimm.c | 47 ++++---------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 7d2dfe5e3d..5af0b13370 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -250,7 +250,6 @@ static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
     SpaprDrc *drc = spapr_drc_by_index(drc_index);
     NVDIMMDevice *nvdimm;
     NVDIMMClass *ddc;
-    uint64_t data = 0;
     uint8_t buf[8] = { 0 };
 
     if (!drc || !drc->dev ||
@@ -272,24 +271,7 @@ static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
     ddc = NVDIMM_GET_CLASS(nvdimm);
     ddc->read_label_data(nvdimm, buf, len, offset);
 
-    switch (len) {
-    case 1:
-        data = ldub_p(buf);
-        break;
-    case 2:
-        data = lduw_be_p(buf);
-        break;
-    case 4:
-        data = ldl_be_p(buf);
-        break;
-    case 8:
-        data = ldq_be_p(buf);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    args[0] = data;
+    args[0] = ldn_be_p(buf, len);
 
     return H_SUCCESS;
 }
@@ -325,31 +307,10 @@ static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
         return H_P2;
     }
 
-    switch (len) {
-    case 1:
-        if (data & 0xffffffffffffff00) {
-            return H_P2;
-        }
-        stb_p(buf, data);
-        break;
-    case 2:
-        if (data & 0xffffffffffff0000) {
-            return H_P2;
-        }
-        stw_be_p(buf, data);
-        break;
-    case 4:
-        if (data & 0xffffffff00000000) {
-            return H_P2;
-        }
-        stl_be_p(buf, data);
-        break;
-    case 8:
-        stq_be_p(buf, data);
-        break;
-    default:
-            g_assert_not_reached();
+    if (len < 8 && extract64(data, 8 * len, 64 - 8 * len)) {
+        return H_P2;
     }
+    stn_be_p(buf, data, len);
 
     ddc = NVDIMM_GET_CLASS(nvdimm);
     ddc->write_label_data(nvdimm, buf, len, offset);
-- 
2.45.2


