Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EABCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RlZ-0002Iu-3O; Tue, 30 Sep 2025 00:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RlW-0002GQ-Sz
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RlR-00017W-0K
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso4203840f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205693; x=1759810493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDZrJ5n4JJlGtTIDZGasXxs/GbyDfsVnrlhryX3chWg=;
 b=BRfkA0UolvLMAa5TO0Go6SUE8mncKPJ6KWEaJGm/Jpljb8FZeSJaxqDydGSfZa30cw
 fbXBHrtoF2lvzoU1l5+905POeKN/Ybs7BguT2X2yhg/k+Je5glPTzXyG8gIURGA3wzhA
 tuDIS/GkThNLSU+TynRdHPBMcG15T1wymrzYICR/EHJSCig0syGACizNBduES6b37Vac
 rjTfVsPhMqC2+Grg48N86IFNVZLVJoewbHedTQpIxbw6c8wrxSL94jM8uLWWHOQF8QkW
 BQQjsDI1nQ0qYl6A88tyMYV7wtT7DbNbfOyVv167iTfm3aas4m0S1xpVR4K6YgTXLdSv
 BNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205693; x=1759810493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tDZrJ5n4JJlGtTIDZGasXxs/GbyDfsVnrlhryX3chWg=;
 b=lHaboOLj6KD0JxGt2Q4vFCX6KTjcol8MancHCjUZbldYGHdNJtzbW/nS3N+uaJaxnu
 hxrk7FPe6ITjm1J3qer9XuWx3/8IZowb4cZavW1K+1VA4wM3ToaINhkBRLKrE80L0QH0
 lOZBzixRL/79/zmdE/SDFkx5HOCqRtYN7z/bu1DMBP6JnbNstRtir/KG32T+st/prcIT
 O1XZSnI+MabVbo5aXppO+FzL7zBuueQ6ljvDM2HgHljrbRy4cFQwnp+8LeL1LSqX6ufR
 gsPnn0u6rEMb25xf62nES2ZcuteFVF8nd1qIRjQpFpFZXrO1eXhxGNyjktiK8crUje1U
 rRnw==
X-Gm-Message-State: AOJu0YwmYPAXaMqyyDTBnLfwKOZ7Edw7mMHKD4e7xTggl93bEOq6pLCM
 bWeKiUZEaMbP2MPNjXTtfW1xJcMYHkXJtx6K2QwGkBd/+ous0Jdu02o4+Btya8rpVm6sHcXq6qL
 4UfsEHxiiGw==
X-Gm-Gg: ASbGnct0wIe5sUZg0oiBf9dMqeeI6d4iSwUc/KTEq6gre5YG3n/sLqX1WMsw2bsLQN5
 QrIVHKpKtSS+C+IN4aBxy/nJVbVMjVyqF2VHZveWgihPTx7ZIMjE8C2qqteILOuh1zymKAx0Px4
 fhUUSBNlhuAHssZeGLyn+3C2YxG1oLUMd3TxvA/XJ3FShWuryRLAA8YpPMO6k3iNUqRvfja6tUa
 UCS00kLa8uasZpSBfqw2/ZtJ7v5iSvVFtH0cGe78NCW7Ndyc8nnSG1/EutZQVpEQh4M6YBE0KE0
 mYAfpYVXbdvu/hn/WBrG0sy7M5tyWMouJ6k/Gfu7W6y5OlKqWSwfRtU+86J+0+e6+Ec+EYKl9vQ
 NKt7HyKR4Yt9SWZJ2iMlNbngSDvnfxMxq7MIPwG/T/OnUlIlS0mnmR49/vQtyl/4VUzOYwd4cig
 vbfwkOtky75YCXz2h83AAp
X-Google-Smtp-Source: AGHT+IGTcuGp6K4U+VzNJFqsWFt5qmyyMICY36EpMMpwA/c/CYvK54pPvXL/H3Oj0HTHDk8uqyOMBA==
X-Received: by 2002:a05:6000:2901:b0:3e7:617f:8458 with SMTP id
 ffacd0b85a97d-424116eaebcmr2419836f8f.24.1759205692755; 
 Mon, 29 Sep 2025 21:14:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41855fc661esm13064710f8f.45.2025.09.29.21.14.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 14/17] system/physmem: Un-inline
 cpu_physical_memory_read/write()
Date: Tue, 30 Sep 2025 06:13:22 +0200
Message-ID: <20250930041326.6448-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Un-inline cpu_physical_memory_read() and cpu_physical_memory_write().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 70b02675b93..6d6bc449376 100644
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


