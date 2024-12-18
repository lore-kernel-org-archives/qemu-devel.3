Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAC1E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrhW-0000ho-9L; Wed, 18 Dec 2024 05:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhO-0000fQ-Uu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhN-0006nw-8G
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfkChPr+ra7P61re5axqyhrcegwzNh2gqwFHHmftqG0=;
 b=VC7pE+7h8JQjNgUCtHEwrjJXbvFtNNLGlF5PP+35fV1J/o+Ah/sKCJ553MdZ9toRie5Lqn
 GwrK1mQ4pOdY6yNgGfBal/L8yqYDlcmBxc9z+SED3kAF1N8gZe3Mv4HA0KD6qV/q4HDHfX
 f0/h5Ri1zMp4XVCn6OJjsi6ig1nzWts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-vlcJU-2PPRGJKetxQWvDOg-1; Wed, 18 Dec 2024 05:53:27 -0500
X-MC-Unique: vlcJU-2PPRGJKetxQWvDOg-1
X-Mimecast-MFC-AGG-ID: vlcJU-2PPRGJKetxQWvDOg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43626224274so30055115e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519206; x=1735124006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfkChPr+ra7P61re5axqyhrcegwzNh2gqwFHHmftqG0=;
 b=jdZwOzLDmGT3epeC+0G4G4eMqxBz0CDVorKILlrVff3RQ1ugfMOLubzyF9OFuZHWzd
 7ApLDNsPUE3tj8pGtpR002rUcD8hdIol7CwBRu0V1F/dTCqTaifspYB+Zcgp7AQ3iEUx
 fOqJRfZ/yIslOR2lNncW1lfvZmdWvyjnheN2hNMjp7xOnvTs/AH9ipPC/UYKem08kHyf
 /+B2ziH2B4e13RduwhdcNxTh9ufJq3IwbUwmiTn9TMFPpEdImDD5op/KHZOV7LNycW8Q
 yr5hrj6oe+AkXFIxzLqvzhXgfdvPoGCjHOiHlFnrmfqUbEyS/4Jeshy/ecYVhw+q00dW
 5Myw==
X-Gm-Message-State: AOJu0YzmE26BC/5GUge1qWika00Kwl6fPVZO/ErOhn6P4AMY/jfSKZU3
 ak2LXybs4HXlyAQZvwdQOhwoXtB9ETaJm+X8FCkZJQ++v3ZWQ9eJH/p1pTdDSh9Cx4B0ZmGQKG7
 XBmgWgb1lcd3yN54jIgSK647nExilDXTpcmB0WMofp7sAtwsMfhIhBMfS8wzCdhJFfqW6QM38yX
 jTwA+iTgB6baFVcFSSzHGuQrnfj9A9DCNWekY=
X-Gm-Gg: ASbGncubGLA3+t89J+FdKwzbtJ2+eztQTKdj4izY3cjVJZbU+h+K4lGvs1+8MVYIoSv
 hzaQswTEYWG4DnuPO96IZQzJkeMTJNtfgW2YK5WHE7SwGL8P4vxCj+9wagd3s5GJ8RZOHuBLiYM
 VyYP0j0sEJtsHRjhyFMpbJIXZq+fEIUMoA0zQVX7y9TNtxKC1XvRtXXdeS5UkZiyhvwDAb083Km
 CaFnC4ykM096PmQ3X0jYlHEz6dJW3mwcH8F0hMzl7F4iLGAmRcJQ2RUqfqtrQNszhRQrZmNkQdy
 zNo2zj5FZSkzQpEtx5TbGd8vtwYXfko0Kiag6GXCFQ==
X-Received: by 2002:a05:600c:1f94:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-4365535e846mr19927305e9.14.1734519205824; 
 Wed, 18 Dec 2024 02:53:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSUhBLgWM5bVGNdLsPpmeKl/5hCAanDdAfVEFcyV7cNYMKaEOASE/oGKT56FKYHG1P3wmLqw==
X-Received: by 2002:a05:600c:1f94:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-4365535e846mr19926935e9.14.1734519205341; 
 Wed, 18 Dec 2024 02:53:25 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b00cf6sm16763155e9.10.2024.12.18.02.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:24 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 08/15] s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
Date: Wed, 18 Dec 2024 11:52:56 +0100
Message-ID: <20241218105303.1966303-9-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
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

A guest OS that supports memory hotplug / memory devices must during
boot be aware of the maximum possible physical memory address that it might
have to handle at a later stage during its runtime.

For example, the maximum possible memory address might be required to
prepare the kernel virtual address space accordingly (e.g., select page
table hierarchy depth).

On s390x there is currently no such mechanism that is compatible with
paravirtualized memory devices, because the whole SCLP interface was
designed around the idea of "storage increments" and "standby memory".
Paravirtualized memory devices we want to support, such as virtio-mem, have
no intersection with any of that, but could co-exist with them in the
future if ever needed.

In particular, a guest OS must never detect and use device memory
without the help of a proper device driver. Device memory must not be
exposed in any firmware-provided memory map (SCLP or diag260 on s390x).
For this reason, these memory devices will be places in memory *above*
the "maximum storage increment" exposed via SCLP.

Let's provide a new diag500 subcode to query the memory limit determined in
s390_memory_init().

Message-ID: <20241008105455.2302628-8-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-hypercall.c | 12 +++++++++++-
 hw/s390x/s390-hypercall.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index f816c2b1ef..ac1b08b2cd 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/boards.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
@@ -57,6 +57,13 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
     return 0;
 }
 
+static uint64_t handle_storage_limit(void)
+{
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
+
+    return s390_get_memory_limit(s390ms) - 1;
+}
+
 void handle_diag_500(S390CPU *cpu, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
@@ -69,6 +76,9 @@ void handle_diag_500(S390CPU *cpu, uintptr_t ra)
     case DIAG500_VIRTIO_CCW_NOTIFY:
         env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
         break;
+    case DIAG500_STORAGE_LIMIT:
+        env->regs[2] = handle_storage_limit();
+        break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
index 2fa81dbfdd..4f07209128 100644
--- a/hw/s390x/s390-hypercall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -18,6 +18,7 @@
 #define DIAG500_VIRTIO_RESET            1 /* legacy */
 #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
 #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
+#define DIAG500_STORAGE_LIMIT           4
 
 void handle_diag_500(S390CPU *cpu, uintptr_t ra);
 
-- 
2.47.1


