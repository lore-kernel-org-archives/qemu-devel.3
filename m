Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217C0D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdscs-0006KQ-T1; Thu, 08 Jan 2026 11:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdscl-0005r3-8W
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdscj-0002q8-Od
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so31739715e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767888751; x=1768493551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ll5Z0TF4oGkzy7B80cNHq3j/2a/mLD66y7IXpt23arc=;
 b=SS7LUIxIKC+LstP7IOa0bqRr3gXkJ4Wp42R1c1G3KzDIoVH55L+NxVFbyGVZ/NvAnM
 rK1LA3CkPbyAlRetl+k51TYsazjd2eS+wRK2Ww6IAjYoMmNFLqyDM4JfzjGMIIlZo1AT
 f9t86DcZXeMVmMM7Y5Wbjy+/gY394qd6HfuqS5PkbsWDYmgrlj7Sg5a2i46xK7bYTnXF
 R6dJd/+yoqVInHohKLOx79YgMYhONVPxTQjjbOlQJ/lgqCj+pzXrc/I6zwAJIisXFOE/
 37I5+tgBOJUrN45Pj26cWKU1wp7fL+/ohhCWdamBy+9mPFgFG7kx1oaIIJ0IImx060a0
 1Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888751; x=1768493551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ll5Z0TF4oGkzy7B80cNHq3j/2a/mLD66y7IXpt23arc=;
 b=c4fDhxTQDMFjcAVbZUmofLBdYy39H/JGmgbSvhBa06pZ0pf/b0qIAkxjtV1N1TMKKz
 sAxBMKeV/J6zEHzn8YhZQqFxT+AN4mcrVam8ofoATCs4A61ERny0Mqktcu6UgWG+ceyh
 iHOp5Ai94NcRRx/pYtwO2A/LOMMGT1wcMle+AL3Cz2ET9l6cAL27eM5j5VwIcIjmzxuD
 fYtUawPZNMJCD4yqlhYv7egWSgVJaosmJxeinQhGKR9akS4XpHcWuoQFixijFvhekDwg
 +9ahNg4ZRGITo8zXJ9WZ84RdoW483Sn3b5Ql4m/jwOeYfKDkjR7IrdShTaTMeOn47aqM
 JtPw==
X-Gm-Message-State: AOJu0YxsqAp8ZYInSDunGeFFUsoETaCKweDP588bIXobhwZWzUoxnkTb
 HMWJ9cHZz9RF928bkNOaLvJgTSC5RM7cQ4KYB8BqRxF7XFnT2z3S6Sr4dO/a71Z+YytjANuFLz0
 vcAGZlxU=
X-Gm-Gg: AY/fxX6eNx4rxQMaVB2zi3Lqco8ZqBOsExxS2oJbHiPZxHyDCkoZhG4vyyq0BGg7nXM
 oBWd4yf0Zl8vGd9AtuJ3RHwIgc3KZbAu0KYvqSqwlF6wdwnzSVwwV1M2+bQy4DboqMbWrWs4Rgg
 1eU2+1ieJaCpGQSyWfcWnd4kbi0gS4/fK+M1mq47GKJIuDjNxa5ZZVRNV7X1HeD5fxa2vkhhIss
 9kCXnyyPFyruaZIj/xs+52bWoX00dpe5OU9CryDlRA+oc3YDP6aygnYmB7+dA5QeYE4LsOtd7XG
 0zN7vePptJ8uMu0/HL3+mYOhfcgJs1igNOEix3MAACJe+RI8YO3zjmlU0YRWyaX0L2tiPgTBKcM
 50m6wLh+5MDeJxfu2wdN/loihwGRpPEnywLZ0xZLFFRUjvpI6rPaYmDbivkSakZwCsI3Q1YP7Ux
 wbKOgP19M1xUAmaCuoTAuz5lN4iT6BTybymK8LEtZzRdBbkSCuv2HPGXv86adK
X-Google-Smtp-Source: AGHT+IHFGXc4mukeq5RNPsADO6B35bkk+ZyfOOFCLxPjoaE1cnugpKhlWv4bO9VyYsbnMwirST0N7g==
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id
 5b1f17b1804b1-47d84b1faffmr84855705e9.9.1767888750917; 
 Thu, 08 Jan 2026 08:12:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm155546005e9.8.2026.01.08.08.12.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 08:12:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] dump: enhance dump_state_prepare fd initialization
Date: Thu,  8 Jan 2026 17:12:16 +0100
Message-ID: <20260108161220.15146-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161220.15146-1-philmd@linaro.org>
References: <20260108161220.15146-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>

Initializing descriptor with zero is unsafe: during cleanup we risk to
unconditional close of fd == 0 in case dump state wasn't fully
initialized. Thus, let's init fd with -1 value and check its value
before closing it.

Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250911123656.413160-2-nikolai.barybin@virtuozzo.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/dump.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index f7a99a7af2e..016a7d7b970 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -104,7 +104,10 @@ static int dump_cleanup(DumpState *s)
 
     guest_phys_blocks_free(&s->guest_phys_blocks);
     memory_mapping_list_free(&s->list);
-    close(s->fd);
+    if (s->fd != -1) {
+        close(s->fd);
+    }
+    s->fd = -1;
     g_free(s->guest_note);
     g_clear_pointer(&s->string_table_buf, g_array_unref);
     s->guest_note = NULL;
@@ -1709,8 +1712,8 @@ static DumpState dump_state_global = { .status = DUMP_STATUS_NONE };
 
 static void dump_state_prepare(DumpState *s)
 {
-    /* zero the struct, setting status to active */
-    *s = (DumpState) { .status = DUMP_STATUS_ACTIVE };
+    /* zero the struct, setting status to active and fd to -1 */
+    *s = (DumpState) { .fd = -1, .status = DUMP_STATUS_ACTIVE };
 }
 
 bool qemu_system_dump_in_progress(void)
-- 
2.52.0


