Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A73CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vda-0000BG-Gz; Tue, 30 Sep 2025 04:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdG-0008W4-Aw
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VcY-0000rQ-Eh
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso36248825e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220516; x=1759825316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmN6KZRBDFIwLcWnEVDqbz1WHRvv8u+lRYP5Aq5aiQ8=;
 b=v8vbPBimOxWLy3b2sbV/F1sAM4U68VnGoPgiKV6kBKYScQHeywj9YBXCaJdsnFdyNi
 SgzlZKXqfnW4GylpIfcQA4jyGnMrFYjrjEAzVgMClNSFjqVcRuFaqJbunKfccIDEFOQc
 2FPrIoKYw7CbT96cVT3o4rZ4UNEVV/WWZpLUhsEG/X5PpmD6/LksjLN8REoGou5oK+a/
 uHeW7zJgU2KahX0g0yl+KNhXs3RKsdMj223NMKpRGmEJgnFMDLdMtaXPZQcvsga+RGTb
 ZSLMztG57IUd/e32G3cbn1F0DpNB2O/4q0nu9VJOl3kBkLlWXLc4++FaEJp+RHaeUShb
 es+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220516; x=1759825316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmN6KZRBDFIwLcWnEVDqbz1WHRvv8u+lRYP5Aq5aiQ8=;
 b=hgI99hp5TWDyBotk50qP5vO0lsg30kjNX8FRsqex6IKTzcHfzYe8dQWtcB1ENxo3xC
 KaAr3LvCewFzfdL0fOcfOKK8iY8FDjDJOOd6hZurI+kEaMj2/y97/xpmCGdlucdOl1zd
 VjpHHZ+9dIWw11Xdr71N5JPfTpxC0k2dLVYVGOq6foxoWA3Be8nUm6pMqA9tHfBumhRF
 darRv6oVzbFUO5W9xqZq4esxgC6cEiEqGXK/3zpmsabitmoQyOX4g0b7yNCvcmJRhcLY
 3JDX0sTMhJo/IClR9JcLFBszL2ssdPsjwR8BUprHjORsMi0yU+l/rxzYQltCMrwcz28c
 wK7g==
X-Gm-Message-State: AOJu0YySH+DBIr4fA/7EK51uLM78iAxUPCJbG/u9GLIoiYB+pureHngI
 zXaPkaUZc5pRJjbm4XYzxPIGoBNnkDXba+07iFkyIY1JCC+PeGcuojAvLgpID5zmMa7KlCvJGA0
 cWJad3+Oh/A==
X-Gm-Gg: ASbGncsBWK/lzQohIUEtxVqe4r2RYG+7GU5HuhDqsgWb0reT92Qjm6KzwiSzzLh226Z
 sosTNOYenIBkyov1m73pzfF+8g3NJ//T5TqxLwdwrZolY/xksMtuzj69pDu32/1U4CGfzPGGoD2
 bRBXImGf0Fpq8PMnaae2zotme/mj95bFrbnDUq6nBnuT+8D3xq2ChLqy0jkXXYvHVksUC3MbihZ
 pldkzS3N6+kXk4Pu/nkJQzvx11+jybZQRH1zpcE+lA8Fw3Hd3vKAanFmgHjdijDcq2w/vYT+3YJ
 3KizCLpJV7ImQfjhW/eXgI6U2WkAgLnUISOcqIzn/qaHZ/fwosElNJmld6aBTUT1ozAGRPi8QOV
 ne9amKGFCcFij/Fx+U4LHYq22tXfojaSjnCCWCJFzMWDS/JM+HxnUxdxAKhK+nxWPhyK/e9J1Ti
 ERbjCRVDc/W3btTpgLFs7s3DRCnwoqRDU=
X-Google-Smtp-Source: AGHT+IFRoVQqdg8pFriDfOKg6AJHeYajBA5OHZoOOnjeKEw77YQUzMpfQKsIByPubJl8mIXC2txRhQ==
X-Received: by 2002:a05:600c:8b16:b0:468:7f92:5a80 with SMTP id
 5b1f17b1804b1-46e329fbd2bmr146354195e9.27.1759220516099; 
 Tue, 30 Sep 2025 01:21:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f65290sm44620345e9.13.2025.09.30.01.21.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:21:55 -0700 (PDT)
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
Subject: [PATCH v3 05/18] hw/s390x/sclp: Use address_space_memory_is_io() in
 sclp_service_call()
Date: Tue, 30 Sep 2025 10:21:12 +0200
Message-ID: <20250930082126.28618-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


