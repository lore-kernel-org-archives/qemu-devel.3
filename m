Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B07C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnj-0008PU-4q; Tue, 20 May 2025 07:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnd-0008Cy-Mk
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnc-0003Cv-1y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBicW1h0/r2veCX2mitXgZUVrMQigI9U0cjfaTeztOQ=;
 b=TumAT8pHjBrF5mqtCcH973ipZMMMznhsso0ZQ5EoZMFcSMv69FcUqhg0sabC24AdPqEfec
 8hiJZqh/iSUb9cYY57a6fSpdLxvxAZ9FfZ4ai9kXa5PDcy75Z26wF72cAVjlnPsoCJ3/3g
 O5Brarzb71NYtBAIkIJc05lB8vEzt58=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-Y7a54K0HOvapuN63oh5xpA-1; Tue, 20 May 2025 07:06:18 -0400
X-MC-Unique: Y7a54K0HOvapuN63oh5xpA-1
X-Mimecast-MFC-AGG-ID: Y7a54K0HOvapuN63oh5xpA_1747739177
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso546557966b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739176; x=1748343976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBicW1h0/r2veCX2mitXgZUVrMQigI9U0cjfaTeztOQ=;
 b=Jdp2qpdl5T0gD+YfV2GAO1RFSP1YsRCIyd9o88PnftWCWW1E5nhspyhyWpmKdcv4aF
 T6cJpsyXhbQOB81tmO9/MSeUWdkb6QSsWAWZtU+6yXaawgvBZCt2oZ5Qt/utt8ZOppJ1
 F52fYNTsLfZfT091sztcKwNMSU6zTyJ9zCdEp6Dwk5n71rSWifQjkXxj5wMql1s6Neeg
 fHQ1gBMDonNSv+DTEIEwSWvQAcsRxF9UjvksTzBMsOPkGEFMRP0Z5qh+X+3mC7Iiq08L
 CRkK0UdKAyp0mFshmuiu1gM3CHpMMa4dsddrF2+NGGVDjzQx9MQXXAh11uMxr+HNckpm
 o5Aw==
X-Gm-Message-State: AOJu0YzSWfIK/bp6ZpbEuPTa3bBrjht5bfWcWpejSVS00M+FrR3L2Zjq
 JkEV7Kv/1lw8Usk+NP8biEy/5k0rUWBM+QBor5dmSk3+76MrK3vLj7J7B/Ue4sxx89gmrOtFW+8
 dWhaZ4Ux+/hjwhXTEAOeadAQFVm0nORUjpRMF2VxQXCZVHpk5OUVYfbxSYvmXhRCLLBD9tI8ZCJ
 llzQUwcuKOHK1+Vd3eDgniULMwhrKgAMH0EEcupYmA
X-Gm-Gg: ASbGncvIADRnUHR0MG3mUOKvaUgz/sozPRYqcdWzNtMxRl9E0pRjtwaUnkzwhM3HTJK
 gllTR+i0gFFZuls6U1YC6qUGBrCtz8RCsFtXhVZOvKTR+nKVbxMF+3a0WXRH6tzI3oXjyKWIrQj
 6lL/aPxAsy1JO4qhDJvL4Hw27RfF4TwqjuXTApOW6TQlkR4LF+SFlolRmSHX1BJ+LaLUzah/bwA
 6TkctyyrRkM90aWDgrknZhmFTIjVEiWvQD3M49Pmwu3siW1+/2LpQTLhK2c35hrr7Lj5f6LhE6n
 z5xt5byqSNwaBw==
X-Received: by 2002:a17:907:7291:b0:ad1:dbec:44d3 with SMTP id
 a640c23a62f3a-ad536bdf275mr1473389966b.27.1747739176094; 
 Tue, 20 May 2025 04:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHowjTnT4qH12nfh2SsatRXCk76ngau5dw3EnjDcTdPH+FYVOYQuz5sNvsJyZeBJklvU6GDdA==
X-Received: by 2002:a17:907:7291:b0:ad1:dbec:44d3 with SMTP id
 a640c23a62f3a-ad536bdf275mr1473385466b.27.1747739175608; 
 Tue, 20 May 2025 04:06:15 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4908cesm717662466b.132.2025.05.20.04.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/35] target/riscv: include default value in
 cpu_cfg_fields.h.inc
Date: Tue, 20 May 2025 13:05:14 +0200
Message-ID: <20250520110530.366202-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In preparation for adding a function to merge two RISCVCPUConfigs
(pulling values from the parent if they are not overridden) annotate
cpu_cfg_fields.h.inc with the default value of the fields.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h            |  2 +-
 target/riscv/cpu_cfg_fields.h.inc | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e9bf75730a6..aa28dc8d7e6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -23,7 +23,7 @@
 
 struct RISCVCPUConfig {
 #define BOOL_FIELD(x) bool x;
-#define TYPED_FIELD(type, x) type x;
+#define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
 };
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index cb86bfc5dc3..59f134a4192 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -2,7 +2,7 @@
  * Required definitions before including this file:
  *
  * #define BOOL_FIELD(x)
- * #define TYPED_FIELD(type, x)
+ * #define TYPED_FIELD(type, x, default)
  */
 
 BOOL_FIELD(ext_zba)
@@ -153,18 +153,18 @@ BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
 
-TYPED_FIELD(uint32_t, mvendorid)
-TYPED_FIELD(uint64_t, marchid)
-TYPED_FIELD(uint64_t, mimpid)
+TYPED_FIELD(uint32_t, mvendorid, 0)
+TYPED_FIELD(uint64_t, marchid, 0)
+TYPED_FIELD(uint64_t, mimpid, 0)
 
-TYPED_FIELD(uint32_t, pmu_mask)
-TYPED_FIELD(uint16_t, vlenb)
-TYPED_FIELD(uint16_t, elen)
-TYPED_FIELD(uint16_t, cbom_blocksize)
-TYPED_FIELD(uint16_t, cbop_blocksize)
-TYPED_FIELD(uint16_t, cboz_blocksize)
+TYPED_FIELD(uint32_t, pmu_mask, 0)
+TYPED_FIELD(uint16_t, vlenb, 0)
+TYPED_FIELD(uint16_t, elen, 0)
+TYPED_FIELD(uint16_t, cbom_blocksize, 0)
+TYPED_FIELD(uint16_t, cbop_blocksize, 0)
+TYPED_FIELD(uint16_t, cboz_blocksize, 0)
 
-TYPED_FIELD(int8_t, max_satp_mode)
+TYPED_FIELD(int8_t, max_satp_mode, -1)
 
 #undef BOOL_FIELD
 #undef TYPED_FIELD
-- 
2.49.0


