Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23ADD5E36C
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kdT-0001vb-L5; Sat, 09 Nov 2024 07:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t9kdL-0001rR-0z
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:32:08 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t9kdJ-0007AW-F4
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:32:06 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c803787abso25838265ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731155523; x=1731760323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I22Vm01k91Exl/3tx9OtOL6Tgt75qZKLVbyFVyDph9Y=;
 b=Ua0ZuS08dmzkHBiwr3b/i2nwMiJDZuJYOwfhiWecaGDGWCkeEoJ/MccXKzU3XAtLAq
 WeR1cIkJt8xGGD/o91cMQOiiio11DZzcfcbH+mKiHxq05AKygBwEWHxwJ0UEUGIqTfi5
 uzYygZ6YFhWGLqbXSU/yZkx4XfCKwRiaNIN5cPEhoRAB0HCivdjy7s40m4Q+H6OstGl5
 E1UO+bYUsP2o+4OCC4NMnSCr9h/C2N7q9YAkbGRAZJuz55Q/V/lXlPJMW+APgodQsDEa
 sSGhc1+ZljPAAtA0BzKE2fZN9anvNEedmYHs+qHLqneEyxqOlnEE9MRA9vX9LC/WtQBQ
 RR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731155523; x=1731760323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I22Vm01k91Exl/3tx9OtOL6Tgt75qZKLVbyFVyDph9Y=;
 b=TxGrPhiYhTP48s4hRCQhuDlSEsAavCGW+1q0q4bwHl9W31VXpYuaTWKZHqXptBNJf/
 tJcTYP8jbrDnTH9S3LAnjxON6mjAWdzGMHy8LmIJg+vvTzx9kf4rlWqpw81zt+ykPMy1
 Pg7wG+G+6qfQFEiupDsAtciziWM+lrDxxSM6MJ2YoWqVpIz4vNxnHd0a+NM49pMHH9ZU
 cC0dot5YPoZihw4jQr5pfj02sY2yGfT53+oRri9CmYOl92XFyx2efz+Kdw6RZYDVFvhT
 DSNCrnjvA4Oyz/fKKic+IAQXd5NlH1Ma/splr6paRz8yAUTATntnzuabxpO/cJth3H4v
 u8mQ==
X-Gm-Message-State: AOJu0Yw647lO93avMGhfqrNr4y751++0JI3oWJOJCEwP2zGVLJUTlrEi
 DXwsC6yPfCzlSpSqTIBnDZruLvEGHTIhFHV+Ba7sJWcnLCxXtAbrbvJl8g==
X-Google-Smtp-Source: AGHT+IGcd///f1aSWcqZh++Jq3x7EmhiC9o/yN+GDGmtmJE2Th7pnFRJSqeSgKsKFnSG0cP+AM/dBA==
X-Received: by 2002:a17:903:32c4:b0:20c:c9ac:bd0d with SMTP id
 d9443c01a7336-2118377eb96mr94083505ad.19.1731155523538; 
 Sat, 09 Nov 2024 04:32:03 -0800 (PST)
Received: from localhost.localdomain ([103.103.35.149])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e6a429sm45257045ad.238.2024.11.09.04.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 04:32:03 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com,
	pbonzini@redhat.com
Subject: [PATCH] device/virtio-nsm: Support string data for extendPCR
Date: Sat,  9 Nov 2024 18:32:08 +0600
Message-Id: <20241109123208.24281-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
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

NSM device in AWS Nitro Enclaves supports extending with both
bytestring and string data.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 hw/virtio/virtio-nsm.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index a3db8eef3e..6830fcfe17 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -444,7 +444,7 @@ static bool handle_describe_pcr(VirtIONSM *vnsm, struct iovec *request,
  *       key = String("index"),
  *       value = Uint8(pcr),
  *       key = String("data"),
- *       value = Byte_String(data),
+ *       value = Byte_String(data) || String(data),
  *     }
  *   }
  * }
@@ -504,14 +504,21 @@ static enum NSMResponseTypes get_nsm_extend_pcr_req(uint8_t *req, size_t len,
 
         if (cbor_string_length(pair[i].key) == 4 &&
             memcmp(str, "data", 4) == 0) {
-            if (!cbor_isa_bytestring(pair[i].value)) {
+            if (cbor_isa_bytestring(pair[i].value)) {
+                str = cbor_bytestring_handle(pair[i].value);
+                if (!str) {
+                    goto cleanup;
+                }
+                nsm_req->data_len = cbor_bytestring_length(pair[i].value);
+            } else if (cbor_isa_string(pair[i].value)) {
+                str = cbor_string_handle(pair[i].value);
+                if (!str) {
+                    goto cleanup;
+                }
+                nsm_req->data_len = cbor_string_length(pair[i].value);
+            } else {
                 goto cleanup;
             }
-            str = cbor_bytestring_handle(pair[i].value);
-            if (!str) {
-                goto cleanup;
-            }
-            nsm_req->data_len = cbor_bytestring_length(pair[i].value);
             /*
              * nsm_req->data_len will be smaller than NSM_REQUEST_MAX_SIZE as
              * we already check for the max request size before processing
-- 
2.39.5


