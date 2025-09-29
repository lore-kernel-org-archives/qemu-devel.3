Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27808CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ih9-0005Di-M7; Mon, 29 Sep 2025 14:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igj-00054d-KB
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Igd-000377-B9
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:33:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso27784905e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170799; x=1759775599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3WGf5UHYCyuY+qdMKaaLuq+dGZ/nmDgi/rxgNJ1Ah4=;
 b=FGAMjFMTaBkXdkbxm1IFa99GjgfKq1zhLWSSJO/qAqujv/uYtanIA+35fah+xn8iMl
 3BdP6cfGB28GY1wmBohCAcfg5U5dXc3GAidmxGMU7/lrg7jNSKmppr+9DeEAo9Oehu1T
 +FI4SMpRTHxrwjf+/Fk7THSdoM0EMW902aS/bSvWf7vvyra2/SVqm65odXHJIp0nVhtJ
 wMdi01gnUPEXfYlzKKAtnEpgwwIKATXV+EuW4wO7ltRPPW2MousLH1JfB58k0chwHZeI
 mBQdN9SIxJ/vCPyiwjoEj7h936Y66iaFdLzTBjOMV+X4UeSSaLnvHb5Gl9WLXB/Qugy5
 sc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170799; x=1759775599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3WGf5UHYCyuY+qdMKaaLuq+dGZ/nmDgi/rxgNJ1Ah4=;
 b=ONvI+RNyvpZYBL4zW5RxYIUlFHhNwfHh9V2+dpY8SA/smAeTtUPdm5XpiffBTzX7qA
 BGAjytn1GKn30pR1ycr3VAm+Og4+YfO30aNmUwdfcSQLLbD4VM1pl2RochC/LoXoNXsO
 Dxxm4KdjUNZZXk3nzVJp4rZH/sabdmgQnd3yMIIjCbd5G1YtFJbtDtwHxzD9gMfSfs43
 ZiY/FaujiwtIhS+pI2emPNJRUzsrbWXE4GWzL8FyENaAdHpx/gHegcS/fmPZQ7hOaP9K
 JblYaZSTzdEby4GgWBEl7qczhXk3LHTIcF8c8DHdS07X4gTdbN7UIlaB6LW/YCqZAizK
 lZvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZvonzHvL77o6vQA8oQkmdkh41PLuCRbpAn5YFfAd8CDN448h0bdv4UlPq16UqgC4jcO3HltpY4Htx@nongnu.org
X-Gm-Message-State: AOJu0Yw+Jgbl0ayT/kKnu1V1S1Rus23PomKrNjWzd/Jalv6wt0w/UfgV
 h2P/+/EHUAmA3sbrbzn4JtbzFtyIRF1gMz6fsOQE+x+S8Rn2alJ32hbdabS2KPim6ig=
X-Gm-Gg: ASbGnctIJaqWkZbI503RHYMSGCblXREHjbxclQI4vVhlqBqKw0GeXCkRVCi/Vqe2jB4
 pyIDsatOa1d21YcQFwwli921v5vgGD7qgy2Eu0U2OCzSc+/o/jPq/8O/ebOyIA636mj+l9if6yJ
 w8qxE2PfuIWfmbBZGx8ikfnC3kKB8LWI/eNEcNZKFhd84NbyJYzqHBXlOF6C5B1sRFw3HnXtY2d
 8tDYHWyP3G74Rf0mS8b2schl2FgTFAhBeehZRcNVOakskL91kv8hG4VeOLpmHxRPKwcYszU8/WY
 2kby1qUgsVJutPmOqK+RvgnXFGO7XnpH1p98QSagGPxKB0Tj1ysvs3xt4X97IKbml90w3R0nuIe
 tLtAuVcwid0x9aF5WqDLiu4zMNW7Y1pFZAj2DE5/Io7EWd4L3n4h+gE1vCES1hzEZoOGiSHcIOt
 TBYESJLU3UEP5qPhEVcA==
X-Google-Smtp-Source: AGHT+IECk0pxJcrABdWnp0wBblgE/rUdgkYk2QyHdrh6Fg0EQMQZuDnjhZ/xllYj8G986Z96HgDgnA==
X-Received: by 2002:a05:600c:1c01:b0:46e:5208:ded3 with SMTP id
 5b1f17b1804b1-46e5208e228mr55680385e9.15.1759170798830; 
 Mon, 29 Sep 2025 11:33:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7d3780asm19281036f8f.52.2025.09.29.11.33.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:33:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 04/15] hw/s390x/sclp: Use address_space_memory_is_io() in
 sclp_service_call()
Date: Mon, 29 Sep 2025 20:32:43 +0200
Message-ID: <20250929183254.85478-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 hw/s390x/sclp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9718564fa42..c0d8c335b44 100644
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
+    if (address_space_memory_is_io(as, sccb, 1)) {
         return -PGM_ADDRESSING;
     }
     if ((sccb & ~0x1fffUL) == 0 || (sccb & ~0x1fffUL) == env->psa
@@ -317,7 +319,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       &header, sizeof(SCCBHeader));
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -330,7 +333,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       work_sccb, be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -344,8 +348,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    cpu_physical_memory_write(sccb, work_sccb,
-                              be16_to_cpu(work_sccb->h.length));
+    address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                        work_sccb, be16_to_cpu(header.length));
 
     sclp_c->service_interrupt(sclp, sccb);
 
-- 
2.51.0


