Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A0BC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27H7-0000uR-T0; Thu, 03 Sep 2026 09:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x27H6-0000te-Dw
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x27H4-00009S-1K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788441276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjVz/M7CD3zMOrpn7gjcjXI+47FyiYiVKWm0/7Y4JTA=;
 b=MbtDQh/s15CbH69FsHJbtOPDnsh1i4W4rL+CtyVyolrwkC6Sv97Un/zMNsUT+50DN6R9wR
 mJBLtt47g0dW+dizF03kPAWtjy+QihJyeHDqFlxoB51HiJviEWMUC4gZEUY6xRABzkf925
 uAa5ISpDmhmfTA9k8g5qZKi0ghcdNS4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-58c57CUMNVidAnFI506lUQ-1; Thu, 03 Sep 2026 09:14:35 -0400
X-MC-Unique: 58c57CUMNVidAnFI506lUQ-1
X-Mimecast-MFC-AGG-ID: 58c57CUMNVidAnFI506lUQ_1788441274
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49b64e98e94so8190445e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788441274; x=1789046074; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mjVz/M7CD3zMOrpn7gjcjXI+47FyiYiVKWm0/7Y4JTA=;
 b=rR9oBOVTjY+wEJRKrCzkWBbn6UGOoTFDCpnv9kQDOEwxBZvU9WcuarJZtWyFlnWZht
 VnYuREj8Xg2gIMgyfRGAtTSCjBELWJrcfwNvCxVoRh6UFud7w/kKf+hy/v+NHxJs19YP
 lsbObqjwl1YOm9wNZH6SsvUVgIcudv/1wbH6dL5+nuKkL5tbAM5Da01E8aCmeiOlnDJ9
 nw+RoTZts+kgH3+5WY3qY8hrLeYafTtdqqzzXxxVMl1otVQz1Z3iEAVvF+WVCBR02Xj2
 pt3jbWiOYwJ7eFMDd3AYrwcBQ3a2ZiJj/jEa7PsGrCcuCGX4y0EZ4JEgbW+eWUerq1/Z
 Vvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441274; x=1789046074;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mjVz/M7CD3zMOrpn7gjcjXI+47FyiYiVKWm0/7Y4JTA=;
 b=Gp+A/QbLQF3fNrzN7TPlPHVnkT6J1iMLPK1ucVLMJO7Gel3vv54KJGpHlZ0Eou1sdC
 u6htKXVIAXyMS9ujPA8VXCXOs73wXDGjBSbPMwf6S/IQItt1q4hCgP+qfHYKfifbwFPp
 Dk6ii3YN4jU6KS4+wZZWHz3zmg1lPji0WH7jIXV8ug57fuxdHvoI0kvscddxyov5GdQs
 s0inQel82SmX3/ee+a2PB+B+8EmWeFwHFaNvdKD4NBjzHYOH3lGbpgTJmlyP0lZRuWv/
 sW8eaAq1Ndh6N3rbdwbe9rOB5mmuU3vqyvRZSy/u6jt8OfAMKYMw3CDfWzYkJyhV61ln
 EXww==
X-Gm-Message-State: AFuF++m/ufRb/c34j68GRdp/J1pQxydrmGR6Dez9qgQgFJSGzRrd/KdJ
 GGkw4L648ldztoefcPtRmi9T5pc/g8vkf0/9V4pj9ffru051yHSMPLtFUWeJQPaTIy8L1ZU6fGy
 MWpMyhs97MVMM2A/WEiJqeRqnalH7DBeizEjksPgOVZ8WwBIjPPBc8UOA
X-Gm-Gg: AYBFou0/lDZUvbymrLzGLA3J8OmC9VUjC0x8fu5TUVHhZq6VALlX+JfksjNQwGZaWex
 6n3RDIgPXFb0bQqwkqB31Ic3/WY3Gjt1ZQW2WQ2Dna5giMAPY+WJs1BqOOq/YdHGtUmD5gjY/kG
 RcSUw6l3nmPNEGcclFqg6Pe21PBp+7nJ12HPjab7F8hHv1H8cYetTA5uzs068JAfe2x4YBrB7y6
 1OU5aQFxcNbUVuH6gSqM8G6s9hIML2I/M/v3iBZ2JQXTuG6RLqIBxfN8n+aca7jB2m7Wq5sl3xq
 /cDtlS0L/kp6iwzVbNusAK9m5r3gkLq4CqqF5wl5lLUV6kcIzSQ35vdCGUWuCTUG6WiYJ/EOoEg
 VmRCHVPerjjwewRUWdezjHDb94svV/bmcFr6zNJW+z9cIuQ==
