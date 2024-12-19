Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE6DE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJHc-0005sq-2m; Thu, 19 Dec 2024 11:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHie-0003A1-7M
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHib-0002NT-Ox
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfkChPr+ra7P61re5axqyhrcegwzNh2gqwFHHmftqG0=;
 b=bcYK7CJzsXVAeOZsKg3lULCA4lr2aRbPIXQfbOPRz8AMBN2moRJvYPputAdqk1H2e1HIW3
 mxCkFx+Zc6XYrxZJNykGabf2CVtgIz6MEXe1olRLfrDaqsvjxktNT80WiyoJ8/3JMLUr13
 bvNtqnVMsRapPBvv6Lqwa1UwGaeVP1k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-t0QnZrSoOGGsRegygGGVbA-1; Thu, 19 Dec 2024 09:41:35 -0500
X-MC-Unique: t0QnZrSoOGGsRegygGGVbA-1
X-Mimecast-MFC-AGG-ID: t0QnZrSoOGGsRegygGGVbA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43626224274so5477415e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619294; x=1735224094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfkChPr+ra7P61re5axqyhrcegwzNh2gqwFHHmftqG0=;
 b=NK9iQ/PlSfOeTEY4nKRe002v1y5Pkz7O4EjfIWwERcnJ2Xz8+ykLZXPiKepvvolU3i
 gHgcikH6/M38MgHcBJu+auosGxrqvrSGI/Y2lKY/3Uwa9DUGK9siVDNyZwX/tHMiUuqC
 +kHjUqTgQm0E8I3cEfxOmyDA5g/ERE5g75hoK2yNM+iIJv09xOS7HePuVQ9ev0dFiX/q
 SjlUlwOanhVsB6e39BsriFsrp6FGzTzl4EosJLiTNHRhssnV0CPusgrdQ2s+f915MoC6
 l7hFNTLsdmwYvOEDxRUS/0BEugSo48gPIEb2b908T357nL5mhAeoBtjveH7r4gk9GFNw
 ncbg==
X-Gm-Message-State: AOJu0YykYICanwTSKBV+RsvGQ4ayMS7kAHpg/GkpikhSwozU17dxWGhW
 JKZQV3zJVa2iqJzml/wSH9hOu7pLDvX6xGAtx2ebyEIIAA3TsxxGiPipF/B8iS5FoAESe9fUhNe
 zRGbAdv0ZM/fvOolGDHJqFVhBGw4G0HsJMft4vCYTuHDwh9I06W3Z5PAey71u+l5Na/Wl960UW3
 qwiW/9BrAh9HbI70etYj+4zLa4OPNLJeT8emc=
X-Gm-Gg: ASbGncsYDbpTj8pmRZxJX3d43YCtLXqCYGp6ir3nlNagxIsIMTPLMvle3zj8fny6JNP
 2nKYTDPnXspATp7h8c0a2AqnIsh6dqd0/PZ1c+FHwktb+iZJ621QJLCY+NISMgEa9awjlZM2Qxg
 ByvUo7fhxYPTDceqmKmhXCSXsPXSVYiJemXQER7/5UaHLscJ+YXpqvmdCGf/WxvK1irF4QdoJq3
 PDwH3gqbbxM3vmIOc8/zJizcehOTQr4cybEZhrM3EjkZQ8yFwiu3Kes2q47Oo/qNr1cTtfgDPbh
 UQPtq9B8wgRgDE/HXqDbsgeWMPYXawBxUiIArqZ3
X-Received: by 2002:a05:600c:46c7:b0:434:f219:6b28 with SMTP id
 5b1f17b1804b1-4365c7c971emr29834815e9.24.1734619294457; 
 Thu, 19 Dec 2024 06:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHztFy0IccXcInyFfCAOjcoAf7Brbxy3wqIIv0V8v9Yq/BFpdH3gxZqLrVcIRngnwr5m1N0bg==
X-Received: by 2002:a05:600c:46c7:b0:434:f219:6b28 with SMTP id
 5b1f17b1804b1-4365c7c971emr29834475e9.24.1734619294016; 
 Thu, 19 Dec 2024 06:41:34 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-436611ea47asm19692745e9.4.2024.12.19.06.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:33 -0800 (PST)
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
Subject: [PATCH v3 07/14] s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
Date: Thu, 19 Dec 2024 15:41:08 +0100
Message-ID: <20241219144115.2820241-8-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219144115.2820241-1-david@redhat.com>
References: <20241219144115.2820241-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
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


