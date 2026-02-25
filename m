Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D593FF55456
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6jM-0006pK-Mb; Tue, 24 Feb 2026 23:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6jI-0006p8-KG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:42:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6jH-00087J-4Z
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:42:32 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso77426815e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771994547; x=1772599347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RJKcGpI3BWQkykwv/8dSycfPJcSPcUWs0ocwwh7tSYQ=;
 b=larLSVR+Ag613KyyrkrRvaoLCTVQcH5F1j7aWTZPv+vpCFsoXUZ+DFfAveIVssfglV
 qkbsdNdzfj3Jeb28FCzlN+7VUu820zqg7UhHGmgO4yfcLA0Ua0s58lJJZz+nvpaC4qOd
 msr/UyJrehrz40zPJ7BghRk52n3qE+4ALKyv0HOrl2UekOtIHJCZQB1WfLN2xdZej5/N
 ID1oFyHGDs2qPFfMgkR1CJe+KkNKydQm2vc74IQbANgkpQDCohmpxauAL/AMtqDLfBrT
 yNWLnbtPKJ+/FFfDt1904cF31hK2+toFiQnIor6fQpHIqySYs0pkwDnDm2YTYFuGgTM7
 OA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994547; x=1772599347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJKcGpI3BWQkykwv/8dSycfPJcSPcUWs0ocwwh7tSYQ=;
 b=OtAAS/2fK3slxe3cwlD4oQJKexcLWYpY6tZ/kfmcHutQVrs3oHQxt2miSJeIdRDN8p
 VSvllpzw7VllV8OxKfdpsaEpxoh5z/w6DLKLrhCh6IoirePsbZphA0ozzhpP/TKBEjlX
 /nCtuKqIXXqHua7s/GJ/qUnn/GCmo9FEtlKBi2C3pPqOi7g+GQ1iHd7r1hEdjR48xKUI
 2ezsR4FelPEbCVUxx95UcoxfR8GRn/hiTrTL7yLGC6Rn7ffKLbXVaNI58ZO8Mv9+i3jV
 op9PZ3WZmyT8j34X2ej+sNVxK2O3Horm0JHmNGEro9Qz6W7pOE4g+yz9yzZL4M3spZ1c
 0Ttw==
X-Gm-Message-State: AOJu0YyjRXV6eeCoLqcEYCrVutYD2mmHKi/8gGMPC5eiV1fg8vPJbXMQ
 xFoWW0QwX4z98uAVmbD8Q0470q2m8PEIG2V7z/m2bit1eCtMJjEaRNnTjIMOiutDm5NArY6bL0n
 Mrwp3cMk=
X-Gm-Gg: ATEYQzy7T4h/KMIJV/I1YTLfDVndHtDMUCtnxibVH3dILVYqZi8Q7NGIgEHudL95OAw
 2yj0AcRkFmee05Jgj/0VulmJcbzG/2kG22Oh98J+zwiDLUwktQlYamdyxmjF2L3xDomRzeDEkpJ
 Gg4z0ZQrTzMYfxF0oS18K09/LGJ9B7wVrJozhkW3jwQxLyCHJzvgW9vdKYLEg0GSHsn6EPjVQlI
 4CFrE4Vi0Gn3GwvYceVK22cftQxm13t4NuJx3mUfGWf5Soli1LFCBYzm98gps4j00HRShjG0myi
 d3FWxCKpmPpXj1QspS9P0rsNncAT/cI97Mut+e26P0zgzR1nfzCzZ1KYmttsHc2tfZ9fH5naiUW
 Ou6Un9RgpyNfSomJf6Qy2UAiJDUQjCHdz/welvEcVs7Sj8BVs2OecOuDN4awG5zB1AJlu2XfAQu
 jgssnzo3cosFZ9LR4XiZlJJZtEPbkUEq5xYBEGwo+TgGjAlaW088a0tf/XlYRzQvQyTLjkwDJN
X-Received: by 2002:a05:600c:4fd5:b0:483:498f:7963 with SMTP id
 5b1f17b1804b1-483a9637a61mr204412185e9.26.1771994547150; 
 Tue, 24 Feb 2026 20:42:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb2c5a8sm3420335e9.0.2026.02.24.20.42.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 20:42:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] accel: Build stubs once
Date: Wed, 25 Feb 2026 05:42:25 +0100
Message-ID: <20260225044225.64059-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build             |  2 +-
 accel/stubs/meson.build | 19 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index db051a1b87b..5fecd6103a6 100644
--- a/meson.build
+++ b/meson.build
@@ -3731,6 +3731,7 @@ subdir('io')
 subdir('chardev')
 subdir('fsdev')
 subdir('dump')
+subdir('accel')
 
 if have_system
   subdir('hw')
@@ -3849,7 +3850,6 @@ subdir('replay')
 subdir('stats')
 subdir('tcg')
 subdir('fpu')
-subdir('accel')
 subdir('plugins')
 subdir('ebpf')
 
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 48eccd1b861..fd5b8b0da5a 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,10 +1,9 @@
-system_stubs_ss = ss.source_set()
-system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_MSHV', if_false: files('mshv-stub.c'))
-
-specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
+stub_ss.add(files(
+  'hvf-stub.c',
+  'kvm-stub.c',
+  'mshv-stub.c',
+  'nvmm-stub.c',
+  'tcg-stub.c',
+  'whpx-stub.c',
+  'xen-stub.c',
+))
-- 
2.52.0


