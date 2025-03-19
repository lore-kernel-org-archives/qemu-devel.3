Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE2C35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy4c-0000rm-BJ; Wed, 19 Mar 2025 14:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4M-0000GW-L4
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4E-0006Oc-RK
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso47006465e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408581; x=1743013381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=442Qfc14sV8K9qojXAxlMgXPGGQ/rtu38D2XjLogGHQ=;
 b=eFwRQ4oTle86EKReP+4m+q2mOQ10zSH0KGd5k9T2+ZUiVcbYRWh3vb18hZaupJS5Ed
 iRbIyVkFQwEvyUo5D02jLZfIxy1g9SPH1g3aMegm1vgUkagWpz8Q6Hbu6RMyaWlx1em8
 13P0jak6YkAXJzQaU5AGTGArDiBEs9hUGXLfbZzI/fxuWz8t3OvJUb/L7rhbvyJ02SCp
 AHFP7B5Ur4i6JWI9rPaqwUVvPjPVZ2LXrMBj7z27WWVDgXJfyfIuP6Gyi4kLONt55Rz0
 VUHn85yd2e2ndiiG3XU5atIcQ7xXzJQY9RUXK2qdmtx9z0cm7a3n+jDioMnm6JjPKUVu
 uq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408581; x=1743013381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=442Qfc14sV8K9qojXAxlMgXPGGQ/rtu38D2XjLogGHQ=;
 b=adZbj6H+NV8d0zvI3P6M/zLbDU5NNqKCDKDIVgCeMluWQwG/+8KvN/palNDfZLEOcp
 WQZgKO1N14hsyNTHACg6ANV0dPp1CsNmE6icLo4laXqi4SjjM2fMekwWSJ7WJwvNK8JT
 ZI/IJg92Pdfz1qZys/1ER95b/gT+9Q5CKzTDq58o7mKONfSla/dZB1B1ncy6HGiKCstI
 wJoh1XqQruVeMujhelpcXEAbJ+/H8reKuhGucsR0u1B+MX6YpxxW+APC7mQ/FzsZ6hZZ
 In2UbptbnYLBBu4NKQThypoUJVyn0Y9e+ewj4lwYHpQkGUh+W6Q2IxzLMBjWHLBeS4gk
 sSBA==
X-Gm-Message-State: AOJu0Yyp3GD0LZHrIHooH6WStPS4OG0ey27T8zw4ZTdnUbLl7+3sEQDt
 oa722BsEYRO1pBI+YoZj23tYoCpIViWU5dFdk5oGoEbRV/HaQBtXSPJXAjqN2Ak=
X-Gm-Gg: ASbGncsJ1CAggvixF7BidbprSB8mJsF9GfBBNzK32A9tYdAfHfe23XBfMyzynN8qo19
 xpUMyVWuSTxc/iA9L3qKJnHX5OTc6STxtPF+xHBiqdJOdjqrkaOGR3xYYWolHPb+JhMOCKAl0cz
 T/QWp4BxNbrNQceHsn2/i+jvD9Go4snr3X06gMfUdDzr6+dyjkJ2BDWGNkYPLoObwh3xzw4U2mR
 xgPIaJQ4IeuE5CeHyFrx0zvZsmy1nEijTUuC/xF6o6/27h4paF5T2UUal8R3A3Mhz2POq0Z35S2
 KZak9wNOhH/8S0nPGMNKHHPkiBq6WQueY6972Z9kUX1iXZo=
X-Google-Smtp-Source: AGHT+IHu9PAj8n317XBQXlS6pw3rzu2f1wo8kZ9MO+O2Yyu6tm09jbWkhNGH41EOvZT/T0oJxVNKVw==
X-Received: by 2002:a05:600c:1546:b0:43c:fb5b:84d8 with SMTP id
 5b1f17b1804b1-43d49549405mr1575455e9.16.1742408580953; 
 Wed, 19 Mar 2025 11:23:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556afsm25431265e9.19.2025.03.19.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B9FAA60341;
 Wed, 19 Mar 2025 18:22:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 06/10] target/ppc: make ppc_maybe_bswap_register static
Date: Wed, 19 Mar 2025 18:22:51 +0000
Message-Id: <20250319182255.3096731-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It's not used outside of the gdbstub code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/cpu.h     | 1 -
 target/ppc/gdbstub.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1e833ade04..950bb6e06c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3016,7 +3016,6 @@ static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 
 void dump_mmu(CPUPPCState *env);
 
-void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
 void ppc_store_vscr(CPUPPCState *env, uint32_t vscr);
 uint32_t ppc_get_vscr(CPUPPCState *env);
 void ppc_set_cr(CPUPPCState *env, uint64_t cr);
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3b28d4e21c..c09e93abaf 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -81,7 +81,7 @@ static int ppc_gdb_register_len(int n)
  * TARGET_BIG_ENDIAN is always set, and we must check the current
  * mode of the chip to see if we're running in little-endian.
  */
-void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
+static void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
 #ifndef CONFIG_USER_ONLY
     if (!FIELD_EX64(env->msr, MSR, LE)) {
-- 
2.39.5


