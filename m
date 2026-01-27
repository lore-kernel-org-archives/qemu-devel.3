Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FCED2D8C0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXv-0000ld-Dk; Tue, 27 Jan 2026 04:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXb-0000dA-Af
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXX-0008T8-7e
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMUlDVYnp9svL9cIfpMxQ3sjwT9bmDWj45k7ba5H9xU=;
 b=ApapxwDW/d77qDdS0OrzKg2kQFCPV5+nO/mKMkBNYObTJiHJhQPm6vYgFmByMZkOq0dBI0
 TeAXZIYJKbnchAQNUesKps/g1De3KAf86zddhg3qtMjbn3inFvRnKaKF4oTCwBpsCwPl1A
 k0qTksvcemliybZGTnhT9GdrsY1TdPY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-SsCw4JVgOqWa82DqY8wsDQ-1; Tue, 27 Jan 2026 04:39:12 -0500
X-MC-Unique: SsCw4JVgOqWa82DqY8wsDQ-1
X-Mimecast-MFC-AGG-ID: SsCw4JVgOqWa82DqY8wsDQ_1769506751
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so95603775e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506750; x=1770111550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMUlDVYnp9svL9cIfpMxQ3sjwT9bmDWj45k7ba5H9xU=;
 b=onddjT2WAFMc/PSZaLi73rvbyAYC4mea4IHtt0L0ScfRDF33JddfWXvC2G5ybn3QtW
 DkAbfkt6Z2ZFsjY6Ym7aBxVD/QaiqVF5+Ipo3uZ9/XYUXiarRanWIgMm0R41suzB8s+g
 UOb6Btw0phFhhphwiCXipMbVuGl9Omt1GQqV2OucokJyNBX6wMFTCs1LHttuevjMu8Ep
 J980XVIYiibZ/Q8P/Cm06FFS6EQnXZ62wrDhq+ZqXfii2aG/beLDL9ppVuMgbY/eVZm0
 5LkD8GDRXp7S1s33eS4H7RwYfLxYTSqjGyDcXZNJ3Lc5ic/KYDgT1crr5o31jAIg9rOB
 htYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506750; x=1770111550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SMUlDVYnp9svL9cIfpMxQ3sjwT9bmDWj45k7ba5H9xU=;
 b=YdZGMK2Gjb0Ta+56+NSpOc1tu8NT69g+LEwKKGwOYBE0GgJC0ERbss4LKtvuS2kkPM
 UyGTpjSWPuxPTGA2qoVEhoqadNpqOI9t6a+HgWWLjfu9Duo53H9VY+dlLwqR0JNcVdtM
 2Xs5xPC73m/s4FpYisNSwaFRmEMeud9zwGZC4fL4QoDk90vEMb/MVMe90ALc+sV2gVZZ
 +nmEW881E4ryopGQ6ZgJw0mNEKIoagyHkJKOrfF3TrFKaZukJVTCBoxiZrP0rkJmqD7o
 B/7mZXEkyN6uuTQ9xQro+NykUNPEGzNr3GJT5VvtwDkwhyRahAlcNWr1i0odF9WvN40l
 K5ig==
X-Gm-Message-State: AOJu0YycvBS7hEDa0ToLf0txmcMp0DUp4TW4QsYFn32zyrN316pPNQjP
 BHVqrz5A5BXmIj25aEGEDABHtgdMoNnE2XHiu86BwZuvtJK5povM0A2sQuETVaVb0l0ixX+ZQqK
 co2QJYKlaKrxvGJKwpDh0JPYPV/ZG5jr6aBJLNWVtQyDQFF4LW2D8953XxoMbqF97ct1FQGff9y
 CqvDrpI7FyqLvxXlyIHvyQ/R/iDbUZGmw2y/VkP3gR
X-Gm-Gg: AZuq6aJ94yslwkIuMb7z9QadmNhkW5f72lPEbnmM0/HCIz9Ul0fqtK9Lr1aFSZdTqql
 9yA+6X7ZUQYaqT9LUpGGuBdqdXvSXHkLuJ6RITEvOZ+0yQSvFfD4liBolrpY9U6+FosPrknmRna
 bwlfBwT0wOXC9XdjuFxiNvdv3KcUPdTiH94WaAhUEw9pgHd5gceFxJU0tkvrqTQVAmjwZpWHg2c
 gE8ujfxfP8zsfMlkRs5pcM0UUmFy8zUF3y95ZZ2062gv3FkeNNdYo3hf2KV2KKgkIBQ8+DU9lYe
 ckkniw+bf93G5YM2uI10GAk3iLlWPWcwy4a1EckCa13KKL1LDnCXwkd44bU8wEwjkRb7TvZkdAK
 ymWLQQqmsgkFiKdcSnWtMFnTMJFA1JpeWoYORTozP4IWadrrzC1vWQzR7/9V3FfutRW4BTXIk57
 paSN1N7lK95cOM0g==
X-Received: by 2002:a05:6000:428a:b0:435:91b6:f53 with SMTP id
 ffacd0b85a97d-435dd02450fmr1411006f8f.8.1769506750268; 
 Tue, 27 Jan 2026 01:39:10 -0800 (PST)
X-Received: by 2002:a05:6000:428a:b0:435:91b6:f53 with SMTP id
 ffacd0b85a97d-435dd02450fmr1410966f8f.8.1769506749828; 
 Tue, 27 Jan 2026 01:39:09 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a8asm36538404f8f.12.2026.01.27.01.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/13] rust: trace: libc does not have syslog on windows
Date: Tue, 27 Jan 2026 10:38:54 +0100
Message-ID: <20260127093906.353741-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/trace/src/lib.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
index c2abe430a52..859d8d1b94f 100644
--- a/rust/trace/src/lib.rs
+++ b/rust/trace/src/lib.rs
@@ -3,6 +3,7 @@
 //! This crate provides macros that aid in using QEMU's tracepoint
 //! functionality.
 
+#[cfg(not(windows))]
 #[doc(hidden)]
 /// Re-exported item to avoid adding libc as a dependency everywhere.
 pub use libc::{syslog, LOG_INFO};
-- 
2.52.0


