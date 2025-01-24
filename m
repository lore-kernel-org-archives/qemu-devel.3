Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23080C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGGI-0007Y5-14; Fri, 24 Jan 2025 04:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFt-0007Ai-8Z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFq-0003us-4D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bbpMEor1R2bRwOjlbdZexCI/CHydxS93U9CuB4hmPI=;
 b=LFYfq029YPxZCP+6yX7TUBbT/V2LmYaw+yxt8xXcRuw9G350fn+D8THHWxyLczgxeGbvGs
 MaHx9yIGlyHG9kxsJP2h0LmpiTSsZ3MGMdzwW6VgxWeshqVwuaRIM5Uvm0TyYFnbMhVS7F
 fOA/PqcdHBjfcitPT6CzsonihKcY1Yw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-KCDAK3XlN7GOPnc4eH1kZA-1; Fri, 24 Jan 2025 04:45:31 -0500
X-MC-Unique: KCDAK3XlN7GOPnc4eH1kZA-1
X-Mimecast-MFC-AGG-ID: KCDAK3XlN7GOPnc4eH1kZA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43624b08181so10185575e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711930; x=1738316730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bbpMEor1R2bRwOjlbdZexCI/CHydxS93U9CuB4hmPI=;
 b=eW0BkaEQ18IazG3qLZrG9AbIFGpodbFnJAEj7T3L8Pum7H1I9gdcN1yHuq5Fzkr0e6
 voGpGzYHBXLNI67gVskiuU91patlErEYGOq06X2fdGzrRowsIiQ5Kk8F6gIEVk8HKVC8
 hwpUF9Nt1Bdr62BMc0gmaYt6raYzb2o/v6Y4/zhlNcqnT3zNfOJRj1c35Vvj+nt00pmD
 8bW3Vl0cU0O49fLRHOEPzXCYApwUMrSRniKgivgiOuc+eBTE0OMffAwiX6Wiz5CPHvXh
 davVXRq21t1+o6MkOlkyedOvmPCMwCthzqHAE4uVAZ08+ZOzvnR2LQdgQaGuBqIHEFSe
 SsNQ==
X-Gm-Message-State: AOJu0Yx66L5cfqZILQKvUgRvvHq5xBIp4HG1DsG57IYfCRlARvavDpWY
 gMIxPOZDDQ6WbGIMXhGggjuty/pn+Ml0gN0/NDljJDJhCKjzC3dWOwDGJjrPvnLDRLcBqO41HRr
 N2qA9ni45bH1kVhcEm+xvHm1E6u3NGdBReoBkjkIOsn5lTxdUusarCYOCrHAy8E5mRIc579ilF4
 mWmgjSA8hqf4sarIJ/LunPISngyum17Kx/9OrhPi4=
X-Gm-Gg: ASbGncv3cpvMzGxfepybIoGZpciJ1kJVSvQFUjV3LUGSQ+sLZIzkFjC570NdxbLGPOj
 bLhs83vihQN2Fyp1m52cl+ilZUcb/YiU3O+Pwa9M6V1LBFyiV7XhN/2UPb//0QnMj879ynEIjzu
 MBWSrGeMTA6+nw3sRWQ03eoOMgLu0OKMhcyN2HEsdasriPCrcPOvrE9lwJ0cU7hX7y4lccBJNgn
 xmwqTQuTYmBFz1Kpz//nLzJOK/c99MRupo8y/oxXq2jXitsDSBeRR6xibK7bJl7oey7/IZZaA==
X-Received: by 2002:a05:600c:4fcf:b0:434:e892:1033 with SMTP id
 5b1f17b1804b1-438bd052fedmr24335575e9.2.1737711929782; 
 Fri, 24 Jan 2025 01:45:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMy8nR8jXlLgW7lQ+fq1Z8BGr/NbZMwdE3nztVlUkfmqPqIaKMctM4WuO5lytPuB72ohNnFw==
X-Received: by 2002:a05:600c:4fcf:b0:434:e892:1033 with SMTP id
 5b1f17b1804b1-438bd052fedmr24335225e9.2.1737711929329; 
 Fri, 24 Jan 2025 01:45:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507c59sm20071965e9.17.2025.01.24.01.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/48] memattrs: Convert unspecified member to bool
Date: Fri, 24 Jan 2025 10:44:17 +0100
Message-ID: <20250124094442.13207-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

From: Zhao Liu <zhao1.liu@intel.com>

Convert `unspecified` member of MemTxAttrs from bit field to bool, so
that bindgen could generate more ergonomic Rust binding with bool type.

As a result, MemTxAttrs needs to be expanded from 4 bytes to 8 bytes.

Therefore, move `unspecified` to after the bit fields and add reserved
members to ensure that the whole structure is packed into 8 bytes.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121151322.171832-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memattrs.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index e27c18f3dc3..4fde4eee843 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -23,12 +23,6 @@
  * different semantics.
  */
 typedef struct MemTxAttrs {
-    /* Bus masters which don't specify any attributes will get this
-     * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
-     * distinguish "all attributes deliberately clear" from
-     * "didn't specify" if necessary.
-     */
-    unsigned int unspecified:1;
     /*
      * ARM/AMBA: TrustZone Secure access
      * x86: System Management Mode access
@@ -57,6 +51,17 @@ typedef struct MemTxAttrs {
      * PID (PCI PASID) support: Limited to 8 bits process identifier.
      */
     unsigned int pid:8;
+
+    /*
+     * Bus masters which don't specify any attributes will get this
+     * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
+     * distinguish "all attributes deliberately clear" from
+     * "didn't specify" if necessary.
+     */
+    bool unspecified;
+
+    uint8_t _reserved1;
+    uint16_t _reserved2;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
@@ -64,7 +69,7 @@ typedef struct MemTxAttrs {
  * (so that we can distinguish "all attributes deliberately clear"
  * from "didn't specify" if necessary).
  */
-#define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = 1 })
+#define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified = true })
 
 /* New-style MMIO accessors can indicate that the transaction failed.
  * A zero (MEMTX_OK) response means success; anything else is a failure
-- 
2.48.1


