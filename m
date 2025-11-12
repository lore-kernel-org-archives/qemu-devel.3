Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E141CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBEI-0007Hw-47; Wed, 12 Nov 2025 08:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7i-0004LC-Vi
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:43:00 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB7h-0001Qf-CE
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:58 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4777a9aeedaso7707715e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954976; x=1763559776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJZy/Fy5K9acciKNQyPK4u1aveLBTjzoIj3j8wI0EAM=;
 b=vXC73oQXX7AgRpit8PkFJJFOZX+BqOEWhpiA3cldOMQ+NGWwUtGitm1M49TBSHoXQx
 qD000oYdDOtYBoiKIurkpn75S9rY1bbA38XMgGsSdPhyFP9QPbx4rFgUlwEc9lx2pJ96
 bj0BoYGLNhx6/4IRrRMTd1i8kylqh6uows1uoWQt0LxvbShRs4R9mC/YpTsOunVzBkJ6
 SiZMFV6pp/8xtQA8LDM8AdxzizrVAflRLD1sCaeNPvqHGuGsK2Hk6JeTd2xp5XgPFjuF
 R5J0+JPTbtuE+Xe0S0ag44S0XxKXlJriC7i2A2SdvD0u2pMDRW0+iLgikSj5szlTtOSB
 ZZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954976; x=1763559776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OJZy/Fy5K9acciKNQyPK4u1aveLBTjzoIj3j8wI0EAM=;
 b=mogWRsLjhB5gRr+NG7OXVnKmdZSk4UdlPxl2hV2kW0x/z6qtCUcgOVpka3tkZIzZS4
 Wo5KILv12f3yxn3aW0iPIIEVwgvfznFk38qHR/ZcvMha6GJ3HHQiZ8DC5elIRZSCs0zk
 R5XfysNbyzHDn3z9W+0eeyXFtL3g8GB+JK/H+bzeBXYRIcnJxz5lUMAFVmpXrckRFscg
 JhHHkDK5msHY4lZnGNoGyXWNc6+K5+2v8bwHji2iohEuTwxU5+K797LUXI3UCe0s+imw
 p+Z7DMu5N33rK89pc2ZwSEVghS8B5TTjowjyKPwyI197u9NlaKjO+RSgW73w1+vVvdnN
 ZB5g==
X-Gm-Message-State: AOJu0YxYWpyt4aktq4jRjElvSaTMb4dMbqJYOHfxas0LQulIrdk718kp
 +I/dxEjlZ8DJKZRybKFQKMtblrTTWWXr+HD4mLoE0RLA4TVVs/8KjDVOTzk4bvZsH5AeLUyxvwE
 usyA3yv2Ofg==
X-Gm-Gg: ASbGncvVXXp7fC30kqUYU3TIAbWNK3fxsR5Q0uYxEAaPc5kAOD+lXcLoJXWhtr8ndce
 8rJq9va5lbWcthznh7FdUO3fb62PPNaJB/46aYPjuZBg2Cw3hR1tAOI6Z4/5oMtGMusd8zmWbvy
 5reTCypIAfgQtkExNJ2Iui+tLiEBc7MnmLmC1zaQFsLyXgCiv3UhJBHM5MHgbp1cp/lu28tL+z0
 /WdTlhISQuq81TKwxHcH2Hm6qJ1Yej46mhOz4NDRo5RyL7/ZlWbecZ+/ThKg9zsDkDK0LO+vUt+
 2vJ51yykeMr8J7u+S9UC7ywkLVYXCN0A0ZpMRqoGJHovj55vnZkeCJu0p16PcWIIIwuoCQq1fPt
 DkCiVxSO6e3gXZC5ZytS08AfdZqeE/9nmdkmLi+gSlnsKaZndqaiPaIsA5yOEP5dZuuOM0axg81
 72YuQP7GsTQBAiZg2+wkyUfUsoZGYicKUlWmPOZCB3si+2+mvDwaoXqg4=
X-Google-Smtp-Source: AGHT+IEeyCCm2DEr0whAopnPgp8P83v70oyTslSXpqcj70WqAfDUouBOEFLMk66oGBSnbRIanNetIA==
X-Received: by 2002:a05:600c:45c4:b0:475:dd59:d8da with SMTP id
 5b1f17b1804b1-477870c9a4bmr26406015e9.40.1762954975616; 
 Wed, 12 Nov 2025 05:42:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47788a59190sm14282065e9.3.2025.11.12.05.42.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:42:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/10] system/replay: Rename some method parameters
Date: Wed, 12 Nov 2025 14:41:43 +0100
Message-ID: <20251112134143.27194-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

