Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B53C2BB85
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3U-0000Vy-Qv; Sat, 22 Jun 2024 02:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3L-0000Qr-9g
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3J-0006UV-Cb
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719037004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zJrXRaDXBIm9h7tTU28UT9xcD/K/7uFNW/URjbJHRw=;
 b=M+IdJz6LvSGIU2sihWZw9kbgZvImBO+lpWOweL4i7IEATaH65eiSdYpdvUijGouF/J57Kt
 tXW0Z340/9dqo6h7C2pC9DGZlNZTf9YiUsTsIvB26JM+no9y6Exa75Wvc0ljVwcmJca3u9
 MTm8pn+SWEJ+S1tCtbFJ5+wLgqS1E0Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-w03g5oJYMemwQTdB07K3Hw-1; Sat, 22 Jun 2024 02:16:41 -0400
X-MC-Unique: w03g5oJYMemwQTdB07K3Hw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57d3f1d20adso466509a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719037000; x=1719641800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zJrXRaDXBIm9h7tTU28UT9xcD/K/7uFNW/URjbJHRw=;
 b=hifVjl30grCH1w0R7uZ3YmdZwQNt4uGWYNWXPP2eeZhenASsIdFyfqmc/K2/q7vjgU
 1tKc2CKtRfbZIdkEqyNW9R/bDm/cc2xwG4Uvgeu8/Mt+vWzT30WL7uvq8JGQNJgKQC7V
 O02JWvdiEYaq2/ty2EeRIK7afznfNZ83LPSXiG4TDDov7XkonnuqXeWklbIsSCr9DeHf
 DAkX7mlpopi6+9gXqfTLDXN94cWW+unjP7jLBCvx/Ola4cbR8G1gJrYfdusAXwZ9Netn
 Ys4N7zSc1GBNInWIB0ndXUL/T5gU5owcyZiHvCS2BngPfAJRmYSH0zHpmv0YaFE02yX6
 kF0w==
X-Gm-Message-State: AOJu0YzFzCez1Sz2aWAFasZEVraZQ4XLVL7vzh3Lk3ehdpsBc9gEx5c1
 JcC+yy55paJk7Y3AHj189SKms2pt/ugeylDYtplW6chXkOFEr7Lvw8oNG/Ul+Sztx2KeX5CMZRP
 0yVJEWroTx43rqMif85FCjAztzpKeY68CjsSGOwiNiiAzcjYDVh2/CDiwcl2bFVvp+diiCuQLAw
 ANe0aq/Xs1UFqMzlLzhP7IcpvPU2MGn+LWAnVB
X-Received: by 2002:a05:6402:184b:b0:57c:6b49:aef with SMTP id
 4fb4d7f45d1cf-57d4483b0ffmr350113a12.11.1719037000063; 
 Fri, 21 Jun 2024 23:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK0wmR8jmoYRTxchYKF3rgI0Gwaz69fLnuEdn7aGZ0+gSYclcQ/Pl/MBtOKJPM3iVieMIkmg==
X-Received: by 2002:a05:6402:184b:b0:57c:6b49:aef with SMTP id
 4fb4d7f45d1cf-57d4483b0ffmr350109a12.11.1719036999807; 
 Fri, 21 Jun 2024 23:16:39 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534b25sm1863380a12.68.2024.06.21.23.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/23] meson: remove dead optimization option
Date: Sat, 22 Jun 2024 08:15:51 +0200
Message-ID: <20240622061558.530543-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 13 -------------
 meson_options.txt             |  2 --
 scripts/meson-buildoptions.sh |  3 ---
 3 files changed, 18 deletions(-)

diff --git a/meson.build b/meson.build
index 6e694ecd9fe..54e6b09f4fb 100644
--- a/meson.build
+++ b/meson.build
@@ -2874,18 +2874,6 @@ config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
     int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
   '''), error_message: 'AVX2 not available').allowed())
 
-config_host_data.set('CONFIG_AVX512F_OPT', get_option('avx512f') \
-  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512F') \
-  .require(cc.links('''
-    #include <cpuid.h>
-    #include <immintrin.h>
-    static int __attribute__((target("avx512f"))) bar(void *a) {
-      __m512i x = *(__m512i *)a;
-      return _mm512_test_epi64_mask(x, x);
-    }
-    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
-  '''), error_message: 'AVX512F not available').allowed())
-
 config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
   .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
   .require(cc.links('''
@@ -4283,7 +4271,6 @@ summary_info += {'mutex debugging':   get_option('debug_mutex')}
 summary_info += {'memory allocator':  get_option('malloc')}
 summary_info += {'avx2 optimization': config_host_data.get('CONFIG_AVX2_OPT')}
 summary_info += {'avx512bw optimization': config_host_data.get('CONFIG_AVX512BW_OPT')}
-summary_info += {'avx512f optimization': config_host_data.get('CONFIG_AVX512F_OPT')}
 summary_info += {'gcov':              get_option('b_coverage')}
 summary_info += {'thread sanitizer':  get_option('tsan')}
 summary_info += {'CFI support':       get_option('cfi')}
diff --git a/meson_options.txt b/meson_options.txt
index 6065ed2d352..0269fa0f16e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -119,8 +119,6 @@ option('membarrier', type: 'feature', value: 'disabled',
 
 option('avx2', type: 'feature', value: 'auto',
        description: 'AVX2 optimizations')
-option('avx512f', type: 'feature', value: 'disabled',
-       description: 'AVX512F optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
 option('keyring', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 62842d47e88..cfadb5ea86a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -95,7 +95,6 @@ meson_options_help() {
   printf "%s\n" '  auth-pam        PAM access control'
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
-  printf "%s\n" '  avx512f         AVX512F optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -240,8 +239,6 @@ _meson_option_parse() {
     --disable-avx2) printf "%s" -Davx2=disabled ;;
     --enable-avx512bw) printf "%s" -Davx512bw=enabled ;;
     --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
-    --enable-avx512f) printf "%s" -Davx512f=enabled ;;
-    --disable-avx512f) printf "%s" -Davx512f=disabled ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
2.45.2


