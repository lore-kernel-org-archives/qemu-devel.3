Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7724CCA5FE7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjkY-0007NO-R1; Fri, 02 Oct 2026 16:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkI-0007BI-I4
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:44 -0400
Received: from mail-pj2-x29.google.com ([2607:f8b0:4864:39::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkG-0005lS-W1
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:42 -0400
Received: by mail-pj2-x29.google.com with SMTP id
 d9443c01a7336-2e300fa474aso14575ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972439; x=1791577239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gzLwnH4jDzrX8kj8UPASW2z1d+DNR/ChcuS1IhF3HHk=;
 b=EesmtMA8Bi39Jn22GB15LJvQh7u3fbqNyTc8ncf0iifj6waM59s2iOv9fRsqFmkdee
 oZcPZYrLCH/CmYbRIlUeFW0HYmn/Sg6UAhEucNtklRdkYDYON/XWqTAe9CsJ2kVxboWK
 48Lqs5yU24n7HpNOEjJHmJX2OxXwvrEHP02b6beJE41DgCxbgZWwZdLb5dZPma11OwHe
 JblqD8ONuRapZT/t0WQwWl938WjWINyS7WJ64RE22EuqQuRAqPtcMHjRZULrFBkNlMDL
 at5NdXEVfRsx4gWWm1kkBa7Hv90Ei/UHFDVtc26j6RCdIOnUTnQdOvJoQGIlKmM/pNZ+
 Kx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972439; x=1791577239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gzLwnH4jDzrX8kj8UPASW2z1d+DNR/ChcuS1IhF3HHk=;
 b=h6NbnrxbgWwhJS60uLVPdoZszGf+t1j5B1yZqRvdWeaOSpb3H9gClYo4u1fhiSRjq/
 ucm21G6minEWmHYcgcppiQOIIx6I+ziDBj3efDAFbrD26dltG5S+MoB9AcmAetkSEl1k
 EfXOmpwSAR+as8cRoop8iYxSDDjIoXg280xHMnFIDUayblE1MSnHMtOl1lRB9LdKcu+T
 D7R+o4L0q0cKvDnP8X16SbE2AHDTjY4BdIM8SssJ1FBWNevryMbv460NURVyiS3KXbqU
 wSPDBjtbM1bhz10YcOgPcScTMXBqkvRXuX0gNOgNrc9NDTDZ8EzslBHbsTebvvKBqV7z
 OR5A==
X-Gm-Message-State: AFq9FYJIuqiZyIi5il45FNtmMCDCFtYYaKyUl+JxDLwlCr2cQ2RLsBtu
 VWKOuuCzFlGrHz5r7cqCikmZho9iBcq/pt/pVWrSa6pkXYzngWI71DZU2llSmDLCrh8=
X-Gm-Gg: AYBFou1EMzK0llYtZFcMzY5oUhWKYxg1TjRBu5SnVO9kN80CJFAo3O80o7rofP76F/K
 bK2r43dAFQD5xambM4c0d3ZL7GHJSa/q/3PqH3755CEwq9zNN592G8iV/NwykDWg4k0gyToXxqV
 i9T5q612aCPEiT2sHFSd/EIRnhgMym0D55BHtMcupP7o65oTYw1euxInXaFLXMvnHMzpQI02jFH
 kZ8oxA4PGqFjT6IVvR+rMRu4dzgamXKZTi0v0BUC4Iaj2S/H9LEhGvzmN3/TScn6m0OYrWbQM0e
 8RpQhpKhpZRgjyBf83ZUD12FettgDsXEM0Spr98PjCmjnAN2gqtniVz70tst7Vcb1Va1k2xq9Wn
 bKPkAh1Pd3bU3q+7hDjljGv7cR8SIa3inLfoVcbJawcpKxH2y0k285/VpvPfuQO0AT+qIjuvi3x
 FT0PEYvM9eTEg5uFs5uaw1PgePzxN8ZgyaeoK+LYP808zMw3ac/CVuiHE2b2D/H6CG5LStIys/D
 +gHcP5zsU2P5oaIdkWqJVh2
X-Received: by 2002:a17:902:ec92:b0:2dd:c100:a5e1 with SMTP id
 d9443c01a7336-2e49b684416mr31187295ad.53.1790972439265; 
 Fri, 02 Oct 2026 13:20:39 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:38 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 06/22] target/arm/kvm: Create scratch Realm VM when requested
Date: Fri,  2 Oct 2026 14:20:10 -0600
Message-ID: <20261002202026.1204110-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::29;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When a Realm is requested, create a scratch Realm VM by setting bit 30
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index cfee9fe99f79..8c74785998c2 100644
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


