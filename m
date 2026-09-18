Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CF5C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Wy1-0001gn-O3; Fri, 18 Sep 2026 07:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WxQ-0000uW-B4
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WxO-0001ue-3V
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRL71dB4DNT2ZGZseVXXIvVaWBoDYLTLHRGinZaqf6E=;
 b=BlDIxRHtypCpgJFnrlIrhf3+PKsGTiyXd/NuIeJZUZhUlO3z6RnDSieRr5KoBJpMjsEnvl
 HkBs1B6TTVhr0NzX6bUlpwW89Sm2A1sEUBQKH4hjX3/t345ifOud8jnu2y0Kc1FkWfuD0d
 kmIM8RoLuOBiYSumvCjYvLo8OWC23sI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-xhdW5opJMsG1XeQqSe-J3A-1; Fri, 18 Sep 2026 07:40:40 -0400
X-MC-Unique: xhdW5opJMsG1XeQqSe-J3A-1
X-Mimecast-MFC-AGG-ID: xhdW5opJMsG1XeQqSe-J3A_1789731640
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-530f49fc5ffso18706901cf.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731640; x=1790336440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QRL71dB4DNT2ZGZseVXXIvVaWBoDYLTLHRGinZaqf6E=;
 b=S1sC0cpF4yD71xj4CGfxiligFVzz6ogHE/VaO1dO3dWMVjZk80ujOQRVaphkMwcW8S
 91mbvAXpYOYajdq2f0LIbqSPTa6Cds/vXj2wxZut2Vr6MjJCWK9w1/Z82TQhHKsqIiFL
 rpY2IQsHguylIhjCBTfNsp2CMuyNtJmOj3eIDzjfw+SYmHhfTNDy0s13Bpao9qy52Gkf
 SnjnaMN35NuQaDHp2sVdVQ5VndmkZ0siuSfy1EG1cEb0H+/PWIuQuPw8dHnsdcRzG0Dy
 Vr5+aEOfKxHvgXEFRSzuunQvjUZI5zJ31I76asYQenrbQTgNMKlppg1DdCZ+3QB8hcgp
 j0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731640; x=1790336440;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QRL71dB4DNT2ZGZseVXXIvVaWBoDYLTLHRGinZaqf6E=;
 b=j6sSTlji0wYRPjh31WX579sUAOmAO1Q5qjpCmzBqn+RG8pmR3nAjvWIF4Jh/7Sb3ln
 DLzhfXuBgu8hLUvXH4YODkAI6VlxZUR97fhb0Pb1VKc4QlyNAz2xJlFVVgRLWu74nRT5
 53E+opfLmsUfwP9Eb/grTOdScYn9sU9NHhn/4lRkGuWninX0fPHDUoPvgKaK+MAwrMGU
 nuyd9Hf2Vf9wbcgZeo93w4hUipUhwFMOiGNi3f/b5q0e2SAAQ03WN6QHw1MfY/lLFEox
 KXFpTMizwBgkb8HAOPfVlhn4c84pOHBEhVv3atJxvPP/os1xpdJyaC2SQZ0k3MUAJJrk
 06tg==
X-Gm-Message-State: AFuF++kpY8yDAdMFpSb9Q+bAfBGqcNBoKkdLZbHix8O0fdGbUPdaGHeu
 4HehOzM1iYOcFhcEj7mPPLR+412l7nihSiReB3Uot3G3zYT4n3PWCdAxcaWUeJnxtB7vSPLBGr2
 gnYParRWSKstCdPKohWcmPT2Oh6bT3LYq9LUqGyO5D4WHZrchEMli+Z5ZmQuVOKPT5mrg9p8vY4
 2Q2NdAhB8iMGgiV15FbHm8o+6QrQ2Pb7AFANOfXqnY
X-Gm-Gg: AYBFou27jOpTqhAqFjNQwQYKX9V0baFmxYNISjNbKcoiRNxJ/P29gDCjIRslYWV+tr3
 eqszxxqooEd8hqFzSoEwbuCdwadtEsNK2BBLstLxzdsD62aB9R0L66URUNFnzq7aMGsIg8LDNLj
 AOunTC0lJXLf3rJo8nfn1t7XH+lhgqD03qguwLRgFUEqP2xVb7AGqzHFFc5dExqUUBEdVwA7ISa
 qEb0hiTq0u9wodq/jgsqJLGfa32xZUJ+qa+n28s467ANqk2urdnFT7ZJSKJ2k0qxhAFnY1rjkvl
 bLzWnG+qlWeMut4D1sqrGX7uTPifjbOaznIC+bgl4xv97o8o6Cj+6R1R+rSrueHeXNlvYyTaqUD
 WH7cPVzlvP8Adzu7ZwRwMIIYfA2t1NOuwcR/blf9BI8VaTkJJx/PTUDfOPvQ=
