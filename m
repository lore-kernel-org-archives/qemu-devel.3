Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E6DC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ks1-0007Py-Lw; Wed, 23 Apr 2025 20:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015Q-Sa
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqA-0004ij-Fc
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so320543b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456000; x=1746060800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/d4Opsx2QmpRYGlTe7zbsmEBVXLmlU0lp+CJtYfxNc=;
 b=E9HVqo8ksu5mNsYCNI7lpHesxBnQO42dkyDQM1CJuU7keaGolWKZYyv5XINiOC3qez
 oUMAc+ec4r3hgrkRYpXII5PcnlPfbLaPjE0J8clzUYf4qQwHGELtYma237KzRsWk6/LA
 wi1n/tHSpujQZSenoJYE4LU/D1WJtPoAMuT2FTCKw1dBoqQeiMMojG7YWDq7c2C7E40p
 p5pV7aS1ULkRJyF/SAvk0AH4a07Z+np6R7yXtH0bm6R0C2XUTvll9VpM26GUmEW0BXFY
 J74dluTauhREbd1K3UQjlinFNXUStyZuyj3VxJTTmo5PwK8a5sovC010Zz906wg2pZo8
 WmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456000; x=1746060800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/d4Opsx2QmpRYGlTe7zbsmEBVXLmlU0lp+CJtYfxNc=;
 b=T5DseCPvz10C4ienPMQwdMT03nJPzFPrGZFnbjxody542CGNSa6dQ+xxBY3VmlE1Ow
 reyD+yscodALroVue7wRXk9+HStUFjgSGnDZmnU1X2d0t4W7khBeTHwbPMMEZI63vSwl
 bZPXTlZOcO4j6J2Qjono+sfvII3+qWmEdVXfjxa0kkg2t4Qq+IC5IHx1S1pTHN7ZoUA0
 +oJeW9uFjbN5Q+EjV8RRJvRFBchdvj4ZKtwgs07l1khU8dvYjl3tUVAvfO3iUM6O8712
 gBZiAtzNdtynl5I+Cm19Lo2u8niKhTZRf4iaL+ZFPe5SuaHLFXiYz/BJo9pg44ViOuIz
 KBUQ==
X-Gm-Message-State: AOJu0YwcqIiqC0ddbFNWq5eCBd1jYE0RCcMs3rgw3hsKfo8QZygpi1kT
 IamOUp5QJ3F/nXklehznvR4DevvHl8XOnwTosIGBsG+q88VoX6u6nC6YutMtbx7iHgucE9YnN1f
 k
X-Gm-Gg: ASbGncsmenZO0QYq7AH7NUwtCdQakR8lRxhS6l950WPX0VAHNF+nexIOu3UnysVeIYy
 12AchCVP0wpf8QGSYqclafnLGzdyhgR/K82rZMjUzpC3rxZaWElJaTb+kfJtJFqgjZy6rbvQVMS
 tWI7S5oTrNHt41xpD4HX1d/MzrUJhDVkW19mAM5lh00KSTf7o8CQP6vr5Paum/mhWvAyI0lBn3m
 K86mNezYAHyN3DNsh/s7/jd2mpME8m8JP2q7ae6exKNLHHXq4KIhU8b8iOOluSPIKf16ebsd5mB
 LvIH7aKf4T2IsMnh3YzZSle+Z8n8mBynlVlvB1hcF3Pev3qf++Wjyyf4qXa2RiKqfI0w5bLJz30
 =
X-Google-Smtp-Source: AGHT+IHo81lWmhZJn26q9XPQRkPrZJdvO7kEzr0CkEB1Gnu/cQkxmtjTNgVSsElj7ya8ber19GtVmQ==
X-Received: by 2002:a05:6a21:e92:b0:1f5:7353:c303 with SMTP id
 adf61e73a8af0-20444ee3960mr922711637.11.1745456000574; 
 Wed, 23 Apr 2025 17:53:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 059/148] include/qemu: Remove ifndef CONFIG_USER_ONLY from
 accel.h
Date: Wed, 23 Apr 2025 17:48:04 -0700
Message-ID: <20250424004934.598783-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

While setup_post and has_memory will not be used for
CONFIG_USER_ONLY, let the struct have constant layout.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 972a849a2b..fbd3d897fe 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -38,13 +38,13 @@ typedef struct AccelClass {
 
     const char *name;
     int (*init_machine)(MachineState *ms);
-#ifndef CONFIG_USER_ONLY
+    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize)(CPUState *cpu);
+
+    /* system related hooks */
     void (*setup_post)(MachineState *ms, AccelState *accel);
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
-#endif
-    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
-    void (*cpu_common_unrealize)(CPUState *cpu);
 
     /* gdbstub related hooks */
     int (*gdbstub_supported_sstep_flags)(void);
@@ -78,12 +78,10 @@ const char *current_accel_name(void);
 
 void accel_init_interfaces(AccelClass *ac);
 
-#ifndef CONFIG_USER_ONLY
 int accel_init_machine(AccelState *accel, MachineState *ms);
 
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
-#endif /* !CONFIG_USER_ONLY */
 
 /**
  * accel_cpu_instance_init:
-- 
2.43.0


