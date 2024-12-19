Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC84E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIG-0007bP-Rv; Thu, 19 Dec 2024 11:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHii-0003Aa-F0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHih-0002O5-4b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIdN8k8UxbFd6pPRixbwE/O/YwzOJXLRbaptlMiUIjU=;
 b=XWmOV9wUwyPje4Vsu/KP4BYWBfv2DOxk5DjZrlLHQo+myGqqXcnlVsCYm0+2GskYFvRb8m
 +det+ogPsXSzjk/znJrjEpF05dqo283T6SB9uKvNYMAUPo3Ei+IPhqphKm+Mnpy0tRRAyq
 aXG3LZ/4sNEEbTbgcnuNou1hm+mCO44=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-V39AOP5YN_K4uAX--bvcUw-1; Thu, 19 Dec 2024 09:41:40 -0500
X-MC-Unique: V39AOP5YN_K4uAX--bvcUw-1
X-Mimecast-MFC-AGG-ID: V39AOP5YN_K4uAX--bvcUw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436219070b4so5115175e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619299; x=1735224099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIdN8k8UxbFd6pPRixbwE/O/YwzOJXLRbaptlMiUIjU=;
 b=gg8NHc7kvw1WNOMbJKuWET0Azl2juFmVrBd9VKZlh93exuWYFRfw61SQR3uofrFQxZ
 0344x8Si7866Zkq92ArvMqc7+rH0L4hz/Goy+fN0aPVJ/rLIfP40DVuCEi8y53i/uMtO
 v/cqeW0RfA0wglumvVfHpVKqWfSAgIN2vLOWEHr2JIET+edeYzsx5+PEQDe7csSNOcsc
 YHXit283nOdXjzp8y7MdbK9G/k4brXAVjiLCKpZOgp3u5vpteOeGtOGpuRutc3z+aiXw
 g2GuBKbWdOLJTRqJ2nG+sbvfrh1WwvqzBQw+cIwLDkx1htTVmjmqgVTnZRuVndy+lEvY
 ngpw==
X-Gm-Message-State: AOJu0YxYNxTROByO5VSsn5kDwyVCkpV2SQYjMc8O25PNC8BW3b2IyYGu
 LP5wVI0WV1f/UAVTfCbWqtsqkcGG/NQB5oU32Dy1POsSTHbtoezy6KM/uW0j6r+NoVrnvNHkfaT
 Kjiw0jA2oB89atKBivNlYkV4OkFv/7mbTeIifJRNJEe8y+Jiz9CGWAcIJYiv+n/y52Dj/10fVWw
 EoBvY+aWNisuSQ9H08mmMh/4J/tO09iJFVjuw=
X-Gm-Gg: ASbGncu+J81v+GhzGqxL3CZiSKQZrRvyRRUZYRGC1Y+MrIkmR+9hHwQFnwtZn9zLd+m
 gYczmKq1q9kTnNkgtQILnGZEjwfMhPD1ciZ5lKjppzIUzywv7Cbe5zvvrNnIxr64DmoSVtcaUsd
 n6Sjow8EErBfPsQUIOpnX28s+cX5/iEih5zkUZs7rMH+w1syrNkvhMBizoA8QfBFZPTy5naZiOI
 y6LF7Q1xZxAvHck4CyjK374hyXzoOilQjC23WhKLVqiuFEgta+GlcFnaPzXShSb5bpYbLHWm7Xy
 zuj1qkStbPNc9gxVtQcMtrE/wPje2PrFpfVnCEfH
X-Received: by 2002:a05:6000:186d:b0:385:f677:8594 with SMTP id
 ffacd0b85a97d-388e4dae534mr6569882f8f.43.1734619299434; 
 Thu, 19 Dec 2024 06:41:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFQKY2hGjqemM6rtrThUOVEhVLFMaAF+U6FklQxfKRNp1OyH97jHfYFfU2gMBiPflYIVnk9Q==
X-Received: by 2002:a05:6000:186d:b0:385:f677:8594 with SMTP id
 ffacd0b85a97d-388e4dae534mr6569844f8f.43.1734619298986; 
 Thu, 19 Dec 2024 06:41:38 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-38a1c84705esm1709900f8f.44.2024.12.19.06.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:38 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/14] s390x/s390-skeys: prepare for memory devices
Date: Thu, 19 Dec 2024 15:41:10 +0100
Message-ID: <20241219144115.2820241-10-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With memory devices, we will have storage keys for memory that
exceeds the initial ram size.

The TODO already states that current handling is subopimal,
but we won't worry about improving that (TCG-only) thing for now.

Message-ID: <20241008105455.2302628-10-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-skeys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 6d0a47ed73..6ea4d8c20e 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/boards.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
@@ -251,9 +251,9 @@ static bool qemu_s390_enable_skeys(S390SKeysState *ss)
      *    g_once_init_enter() is good enough.
      */
     if (g_once_init_enter(&initialized)) {
-        MachineState *machine = MACHINE(qdev_get_machine());
+        S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
 
-        skeys->key_count = machine->ram_size / TARGET_PAGE_SIZE;
+        skeys->key_count = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
         skeys->keydata = g_malloc0(skeys->key_count);
         g_once_init_leave(&initialized, 1);
     }
-- 
2.47.1


