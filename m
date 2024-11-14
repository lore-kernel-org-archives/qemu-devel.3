Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20D2D637CF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOT3-0002Rz-NX; Wed, 13 Nov 2024 20:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSO-0001lR-9z
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:36 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSL-0002e4-J2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:36 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so67741f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546932; x=1732151732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrrkoTna7tufOe6qwJFGaLdax+anmf+pXIEo/rEb9w0=;
 b=dZgLNgcozHtPt4OyJKjftjLFhPYewJeExpfQDlOrz7AETafJP1JvCVIA7gSjs8+orw
 MuMg7VDLfYT3WlEdCZLSWeYUvorA7PUHax7ZHcK9BgTomoDhcVjHGPLV3yXyMeEXTklL
 XF9CdEKKYWnVY84NBEXkq3WQXmL+CEDoQSoSqYIUf4wVGyWNpnm2UztTzLb9Qp37dV0r
 Pjh7aVWQakr0v3qxnBN1Az8ySiQfru9e3xAXCBVHMkFzmp+CT6LO5/tQysO8s0mucpTz
 umlrfLWkMrFMorRIh3b3/Y9QAyNMpuO8tExWOGUxZlnlesjXXZRx5liLoOCs77qGQwSu
 0nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546932; x=1732151732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrrkoTna7tufOe6qwJFGaLdax+anmf+pXIEo/rEb9w0=;
 b=Sd68eoSZk7aKjHiZdxC/PBtjYuiOFO5O1X5q0prDchHv52N4RnY/5Jym1W7qZpRgXr
 BaXmfyvlkXV/3+HMJiGcZ759meQD5CGor5ko9eJ+g/uC+n2T5Gd7TyZipK/bSDtDnTPm
 dHe6M/AkV5M/pNNgAqkiNcGuyr21N964N891vWs95A3mGxOtiE/3mRgMIELbHWat9DKE
 v7Mhe5qddDIBnU+sFkxD/9ItOA+Z/7xhQjP2iKUzu3e1CT8fyqkrVonooCxirJNh5Yva
 s6yfHxcAuEajKUD19hpuuKtfKGbV0gsmGRM0Jp1CvJhEuyhVgp+S+lngHbVb2x8u+wyH
 yZ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFUcSP1Vvdt2QsZe/OsSozwHBeEyaaavDOCDpJxmVty1ksHuYZ6Wqmx4m0nKOf8gAM3tSdBuaIum/q@nongnu.org
X-Gm-Message-State: AOJu0YwT7I5B/Pw3PVoLwbfnXLkD5xl8d962afYp7HUQvIg6yYTRAjsA
 ErNT/WkV8sTU20Nd1xpAqhbNs3BxHZ1ZD7WbsxFPS8o1x2L4O93euj34/yM8GMU=
X-Google-Smtp-Source: AGHT+IHuhhAiEzkVHTWofBhBqgpOXZdBh/rWL7IMEM1ux8mz49czPs5z3Ayh4M4BEC57KqIzUKPO9A==
X-Received: by 2002:a05:6000:186c:b0:381:cfea:2818 with SMTP id
 ffacd0b85a97d-3821851cc75mr155127f8f.30.1731546931624; 
 Wed, 13 Nov 2024 17:15:31 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0ae51sm1409755e9.34.2024.11.13.17.15.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:15:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/24] exec: Declare tlb_set_page() in 'exec/cputlb.h'
Date: Thu, 14 Nov 2024 02:13:02 +0100
Message-ID: <20241114011310.3615-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cputlb.h   | 11 +++++++++++
 include/exec/exec-all.h |  9 ---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index ae4798a017..9075d94ec5 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -108,4 +108,15 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
                              hwaddr paddr, MemTxAttrs attrs,
                              int prot, int mmu_idx, vaddr size);
 
+/**
+ * tlb_set_page:
+ *
+ * This function is equivalent to calling tlb_set_page_with_attrs()
+ * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
+ * as a convenience for CPUs which don't use memory transaction attributes.
+ */
+void tlb_set_page(CPUState *cpu, vaddr addr,
+                  hwaddr paddr, int prot,
+                  int mmu_idx, vaddr size);
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2b314d658b..2e58540005 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -174,15 +174,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                uint16_t idxmap,
                                                unsigned bits);
 
-/* tlb_set_page:
- *
- * This function is equivalent to calling tlb_set_page_with_attrs()
- * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
- * as a convenience for CPUs which don't use memory transaction attributes.
- */
-void tlb_set_page(CPUState *cpu, vaddr addr,
-                  hwaddr paddr, int prot,
-                  int mmu_idx, vaddr size);
 #else
 static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
 {
-- 
2.45.2


