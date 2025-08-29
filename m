Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE35CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGv-0007pH-0f; Sat, 30 Aug 2025 11:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryjT-0001R2-TL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryjR-0000Ai-Um
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1JyH2wiz5vFRYd2711N6Hwx1KpHo8g0euMCvUb8MQs=;
 b=D5dEVy0v4dg0SAzWJ4kg/q/BTjKNQdrO3XJddkMetY/n7WVGhkpdT5f1sTLjZZhegYtexr
 tKJ051Eg+HQgEaSEQiKnrbTi0WATwLOEsB2nS5vWFfD4p2/rfTPdCbaG3xqre0BD1NfOiv
 qmp44sgsdTveJx48iChPQf+F31nuClk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-W_wH6aiUOECmvybDJ2FuoA-1; Fri, 29 Aug 2025 09:01:27 -0400
X-MC-Unique: W_wH6aiUOECmvybDJ2FuoA-1
X-Mimecast-MFC-AGG-ID: W_wH6aiUOECmvybDJ2FuoA_1756472486
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b7bb85e90so12269985e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472485; x=1757077285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1JyH2wiz5vFRYd2711N6Hwx1KpHo8g0euMCvUb8MQs=;
 b=kkTBjrED4FtaveF8+jhIefh6YVIfYMvIEeeWdAyT9GktAyX653PH841ckvHURbY+nT
 QgNdNroRP+Ettyaju4/We4W09GNdcPhn9TSM/z6zMOkW4iDJpv491qfnMhDd0qFlGt9m
 GqZybACN5mi8Vn9+D643EjIt13HVEeQ02H7Q362GZ6Plzm70035/whzIB/Z10SzzTYeg
 3vKD53EpfpduwGCknK0RJIo2pOcw3e2+rz2Sx+2l0lwGK9n4WlQaVLXXDgbCe/Obieu6
 n7rIorDP8jq1YCegxMLp2+uo3vba2zrx3DAiYA+KsaVe7NmjAbj3NLb3agizoqJWdt4m
 APbw==
X-Gm-Message-State: AOJu0Yxufa1m/rZxWISt+p1jBttegMnx88svG5+iELIb/z298PKHIyJB
 TQxgIfKNdQnUceIEOQlNoQeiEWei2xHxjY1eOfOjv4HU3oRnLTwMug1VXsuMELGt7tyyGS3TTmO
 JsDN6uG1XhC3JMsmSb5+OFTsoA3aSzHn8MFFu88EaBobNomG0lkl5LkO+sV8ni47RKXFI8fVwZF
 2CBLsaveM9O7GMImD1WIABFQ+lKS0R8AO4E2HH9fWI
X-Gm-Gg: ASbGncsHeoFNzmqqsF+i3Wmu1AGrGx9prB6+ds/0aS8x074CgJo8EGpv1oaXoYsaamg
 tpg+TDxTxCKsxS/+IW8I1SV3NL8pxfY2yec+tEVOsbfOGmnQPqJuIuKefYDKfXGIAmQo0BpQT5g
 vR6WjzEvVgeDCmezHHs/k9h/Sbe/J6/933PuNyaa7aivNTOYL9KAr8smzTkSNGP8ydkm+zEyVr0
 cP9PktAZG9QvGlMe3N/93ucHX2YOhd4j2eE+1XegibOZUWFxjZIOF6I/APyeiNHxtgYpT3+/QT5
 7A1yu23Lljv5Vt8wcz5pS1jkAZTvUZKv7hXrkx0kmC1CwkVtukMQgGKoXZhVd5nk2qoLZZoA98H
 GbCp0B5dXmfikNNbaFBFVWNxdh1i0bv/MEHYtKZjrmyw=
X-Received: by 2002:a05:600c:430b:b0:456:942:b162 with SMTP id
 5b1f17b1804b1-45b6e42bad0mr65771665e9.11.1756472484780; 
 Fri, 29 Aug 2025 06:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrtRhe/ZtpJP3KGy3yiPpcs6g6Jf7QM/4IUPegPEJhbcJp9bbBWUT/eOfGDy484lyCHyLm4A==
X-Received: by 2002:a05:600c:430b:b0:456:942:b162 with SMTP id
 5b1f17b1804b1-45b6e42bad0mr65771235e9.11.1756472484107; 
 Fri, 29 Aug 2025 06:01:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc496sm3400264f8f.1.2025.08.29.06.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:01:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 28/28] tcg: move interrupt caching and single step masking
 closer to user
Date: Fri, 29 Aug 2025 14:59:35 +0200
Message-ID: <20250829125935.1526984-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

in cpu_handle_interrupt() the only place where cached interrupt_request
might have effect is when CPU_INTERRUPT_SSTEP_MASK applied and
cached interrupt_request handed over to cpu_exec_interrupt() and
need_replay_interrupt().

Simplify code by moving interrupt_request caching and CPU_INTERRUPT_SSTEP_MASK
masking into the block where it actually matters and drop reloading cached value
from CPUState:interrupt_request as the rest of the code directly uses
CPUState:interrupt_request.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/r/20250814160600.2327672-9-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 96c124aa720..8491e5badd1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -782,13 +782,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     assert(!cpu_test_interrupt(cpu, ~0));
 #else
     if (unlikely(cpu_test_interrupt(cpu, ~0))) {
-        int interrupt_request;
         bql_lock();
-        interrupt_request = cpu->interrupt_request;
-        if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
-            /* Mask out external interrupts for this step. */
-            interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
-        }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
             cpu->exception_index = EXCP_DEBUG;
@@ -806,6 +800,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             return true;
         } else {
             const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+            int interrupt_request = cpu->interrupt_request;
 
             if (cpu_test_interrupt(cpu, CPU_INTERRUPT_RESET)) {
                 replay_interrupt();
@@ -814,6 +809,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 return true;
             }
 
+            if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
+                /* Mask out external interrupts for this step. */
+                interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
+            }
+
             /*
              * The target hook has 3 exit conditions:
              * False when the interrupt isn't processed,
@@ -838,9 +838,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 cpu->exception_index = -1;
                 *last_tb = NULL;
             }
-            /* The target hook may have updated the 'cpu->interrupt_request';
-             * reload the 'interrupt_request' value */
-            interrupt_request = cpu->interrupt_request;
         }
         if (cpu_test_interrupt(cpu, CPU_INTERRUPT_EXITTB)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
-- 
2.51.0


