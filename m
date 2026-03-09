Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9D8FCA166
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzejZ-0000pE-NV; Mon, 09 Mar 2026 13:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzein-0000Zj-If
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:48:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzeik-0002oi-Es
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:48:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso26587285e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078524; x=1773683324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhvJ30u4SjKjKGIAS0IRtyTM16wsKwTzLGcYfkxCVc0=;
 b=rhPopMlXstd5OeHVGDbY99KJUyq0nEuE96vXmTs9BoOqen82Sss5fvu7h7wJr7ynZa
 sVkcBhq0hFpqWIMm4P2+P2aNmi1sTHXAx6sJQwoLH+RxlkFjsNQdtjuDo2T07572dhhB
 Pjecrwn1T2D76HZzCDAjbBAXaai50Ku+s5aLk+/SmBRiqWVWTcG/8akrIO2OspH7Ss46
 oEm3Nr5AXEsNcwgjcgyhf2VLPPhY+cDy6bn76nhwP8MXwgkQyVukStkqtLqv5oahy5V3
 HNXoiSCS8exusl73vrxqs2Ud9n5LrlBNZVhjw19t2IrRWGhandbGLmqehtnZTOuAJxKA
 gdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078524; x=1773683324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YhvJ30u4SjKjKGIAS0IRtyTM16wsKwTzLGcYfkxCVc0=;
 b=SVzzq1/cUsCDVFXwaBzybFt7mwL0O/oA7rn2UXHWcMM7v9f1LmLhoMpAHcncfLghW8
 /B7r135H2pGP1veVTHkKn5aBtel34J2alUbI4B0xvtBkHLHyOaix2unjCHykQeAyo5vD
 7wrosopvTb1yfMOyqZyRGEmeqe34NSNk8gJERkNXThKelBp30XLk0WSchSr8iiXBdXvu
 8oclmo1UZj2zBOXCFzxMk90Z1fOgoByPADqhsMZavx30B1edP3U2pnHk7E3t+emvJ+Mf
 zWlnRvRkhH/oVcXVLod3Dr63Gf0TDCWInT0/cmemqx4F4IpXvkY7uVuiTP1/CQ7BBuun
 /Aiw==
X-Gm-Message-State: AOJu0Yx5zabDEHTB4GW42gXoOrGC8/1+pYv2lQYw5wIE2zo+5h+G0kDm
 GWfViO6/7FLvgL3xr71TegGUO7nk5LWoWakaGq0v6KRAFiAHi8RMCocxWlzJxZG6KGM=
X-Gm-Gg: ATEYQzz2Kg0OHSwpHewkehcg8wseWnf2ccycPVyfNQpo8UdahvPHgXD/5XvvSx456QH
 otROqv0mx4E0z8ccIRW4sXam+8+VKGgnKPchxWcMaX/ZXX5BCI2AylLG24Wz4C2Q4qDBa9eMTvd
 0YG4dUqE+Cym4UUwZCu7uHTuA9rHffSJL5g8XzJM7fOpM7b76wC3miWLdvc6p7GIfZFC6XyE3Di
 OG5604uTWYqn1eSAP+zK+XP5m8NItncZUR0aOEJgeCbVByqOuFcTyuXjNc3AS3Gy5L5OP3PzO9Y
 /kaHWMo7d1jDRcqoMeAnXuE5njFPbVHQqVBH3dWqcoZvJN5jRYsAzHM7NJxF6bV/R9trcUwbQNd
 HoOxhlLt0nkI13GkMFX3VxaA6uJcMncnCnxwj4TPoPQ7QCjezfJCsPbY8Q1jrcc3H6c2+VHsci3
 DSYRZD1PSgsWIEovupWEOxH63r4wQhbNXlGg==
X-Received: by 2002:a05:600c:3114:b0:485:40c6:f516 with SMTP id
 5b1f17b1804b1-48540c6f648mr28269355e9.33.1773078523879; 
 Mon, 09 Mar 2026 10:48:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aad45fsm8048965e9.15.2026.03.09.10.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:48:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4EA55F94A;
 Mon, 09 Mar 2026 17:48:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 3/5] tests/tcg/multiarch/linux-test: use portable
 alternative for dirent64
Date: Mon,  9 Mar 2026 17:48:39 +0000
Message-ID: <20260309174841.4184117-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309174841.4184117-1-alex.bennee@linaro.org>
References: <20260309174841.4184117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

dirent64 and readdir64 are glibc-specific and not portable to other
C libraries such as musl. Define _FILE_OFFSET_BITS=64 instead, which
portably instructs all libc implementations to use 64-bit file offsets,
making readdir() and struct dirent equivalent to their 64-bit variants.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/linux/linux-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index bf6e0fda262..0fa3165602f 100644
--- a/tests/tcg/multiarch/linux/linux-test.c
+++ b/tests/tcg/multiarch/linux/linux-test.c
@@ -16,6 +16,7 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#define _FILE_OFFSET_BITS 64
 #define _GNU_SOURCE
 #include <stdarg.h>
 #include <stdlib.h>
@@ -83,7 +84,7 @@ static void test_file(void)
     struct utimbuf tbuf;
     struct iovec vecs[2];
     DIR *dir;
-    struct dirent64 *de;
+    struct dirent *de;
     /* TODO: make common tempdir creation for tcg tests */
     char template[] = "/tmp/linux-test-XXXXXX";
     char *tmpdir = mkdtemp(template);
@@ -191,7 +192,7 @@ static void test_file(void)
         error("opendir");
     len = 0;
     for(;;) {
-        de = readdir64(dir);
+        de = readdir(dir);
         if (!de)
             break;
         if (strcmp(de->d_name, ".") != 0 &&
-- 
2.47.3


