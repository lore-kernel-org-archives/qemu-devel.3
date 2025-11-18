Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A357CEE34C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQx8-0008CY-2b; Tue, 18 Nov 2025 14:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQwx-00087J-5e
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:11 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQwt-0005zf-Cs
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:10 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so28781475e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492463; x=1764097263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QC8WE8eYMgcfS9sjroA8zBJbr2zc7zfo/2xABclw2L0=;
 b=X5gXXUVCpFjDd7i/5R+WA8RUzDCYaqs1Mvl+F5NmUucci+is+9dSF7CKvzDhN4azfJ
 W6VU9wnHVMrEmrciCE+7N1dYOHkvhFV84eDuxFt/OGMFLzwlsSsVwQOhKiX3Y6OfWHdq
 7t0d/3mMF2+qBzKd8ZqXRA8+FzBSAfdIoyhMZZNX3e/BjVQE+JNh/fvKhqrBv5MCN3oc
 cA05LOGcJJAvLt1eAq4GW2YJ7UXSiD1jfB12Aw86GQKMCDrnDQICXRoaICGlW3a5M/kX
 obUTXs8O3/E8fWc4wOzTar99/J6SV7U5nAZT27WcXDf8OSIYifNutThfQRrVAn7zQKpt
 retA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492463; x=1764097263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QC8WE8eYMgcfS9sjroA8zBJbr2zc7zfo/2xABclw2L0=;
 b=BJnbuHJ7LYZ3yGl7stFDk9zJ6GqCbOAxlu0s/GyZzWMOST/42w9XOP7I2hV67x6pYc
 UImYC4c9bdBRMNqPgHwdBUXeKRyL4rMutW7OCPocehWksV9vKY6SteNWa0aOCJg5QsEd
 x9K6ib/jLh3mxjOGva5ZWtA9MmKOYNNIr68DyIkSid5MyDvK7u3bC4tiT+tn36JU+m5w
 xinB2le+3RJXs0YKbGpXhJdWj5BAGXp7+GdejsGYGmh4dTIogblXhUXFCvUNIIY44MmB
 H0U0mj24AtpMvNy/u1sRUnK8u5B4uoH/hu4jCmOSHkV/N0/8TAJoY+V+47T1V4oUOVVt
 43ww==
X-Gm-Message-State: AOJu0YxTHn4KiM3qhwVRntnk1rsrMkCWESREHXKzX7zBbJVpOBT7OZfx
 g/RvhgfP80sQnEy6TA68/rVfiLn3Vn2qdwUxl+65Z9ZMxhyphryhpkLGhdd1KKuWgrZ36W0M0Rf
 s9e54D9qAYxTg
X-Gm-Gg: ASbGncuDvdmEJlCSijZhO8f9CojgThCkNchLYUVxz6wR+1/ae0h8EV+pgm1vLl7xe11
 zokN5WV5RqgEmV55Qw1G6CK8zec3OXlmkmM0WYbM3TxQy1qKMyJGNmPL/i65xJM1GnuinDLiKBC
 9orH3Z0rVNtOBDWKETaS5ZBJn1PmZRmu9bp4nsVRTnIct6K2YraCXyBH96nWDjySqi9OVkYqnYJ
 HsiZfku5oqDd/p+nSaTnydv+MijqpKUbgcguzBZNP6delwUgRlttvtYvS9+07BGdIQ4biooAkCs
 HjGz7mDkXKwdeBqeaag46dwzqU81B5xiAoqjtKJZG6zi3GFB+Qliu8YyTx3ZebDxY1Vv7oeiAVy
 XAaYeN09hpN3VQ1RFjotbCk8nLwGwsqLEs6ur1vxYEYjWYS8WhfxfyyMoF/090cWKU+SaBNVQdx
 25Ke/Spy5dsA2+R9rYe8+i+Lped3nkhXqJYVgaww5kwFVcWYh+8Lro/HEZ/WZk
X-Google-Smtp-Source: AGHT+IH0I+9C+HeUrCvYPESlnc6sMV0sq5hDciSWKvU1EkBjarEwsjIZiewdGkhRXo7qK2Ur2BbDUg==
X-Received: by 2002:a05:600c:5246:b0:477:a977:b8c2 with SMTP id
 5b1f17b1804b1-477a977b995mr32655345e9.13.1763492463530; 
 Tue, 18 Nov 2025 11:01:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b106b10asm5154785e9.10.2025.11.18.11.01.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:01:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] MAINTAINERS: Update David Hildenbrand's email address
Date: Tue, 18 Nov 2025 20:00:36 +0100
Message-ID: <20251118190053.39015-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

Switch to kernel.org email address as I will be leaving Red Hat. The
old address will remain active until end of January 2026, so performing
the change now should make sure that most mails will reach me.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251103103947.384401-1-david@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 18 +++++++++---------
 .mailmap    |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38325e0617c..d1c5080e505 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -364,7 +364,7 @@ F: target/rx/
 
 S390 TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 R: Ilya Leoshkevich <iii@linux.ibm.com>
 S: Maintained
 F: target/s390x/
@@ -1862,7 +1862,7 @@ F: target/s390x/ioinst.c
 L: qemu-s390x@nongnu.org
 
 S390 CPU models
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 S: Maintained
 F: target/s390x/cpu_features*.[ch]
 F: target/s390x/cpu_models.[ch]
@@ -2384,7 +2384,7 @@ F: tests/functional/x86_64/test_virtio_version.py
 
 virtio-balloon
 M: Michael S. Tsirkin <mst@redhat.com>
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 S: Maintained
 F: docs/interop/virtio-balloon-stats.rst
 F: hw/virtio/virtio-balloon*.c
@@ -2532,7 +2532,7 @@ F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
 
 virtio based memory device
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 S: Supported
 F: hw/s390x/virtio-ccw-md.c
 F: hw/s390x/virtio-ccw-md.h
@@ -2541,7 +2541,7 @@ F: hw/virtio/virtio-md-*.c
 F: include/hw/virtio/virtio-md-pci.h
 
 virtio-mem
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 S: Supported
 W: https://virtio-mem.gitlab.io/
 F: hw/virtio/virtio-mem.c
@@ -2919,7 +2919,7 @@ L: qemu-s390x@nongnu.org
 S390 floating interrupt controller
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/intc/s390_flic*.c
@@ -3248,7 +3248,7 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/system/ioport.h
@@ -3268,7 +3268,7 @@ F: system/ram-block-attributes.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
 R: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
 S: Supported
@@ -3371,7 +3371,7 @@ R: Ilya Maximets <i.maximets@ovn.org>
 F: net/af-xdp.c
 
 Host Memory Backends
-M: David Hildenbrand <david@redhat.com>
+M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
 F: backends/hostmem*.c
diff --git a/.mailmap b/.mailmap
index 7f817d9f425..0690f7be34b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -82,6 +82,7 @@ Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
 Brian Cain <brian.cain@oss.qualcomm.com> <quic_bcain@quicinc.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
 Damien Hedde <damien.hedde@dahe.fr> <damien.hedde@greensocs.com>
+David Hildenbrand <david@kernel.org> <david@redhat.com>
 Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad.frederic@yahoo.fr> <fred.konrad@greensocs.com>
 Frederic Konrad <konrad.frederic@yahoo.fr> <konrad@adacore.com>
-- 
2.51.0


