Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C2CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Eu6-0006rg-UY; Thu, 02 Oct 2025 04:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etz-0006mN-SQ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etg-0000tG-K2
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso577076f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394549; x=1759999349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpGUqjX5M0j82QXVYXw9oJFFwSK+I6Ya0azNIIXD0n4=;
 b=noIFvRowyZa9UA4ULua5VxaiuWO10sMANzTaKlOgoe72Jb1sUCyiFFksWwzDS3i5lP
 +U3mZBaQr2OCjxOUvEEefHOUDGnZrmvMQdUv/utaJHxDnmke8kwTfms8wduTHRsTQogd
 kneQYZacJQKqDzAr8J/uTrIxw/HkdLzGBUCwAjTHNLEQu8BUwteXqGqBjRdJOjauOuzd
 l/foHNMzKIibI+1jVMAjS5IHTZltBcP6G1g7m2NK7THKtv1m1GFkBECHP95xECkONZ0m
 Go/y73RmeTzxwipngFuDEhW23xu/LKfRpg7LGqoi0KB9opMr/3pujZj6iar4BGkyhaif
 /Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394549; x=1759999349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpGUqjX5M0j82QXVYXw9oJFFwSK+I6Ya0azNIIXD0n4=;
 b=wO7zwGZa3YElxWi3E2yHz/jdYzjFFUS3KeHePGLizAth/9CaOBD6I+Pbju68C8/lal
 erap/JyUOjUaJP35apJezqBJj3yki6taxurEr6le0K8zlaJFlQoxFeKOTQD0jTfsueBc
 uk8pC3To7WrJxTbRsEQC3UwlxVxuD6foH6E+r+MO2G8qqzdJNMEnmBz7HLMohIfNlqHb
 knKqsynB2D9KL2zTRkpal7cLZXwz+9jh1GPyo2Y0dJDHGXxmqCVhFso380ylyOrrzY+Q
 FwzzERfC7DlP/qeUkMb7egaBVDJtDv1c9KOPu3nppTn8nyf8icS2LbBqbnz5B4de07rQ
 UKBg==
X-Gm-Message-State: AOJu0Yx9kzEAbdplhE8CMLceYcnGIwigad8eLid7eh0xV8TPOMeZ36Uz
 3hWk8jI79+xfkUkFXnEMTzQf9HvEyEMBXgmFe6ola+eTdYxEKcThIEaNVIv9Br8sieBpEAKUMY0
 tH0twmDCHvw==
X-Gm-Gg: ASbGncubS4sOIc0Y1srt+TckfL0Mf2RXS8bPtAeLLXA9wx9nupD0lCq8Wzq8o7KR1XO
 BaHFgI6e6F1MaysvK1SvlUkiAd+iANEmyH+tjqOa3iUsb9gPncYZ8s55yhym+BUe148qMVHkRea
 1KcWWkMedchUibr2vndJWs4+OkU2hlYhX/KCAkRP11wRHtzvNC5SPLOOgGbpJrEU40IUrROhs/Y
 3B7EFZAEGWz1928mYXWyq6E4JUi6aaN3aUqpYi6v8+og53BmddyZznd+edMadgRKv0IMkfDOatW
 29OM2UsRP0ZCnrQUv/dI3VFbSnNGPTpje+tfoaec109fjLKYJW7uNHWCNUUXEpDbJJxl5BP1foV
 LCDa3lhoCyWYRcgjjXkUYxWLma33PR7EIso4rvyzTPdPXbsHDb51gsSL9ItqmSZHv5iHTXoBctQ
 T0thJraTiESv+R9A6MYHGMCBSqq+RAIg==
X-Google-Smtp-Source: AGHT+IHnMMvrULFyoGLvyWEYNdN7opPAO0EOueQAPseRRuabHvxN0jtL5dWb3pgTDAuMakOX0VTtNw==
X-Received: by 2002:a5d:588f:0:b0:3e2:4a3e:d3e5 with SMTP id
 ffacd0b85a97d-425577f362dmr4449090f8f.22.1759394548791; 
 Thu, 02 Oct 2025 01:42:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6917a73csm25459055e9.2.2025.10.02.01.42.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 05/17] system/physmem: Remove cpu_physical_memory_is_io()
Date: Thu,  2 Oct 2025 10:41:50 +0200
Message-ID: <20251002084203.63899-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

There are no more uses of the legacy cpu_physical_memory_is_io()
method. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 2 --
 system/physmem.c          | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e413d8b3079..a73463a7038 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -149,8 +149,6 @@ void *cpu_physical_memory_map(hwaddr addr,
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
                                bool is_write, hwaddr access_len);
 
-bool cpu_physical_memory_is_io(hwaddr phys_addr);
-
 /* Coalesced MMIO regions are areas where write operations can be reordered.
  * This usually implies that write operations are side-effect free.  This allows
  * batching which can make a major impact on performance when using
diff --git a/system/physmem.c b/system/physmem.c
index c2829ab407a..4745aaacd8f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3763,11 +3763,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     return 0;
 }
 
-bool cpu_physical_memory_is_io(hwaddr phys_addr)
-{
-    return address_space_is_io(&address_space_memory, phys_addr);
-}
-
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
 {
     RAMBlock *block;
-- 
2.51.0


