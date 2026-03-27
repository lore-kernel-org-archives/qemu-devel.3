Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5C110F2862
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6BHJ-0003oV-6v; Fri, 27 Mar 2026 13:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6BH7-0003ns-1p
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6BH4-0005fD-6r
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774633627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5fKt7A2FD1i1SFTtrZ6g0b8Qc8madY+JGGQ0SAw4LSg=;
 b=CpeKwy1Wr/AbWEO74xrM0GbVG0T3CA76undHzBdOxuY7b+s21priIRGmsLT247e7lHN61Q
 YresUbtW7qfmPZzzFuSv+FzBJX2I3T3J1xXS0OhBg5ZKjcnlaAg6w7T3wu/ziDGYqQd7pk
 bPW4R4pBJPDJqCNFBeYrWVUCqV8XTPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-LQ533YzCOWKEVpZ9c_IFVA-1; Fri, 27 Mar 2026 13:47:06 -0400
X-MC-Unique: LQ533YzCOWKEVpZ9c_IFVA-1
X-Mimecast-MFC-AGG-ID: LQ533YzCOWKEVpZ9c_IFVA_1774633625
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b95f9f837so2092345f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774633624; x=1775238424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5fKt7A2FD1i1SFTtrZ6g0b8Qc8madY+JGGQ0SAw4LSg=;
 b=rCUdbCQKrFFnGOdtCoHpSoiy5o2MwYuo2+6Hy0GSJkPKCWe/8A2f7kj1SRet563NuG
 EMtCrIKsp8sEj13OQaymke/fNrCeiDJ7FbjV9+t8b0fKfpkKjkv08gn+yDmp/vGKf/7a
 pP5dJ89aZJrugXu21QZaBwNKgqI2LniWgjZknX2XCFprOv1Q3tdR+VEXfASh3RjBmP+k
 7VE+IYi4zE/tNzM6fJ9ESKsww4n9Kq5S291gctwsN+Z/A4gnX6lMKjLtrmsHv2udwnLh
 a6vekSGKuFAhmJDl9pWRca05VXBzkXrN4peupLXtu2cwtvJ9dGRT5IQbuXayucvHp2nF
 iyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774633624; x=1775238424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fKt7A2FD1i1SFTtrZ6g0b8Qc8madY+JGGQ0SAw4LSg=;
 b=VF+0CTFdfT8B8N/dIh/tJBZD3xwCyL06a9QeFb1diT3EfpjKgBLzyVyW0JN1rYsaJL
 HOY3TA7n6kwnNcuvzuINEMKFZb+tz/XV5lS3Py9KSTs7J4NmaDVPdro0riZ+Q4t8CsSR
 M5at6wGiQRDFLRfI22Vn3FX0U63+L2zOotIDGLo8XIguYzA+MnHMzdoz1uEB8OpcxMsw
 hWfvhll+8jluBLU8HZxve0Tbq5xXOqL90op1El/Jg/UqbstwgmIGjNHY6izLCPa5/Mo1
 NbCXcm+myccQZcJGWf5m0xuw2jNNt955lBOCE9OsqR6m2YIXfvKtapH0TbBMOaw2qFJf
 IebA==
X-Gm-Message-State: AOJu0YxHJe0NztoDUy/U7CNUo5j6B1RMhyVRQipetQgd/WPdiGoYW+VP
 GrmzaPBlrLPzUYlcBLHb8n5jEb6r4blY2hDTPBnkJtdv3uXIF9o0c1VbdrC0xKyNtjB6udRA75x
 j9vdUtXTz3wKphGyv2hgPO+D9RxziD4UVMApG+MDor5Ouls9MxOoGGcEuQwDYR/VBIHyvCZPfMt
 jnZPlZJFW9tcAI/4UNbQfTLw/JyfeLBmPDdBthRy/U
