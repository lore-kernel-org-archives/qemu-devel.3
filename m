Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F3DCAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNy-0004PZ-0K; Sat, 13 Sep 2025 04:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLN8-00025p-Ck
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLN6-0005L4-J1
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5uQt5ustiZIdzCYn4xmtqTsqlJ6I63W6ymofZAy7J0=;
 b=A0H5qHb/Srq7Ek3PMhAEnCh5m7JyIar8vEqloJ9Gq0RuSYHjezjm5rn4IrM0Fqnl6Z9FCg
 o7FEtvTtb6uG9eKNUZkjuRb/R7GKO7hz1AhnJqyhvEfRu/wV2lHxnADTteHy1tiDlRFqTg
 WQKKZN9iH119rr2GrRGy4/EI6V5zqj0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-oUNNH6MTNdSPeIbWQwLUjw-1; Sat, 13 Sep 2025 04:12:34 -0400
X-MC-Unique: oUNNH6MTNdSPeIbWQwLUjw-1
X-Mimecast-MFC-AGG-ID: oUNNH6MTNdSPeIbWQwLUjw_1757751153
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df2f4aedd1so1862778f8f.3
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751152; x=1758355952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5uQt5ustiZIdzCYn4xmtqTsqlJ6I63W6ymofZAy7J0=;
 b=R9gasxy3viIzbOqalpgPODuO6lkag4hwivZUYbdnvOQfMLP7Z0ID22KGycvOemX2Mt
 oFaqGwV7MGqM9WYSl/DqVSAv7ZMyICerDew7uQO0ud5v0OW39T/yFvc0KRLBBLYqEEK8
 gDmENB91njCchmlnn7IPdUjkT3MBhcmOA43YV/4Gpsfkjs+13RcEfkUMoAideePnrGIU
 1mInibIdipHyDJ1SmQuU7ow360o+6wEyka5z10WrIh1161lrwrhGGuiIXb4GlZDXiMSf
 Vey97J3rtoufAhsfxKKxyApQKrxn1wwW4/aELSqxxzCH5xZZYf92QnBupFw8TbAxDWW8
 3VWQ==
X-Gm-Message-State: AOJu0YyuGMAsNfGdf5ZLBWksv9nGoRAkSseSnUpcpkB1DL7hXYsuwKre
 b5vbfm7NVo4TZSkrCm+u9eb3SU3PwrtikwqCWpv8S/vLG8ZDrMHRUXFq1vtw5ZAmCpm0iYwNADT
 oIpwNJ7r9IR4/gp1VtRcXLc90RVfWAEHG037dUXhF4iPpV+4ZJ+ADQoYKce7cNCMk9dUNfeEq+e
 M1xQ52HjoISAucxAKMj4RHWEsyngChMqJhwbeaJreU
X-Gm-Gg: ASbGncuYV8AjIj4/SJbJIU9wWN8YPNQj2xgHpZLDsFnoLcN3akJY6Ps0lTJvUY5mJNU
 d8ZJ5PEYuMNS3rZnTMXbqSDlqmmIQUAZuw/p18qa/s2YACVFwoZyL9mMYVL5L8VMndLfSzudFEl
 lF0gsBMZFaKsSROCnF+z1WlWaeAl5okQvT7YbWDXz5zEYH9vZKvYDs00KtwPJsLiXjIyZv1BykV
 HJ3Ith9yNOV6kcZJwmEJyX0PjO8G/ZejQ1iIsCtw+Nll4NDAnCpLNmY+fqUI1TwzurQmSXhDGyA
 mW6trsUzchRELgAyODuEW9PXqQtjZVdyIWf/Rk4cTwkaps2YptG7ifvd3Ep2lXsk1NqQyfArouz
 /TK4KzqpveGbTai42ka7FICtfZtFLPjEZ1yWmjfEWpmw=
X-Received: by 2002:a5d:5c84:0:b0:3e4:f71e:2d7e with SMTP id
 ffacd0b85a97d-3e765798576mr4616383f8f.23.1757751152022; 
 Sat, 13 Sep 2025 01:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9gKJ6zhYZUit2MO51JvZlTcvpfh7rjKP0NCSAJJY3k0/6Lb4S6RCDvPPCkLTYXBEY5PCMZg==
X-Received: by 2002:a5d:5c84:0:b0:3e4:f71e:2d7e with SMTP id
 ffacd0b85a97d-3e765798576mr4616363f8f.23.1757751151561; 
 Sat, 13 Sep 2025 01:12:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607ccf93sm9469194f8f.38.2025.09.13.01.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 61/61] accel/kvm: Set guest_memfd_offset to non-zero value only
 when guest_memfd is valid
Date: Sat, 13 Sep 2025 10:09:42 +0200
Message-ID: <20250913080943.11710-62-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Current QEMU unconditionally sets the guest_memfd_offset of KVMSlot in
kvm_set_phys_mem(), which leads to the trace of kvm_set_user_memory looks:

kvm_set_user_memory AddrSpace#0 Slot#4 flags=0x2 gpa=0xe0000 size=0x20000 ua=0x7f5840de0000 guest_memfd=-1 guest_memfd_offset=0x3e0000 ret=0

It's confusing that the guest_memfd_offset has a non-zero value while
the guest_memfd is invalid (-1).

Change to only set guest_memfd_offset when guest_memfd is valid and
leave it as 0 when no valid guest_memfd.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250728115707.1374614-4-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 72b571a6972..9060599cd73 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1595,7 +1595,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
         mem->guest_memfd = mr->ram_block->guest_memfd;
-        mem->guest_memfd_offset = (uint8_t*)ram - mr->ram_block->host;
+        mem->guest_memfd_offset = mem->guest_memfd >= 0 ?
+                                  (uint8_t*)ram - mr->ram_block->host : 0;
 
         kvm_slot_init_dirty_bitmap(mem);
         err = kvm_set_user_memory_region(kml, mem, true);
-- 
2.51.0


