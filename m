Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C32D58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyso-0001V3-OD; Mon, 02 Mar 2026 03:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysf-0001Qb-J9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyse-0001Uz-0b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5XVQye+19ruydFJSwvWvInX5SHaYM971FB7J2eYwf0=;
 b=HMO9qGY1PVcEr7j2k+xf55JF6VxqB8qQ4Zl4m+ZvuM/oV8vBcnxKGNq3VYA5QHSSdJPtPX
 wdb2WeSeRb5clReMlZD3ZLvnH+WAhRIUYVjNN6K1NQMAznWAT70iRCseXsq4+gp+BNQ7lm
 NemUI4qdx6Yl+oQSr5gDgQ5S2R3a8KE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-Q9OllKekNSSDqeFn6Z_OZA-1; Mon, 02 Mar 2026 03:43:54 -0500
X-MC-Unique: Q9OllKekNSSDqeFn6Z_OZA-1
X-Mimecast-MFC-AGG-ID: Q9OllKekNSSDqeFn6Z_OZA_1772441033
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439b3b408f9so945651f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441032; x=1773045832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5XVQye+19ruydFJSwvWvInX5SHaYM971FB7J2eYwf0=;
 b=sU2Ji0w7X8uiPiRex5zFXwBASEZjuGZKNtRRsCnTPPjSWKpwrABu3+/xhXImidk0IR
 z5YlPZcuL6lsaRVLjTDElDIZh/hBjYdlW8K+Lzit83IS43W0ZTvAJNEBczt02jHjxt/Z
 YeWCJxNuXPH8lbMr3nLW0AAZkN/my0884ZI1uCtQSoySh92PSC4bip3gJiViNECbZ5l1
 3MCAFGAfyc9E5zb0gPS8sHwm8/1pdQ/qouDaPl2Frj1pfq27DkA1Rc0TVwE5keTMnHOW
 B0ATaB2IxLVfmuI6X5jpPeVxfTjLe9syNQ15LMP7IPRuLdWy2vcTWg0bAkFzLz1I/ZR1
 RJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441032; x=1773045832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u5XVQye+19ruydFJSwvWvInX5SHaYM971FB7J2eYwf0=;
 b=BJfb90dTWp3gdvi94SpVzRgTDNdOz6087hSs5HprjCEE75DZG8Tumix8ch4AeGdbpR
 tAoFUsJbezt34Rb6KX+ot3/4Bw8HGy4irq9qGdqJqqRwzOP0x/AIVQ+kQLjOsP9cxaSm
 k3DwmbX8IlFbXK8tFfmVCYXUOeGPrM7RamjY2jvEByr7bjtWky0HiAe+h0McN1Mtyr1+
 OGQHbugbVOzNag7oZAPzsXJARfQaWYuK1bAkg3AWWh2DAhDip9Mk9WT0t6NKUqP2sA4z
 Xt/Koe4Bb2UMQMhOMFv/9vymc86QP0A3X3/LBykpCXdeH8Qw1Q3di20eG+uMV1Pr1l5R
 6Dpg==
X-Gm-Message-State: AOJu0Yx4lODOU2dV3uDaHsHeO98NG4rgvsivjQoRfoZ9kj3kmY7+Sk25
 n7gXOgCMzI5unpnl+Ik0jLm7OCSICdiBw5AYxK2Zkq72vBRL8wD+/XLjerx0hv7d6oYrFvZKW9f
 PAWmHc4TtprQA8FAChdlAs27gzYDQ6X+szWXNnieMtOjp1eT1mnwburfZSc/i6+o5yUF8Abdk+t
 WbmYJvJwFjzoYZRBrKtVm4PYcGvlzcyVOv+Wr5qGk5
X-Gm-Gg: ATEYQzyw+e25nKmVlmcIfdHMQoK1/gBMNl3MHCjAt0hrYNRQf4QMVJrMF7AhdU0Gfyn
 RmYAuDCtYlZ1kVFL2/D0dLHPYe3vQ0V97sh9n3Oa1J8zTCWnRxDnVQjoxFktKVjMqebpDwxfriO
 h/wzWIbZqyrb4RZSerUZUbp8EoJkDJH3wvF3R2hr1pwcFw2Qea96GM/dIE1xgvGsZjUbAXXLBZ9
 q3ETSF1yCfTcphqUTU3cbAXBmnEhiByWPnLtNdwKXJYYczF1UsWqYi09qkrasLsn9p0aKq07zxQ
 mqd8zNRdJfg49pWSQ49vkFnMxXAhH4n+XQgR5i/u3gDez+0yig1y2UJwP9wzs6gRW9OlGHknPGD
 tjbgT8CDlp73FSq8CTnoH1rbcfBEIcuVGm4fDLxsinxKxTBBV9M/EVFZSoOQe2ZkvEvQT9z3u8F
 mVQRCz7aVYbYLh07Q2iDwthjR1UOM=
X-Received: by 2002:a05:6000:bcf:b0:439:aa1d:be10 with SMTP id
 ffacd0b85a97d-439aa1dbeaamr8602768f8f.40.1772441031884; 
 Mon, 02 Mar 2026 00:43:51 -0800 (PST)
X-Received: by 2002:a05:6000:bcf:b0:439:aa1d:be10 with SMTP id
 ffacd0b85a97d-439aa1dbeaamr8602715f8f.40.1772441031356; 
 Mon, 02 Mar 2026 00:43:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439bb686a32sm1967191f8f.13.2026.03.02.00.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:43:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Wei Liu (Microsoft)" <wei.liu@kernel.org>
Subject: [PULL 003/102] target/i386/hvf/x86_mmu: Fix compiler warning
Date: Mon,  2 Mar 2026 09:41:58 +0100
Message-ID: <20260302084338.473368-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

When reusing the code in WHPX, GCC emits the following warning when compiling
for i386-softmmu under MSYS2:

  In file included from ../src/target/i386/emulate/x86_mmu.c:20:
  ../src/target/i386/emulate/x86_mmu.c: In function 'vmx_write_mem':
  ../src/target/i386/emulate/x86_mmu.c:251:25: error: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'target_ulong' {aka 'unsigned int'} [-Werror=format=]
    251 |             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~            ~~~
        |                                                                       |
        |                                                                       target_ulong {aka unsigned int}
  ../src/target/i386/emulate/panic.h:34:12: note: in definition of macro 'VM_PANIC_EX'
     34 |     printf(__VA_ARGS__); \
        |            ^~~~~~~~~~~
  ../src/target/i386/emulate/x86_mmu.c:251:48: note: format string is defined here
    251 |             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
        |                                             ~~~^
        |                                                |
        |                                                long long unsigned int
        |                                             %x

Fix the warning by reusing the target-specific macro TARGET_FMT_lx which exists
for this exact purpose.

Fixes: c97d6d2cdf97 ("i386: hvf: add code base from Google's QEMU repository")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
Link: https://lore.kernel.org/r/20260223233950.96076-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index afc5c17d5d5..fe44d2edf4a 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -244,7 +244,8 @@ void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes)
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
+            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
+                        __func__, gva);
         } else {
             address_space_write(&address_space_memory, gpa,
                                 MEMTXATTRS_UNSPECIFIED, data, copy);
@@ -265,7 +266,8 @@ void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
+            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
+                        __func__, gva);
         }
         address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
                            data, copy);
-- 
2.53.0


