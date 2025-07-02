Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BC8C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2cH-0003Vr-6W; Wed, 02 Jul 2025 14:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cC-0003Ak-EX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2c9-0002D3-5w
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453643020bdso63101435e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482522; x=1752087322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnLLL7YQoCQGdWR3EVL4zcbePVJyUuDX4baxuyLLriU=;
 b=BEQHCkJuF9aimu/Iba3BDw9vcces+zALk2nARbTp+EyBwoaAuGtiyMpneUvWL9VyyL
 wMWxB7VQMwXhxr2qE7GFy0cWR8G27x9VqIw1E/ZeyVmypsUjUFQWUNkPKcLi4urvlMec
 mlkrFmshxY7J0AjTEwsrspvO1iYC9zl3WAoAziQ9ItZL7ElHrJEFPyS2jJZCWDsQNpQb
 YtKFvd1G9yVOnxBC2Oxtl3AhOSYL0sbKjzZegzECU8N7TLI3KWtJiHeCo6fqjyJ03V7p
 v9yEOu+eKfrSpIw+AstkaYp+a4jMTkRr21kVMdRfo0o9sXw/H7Z0eJTZVQZF32BQ8CiZ
 KrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482522; x=1752087322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnLLL7YQoCQGdWR3EVL4zcbePVJyUuDX4baxuyLLriU=;
 b=ZkwgKMzhidS6+vtTfxtHeoQS4zvat0knibcetxg9Qb5INfGUamDdbsrUiObVX4P3oS
 Be0ygypqM0BwgLn5UsRs6wvV5ePpQaXot/lfnKqsetFdpKmSdm8BmCbz5dbaKM/Wu9Qq
 Yi3mZc3AmjBvq56RR6ktYDxsUahMt5bX06WGixb0ofjcgvVnytUQiVIr7Xhd48xa5pIw
 bd7L0zsaD9hNff+FaIURL4zdGcqGqcmo8FEaVBjUCTYGjllqHKFFUxmEOuMvStJa+dFo
 uRokpZdnCBzReGMoBPM5vEG3REb1dgtl305vPb0wk0TF1IHqITXKS8EZg7MAiwwrhiju
 vGkw==
X-Gm-Message-State: AOJu0YzHZDvRdTBZ1Qkr5yY7Sg1kEfa4Kb4cSsTGADEOi9+Xt3C3J8Tp
 f5NUuqOz8XAypr9PJatHFXGp/pmQiWYzmHjOdFw+CwUK1mBU30HSfwpAESKQ6r0MBNxQuWaJ9zN
 YUplG
X-Gm-Gg: ASbGncsZiPLmfm3G3lHCk0x2pu1s8PlkALD2kJD8PfnsNEh3q21DeXmZWKCWBquI7Hb
 2ccuM1oEGLtp71pH/7XR+woJcmaYMsQb+vRm0+bHWPefEZWo6WENSwHlPkCCDQboxLGo/3EH9HI
 rZ+MoNhLOgteLSc4+03dyPSreSjPa2BTagi110fsILdhE5dXcfrIM8kDy8Yqqscku7rurlyLQY3
 bhG2rQUrJW11prFCZ1m7e6AZppfq40kPD21YX56LvGo4VM+gqRSScSQUtBdSOxP3XVpu+z7YpIq
 P5Ls2K7bkPUqPAtlKNm/4+fiWROpUjeDoj2mBNBMI7W0lLHO7uKkJHht/hi7I4sqBBGX9cY/TJF
 HnaMyjmnQKA9/svrxYyI8/l/6BnPyNEWekGQX
X-Google-Smtp-Source: AGHT+IEXN1ji8HMgF3oWOa7k02PQHX4IAD+Mx2AkWivNZait2oN82da7g9XDELsEchLGK60Cx8nB2A==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:f7e7:416b with SMTP id
 ffacd0b85a97d-3b1fdd16d21mr3559245f8f.16.1751482521753; 
 Wed, 02 Jul 2025 11:55:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bac48esm5412345e9.37.2025.07.02.11.55.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:55:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 15/65] accel: Remove unused MachineState argument of
 AccelClass::setup_post()
Date: Wed,  2 Jul 2025 20:52:37 +0200
Message-ID: <20250702185332.43650-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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

This method only accesses xen_domid/xen_domid_restrict, which are both
related to the 'accelerator', not the machine. Besides, xen_domid aims
to be in Xen AccelState and xen_domid_restrict a xen_domid_restrict
QOM property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h | 2 +-
 accel/accel-system.c | 2 +-
 accel/xen/xen-all.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index f327a71282c..a6a95ff0bcd 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -45,7 +45,7 @@ typedef struct AccelClass {
     void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* system related hooks */
-    void (*setup_post)(MachineState *ms, AccelState *accel);
+    void (*setup_post)(AccelState *as);
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 913b7155d77..af713cc9024 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -58,7 +58,7 @@ void accel_setup_post(MachineState *ms)
     AccelState *accel = ms->accelerator;
     AccelClass *acc = ACCEL_GET_CLASS(accel);
     if (acc->setup_post) {
-        acc->setup_post(ms, accel);
+        acc->setup_post(accel);
     }
 }
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 1117f52bef0..ba752bbe5de 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -63,7 +63,7 @@ static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
     xen_igd_gfx_pt_set(value, errp);
 }
 
-static void xen_setup_post(MachineState *ms, AccelState *accel)
+static void xen_setup_post(AccelState *as)
 {
     int rc;
 
-- 
2.49.0


