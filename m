Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B77C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqfP-0001kM-Bp; Fri, 19 Apr 2024 12:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqee-0001Be-H1
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-00016x-W9
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-417f5268b12so23476665e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542393; x=1714147193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSfgbPCTP9EyXuV3juP9dkL7EJuQyUK18eBXqNLqpbo=;
 b=SQkKAnNo6T7f4A8fdejdCV0cnzTGOc55u0SIOm2zprUiRGqXkBoA+AxUpKBWorEOtp
 DienCbhrcU4IG1uuHaOGqNbt/NgByoRUPPbinsDm/MLCnHJFudci71GvCXFylqzMkMNi
 yStkjLgDJNTmxO7i9/xz3CUlf4d2oVLKa6wxcWG5CsgQRehT+zkhG6RnkgbomwyaHAU+
 M+C8iSGKDQoavfF+OY/v66iMdJ0jTN2QVjlCKTu2UXaRnku/3tgam+EZRqkPid4IxJZH
 b48odklLFQHXoXGRawRcQEM1hNaUbuYJX0yEMKWjPbjxVtkPO76LKW1xBIiJGaLONvvO
 aIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542393; x=1714147193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSfgbPCTP9EyXuV3juP9dkL7EJuQyUK18eBXqNLqpbo=;
 b=YAYc2Qh6of15KXq8h7PaDJqs06kC2L/tO7g+A7goG5fCggxKawf4eArFrKvoxAPy+t
 JmPiwgLRODohqECYQqCRY/DyTMcu5MUHR0PUty5+0rK26UFoYFmZCd48HcJbogDssj2i
 cERf7hUH1hMFsHXT+VgGkedN2Y0eqVqzKys/lxXKu5F5yapTevn5+G4BU7ZEqirFoVZ/
 LFSgEraaU/Nf/aEmmeNNYs2Dnb+0I1ksP6pCwIPsBxTEqzOJll0Vc/sK32lCuJhnOKd1
 GmfHLgZBLxa06OkRziaa2bPmgLreI1Y/3xw3hMjDOelIIrlgjoC44pTGTbHwYkmuyRDR
 aoyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVL3lMB6lMnw0q/RFXYPKKEvR7xCz/HeIfi+PNgt9VUXpEjrfthPZHZas7TC7HjOc413AG8G2V4dJB9Og3dCus+unG6J8=
X-Gm-Message-State: AOJu0Yylcvnz3P2cqodPZiLzrWddSrdFaJJJLGszGinH8vL7ovFk5nka
 9Xm+9jgJS9Ptz7uF30FIgmjXe3+x3FYLJKe5CUSSbOYvVThgWhBwIXUtG2e8R+M=
X-Google-Smtp-Source: AGHT+IFeP2EmhMFD2HOBJ3b6ZBLM6/A+kopBfhoJ2HRfD/44Kv6a5uuKskDScPr0n9uZ7+UX02om3w==
X-Received: by 2002:a05:6000:10c:b0:34a:4b5b:a3d with SMTP id
 o12-20020a056000010c00b0034a4b5b0a3dmr2104134wrx.7.1713542393565; 
 Fri, 19 Apr 2024 08:59:53 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:53 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 10/22] target/arm/kvm: Create scratch VM as Realm if
 necessary
Date: Fri, 19 Apr 2024 16:56:58 +0100
Message-ID: <20240419155709.318866-12-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x335.google.com
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

Some ID registers have a different value for a Realm VM, for example
ID_AA64DFR0_EL1 contains the number of breakpoints/watchpoints
implemented by RMM instead of the hardware.

Even though RMM is in charge of setting up most Realm registers, KVM
still provides GET_ONE_REG interface on a Realm VM to probe the VM's
capabilities.

KVM only reports the maximum IPA it supports, but RMM may support
smaller sizes. If the VM creation fails with the value returned by KVM,
then retry with the smaller working address. This needs a better
solution.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 target/arm/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3a2233ec73..6d368bf442 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -104,6 +104,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -113,8 +114,9 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+    vm_type = kvm_arm_rme_vm_type(MACHINE(qdev_get_machine()));
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
-- 
2.44.0


