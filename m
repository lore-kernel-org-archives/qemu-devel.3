Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40567C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LQz-0002VW-Uz; Tue, 01 Sep 2026 06:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LQx-0002UY-Hr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LQv-0000vs-CV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788257376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1q8tTUm5QcHyiu9DXLZbI88hsaICvNBYvi0zuGJw3GM=;
 b=LY9heBj/bAPfvvozIOYG0u4gZEnF0X39/fa6r1Ss/+8B8kNhE75iSm4kyDX+l4W90yQwZq
 pT7A3njjjN8HFC9AsKr4RZUY3+co+CRFv/6Y5qpR8xPLEt/KDToMgO7pDgNQ5d/WFygxo1
 uAozYAL/yICBvT1qVGwowiWM3Qlo/Ik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-GAilDrsMOvG3YfmX6Vp1pA-1; Tue, 01 Sept 2026 06:09:35 -0400
X-MC-Unique: GAilDrsMOvG3YfmX6Vp1pA-1
X-Mimecast-MFC-AGG-ID: GAilDrsMOvG3YfmX6Vp1pA_1788257374
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482e575596aso2033151f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788257374; x=1788862174; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1q8tTUm5QcHyiu9DXLZbI88hsaICvNBYvi0zuGJw3GM=;
 b=Am34jGkwlds3RiHu2yYRHCoCijtpdf9gniq3Pq1RIkT0DkTi5EVWEQIcH0PdUpX0uX
 SvnzmB7NCuBnb4OOxCKfLTjzgOVv4EUSVAiYa5+e06dFYkJKEZG88uT+OF52ji+WceVK
 ennUaSf0TukB3kSJkQTAO4OHmj8DMrZWl8kqMHgpunNlUkHCUG1kol3YF0gkfPRiFZSH
 R2ljbbmolmuiRU4xaQEhd1tyXE1pvwRXO57+HBhz+Vig7orsk+sgELtVjSvj/geg430N
 pOC3gW1s6nQjY6c8SNJn6rSKchxsSh3G8t2vnor7SdT/MDVmwrrhMpM27xATMdiyncM/
 cipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257374; x=1788862174;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1q8tTUm5QcHyiu9DXLZbI88hsaICvNBYvi0zuGJw3GM=;
 b=Zz6ffDpBzRcU0Ap2h9QusQq7H/IVdzaYIFtN+ttilQOt8wjajVSo8CFWW9ZkW+f31Y
 KTzhmzrGds5zTH923vFPHtP1DGX9MxizUbAjkOOgmaBoKNLvzPV/EyyaCYTboExS/KfX
 fQ9m+jlpPu5Zetk7g/i6iZsgIV9I22MOm5bNxLDTzMcQuyf9YEKQhHKeefosOPnJj+zW
 vCfZWJgYkS1EkhG1LfaP8pbTcp1Ydy8OXmywJ7yhflRNXBP7vFFdG8JQWQ1NuXGzWd/7
 d7FETh6pqcTaP2CpfSBIWgQAIKC2GJP0AjaL1M6Gjq52XBlEF3z7o/sByp/ewdfoLTVh
 sXcw==
X-Gm-Message-State: AFuF++nrBZWDQ07y4jMjmVmzzYeqRz2UcgryuMvT4ohLLL2KVKlfkbUz
 +sr3L0IoWn72hxQ4YUNf9KkxhFLEPmSv6cp+JX2wbWPW0n/BbakmNZ7899iXSpmHD2DYRNi2Wlz
 igRzw/Miv4LB0Nrclhh7aPUlWKDchouu9IWS/dj0O3PFxP7LsKdEcytRw
X-Gm-Gg: AYBFou0roQ8aJIdZsjUdP4gbX4c5buw5r6zIuCuDAPO46J16KrH/IDsKhYY4DXkens5
 AKIB8HeD+CE+sNleud5JQ+fDKz+wqUpGrpdO3AFnQvKxCiiCkmTYlx6U/DKwSAOJuwZ+qkYPVwb
 nL0oBp4f1CD7vItHETSzcxdV/JU7vdyuwT8HEW6G9OYQlGNMfMkB8g2Iqx054/oEj+HSdRjze3N
 jJCDD4n3WS9OMfNYctwcn33otybrg5H/9k0+SnJ4Hgo8okJo8krfSfzwr9YQAaCQ1auNnm6cZ/M
 Nqrsiik3on5HT+hk6CT139RR7/3XNCJoSryIzbPNmKd/vjv5zKxCG/hi6KqTa1shUFaPYjYjTu9
 DTXxF2FQ8fXgceFotbGjrpyCis9ZHiBWnh46uBTZ2DCTFNIftb8ZcopEK86AMj8Lr458T
