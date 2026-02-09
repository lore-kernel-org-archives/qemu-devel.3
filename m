Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A7EE81BA4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 12:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpPuv-00048c-Lq; Mon, 09 Feb 2026 06:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vpPus-00047I-5u
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 06:58:58 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vpPuq-00021s-Fs
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 06:58:57 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81f4f4d4822so2305630b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 03:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770638334; x=1771243134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X79gSuktp59m2ZjRB205eWTFvosz4VAdKX9YgjOiL9c=;
 b=OeFpnQrBc7asQF0zl3wXfbmmaKgWxkjKA8aAdhwBbuO5wIZa9YXHzQhupHld+Z6unn
 gzUzil/Fpn8OHScbnRO8uQIPQ+FPF57FHdwDk8PKxYY7VsowtDGTl2D1O4jfj24HyPVs
 bXnYtV0pal7iTn8Tb5ROvoGTxsXi0UcpDZA8QBM2aMSjsIYDxlxSV65Z2VTtEQE9yM0S
 n2P6xCL1WHW74nGzlwvr4XGTAkUWOHb0OK0Yx5yKIoFAmVAgUk8bIZbnovcR9xKpkThL
 LpwnX5dZs2isaKFn/KbJzP0tiCuOMP3G09xm/AUmhd2MQBdnBqNpkptgtfeYH9tb7puw
 ReXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770638334; x=1771243134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X79gSuktp59m2ZjRB205eWTFvosz4VAdKX9YgjOiL9c=;
 b=knzo6z0OpHrWFcxmIAfmWIqNy1hK/xExP2vZ+BfWkajhUmA1q7+WutaM4ERbQTrxKo
 5FD80nLHrBWSypmzk3I7qj2nO1aUvw/rkEsqIuf8J/KhFrKe4T8cNcZHjrHgrc4L1JAV
 ZHhNlxmEHhGk290Cw/IQj2hXmLCXJyAZ55vp78M2TXqwR/9uaM2yUZE3vK6ynZhtct/T
 XfK0POta1TfI/CUOTGpQokPzfNqo3Ae79VnPHivDO40pavVuod3HMnpuZsrPZ2xGPiB5
 3volgV+n8/ySKQUg/l75n0vQT22RMW25wxhPfJvSflRC7TUHL7FmtoZWFsfZndq0vY6c
 bClw==
X-Gm-Message-State: AOJu0YzlufHXUS8OJkvbXBt8y7xvveKAktujb3S/jBjX3k4AJcb+btfG
 7Jlso0InWM4qqo7Icoy5hqpU0xSJa6OxDhhoiIF8X9SOkVzexwvttFSn+fC+hks3nl2DX0YO4u3
 tcIyHMe6oFLKA8ODW9RnBcQZxUS8H4/SumryINCjhGvlG+rJNdtqCxgNolwhn8g9fqMjdMIWn5W
 Aybgna87L+pq92exgNF/t37FFFycdWGP6Vor3KzA==
X-Gm-Gg: AZuq6aJIzIkxQJmKfQiS6H2FYPwqsqnf8NBwYtIfgtYBJq1Ygy8PO61ztr2Bh98Ovky
 d2/oqbvj1FbDC/U6eZd57YVztiJVpxVs6F2JKOy0ZvVjNQSdaDWah8vxCwaZQBThPr7Zq1x59WL
 0xeQeD9EWMZ8oT70KnaPK1r7lyjhZC7O/7GroHymm15Syvt8m15tAl1QH6KCYQAt982dixQB45J
 257WAKK2WjAXXxnHkm4AM5i3O6UYV1HBE2E9H9JvSF8BvrBbGqiY1s4a9MNn6Ua8ke3kiX2po28
 OB6dogPxZIa6niC/iSqmxVMuSFYU/koFTzXar+2NnJU2v7CRRrZWSMU+HH0HOT14MHBo9vufG4g
 JmxYD1X1hGrQpQDfjuhcf7atZ+iqm7iKgn9xYnEvyVh9/bSyIZttwoOpgs62wcIEbt0zeErMa7Q
 eRkuHTqTbBtqRrO32IxWomQYt1PBVtsOG+
X-Received: by 2002:a05:6a21:4d8b:b0:35d:ce99:cc23 with SMTP id
 adf61e73a8af0-393ad3071e4mr9130878637.49.1770638333914; 
 Mon, 09 Feb 2026 03:58:53 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb5e406asm13566216a12.22.2026.02.09.03.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 03:58:53 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Jim Shu <jim.shu@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] exec: Add RISC-V WorldGuard WID field to MemTxAttrs
Date: Mon,  9 Feb 2026 19:58:44 +0800
Message-ID: <20260209115846.2276651-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

RISC-V WorldGuard [1] will add 5-bit world_id (WID) to the each memory
transaction on the bus. The wgChecker in front of RAM or peripherals
MMIO could do the access control based on the WID. It is similar to ARM
TrustZone NS bit, but the WID is a 5-bit value.

WID is usually implemented in AXI AxUSER signal (user-defined signals)
in the AXI transaction. As we have a secure bit in MemTxAttrs to emulate
the TrustZone NS bit, which is implemented in AXI AxPROT[1] signal,
I'd like to propose to add world_id field into MemTxAttrs struct.

Since the '_reserved*' fields in MemTxAttr are for padding the struct
to be 8-byte [2], we change the reserved fields from 3 to 2 bytes when
adding 5-bit world_id field.

[1] RISC-V WG:
    https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/

[2] Commit 5014e33b1e00d330f13df33c09a3932ac88f8d94
    Link: https://lore.kernel.org/r/20250121151322.171832-2-zhao1.liu@intel.com

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 include/exec/memattrs.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 52ee9552491..6bde90d482f 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -57,6 +57,11 @@ typedef struct MemTxAttrs {
     /* PCI - IOMMU operations, see PCIAddressType */
     unsigned int address_type:1;
 
+    /*
+     * RISC-V WorldGuard: the 5-bit WID field of memory access.
+     */
+    unsigned int world_id:5;
+
     /*
      * Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
@@ -66,8 +71,7 @@ typedef struct MemTxAttrs {
      */
     bool unspecified;
 
-    uint8_t _reserved1;
-    uint16_t _reserved2;
+    uint16_t _reserved1;
 } MemTxAttrs;
 
 QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);
-- 
2.43.0