X-Received: by 2002:a05:622a:1b27:b0:530:f9b5:5837 with SMTP id
 d75a77b69052e-5329e3c0b74mr35365931cf.23.1789731639625; 
 Fri, 18 Sep 2026 04:40:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1b27:b0:530:f9b5:5837 with SMTP id
 d75a77b69052e-5329e3c0b74mr35365101cf.23.1789731638759; 
 Fri, 18 Sep 2026 04:40:38 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532a19a4fa5sm11375511cf.13.2026.09.18.04.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:40:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cam Miller <cam@linux.ibm.com>, qemu-stable <qemu-stable@nongnu.org>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 11/11] system/ram-discard-manager: fix
 offset_within_address_space in replay_by_populated_state()
Date: Fri, 18 Sep 2026 07:39:26 -0400
Message-ID: <20260918113926.831204-12-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Cam Miller <cam@linux.ibm.com>

Fix bug inside replay_by_populated_state() that forgets to initialize
MemoryRegionSection field offset_within_address_space. Follow the
established pattern of calling memory_region_section_intersect_range()
to accomplish this task.

Prior to commit cc9c77f4ddf0 ("system/memory: implement
RamDiscardManager multi-source aggregation"),
replay_by_populated_state() had called
memory_region_section_intersect_range() in order to initialize
interdependent fields offset_within_address_space, offset_within_region,
and size together, as shown below.

    s->offset_within_address_space += start - s->offset_within_region;
    s->offset_within_region = start;
    s->size = int128_sub(end, int128_make64(start));

cc9c77f4ddf0 reimplements replay_by_populated_state() initializing the
fields of the given MemoryRegionSection instance by hand instead of via
memory_region_section_intersect_range(). In doing so, it leaves
offset_within_address_space uninitialized for some reason, as you can
see below.

    MemoryRegionSection subsection = {
        .mr = section->mr,
        .offset_within_region = offset,
        .size = int128_make64(MIN(granularity, end_offset - offset)),
    };

Consequently offset_within_address_space defaults to GPA 0x0, which is
incorrect. For example, on s390x, base RAM begins at GPA 0x0 and it is
problematic to report that a virtio-iommu MR section lives there
instead.

cc9c77f4ddf0 deliberately calls memory_region_section_intersect_range()
from other related code paths inside the same file, namely
replay_source_by_state() and rdl_populate_cb()/rdl_discard_cb(). It is
unclear why the new replay_by_populated_state() implementation does not
conform to this same pattern.

The effects of the bug include qemu crashes on multiple architectures.
The following assertion failure occurs when driving the
guest_phys_blocks_append() code path, for guests with virtio-mem device
that has some memory plugged.

    DBG: guest_phys_block_add_section: predecessor->target_end=280000000 target_start=0
    **
    ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
    Bail out! ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
    2026-09-11 16:03:57.405+0000: shutting down, reason=crashed

This crash can be triggered on x86 via the dump-guest-memory QMP
command. The same crash can be triggered on s390x by restoring VM State
that has been migrated to a local file. (I used libvirt to manage this
migration restore operation, namely command virsh managedsave then virsh
start.) Applying the fix resolved the crash on both platforms.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: cc9c77f4ddf0 ("system/memory: implement RamDiscardManager multi-source aggregation")
Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Signed-off-by: Cam Miller <cam@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260914-vmem_fix-v1-1-f69ef04a07b0@linux.ibm.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/ram-discard-manager.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 4e8816e5a2..e9a609e5cd 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -238,14 +238,15 @@ static int replay_by_populated_state(const RamDiscardManager *rdm,
             }
         } else {
             if (in_run) {
-                MemoryRegionSection run_section = {
-                    .mr = section->mr,
-                    .offset_within_region = run_start,
-                    .size = int128_make64(offset - run_start),
-                };
-                ret = replay_fn(&run_section, user_opaque);
-                if (ret) {
-                    return ret;
+                MemoryRegionSection run_section = *section;
+
+                if (memory_region_section_intersect_range(&run_section,
+                                                          run_start,
+                                                          offset - run_start)) {
+                    ret = replay_fn(&run_section, user_opaque);
+                    if (ret) {
+                        return ret;
+                    }
                 }
                 in_run = false;
             }
@@ -257,12 +258,12 @@ static int replay_by_populated_state(const RamDiscardManager *rdm,
     }
 
     if (in_run) {
-        MemoryRegionSection run_section = {
-            .mr = section->mr,
-            .offset_within_region = run_start,
-            .size = int128_make64(end_offset - run_start),
-        };
-        ret = replay_fn(&run_section, user_opaque);
+        MemoryRegionSection run_section = *section;
+
+        if (memory_region_section_intersect_range(&run_section, run_start,
+                                                  end_offset - run_start)) {
+            ret = replay_fn(&run_section, user_opaque);
+        }
     }
 
     return ret;
-- 
2.55.0


