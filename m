Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5253DCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0R-0002UG-HA; Wed, 30 Sep 2026 11:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0H-0002Sw-6p
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0F-0000gS-Jr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EoRCo81I/eGkPgW+8ugkZwxe3C1k/nICl5X7HO6q8Fw=;
 b=iG5Banwo4NRIhqwDJAsCqf3QMTgaUB5UEsnkLArAbTbb2PTFW80e0VSQy/l6UCMdfQqkL6
 89Qg7KWZsvLcNw3g582/GMZl3+VTGT4aJ1dpQzhP4fxzQOTjM6LSGfS2YbPBVYoUlA99F/
 1SDWnijdT41P7a5V+hZIkLKYHJQgIMs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-r_YTaUwvNkyHA_RTQMcwZA-1; Wed, 30 Sep 2026 11:13:46 -0400
X-MC-Unique: r_YTaUwvNkyHA_RTQMcwZA-1
X-Mimecast-MFC-AGG-ID: r_YTaUwvNkyHA_RTQMcwZA_1790781226
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-879b1d03d5fso85978197b3.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781226; x=1791386026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EoRCo81I/eGkPgW+8ugkZwxe3C1k/nICl5X7HO6q8Fw=;
 b=PHnkq7kArLLKYtgSQ643LH+7Gk30Ziqa2p9R3AdaksBrjO/h1K74h2heM+p33VYDM9
 AxkmSoFQmZAdyh+TvXQvLRjIDRcRPGi6UrLOP1o2ukzTtefWrhyL1ZL39G3FHMzQwODZ
 ZoGJfN7wjmYcRk5GE9m5OAxlM/ufhQXMOiqMQYNMTAQtU9mH1vhlcXYWu6pe0zH5cVq8
 KqDGO/aZgN6VL59utUjhYPgUottTNQZ8u//iIb+ju4dza69fivGzPUNxjH0/U4HLZYsM
 fXy68+VhX8Sp13EN3GQtXaSOBZ+QmBleZXLqBPrkG8p5frquONkNxZBHrwjB6RrLW5Y6
 VILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781226; x=1791386026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EoRCo81I/eGkPgW+8ugkZwxe3C1k/nICl5X7HO6q8Fw=;
 b=db2nZZstuAuHLzcbXGBeFdd+VUnufV2C/pPPQu6vD2tDe0mWkHW1gG61Scv0MWBn4L
 Fy9F2hV7neNPTiorJrwUda4gnW6ZBhK8mSyb3uUn8rdLRZOhtdxzUqb0lQbLTKfWfaSY
 QhPuu0SER/xL2mggIVYkmwk7KC4+gqUp7H7/NQKY0G2NsgbPiYEmf+4ui2w7JWEPVf84
 PFklO6+bwzdYcfNNAfpMRIUf/2mqiEnDA1WEevY+Fp80b97ScR/ghTf6cTCbb5CwrXYA
 Lcn+/TUr81ANXU1bdmp3Pt5M4CRVYgW0WssKBzJWsQ9Kzh6m22AaPmsZb5u7m5GqRabc
 PvLA==
X-Gm-Message-State: AFq9FYJ3wJbF0P0/A5jv0AbPbVI9tH1ffbxyCTKz9EeXJR/eqqfp5lL1
 NilYeKanQU9N61IzNZhChHXL19lFFuuqM+gp5iQxyj9P6yU6TSG9TLOBCR6/gVFvIWmDqKlsDLE
 JO37ntdwzkpU5o+JUcsql0khKlEoJxzXBq0xy8cKymMiPS0mIeSFzT5j07PGFjlbwLXg1TwXWlz
 e7n7fF2ak9cYN7N2y16Hp0TZ1n8MEXJNN2/gfdwNLX
X-Gm-Gg: AYBFou1JbZpZaWDRs7e3NVDcCXYooQVF9/O+KAmYeWUHi7EWF555kyLd9i1NOafeSF4
 3yPnnnidThTDxUu9cGgR5soba4/pn56gbfNGZWlTAd2kug1j7Nn5ZMAaJQs14JWmMFv0wTOHqD5
 TaMfX62tcCylp3LtVUgOeoMjiMlItdAhmbEK1BImbtJDmSu3yaKsaKPsEfuXEaA/W1GMQZnfSzl
 kAiASzBSosMAb2kA6x5O4cOv4p6BwFBbNDJfMtCboZ7kuHuQanEA2iQqSQPsyUd1k2WWjOybXFr
 ugXgYhAZq9A+lusHuqG8BTAiRkSInjZXsepkrMVNJTp0SIFWHkuqThnrQJJ3ob6kVpYDM2w=
X-Received: by 2002:a05:690e:b45:b0:676:8c59:2a36 with SMTP id
 956f58d0204a3-6768c593f17mr366079d50.57.1790781225679; 
 Wed, 30 Sep 2026 08:13:45 -0700 (PDT)
X-Received: by 2002:a05:690e:b45:b0:676:8c59:2a36 with SMTP id
 956f58d0204a3-6768c593f17mr366032d50.57.1790781224946; 
 Wed, 30 Sep 2026 08:13:44 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a8a2feedsm1652086d6.33.2026.09.30.08.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Michael Roth <michael.roth@amd.com>
Subject: [PULL 02/12] kvm: Detect guest-memfd flags supported
Date: Wed, 30 Sep 2026 11:13:30 -0400
Message-ID: <20260930151340.2817042-3-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Detect supported guest-memfd flags by the current kernel, and reject
creations of guest-memfd using invalid flags.  When the cap isn't
available, then no flag is supported.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-3-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cdc7554082..120cab1e22 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -107,6 +107,7 @@ bool kvm_pre_fault_memory_supported;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
+static uint64_t kvm_guest_memfd_flags_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilities[] = {
@@ -3065,6 +3066,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
+    kvm_guest_memfd_flags_supported =
+        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
@@ -4760,6 +4763,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         return -1;
     }
 
+    if (flags & ~kvm_guest_memfd_flags_supported) {
+        error_setg(errp, "Current KVM instance does not support "
+                   "guest-memfd flag: 0x%"PRIx64,
+                   flags & ~kvm_guest_memfd_flags_supported);
+        return -1;
+    }
+
     fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
-- 
2.55.0


