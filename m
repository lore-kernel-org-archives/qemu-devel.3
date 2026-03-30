Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A482710D14A4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7BAs-0005jA-8d; Mon, 30 Mar 2026 07:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8s-0003bi-2j
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8h-0005wT-30
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQN6BGEz2uMzaWLtnDgvxzEtfd2FYHTGxTkLOU4YzLs=;
 b=edm1RASeyoHcRT6G+QtOYrO9Rf34L+1nroTb5u680JDhO/aP4wxW46PwpYrNBkGkiSS0zH
 mKNQH5nR8uvEKBbWQaEo0WMmifUFH3WtqBzQH23MJvnwPXgRJk545xT7iBFzT+pMhkO5pq
 UmCKfAQeYYWdWwdn0JO88YquJeBwQoo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-76Xfui6XNB-bZilV6tSgVA-1; Mon, 30 Mar 2026 07:50:36 -0400
X-MC-Unique: 76Xfui6XNB-bZilV6tSgVA-1
X-Mimecast-MFC-AGG-ID: 76Xfui6XNB-bZilV6tSgVA_1774871435
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43cfe9aef60so796746f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871434; x=1775476234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nQN6BGEz2uMzaWLtnDgvxzEtfd2FYHTGxTkLOU4YzLs=;
 b=GGJ3IHvnTtGve1Myd91lMln2vUtLdhXvOT6eraUAznTjQ7AAHzjJvMp7SY6MvxskaC
 qVNsXYYoesTQHBPb/C7cyH4YQFNydKaVf7LyZAonNUNBW0N8U8qaMPT8qEjeW+c4O4/+
 AnWiFN1XFwk8YIBfIkSmw/xWb6qXcxtRkJMgrt614tz+jCEpysM/O7+mtyjUf3IL7BQB
 xrLItjLYi+G+byKYMAiSeO8XRp98GkOfXnBavYhrOl8PVuOvhbaWTcaM5R7+7QfOROBj
 jHdwUiwFf7oPfsJb6tVngYQm3+dwQdkNg2BtLwXRyinQUTCyZOhWQBau9a9UX4qI5ufF
 cbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871434; x=1775476234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nQN6BGEz2uMzaWLtnDgvxzEtfd2FYHTGxTkLOU4YzLs=;
 b=rLpeN+RegQmvTOBzMwOq1JyfsGCmmSO+Z78XZVr7/aVxS1WxDCHudEYb4A0FapLqsw
 8FgqlfSgkJ0KTZXdN0GAbE74ArRWbdSa8gfQgkcx7hUOSftuX9eXJlgZ2wjfXpMFBxPA
 Lto6zjufIqcdaI2KatjRKYqYaA4FygU2naZAi9HeC8i+WsUgh9OsMIswRv5Oe9SB1Og6
 t3Bwc5i93E9H8Fkrelfcsmx+NcSMq/onzH/TAfkjgIDkIYGHQd5zb+sQ7rUbgGw4H00V
 f+iEpyQh+g/RwlyalaZhRJu2DDc4gJ8iSLQQGz+7x54etKqNy98kJXaVZai4clVmNPu5
 kAGQ==
X-Gm-Message-State: AOJu0YzUxWDsvNCSfsS82QII3fVjWEVWD/JvpxsIDeuMl5Wti4dXT7D1
 KcfAICEUynSjzVb9pfHIRdxPYeDwiK0NM2lEj4ODP/LRSM9kMVw9xH1aMxk8LGlAb3XfBUZ8aaJ
 U4nzPAiUaTXRgrIRqi1gMcPGQ1ppa/aTmjkEFdtkvcqyQShclRNOG+iBjU4qjoVU48AE/7FhJ4N
 AssySoCTBfErg8bcj6JaaulJQGDD0FyS6l6+9iqs83
X-Gm-Gg: ATEYQzx+uaeLWEOYrE7fc5PGgo3xdfe9mKF2b697X44yQfJlQneMuJsPeA3YskvwmyB
 RetBhHakcq4sfLDkW1Ob3ZizX1n+f39Wx6fZjjgSbq8RCDR2QIrVNdHNu6OG8zdO1gV7qtvTN6K
 nVtl+7bEHWpJzMOaf57n+eBJ0vLoP05biWJ5wcb+7B+rzc3MtKCl409it+lNIM9vi2eJnh+gjAL
 A9Aw9Iu/CmU1w3HHLeRrObAj5nCNz02dMLLl/srh98+6XLiFmNW3+Sug+284H7Qth91mgPM33im
 hKR5hWOEzxSGbnt/FYvD9qW7I+UZUKFPkmgVCXHPRTDy4a4JsQG/JCprh8ckJBODh2ww8uNse3u
 6ogX6/i2UAfW0QrOdtrf+SF7TV1b43cBdY5ftrrxzmEO8K4YineX26NNlSdNUbePvuPdcUjtJIC
 vAT8UmgqPIVSFGA6WmlqttvM59
X-Received: by 2002:a5d:66ca:0:b0:43b:f322:34e1 with SMTP id
 ffacd0b85a97d-43bf3223544mr12989094f8f.51.1774871434564; 
 Mon, 30 Mar 2026 04:50:34 -0700 (PDT)
X-Received: by 2002:a5d:66ca:0:b0:43b:f322:34e1 with SMTP id
 ffacd0b85a97d-43bf3223544mr12989040f8f.51.1774871433974; 
 Mon, 30 Mar 2026 04:50:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf24707f2sm19331841f8f.26.2026.03.30.04.50.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] hpet: lower HPET_MAX_TIMERS to 24
Date: Mon, 30 Mar 2026 13:50:10 +0200
Message-ID: <20260330115017.256211-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Each timer block occupies 32 bytes, but they only start at
offset 256 of the 1024-byte MMIO register space.  Therefore
the correct limit for HPET_MAX_TIMERS is 24, not 32.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/timer/hpet.h          | 2 +-
 rust/hw/timer/hpet/src/device.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index c2656f7f0be..84be4c3529a 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -22,7 +22,7 @@
 
 #define FS_PER_NS 1000000       /* 1000000 femtoseconds == 1 ns */
 #define HPET_MIN_TIMERS         3
-#define HPET_MAX_TIMERS         32
+#define HPET_MAX_TIMERS         24
 
 #define HPET_NUM_IRQ_ROUTES     32
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 0a5c131819b..ec0bca4496d 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -32,7 +32,7 @@
 /// Minimum recommended hardware implementation.
 const HPET_MIN_TIMERS: usize = 3;
 /// Maximum timers in each timer block.
-const HPET_MAX_TIMERS: usize = 32;
+const HPET_MAX_TIMERS: usize = 24;
 
 /// Flags that HPETState.flags supports.
 const HPET_FLAG_MSI_SUPPORT_SHIFT: usize = 0;
-- 
2.53.0


