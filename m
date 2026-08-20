Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4ECC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8zl-0000U6-TM; Thu, 20 Aug 2026 16:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zj-0000Sz-GC
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx8zh-0005TG-QO
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787256249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/Xkfq+lq3xPoFL/oLLlWrg02F7OVnZ8OwdaPMaK6PU=;
 b=T3XSRik7bKtqM1aNquyRMZVlus4fJ4RRV4WH9yuzxuXrHtudA3q+LlNMJ9R35AV5Km4hZt
 J/A/9OIaMW/R0uXyFbmlO1adO0/qnC0YUM7/xc07NDMvo/+T0lbQhygVKM8/3ZRBYhccKS
 NLyR2C+9EHjrBDCHaM2TcqNOOApMJJg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-x77qCbzzP_mic0SRf_u26A-1; Thu, 20 Aug 2026 16:04:06 -0400
X-MC-Unique: x77qCbzzP_mic0SRf_u26A-1
X-Mimecast-MFC-AGG-ID: x77qCbzzP_mic0SRf_u26A_1787256246
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7f1da5e5b06so435302a34.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787256246; x=1787861046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o/Xkfq+lq3xPoFL/oLLlWrg02F7OVnZ8OwdaPMaK6PU=;
 b=Jaj1rCoxmJqQ4jeT3GJdePY6yaQ2XK3epug3pScMpBhaxW/BZjBiH9SFhKZ3V2pqxp
 kbFldjh62bw3MWFOlwg4cAixPKF6r6ETNjsEiGp42Bd7Zg6+pa9XB5O+QzS32N8VWmE2
 r/xsqNKN/ITaAsT/dh0ffKDe52hpHJ5YDFrbyAJZryhYW5LK7dmmFA9M7/6SUZuarHr2
 U2Xl/A/GmBFBJyiGHtcBzAM3RxXgtPTf+sM7aY3ohnXJHE/wBsrywrJX8MHYfcmXfFYl
 ze0QVLs6lZ5g1Gzel6dHnO16i5Jzn9UdGZlw3Jar1SgMSZbXBeb2+75C4hL5Mg4R4A4c
 L1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256246; x=1787861046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o/Xkfq+lq3xPoFL/oLLlWrg02F7OVnZ8OwdaPMaK6PU=;
 b=gtzatQ2JIIF9+MoWs/IxOk4GrWlL3YdM4WPZ0YQGAzpsKpZsjQLgdgpxVvvzX3ob4J
 5h0fAp42vV28ozduxp32neUVRSJNUvFAMtDQN49iFccXtTJwIczR+MKBIiguCGQ1jXh3
 YY/9kzETb+01biUMX3wM08+RXISM4Y/K2nNT1uVXulZajfUwhzzGfkgIBDi+qK61gmMy
 A7IH0ILq9e1Vr1bR7cqdd575/vEkkmlJoomgpSVUzsUVLlmGFj1vg3myrS5NBcbG3g81
 RX6trXl0mMGWE9ZsFzvWifmLrJQULEuPrViz9blu2PA8Xuhn9IdXgp46q0AA4dPQGc4P
 8yxw==
X-Gm-Message-State: AOJu0YwriIKqSzCNb0ugNbr4Bkr5R9biEKRez66k2xsXSB/5Aorcbo6v
 aCdNdxjXQOF6GO4rcLGjadoStb0YFG/waAIuCv8JfiMF/XsxxYSA1jhjNjQwXMfLV8CzRLqc09t
 86BLmpLad1uddH5LBCU5KdHpCoeb5XjJs3CksFiDKnjp0Dbh3GELePjJeEiWbhWP6zJze3LNy0d
 52+BjWAYAr4/Jzaa3wTNB/GTMKvmJPjDaG+vj0Qw==
X-Gm-Gg: AR+sD12IC41qWQOL02UGNyY89+cq7Xh/p99Lil0Ygw7jyVpFDZ0itRI0FLA4ML+Hcgc
 xcFjJAF4pIGZ6miwCcI4HXL6I3Nt9bJmw4KI+7o6XuK9dlQf7kifqBvprE4lX4Ms8KBOVhHwG2U
 ESSXTTAvrK7Vj3Om5lmsJMouATvo9/dOFz0LIbbjnqREF0ltHmv5VT7mVCDIgTrBrBib+PW7Uvo
 wyz8RVShq22SRpIBTGXyGEmx/D4AjcRMZiDP9Mm+hMzeTwQmIhiZgdQUBbRH2yljUSNoygFQmaU
 yPmuHormfGEJtygnkbO9X082nRUw9D0XatqFcdQIXtf+GqXllU22sjWCkBsxqF9wvW3GqbPuon4
 WZnCXllBX3Z+Dslgskf8yM3I7vStTZaAtbJclZ+qPRIZFtuq+uiPPYBdEmLY=
X-Received: by 2002:a05:6820:7085:20b0:69d:9dfb:7928 with SMTP id
 006d021491bc7-6b1591d56ecmr1170021eaf.3.1787256245699; 
 Thu, 20 Aug 2026 13:04:05 -0700 (PDT)
X-Received: by 2002:a05:6820:7085:20b0:69d:9dfb:7928 with SMTP id
 006d021491bc7-6b1591d56ecmr1169948eaf.3.1787256245128; 
 Thu, 20 Aug 2026 13:04:05 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebeb2esm6181314eaf.10.2026.08.20.13.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:04:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jack Wang <jinpu.wang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Samuel Zhang <guoqing.zhang@amd.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v2 10/10] migration/rdma: Sanity check compress request ranges
Date: Thu, 20 Aug 2026 16:03:22 -0400
Message-ID: <20260820200322.3321036-11-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820200322.3321036-1-peterx@redhat.com>
References: <20260820200322.3321036-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The offset/length ranges are not sanity checked in RDMA requests, add the
checks.

Reported-by: Tristan (@TristanInSec)
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4005
Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d8953363fe..e976739fad 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3198,6 +3198,28 @@ static int dest_ram_sort_func(const void *a, const void *b)
     return (a_index < b_index) ? -1 : (a_index != b_index);
 }
 
+static bool rdma_compress_range_check(RDMALocalBlock *block,
+                                      RDMACompress *comp)
+{
+    uint64_t block_end = block->offset + block->length;
+    uint64_t comp_end;
+
+    if (uadd64_overflow(comp->offset, comp->length, &comp_end)) {
+        goto fail;
+    }
+
+    if (comp->offset < block->offset || comp_end > block_end) {
+        goto fail;
+    }
+
+    return true;
+fail:
+    error_report("%s: compress request range outside range"
+                 " (block=%s, offset=%"PRIu64", length=%"PRIu64")",
+                 __func__, block->block_name, comp->offset, comp->length);
+    return false;
+}
+
 /*
  * During each iteration of the migration, we listen for instructions
  * by the source VM to perform dynamic page registrations before they
@@ -3277,7 +3299,9 @@ int rdma_registration_handle(QEMUFile *f)
                 goto err;
             }
             block = &(rdma->local_ram_blocks.block[comp->block_idx]);
-
+            if (!rdma_compress_range_check(block, comp)) {
+                goto err;
+            }
             host_addr = block->local_host_addr +
                             (comp->offset - block->offset);
             if (comp->value) {
-- 
2.54.0


