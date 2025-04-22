Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E9C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPR-0006ND-Ti; Tue, 22 Apr 2025 15:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLk-0000lu-1l
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:09 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLf-0006e6-JW
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224171d6826so79613015ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350322; x=1745955122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xgU73YOfMEflbLqLNoDMX+RVctfg0fSpdUj7bFm7Lqc=;
 b=gYrU+NJjTwRm+rPXDBwaEjSQbuEpz5jAhRjaEfZMjgHa9e9x7D6XGTACI3r1UFTAIU
 ti0cm6Zi1nVR/COE0egnSlHtDiiIKmBumiOHBkN1Ba7IvrfnSz9/uhyzJQImb1viuir7
 cN8jnN+8vV1XOpZUP/pPyQuvyvM9R/H1ZJAeFE1+2BXJt0KcCCokxnNElsbYSzKUs9IR
 m8dlnFFGx/yH+8dMV6uC7oij6Ve8D+m+G8XBvugzU8sS0iXKVO4Bk0Wsa9fuDNEX2GoN
 EEfaNfe2+ZQjdoDcso+LsM7wgVS/KrR4vYWI7V3SkUkAvPeKZ8I3kmZteTpOBBAn9Mjc
 9hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350322; x=1745955122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgU73YOfMEflbLqLNoDMX+RVctfg0fSpdUj7bFm7Lqc=;
 b=mhXmfL3gxBIfj1bzLUZiu5zRKr9McLKecTQCXdyJ20EW+XRKbs/wrvPqMQfwaTB9Zh
 SzvisuxZ4Z/4x6pXfPpygZYlE2KOBRhpdG+Sf5X7uhQom2gL/jrloiHAUL5mHSvZNhwq
 uSoRtaj/U1QouSDJDPLtqmqjdpYOl0mvqCyQEn8pmIlK+ypsJBkQFdRXIbuGXwm5+u1G
 2UYMoeZcXhuz0g3md17us7dq4SY+xwOydevLZKNvC/JkVjMfC3KkrM/dL4Su6LF0WMQi
 xJPJ2/kz7meq+tWwHcDKwkzVzSzRCD/BSzr4NmIk+46Vj+8vmtAXzsZW1BqBhLt/AcQf
 ve6A==
X-Gm-Message-State: AOJu0YytsCLJw3yHEiu5ubfPIfYyZYir9NJcHe6qqgg/eEivsz78P134
 S817djPPncLqEu+ncyN6sPmz4Th2hQGdOhHaSggHIkaiPy67wWUnBnSl71Lnlu7MYsBDi7sPPD6
 B
X-Gm-Gg: ASbGnct5+41RW812gEyWVlvKQtOVJQBP1EaoTKQIHMhYTzv3/4U+4JWahaJi4MVpiUG
 Otn4apEPhhPtuwvHYFQnbg/7ZNIpuI8Jyc04dIKoIL/08hiDLhYZsZLOsIXYLhxtLb26XpU/ihc
 n2MHTrcvMb4x+bvSvtvZgBGuDVfKYRB/1b4Xw5dvJQceJ837ARlFUWLROpsTVdN0TotX1sC9afC
 7RvLUDTbUvIhU7U/DYwqAzwxQ0NgKJetomylSge5Cu4hEPHqEkVAi6VLjRbVmEMFX0kTdqdECa0
 2Dv/mMxQYlHBfFNQa6qmWkmmX1VDFz/ePWYxb46MNWwGu+HZ46FA8XVoKr1zboEKfKIXiXeIXpA
 =
X-Google-Smtp-Source: AGHT+IGu1VapgOEfYgynacBU0pOJ6+VaXmA1lGetjRfxNFbim34rQHlmJ2Q9oOyLzhUkRgE4+kxV0w==
X-Received: by 2002:a17:903:2983:b0:224:1781:a947 with SMTP id
 d9443c01a7336-22c53580c35mr263978735ad.21.1745350322148; 
 Tue, 22 Apr 2025 12:32:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 063/147] accel/tcg: Fix argument types of tlb_reset_dirty
Date: Tue, 22 Apr 2025 12:26:52 -0700
Message-ID: <20250422192819.302784-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The arguments to tlb_reset_dirty are host pointers.
The conversion from ram_addr_t was done in the sole
caller, tlb_reset_dirty_range_all.

Fixes: e554861766d ("exec: prepare for splitting")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cputlb.h | 2 +-
 accel/tcg/cputlb.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 8125f6809c..03ed7e2165 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -31,7 +31,7 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
 #endif
 
 #ifndef CONFIG_USER_ONLY
-void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
+void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 #endif
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b2db49e305..10090067f7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -912,7 +912,7 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
  * We must take tlb_c.lock to avoid racing with another vCPU update. The only
  * thing actually updated is the target TLB entry ->addr_write flags.
  */
-void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
+void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
 {
     int mmu_idx;
 
@@ -923,12 +923,12 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 
         for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
-                                         start1, length);
+                                         start, length);
         }
 
         for (i = 0; i < CPU_VTLB_SIZE; i++) {
             tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
-                                         start1, length);
+                                         start, length);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-- 
2.43.0


