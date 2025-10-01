Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDFFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zxJ-0003zx-H1; Wed, 01 Oct 2025 12:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zx6-0003wC-HD
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zwy-00089L-NJ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e317bc647so56445e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759337103; x=1759941903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=caJIjlQVI1zG/C/he2yH9f+M89HcV8DgqjfXZVRQPEU=;
 b=Q0AdXq1EJdNPvmMLbHCxOakqhyN1PTo7/LFJ+ckQqXO4PjLtOVhRqSWNl0UBG0pkqQ
 N/iJ/Pr/i8gLxaSlwsWcQ7/pgveG7tcWyOQzIhe9qTkUgLA867+Da1rb6vDty3nOewuB
 Mu2QJGRsy33KZRKmQQfntbkEpDXcVgbdmI+G6IQ7d2v0LlJF3ZXxCjToUOG8/RXB2igj
 Ec3KurU7+jrdxoJu3aKBPlU2aPhHw3m74Pguy+62HlNddQq+0bLMgCZ3xvSPgdc7AAKI
 kPKgqr/sZC7+IxUQByLb8Icqsk58EohF43FdjyYJOtm5Bkf4Am8EI1/YtTq0zhheIfle
 FWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759337103; x=1759941903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=caJIjlQVI1zG/C/he2yH9f+M89HcV8DgqjfXZVRQPEU=;
 b=Vbvr2rKT6hz8BDUpSdHin7i5JddoyxKhzMcK3KAyG3QiigR1m6k791xPpm5oMnW+VX
 FoIB9Rwe4jbXW66Qn/SF5XxDHcW0yZhdUZLLJ9X4mJ4mfzdIl2yXjpHvxPnuDQ3ZI0xQ
 CVO8APDd8mioz/ZsM2RyBe0tv0gn8Tg/lTL7liL/bT5g013yEzv216LJM53EzLOMJhH9
 mKRiFSei8gy17b48VFPMyYmmZZUorxgKguuasAQ0VRoZcHUhfjxoJP9ZsAEIpxInQnSX
 46TyIqUBiyAgnGzDnKkfjaeiP8At3B9p/f/F0clJoztlbjKuN2obgwy6Hyiq3OPVgVl+
 1oMA==
X-Gm-Message-State: AOJu0YxTlM/HIFvrOv7uwpVPvRY5VcEP33PH0BtscpTEqXFQo7ZCpIKA
 ZYdh0aDvu0+gg8dmL9Gt7mF5rSyyXvPvby0d16ceFH5pQ/w+KO5fRF95fpdirtaSv/G2AFI9nuA
 bgo12qtHDZg==
X-Gm-Gg: ASbGnctprfqBj4Ev7ClFPBz9wPNdhnT/LJYh9adU6h+HUrUduRSqebnXVJTho8JAJFH
 hBIvSg4lTG2VlQqM8Q5YBOn1VDcwCjTLhQzVQxCwYCi3YZ05Jeg9ZhUXB2pwJb4DIWUQCkPlZmO
 fH0PNetJKPP3TVXqJCMyw764P8hCbwhD5fMTo+nZEVngesHIRWY5APkGbnn2yZaIEB1+NXw/zbM
 QpaWzZWL73f9xGtIRF1L7hleg1uPqJLM6iz6opiSsd4TRBsEJYsd3fEj8ojZ4OYRgeQwfsWrbTA
 fRUmraWMEVC2qgptAsmajko5+2N1Zn0YXusT1YF++fnjIkZvSmmSgzuW89bzRIwi2/3alUBM1m0
 j0GUoy4kaJtBCQRrDqNc8eoihE6KgfI3LtPXPEoC4TdMBERwOEebhBPCmAps5DNthqcTNOhrUZ0
 zSnEcRDwOF3YXTHUb9UOKG
X-Google-Smtp-Source: AGHT+IHSXLf/MaBMGoP1ipyo6HIx1farhws9Inco9aGTj7aaRrCeY0cgBMm3s7sKT+uA83mkq0UQnw==
X-Received: by 2002:a05:600c:1f8c:b0:45d:e5ff:e38c with SMTP id
 5b1f17b1804b1-46e612daeccmr28760345e9.32.1759337103419; 
 Wed, 01 Oct 2025 09:45:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b5f3015sm41174145e9.1.2025.10.01.09.45.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 09:45:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/6] system/ramblock: Remove obsolete comment
Date: Wed,  1 Oct 2025 18:44:51 +0200
Message-ID: <20251001164456.3230-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001164456.3230-1-philmd@linaro.org>
References: <20251001164456.3230-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This comment was added almost 5 years ago in commit 41aa4e9fd84
("ram_addr: Split RAMBlock definition"). Clearly it got ignored:

  $ git grep -l system/ramblock.h
  hw/display/virtio-gpu-udmabuf.c
  hw/hyperv/hv-balloon.c
  hw/virtio/vhost-user.c
  migration/dirtyrate.c
  migration/file.c
  migration/multifd-nocomp.c
  migration/multifd-qatzip.c
  migration/multifd-qpl.c
  migration/multifd-uadk.c
  migration/multifd-zero-page.c
  migration/multifd-zlib.c
  migration/multifd-zstd.c
  migration/multifd.c
  migration/postcopy-ram.c
  system/ram-block-attributes.c
  target/i386/kvm/tdx.c
  tests/qtest/fuzz/generic_fuzz.c

At this point it seems saner to just remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/system/ramblock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 87e847e184a..8999206592d 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -11,11 +11,6 @@
  *
  */
 
-/*
- * This header is for use by exec.c and memory.c ONLY.  Do not include it.
- * The functions declared here will be removed soon.
- */
-
 #ifndef SYSTEM_RAMBLOCK_H
 #define SYSTEM_RAMBLOCK_H
 
-- 
2.51.0


