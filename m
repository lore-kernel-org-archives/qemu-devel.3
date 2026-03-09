Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1CDEFCD93
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzY7a-0002LE-GP; Mon, 09 Mar 2026 06:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzY7V-0002J6-Bh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:45:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzY7Q-0008PE-UR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:45:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso10527825e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773053147; x=1773657947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dBF0F4Eo+J36hqfs4PYRXkLQw0s8JmGYcjmT4oShuDw=;
 b=qdQOYAK9Pp2Sc/KVa6nvKO3SYAQM82v54Wi7neipyetYDq4BwmutZfAwFlugmnjat2
 rl5CDVJzZ6Ht7XNYB3tnYLFpG5zKD096rlumfUxuJCmvuoRRrRJdFLu+c48W2OtPGCdM
 05mjH12mD0bgeM6GFKWbSQFmI7LhzBzsZQmGU/xTEf9sjiLqetYJSCSFzbC9m6JMq/KN
 O8X7YM0IZ3fum75+oYb4v4JVsH6a9we8/Oe6zATCceMorwmfE2u1GMQ45EKZWhpODZvP
 Y2mlLbfFQU23nxrVLzTNXvSAW0TuPSm5WSr4NfnuvvUOrkt/6hrReACePEYTOI99If+G
 rxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773053147; x=1773657947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBF0F4Eo+J36hqfs4PYRXkLQw0s8JmGYcjmT4oShuDw=;
 b=EHGUdYVGvl7nVw6xpbJgFGadK3S3pupZcnuk0jmb32VlOf+zyNpMRu1W0LaaROAunD
 irUQ0+Jn7g3ffDgv8muLw3LzY/JWrGV77BCjtr76WL18dyq+AXcV0kp1mxD3NKhDhWJ9
 1Wns5WQ85fGdfWRoqxJ8FN/JdambViXpfCRvbuS1QbcyR0XUIXsgZ0njQkDbjNthhWZB
 8HnWG1pkneXYYZ7705OwHc3suEpWAKHQIh8lRFgVBvAn1xkXEqHKFnypqYZ8FXxvNLQ3
 s9IwIkJ4BFZZKg8fQcH3QooC76yfm7kQcOOL50fk4UaL5EoqAdg27t+l+5mhTRO+0tlI
 fMlQ==
X-Gm-Message-State: AOJu0Yx8YQES+gOEdebjv6a/xfQdRHo8GwDGd36H3NU9rMBBz+X0DjyL
 633DE8IkslMdxSubYWNEA88chLYYi3iX2irkqNWhY6RpvtsN3fGtU1KWjLSc+etNAsN75e/5Q/A
 7mdtQ
X-Gm-Gg: ATEYQzxUwpnprH/tWsW8dcFQXfvtinfdPi+C6IbZokP1I0o106JcOFOohePVZftOe1i
 wj7GwvAcg4pzs6VwkjlnnKgERDhXW4Xsg0BFyULxhXt40g90jX1i7Xp7q8NeeGIGtIsZqQ3ytN+
 UUcK3A5xmPJ02NQDOvQge6Q8NtEyDKKYL9kZKC9r+0PbEY4uYSl6dB46CQQf6OsccRfZIvoPC9V
 ZK8qqmTww3UJPlEtX8GqJD7WCfb2qQI5nmOQ0uczlEslp2QLIpapFdcC7A2cWBzoM7HW27DjVmV
 5RZGQYb7RPxpwOCVkxLxs0En3v3CRFpWzS2Ky6DEfKFDSiKTQSkJ0coS9Lf3crEv0UgSKDhf5BD
 OFh36Jxv3mgsX4R+WHJFfMnZqLtxjQCCB4ZtZhgqcdrIIuFnqxnb1n2szmBrU5/J0I9W8t6tH9Q
 lwrH9FbtgYAZdq09XAkQBP5kXUSbiP+ibu1N1HcL0k+onJvMV5oGK4jInRQWSDCilRz3brMw7sb
 nU3Aj9BcuvKZR3OsB4FKSISP/T9dsk=
X-Received: by 2002:a05:600c:3f06:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-4853e0094c8mr21374695e9.9.1773053146629; 
 Mon, 09 Mar 2026 03:45:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485354f96fesm41620895e9.30.2026.03.09.03.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 03:45:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH] tests/functional/x86_64: Disable memlock test for asan builds
Date: Mon,  9 Mar 2026 10:45:45 +0000
Message-ID: <20260309104545.1550888-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The address-sanitizer intercepts mlock() and makes it a no-op,
because it interacts badly with the sanitizer's own use of large
amounts of memory.  This means that our 'memlock' test will always
fail, because it checks via /proc for whether the QEMU process really
locked some pages.  Don't add the test when QEMU is built with asan.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/x86_64/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 05e4914c77..1ed10ad6c2 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -14,13 +14,20 @@ tests_x86_64_system_quick = [
   'cpu_model_versions',
   'cpu_queries',
   'mem_addr_space',
-  'memlock',
   'migration',
   'pc_cpu_hotplug_props',
   'virtio_version',
   'vmstate',
 ]
 
+# The address-sanitizer makes mlock() a no-op because it
+# interacts badly with the sanitizer; this means the memlock
+# test (which checks via /proc for whether pages were locked)
+# will always fail on a sanitizer build, so don't run it.
+if not get_option('asan')
+  tests_x86_64_system_quick += [ 'memlock' ]
+endif
+
 tests_x86_64_system_thorough = [
   'acpi_bits',
   'hotplug_blk',
-- 
2.43.0