X-Received: by 2002:a05:6000:991:b0:484:3311:3703 with SMTP id
 ffacd0b85a97d-484331138a0mr42340510f8f.26.1788257374236; 
 Tue, 01 Sep 2026 03:09:34 -0700 (PDT)
X-Received: by 2002:a05:6000:991:b0:484:3311:3703 with SMTP id
 ffacd0b85a97d-484331138a0mr42340369f8f.26.1788257373745; 
 Tue, 01 Sep 2026 03:09:33 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:09:33 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 01 Sep 2026 12:09:21 +0200
Subject: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The guest policy carried in the IGVM guest-policy initialization header
was parsed into QIgvm but never forwarded to the confidential guest
platform: the previous callback ran at the end of qigvm_process_file,
after LAUNCH_START had already been issued, so writing the policy had
no effect.

Add a set_guest_policy callback and invoke it from the guest-policy
initialization handler, so the policy reaches the platform before
LAUNCH_START.

The guest policy can also be set on the command line. As it is part of
the attestation report, silently overriding it would cause attestation
to fail, so return an error if the command-line value differs from the
one supplied by the IGVM file.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/confidential-guest-support.c |  9 ++++++++
 backends/igvm.c                       |  4 ++++
 target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index a0b36d2da5..c0d15b4a76 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
     return -1;
 }
 
+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                            uint64_t policy, Error **errp)
+{
+    error_setg(errp,
+               "Setting guest policy is not supported for this platform");
+    return -1;
+}
+
 static int set_id_block(void *id_block, uint32_t id_block_size,
                         void *id_auth, uint32_t id_auth_size,
                         Error **errp)
@@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     cgsc->check_support = check_support;
     cgsc->set_guest_state = set_guest_state;
+    cgsc->set_guest_policy = set_guest_policy;
     cgsc->set_id_block = set_id_block;
     cgsc->get_mem_map_entry = get_mem_map_entry;
 }
diff --git a/backends/igvm.c b/backends/igvm.c
index 6545382546..5131ee7829 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
 
     if (guest->compatibility_mask & ctx->compatibility_mask) {
         ctx->sev_policy = guest->policy;
+        if (ctx->cgsc) {
+            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
+                                               guest->policy, errp);
+        }
     }
     return 0;
 }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index c76cdba8d2..533ea4b54e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -128,6 +128,8 @@ struct SevCommonState {
     bool kernel_hashes;
     uint64_t sev_features;
     uint64_t supported_sev_features;
+    /* whether the guest policy was explicitly set on the command line */
+    bool policy_set;
 
     /* runtime state */
     uint8_t api_major;
@@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
     return 0;
 }
 
+static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
+                                uint64_t policy, Error **errp)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    if (policy_type != GUEST_POLICY_SEV) {
+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
+                   policy_type);
+        return -1;
+    }
+
+    if (sev_snp_enabled()) {
+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+
+        if (sev_common->policy_set &&
+            sev_snp_guest->kvm_start_conf.policy != policy) {
+            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
+            return -1;
+        }
+
+        sev_snp_guest->kvm_start_conf.policy = policy;
+    } else {
+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
+
+        if (sev_common->policy_set && sev_guest->policy != policy) {
+            error_setg(errp, "SEV: policy mismatch between IGVM and CLI");
+            return -1;
+        }
+
+        sev_guest->policy = policy;
+    }
+    return 0;
+}
+
 static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
                             void *id_auth, uint32_t id_auth_size,
                             Error **errp)
@@ -2848,6 +2884,7 @@ sev_common_instance_init(Object *obj)
     cgs->check_support = cgs_check_support;
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
+    cgs->set_guest_policy = cgs_set_guest_policy;
     cgs->set_id_block = cgs_set_id_block;
     cgs->can_rebuild_guest_state = true;
 
@@ -2970,6 +3007,7 @@ sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
     if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
         return;
     }
+    SEV_COMMON(obj)->policy_set = true;
 }
 
 static void
@@ -3027,6 +3065,7 @@ sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
                            errp)) {
         return;
     }
+    SEV_COMMON(obj)->policy_set = true;
 }
 
 static char *

-- 
2.55.0


