Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA84C49EA1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 03:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scGg0-0000bk-OY; Thu, 08 Aug 2024 23:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scGfz-0000Yn-68
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scGfx-0008PC-Q5
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723175544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ux3Fv2w8xPQnIKMOjm6SpLkBTCoGuFWECJ1dsi/Iw1s=;
 b=LKSbtKRVZB/rTWhtf6Bx4rh8Fa+IndSW+EHGkUWMdoDJnr/uJJEnR22LCZY8NRhk1D/KmO
 mIOSxtcQByYMMEyoxI5uwC8h/w3r5Dne4FYNPHi/xHTZ/k8CdWB2nb0FOEuCBgqq/sfAC8
 d7HcVBErNh7la16SNAL1WIzruK/QidU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-fV_d2UyOPeu5mu4PNYTdAg-1; Thu,
 08 Aug 2024 23:52:19 -0400
X-MC-Unique: fV_d2UyOPeu5mu4PNYTdAg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4C4519541AA; Fri,  9 Aug 2024 03:52:17 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.133])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2C7E195917D; Fri,  9 Aug 2024 03:52:13 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
Subject: [PATCH 4/4] target/arm/kvm: Remove kvm_arm_get_max_vm_ipa_size()
Date: Fri,  9 Aug 2024 13:51:33 +1000
Message-ID: <20240809035134.699830-5-gshan@redhat.com>
In-Reply-To: <20240809035134.699830-1-gshan@redhat.com>
References: <20240809035134.699830-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Remove kvm_arm_get_max_vm_ipa_size() after its logics are moved
to its only caller kvm_arch_get_default_type().

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/kvm.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 65893c9c12..5d9e66d82d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -526,22 +526,13 @@ bool kvm_arm_pmu_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
 }
 
-static int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
+int kvm_arch_get_default_type(MachineState *ms)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
     int ret;
 
     ret = kvm_check_extension(s, KVM_CAP_ARM_VM_IPA_SIZE);
-    *fixed_ipa = ret <= 0;
-
-    return ret > 0 ? ret : 40;
-}
-
-int kvm_arch_get_default_type(MachineState *ms)
-{
-    bool fixed_ipa;
-    int size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
-    return fixed_ipa ? 0 : size;
+    return (ret <= 0) ? 0 : ret;
 }
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
-- 
2.45.2


