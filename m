Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4847AE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIerv-0003qN-It; Tue, 03 Dec 2024 21:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIert-0003q7-KW
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:11:57 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIerq-0005PA-Lp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:11:57 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d896be3992so19272376d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733278313; x=1733883113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0wN4j/oJJNTRC4MBF1twlWeye36pdO8I/CrrqHAcjQ=;
 b=frxrB2IKlmySaXuNaEAhw1cfQdcHOpzwLIm4DeokjllG88cLFk6zIDlFC2DW4StDTm
 ZYVNda2jakU470KQiUQ81CJPCasXM+HX0Chizn6hCepwS93Ofp7D14kMkhighw37wSp/
 sVgtfC5xGFvuX0zJb9DjTas3EanEgR1zE5Bf/Q45vjI8TSL1t21YOCX/UeufaEJVAnWm
 ZvrUxi/Bi3rdaql4g6nzsl/mN+p7dmm9DZav8TPGMD9oeDKyaIxAD2757hDpD1cqYa3b
 AD4SbtJKPf55auC8WUBN6fKIW/bGX7axZk0ahkEzanmDRxxWgdMGB4lYVbz3GBKipFZN
 NVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733278313; x=1733883113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0wN4j/oJJNTRC4MBF1twlWeye36pdO8I/CrrqHAcjQ=;
 b=ksxcckKbRczC6b1xhVD8zd8Cnustp4rke4GX0MqvWLbzABCmDy+fiu/iIGD+QJnGjY
 yYZk/Mcvm6OF3dIaxK27ve4uw1oNLT7tLlNpnudWs6XF8V1yD6dEX5diIR2fhvgP5hEn
 T7TG2SA7xrrqeThEQIL9joWp9Y4HgUZ2vRt0iAxlK5xCABO0ZFNIsaMsfWfFixOMqNzy
 /mN7b3xSQn2hCZCY89DOfwsiMBUj98vvumxpNaKpV+CCeEKCe+zWp9jhKgRDFMPbCGvM
 bsVJ/ZLP5g+X6XADZkYCCZ7MLL3uDDGJeW8VK9O2+B+/4Vmqo1yVmVntoumxSDbrIrkB
 g9+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHJ704PO6JrDlwnsscwiViiF/WCGaKkowpHqQrdFEIefKSIz2PGpftMDbRQiz8KVD+W9xj6C6spATN@nongnu.org
X-Gm-Message-State: AOJu0YygvJwNWYveN63XBawKFW89c0EiEOYhNurHS7s7GoRHS0dmF1Bo
 bhDOTNDDY8uK4inOQTDtZb4um7LGHQV1OI26QOyp4WNaED6pALGZDVxidi42iEQ=
X-Gm-Gg: ASbGncvyc+X90A6uu2+o9/3/VjZlH6zMB19mEI3Bk6Dmh2QdiEw4MH+1QR7dXqP8mt8
 Fnf+CP492UJEOj6Xq5bVLp0JaVXmes1t4YI0zYP/ksgm0qySNNgFp3Xm1uIhHN9VgUCZ2jmZsrx
 kDrsj/KizCEL7pxu34vxpCA93UsDTRSwyMKTfzBN1fRlOyWOpOCnD5Yiwy4xL+Nbi2Em5x1n6ly
 XpidgZ0kxZzvxt3FfdiiBsZfnR03VN81HFkutQaPz1zU/fzYOqqniaI4GhNUdoEmovi7t8G4ipe
 iBtYmn9iyGRLsU4KqQ==
X-Google-Smtp-Source: AGHT+IEN99xczOXj8OW/XtgjGtM089VwEZOvzDW5uzYqGf7/sMYDdnkqq+ragp9D1WtsYWXJ4C/2Mw==
X-Received: by 2002:ad4:5bc4:0:b0:6d8:ac5d:b83e with SMTP id
 6a1803df08f44-6d8b747b62emr97529876d6.47.1733278313526; 
 Tue, 03 Dec 2024 18:11:53 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:323:644e:288b:2b6d:d94c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87ec537ebsm63488986d6.30.2024.12.03.18.11.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 18:11:53 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v8 01/12] meson: Introduce new instruction set enqcmd to the
 build system.
Date: Tue,  3 Dec 2024 18:11:30 -0800
Message-Id: <20241204021142.24184-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241204021142.24184-1-yichen.wang@bytedance.com>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2d.google.com
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
index 147097c652..50df5dd3e0 100644
--- a/meson.build
+++ b/meson.build
@@ -3062,6 +3062,20 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
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


