Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2D1C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKLe-0002rP-RX; Fri, 09 Aug 2024 03:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1scKLZ-0002Z7-Fn; Fri, 09 Aug 2024 03:47:38 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1scKLX-0003Nx-2S; Fri, 09 Aug 2024 03:47:36 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso1495003b3a.3; 
 Fri, 09 Aug 2024 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723189652; x=1723794452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L0M8bij2ao9KOi6QNbQTB6QgOeCuajB979exbMPBzyg=;
 b=gZhhuZcZXV0AROQgEgrGVNXINie3v02i2CeQ07bU5V8Vv85u09JWyuagPG1me1WIk/
 bDh2jnJo5ejLkU1h+8oGzdb2hd5yMBNe6NBB/mI4RIhAimj2KP13TQgaDMZ9pvshAedV
 /ruM6PcATandoRsDhV/K3HQ2nLhUZODEXSA29EL7xOsZ8uY/5hQfnYmWHPrj0De2Bq5/
 vzJ8EJsqHPBtSJn86AQECEYL8RgenB90iAEKm0JHLS3tJQ5rbUPuS+dZuIQgqMFs1RVL
 8dMV4wZFO9j10cI7A3uru8ZYFaoQqkBhFbTQNfTW10sajnPuYzfAUdKgTJtfeh6z9ZTU
 hzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723189652; x=1723794452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L0M8bij2ao9KOi6QNbQTB6QgOeCuajB979exbMPBzyg=;
 b=m0y33HWBPbX7LaqqEHx82+2Iq+I+D+mRoV71umzjD+yKYAczT2vHFd5BR6vAtrX50S
 pKdE4/2asnOyGCNqYyb9bEM77HIxDV40nbls0dhRGpzK+GbG/SOagJooovMxUnQxSTQN
 luSN/WLb6gjj8x0dp0ZpMm/1Fc2MTU7pynjkgvLXrBnQdHuF3yx5Bsm0UtLIsH4bOtP8
 88NmuRpRzW/gPg+0fjeniTMU7VxkyRm77YjTcvMdYUDSpXxJNxGnzGuQ+n71gO65NCvf
 VTMyPKa9499x1y74r48QrVGgQpycL6Fo/n8iCPo3E1BnEo/ILeOSPqQREedLoGP7zzCP
 dU7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNs3vX0YANxci7RFQQuW7CeSzoXoTsTH03Q/x8GaNvdlr3AwLIjwW/kZUfNZst/hd2AQREwOQSwK6KvjYISNg34aUO
X-Gm-Message-State: AOJu0YzO+4q10xTIswQodkRlq7mjSVxEbsMXuSposJmf/oZ2F94xurGd
 /mImIvBOROV+PHyaGgdKvFvltZd69TuvWzet+e8LErU1zAZDldtsaHMMsA==
X-Google-Smtp-Source: AGHT+IEfKYV6VB4sANYB2LczblVP7a0VKvVNTC4L8H46g/Qi+w/D8tsKeFDliTDSSA3ENEngKoyvTw==
X-Received: by 2002:a05:6a20:9f48:b0:1c2:8b95:de15 with SMTP id
 adf61e73a8af0-1c8a0242cc2mr937096637.53.1723189652048; 
 Fri, 09 Aug 2024 00:47:32 -0700 (PDT)
Received: from wheely.local0.net ([146.112.118.69])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5929839csm136531065ad.260.2024.08.09.00.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 00:47:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] accel/tcg: clear all TBs from a page when it is written to
Date: Fri,  9 Aug 2024 17:47:25 +1000
Message-ID: <20240809074725.320801-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is not a clean patch, but does fix a problem I hit with TB
invalidation due to the target software writing to memory with TBs.

Lockup messages are triggering in Linux due to page clearing taking a
long time when a code page has been freed, because it takes a lot of
notdirty notifiers, which massively slows things down. Linux might
possibly have a bug here too because it seems to hang indefinitely in
some cases, but even if it didn't, the latency of clearing these pages
is very high.

This showed when running KVM on the emulated machine, starting and
stopping guests. That causes lots of instruction pages to be freed.
Usually if you're just running Linux, executable pages remain in
pagecache so you get fewer of these bombs in the kernel memory
allocator. But page reclaim, JITs, deleting executable files, etc.,
could trigger it too.

Invalidating all TBs from the page on any hit seems to avoid the problem
and generally speeds things up.

How important is the precise invalidation? These days I assume the
tricky kind of SMC that frequently writes code close to where it's
executing is pretty rare and might not be something we really care about
for performance. Could we remove sub-page TB invalidation entirely?

Thanks,
Nick
---
 accel/tcg/tb-maint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index cc0f5afd47..d9a76b1665 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1107,6 +1107,9 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
 #endif /* TARGET_HAS_PRECISE_SMC */
 
+    start &= TARGET_PAGE_MASK;
+    last |= ~TARGET_PAGE_MASK;
+
     /* Range may not cross a page. */
     tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
 
-- 
2.45.2


