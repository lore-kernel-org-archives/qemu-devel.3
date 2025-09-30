Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C621DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeG-0000hF-UA; Tue, 30 Sep 2025 04:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vdw-0000NU-S7
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdK-00019M-Qc
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so959312f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220565; x=1759825365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWuKL8TfgkuOIExpLDHpPzfjXl06+qaviUFlhAaNsvY=;
 b=V8rsKghz50z50vBCT1LEQU+km7CKxX83Fh+XGmFw0m6A8RY68XuyaumIOyIrWfYucj
 PjxHKzl4y3eM67kIaBeWuYdVbyjx/dOcpHNlJwHRowxbgwzX0qLluJLBGTP7mG33SwzQ
 5YPPpAiKaWyb86ZUyda/U3+DtRphUHYYXLGkqkXi2uymHBM/bKlLcu83cqJsNsHR5lhw
 64gzxZpGu6AljCRLj5XPYvOLNYKM4N+t5qCgznYP6Q7guqOSoSKke425oreYcs9dEhDR
 7cqabZM/Cl81ZF+T2F0Kq1ULMzDn5gG+JHVN+JpktH+adxcmkIMK3bF6cqUcuU8Pwm7F
 vy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220565; x=1759825365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWuKL8TfgkuOIExpLDHpPzfjXl06+qaviUFlhAaNsvY=;
 b=ZfgOEmprhK5WmKxfIeV/dzBMLYXnPSaaA9aDKQidCd1obAZuRM5Gxkt4qPVwswlKK+
 bf//W5bhbQE0x8BaR7tDOYvV2JgC6/bUOJVP0rUGZA+jO4uLKxzmMKhACGWe7rgM3idp
 MraIfOCFxVOfnR+ljl03WcinMPWHJ3vsugn7S8zr1SiWlANHePP/RtjNQEecDJdxcWxF
 3ZMrrCVit2gFs5jyolDVm+YIqjmcVIHxhojLUsAzf92pUslsU4NDV4//QlYwkjvyL3vc
 +eIR2NfPLYth9i3TpmoefltjduHRl0FD4npSoeo5+XgycP9jdeu68K8dOmfV0A9+RlvN
 ytHg==
X-Gm-Message-State: AOJu0YxZpmzkWJ4Qo7RSxChKAxQuVaVHmGLbg+kebrESYBsfZXWNjSb6
 HANK1nVrjdajshfVzOPtsiL9LH5kCQXIVj+2pVFe/kpHv94I1QmL7fzRgX7tAinjG1tG+5PXvci
 2EqZYTJjnPQ==
X-Gm-Gg: ASbGncsGCBVeL6iSniUvDCF+tgXaveV6hUEjquWf7aWcrzS9rQ5o6Y5xAxgU0qf1LK0
 Nh58eUqta3cm9ptgWPJeM/XbELQET63pX5BiXivHlJwHY1acqjVRpmFgVxfJU0NtyFtIbwfIQkl
 ZfP7w4KGrt7uHsDVr5LN9GMTLZn4asKu/DiAmDjvXnQgK4+mAICPcnTxl+kRuGtmyQrrDOK4uI6
 GN6IwzIaL0PwMJdL+YNGhIRBje/p38kSpyfE/SAfSJvQMKgo/br4iXebjYcOvVAVs6naS12lKCR
 tcY42BWZuCyky/z0+CTOMPhX59UpQKt8MWsfz64kHnRqK1OE33StPHCus/sEgVdw/QwmalpDtl8
 qdKfT1ZGTsqHeIzic5X3YXGqK2kaDv3nDis3XSJva+Nm2joc9GHkjW1RywgixC3+ElTmnBiZT8T
 rAX9R7b55oV/4tOv3AZ7Dn
X-Google-Smtp-Source: AGHT+IHE0WytwIozDLwCH/1E/tGTnOI9D8efEv7Y9aQk+zHE6qo+2lNsAzNshhN1K4J4d9d9Usou1Q==
X-Received: by 2002:a05:6000:240c:b0:3dc:1473:18bd with SMTP id
 ffacd0b85a97d-40e497c348dmr17529188f8f.3.1759220565490; 
 Tue, 30 Sep 2025 01:22:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7e2bf35sm21817486f8f.53.2025.09.30.01.22.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 14/18] system/physmem: Un-inline
 cpu_physical_memory_read/write()
Date: Tue, 30 Sep 2025 10:21:21 +0200
Message-ID: <20250930082126.28618-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

In order to remove cpu_physical_memory_rw() in a pair of commits,
and due to a cyclic dependency between "exec/cpu-common.h" and
"system/memory.h", un-inline cpu_physical_memory_read() and
cpu_physical_memory_write() as a prerequired step.

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
index e0c2962251a..033285fe812 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3189,6 +3189,16 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
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


