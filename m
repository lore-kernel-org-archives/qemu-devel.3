Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287CCCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IjL-0007Wf-BD; Mon, 29 Sep 2025 14:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ihf-0005b9-Q3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ihc-0003is-9N
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:34:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so38199225e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759170859; x=1759775659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+R20KfaeepivX48ztS5Qk+Utu4Wf2nP4nwxC8R0e4a4=;
 b=neFSrJOSK8c8aPfjvqkzb3fk2IJNkmQf8l2rlQkfUDEFfY3i2QTwGCgTzgvj9lDYKt
 V94v1WJPUXYN7QBnd5sy1hCOZZhhXzSZ9XgXPlqiSh1cIxfzuZawHdD+SuU4SmdJFr7a
 BgtLH4tIBGBqWEaAigmNOKdGPA75BylzosebGtc/8ZWiJGrJRAPM0RzeLw0V34cVZAGo
 31MOZPac9oSZQEv3ywEuUTejNsgF28k83y1AMT8Mu5PtjDNEZuiND5IqLD8EvFk7iwFW
 Asy67g9TYThY6gURa94+5iCP1kSK+VfTAO52/TT9BPcFdekzFwH1HLvdGrolGLu+Yb2/
 gTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759170859; x=1759775659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+R20KfaeepivX48ztS5Qk+Utu4Wf2nP4nwxC8R0e4a4=;
 b=CKeFaTntDS2Bn+r3bkE2/HCZ9lByVa0p9wSdfKnalhlZZKaVfqH0oulT9mjOn6s6Dn
 htIk9YiYId1a/JFp38veT0aDWPif3NI0qIhpMdcA5jEZE801AbN0DxWlR8kWUcUfJmzW
 oykWXg6vCQa5O8WoDM3vwDlz0BzzyEk2r2zk6OzoyniR3Li996+SEUuIzygnFWmhyLDe
 +Z9i+ghJaq7WMe/bcIooPQ0jrVPbFLwHQMlHecCOKlL7CEXbkkPwdHO3a6CYhK5I6fY1
 RQYnvGQnK//7Z3H3ewiZCt0LnvrehiERGaaRHbOtCgTrcLXtJtXhVVFfLf5LSQ6si0up
 xkFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs0gqBDUee3jJdWg4ABGYFo4/4UoT9s7qM6BhZAabDafof/YCXySEsMS0qWzlqOwbvqiWpGYAGDCKR@nongnu.org
X-Gm-Message-State: AOJu0YwmUPdjbjxpxtU2B27at4jO0V51eYTVwUhjnr7DTvOg7s2XvKat
 rZw89FVStXXkalAkpwnJL75bPi7AssS8meAaFx83sPwKhCMLPgf9G1TMR7gj9kt7bOE=
X-Gm-Gg: ASbGncuOu5AiOn6D9yRIqUMXk32y224mqHGZS0IiBXpCmAVFskDMQPf0V35+GYTDgB0
 /AfcKuKQeHFC/P18ZbTIZfH5xPnRFC+IiGh034y/OJOIKXZB0dmD+PF+Oo2y7eaOjpHpOvSIycX
 F4awrhohrrbdJi90gY+lGKbXtIzcdJei6k/oaMawMyRbgERXjLKDVMNHvtBArcSwJbbB89u4bnf
 RW94TITSkDfYPp7xePcA02VtYox+o3B246G4GoEIJnprXKvte6Jlvzi281CEWTW0g8k+qp5wt/Z
 Yk8mKFbTNN4wlweIyCn5TT8J+nA8v15q9llI2bsjuNXm49n3eTd7AhkrIwxWV83jTrPok5a2vZ4
 xsD5xcGKbcLNX3O/YbI22rVBeIG7hR4NmjgZ+J8kVvbJdPf4jqdJRxvEKioQDhLFYd7KcFnaL5j
 WvR8rLYN0=
X-Google-Smtp-Source: AGHT+IESuOr/9kkTMP61JEo78aO/qu+Se16k4y0bZLp5zO2vT4tUYcRGwPC2KF7trcFZOrvkB6y8nA==
X-Received: by 2002:a05:600c:5491:b0:46e:345d:dfde with SMTP id
 5b1f17b1804b1-46e345de049mr203777245e9.16.1759170859187; 
 Mon, 29 Sep 2025 11:34:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6de90desm19572933f8f.47.2025.09.29.11.34.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 11:34:18 -0700 (PDT)
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
Subject: [PATCH 15/15] hw/virtio/virtio: Replace legacy
 cpu_physical_memory_map() call
Date: Mon, 29 Sep 2025 20:32:54 +0200
Message-ID: <20250929183254.85478-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929183254.85478-1-philmd@linaro.org>
References: <20250929183254.85478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Propagate VirtIODevice::dma_as to virtqueue_undo_map_desc()
in order to replace the legacy cpu_physical_memory_unmap()
call by address_space_unmap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e0..1ed3aa6abab 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "system/dma.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "virtio-qmp.h"
 
@@ -1622,7 +1623,8 @@ out:
  * virtqueue_unmap_sg() can't be used).  Assumes buffers weren't written to
  * yet.
  */
-static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
+static void virtqueue_undo_map_desc(AddressSpace *as,
+                                    unsigned int out_num, unsigned int in_num,
                                     struct iovec *iov)
 {
     unsigned int i;
@@ -1630,7 +1632,7 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
     for (i = 0; i < out_num + in_num; i++) {
         int is_write = i >= out_num;
 
-        cpu_physical_memory_unmap(iov->iov_base, iov->iov_len, is_write, 0);
+        address_space_unmap(as, iov->iov_base, iov->iov_len, is_write, 0);
         iov++;
     }
 }
@@ -1832,7 +1834,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
@@ -1982,7 +1984,7 @@ done:
     return elem;
 
 err_undo_map:
-    virtqueue_undo_map_desc(out_num, in_num, iov);
+    virtqueue_undo_map_desc(vdev->dma_as, out_num, in_num, iov);
     goto done;
 }
 
-- 
2.51.0


