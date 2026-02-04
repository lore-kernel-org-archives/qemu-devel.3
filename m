Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735CDE8B388
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhbH-0002ao-H2; Wed, 04 Feb 2026 13:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbF-0002aX-Ph
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:27:37 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbC-000140-Iv
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:27:36 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso1039295e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229652; x=1770834452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvE2Y73I6IaYLt6UhjFR+CGAiJFnskYHQajNdWFwAsU=;
 b=HTlQ2P4FwnYjHs1vNVfp4qKsY8lp1ozZ3TseNyWPUjAZ8PiEizKlP0fRQH0S6ZIBWJ
 P3UFZnCxKLxGNi5J0leLLqGNTwxHKUtA3s0MOOk6fO5uMxHZtT6QYbgTwuU24rxmBiuU
 gsFlmW0ycWtdXqWACNK2bn0nGvW3xHKqBtOsxGtXB2ltVs0VfrOffQIr5VEZavLF/4Dw
 zotI5lePbDDAnxbNUe5TOeICbruEEkeHoQr/dAw2sGx3H9M2btBQS3ExHYvupNdlLxNc
 8yOQexsoL7Ex/9C4yfxIfZECHAY7d5fPuxdVyYeuIv2U2wQ8PX+CLk5O110aelgC/nwc
 1pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229652; x=1770834452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvE2Y73I6IaYLt6UhjFR+CGAiJFnskYHQajNdWFwAsU=;
 b=Bl4tjNx5Vptu1dWhjQuhmv6J3CGCAnlR3QcKUAV7SXyOtweeYHWF+kqbkTFVIGOzBT
 b2UusilRESnRkFlwxoVIv3v0KEtI8P0yN3ATg1qE5zsUxc18Ffj/1MWwuGWyvGBNiVBp
 o5zZcUD8dspTPn4smCiZ9mypBp0KCygmTWRMoVX+iq3VJPg1Z5fI76Hh20zPrLuUPNNb
 iasY0iAz1/ERJlVdjFnBwQli+502EbkWleCCyjl6kqb9ywIn88a7qpXmOAb/ekLECFcr
 xTNvvCX0iD7oQup9nuZYimYGS11EDKF0eV3RWQ/Y+HvscZAZiD30TKG5QpD/zKA7RIUa
 Eb4w==
X-Gm-Message-State: AOJu0YyzwQ6kih2bX3/TVak4+jmsMBU6DW/tNIBsNm4iDuooXHVQ7Cp1
 YytDxArFDKnQQWliH+4h1fghnpybRjh1bf7Rz3vhlrWHLSBqIUURoMiRPitXMIDltbhDR/wRjYS
 CvvQUYG0=
X-Gm-Gg: AZuq6aJwyj3CLlxPT0Sd66Q7OVHPLKBVIp0AXqjgK//txCNEgwxG591PoF6+Gj1BtYN
 D7vWws9/z4uOQKZvZyZij6CU+a2R6L8smfG0eZMnx+0t2DNG2tfY29h60Os3lIoC9LGfEgZkWSD
 57Ya01EHO5c7ZzzOajG6UJTqshsvQqNlGsMT4lFILlisT6t1XEEGiOX8dGQSk3plA4M987Km5SM
 GmPaC3wEh3JqwhfIbcuQLkL1o1FI2SWyEzGO1gH5mqcnnIQtiDWGpMU2XH81dsT+yQiB8O4SVb/
 6I0ZO8CLbJmxGSFyogf85+q+7uvK0Kf33WiWxXgOdwSqm2hDRnSvhNcfgMFxqDrHkeCuvn6BWJk
 g8hgkMqZqG8aM6BVu85Z3wg2aIjL/MeUic8XshjrCYp/6FcH3it45R3hhLI6kxjbE5oAVpwTDOJ
 eK8e2QFVrtAt2uhTqvQ75OHItlG7087QDZJWylcN8EGwuLvPbl2ZFL6KjU7/IJ
X-Received: by 2002:a05:600c:871a:b0:47e:e61d:b8d2 with SMTP id
 5b1f17b1804b1-4830e976f0fmr56020965e9.27.1770229652574; 
 Wed, 04 Feb 2026 10:27:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d58214sm1589225e9.15.2026.02.04.10.27.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:27:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/9] target/s390x: Use address_space_ldl_be() in
 read_table_entry()
Date: Wed,  4 Feb 2026 19:27:14 +0100
Message-ID: <20260204182722.44062-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204182722.44062-1-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

address_space_read/write() is meant for accessing random
amount of memory blobs.  When the access size is known,
use the address_space_ld/st() API which can directly swap
endianness.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 026502a3e40..30f09ec3de4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -108,6 +108,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
                                     uint64_t *entry)
 {
     CPUState *cs = env_cpu(env);
+    MemTxResult ret;
 
     /*
      * According to the PoP, these table addresses are "unpredictably real
@@ -116,13 +117,9 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
      *
      * We treat them as absolute addresses and don't wrap them.
      */
-    if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED,
-                                    entry, sizeof(*entry)) !=
-                 MEMTX_OK)) {
-        return false;
-    }
-    *entry = be64_to_cpu(*entry);
-    return true;
+    *entry = address_space_ldq_be(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED, &ret);
+
+    return ret == MEMTX_OK;
 }
 
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
-- 
2.52.0


