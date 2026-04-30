Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84352FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV5z-0004cO-GY; Thu, 30 Apr 2026 13:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5o-0004Y6-5T
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5j-0004AG-2P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFq/igNF+Xhi8H/iYwBMXK+5Kh7wY4UEYJ/pdGdNZKc=;
 b=eFVJqXIN3/UQ8/sGzRkeYKxocvHG6a8GYUEjqATlGLLoaTzGYzigp8ONVKbdtVcpim4mEu
 qHs+GJJVlMrmFrpD45nLyx5XTcleg85JoD+F3GZn0hpfouO7rYwpNM3sSzmBjuconZeF5d
 lCTX0w5zJAuIjM1HXaOZZnYmv79ZKfc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-gtMHJFIJNceHx-LF6az4QQ-1; Thu, 30 Apr 2026 13:22:19 -0400
X-MC-Unique: gtMHJFIJNceHx-LF6az4QQ-1
X-Mimecast-MFC-AGG-ID: gtMHJFIJNceHx-LF6az4QQ_1777569738
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8eaee67d1bcso246953185a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569738; x=1778174538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFq/igNF+Xhi8H/iYwBMXK+5Kh7wY4UEYJ/pdGdNZKc=;
 b=RpWlzSC3w5LDCGTp+343H1KBlwZBKmvrYHKGxWLABB6RMK/S8HLz7JNpFIrDBgNHfa
 HFGQ44EpDoW4VPThDhVKFe1S0JQiNRDvPOQ4aNmnOjDjGi5xMrEqjcPmieuEknr78MPK
 7Z5GL9r5X3VjRCoAs8v1E3hYPt3NpoDtWgq0zVUJQ+Fv2tFcX/jopABbovKZ6Zhk7XAk
 E9z1r54jFVHmX62rb95c7gsAlWE9EyUN1pk/JIsBl50E2WqHOSgYKZS+m1+pQCG4R402
 UznNnpXUuD75vFZm7s9fX5JPKfazcEMzsYYudH25JSofJtVuqF7Viit+ry4rhIZw3xeH
 TKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569738; x=1778174538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cFq/igNF+Xhi8H/iYwBMXK+5Kh7wY4UEYJ/pdGdNZKc=;
 b=sIVMzThe9VW/rwNCA44ppu7qOZn/NG8NIt/SCzaj5LsAaqTTuDf4lQsbsfMIcLijo5
 w8VjAd3uiYe3RxfBJtZYqY3J5f9o94lj83HMQ/0glsY3wLEiwVfp3o98DKECTk1SZP8N
 DzL/uLAqOt0cmmz5k4B+m4utcKRsJwO6v1IJjeYlGGIH9hpS5asKDaosRjDaK0nKVVIt
 bIgCkbTP6AmSCWET3KgYyqaWq7jbEpJH6TexI3aek3aSKCd1uDbVNB+DiQPQe58i8x1x
 L5fw1q7EHYhQO1xseFlWJK/4az7ZmsAqCIglUwauYuZ00n5L6lolQuMPigmwUfkxslNE
 JLTA==
X-Gm-Message-State: AOJu0YzwZrZ4yGTlCYju3ZqS2NFbQJEcDxigcCb2EuQQy2vZl0fTkRi+
 DC6n/lXXfMWv09jdkYdlCqm6sz8HLCspco7HVmi+LPyOThfuwp6931Jf4f9HLE5xxfp2sKqr8TO
 YwNGs0//qDBNp5EJRC+nD7d34agJZv9S/LeJndkDlMd/IhxXY0OojOXav+jnCCr6yPRiQlNkFRs
 YhuYUFHUXX2oNw+j5mz5Bcj9xsqER+B1M3S7UmbanA
