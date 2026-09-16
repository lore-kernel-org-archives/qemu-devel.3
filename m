Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0072FC982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbE-0002Rj-Bp; Wed, 16 Sep 2026 11:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rag-00028i-5Z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:30 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rad-0001PS-E4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:29 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso4964905e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572626; x=1790177426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=985RXYgmuubKbGZhm5YGlCDe8xIWjFc7WGyDS1rZ3h4=;
 b=NPjFly3mrT+eoFe+HhAwN4yYTIO49np8T8/2umCwwbr9PIL48rZ5+WI/XMLpoftnVo
 pABC0oIZN5LA/BQl5BOerAMDKpBSERt5uNKdPg6M7XGUS2UUpzNZt6TtPlRS9wYMn3Xh
 qN3lVzLkoUEVwou7yU3sChL61StubG6oiFO0/EEMzgAtDP14iTov3SeovpcFJwLIOYG1
 hvJ9qK7fO2tdO6JYcQTYgpVtnlGWV7V8fgF4BvNcnFZcBC9XYyFLN36PzKNA3KhT1Sjj
 AgPsBYp+oJzwWgaYDuVqV7v4UDi4335NN//GWPNPN39aIdzP/pbaSVH9fo8P7Ix9YA4P
 SCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572626; x=1790177426;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=985RXYgmuubKbGZhm5YGlCDe8xIWjFc7WGyDS1rZ3h4=;
 b=A1ZUnGsuliFK1hzyPx2WkIHLxD/dsFoeWhCdIyyRevDjGUIm0KHe+SUJ8COMIBjBk6
 RwoZ7Qfu2i4rIx9AiJvvvP/B6R9R380ynHmtQk1IGKswcVH6+ObcoEgUCER8AhIKMIIe
 mxpJXIXAoee+yidv5kvZjXP+izzD0PGDJuZ3UDLeafdbV5eUHvMyU4xBAO46KTfCnMc8
 HRbH9n02rWEGGeOJsUXJMaiP/rc+hWb72mnaYJFnS+UuK3QmsCzRm6Cb3UzhTqgLZUxH
 Yvn7zwXTOUKkXrnppj7ZXFLqSHzfElg9B9jAaQ0hO8ioBKg3BRkzvL/cPzYPZw7mzWox
 yAJg==
X-Gm-Message-State: AFuF++m6nWhIjl01JZ04FCvwrVsOKAr2pTkpH/iv9N2LE7FNohZ/cFY3
 8QRF5MgHc5TZShMWUUQzQNbAJN40a69rgw1Vcw4/nlEJgQHJoIurpwO2rZgSfGNeIYM=
X-Gm-Gg: AYBFou2YRAEot2uIn7Zxvn4kluY6fdnn+yOe5rU69vNUPU0lL1LXnlvFZ4NjjkZ5pOI
 w0lHUzjB1irmcZl18RMux88fRt+Ew9uUyxKla6lCuRriBV4z+hmj2K7FvwmKwVZT/OZy2SUl/q7
 ScSDVE3+zGsNk+EJEwxU7s6nB5lo8yaA/S5ZyLUavcUk0CKLmpYy5hcXr6UzRXuRM435f96OdHb
 qTOqJuEFHARTNC2LOgwmCQU6jMfSpvoKLN6r/gUScqk9rUpyxJUijPN1XlJ2dqDOeRcwRI+r8n8
 cW0kZ8cs9fz00VLP6X0n5yRaKOt1ogKvTQC1YL4guEnqvnBS568570fCTZaoytDMviBPEiU2fsM
 VHH3KtzI9o60vi/hsUmyf0QtmpB62CPmwZ7ur39dEIGqLV6pq+4JrHY8949jJ0S0dbRfugwuzpL
 FE0SW62hn/qMYh7RnuQ8/BJjfuEcWhWNvbHlsrvTtUvV5WQPSR49S4dz9xLp7LjOv621xUnYE=
X-Received: by 2002:a05:600c:3547:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49eac45c077mr34765705e9.7.1789572625872; 
 Wed, 16 Sep 2026 08:30:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1a56d6sm194715e9.8.2026.09.16.08.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 63CA361996;
 Wed, 16 Sep 2026 16:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 11/19] tests/docker: remove used _read_qemu_dockerfile
Date: Wed, 16 Sep 2026 16:30:04 +0100
Message-ID: <20260916153013.2134555-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This is no longer needed since the functionality using it was removed.

Fixes: 07056db1b50 (tests/docker: remove FROM qemu/ support from docker.py)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 6090a9dc957..fd0cbdfe856 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -175,16 +175,6 @@ def _check_binfmt_misc(executable):
     return interp, True
 
 
-def _read_qemu_dockerfile(img_name):
-    # special case for Debian linux-user images
-    if img_name.startswith("debian") and img_name.endswith("user"):
-        img_name = "debian-bootstrap"
-
-    df = os.path.join(os.path.dirname(__file__), "dockerfiles",
-                      img_name + ".docker")
-    return _read_dockerfile(df)
-
-
 def _dockerfile_verify_flat(df):
     "Verify we do not include other qemu/ layers"
     for l in df.splitlines():
-- 
2.47.3


