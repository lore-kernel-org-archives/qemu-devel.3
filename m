Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF94C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPp-0005hD-5X; Fri, 28 Jun 2024 13:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPn-0005gX-4S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPc-0002CP-F1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+eEF/gR13OhRf7dx6NHiP8oPNIeovEULUu0GqyLkjM=;
 b=ecvhzTCoOBxH5E2O2RcG2eY5Qyrc/zGWCp1DV5U4PYJfKQfw/vxQaeUuGr3hRH8T2ZLrir
 1d4b/wkQ43bTqoehnc0E83pF4hdiqTFrrHCHT24UMmro9GZHA3mPeYANQI9nK+VJ1d+JFG
 /5l06N1HT9cKvglbtKw9xbSnWf9djaY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-dAQldfY3M0KoeFHABF4Tzw-1; Fri, 28 Jun 2024 13:29:26 -0400
X-MC-Unique: dAQldfY3M0KoeFHABF4Tzw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a72b3066669so98328466b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595764; x=1720200564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+eEF/gR13OhRf7dx6NHiP8oPNIeovEULUu0GqyLkjM=;
 b=b/pqwc7rXE7OR8eZYOIJ8xNkvARV1FGdlJAFVddZVp0mNWA97rbpP6NvbRrJ+TrV3V
 xgMWdrOTadCpaJSM0O0pxuOkCK5OAwF/QinSZk6+wOy6xHqFxooZan2eyQYsxfz1IG5E
 73s/ZUjqHodHG3TCYNvAVnB52iDPEr2I8tKH8F2jYNrszvc8FhXzeFMwl3+Out00MLRw
 z4+ek5hYeNqt3uuq9Kbkb6Ku1zcjFYRJuseekNNyDIxnjSnBtrNEUK4vqoqZGSKkQmDy
 FFBZ5qfeSoUQCyW7euvTFTpuRFQcvPl7nyo3dZzV3AL/DbrEPqcRZW07onIGE/cb8D7u
 pf6A==
X-Gm-Message-State: AOJu0YzDTltvyHDkh5yOyxws22xAMTmo4AGepSGltY58rk4cjcPf3Das
 rjDxBeEa9p7FVs2qc7dXPVECpoJ9OiYw5u0bd8HmsN4Lf3MntNAHm5iGuRplXk0Bs01qBSEYm1Q
 f/VlbMSJGzyoJlhSO/qN/909XvvYmC3Y/vg2+0Xd8mekVKgfYLj7madWMn19RtCvYJInrbPWTsV
 KxPUOoKIAf3+ENOnFBVhPaFHwo7hetf2/or8WG
X-Received: by 2002:a17:906:161b:b0:a72:6fc3:9941 with SMTP id
 a640c23a62f3a-a72aee8fc6bmr163147066b.16.1719595763996; 
 Fri, 28 Jun 2024 10:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXV2vTR3B9RtzltNabu6JYoz75qfSeGXgwGmYH5XcV1F6lqvtxmPpevnhcHsbAfKlayngd4A==
X-Received: by 2002:a17:906:161b:b0:a72:6fc3:9941 with SMTP id
 a640c23a62f3a-a72aee8fc6bmr163146166b.16.1719595763720; 
 Fri, 28 Jun 2024 10:29:23 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf18a14sm95937666b.25.2024.06.28.10.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roman Kiryanov <rkir@google.com>
Subject: [PULL 12/23] exec: don't use void* in pointer arithmetic in headers
Date: Fri, 28 Jun 2024 19:28:44 +0200
Message-ID: <20240628172855.1147598-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Roman Kiryanov <rkir@google.com>

void* pointer arithmetic is a GCC extentension which could not be
available in other build tools (e.g. C++). This changes removes this
assumption.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20240620201654.598024-1-rkir@google.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 154626f9ad2..c26ede33d21 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2764,7 +2764,7 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #include "exec/memory_ldst_phys.h.inc"
 
 struct MemoryRegionCache {
-    void *ptr;
+    uint8_t *ptr;
     hwaddr xlat;
     hwaddr len;
     FlatView *fv;
-- 
2.45.2


