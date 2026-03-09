Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E796FCA187
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPF-0004iJ-1p; Mon, 09 Mar 2026 16:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0004fb-Hy
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP1-0007hg-Na
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCSsJ5q4fk9kF9TJZO2z5mERilkapSPpUsI49F3EOfg=;
 b=h3p7fjnt3zDRmNWXpJeGNVmK1+m3dXlVhJtQU8jkd3HZglK3aJVqxILh2at808hwqqW8mW
 VNVqbKM90a27ZESdwp6vUdRQG6GYZxB3OAHvDZl4k5o/ajJ75/jjmWDCWVc3dhsock3ErJ
 7EBf39loxHoV+Jih5p1OhT+bA7+lRts=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-3J5_IFIMO5mCn4qwGqO9QQ-1; Mon, 09 Mar 2026 16:40:25 -0400
X-MC-Unique: 3J5_IFIMO5mCn4qwGqO9QQ-1
X-Mimecast-MFC-AGG-ID: 3J5_IFIMO5mCn4qwGqO9QQ_1773088825
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd81506677so979574285a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088824; x=1773693624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCSsJ5q4fk9kF9TJZO2z5mERilkapSPpUsI49F3EOfg=;
 b=pTKg5P8fhgAqB991pq2EmWx2w5yrTFcEdWssSJmwGoGUrGSlLW1GO4P7OK9dp2GzZ/
 bAUOq6bTeT/0W9tRVUet/4clHAHEmMFCLmEr5YGZi6Ii4keNvpjGP+3/fQqCzHBowxAG
 k3bNRSs9mSDWF4jQGp302/G1BHTiZ5zGO9QamclYAqROAtob+zjHyD38FGfblW4uY0Wm
 nCfL9+1EJ2+GNC6gLwYFqwxIPI7xSdkQyKcIUE32yHWB9uHLerkG2X8FvWZdeI9UjuLw
 QECIln73KBDMkdjj+Dk1KPWZEE6YdEg7JO1h0bApSbNUZRH6tMGmNN3vZwtnnCoz+X0h
 sg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088824; x=1773693624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PCSsJ5q4fk9kF9TJZO2z5mERilkapSPpUsI49F3EOfg=;
 b=eucaJXPaiQVmvCGh8xPoZ8ArYbydrUj4FbV2J03FI39FgJdxr15OeaKhC/Q7xDGmpK
 WpVyp+Qevb3U4KplGrgNu0B6EI1lFyBWhbcD/8mSVCTCyo+df+k2pPJ24gsrZ80OvT+i
 RKEI62L+oR+LE3ILQ3czpIODERRCTBLZDlZOU0Z2Lp3h1Fr6iSeTFMgHmbczquMGrk0N
 rb6yGKbsnGkNuwu3nZ6CIRvmVR0V4IzYJEXSDflyJUoga+jv5NEX/4u0hKMBFFetITDY
 uQ2qOlG6tnHgWgEd9jt9mNROGYlv/VunomZJhV0RS8W33uQoVotvlNB9Kdt+sHNgvH/E
 qFZQ==
X-Gm-Message-State: AOJu0Yx1EhV8xyA0VNYSDbLpOd7DFC6sRqQtl3ZTCM2HY0obZEkUR4ZI
 3Zonr6dgof4VWdj6seSr0Pur/FR49OAiRhWT4G3Paza0+Gj1KulZeG5bXopdKCwQR9VHS4UjPZe
 IqsWpnb8TyAymTgYxxj/CncU4jLkfucc12Imk93WPiv1HxoUMapxF7ek1RGC4IOIJ/wbZKRH1eo
 uMov/5BmBHP/e3EaAhKVI3Fhf2HazoiSb03vgE1g==
X-Gm-Gg: ATEYQzz4TjR28XvaBDl1ucAaTCzotkfqUvA0a1KQy5OBw8dE9FckeV13AwMeGuPR4b7
 hjJAvbuVVtx8Y7nK209LLu1Al9U2aM0LjZV0uDN9ZlFeZ4NXPaNULe1O3dwRLrAOrluDkeb2qVF
 eVm9hBc9JVfsSuvc8DdKrY/c3dSEPPpEoOt7uJFpQw7lDOxax7BuoqqGB4Df5fBH/6I9NzUy4n/
 4aMBgEl9OA5h1YQd+DTyn/vzDZYG2M+MGwgQtqTLWXU2GKn+ttdcAaWqQEwyBtdp+t6XaMVkiOh
 T4h5fUxLLnDnhbo5OlJDBeglHxJcXqZy2lUMyuC7/Bxvbqf5Fx/9Nz7jhEEA+8+UMEZ28O9zwMm
 n4wmKDYeKsxUgC/YXr8kBbe3NTcqFUNfXE8c1ucwVpLimd51/2dKoznWa9rgOlg+8bXIQ/ps41l
 dxsRAfUw==
X-Received: by 2002:a05:620a:4008:b0:8cd:8142:b7d3 with SMTP id
 af79cd13be357-8cd8142c613mr814604785a.72.1773088824032; 
 Mon, 09 Mar 2026 13:40:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:8cd:8142:b7d3 with SMTP id
 af79cd13be357-8cd8142c613mr814599585a.72.1773088823432; 
 Mon, 09 Mar 2026 13:40:23 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 06/18] memory: Shorten memory_region_init_ram_device_ptr and
 memory_region_init_rom_device
Date: Mon,  9 Mar 2026 16:39:55 -0400
Message-ID: <20260309204007.1709441-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

We can reuse memory_region_init_io in these functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/79ff00abd2eb5c304f1f00664c94784e1269d984.1772924151.git.balaton@eik.bme.hu
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index e15f931a8a..13d4e3314b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1705,10 +1705,9 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                        uint64_t size,
                                        void *ptr)
 {
-    memory_region_init(mr, owner, name, size);
+    memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
     mr->ram = true;
     mr->ram_device = true;
-    memory_region_set_ops(mr, &ram_device_mem_ops, mr);
     mr->destructor = memory_region_destructor_ram;
 
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
@@ -3762,8 +3761,7 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
     Error *err = NULL;
 
     assert(ops);
-    memory_region_init(mr, owner, name, size);
-    memory_region_set_ops(mr, ops, opaque);
+    memory_region_init_io(mr, owner, ops, opaque, name, size);
     mr->rom_device = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-- 
2.50.1


