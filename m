Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7156C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB12-0005PQ-75; Mon, 28 Sep 2026 09:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0h-0005E0-Vy
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0g-0004NR-8v
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4RvNCT2y8zVGqENgvkDht/pSR1xl+g9L/5IdPFCHSE=;
 b=fLhxCQj/+dMZisgW5Dl9e3181bVB9UP6K2AIrbybsY30M19woHUd/KS2yjLtMpw0HwZajs
 ZtcnCQxnSz1vi/QrElmfsMY3VoJOl7HCwX/nwEJZQpKY8XI77eqsKh7B/a3F2KJcG7C/J4
 oK1OJ7lMXAuH+yMIBSwXpdlZakVj4fI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-80ftbUfYMya6UMLsTTOQEw-1; Mon, 28 Sep 2026 09:03:07 -0400
X-MC-Unique: 80ftbUfYMya6UMLsTTOQEw-1
X-Mimecast-MFC-AGG-ID: 80ftbUfYMya6UMLsTTOQEw_1790600586
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48889d1f527so1422732f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600586; x=1791205386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h4RvNCT2y8zVGqENgvkDht/pSR1xl+g9L/5IdPFCHSE=;
 b=OrNarLWMmh7bWvuU16obpLZ773J1Jx4f0Bi/CSHzWqunTZidXCTK9kvt6I4GcoGXrF
 5p3oUaV3M3liXhkK6eIeUet8VqY56WbgUVO9TTD46WtSiMfGenlVOnDjk4MEDSPtRKGt
 V/2b4IrT+AKisW17BH1Lhfhduimw0aoTumF0ywXnJ7wYR5UmE0s5y3kJHYqTkp06wS/7
 gN25gY7C/hZl4w7V/Y0eK0h+Sxubt+5uOVvcAYPHMdZTcLGlsBfGfjTl3kEyVJ2DZHrU
 ankFt/Ob9+OHk5/CaJrrm9enRo2kQ2ZnMWmNpLUZxAkV1Ge8Ty0qJlowmXTXh/NJlHRm
 yuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600586; x=1791205386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h4RvNCT2y8zVGqENgvkDht/pSR1xl+g9L/5IdPFCHSE=;
 b=NSVg/R8vVcB1BucldARTrEc9W8E0jGCTjVkcD/nsF8en3YR4XGm1LzhErf3lJOWY2h
 4Jdak2pYaLSpYMMEM1YhXghLXy/hwnXA7Q8815szp20PtXtCbe0pl0i/CKHRdZ2UlxpI
 bKJRc8QlhRWN5za76PdGUcc2lUa0l8bdp2Y9r/7o1OV9CgJx2OYq4PKdroUd63ew0yzm
 rPvmcZBkBkMqFPQN3znDPwIM7+vPJdmfCHEObKobzt5+spDLxNIRegqkG0HD6YdYfAM7
 Ri7cjt2f0EwBhk4yndCD0+KmKq4tXa+EnkPI3WQEEnjpYVnFihlg64zGbcdIzdd1e7r8
 KGIA==
X-Gm-Message-State: AFuF++mY6eTi1bB7G4ZyRb3mdLxs8oXPGjrk31pkrH9JTfWgBx3V6R8Q
 74hBjQcKwlwwrfRhJcP7Ovqh3iIIJI/R3nVQ/POY/e8NFrIv4Rxm36J26eCA022iNKL13+9MF/A
 gRLF+B5Y7L7rY9BzZugdJ3lv6BBbqaNh3jomA4WRse3AX0KosXIxqNjk3HkIdKUlRg9/rlADyp/
 BL+Ylsla/HyYJ/K36Xjg6iZD+xL1ub2xfJ3Rw9W8pf
X-Gm-Gg: AYBFou0JpgPvQjhHvgjnHeXmYXzTjwF5iGTJJTouElDmHUuGK5Krf7l4ogYUUxSG9Nt
 R5+CpjHJcxclWdrV9eg381GZI80KP/A0saVWs3RRFoWYAOESk1ON874g0pxRh8uJzopueU8IQda
 AgHDKWeDyO2koj7whV4XCE0Uc2zDTIHO/CMR0CpcHI6Kb/I/PVREbEHuNUIxp+s2iI3KlGBppqM
 LlviXSmjXQcOCvklGZxqChSVcOlSFob/Zwb9QHbVj/qQ+vBFV018+Br9HvxrkLdCsBWhpXv16aD
 Mex54ou+DgPu69qMrPrShFaNscN4TyVr1yXKF5vgaWlOyIBhpZDVNY2XnRvmB4evmzsrOmAQmcK
 1GRxmTu9b02XgY1/nTsGJuWomHUNdenY7gSLSp6M2CAQ77cBOlqa0416PkF0CS81wYiR2i1G1Ql
 hcmR0m
X-Received: by 2002:a05:600c:3550:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-49ffd408357mr93518455e9.34.1790600586203; 
 Mon, 28 Sep 2026 06:03:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3550:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-49ffd408357mr93516225e9.34.1790600583880; 
 Mon, 28 Sep 2026 06:03:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001922102sm145095075e9.15.2026.09.28.06.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PULL 11/30] accel/kvm: coalesced mmio: check lenght of the MMIO
 write entry
Date: Mon, 28 Sep 2026 15:02:09 +0200
Message-ID: <20260928130228.877003-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

From: Maxim Levitsky <mlevitsk@redhat.com>

KVM's coalesced mmio ring buffer has entries that contain deffered MMIO
writes.

Each such entry contains the length, an 8 byte value and a guest address.

While the length value comes from the kernel, it is still possible for
an attacker to corrupt the length field using another exploit.

The attacker can then invoke kvm_flush_coalesced_mmio_buffer, which blindly
trusts the length and can be used to inflict further damage.

Add a sanity check on the length field to prevent this.

This patch was only compile tested.

Reported by: "Labs, STAR" <info@starlabs.sg>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3863
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260923004631.100997-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index da3afdc68d8..5433a223e36 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3185,9 +3185,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
             const AddressSpace *as;
 
             ent = &ring->coalesced_mmio[ring->first];
-            as = ent->pio == 1 ? &address_space_io : &address_space_memory;
-            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
-                                ent->data, ent->len);
+            if (ent->len > sizeof(ent->data)) {
+                warn_report("coalesced MMIO entry has invalid len %u",
+                            ent->len);
+            } else {
+                as = ent->pio == 1 ? &address_space_io : &address_space_memory;
+                address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
+                                    ent->data, ent->len);
+            }
+
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
-- 
2.55.0


