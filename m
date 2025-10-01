Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CCECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yPw-00013w-9F; Wed, 01 Oct 2025 11:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPZ-0000yu-Kz
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:06:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yP2-0000ev-Pf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:06:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso56522315e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331152; x=1759935952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzVIXRWuWGr9aTJxzc0zYs0L20Pybb+agvUMr6jmaGc=;
 b=IFqIhhKLs0C16+ZcGsqHoYJLIZ/wEo4/wPj7HyJ15ZkzrlLm3vxflCBX02QVL8edSa
 eEaAeAtYWc2Cy/oclB1osQv5j75XIATVcLhXhsY3N7fcQhUDdFGfez0J49MBJLdN4t6u
 8iu+HxXL+row7GHXZ9L0QuL4aim9gKHZVA4nTkINMO3L6qmGFr03rjJ7HwIJ94/rLGw3
 vzzr8ZLe3gxLNuDDUyEkUVHvMgAHa5Q/Le1ficB7mF2PMxrTNvrM7DCZ6Ji5K+KLMcPw
 t14Rf1ysM1xk9TybdZZaO2zTpMzEzTGUYz89x5qXMMVcHXCUu7n2yL0Rkj/JWilf3HvU
 SzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331152; x=1759935952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzVIXRWuWGr9aTJxzc0zYs0L20Pybb+agvUMr6jmaGc=;
 b=CmDs0HIFbcajKlyAmGPgnJnt/zcA5dOlKaU5amsYRpxlafvQftTfMWkJchrFOHjO2N
 L/zTvgd/4xme5Z2KW8GxsnioF7QiHa/rsG7srrr9FOREECmihXwnFLNI6h16rMy051u6
 am+wti6Lp/T2Wzc3h6KQp/NOR2L/zNWLGn5C6ybn5n/n5M3ZI3Zd6ZmOWx42lOhXqiAa
 yhHXtxy8edh/Skn0tQER/ORAq8PtUMwpNdoeAclo6oxzz640qRt/I1fJTQB+wQlJBESB
 6/69sk6u6o5lATNP4KxRBZn6zBIf61Pm5ZYvX/djoVxe/oVRVnB4JiaSmg/+9RqqUfiL
 uFnw==
X-Gm-Message-State: AOJu0YwLKvAR524UdJHIqTq5VvZnMORY58BSePczGcd5jozmisDCWmU9
 R3X0DE40CbNGTdJWgb1njjJQHHHIL95mIbltsQOUQMS5JvnlcschvCT+bfTZ6CO+3ur2pqEAsoJ
 /1pFfffIOng==
X-Gm-Gg: ASbGnct4Hp7QhE0Y/0g934Kanv5h8XtDB8ibXq4q0ITo8NsUllz8kGBLVz6VWSplAGi
 RV0Yzf3Y6KCkGfsTTeAYt5wMspIK+5G+QsQcqLqEjwRhrpJKRTyot6/X8i1ekNOqXEVJxJCYl4o
 BVFV4R06GsG9ues33XOcqxfkNfYcW6dtqqFiP68/eDm1U9YxxJ2nyz22zQhwuRF3Kv3n+vi8qOW
 74Vqdh2pKtkojOf2jJXcnmztLr3fT1wpYEV8xR8vU86tLS4iWUfVMxLQbKeKS1SlU1PL1HWs348
 ZfXQxnrdJC2QrcdkJaNY/f5DqvfR0xh+s8NmhOdnsCZB9DqTC3wQjt2ielszc4L2JPKS/xqTs30
 FcsCmnrN2+JAKl/GAu0cAf95uq0DG4ZHh5q8jXvVq68hIt+r/3c93ok70pkV+UzOGXKDgNlAJih
 vPwNt1LsCZbL3kHcKeYfPL
X-Google-Smtp-Source: AGHT+IFLHawgvzRRR9giVgia0mvWSnvz0hRd72bjATPATk4foHjp7wT3xHqdxQtb6jCh5XRxIdg0vA==
X-Received: by 2002:a05:600c:3b08:b0:468:4350:c84d with SMTP id
 5b1f17b1804b1-46e6125ce14mr30601145e9.7.1759331152089; 
 Wed, 01 Oct 2025 08:05:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c4c0321sm36203765e9.8.2025.10.01.08.05.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:05:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 04/22] hw/core/loader: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:09 +0200
Message-ID: <20251001150529.14122-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/generic-loader.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index e72bbde2a23..cc8eacdf067 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -52,8 +52,9 @@ static void generic_loader_reset(void *opaque)
     }
 
     if (s->data_len) {
+        AddressSpace *as = cpu_get_address_space(s->cpu, 0);
         assert(s->data_len <= sizeof(s->data));
-        dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len,
+        dma_memory_write(as, s->addr, &s->data, s->data_len,
                          MEMTXATTRS_UNSPECIFIED);
     }
 }
@@ -130,7 +131,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
     }
 
     if (s->file) {
-        AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
+        AddressSpace *as = cpu_get_address_space(s->cpu, 0);
 
         if (!s->force_raw) {
             size = load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL, NULL,
-- 
2.51.0


