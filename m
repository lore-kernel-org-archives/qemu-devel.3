Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B999CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rke-0001ig-3l; Tue, 30 Sep 2025 00:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rkc-0001iS-1X
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:06 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RkZ-0000pP-7f
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso3188581f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205637; x=1759810437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UsPYBf9Y41DYeMpdEdOkBi/mu9mpDrkpGT9A+u43FVY=;
 b=yEU7mbkItYqTzxF3pDehLvxOsjD7kzplSZX0fth1cK6H0pPcV36lfBkLPI+LbtGdW7
 uyQ9ZaENlqKtDzleina/Ih2SmHcs1gtibqym0pEtyCRi/KhCA6/aZmKyNxdKt36WcW3S
 z9dmpWMUYPMCTbO/D0IeTEK6B4WjWMROzDo+iWc3jqXFoz9YovwUlNV/9JMWf6AvR04F
 LsxBxLv37QusuKmapOMlUcIcci+twwPuAABti0t8XGcEJBoOm1OyXSarub/pB+bVyeg8
 BiARIl6DQcU8KUCj/4R+kTN7n01odC0n57TfybYHcUqanlDYi1KV4gI6XIwSmGxzHPNV
 tn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205637; x=1759810437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UsPYBf9Y41DYeMpdEdOkBi/mu9mpDrkpGT9A+u43FVY=;
 b=XarPKaCishxZZFi3jOdBWQTdi87TGC69n5FFjtRv2ja+6zXpq9xy3iSaAyt0uqiztU
 nVw0/YNWNFJ+rjk+NMfXVcfBvKdrD/2XQaMJk0JdR9PFBiu9H8iJGZqd2MtozQH4ke8B
 DX9NSn4f56rxoFYzb0CQepUuTYW+pE78x0CrzwR9QfPGsMZkTX62JhrzOj/8x/tmOOmM
 2D2tTpSSk5xSTMoEfbW1GYpHXR6TmCI+yBYGPyxpAi0Z1aK0jVZJ9M1+9vaC2rsU4TjY
 pUfz4IXZgHHilxECWhIMOZjHGjns4E7ofEjj/7DLPEyEUKL2nb0//8w/KA3UpHcP7qCJ
 m7zQ==
X-Gm-Message-State: AOJu0YyW3udoNVCDLd+IcxkTTt/Uyqk4PjBNTD/+QclnIaQrxXQounvY
 pFRBK7wnEROzpbYpfKiJ3/t0lqn6g/yLiV43LCtqVyK3tbnb3QlneyzEn805wmYbfKIfyFbCrbC
 wkRmvuCw51w==
X-Gm-Gg: ASbGnctKq6hJpc356navctflJXAym3/j8Jf7zZ6U8llrjKZeWKtqe4FkntN8Bws1NVv
 LoelHtqb6NqiWahsweH/UIEToBYO3sXNwWZUBM9dx7aWSkohRYZCHIiwxINFi0HaNcKtnRUESe7
 rC0vtE8K2D8jmnkCHp/6CqpeALfg6vYRAYy/tokxTXB/nLEdQcMzSInGtlNYwgAgIKM3rlaNB6L
 p9jvUGaqgtQZNK78CCnAEYSBdspcU03CATS4+wefhL0mx8PmEQkvIqDYGWaAIDacg62+vR668Pu
 eRYq0W4HhOSqyfFGIwfQc40P7WBKCRwbwYX1uWq54YyQoztci5ALVUutE5vlTsPNcDZrB3uLfGk
 XfQ8kMTBtPl2o5NyfgcSWAf1sUCoXglCiWoMZIpUAvSmkKWtm6WKFii9/V5FEEKeG7cvEs67A2D
 o/D98RJGZ5FYbasLlq/v4+
X-Google-Smtp-Source: AGHT+IH3He/bgDcAVA0O1uM4KAZUJWAOZ5pxrLV0agMvoc3nOriIeKi2nLWEPRWZf/BAWQ6cyeIFXA==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id
 ffacd0b85a97d-4241227789emr2285457f8f.30.1759205636900; 
 Mon, 29 Sep 2025 21:13:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31e97sm251610955e9.14.2025.09.29.21.13.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:13:56 -0700 (PDT)
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
Subject: [PATCH v2 05/17] hw/s390x/sclp: Use address_space_memory_is_io() in
 sclp_service_call()
Date: Tue, 30 Sep 2025 06:13:13 +0200
Message-ID: <20250930041326.6448-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
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

When cpu_address_space_init() isn't called during vCPU creation,
its single address space is the global &address_space_memory.

As s390x boards don't call cpu_address_space_init(),
cpu_get_address_space(CPU(cpu), 0) returns &address_space_memory.

We can then replace cpu_physical_memory_is_io() by the semantically
equivalent address_space_memory_is_io() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/sclp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9718564fa42..f507b36cd91 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -16,6 +16,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
+#include "system/memory.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
@@ -301,6 +302,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     CPUS390XState *env = &cpu->env;
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
+    AddressSpace *as = cpu_get_address_space(CPU(cpu), 0);
     SCCBHeader header;
     g_autofree SCCB *work_sccb = NULL;
 
@@ -308,7 +310,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     if (env->psw.mask & PSW_MASK_PSTATE) {
         return -PGM_PRIVILEGED;
     }
-    if (cpu_physical_memory_is_io(sccb)) {
+    if (address_space_is_io(as, sccb)) {
         return -PGM_ADDRESSING;
     }
     if ((sccb & ~0x1fffUL) == 0 || (sccb & ~0x1fffUL) == env->psa
-- 
2.51.0


