Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBBECCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCC5B-0006qg-O8; Fri, 24 Oct 2025 03:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vCC58-0006qO-4m
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vCC56-0001IW-2Q
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761290363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h1qxonL+L9MKDWYeJ+RXK2VRKKtWw9z7Gm3e6WthLSM=;
 b=AkuJVoDeQj3iW54tFPK2BIEuwiLSEt43vxLyz6dqnPNeNyM75gpT0mnET/Tg/4dmPWnjJJ
 hLXUpXgP13xqWDG4Qh32T4sSptSRPIqNKVItMyuNL+5UsW9vaGdYgTDZGc4Ae3I6i6Hq08
 2MKcfUFkYNoGUeNjVqZZUu0J9MlVX2k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578--g9t-5uUPuqW13RwJ3JOQQ-1; Fri, 24 Oct 2025 03:19:21 -0400
X-MC-Unique: -g9t-5uUPuqW13RwJ3JOQQ-1
X-Mimecast-MFC-AGG-ID: -g9t-5uUPuqW13RwJ3JOQQ_1761290360
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e4cb3e4deso9314935e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761290360; x=1761895160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h1qxonL+L9MKDWYeJ+RXK2VRKKtWw9z7Gm3e6WthLSM=;
 b=oyq8NlLlMdc/48JR77JNxIjUsaJaMSUnVHtswL6rjJW+0pGudZ+iUJRJRGU8sXXB5K
 LkUt8tZSuAfiGJUnUU90lrGqlQgAkMfHb9C4ObpeQTVNyKXCRbs9vc7bHWiwcoMfiWvC
 WGSoIg5J7hU0x5n/Sl3PMMrJO9YlQhyyswmlDJ224A9VGNe7JEofRoi0/FicKQrOpS/8
 PnaQSOnuLlph/S+Ph7a6ddUVjEr7lImZm7LLeILPqQxvQvqv8RjMILAPqJnoOBWMa1/U
 x5ToN4xdpyhzkyVoDLYB5YyBpDbCmgC/Fqvv7wvO5kb76YJIiFm1Fo/O61XlWh5Bvsmr
 7Spw==
X-Gm-Message-State: AOJu0YwTuoKUuOQHPPb1e0iqa8/vKptb+LGrPohy5ueIOYneS48cLdNF
 545/MNFkgJD165i8bs6oxk3F3KulSR64j4IjARQFHa3nGoEeZtFrRoJwtXuVS+fwCdUCvHtZ578
 v1i8HtFn1J+J5flRdGoZEj9q2fNAh7ID1qGZ4OWpvPMunXLx61MsIA5per/pwYjuaSQrtPyrpam
 8bGpq1zTPsmwQr/IirAqSdsHyDa+SlGd0/eIZ2hZZ0
X-Gm-Gg: ASbGncuFqaOB7qxH1SJv7giVTmdFp/oIKOlBKojfzTZRhcuo9lRn+u2BcocpV5BPWKq
 XwhFibXK/jT4J3aE/o0L/4ttgSdC+gzYGIR62WP+lDyABTvBe5GBS3qHM0gvOhgOG4U8QDVoT/A
 rMic4eP+mvCWii+3DXg6ssVYI03ygOD3KZwoHSeSd0KPS0BFmlgVtQ43ZnDzddrpKGJ1yFMS/Be
 /Obd8zPJQqi97+3+Vh5oRIxx9kl9Q7RyvWTzKTXUdl4jQdw1inTZsxzGs3Wd3Znly5JM9MHQpbv
 C2GVhsGbIxJlnNmIpkLlvwt2gwaqDgxhxpj95hYkeBTqFYz4N07IJ4ySZAmgeN/R4hDcA3+gm2Q
 DOy03T4NgWrGwBPXPA7XKstRzctpmVFKYkNSb5tFEDY/sb65cJHjO/HdXtjq6YxK2lEY1VFmNLZ
 HnVg==
X-Received: by 2002:a05:600c:358c:b0:45c:b6d3:a11d with SMTP id
 5b1f17b1804b1-475d2412c06mr13698655e9.1.1761290359768; 
 Fri, 24 Oct 2025 00:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU6SgB8mgRHZPY4uScTWgtxiZOZ1ymnXU2sKxfnnAByvjqYWH5rxe/6X6mTJ/aNZNx7+wnRA==
X-Received: by 2002:a05:600c:358c:b0:45c:b6d3:a11d with SMTP id
 5b1f17b1804b1-475d2412c06mr13698325e9.1.1761290359298; 
 Fri, 24 Oct 2025 00:19:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae9f8eesm76613085e9.6.2025.10.24.00.19.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 00:19:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: clear CPU_INTERRUPT_SIPI for all accelerators
Date: Fri, 24 Oct 2025 09:19:18 +0200
Message-ID: <20251024071918.228749-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Similar to what commit df32e5c5 did for TCG; fixes boot with multiple
processors on WHPX and probably more accelerators

Fixes: df32e5c568c ("i386/cpu: Prevent delivering SIPI during SMM in TCG mode", 2025-10-14)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3178
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86hvf.c    | 1 +
 target/i386/kvm/kvm.c       | 1 +
 target/i386/nvmm/nvmm-all.c | 1 +
 target/i386/whpx/whpx-all.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index a502437c303..3838c9f5a6f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -446,6 +446,7 @@ int hvf_process_events(CPUState *cs)
         cs->halted = 0;
     }
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_SIPI)) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 3095625b525..23a0329d7a5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5659,6 +5659,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         cs->halted = 0;
     }
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_SIPI)) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 2e442baf4b7..60c9b975562 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -709,6 +709,7 @@ nvmm_vcpu_loop(CPUState *cpu)
         cpu->halted = false;
     }
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         nvmm_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 256761834c9..1cb33001cc4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1621,6 +1621,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
-- 
2.51.0


