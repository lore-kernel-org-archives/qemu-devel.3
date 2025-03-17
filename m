Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87BEC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJb-00054k-R5; Mon, 17 Mar 2025 14:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFJA-0004ip-D5
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:31 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIW-0006DD-4E
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225df540edcso61415945ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236482; x=1742841282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vI16NHb2tKWbIxjnq/SoVUTdY/Lep770BkCc47k0Rc=;
 b=DA2nNTJiVk5bp05CCI1KSkiBTAuCcZemKJjL7T8qfl8hrsLJZeSnUOCUosus0zXweI
 PWExMvi5z4VLVf9X9PVHu2i6yYiSwUql5iq5ERr/Gli5xpoQneXjddJ8Tnb0fRV/N3LK
 DRT78uwJh7S9hmVIgcUbp8ZjsaLK/j28xaZxrZvN3ellTlNRyyPH915Upsa5LNw6aKnc
 kXuu6Dso9YwWDmTf3gK+MhgrTEh2aNyKlB6pNuD22vsMVLHhmX1WefYp9IleP6jpmfAt
 y3ql+QbOOHVCQXDwMoH9OKYYlh5QpxoEWB+yKk5VpE2R0/3NUBSEB4WUT3MtW7MbjSHN
 p4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236482; x=1742841282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vI16NHb2tKWbIxjnq/SoVUTdY/Lep770BkCc47k0Rc=;
 b=aBk+Mdz+mRigewpFJByUkV32Ai3B9DSGP6AOjLE9ahRyplkPTLso+TU3V/uulk2Zgk
 iz1na4/Z3kwUi9XL308IVWTO8RjB5OghilsqA+E5uJabdQW4LlClFZTgtiLs08ZZtGqa
 sDv3KQ1HWFu+eiX83HjR/UWgykm4FbdJSDZaj/7oxSn5UKsJMRsDIEyt+UPhHHHT+8az
 tSYhvm/1WrHrte4zb00ralrBLcj8ipNDWQYZbPf5SOhMtM72cmfAUgHq638P4TvfXP7O
 +Pd4bYwnuIYnH+ERZOGtmcqCSJNX8xXs3VtaarSGgP1N2ePKjvc2QpIE7HJ1oynHvzYW
 qvog==
X-Gm-Message-State: AOJu0Yy/Shl7i1s7pVR2u4OwzVZYiMoQreL0IniyJ17F6sD8l6XWeubz
 VHD8nOOlfa6OZHwDAhdGA48vSshmwP8dgLuYXSQCesYKg19n1rwkEY1dCmVLgrKtkEjPMV95ody
 P
X-Gm-Gg: ASbGncuHh49UirX/HrNAlxYv9vCnrW+wRZJItjL40GS7aat74uZ2azLJXO6XanrA6Ii
 Pim+DiO4ws/gzRhEOxvcoOSN+danwvV5G5HxFMgp5weA76Ce/tzyxl4AsN6nZr8wH007n3j8PTT
 Z2MZ3QdWhzTSrSp+j8Pdk7S1NUHhv7h+oYR7naDYwAynNlCfe26nKP1mT0YXItaeWTzlv2oPb/2
 VxESHmm2ZCTUqCxe8Ieg3z9dUOwWAvqByvBlqWbMx59O6c8lAX1YHSPMahdlRAdE9oyxVNeyGCA
 cYx1UVORFJj66GnHPehLXkTFR9JoiZWUKNPgqXPLbaRCtKM2l+UTRAQ=
X-Google-Smtp-Source: AGHT+IHLCVfoMXXafvmlUL+0Gr6I93fx5MjwwlixqoYIvnF6wjRbfJSSJwsXt8s9Rnrm35OOx0JfRQ==
X-Received: by 2002:a05:6a00:a15:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-737578016a8mr692906b3a.12.1742236481805; 
 Mon, 17 Mar 2025 11:34:41 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 15/18] include/exec/memory: extract devend_big_endian from
 devend_memop
Date: Mon, 17 Mar 2025 11:34:14 -0700
Message-Id: <20250317183417.285700-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


