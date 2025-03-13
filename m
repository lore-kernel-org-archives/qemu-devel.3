Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EEAC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslcl-0006FG-L0; Thu, 13 Mar 2025 12:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslan-0003Ui-LU
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:34 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslaj-0005if-Bq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:39:33 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223594b3c6dso24047575ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741883968; x=1742488768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vI16NHb2tKWbIxjnq/SoVUTdY/Lep770BkCc47k0Rc=;
 b=sl7Se8qEtHnJxO6BXvWyT0EFhbLbROmKN3DCbaJFeXuwRZq2cCi56KQsvp4Jiusd10
 v+oaH4ogRkseAbRryvtc5J4zzchnr6L47xSNxUKvHXy3NjgtYW0TN2O5ForCtwYkqcNl
 VqCkHqku7M0E+feOofL9hR1WPCUvEzhwV70Sg/Av9tR+CQLOIhnOPl7L1Fse/7hK6Op8
 gXc9Qk3sXhsJKRw/gwG/MDesRehQ0Yu/BVQ5Q9P7vr0BSEV+1iv2bOSySbjzW0rE1lp0
 KQ4/TECYr1DRMPm+VeIhLUxsSq1qBKQ/4KCG3a03cJG9bZPoUh9UglTve4IHNxHJfItu
 9Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741883968; x=1742488768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vI16NHb2tKWbIxjnq/SoVUTdY/Lep770BkCc47k0Rc=;
 b=okkcxPI0hjQykwiaHfNJ5bnxHuQsM0iwB6O9OmOHvBL//sJaKB05gfyY2MVeiVjpSc
 rOhvu9f31YiKh5SK0ZU20+7jr/kbBIDOPvtTzG6rJfFC5svezg7fZokdUa2zYQoeckqn
 UbV35JM/AneGe94jttb4mFbd1ccaNflbDZc5RrSw4mv2+2uW7iSTaBJAIV25PFTsoztG
 b9caPY12516vmTR+9AxXyq6LbvLeFmsdrCA8IT0ligus/aoJNaHnR4mwVkGwk86IhIfX
 913/b9nJ5mlUaQEPB+PhFBbdYBjrLo/PbdRJI8aWNn2+yQjv9eRCsxJiOmHuJeftWR8E
 Tkiw==
X-Gm-Message-State: AOJu0YypEzn+hwsmG/7wV3rwGdW6bOKH3rNaU8Bn25H+CXFeTPXAWn6Y
 BypYc+0SmND7g7VTZiUw7YcDJQDIPsU9JYfefZFqssqByjY5XKi4t5upBIL0m9ncE1OJK+CrXkf
 oGXo=
X-Gm-Gg: ASbGncsSALqgEPN1WJrCAYWlY+gDhw7K5ivME3FuRDYuT73kOioJI14j0ie/SG3oj9n
 T00e3+W+ypJcbkHNS6eITBkuYjpPnzgby0Er3IS1hWwMSIrt9yxyAqJnqj6JezLV5PxsQbZ/Okq
 CLAPYjYpoTdIRGyGmhYP5P5WBzN7TcqGb5CS6ryREBEaaxKFCx5nAd17tN0a/gGXWtG4gfPADkW
 PvC/t/hjxlQZw6eKWhAd2r4rly4m0jr7btg1bKQZaVMjlr/fTGBjIwuEZ6ftYqH3KqFSLpOwjq+
 nQsFpiUkZo4KQ0wrDBwdcLzmyhxObecfiqKemq1zr176pKhugf09H3I=
X-Google-Smtp-Source: AGHT+IFcq5bUjsmA5zzk8huR+izs7UMfjfhsI/1Y2larg5eumFEccAwXse4tJs4zAbzQaGCcQS+wlQ==
X-Received: by 2002:a17:902:cecd:b0:220:e924:99dd with SMTP id
 d9443c01a7336-225dd8b9922mr2731115ad.34.1741883967572; 
 Thu, 13 Mar 2025 09:39:27 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30119265938sm4020084a91.39.2025.03.13.09.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:39:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 14/17] include/exec/memory: extract devend_big_endian from
 devend_memop
Date: Thu, 13 Mar 2025 09:39:00 -0700
Message-Id: <20250313163903.1738581-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

we'll use it in system/memory.c.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 069021ac3ff..70177304a92 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,16 +3138,22 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-/* enum device_endian to MemOp.  */
-static inline MemOp devend_memop(enum device_endian end)
+/* returns true if end is big endian. */
+static inline bool devend_big_endian(enum device_endian end)
 {
     QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
-    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
-                       ? target_words_bigendian()
-                       : end == DEVICE_BIG_ENDIAN);
-    return big_endian ? MO_BE : MO_LE;
+    if (end == DEVICE_NATIVE_ENDIAN) {
+        return target_words_bigendian();
+    }
+    return end == DEVICE_BIG_ENDIAN;
+}
+
+/* enum device_endian to MemOp.  */
+static inline MemOp devend_memop(enum device_endian end)
+{
+    return devend_big_endian(end) ? MO_BE : MO_LE;
 }
 
 /*
-- 
2.39.5