X-Gm-Gg: AeBDieuHW1XkBZbfKk40plzOwWJDrnRTXyhwW3mxwHk1bZaB7Uu688TLdQPQf/sN2p+
 0ry93oq8yb/kB3yerPWgmaw6PsKAcidDEMg4+oWoN8ZG2qbfKbQghtsfDOVz4LP5f+yEoxFk6bH
 T3g2VQXRQBuC16gMdUn4w49s2e39E2MtMyv8vT3GIZYaBOYrXnNDDj6VP87fA62q6XhTC2e6kIU
 mZk5EwYHsLxoRCxj/ad/puyh/Qnj6GTuOnu3AETrjSWbqZzM6Dq5A/VPJr9WEk6dhzAVeBOxgV0
 HOOKXZhWGcRATRZi7ZrC8jTg9Sign9byjF2MxdmTAx7oSvtZdg8lxiCrw+HYHgASvP/hUjW14aL
 x3jBN39bzW3g2E4Fc561Q6h3zO+VfQ/5SDrMd9dHxYrZjVM8OPM394Vbc94djFyxRifzhA2Zhoh
 BU/159YG/NOqFjByy8bDVKHW0XrrIC+mLRFxA=
X-Received: by 2002:a05:620a:258c:b0:8ed:45b8:de8d with SMTP id
 af79cd13be357-8fa8759663fmr615338785a.13.1777569737607; 
 Thu, 30 Apr 2026 10:22:17 -0700 (PDT)
X-Received: by 2002:a05:620a:258c:b0:8ed:45b8:de8d with SMTP id
 af79cd13be357-8fa8759663fmr615331485a.13.1777569736944; 
 Thu, 30 Apr 2026 10:22:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb4028f9bsm23342085a.38.2026.04.30.10.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [PULL 02/58] target/arm/hvf,
 target/i386/hvf: Pass MR-relative offset to memory_region_set_dirty()
Date: Thu, 30 Apr 2026 19:21:08 +0200
Message-ID: <20260430172204.1006673-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
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

From: "Scott J. Goldman" <scottjgo@gmail.com>

Both the arm and i386 hvf accelerators have the same bug in their
dirty-page logging path: the address fed to memory_region_set_dirty()
is computed as "<ipa,gpa>_page + xlat", but memory_region_set_dirty()
expects an offset relative to the start of the resolved MemoryRegion.
address_space_translate() already returns that offset in xlat, while
ipa_page / gpa_page is the guest-physical (system address space)
address.

Adding the two together produces a bogus offset that for any non-
trivial RAM size walks well past the end of the MemoryRegion's dirty
bitmap. With dirty logging active (e.g. live migration on a guest
with several GB of RAM), this triggers an out-of-bounds atomic write
inside bitmap_set_atomic() and crashes the source QEMU as soon as the
guest writes to RAM:

    Thread .. 'CPU N/HVF', stop reason = EXC_BAD_ACCESS ...
      bitmap_set_atomic at bitmap.c:213
      physical_memory_set_dirty_range at physmem.c:1038
      memory_region_set_dirty at memory.c:2191
      hvf_handle_exception at hvf.c

Fix it by passing only the MR-relative offset xlat. ipa_page /
gpa_page is still the right argument to hvf_unprotect_dirty_range(),
which works on the guest-physical address space.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
Link: https://lore.kernel.org/r/20260427232116.50586-2-scottjgo@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/hvf/hvf.c  | 2 +-
 target/i386/hvf/hvf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 678afe5c8e1..2146c5c87c6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2159,7 +2159,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
                 assert(!mr->readonly);
 
                 if (memory_region_get_dirty_log_mask(mr)) {
-                    memory_region_set_dirty(mr, ipa_page + xlat, page_size);
+                    memory_region_set_dirty(mr, xlat, page_size);
                     hvf_unprotect_dirty_range(ipa_page, page_size);
                 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c0d028b1473..cdc8bd19504 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -146,7 +146,7 @@ static bool ept_emulation_fault(CPUState *cs, uint64_t gpa, uint64_t ept_qual)
     if (write && memory_region_get_dirty_log_mask(mr)) {
         uintptr_t page_size = qemu_real_host_page_size();
 
-        memory_region_set_dirty(mr, gpa_page + xlat, page_size);
+        memory_region_set_dirty(mr, xlat, page_size);
         hvf_unprotect_dirty_range(gpa_page, page_size);
     }
 
-- 
2.54.0


