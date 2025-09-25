Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51600CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1c9D-0001zP-Bz; Wed, 24 Sep 2025 22:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c9A-0001z0-IT
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c96-0002Z4-5K
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso560257f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 19:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758768946; x=1759373746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/w1oo89YkX4j56P5P1/JI5beHjfC7oSHrKTDCe6IzA=;
 b=qyu16QSsr6nWsVpF8lLOfRkQcDCotD0D1gaX2UBqWas36GL02cJEWMWFdGFEhQXhK5
 k0qPB+BTDRqsB6wgVA5OxChPs78Iinyg+N3I2UXEO3J05ShhdDJjF/Zn+uLhDybF0jH9
 xG0LNRuh1gMnb/VvunI0tTmeaCBdAWJV7QsgIbmF9B4K4ArVsoZKJTjed0Fi1Ykh6CP2
 ZwNFzqz0wsMLqQ6p/r/yfjeSkk0WmmMm87atcFGHUn27iUc4WMPt7J8fvGnQyPSJk2eB
 bQlBm+SEOMXLM1d9/BhZ45Gvj5oGs/oqXIjHQjxYXObVsIaWXyprWjJeMZ6BRe9/QvEt
 29kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758768946; x=1759373746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M/w1oo89YkX4j56P5P1/JI5beHjfC7oSHrKTDCe6IzA=;
 b=Iek/lj4Ao+30LSoUqt2UVKLm3MBvLlIE8VA01bJStqzTqrAvQAploMOkHXPv7IYzR2
 o66RKLVAqHhn/iOshESuIq5BCWQcc5Q1ALdk/FVSfaClvFpf7harudz1cBrV+/49pWmH
 tUma9/5SjNyxPENh8ZfPVYZVTezuttvuowOJTX7+Dcm08kP4yn2IV6A9IzEaeoYs75SX
 yiL8B/FYiw2vyVWryG7oXpkiVJS+Pb72c3YiBowQaBhYg/vMTvx025VgC73rJePAokll
 IdauGVVs8JLvsHr7XAteEtzSxvpRJQHDw6r5JCZ/dEhwKUhF7Di1lOX88VDx+GZVRB3E
 hB+Q==
X-Gm-Message-State: AOJu0Yx4inQfWkffXynQLmeFzTLODj5i3VZ3TCGBKjG3alNaedWJ41IV
 f5DtEPcD2ekl2Y7C/MXlVehCZTeAmIFY6PGe6i5DNF9c0W+CpZZ1egNHaEnwZaUP6hhH3JZdUJd
 8rmdjGPF4Wg==
X-Gm-Gg: ASbGncujWw83eFp/7urCDLGYEhl8SyY/M+1HkkQCXO8em/ImJDBSNraM7hxlMT4ZXR1
 UjUEHO5y0tXQHRQm0gBNDNMAiNqazVpDZjz+y0Fk4PoqOsYYsyzLmxZJdOKRphexfDkPkCIbMuc
 g9bicCsCBn2LW/tctjSlp/vJ/UBfAiaFMXkZPDpmeuQJ7yq5+gab2yE7riQL3cPDOEFZ1ok0Cfq
 YzGyq0R0RwALfYkEUX4sTtur+PEuKl9u6dHHaGbKjBYwulJo8hdlU5wz4kPp+09ej3dN/r+NI2J
 jzKC/sECxJt/9sLa34P4qcZaa12CgrD/7q8/wf8iPuC3bhdwjvlR2DOP9jkwN4fb7gof1QRkrS7
 GVJ8KypCJHCx2g+e0VdxQL0G3cTptBWJSHmH7G+06KU5VmIwM9HraKgKTSzGtYw00CjuRE/Cl6n
 y9y0nX328=
X-Google-Smtp-Source: AGHT+IFsxdr+JXwJOUOGoHMw5I7UtgpECL0VwfTynMbpxTSApMyG+EeEUGFd6VlFOMXeXu/NxlYvXg==
X-Received: by 2002:a05:6000:430e:b0:400:818:bae9 with SMTP id
 ffacd0b85a97d-40e4b85103emr1755260f8f.32.1758768945684; 
 Wed, 24 Sep 2025 19:55:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fbb27sm924338f8f.4.2025.09.24.19.55.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 19:55:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 4/4] accel/tcg: Use cpu_is_stopped() helper to access
 CPUState::stopped
Date: Thu, 25 Sep 2025 04:55:19 +0200
Message-ID: <20250925025520.71805-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925025520.71805-1-philmd@linaro.org>
References: <20250925025520.71805-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 2fb46439971..f84342e0449 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -197,7 +197,7 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* wait for initial kick-off after machine start */
-    while (first_cpu->stopped) {
+    while (cpu_is_stopped(first_cpu)) {
         qemu_cond_wait_bql(first_cpu->halt_cond);
 
         /* process any pending work */
-- 
2.51.0