X-Gm-Gg: ATEYQzw0CnGv8ulQLQBg5rxivVdsee17XcuqCqM3Pg5oeGXvy70tVwidnzlXdooFPYL
 J/M+fTlCHD5wjm12LoVHLHFHYuxHUtHWHSW4c4BoqZlmFrhsUQYBJ+iordxxagZWa0aet/ioAzI
 ozY8GbQbTFgPpclVtlGL+I9BDwW+bU5PsPYoe03Xbkg9jZ4IvmlGsgE9ZHnfpdpUxdApq24Gxac
 YsS9pGEfrYHl1masx9MFZGZ+r3ZA/62ktQc7DZiYQ338Hzq9x1mjMYKEk0PlTCLkrB1r2M92jsx
 RaZqHEGS9zlNkoKiG9VuyYokflOdllgPox5TanUP6rFpmtSyuRoQvu5aaW1LYYyRXyePRF6Tw6r
 NsqxKSwToHgF4mLlaELxWJD/DHjr8NyvK+5GCihSb3+QiS4zxth8oDjy+d6joSFAQ23iuwJmQe8
 h0Vd2PmirsmIrDAlAmQSGTfOgz
X-Received: by 2002:a05:600c:810a:b0:487:2e8:69c5 with SMTP id
 5b1f17b1804b1-48727e909b0mr52629385e9.15.1774633624206; 
 Fri, 27 Mar 2026 10:47:04 -0700 (PDT)
X-Received: by 2002:a05:600c:810a:b0:487:2e8:69c5 with SMTP id
 5b1f17b1804b1-48727e909b0mr52628785e9.15.1774633623615; 
 Fri, 27 Mar 2026 10:47:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91942f24sm17268571f8f.11.2026.03.27.10.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 10:47:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Yuma Kurogome, Ricerca Security, Inc." <yumak@ricsec.co.jp>
Subject: [PATCH] hpet: fix bounds check for s->timer[]
Date: Fri, 27 Mar 2026 18:47:01 +0100
Message-ID: <20260327174701.364328-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Fix an off-by-one issue in QEMU's HPET read and write MMIO handlers.
Both handlers check timer_id > s->num_timers instead of timer_id >=
s->num_timers, allowing a guest to access one timer beyond the valid
range.

The affected slot is initialized properly in hpet_realize, which goes
through all HPET_MAX_TIMERS elements of the array, so even though
it is not reset in hpet_reset() the bug does not cause any use of
uninitialized host memory.  Because of this, and also because (even
though HPET_MAX_TIMERS is 32) the HPET only has room for 24 timers in
its MMIO region, the bug has no security implications.

Commit 869b0afa4fa ("rust/hpet: Drop BqlCell wrapper for num_timers",
2025-06-06) silently fixed the same bug in rust/hw/timer/hpet/src/device.rs.

Reported-by: Yuma Kurogome, Ricerca Security, Inc. <yumak@ricsec.co.jp>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 767093c431a..42285cff762 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -464,13 +464,14 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
         }
     } else {
         uint8_t timer_id = (addr - 0x100) / 0x20;
-        HPETTimer *timer = &s->timer[timer_id];
+        HPETTimer *timer;
 
-        if (timer_id > s->num_timers) {
+        if (timer_id >= s->num_timers) {
             trace_hpet_timer_id_out_of_range(timer_id);
             return 0;
         }
 
+        timer = &s->timer[timer_id];
         switch (addr & 0x1f) {
         case HPET_TN_CFG: // including interrupt capabilities
             return timer->config >> shift;
@@ -564,13 +565,15 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         }
     } else {
         uint8_t timer_id = (addr - 0x100) / 0x20;
-        HPETTimer *timer = &s->timer[timer_id];
+        HPETTimer *timer;
 
         trace_hpet_ram_write_timer_id(timer_id);
-        if (timer_id > s->num_timers) {
+        if (timer_id >= s->num_timers) {
             trace_hpet_timer_id_out_of_range(timer_id);
             return;
         }
+
+        timer = &s->timer[timer_id];
         switch (addr & 0x18) {
         case HPET_TN_CFG:
             trace_hpet_ram_write_tn_cfg(addr & 4);
-- 
2.53.0


