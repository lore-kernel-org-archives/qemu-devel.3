Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF95E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 01:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQFkK-0001Pr-Ob; Tue, 24 Dec 2024 19:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkJ-0001PU-12
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:31 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkG-0000N5-M3
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:30 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6dd43aa1558so18296836d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 16:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735088368; x=1735693168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhWIos1irDAhyI8JsAGZOunWg4JAWgOu550FM4dnzHA=;
 b=F1lKeWRJXTj+qv0KpYqU4XbPn8M3IK4SLofJ4EdcuTRu1+hRWSCfjju2qMvvw2xOPh
 xPtmUH8373xAX5WJBSwelFiK4CbZ5IUfyme5VT/w94APKT7AnHDVCRL7c7BiFJLUj3ZS
 Ynm0FDf5x2ZYo6MdYzwq8sS7WbnLf3lGqlWIP5llAd3oX+d/nowOvYLqnlFdc7KMEzRS
 S6CmyvNYZHNJHpgr/WHsuqxvLgvpX6JivYmfeh70eHxnN9Sq44CbZYoXHmOFWJRHwhdj
 ZcgVTNWLGlwbKuz56XwBkHGxUcL840/b32xkfCizjTtpFuqYQaOwt+apDq1E3y6Lue3V
 HEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735088368; x=1735693168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhWIos1irDAhyI8JsAGZOunWg4JAWgOu550FM4dnzHA=;
 b=LL3lb5VrrZEZFWJzgi6hgk1h9XLK5ZLx+cyBdgsJjx2DJnosSorCwjMSgqZdxO/S1S
 rII5lBch5reDaRrmYppotYpPzOXy8LbNBXUMI+DLR7IVbVOoXheQVEC7eKJO9ylfgZ3S
 gUrIl2TGC/Pp5AzEJuEABXgOfRw6eaH5sT0XUrnZF1fflhJQ2SvTeTJDyUWgJ1e8q09U
 xloCvZlPpv15J3ieHn4dOMISHsdKFScmLKBgwIPWCXI9hQSKLnqDA6gm54dDuAirR2cm
 GuPrSDLZr7aRwbEb0PWkJ6fYM/317xBQ4s/D6bsrBYb1+CwFVA72UOe6GgYUKTWSthZ9
 pPbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg/kCebY762IFvHUxOPX/benkiviZ0X5fdA5IITIp2Ew7f0CDSvTvm3QGn1DXzinjbyfG6b0U4bNXl@nongnu.org
X-Gm-Message-State: AOJu0YzYYw/KohiTijZyjPkGa1iaJCpXxC9XwZKVbAOmqbhtWvBXW8yy
 P4D1ZeAmJHwPSvO9iQ4Su+Q5r9tCZwdEvVRNaqWlkOYlwbyZPdAX2H2aib7cn0Q=
X-Gm-Gg: ASbGncsyPATkAtbRDaFizDtY6zWVIDgvhdgu9xU7NkvAJN9PALGs+IhoxgU1lqx9sLf
 aQuO6E40aN2zG1zOZQ0mRzaG9YBLpDPJjjsx+JGCo9QtG/8jn+XYuYHu43v0qvyR+EmGnuhmQ4u
 o7wSvaW7XJ6SEyjbzRUwsRPyn0HU00NvIppEtbUxazXfPNuuHjgGIqzqfEXCjnmvVNwtLXEtCI5
 95lhQu0ts9TEZoa6zvuWb3kEv3J3xQ5o621Sh7+tkW6oGjwB/S3Xqd5u3sUlGKEKZV2L1HF61YD
 LiCW8ZRgLxaJwTWFF94VFkuV9A==
X-Google-Smtp-Source: AGHT+IE4ra4WAsv9EXwJywm+K6QozauDChxhcOuWRwEFC16NylGELdg9XEy3XTY2+Lp8ge8xAPGEAg==
X-Received: by 2002:a05:6214:1d28:b0:6d8:7ed4:336a with SMTP id
 6a1803df08f44-6dd2339daecmr264980456d6.31.1735088367695; 
 Tue, 24 Dec 2024 16:59:27 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:1799:4ca4:2dd7:ba38:ecbd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d244fsm57318206d6.98.2024.12.24.16.59.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Dec 2024 16:59:27 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v9 01/12] meson: Introduce new instruction set enqcmd to the
 build system.
Date: Tue, 24 Dec 2024 16:59:08 -0800
Message-Id: <20241225005919.26853-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241225005919.26853-1-yichen.wang@bytedance.com>
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2e.google.com
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

From: Hao Xiang <hao.xiang@linux.dev>

Enable instruction set enqcmd in build.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 meson.build                   | 14 ++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/meson.build b/meson.build
index f4109cd3ca..44ebbd7b68 100644
--- a/meson.build
+++ b/meson.build
@@ -3085,6 +3085,20 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
     int main(int argc, char *argv[]) { return bar(argv[0]); }
   '''), error_message: 'AVX512BW not available').allowed())
 
+config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd') \
+  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable ENQCMD') \
+  .require(cc.links('''
+    #include <stdint.h>
+    #include <cpuid.h>
+    #include <immintrin.h>
+    static int __attribute__((target("enqcmd"))) bar(void *a) {
+      uint64_t dst[8] = { 0 };
+      uint64_t src[8] = { 0 };
+      return _enqcmd(dst, src);
+    }
+    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
+  '''), error_message: 'ENQCMD not available').allowed())
+
 # For both AArch64 and AArch32, detect if builtins are available.
 config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
     #include <arm_neon.h>
diff --git a/meson_options.txt b/meson_options.txt
index 5eeaf3eee5..4386e8b1fc 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -125,6 +125,8 @@ option('avx2', type: 'feature', value: 'auto',
        description: 'AVX2 optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
+option('enqcmd', type: 'feature', value: 'disabled',
+       description: 'ENQCMD optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 option('libkeyutils', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index a8066aab03..ff6c66db1e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -99,6 +99,7 @@ meson_options_help() {
   printf "%s\n" '  auth-pam        PAM access control'
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
+  printf "%s\n" '  enqcmd          ENQCMD optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -246,6 +247,8 @@ _meson_option_parse() {
     --disable-avx2) printf "%s" -Davx2=disabled ;;
     --enable-avx512bw) printf "%s" -Davx512bw=enabled ;;
     --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
+    --enable-enqcmd) printf "%s" -Denqcmd=enabled ;;
+    --disable-enqcmd) printf "%s" -Denqcmd=disabled ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
Yichen Wang


