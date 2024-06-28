Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4332AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPY-0005aA-NS; Fri, 28 Jun 2024 13:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPO-0005YW-90
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPM-0002AR-Aq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZr6EpxPTnCtfkI/16JpVzSMCa8vz0QSxvxLLnS2Bk8=;
 b=F4Ki1lG8YYs2cHnGN5VVIgy+JhQQK1CQassz+MDDvAMxx/+C1epYNOPk3ZjttOq2GH8g4a
 W1avYlxd1DRZ7vl37f+D560dmclZ926I5S6gJS6yUPv2K9IVh1Y7sh6h4sptQbCWyDpbxv
 edq5FkbtB/ev1dpSLyScFTjzVyXU+2E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-YxdTIJMnPICnGVWpjTaBkA-1; Fri, 28 Jun 2024 13:29:09 -0400
X-MC-Unique: YxdTIJMnPICnGVWpjTaBkA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d22ea3e71so606501a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595748; x=1720200548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZr6EpxPTnCtfkI/16JpVzSMCa8vz0QSxvxLLnS2Bk8=;
 b=UzYELiGEnkkiekr+e8+TlaUWzV14APNzsUYFN+cifuYBng4+HCSHzGuBJU/x28xwEb
 4Vu5usmramx70p5qaUnksHQUowrqOG3RaEo/5Kfoza9RyTgvUovl4rVYlzO7tM/agNyE
 kKL8x+boOPbFCtB3oCv5QFZWki/MZToSzk2BBjztSGMfxEV6PdQjB4AR8IDVywCDe3IR
 sckevlOgxA9Y3j0WERrFWxsboMOIM5BekhyWXhZTVjdVbDLBVcFxagViZbKEIwFwL5AI
 FpUZldRY+hzEVH6blyFssRiQJvAAr7pg4TZSnqSNDM2JiIAWz8JKuwnoXIqBTBLtOwI4
 Psmg==
X-Gm-Message-State: AOJu0YwhcezQ1CZKw+VniwgVh8ef+KDmfXGFkW3ufxvoTvaBD9ykRC67
 vvvz3t8K9iv3I2pqQcLGpIAiNk2JcJFE5bELy/lXdEQ5kRvqESEHzcQD/EcfivJnBiTAU18UG3y
 zWKdptOJs0iOFO69ositoBDx3kyiWgISDuYLeSE0pRmVNINyKD8QLm2Lz2soPvTdhK+tXI2f3oK
 tYz7HUFLKj6CStqPea/A8VOptYD5s4HoL7ZX4k
X-Received: by 2002:a50:c058:0:b0:572:4fc3:3a28 with SMTP id
 4fb4d7f45d1cf-57d4a28e8bcmr13800176a12.23.1719595747827; 
 Fri, 28 Jun 2024 10:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrLT2EykPq3z0vUTeobzU3w7rycYdNp4vNjPiZoymiOPwpisEhtIXVa2fHQ+6FULtTF+aDyw==
X-Received: by 2002:a50:c058:0:b0:572:4fc3:3a28 with SMTP id
 4fb4d7f45d1cf-57d4a28e8bcmr13800160a12.23.1719595747302; 
 Fri, 28 Jun 2024 10:29:07 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c8720dsm1288640a12.7.2024.06.28.10.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/23] meson: allow configuring the x86-64 baseline
Date: Fri, 28 Jun 2024 19:28:37 +0200
Message-ID: <20240628172855.1147598-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

Add a Meson option to configure which x86-64 instruction
set to use.  QEMU will now default to x86-64-v1 + cmpxchg16b for
64-bit builds (that corresponds to a Pentium 4 for 32-bit builds).

The baseline can be tuned down to Pentium Pro for 32-bit builds (with
-Dx86_version=0), or up as desired.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 41 ++++++++++++++++++++++++++++-------
 meson_options.txt             |  3 +++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 97e00d6f59b..6e694ecd9fe 100644
--- a/meson.build
+++ b/meson.build
@@ -336,15 +336,40 @@ if host_arch == 'i386' and not cc.links('''
   qemu_common_flags = ['-march=i486'] + qemu_common_flags
 endif
 
-# Assume x86-64-v2 (minus CMPXCHG16B for 32-bit code)
-if host_arch == 'i386'
-  qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
-endif
+# Pick x86-64 baseline version
 if host_arch in ['i386', 'x86_64']
-  qemu_common_flags = ['-mpopcnt', '-msse4.2'] + qemu_common_flags
-endif
-if host_arch == 'x86_64'
-  qemu_common_flags = ['-mcx16'] + qemu_common_flags
+  if get_option('x86_version') == '0' and host_arch == 'x86_64'
+    error('x86_64-v1 required for x86-64 hosts')
+  endif
+
+  # add flags for individual instruction set extensions
+  if get_option('x86_version') >= '1'
+    if host_arch == 'i386'
+      qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
+    else
+      # present on basically all processors but technically not part of
+      # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
+      qemu_common_flags = ['-mcx16'] + qemu_common_flags
+    endif
+  endif
+  if get_option('x86_version') >= '2'
+    qemu_common_flags = ['-mpopcnt'] + qemu_common_flags
+    qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
+  endif
+  if get_option('x86_version') >= '3'
+    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi1', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+  endif
+
+  # add required vector instruction set (each level implies those below)
+  if get_option('x86_version') == '1'
+    qemu_common_flags = ['-msse2'] + qemu_common_flags
+  elif get_option('x86_version') == '2'
+    qemu_common_flags = ['-msse4.2'] + qemu_common_flags
+  elif get_option('x86_version') == '3'
+    qemu_common_flags = ['-mavx2'] + qemu_common_flags
+  elif get_option('x86_version') == '4'
+    qemu_common_flags = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl'] + qemu_common_flags
+  endif
 endif
 
 if get_option('prefer_static')
diff --git a/meson_options.txt b/meson_options.txt
index 7a79dd89706..6065ed2d352 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -370,3 +370,6 @@ option('qemu_ga_version', type: 'string', value: '',
 
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
+
+option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
+       description: 'tweak required x86_64 architecture version beyond compiler default')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 58d49a447d5..62842d47e88 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -82,6 +82,8 @@ meson_options_help() {
   printf "%s\n" '  --with-suffix=VALUE      Suffix for QEMU data/modules/config directories'
   printf "%s\n" '                           (can be empty) [qemu]'
   printf "%s\n" '  --with-trace-file=VALUE  Trace file prefix for simple backend [trace]'
+  printf "%s\n" '  --x86-version=CHOICE     tweak required x86_64 architecture version beyond'
+  printf "%s\n" '                           compiler default [1] (choices: 0/1/2/3)'
   printf "%s\n" ''
   printf "%s\n" 'Optional features, enabled with --enable-FEATURE and'
   printf "%s\n" 'disabled with --disable-FEATURE, default is enabled if available'
@@ -552,6 +554,7 @@ _meson_option_parse() {
     --disable-werror) printf "%s" -Dwerror=false ;;
     --enable-whpx) printf "%s" -Dwhpx=enabled ;;
     --disable-whpx) printf "%s" -Dwhpx=disabled ;;
+    --x86-version=*) quote_sh "-Dx86_version=$2" ;;
     --enable-xen) printf "%s" -Dxen=enabled ;;
     --disable-xen) printf "%s" -Dxen=disabled ;;
     --enable-xen-pci-passthrough) printf "%s" -Dxen_pci_passthrough=enabled ;;
-- 
2.45.2


