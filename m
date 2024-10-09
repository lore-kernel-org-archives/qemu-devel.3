Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9ADCED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygPA-0002zw-VJ; Wed, 09 Oct 2024 19:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygP6-0002yw-Uz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:41 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sygP4-0006ba-VT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:47:40 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbceb48613so2465476d6.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728517654; x=1729122454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OLRasB0CC5bovyz2wxcoxtO2uT5qwr3ejcqOwE8FJE=;
 b=Gmz0Zcm10/Gd6Ei3dwkFi8UWXBfJRM0NEUa6y9QHs67FC7qLiLHZ+Mz0Sxqal+0+Qs
 EhQxh0K4AwqdeaxmFannjpNa0sjphZaD7JIhs7NGAV9UT7trIhG9RuTQN/JJsx+39vZR
 wmzgW9/aH5BSVFjeSYzUF65oInaPQNogqve+XcUSmQfwJrVOMse/opz1pre2vQPhuUYn
 B5kZB6jOfMeFU9ifJlw4jZQd2RmjHaMPKKfRd+2XNbp/Ry3RR51Na3xmGzu8J2lrz4L5
 iaS1jkrg2wlcdkgM+ebtWdNQp1yzNFjV0j2Qm3foLEgzYGRXN8aM0ejPE5XjYH9V6nx+
 c/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728517654; x=1729122454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OLRasB0CC5bovyz2wxcoxtO2uT5qwr3ejcqOwE8FJE=;
 b=jgYQLJNIr9NiV74t200tZtHKYymY+KmnsC2qFNKNPhEq+MULZWjY3AFOAD19qrKvwR
 UU4aKrFsOLGF1CPMCU9ep3PNsaTHL23HHpG59qJZ6bcTaUd34yLQjQjmXPJNEbn5zatU
 RaReUEZj67Mdu0Lp5boDiDdNfWSkjNuh4BCOUkL27tE6UbaOK/Be7SOTBvyEKmDihNOA
 FS0QID/a2jaoVHJWVLna0lJ8U6HGaz4aOrc/VkmkUl3CSuc5OXfB94Jpxxuhbz4IMTZD
 CLT6RZqtcfTxYSUtPsvv0f1DmxmYgAcgwN5hu/j7L/+yMoZ9S3Br7FLJtoZa9Rrkaz69
 SY+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNi33B8pjC5H9A/pSg+fCd6c2qNZf0HM7bbOz8ENpj91p/6cmXzyQmE0o24ekJHzaxCVjRpEtTP+5k@nongnu.org
X-Gm-Message-State: AOJu0YxlVwNkf/+n3L87UzUup8yUBHrcVWMFfbACRUqog5i/6yAoHzOV
 atNS2H3ArtT5EwqKSuKFPTK8DArTPs7XcRZcrlIRKF7Z0Z+z7V5DGwyY4a+jIws=
X-Google-Smtp-Source: AGHT+IE97e9pilUf2xOw+kfKMNGuAbQW9PAJKWk1g1U2+F99rdMyWaBk+y6DKVGmyRbTzDLO16dSPA==
X-Received: by 2002:a05:6214:3b87:b0:6cb:a355:10a9 with SMTP id
 6a1803df08f44-6cbe4b05ff6mr25716966d6.34.1728517654104; 
 Wed, 09 Oct 2024 16:47:34 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([2605:a7c0:0:301::44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85d856fsm264386d6.72.2024.10.09.16.47.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Oct 2024 16:47:33 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v6 01/12] meson: Introduce new instruction set enqcmd to the
 build system.
Date: Wed,  9 Oct 2024 16:45:59 -0700
Message-Id: <20241009234610.27039-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009234610.27039-1-yichen.wang@bytedance.com>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2b.google.com
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
---
 meson.build                   | 14 ++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/meson.build b/meson.build
index 4ea1984fc5..a7b545cd88 100644
--- a/meson.build
+++ b/meson.build
@@ -2954,6 +2954,20 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
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
index 5ee1d95c9c..2c02c654f0 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -123,6 +123,8 @@ option('avx2', type: 'feature', value: 'auto',
        description: 'AVX2 optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
+option('enqcmd', type: 'feature', value: 'disabled',
+       description: 'ENQCMD optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 option('libkeyutils', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3bee1c56df..f6c7f1251e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -96,6 +96,7 @@ meson_options_help() {
   printf "%s\n" '  auth-pam        PAM access control'
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
+  printf "%s\n" '  enqcmd          ENQCMD optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -241,6 +242,8 @@ _meson_option_parse() {
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


