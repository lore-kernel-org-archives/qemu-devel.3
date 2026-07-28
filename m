Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE6CC54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS1-000376-6w; Tue, 28 Jul 2026 15:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS0-00035I-1F
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRy-0001QT-E6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:51 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c9e0b89e228so65862a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266808; x=1785871608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BW+koEYMGeh3Q0Il0QE3jfPQEhQaRsizJA+FKY6y1jw=;
 b=Xwy8w1sCVSmelc2f89Sv6ZKM2f3hllhCL+BjDg/gvkJLYbIeoWBGVPY8Hr/yZYfRMD
 hJyZguhPwCkP1mA+BdlBgy1GVcl3zn5O9ebBCbLs8/QqywpCr14843XVgCgl2Ed67j7r
 b+jnnFWGANziRk5RbigoCTECX+lYiex1eHteTBErPhbMop0kSoUSIzDzvAVdiEaWoS8E
 Ji7SNGVR9dTEO3dXSZWjiytGBAVA7XVE/JSZMatYMtdNAuHjhXVZkHZjFRAaGTV5C/jE
 0Teblr5mMXfLXLfihiLnnnmnoFs74TwtH5c1WSu3XaAN3/ObocHYdY6DBXYGZbRVu2SA
 uS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266808; x=1785871608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BW+koEYMGeh3Q0Il0QE3jfPQEhQaRsizJA+FKY6y1jw=;
 b=Nr4ZXoOPgQhv8FoSilMP7VKIaWOZhkywIWuML2Rfns1BRYe/gVtEbKh6MzbGn/XrOK
 A3T1HM9AFLvkGv+UbM8Z4LoRSj1DNsXKCUzMQTB31IPnOvowv2bueHV/UtHCGJ8YW0SI
 gyvPuMFmqx5tt+gPlRfjgcZ4KFNV6NWosadr9HvVMOZtxXYVvyehxpBXTQgp51BNRqZJ
 qHUj6S1MdH8/2Ixfl0FpXIGjf+RweaoaiRkPml2ZuoNhXZXcyZN4gGzTsj/KsurgQvck
 Qm+e7Re9zXDx6kvg531HwOnDm48HSVHoU2kKLWnIRpsdduFxPDg+l5OP3UGDcVG+pVj3
 n9sA==
X-Gm-Message-State: AOJu0Yyo3KGHzaezEWmq1r39sjfzWAvJekjHYtvPVCWjOLQW9FjyYpPa
 KR9c2Dybb3NOIjbTZ4fx9VYtLPZiImIgXJ57YHNEGa1T84wrujj9y/LUTDAwW+Amfbk=
X-Gm-Gg: AR+sD11Jif93M0SL4/J20rXF+6LaC/oPrnUeXIjhccNCqZw3VdLajoe7RLGNrlhWlHU
 Yp/t7yztB88JzfGvLQorOU06G7URdcQdQ7pWfprhwgond7nNGXsydygg4fvrTokiA4RBKg65ujR
 xf0HNxDo16OYwIttWBRCm9Y/vmjrLpATs+f0sTcwh0gKScvgVxhfBc9loc9tWh4E1vOiKqtzHdJ
 HnvNcC/huhQZ5Zpet43fFSg7S2NZJSc5B8j2Agho0l+gIZB3cfx60L2+3GxoSvV9vHueRW53SSu
 jayFuMfF9fyCuHqf5wLJKb5PvbOb6UKOdqSMtTZIWF0fzaPAepL/LaIZQPNB+WMGOB1k4LrNvxN
 eIbtlfwNvDN1HxXgerjqv5o+AJUTW6FLGhCkSXDmc9Yn7Ze9nB5xRN925z5MQ2R5iM/xJmT5zgg
 +Fd9ta2xPCsVwEi3IrOofzBppsc4teIYKnhM3sALYMZ8ynM0yEJ/7/5g6PUfgNjo0sHmfDzMFQb
 UfjUIuO1DjeNs0=
X-Received: by 2002:a17:90b:180c:b0:38e:5741:5173 with SMTP id
 98e67ed59e1d1-38f6a4205e1mr3934859a91.29.1785266808420; 
 Tue, 28 Jul 2026 12:26:48 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:47 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 07/24] target/arm/kvm: Create scratch Realm VM when requested
Date: Tue, 28 Jul 2026 13:26:13 -0600
Message-ID: <20260728192630.240375-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pg1-x52f.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a Realm is requested, create a scratch Realm VM by setting bit 8
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c6da1fb9f3..d86e66e056b9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
+    MachineState *ms = MACHINE(qdev_get_machine());
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
-- 
2.43.0


