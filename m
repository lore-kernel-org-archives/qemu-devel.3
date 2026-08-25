Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030B4C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzDL-000473-RR; Tue, 25 Aug 2026 18:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCs-0003Jq-RB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:23 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCr-0001RY-Cj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:22 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3964dfb5b9aso483327a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695280; x=1788300080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eyJsbM3B9U91rhA9XcMnnj9HbTzV3f8teoGWTnmCdi0=;
 b=ZbKQomfQyjWWZwX0zenDsYgW/khA2tAfJOYEcTZX0SmSXBkVy/gxtXIJU1/klYBa3h
 Jo0xKoWJ8pNjDgPePf+u9Uk6bC3gqKBQYh3Pwrnv4n/oDzH5SUIz/qafeYD1UBH8YQ+d
 kRWWVAnUo0BsJ19MsMQh7Ei0LKA8QDIMYiOJ5OviyHrU18AzshqG8rokzC8lYvaTAM9S
 3ED5ui3kK3i49iaisVw7TnTBSdrOouP3paL2kavnAHieLagO746+VkFoLIqyQuxc7Sk7
 htcPmnWIRfo2QuIxPJXfq65txrszXiBB34kroN91sXZA85S2zirv+8qbSzt8XTOPZ5G2
 SEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695280; x=1788300080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eyJsbM3B9U91rhA9XcMnnj9HbTzV3f8teoGWTnmCdi0=;
 b=lh/hpipRSi3bwKetjzXluUc01M2Vl/yJgqsIUHubKyCYxGj/+KUMvlZ/WR1JWriJTT
 2Dn3UKXxSICV+y079BBdQ09v9Db9llDrj+Bfxu4NarOLaieuS1Y8/MmenWYxHpbKfTZB
 wSmbqZ2wADlp6sEQWQd+rcAk4aIQgAvAnxqWfKBlLYIPIqrB2PEn5KCROJOIg1/3nGAz
 pGC0xu5jrk55ca1EkJAOMzmjGRiZSJxqwBKm8wDw5njxbG6CIe8nqA2kyEm8qc94kalF
 H00XSbZhYtzkEAGzgknxzUiFXYB/guTvpwo+vZYC4MP0KnLZSJ/aixoiaixVaPj8RQk9
 HVAw==
X-Gm-Message-State: AFuF++kOFFjeUOq5iyMOg9fEliwe35llm3LevBVX0g2rOFRnMfCMYHRw
 eoMPhILtpztNjoiZQpA8TAKI1h59C0bVlOUaOCS+2BKp9zHrCFryxOnsAcPeWc0tEqk=
X-Gm-Gg: AR+sD13BwXIxgi+5s6jyMOG8yaLctmyB057gAMeCSVvM+cWDr7FJ7i/qMfnbiSngJ0i
 gjRgjtZj9YLawuYQ55sj3ktqCdEaeeV5lOhDmFm9Np650HtVnMBcwQoc8pQ6n0J6IQn4u65z/vm
 bU7a3lIkVmgSjNh/n1Xy6rd0bpREO6ewTN5ZF+BVcM42iSzTQEStUbOuIhy45Xk3wk/+okk+Xrh
 WI8Bn1cItyCfq7pYA0ZkunTUj5HH4i33qPt9MqJ1CSGTRSVOQBWuTEvh2fiISVw+S3O/IjTUPrQ
 R2GQuhtluJRlWVJMUfJKqxFlgctAsmdxEdPTAvGCth1FI2NH1gsyG0mdFFiJiKbEhDNi1PNZT+P
 VbQDAtRek/WWjUX6tJukRXQdcnMYMQLi9/URWyg5VUHHdhAoGS5Scc4m3CAbJCkG5ZVl559L8ZP
 C0OUTyFx7aIyobFXfm8vu82estq3dblAOTDfjz3SwSUGuN
X-Received: by 2002:a17:90b:390a:b0:396:5785:843 with SMTP id
 98e67ed59e1d1-3966d203a94mr3597179a91.8.1787695279952; 
 Tue, 25 Aug 2026 15:01:19 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:18 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 07/24] target/arm/kvm: Create scratch Realm VM when requested
Date: Tue, 25 Aug 2026 16:00:44 -0600
Message-ID: <20260825220101.3443954-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1031.google.com
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
index ff179a66b821..1acbd885bf4e 100644
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


