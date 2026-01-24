Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED161D715EE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiO9-0004Ma-NL; Sat, 24 Jan 2026 13:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO8-0004Ls-CE
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:36 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO6-0003hV-Vp
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:36 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8217f2ad01eso2940728b3a.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279373; x=1769884173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvR1Snlpk2uTlHbA8GXZk1IgzFIJTiP7/Ri0kDL87U4=;
 b=hTwqKdgE+sg7yNjIj2ghvoComDFbl7zuY6MW88cNHlPblEUgS/2BLalxfzU5lOIHj4
 ne7PEIAvZRD0/aW+0GEna18XuPbj13E53lmg1LaWcCzoYsIrl/qRc6KRylagYs7RqJQZ
 qJrOgpuKkUHcXhO9N3m2xzTY926NOj4g3HJfmDm3sV/uYNjMA9Rbr7CAhx37fNzMiAEV
 5bHZNTh3OdMrPYtGjSUFOevCeHtwnHjTMLfNryUrKSFZLvhIkD81Kp3KUequtqyBSqaU
 EZZZp+pQ1GBZt3tqxtri0C169tDCtwLNH4tarZ8W5MI3uPQuVulZCeS/+N11CUuL/YRE
 fy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279373; x=1769884173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UvR1Snlpk2uTlHbA8GXZk1IgzFIJTiP7/Ri0kDL87U4=;
 b=kVbmO16jodk2YQdrlVAk9lUCxvFXSRrWKuDegoZD6knXO5gzy6pp6JP+vOxaDzkqYA
 0T/pGFkPQ3vIeLMva0jOfzB2KjLCjd5Ij8z/4HKW7oo3MHUASCj3GY4Nob9ZF0nMfZqn
 t8ognwDB+yBK+pbB4C34ypRK8gzluBk0WKmkqcBRect4tMwxiDEYKg45Ljbu7N95eK18
 Qe1u5Qsh+9Y4yQRf+rl24/C0uUS7lAq7njfw8ffByQru7AwvCODsoBeMfIkLPJDhrNu9
 Qvhdlc2lOCUfafYcgUQ0EpA5blHiTi+gfE4H2HvvcWY2ExoEiPYBVshQvXgmFxqT5eCo
 uwKQ==
X-Gm-Message-State: AOJu0Yzrk34G9K34wO/xOqyAloTj7g93ec3rEzVd7AdIJ/WK7mSyONRU
 643Gv34r6Xc3yGwRGF8Pn4MVR3PsWyvVmdaodlsYPkoTJAeU5lJLnL83Z1jB4Sx6pEglRiPqaES
 2Okkn9B0Zqg==
X-Gm-Gg: AZuq6aJCgZfDyRA9mRsqXSUS+vUTucS/cURmx82ob2JljSDz5ydTY83rjbj4X0tTup7
 eMXrtTcVWTnuUFnF8Fp3bGH8YjmbicvnFjNn4zwku6Pu/SJMkZIR617n2Bsiz7VTXeuItXmeQ2F
 vkAyHsROiMWPpZwJa0ytIEcfYtJzpM0baNdYgOPveRDEcAKJe+56hwFgWOiONApClHH7y6F6Gfc
 5pPFTo/2BEITjFGeTy0iwZ/B9wJBhWgBvwQCuZQZcAPVTlvHgZs7g4PlT/m/n8AUdkofBmjis9B
 w8jQU8yzq0g1hsKRV3HB+fy6V/637GwZpniIQ0YTK9Uv9ZxmJ/H0/bcq3eASBeV9hDrNb3lv5Lb
 kqBjB5EdT6DiL+udvGM7rIO44Z2/xsqnENIgJUTail+Bed+KDiGiz9sPOk9MWUp+xt9UsGv2jx7
 HKu5ogwZ76BQz1TnjJAHJdcUYif9LOJhUt/S6SdZqjLoG9JweSwpDJTlTcKhcx3/BhuAONzZyAH
 14=
X-Received: by 2002:a05:6a00:4b0c:b0:81f:3f88:89f3 with SMTP id
 d2e1a72fcca58-82317d9e2c3mr6655965b3a.3.1769279373492; 
 Sat, 24 Jan 2026 10:29:33 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 04/11] plugins: define plugin API symbols as extern "C"
 when compiling in C++
Date: Sat, 24 Jan 2026 10:29:14 -0800
Message-ID: <20260124182921.531562-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x442.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3fa..e44f863d839 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,10 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -1210,4 +1214,8 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
 
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.47.3


