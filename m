Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5062AD5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYF-00065q-Mf; Mon, 15 Dec 2025 15:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYD-00063U-PT
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYC-0005hX-E6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmRelyvkEWPwQViCA0GfPBr0X54FEreZWo37gPxLTgs=;
 b=Wz3gsTutBaRHpuu6HQ/XnXfyUtHftiBawnzWuMGnAI/YKcxL8JgQvnbcqs488DF5srnIpD
 eBSk0kdZx46n/WzLS33SIs4xeJcbKcFm6GiGydZUzAzyJSSSjSEkHES2UjO8SzktwyV+Kk
 ctGoQ5kfmlzi2z3KNCpvxqKsrQWLyPc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-wPfzcQoLOveStDxEe44hHw-1; Mon, 15 Dec 2025 15:52:10 -0500
X-MC-Unique: wPfzcQoLOveStDxEe44hHw-1
X-Mimecast-MFC-AGG-ID: wPfzcQoLOveStDxEe44hHw_1765831930
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2f0be2cf0so1305752985a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831929; x=1766436729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SmRelyvkEWPwQViCA0GfPBr0X54FEreZWo37gPxLTgs=;
 b=BqUvz2PVtFWNKH0AxOHOEfxKEj3n3x8VVaDfLHyQq4J3CGE8PfjBG8cRJEdLijGj5T
 OknGoO6XaERJM+lwRk0EweQxfug8R/K6RDOjpH+ovRQYESXZ4zcSnBIT3rn+P5YVWneK
 FJMN9F9sWD8SI/6SET68JA2kp9OKH3L9j94nvoz/5igTPtoyjevz6d2Ht80kEn7h+wzc
 JoTbHQUqiboP70obgzfpctkWdldcUKGli32YadZwPVnxFBqD1CJ5ArPy9fGwSX/5WYa0
 ACslt3r8wkHJJYsY8922MalP65G0jm7SRZGYAMxpOWXn9QV/FPn1XvFBQUIvouv7fQDB
 vggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831929; x=1766436729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SmRelyvkEWPwQViCA0GfPBr0X54FEreZWo37gPxLTgs=;
 b=hrY+5z/DHVD13wdhUM8ucc60FjKA6wpSAfuLEz/U6krs5DuC7OVPa64uCOY+PXrfkA
 fNA9YhZ3Jgn+EEnTLL2G4hoKSD/X8GY3di6swYhoq6Rsrb6u5Tr8FUNdRKnMiExLlRqT
 dN7ViyYZ1n2EVphtutJmZqCMq0EyZnPeLVtA81wwuzwIygkrjVGKhpDi2swz/Gw2HaHh
 1Xzrv6XJe6+VILSPAHGcppTAbd/pRfNMjYDVye/x756c4tAy+JmoonTHkCHyGV6Pbi4b
 McwFcI9vJ+7hxiHR5YPxt3DqMv/hAT1ZSXuNuGUMAm9IoYv75GeOV6jWp2FsQEnm+Wjq
 fKqw==
X-Gm-Message-State: AOJu0YxpztN5gKTzldF0ftYKr30rPw9SS+M2OMcitSKhY0r3II+h6MI6
 Zyjl4z88c+7GHk0sH6DDW/yXNwhQbwD++nifeTHCHc2+cZTAMCi0hs0OrkdVZz+Qmw1bVgZbmIw
 fPAwoE93stxv88gS5LUj3QlG5ThbL2fwoHBlvmMyw++blzVmm6sEEmGVQbVaDjld3Bfzv3K5aLo
 CuCPFQdSc6nin9nwULl2mVtwmjhMSBL6c/nHEvnw==
X-Gm-Gg: AY/fxX6FV5Sg9zuLcT+d/NejLSI18xjXQ+iv0EIoorRMOGYiXdkT2h/H8XI3ybhunL9
 tLemf+pXWYnnc9NeX4MUf76Y55SnTm4XylZ4rd1EQaudAmgumXgUhX90NyIXIRCvexym91Agr2N
 Ak7psQSV9KAEouQA0RISSJ12FBkgNxe5sw9BZqk64UwxpQicQcV8Hx8Ta5mvmkhUq2pajbec66P
 Ug0ckesK3KFsHCmOITBwrhN3vcqyvJwzfFKm47J2EzK73YJwtSRcEsbnPoykr1NK732xzGoTnKj
 NgNnVb0fOOWTsaV9S/3MbB7k4jy+VPhlH5BZzRhckDljQnLP0Cwab4EHv76IOoWu7koHTcgA7zA
 U
X-Received: by 2002:a05:620a:1a20:b0:89a:ad1c:5139 with SMTP id
 af79cd13be357-8bb399d90a3mr1650871485a.1.1765831929169; 
 Mon, 15 Dec 2025 12:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbPXsWWzDu25bjK3oDlTGZWUlehNqb0ayakt6jxFVAHsqF+4litep2Z0/EBQs/flimdQFrxQ==
X-Received: by 2002:a05:620a:1a20:b0:89a:ad1c:5139 with SMTP id
 af79cd13be357-8bb399d90a3mr1650866685a.1.1765831928655; 
 Mon, 15 Dec 2025 12:52:08 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:08 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 02/12] kvm: Detect guest-memfd flags supported
Date: Mon, 15 Dec 2025 15:51:53 -0500
Message-ID: <20251215205203.1185099-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Detect supported guest-memfd flags by the current kernel, and reject
creations of guest-memfd using invalid flags.  When the cap isn't
available, then no flag is supported.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 59836ebdff..68d57c1af0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -108,6 +108,7 @@ static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
+static uint64_t kvm_guest_memfd_flags_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -2787,6 +2788,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_guest_memfd_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
+
+    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
+    kvm_guest_memfd_flags_supported = ret > 0 ? ret : 0;
+
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
@@ -4492,6 +4497,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
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
2.50.1


