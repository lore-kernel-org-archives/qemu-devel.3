Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C60C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhkt-0002tq-5j; Fri, 22 Mar 2024 12:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhkr-0002tY-To
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:28:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhkp-0003UN-A3
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:28:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4140aadfe2eso17361285e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711124905; x=1711729705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7QdAIBvFnVQkIHc7ZXX6yGjuUKjHY2VoM4j0omCFJVI=;
 b=kK/7B6v31BXRDgCol18Ej57kO4zj6yrKNQ6EWtwZNj14hWoQ7+AJ/Xgb50tyXww/EP
 jclLsCItyTQXpfjI7WKoS1YEsCJgAef3l3J+glz7dqEyA7x71/bFUZBhYMZrOn12fgjw
 6KaFltra4tlld8nk2m0EGX+lV8ifIxW5t+96RPXz6Rw+Mt8Z214XSTqeYI+OpiP/up5j
 VYVyQwTsVJlu4+cZ7Y9f5VB3F5fd07ty8y/c3DCrBNrtzMB8oY1kAedE+Gaehy1TEFu1
 WDjPnqUbrCjv/ue0OcAMDHkNMkO4b5Hr7V4VUth8R0Zii2gktRHGuZfi9rnXp21zPD20
 R1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124905; x=1711729705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7QdAIBvFnVQkIHc7ZXX6yGjuUKjHY2VoM4j0omCFJVI=;
 b=LBMUB8ntK+AJlHVwudVvKOMiwWFWCf9JcZC+z68eNmHHWwdj5bbB2bjU4+T7SOBrqB
 qf6vqAfrq9prbGw7HloG0R/4DhXCyw6gPurFeyJA/J7kCFd3fSsaIi9lFFe0dIOcIeI/
 WLoihdKf3s1ObcU/vfjboYaSJaL60b3fCbSSiaZN+iMoIz9cjsjrkIfr28CTD0tjb2YV
 ikDt67fE6FtWI1NX47bcRg++E9FNszdGYsbcbz+h4/9goadAmBdX6S7ZLl1BYNasKwg+
 n2dHf4+b9A5LsuOiYwRQdOoV24CVwBMDi35GGT7YejbEX/rf+G19tng4Sn4YkcolcmI4
 z7Yw==
X-Gm-Message-State: AOJu0Yy7iGaLToR1v+kYdnZqAC5XkS3xHTTPwmWcHatqmpltHVrWv9Mo
 sGlCUG8NzJ3JtnsUA0ukG2+URW6q6hyHetnzzzxoblI8Fv5TxTKvgJH+t+4513cmpHej3lyPStK
 8
X-Google-Smtp-Source: AGHT+IGp3OszdZpj8J8Od3tnDJNRaFgneYYJInxnxCT394gdzGwWqLgF+zz92oqjmRJu6AnPYDHwgA==
X-Received: by 2002:adf:cb13:0:b0:33e:652b:d6db with SMTP id
 u19-20020adfcb13000000b0033e652bd6dbmr1655893wrh.23.1711124905395; 
 Fri, 22 Mar 2024 09:28:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a056000018b00b0033e75e5f280sm2375905wrx.113.2024.03.22.09.28.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 09:28:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/s390x: Include missing 'cpu.h' header
Date: Fri, 22 Mar 2024 17:28:22 +0100
Message-ID: <20240322162822.7391-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

"cpu.h" is implicitly included. Include it explicitly to
avoid the following error when refactoring headers:

  hw/s390x/s390-stattrib.c:86:40: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
      len = sac->peek_stattr(sas, addr / TARGET_PAGE_SIZE, buflen, vals);
                                         ^
  hw/s390x/s390-stattrib.c:94:58: error: use of undeclared identifier 'TARGET_PAGE_MASK'
                     addr / TARGET_PAGE_SIZE, len, addr & ~TARGET_PAGE_MASK);
                                                         ^
  hw/s390x/s390-stattrib.c:224:40: error: use of undeclared identifier 'TARGET_PAGE_BITS'
          qemu_put_be64(f, (start_gfn << TARGET_PAGE_BITS) | STATTR_FLAG_MORE);
                                         ^
  In file included from hw/s390x/s390-virtio-ccw.c:17:
  hw/s390x/s390-virtio-hcall.h:22:27: error: unknown type name 'CPUS390XState'
  int s390_virtio_hypercall(CPUS390XState *env);
                            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-hcall.h | 2 ++
 hw/s390x/s390-stattrib.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 9800c4b351..3ae6d6ae3a 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -13,6 +13,7 @@
 #define HW_S390_VIRTIO_HCALL_H
 
 #include "standard-headers/asm-s390/virtio-ccw.h"
+#include "cpu.h"
 
 /* The only thing that we need from the old kvm_virtio.h file */
 #define KVM_S390_VIRTIO_NOTIFY 0
@@ -20,4 +21,5 @@
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
 int s390_virtio_hypercall(CPUS390XState *env);
+
 #endif /* HW_S390_VIRTIO_HCALL_H */
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c483b62a9b..aaf48ac73f 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -19,6 +19,7 @@
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "cpu.h"
 
 /* 512KiB cover 2GB of guest memory */
 #define CMMA_BLOCK_SIZE  (512 * KiB)
-- 
2.41.0


