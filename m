Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57251D6A247
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 22:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBhuY-0003Mj-15; Thu, 14 Nov 2024 17:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuO-0003MQ-34
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:01:48 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuM-0007dk-7V
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:01:47 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b18da94ba9so96403085a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1731621702; x=1732226502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2shGJzNrO4ttucD6ydWtQy0fNVwT+v2Fj5gAFSJcfE=;
 b=ZAnHXPMF2Y2A14EuML4JV2dTblno3/s3JCNbqfPIGYt/n51Zm5e0muw89mcCTPixmW
 4v1lQ0R0d0gkGeJFnFpw20lszN0/S2o+abYGTjmaBrcXTdlOom7sElSEdsuoEoMqH9eI
 IHEN4TJiyhW+qK09GB7MhgkBfdosuO8kDjX/4pMU3xqIQ6inXf0h0zjM2Ol/0SFzHs/r
 S/tOvNdL9GZMD/7+2CRC1OY0qo02MNbGlamw2rL1ECVuNt3HLzNfKYEzdm2/v20C7aCD
 AITyowyovcHyzyJ3ZGtXHnqvnbz15YsOyEsuZdyuLAH7ZaXw8AuB8zg+B+T9gPZdU6Vt
 j8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731621702; x=1732226502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2shGJzNrO4ttucD6ydWtQy0fNVwT+v2Fj5gAFSJcfE=;
 b=NmGyfp0zIWssz2KmAJ9jKLSoqFpg4BBPTKjcM7+AFYk5SWUXfdfgC6tiXSyRMuT1/u
 qg1I5Vc7YGVTWbfce7ovsErXzccTBgxmX1NnkP80sCLIhkkXpFHy8pJ0w3j5AXGdPm1J
 JziB6T5CBiB1ic1Ebx8cZrrOPT/55IhuoBOA8NYJXdi/PLV6aXmgjXKH+6VJPJBCCh3q
 aK86MpXB/WYt7ZWv1wqF+UwAASN+zU0v8FYx+uKbD5v9v7WoIkE9sVs2TiW4B0ENdeqL
 H9AbsAtko2Za+60Y5zxOHCvIwUhgJNxLUMfiudNxFtftplJk4ynNO+WSWmTUrae996zF
 o6fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfUTk9/Wxkb3OQ0tebyfSy4cQUcj4ZMRJCA9IAi1XoU6Fu7h5BuCl2qJz4hNghPHDeboINpDx2e5dk@nongnu.org
X-Gm-Message-State: AOJu0Yy1pdsYMdquuocC7qovQOm5MYZoygAOz97kYAXkgCwGB07/f+RA
 Fd0eD/CGqzG8QI1mgGJ9Rxnwk/7xJumM3dvgxNqKWWEKj7THmZPWx7ExrHw19RY=
X-Google-Smtp-Source: AGHT+IE5ZfxJ9JnXL9+p4qk/aeSEj3SLjuZjF0gGDi76MxHyQTRWthj3NfrVueuGoa/8NAgrA2uFng==
X-Received: by 2002:a05:620a:c44:b0:7a2:e2e:31c6 with SMTP id
 af79cd13be357-7b362005b43mr109464485a.21.1731621702187; 
 Thu, 14 Nov 2024 14:01:42 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net ([130.44.212.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca308bdsm93742485a.83.2024.11.14.14.01.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 14:01:41 -0800 (PST)
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
Subject: [PATCH v7 01/12] meson: Introduce new instruction set enqcmd to the
 build system.
Date: Thu, 14 Nov 2024 14:01:21 -0800
Message-Id: <20241114220132.27399-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114220132.27399-1-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qk1-x733.google.com
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
index e0b880e4e1..fbcb75d161 100644
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


