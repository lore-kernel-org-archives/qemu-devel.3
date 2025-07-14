Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85E9C83F22
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHas-0003fw-AZ; Mon, 14 Jul 2025 07:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1r-0002Gs-Gi
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1o-0002I8-SL
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lx/3OjKQQiRwtu1QUxLqhLmOvdf3soAfb9Z3azPYw/Q=;
 b=H7mwPrpJYIq3UYx4OisjagINGW1EKLm3l9rpDMp/nDB9/n7BYYRgTTEN95uAL5axwCq2r/
 ZiGLev/QqRV3I0uom4ZGMvLU63AB3EzCl0R8n0VINwEB2kf8QfRPjYe0cUe+yZ1b3YH/sn
 SpCBXhj4/rywuqz+Ngkab6lja2wlMQ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-GbReMxxdN62UnJ_54_n1SQ-1; Mon, 14 Jul 2025 07:07:22 -0400
X-MC-Unique: GbReMxxdN62UnJ_54_n1SQ-1
X-Mimecast-MFC-AGG-ID: GbReMxxdN62UnJ_54_n1SQ_1752491241
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4561a196f70so4845325e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491241; x=1753096041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lx/3OjKQQiRwtu1QUxLqhLmOvdf3soAfb9Z3azPYw/Q=;
 b=lAatpUyt91DrKtwrhDA7QtymlowfpKPn/syDJjOVYwkGoYab1FulcsrzXB1EHwPp2P
 KtiQYhtNlzssEx+wecD7WYZSqjQcusY1e7TYEPz0byMFuBnqOzM7k15ujTQIH4P62Or1
 GwyZgTyA9Ft0WswaWr/FdsPN9N2cAfufxFPkxD5FCQbYN4JIao8RQCo3b88zjwZKPpmJ
 Z97x8+Jcy2YeZp1VqPqBmwD7LJo/IsttsuKtkDn1CUOzZyPwDScbaFnOzaPEYaVlsFDn
 MndgfEqABCR7AB7BaWgQD5nIM1yp5my+FCchxYfOXg5UazNhfB42cxMHxxVW6KUYzc1g
 qrWA==
X-Gm-Message-State: AOJu0YxwwCWijPv6xMC6iMOFP1jI0UVkOeB5nS7YR3pPjKYbXXKbMj8u
 1iq+A7+uBAp6kM+LBmH9PROP1o7aqLBHeTWyF1Herzlg2XMkNNGHOt1iCdNzTsDI4BEfsIdm9r3
 4QiKwEq+3Fh/5OcsY+nfkoDObKycS9375vIfKNa6xZQ77fq51qIcIr04eY2zKZYv5eQLJwU+55E
 xWJbyMwFuOOt1eXiPPI1nFNchQU/wsPcY3YsDR3KTb
X-Gm-Gg: ASbGncsZokWtBiB0qaw9yTfMNHuKbUJzyH0H0iV5TIqtGDjGOeZLBSIZ7TBuEv+KxQt
 eZsKPCmd0lHO95Hlm3Sz12DB8r9MSSYMsgSdv+KCoqQoUQrUVI+dkFsNPPXUV12u3XFszgsCsye
 Nu02P4L9KJaehkXOZGhWDk/9XfxStWuQLez9Go4jb6rcFd3wdFf/Ixy0+vxa9/x5qNdIToXhNh2
 1yad2nYYrRFuhUJNLVh+Mh56HdLzwN0M/zZWhtG0pLwm7LXc+X71kJobSDi8g62a9De+sDOcvRe
 kDjmDsKm0rn2YD8SRzC5X9Ya9yeLjAdpuJkQ98kCx1c=
X-Received: by 2002:a05:600c:1c23:b0:456:2347:3f01 with SMTP id
 5b1f17b1804b1-45623474399mr4341475e9.20.1752491240714; 
 Mon, 14 Jul 2025 04:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHecDM8iuOfxAcVoT02BLVouFzGYITNitOhWCHtmLENnuMQ7tX9cWWYCHnvgUBPgiaIlFfK2w==
X-Received: by 2002:a05:600c:1c23:b0:456:2347:3f01 with SMTP id
 5b1f17b1804b1-45623474399mr4340995e9.20.1752491239785; 
 Mon, 14 Jul 2025 04:07:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d587sm11907762f8f.46.2025.07.14.04.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Qian Wen <qian.wen@intel.com>, qemu-stable@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 75/77] i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
Date: Mon, 14 Jul 2025 13:04:04 +0200
Message-ID: <20250714110406.117772-76-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Qian Wen <qian.wen@intel.com>

The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
Vol2:

Bits 23-16: Maximum number of addressable IDs for logical processors in
this physical package.

When threads_per_socket > 255, it will 1) overwrite bits[31:24] which is
apic_id, 2) bits [23:16] get truncated.

Specifically, if launching the VM with -smp 256, the value written to
EBX[23:16] is 0 because of data overflow. If the guest only supports
legacy topology, without V2 Extended Topology enumerated by CPUID.0x1f
or Extended Topology enumerated by CPUID.0x0b to support over 255 CPUs,
the return of the kernel invoking cpu_smt_allowed() is false and APs
(application processors) will fail to bring up. Then only CPU 0 is online,
and others are offline.

For example, launch VM via:
qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
    -cpu qemu64,cpuid-0xb=off -smp 256 -m 32G \
    -drive file=guest.img,if=none,id=virtio-disk0,format=raw \
    -device virtio-blk-pci,drive=virtio-disk0,bootindex=1 --nographic

The guest shows:
    CPU(s):               256
    On-line CPU(s) list:  0
    Off-line CPU(s) list: 1-255

To avoid this issue caused by overflow, limit the max value written to
EBX[23:16] to 255 as the HW does.

Cc: qemu-stable@nongnu.org
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Qian Wen <qian.wen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250714080859.1960104-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 12e719e9957..608fdcf7578 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7871,6 +7871,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
+            uint32_t num;
+
             /*
              * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
              * count, but Intel needs maximum number of addressable IDs for
@@ -7878,10 +7880,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             if (cpu->vendor_cpuid_only_v2 &&
                 (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
-                *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
+                num = 1 << apicid_pkg_offset(topo_info);
             } else {
-                *ebx |= threads_per_pkg << 16;
+                num = threads_per_pkg;
             }
+
+            /* Fixup overflow: max value for bits 23-16 is 255. */
+            *ebx |= MIN(num, 255) << 16;
         }
         break;
     case 2: { /* cache info: needed for Pentium Pro compatibility */
-- 
2.50.0


