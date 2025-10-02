Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Euh-0007IJ-Hj; Thu, 02 Oct 2025 04:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eub-0007FZ-ID
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuG-0000y4-EG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so3671865e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394588; x=1759999388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VaFs+E7RwXKG3PK6PiXPvBWe0XSzQsXZvT65+7chMhk=;
 b=Xjcg5oVzFs1nf8DzRVel52JeuN7Je7Kk9qOjBqw7Oa0T67f7kxBLT7wK7LW6wlzUB3
 VMo9iJ7r8wlj5/sDtCtd3WsewMFPH8M4M1zofmqkTrJKfWVGNenxFBbotXREY8LPGoM/
 Vc0UNF710mvVFqKVBHVc/SffZjGkVVx9BXMX0ytnMYNaoCNkjTWDQG4FMDxpTEdX5S3E
 ZN/peuYO7ulT0fvE9LQa/5FH/AiaIl72zMoxX5xepsV3AmZFlHL564LV7fBfiBjEO1og
 9xmTCRc8oYJsMTUGSPnHdUwyBTsm7BzWlUfws8xCABbMDrzYwISOgVVZvAm16xd2X2lb
 +9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394588; x=1759999388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VaFs+E7RwXKG3PK6PiXPvBWe0XSzQsXZvT65+7chMhk=;
 b=Q/galttmR9yRRnNuPWhZWTcbd1jwM581x/2t/rVx7RwR+/zsMGV8EFZgNSUw8DLuAm
 QFJ2Mh/AcLFbxa6nMniBgs8IpROZZpUBpqqPIinrkv+Aw4fPr3eBmBAbQMTfvWzcvBP+
 bx5NXNoDE8i16gz+qUDAtw+Ucecj5AMYpMjBVC9Y0mz8EFSQUhSUNrE3E8FOzmxDI12Q
 i5gFhyqTuN3CZHycs9rKiSugV3T4I5rMMal4+BCLNmcLK7fSFztU77/9/MjiHy0/hOn9
 xEsElB9oE1E6bURtwCjHsUyeL/XE8lPP3kcsyJRVATBUtnf5J+wh9XZGuz3s6/kIqJvg
 BnnA==
X-Gm-Message-State: AOJu0YwG4vrJdbSS/za68Dz3n4/115vPOWJna3fw9qPecJ9nqoWSUYdr
 DXBEEw/G/zV3fV+9f6bAnr8kR+OWTRm97yhG36Z+OAODpj5mTbAtNhk1F4lfR8PdFs/yoK9p5ut
 FIhz4wjFiuw==
X-Gm-Gg: ASbGncu1GMoWmiyKBtNKDYsZemL9320pD1qELtqZba/QegaFbb25AAC/qSyShHXxO9n
 mCwEUvIn8KGZKnc0NJPB0dUClcTOnDRRtTIPNwIxbCDQYNMfI0dv7tU/gSHGnJNdeNUedV7thUH
 cWxAW0tnWyyIxEDs9NYAQ8TDlJ+8bPZDqopJlTNoLlKbJB3JSPf6CLeWSdpjMFyS2nXnLi6K10k
 rSbffJtrONbBO4T/mmHThuF7lQx0WE/iHkfwzXsPO84lru4iZ2T5hDmABaCke/AbvRpsAzgY3Av
 38KY3Z8a16+Z4/1BKSa31vJ+KYmD584taft1Yrsz2/d++bw/zVwLxKlkcPvOzxi7LAk2UlCnCfI
 Z+EI36XO3bvoPjFVLVHeQILUfVvS+Fs1ci6W6dqZOwF/jXF6KsMClhJFgamGHNcO8r8o/Fq6zgK
 dE6mwhOXt40YFylA/IwUq6n+jJzkh0iw==
X-Google-Smtp-Source: AGHT+IH3oBDcFkCrZW4zdMmmdzvura7CGJv+T+de06uu1CRKlNDCaUMsAj1fOdp2bPK62ElNJTRC7Q==
X-Received: by 2002:a05:600c:408a:b0:46d:38c4:1ac9 with SMTP id
 5b1f17b1804b1-46e68ba134bmr12450485e9.2.1759394587659; 
 Thu, 02 Oct 2025 01:43:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693c2ea5sm24632555e9.16.2025.10.02.01.43.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:43:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 13/17] system/physmem: Un-inline
 cpu_physical_memory_read/write()
Date: Thu,  2 Oct 2025 10:41:58 +0200
Message-ID: <20251002084203.63899-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In order to remove cpu_physical_memory_rw() in a pair of commits,
and due to a cyclic dependency between "exec/cpu-common.h" and
"system/memory.h", un-inline cpu_physical_memory_read() and
cpu_physical_memory_write() as a prerequired step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 12 ++----------
 system/physmem.c          | 10 ++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6c7d84aacb4..6e8cb530f6e 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -133,16 +133,8 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, bool is_write);
-static inline void cpu_physical_memory_read(hwaddr addr,
-                                            void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, buf, len, false);
-}
-static inline void cpu_physical_memory_write(hwaddr addr,
-                                             const void *buf, hwaddr len)
-{
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
-}
+void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
+void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               bool is_write);
diff --git a/system/physmem.c b/system/physmem.c
index 29ac80af887..d5d320c8070 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3188,6 +3188,16 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
                      buf, len, is_write);
 }
 
+void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
+{
+    cpu_physical_memory_rw(addr, buf, len, false);
+}
+
+void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
+{
+    cpu_physical_memory_rw(addr, (void *)buf, len, true);
+}
+
 /* used for ROM loading : can write in RAM and ROM */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-- 
2.51.0