replay_char_read_all_save_error() saves %errno, so rename as @errcode,
replay_char_write_event_save() saves the number of bytes written, so
rename as @nbytes (same for replay_char_write_event_load).

Use the forward declaration in both replay_register_char_driver() and
replay_chr_be_write() declarations, matching their definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/replay.h | 16 ++++++++--------
 replay/replay-char.c    | 14 +++++++-------
 stubs/replay-tools.c    | 10 +++++-----
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/system/replay.h b/include/system/replay.h
index 68f91bdfbf2..56d2aebac7f 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -136,18 +136,18 @@ uint64_t blkreplay_next_id(void);
 
 /* Character device */
 
-/*! Registers char driver to save it's events */
-void replay_register_char_driver(struct Chardev *chr);
-/*! Saves write to char device event to the log */
-void replay_chr_be_write(struct Chardev *s, const uint8_t *buf, int len);
+/*! Registers @chr char driver to save it's events */
+void replay_register_char_driver(Chardev *chr);
+/*! Saves write to char device @s event to the log */
+void replay_chr_be_write(Chardev *s, const uint8_t *buf, int len);
 /*! Writes char write return value to the replay log. */
-void replay_char_write_event_save(int res, int offset);
+void replay_char_write_event_save(int nbytes, int offset);
 /*! Reads char write return value from the replay log. */
-void replay_char_write_event_load(int *res, int *offset);
+void replay_char_write_event_load(int *nbytes, int *offset);
 /*! Reads information about read_all character event. */
 int replay_char_read_all_load(uint8_t *buf);
-/*! Writes character read_all error code into the replay log. */
-void replay_char_read_all_save_error(int res);
+/*! Writes character read_all error code @errcode into the replay log. */
+void replay_char_read_all_save_error(int errcode);
 /*! Writes character read_all execution result into the replay log. */
 void replay_char_read_all_save_buf(uint8_t *buf, int offset);
 
diff --git a/replay/replay-char.c b/replay/replay-char.c
index 81dc416e988..023159b155f 100644
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -93,23 +93,23 @@ void *replay_event_char_read_load(void)
     return event;
 }
 
-void replay_char_write_event_save(int res, int offset)
+void replay_char_write_event_save(int nbytes, int offset)
 {
     g_assert(replay_mutex_locked());
 
     replay_save_instructions();
     replay_put_event(EVENT_CHAR_WRITE);
-    replay_put_dword(res);
+    replay_put_dword(nbytes);
     replay_put_dword(offset);
 }
 
-void replay_char_write_event_load(int *res, int *offset)
+void replay_char_write_event_load(int *nbytes, int *offset)
 {
     g_assert(replay_mutex_locked());
 
     replay_account_executed_instructions();
     if (replay_next_event_is(EVENT_CHAR_WRITE)) {
-        *res = replay_get_dword();
+        *nbytes = replay_get_dword();
         *offset = replay_get_dword();
         replay_finish_event();
     } else {
@@ -138,13 +138,13 @@ int replay_char_read_all_load(uint8_t *buf)
     }
 }
 
-void replay_char_read_all_save_error(int res)
+void replay_char_read_all_save_error(int errcode)
 {
     g_assert(replay_mutex_locked());
-    assert(res < 0);
+    assert(errcode < 0);
     replay_save_instructions();
     replay_put_event(EVENT_CHAR_READ_ALL_ERROR);
-    replay_put_dword(res);
+    replay_put_dword(errcode);
 }
 
 void replay_char_read_all_save_buf(uint8_t *buf, int offset)
diff --git a/stubs/replay-tools.c b/stubs/replay-tools.c
index c537485f401..df21475cec5 100644
--- a/stubs/replay-tools.c
+++ b/stubs/replay-tools.c
@@ -49,21 +49,21 @@ void replay_mutex_unlock(void)
 {
 }
 
-void replay_register_char_driver(struct Chardev *chr)
+void replay_register_char_driver(Chardev *chr)
 {
 }
 
-void replay_chr_be_write(struct Chardev *s, const uint8_t *buf, int len)
+void replay_chr_be_write(Chardev *s, const uint8_t *buf, int len)
 {
     abort();
 }
 
-void replay_char_write_event_save(int res, int offset)
+void replay_char_write_event_save(int nbytes, int offset)
 {
     abort();
 }
 
-void replay_char_write_event_load(int *res, int *offset)
+void replay_char_write_event_load(int *nbytes, int *offset)
 {
     abort();
 }
@@ -73,7 +73,7 @@ int replay_char_read_all_load(uint8_t *buf)
     abort();
 }
 
-void replay_char_read_all_save_error(int res)
+void replay_char_read_all_save_error(int errcode)
 {
     abort();
 }
-- 
2.51.0