X-Received: by 2002:a05:600c:8708:b0:49b:4eb6:6ffd with SMTP id
 5b1f17b1804b1-49cf1586a97mr17565275e9.5.1788441274056; 
 Thu, 03 Sep 2026 06:14:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8708:b0:49b:4eb6:6ffd with SMTP id
 5b1f17b1804b1-49cf1586a97mr17564685e9.5.1788441273448; 
 Thu, 03 Sep 2026 06:14:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee3b0af8sm72500045e9.0.2026.09.03.06.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:14:32 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:14:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <aplvlx7ciHV6Y-nz@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 01, 2026 at 12:09:21PM +0200, Luigi Leonardi wrote:
>The guest policy carried in the IGVM guest-policy initialization header
>was parsed into QIgvm but never forwarded to the confidential guest
>platform: the previous callback ran at the end of qigvm_process_file,
>after LAUNCH_START had already been issued, so writing the policy had
>no effect.
>
>Add a set_guest_policy callback and invoke it from the guest-policy
>initialization handler, so the policy reaches the platform before
>LAUNCH_START.
>
>The guest policy can also be set on the command line. As it is part of
>the attestation report, silently overriding it would cause attestation
>to fail, so return an error if the command-line value differs from the
>one supplied by the IGVM file.
>
>Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
>Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/confidential-guest-support.c |  9 ++++++++
> backends/igvm.c                       |  4 ++++
> target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
> 3 files changed, 52 insertions(+)
>
>diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
>index a0b36d2da5..c0d15b4a76 100644
>--- a/backends/confidential-guest-support.c
>+++ b/backends/confidential-guest-support.c
>@@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>     return -1;
> }
>
>+static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
>+                            uint64_t policy, Error **errp)
>+{
>+    error_setg(errp,
>+               "Setting guest policy is not supported for this platform");
>+    return -1;
>+}
>+
> static int set_id_block(void *id_block, uint32_t id_block_size,
>                         void *id_auth, uint32_t id_auth_size,
>                         Error **errp)
>@@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
>     ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
>     cgsc->check_support = check_support;
>     cgsc->set_guest_state = set_guest_state;
>+    cgsc->set_guest_policy = set_guest_policy;
>     cgsc->set_id_block = set_id_block;
>     cgsc->get_mem_map_entry = get_mem_map_entry;
> }
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 6545382546..5131ee7829 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>
>     if (guest->compatibility_mask & ctx->compatibility_mask) {
>         ctx->sev_policy = guest->policy;
>+        if (ctx->cgsc) {
>+            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
>+                                               guest->policy, errp);
>+        }
>     }
>     return 0;
> }
>diff --git a/target/i386/sev.c b/target/i386/sev.c
>index c76cdba8d2..533ea4b54e 100644
>--- a/target/i386/sev.c
>+++ b/target/i386/sev.c
>@@ -128,6 +128,8 @@ struct SevCommonState {
>     bool kernel_hashes;
>     uint64_t sev_features;
>     uint64_t supported_sev_features;
>+    /* whether the guest policy was explicitly set on the command line */
>+    bool policy_set;
>
>     /* runtime state */
>     uint8_t api_major;
>@@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
>     return 0;
> }
>
>+static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>+                                uint64_t policy, Error **errp)
>+{
>+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>+
>+    if (policy_type != GUEST_POLICY_SEV) {
>+        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
>+                   policy_type);
>+        return -1;
>+    }
>+
>+    if (sev_snp_enabled()) {
>+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
>+
>+        if (sev_common->policy_set &&
>+            sev_snp_guest->kvm_start_conf.policy != policy) {
>+            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
>+            return -1;
>+        }
>+
>+        sev_snp_guest->kvm_start_conf.policy = policy;
>+    } else {
>+        SevGuestState *sev_guest = SEV_GUEST(sev_common);
>+
>+        if (sev_common->policy_set && sev_guest->policy != policy) {
>+            error_setg(errp, "SEV: policy mismatch between IGVM and CLI");
>+            return -1;
>+        }
>+
>+        sev_guest->policy = policy;

`sev_guest->policy` is u32, should we add a check before this 
assignment?

Stefano

>+    }
>+    return 0;
>+}
>+
> static int cgs_set_id_block(void *id_block, uint32_t id_block_size,
>                             void *id_auth, uint32_t id_auth_size,
>                             Error **errp)
>@@ -2848,6 +2884,7 @@ sev_common_instance_init(Object *obj)
>     cgs->check_support = cgs_check_support;
>     cgs->set_guest_state = cgs_set_guest_state;
>     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
>+    cgs->set_guest_policy = cgs_set_guest_policy;
>     cgs->set_id_block = cgs_set_id_block;
>     cgs->can_rebuild_guest_state = true;
>
>@@ -2970,6 +3007,7 @@ sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
>     if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
>         return;
>     }
>+    SEV_COMMON(obj)->policy_set = true;
> }
>
> static void
>@@ -3027,6 +3065,7 @@ sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
>                            errp)) {
>         return;
>     }
>+    SEV_COMMON(obj)->policy_set = true;
> }
>
> static char *
>
>-- 
>2.55.0
>


