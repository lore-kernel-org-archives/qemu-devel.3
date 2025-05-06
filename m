Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD30C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 18:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCN4H-0003Y9-1n; Tue, 06 May 2025 14:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uCN0V-0006gO-3G; Tue, 06 May 2025 14:27:10 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uCN0S-0007g9-Pu; Tue, 06 May 2025 14:27:06 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54acc0cd458so7031415e87.0; 
 Tue, 06 May 2025 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746556019; x=1747160819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulkQy97n87PM4Cu6oVIfWw2jKyekJRa0XlxEPEhm5IE=;
 b=FU3U3DbzVoInq2xcZRSkfXHQ/wTtybrCLKi0fCrMEsyzUThnIVsmp/EA050HIh757a
 B/tZt3PukNDGOlqlwYBRcwVGp3NEuwZsd4z/oJzDqMM22nme5xQxtG2idva2IGxXn5nJ
 acsAkDa/XPQAMNGSd4hC9K7od6qTBYfJbicXx9FyGyLFqpAnYmNOipnFLHoIkHk1In0Y
 3S9+5piK5QrVCIzR5662BmVFmnQBPWRob9e/yIzwbaJfH0Fl+uWiYqqTJGR6xvfuBwdB
 PUM9sefouPVbbqK+vYbbv9a/odFhmymLIH7PxwioyW5D1nxf0NfHBLv8r2IUrFlNKsBi
 +Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746556019; x=1747160819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulkQy97n87PM4Cu6oVIfWw2jKyekJRa0XlxEPEhm5IE=;
 b=vXsGcmQ39b3chF49dhbLn1n+BoRrE0HmUh6+IydEhCJlmQTHyhRM7dEIjiqlK4Nayw
 vRdIOxRpW9cmBxeBl6mHFM9FYhSMKeUq/rBTHylB7tPq9XinSIeEBMyWNvEJb1Ppsvrv
 sIsk1HTpVpSEjPL4nhtz4Nij7pQYlZG63BMsY9HL/Pz6q39dXScDLbVlW8yZsnJk369x
 q/l92arUQAn+/YIgkaiCzwaxlGn9NygTjyRN4YPTDYOvsEzbkplUPqHQE4CAVxeT1FQk
 0nxFblIeVNhmTqnLRV64bsYY9FfjQTjnPO4MDvoL/8tSccMrnN+RlObhPYTCOtPibip/
 8Efg==
X-Gm-Message-State: AOJu0YxZd58jfJsTM5Ki2rrQjKNeffEDyGZSMympZ8Mb5DjLlLl8pdgp
 HMrC8wW7YP41B5dDfcHG9Kwj6Hhj9vihL7PGamtGKviw7c8mieyOvleTmb0Wzk4=
X-Gm-Gg: ASbGnctcOHLbv0vmYIKJgXKmr8wxiYJN4IE/FD9B1tj1hkm0lbJRmX+ffiSldOoUcLh
 +8fkZsZer/u3POlG/hQwLqn/TLtlnBJbdiB7JcHC33RKoS1OZ+dwGRfeuSqqi9oVYYR84z61UQl
 KLJP9BKnW8xdLw2pCsfeaIexfAxgd4waG64WAgkJCAP9VppKrhOtyRgsrNAgwXlcxRr9lan3hXQ
 GTrcHNREbGYw/n4xslizhD6QXh/S6UxECv8TaNhg9Wus9Q0BWsmRwZ6o8w7q4YqDoFM1SI11JCQ
 JxUl2zvTlnyo6XKKjk7l1QJrthHo7bCL1UXE0KdA2XJGWE3p/3ZWrLFUDLD6X2T1tnvNUdO+yZy
 BY3PICh2ulyY2
X-Google-Smtp-Source: AGHT+IHzaJIdUGZqVsMqaaLKD2N5KnA7xk6kTtRN63mmTk/vnTIZ/huHbnC5q5MQJQGLHrEoa/muAg==
X-Received: by 2002:a05:6512:20d8:b0:54b:117b:952e with SMTP id
 2adb3069b0e04-54fb95ba664mr159760e87.55.1746556019187; 
 Tue, 06 May 2025 11:26:59 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ea94ee173sm2093370e87.127.2025.05.06.11.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 11:26:57 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org,
 paul@xen.org, alex.pentagrid@gmail.com, peter.maydell@linaro.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL v1 1/2] xen: mapcache: Fix finding matching entry
Date: Tue,  6 May 2025 20:26:46 +0200
Message-ID: <20250506182647.302961-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506182647.302961-1-edgar.iglesias@gmail.com>
References: <20250506182647.302961-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Aleksandr Partanen <alex.pentagrid@gmail.com>

If we have request without lock and hit unlocked or invalid
entry during the search, we remap it immediately,
even if we have matching entry in next entries in bucket.
This leads to duplication of mappings of the same size,
and to possibility of selecting the wrong element
during invalidation and underflow it's entry->lock counter

Signed-off-by: Aleksandr Partanen <alex.pentagrid@gmail.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 698b5c53ed..2c8f861fdb 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -376,12 +376,12 @@ tryagain:
 
     entry = &mc->entry[address_index % mc->nr_buckets];
 
-    while (entry && (lock || entry->lock) && entry->vaddr_base &&
-            (entry->paddr_index != address_index || entry->size != cache_size ||
+    while (entry && (!entry->vaddr_base ||
+            entry->paddr_index != address_index || entry->size != cache_size ||
              !test_bits(address_offset >> XC_PAGE_SHIFT,
                  test_bit_size >> XC_PAGE_SHIFT,
                  entry->valid_mapping))) {
-        if (!free_entry && !entry->lock) {
+        if (!free_entry && (!entry->lock || !entry->vaddr_base)) {
             free_entry = entry;
             free_pentry = pentry;
         }
-- 
2.43.0


