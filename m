Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5CCCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIs0R-0006ls-Md; Tue, 11 Nov 2025 12:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzt-0005d9-8W
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:38 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzn-0003vu-Ag
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:36 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6417313bddaso4821261a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881450; x=1763486250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQS9YQGXlgeLOTl3xkA9NMzA8j1lAZ6Lk0RjehvJU9s=;
 b=fT+vpc8nju5Gyl67tm7Z6CemHcWWmwVEjQBws73mdvD3L/+Qjz744L4qORePi4F8o5
 +FcEUvdmnVfQwsLrvt/HxyW2Hi9o/ngtXppL/naMOpBwkHwgpJmJf+kjXmbEsSRqVhse
 9HD6CpZlOyDLuxZvZnMp9YjR1FdEZJrxrqCGb902nIfRe8PiFY/A7Pvkd66S6AQfOZCE
 YZA2Jz8D8dnNULPTPv24SOTL+tJAL1BAkL819puyAoRldJUOqZ0pH5okPKNCN67S43XA
 LiyB1VzWl2qSmtDQPwAvka4admiVJR5HBQBCWd1nxlPuOM91NJ1zCQdC52HaEzKBln1o
 svrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881450; x=1763486250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BQS9YQGXlgeLOTl3xkA9NMzA8j1lAZ6Lk0RjehvJU9s=;
 b=lbaSiD2ZcOs1wlHUTFeWpPykAWbN32I08eDP7xXguDadWtWihYRzwmnX0KWa+C9z/I
 Ks9Gt5hF1G45bnR1QDC+SLtZ06o8ue36sZ6sj7OVIs5lzbCq0hd9IYmno50GtOF88Tfw
 zdjwqQhYL4sWHkgfLvn5PuxpKnfdsqFOKWEB5NR5F4dPGel4PJgIncjiZLAlGU6E/9lw
 lvSQu4MBpgvBCXRyHk+9EXD1cqH4u8dqTxT6Q6HgFcRx6kctB5wqv7zdOqtjg+dpaNjS
 XQcsMCVy1OEXr6wXYe54pmrihdBnNNgKZ6RJjSw85uP4c56l8ZM+8vEROYeLC2msPwtY
 QVWA==
X-Gm-Message-State: AOJu0YxArBLAgXZ2+ipH5vYx/QAnIy/Y3qtpxMHo0+7WrcsMtFsAiit5
 8eM9E2Z8Rzn4fZWyj1lygA75fPjD97KJZ7YUQxa4K6xD9WBhN+f7/FnAi3BvEp1uE9Y=
X-Gm-Gg: ASbGncvLJmkqdrf9GU9BS3zQ0A29SB9V8rqghnzY9EfXQ7N9+O1qDKwO0KygoMqdpGe
 opxOF9krcmX0cAOt+pun4Zg0+hZUJ74r8ffpUcrl5tPDyuRlUAZ5Ne9L3Q/mIDVPINdVwoWxFFt
 L6yx5KcWVVPaDunH0y/LI4iUSTPnbULj4hs7dz8YL9X304GBHDIFo4LRP8Az82WJ+PI5Vp9hBv5
 W//cojz6dDwIk8jal1CK1prsvjxrLzDDw6lWV19IvFj7cteP+WALDx9uWnlWY76vhz7RqemJsKt
 PSM4qeGy8x7DNWB1+RRK8dLRdTzf+UsZB1u+iwdH3tUw9Dxium1Q8JtaMDTHr25Ja/MbBZ6DdID
 WMb7i1c2N+R2rUXUr0OTYjKIeegz53grSkmnRMv7P00oZWFif7grag5Vx50w4uPGqif8vwTjop1
 gA2s7KfnwtD/qpzBYMM4mTSA==
X-Google-Smtp-Source: AGHT+IGmR/ME3olvSM99X6DoR1JwsuLQOmDgc8wTfZ7holzl8IRHnHFVCVyVq8lk0Y8ZWbvqZT7lVg==
X-Received: by 2002:a17:906:794a:b0:b70:50f0:e6ae with SMTP id
 a640c23a62f3a-b72e049248bmr1277590766b.46.1762881449654; 
 Tue, 11 Nov 2025 09:17:29 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bfa11271sm1375799766b.66.2025.11.11.09.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:17:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4521F5FCBD;
 Tue, 11 Nov 2025 17:17:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH 08/16] tests: move test_virt assets to share.linaro.org
Date: Tue, 11 Nov 2025 17:17:15 +0000
Message-ID: <20251111171724.78201-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111171724.78201-1-alex.bennee@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site. While I'm at it drop the old pauth-impdef flag
which is no longer needed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 tests/functional/aarch64/test_virt.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/functional/aarch64/test_virt.py b/tests/functional/aarch64/test_virt.py
index 63071f9b517..972b7bf783c 100755
--- a/tests/functional/aarch64/test_virt.py
+++ b/tests/functional/aarch64/test_virt.py
@@ -60,8 +60,7 @@ def test_alpine_virt_tcg_gic_max(self):
 
 
     ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/'
-         'z6B2ARM7DQT3HWN/download'),
+        ('https://share.linaro.org/downloadFile?id=3zGlbmXh8pXFewt'),
         '12a54d4805cda6ab647cb7c7bbdb16fafb3df400e0d6f16445c1a0436100ef8d')
 
     def common_aarch64_virt(self, machine):
@@ -77,7 +76,7 @@ def common_aarch64_virt(self, machine):
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
-        self.vm.add_args('-cpu', 'max,pauth-impdef=on',
+        self.vm.add_args('-cpu', 'max',
                          '-machine', machine,
                          '-accel', 'tcg',
                          '-kernel', kernel_path,
-- 
2.47.3


