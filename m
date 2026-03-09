Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A03EF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcwO-0007lK-P1; Mon, 09 Mar 2026 11:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvu-0007Mj-Ew
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvq-0000ME-R6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439c5cce2c6so5478953f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071649; x=1773676449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WzoCoJMLqVNBMnjsc6P0ukejjlUBO9sj0mR2CllotAk=;
 b=rnQvya0SHS+0uJwl4SrrPhpiYFw2SU87lMwg4zwrJqZyTDTzNc97tYH3eH5nwY81Ko
 8HQj4Ki5rsisxgDSLzbufvvQp4Ijq8ad+KcdYGz0+W+LoYWg/8HZSDKJkcTG7Pt54wTt
 C9GbFqL5J/3zyuKhXkbL8T7vg0tRbhdvovc6R/YDKP7QQxY6HHhX1tre+ISa8bcvGF6i
 +UxQANCN4wEJobTtjJuL72sd2fNZvNrvVrQgJiKZUHrBstm644H+0Q6zKf560/yvZrUK
 v6ndrH93l1saXm04fbqeyHDyi14vPjCECr5entkrv6tpIMqukF9oHNIJrQYyi9Qf27kR
 FywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071649; x=1773676449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WzoCoJMLqVNBMnjsc6P0ukejjlUBO9sj0mR2CllotAk=;
 b=aKPIgYFlhWzsBlI05QxdfEil3e4CipJ5PXjs6dkty7PeoA4WlrTp+VEBUmTu1KEIXS
 xNcz82NWVgy2+0CQ8BZlmI5EngziJh2ece3mpN6h1mZJuKu9jS4ghFjc1293vW/Ome9T
 B/i7Eno7WiNNbUgmaXJlxNbgBXeal1QUIgSx84aT0+4iMbLmAAV8uCjAdQzFGAXRZzCm
 mIjCX0OJHnyxQfObLYqDlkqEb2AgaLK+2rzvxugl+hmD753wxOK6GrdJ+OfJE4B127Z+
 /UfL1Rl1eFU4pS1Aa1OuG/tkugbPaoxdeQ+0rBulPU3jXyx1BpDOdXpq+wQWoY2IqMsj
 5B8w==
X-Gm-Message-State: AOJu0YwbVL0HQersG4aLxG+NjtNbl6olyAPBoL5QI6BBbW2tBLe8E80l
 9ChnBj1DNBZ6WNXXFuI9UMU1wNf6vpUshW4m4MtEAgYlfPT8GN9SdevhBRxQwcieurBTUkagfAM
 bIVSzv8g=
X-Gm-Gg: ATEYQzzQlNrnXw2Z8QqKBd0tZcU1p/sdF8wxaV2Tyn/neIjyCKtPdUVswqBHTtFWE0O
 x0oT+Zgm1e0ZKHY+vhUCJb3c74gNAkRQUZvFd8LnJ4cNA5wGSoE1HAnl8YdCv8VYdz+2NAyHp3u
 aQxcbzUACym2EWgbZHjScNI08YeN4FRWUeFWBqXgCtCB2OD3DAW0MJgzLYYEPkdPMggoQPOngvu
 X3QTP/AvvyYI6MBwud8fAMKvtuArYSUp0PbCSvcjzT3RLHH1jwPqopGOjscQ/VJGR3NKkB7j+rB
 2Hae4LiJTppvy4AfqsEb61U87DtJUe7rrH98dUrZkT3GStSePdrbkbXWTYbva8+BugioxIpiU0n
 M3cV0utmo8P83TtYXeIwIbjdM0v4Wbw0gkRVCj8ia9PsgKc/8gw+ertMRGa35LPUSU2W4iyFNof
 5E6grX2xRQZwZh35hhIyculDvC8knR+2CTu/J5aqDYDHBI/ljjv0jxdSXvwl5YzENAW47UYlCS
X-Received: by 2002:a05:6000:26cc:b0:439:bc31:a056 with SMTP id
 ffacd0b85a97d-439da8a6cbdmr22338208f8f.51.1773071648812; 
 Mon, 09 Mar 2026 08:54:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae35cf7sm26157523f8f.26.2026.03.09.08.54.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/49] tests: fix leaks in dbus-display-test
Date: Mon,  9 Mar 2026 16:51:46 +0100
Message-ID: <20260309155219.62400-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Close the connections and complete the method invocations.

Thanks ASAN for the report.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20260122113144.2046899-2-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/dbus-display-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 1d5951b7117..5773776cad5 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -76,6 +76,7 @@ test_dbus_display_vm(void)
         qemu_dbus_display1_vm_get_name(QEMU_DBUS_DISPLAY1_VM(vm)),
         ==,
         "dbus-test");
+    g_clear_object(&conn);
     qtest_quit(qts);
 }
 
@@ -97,6 +98,8 @@ static gboolean listener_handle_scanout(
     GVariant *arg_data,
     TestDBusConsoleRegister *test)
 {
+    qemu_dbus_display1_listener_complete_scanout(object, invocation);
+
     if (!test->with_map) {
         g_main_loop_quit(test->loop);
     }
@@ -131,6 +134,9 @@ static gboolean listener_handle_scanout_map(
     g_assert_no_errno(addr == MAP_FAILED ? -1 : 0);
     g_assert_no_errno(munmap(addr, len));
 
+    qemu_dbus_display1_listener_unix_map_complete_scanout_map(object, invocation,
+                                                              NULL);
+
     g_main_loop_quit(test->loop);
 
     close(fd);
@@ -287,6 +293,7 @@ test_dbus_display_console(const void* data)
 
     g_clear_object(&test.server);
     g_clear_object(&test.listener_conn);
+    g_clear_object(&conn);
     qtest_quit(qts);
 }
 
@@ -322,6 +329,7 @@ test_dbus_display_keyboard(void)
         &err);
     if (g_error_matches(err, G_DBUS_ERROR, G_DBUS_ERROR_UNKNOWN_METHOD)) {
         g_test_skip("The VM doesn't have a console!");
+        g_clear_object(&conn);
         qtest_quit(qts);
         return;
     }
@@ -348,6 +356,7 @@ test_dbus_display_keyboard(void)
     g_assert_cmpint(qemu_dbus_display1_keyboard_get_modifiers(
                         QEMU_DBUS_DISPLAY1_KEYBOARD(keyboard)), ==, 0);
 
+    g_clear_object(&conn);
     qtest_quit(qts);
 }
 
-- 
2.53.0


