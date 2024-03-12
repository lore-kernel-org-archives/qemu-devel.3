Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68361C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8Wx-0001mM-BR; Tue, 12 Mar 2024 16:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8Wq-0001ly-AU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:15:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8Wo-0001LZ-5W
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:15:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4132f780ee2so1408525e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710274510; x=1710879310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gs5HlW/Ip3qFcJbnSXOPguk0JHRri5DnrCS/iUDagd0=;
 b=kriJGLY/pDR0v7aiAz4MkeEwo//oQNgN9BAJakpBYKJx0AC8+b/QDThdK31LYWTcec
 V1tqRojKl105VqCVekvp43VAJqUmpSU0dvyySE4w/d5wGx4nQA3XcFZb5q8z5SOjgrn/
 41GQieRG+Aeu+TV4bfvlEVK7qg6Lzg96YLmW9+iGzE4XmT1XSgTDLLACVTP+CC9QaBTC
 fVjsNPJtr7P5Bg/BlesN61z1GlUvqzBv07ZW2R1T2gIRidixLpqQe0dB9R9k7dqWl14B
 rrtd2qCDEDAJj3HChTr5+Wayc6rY8dIzZK1pAmma2whfWpBhRxCG28AXloKb6c76SNt0
 QWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710274510; x=1710879310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gs5HlW/Ip3qFcJbnSXOPguk0JHRri5DnrCS/iUDagd0=;
 b=NR6Tkks4V3HkYRlQ1bSkD0rfcQjErD3rsNmKd2c0BamGWi2aYF9EjIJrrKieJ0SVjc
 ujdT1sRpLuvukhIFOckUSMYlTqEZhZvLXuabutE3pn7YYLk3nSb3NRiEZKD2KViRcOf/
 OzICF5Ksm8rMFMsWzyH12JUaTt0ElBMmZmtYuGCZRQ0rthLeTF8JVX/KF8Go6baFpfNO
 dSl6SqSYalagaoaOl700Sf//7n/neUoG+NVSWSI+u9EnRp/1xlc7fqd7R1masQfIBYZr
 CNPc2oUZHHanTaS+1WP+79cmT49ASYNbQ/G6DtkFV+/ums07uSAjYcE1peUacJJd4N/j
 /blw==
X-Gm-Message-State: AOJu0YzyJyTVoPzCpDUhfqXm0AkwGnalKv/Kfwjjr7bzgqmZpYMRUpib
 r94qsh2T+UaZHrZv9kMGo4gcUvuUkdBxG/Ab4vyA/FlO626EgjY4pW8W87OZ86DMqRAlJwQ/vL4
 g1cM=
X-Google-Smtp-Source: AGHT+IFjZAd83dMgNuXQtiAWrZHnUnF2LKvMmOsD6m/cQY5bktRJZsn11IFGIB5hk7X9B9sEpTl3Cg==
X-Received: by 2002:a05:600c:34c3:b0:412:c379:606 with SMTP id
 d3-20020a05600c34c300b00412c3790606mr534888wmq.2.1710274510026; 
 Tue, 12 Mar 2024 13:15:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a05600c45ce00b00413177c3f1dsm13194769wmo.18.2024.03.12.13.15.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 13:15:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 1/3] physmem: Expose tlb_reset_dirty_range_all()
Date: Tue, 12 Mar 2024 21:14:56 +0100
Message-ID: <20240312201458.79532-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312201458.79532-1-philmd@linaro.org>
References: <20240312201458.79532-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to call tlb_reset_dirty_range_all() outside of
system/physmem.c, expose its prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h | 1 +
 system/physmem.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index ce36bb10d4..3e53501691 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -655,6 +655,7 @@ static inline void mmap_unlock(void) {}
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, vaddr addr);
+void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
diff --git a/system/physmem.c b/system/physmem.c
index 6cfb7a80ab..5441480ff0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -819,7 +819,7 @@ found:
     return block;
 }
 
-static void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
+void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
 {
     CPUState *cpu;
     ram_addr_t start1;
-- 
2.41.0


