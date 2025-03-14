Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684B3C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tn-0005xA-C2; Fri, 14 Mar 2025 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8t6-0005aw-Q2
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8sy-0008Dr-OQ
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225477548e1so44203415ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973511; x=1742578311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wT5ohu0Ui7xrH+jgYqMJMpKemGPcZNvy7jzdyuAyzEs=;
 b=UY8r+XqqJ0T+7WafBnB6Te6YVvOPOshirmHpuTBIc6LmrM60rxwTcQJdfTBaIqMJWH
 4+5TKthTicQykCJLhzd/bG+9ZVPkFb71B9OTOiV6MmCnznu/4X/h71/jTX6FKkvRfiHZ
 zHPwPN3N/8JEeETISFBwmgqCfFlnPR89WMJ/oYXsrBFs6vPup1rMJbJR+qMo6YkSeFuT
 eiIUXwmDsf1vKmJWr8lrhNBByWSBYCxRYuU3f87X3QcZ4XM7sVaiR/TVCoDEMQVLRQZd
 GlznIGszVWf0IhQ85HurJT3ZwBPDRQNYbqtbjhyALTWTfL4PntFwOAXYTUVAuzxADzWV
 ZS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973511; x=1742578311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wT5ohu0Ui7xrH+jgYqMJMpKemGPcZNvy7jzdyuAyzEs=;
 b=PZlDUsRL5g+Bj5gdgDsJKCNdMoVtk7rjabO/+GVoqrwDu6tPdntbND+5T+84rne4fi
 0blxQcykP4ErQXtInZgc3skaYZn+iU9mY73OehyVcRgiCQrz6+lmSwRF2OEZJUbjCrU8
 A9bMJ0lVLibQiM/xlCkOYpMOE7iugkEBNwHvcUsQa7m1wstFGPkYAGq1HbiaA7tVgkZ1
 v8O5PeuIiY71LPYUnG2g1dqn3tN+ujxeYbohJcd0MOPePb9t6bYEOkonM1FoZ+XCiZ4s
 fWhxUrLc/r3wm7ZQGYWgZms3Io9XMg/AMQ/9fober2ziO6LEUxwWE0OyFSNKvo5uQ/8I
 ROZQ==
X-Gm-Message-State: AOJu0YzGVacTqItg40AEGnJ2xTV0Kzw5VyztFVYGsAJLsGeOUqruP6y1
 /y8mQEQbFpQQ2O8d5vOEU2PoPznngZ3lKd2E8xxmR69gYG4T4RoCiV9J6CMBEe7zygt8h7Zxwpi
 q3k8=
X-Gm-Gg: ASbGncsmnbkRm/05UPXvidldLedehL/K8qSZ48lBkQFxKLk3OOOGDLvZ8EnNtmKTC1B
 TGKlII6X4UtkVqpbQUXw66cb8fgoIuu29fxRWzvjTj4cgqqsi4p22ylPrB9gBIskZc4R5NqGc3p
 q8N3441WKFVppkRZLks1eZ7Lfvd4cTaiO3sIagHanRZ5Sq0byvgHYpCJ9lMAQpd/LWJgPgXo9xB
 AR0gE5rEi5+8UbufqvWw0pnN0ZwgQBVdCBi+Ds6suJ29n/o1y2T7b1EsywN5Lb05dEbTx6ApQ4R
 CKotFfcE1JtWkNlldalK3iwL+Xbl+PovIF2/5Q9lyRc4
X-Google-Smtp-Source: AGHT+IHrpliMNKDFJoDtMC4n7ul1BPKlqc8CVK3A1d9AQSWcUHjtbEMPub70Om5ILhqP0o6bsvQnoA==
X-Received: by 2002:a05:6a21:9005:b0:1f5:75a9:526c with SMTP id
 adf61e73a8af0-1f5c117e146mr4872005637.13.1741973510710; 
 Fri, 14 Mar 2025 10:31:50 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:31:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 05/17] exec/memory.h: make devend_memop "target defines"
 agnostic
Date: Fri, 14 Mar 2025 10:31:27 -0700
Message-Id: <20250314173139.2122904-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Will allow to make system/memory.c common later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index da21e9150b5..069021ac3ff 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,25 +3138,17 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-#ifdef COMPILING_PER_TARGET
 /* enum device_endian to MemOp.  */
 static inline MemOp devend_memop(enum device_endian end)
 {
     QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-    /* Swap if non-host endianness or native (target) endianness */
-    return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
-#else
-    const int non_host_endianness =
-        DEVICE_LITTLE_ENDIAN ^ DEVICE_BIG_ENDIAN ^ DEVICE_HOST_ENDIAN;
-
-    /* In this case, native (target) endianness needs no swap.  */
-    return (end == non_host_endianness) ? MO_BSWAP : 0;
-#endif
+    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
+                       ? target_words_bigendian()
+                       : end == DEVICE_BIG_ENDIAN);
+    return big_endian ? MO_BE : MO_LE;
 }
-#endif /* COMPILING_PER_TARGET */
 
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
-- 
2.39.5


