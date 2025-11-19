Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB0BCF397E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLm03-00039q-3X; Wed, 19 Nov 2025 12:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzi-000314-NR
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzg-0004Nn-7K
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/qhRlrhL2hHAQxy9Ba9VBELeFSbko3iP9NyeeHVbJY=;
 b=OStvHX41ML+1xD5TBEzL9CC3DUNj/LMp2d7Zq+2/VjGQZa8gbVJET71wJ8+OTei8sI0IHv
 eC3XPeTnUG5piRTeZE5nHk64NXTeYDLxl7dEXkp9J/2q/AKUHawbxwTNudRoyEYCE1HkYb
 0ZOZLptX741EaLUFHcnHTUe3aQL9kB8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-7kpSR_5VO6qrTFbNrR6weg-1; Wed, 19 Nov 2025 12:29:20 -0500
X-MC-Unique: 7kpSR_5VO6qrTFbNrR6weg-1
X-Mimecast-MFC-AGG-ID: 7kpSR_5VO6qrTFbNrR6weg_1763573359
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b26bc4984bso1317388085a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573359; x=1764178159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/qhRlrhL2hHAQxy9Ba9VBELeFSbko3iP9NyeeHVbJY=;
 b=gJeENwYj48a27/q4DmsE0Jcbu+kr+Nync3v9eQo/LD8mcrM6HXr4BAiuE/40/tvGAh
 1ZdmkpjmIEHKwt1i9dRTxTPZ5lem19km8IG8obLOfxPm8FhZxsWtTklf39f64LvJCWK0
 T3UIKyCkroAHEv3+nDyVFKcKFeqB+xcAjOx78vwm37FWMakOEaCGJTqV/N7eaZbQumad
 0VEoPbFrcEJYiLCzLlB5DpK5iloKw4ekaAizTII0rzVPQ0PNb6a26IEB5n+uiYctdifP
 r1QWANIOkcGgFYiSy+Tg1okGdvBXN66xsfZEGddL7fc5TJ+K6XuKdagaYXq6lXC1hEpJ
 JhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573359; x=1764178159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z/qhRlrhL2hHAQxy9Ba9VBELeFSbko3iP9NyeeHVbJY=;
 b=ueyMQgh1yB0sKdzEbGo74UUlyxICHjGf9sZwaIf5KsmE2Hql90LUrUNgYeOQoPmPkr
 l/lRndB2bvIT4YNAcWmVWzPEVa5g+aKmT/X6s3QIp2rf7/1GnjlCOwIxNohD1BjG0eRU
 RrIjJLoOZ5ET7254F0tZBzATtDXHBhtBomBUx+MMRtQrgyWvelmAf33RtXbKs8hYAkqB
 J5nhyFMx8f2dkB7P3+hYpVRfP6v54P/8Q14JOFpa8fl2gIn98zzsjg0hg5Q47PB02FhF
 PSiPYYulKIKWd9edSNTot8/f2y+LeZwxs/L07Z0xUuux0rvDjnqEx+v+eotKLZ7TlsKR
 oNfw==
X-Gm-Message-State: AOJu0YxziUVGCw1iAuI0kh9NCVmo73+v0fjnDOgobELO8fdA/6bHzgi0
 yQ1Z2m7qSkboH30U1C4ccmXFnOgcas+IkpIm3/NPaMGBR9hHHM7YS8DSez9iG5NwL7ro2EroCrq
 grKXJlZJ6G0gRxoIia6ChNMXk4d9A6uXBZp9h+APvUdN0FDPKHLJ7cqiP5FYfIg1twuy8VnqBWj
 zQw8MThNehmYwDm0c654LBFxz8EllaD5bwxuaiWw==
X-Gm-Gg: ASbGncs8ggWL4HR3GKmGIXN7VEhVGzT2BJPoJC2GwcwGAkKrbSLnkg5mPeJFRYUZcF4
 3BZFv5viapU4zgHKdlbbWHXQv7S4yFfxnvAdvWsbbpADaTDmndzk22nrPrI6qqxH0y9ZvueFTkz
 3BiInknsjrLfGOQ7vJAWhgkOHRwBQ1KhSdvXaLmoAT5vCfUTWwg+xmHHSkk425qd2XR/WKzZ3B8
 kGKbV6/D9h8DYg0meZOaZCcQdaTLAYewSOkvRa4RnGQ+OgUrprBLVkfN+ht9e5asYndNdEM2eQc
 6s3Axym9Hr9wuUgMq+sxKoWsmrr9HDd4YXiUnLS7j0N85Mi/r34xTW2tK7CAxAmH3Dmb/C8D5xt
 l
X-Received: by 2002:a05:620a:4443:b0:8b2:dfda:66c4 with SMTP id
 af79cd13be357-8b3271f3baemr23463085a.8.1763573358969; 
 Wed, 19 Nov 2025 09:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFszdwXgXqadTURmKX6GrLjwtuOtx0zhOyJIsiSrNwIISrL//Z08/sOMWieOqZzvOGd2aXZRg==
X-Received: by 2002:a05:620a:4443:b0:8b2:dfda:66c4 with SMTP id
 af79cd13be357-8b3271f3baemr23458285a.8.1763573358441; 
 Wed, 19 Nov 2025 09:29:18 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:18 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 2/9] kvm: Detect guest-memfd flags supported
Date: Wed, 19 Nov 2025 12:29:06 -0500
Message-ID: <20251119172913.577392-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119172913.577392-1-peterx@redhat.com>
References: <20251119172913.577392-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96c194ce54..f477014126 100644
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
@@ -4492,6 +4497,12 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         return -1;
     }
 
+    if (flags & ~kvm_guest_memfd_flags_supported) {
+        error_setg(errp, "KVM does not support guest-memfd flag: 0x%"PRIx64,
+                   flags & ~kvm_guest_memfd_flags_supported);
+        return -1;
+    }
+
     fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
-- 
2.50.1


