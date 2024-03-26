Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CC8CD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 22:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpFWK-00069i-64; Tue, 26 Mar 2024 18:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWH-00068i-S8
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:49 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWG-0007aU-40
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:49 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78a5ec6a17bso27575185a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711493025; x=1712097825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlzr1/mxNhrro+EzJZYCMXcsfNMOc4LNKlEsuKNRLok=;
 b=ONeEQRULWzMVdI2UgW5ZtsrLUEaw9CLJ6N7B3BK8euHcOCUzye1MHjGcAfxiZ7+b1j
 zQet8TkxyRQ1wasutQu6H73xy4EQwhVcHr2nykPZoh4qess12nC72i/EEqjQDbJxgSAr
 QflqQ+JhCf8B2Y9dZZxmQvxsjYTSAk7Cn8J7AzweH6x6syF1iMiss/a/KZj0cl1uLcg0
 J8X+qpDgkjjJvy17aa5Wfg/Vr1bsnH6ZPnQBwp43W5mAJTUgm7sPtBWe0a2Wf2PQRiZV
 2iQkHoVnOAipw/O+Z4b5h3In+d67/89CnNfDidMOeLl+KVwN3cZuyTKFgKIYcjHqPGe9
 1Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711493025; x=1712097825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlzr1/mxNhrro+EzJZYCMXcsfNMOc4LNKlEsuKNRLok=;
 b=Tlh7qanidCQHkrewWc7tsp4TxxsR8Zs561z6X7kcuiQpmx05KssbuMWaBMZdaA4fVL
 BGt9rjtcHcmoRAzaQt21h74Og5bqjctWY2YNWc++PnOOyqEw3zim4+kM3VfSh1Pffk+e
 UV74xVKnvxJto9u0YSMUiFyjXKpxhKIhfZ5YRXWcbH3Cso1wPzvNn55OpxBmNrDg6qXH
 jnktB9iC5tCIFh/yKrnH4+6fWr+dly+ENdCneKZkFSGg4jMAKwfhFSycGeYU49s8v1HH
 1dgw3v7cz+mZ52/ClJM4fCFiIkH4neov0yl4Le+CPMrrXNat4tyaCarJwY0mAfQ1wpV4
 isDg==
X-Gm-Message-State: AOJu0YyUnEqIxWGXfsEFWNNDXRD8L1gSUx2ntxz7RmkAOEkwdG7+4Uy+
 mj2Lg8kb+Hdp2BrZep3Zz1zqZHHKwYN8aPK0L65SZfLPrMmTjkmie9DivyMn1rVLHJ683LtT9hC
 Z
X-Google-Smtp-Source: AGHT+IHuobs477Ig/8Nu/ySQ9JRQLFJwG0R5pUAEl+U7DutnMEFNvrIW2kuX7TAAFoQCG6fwB5RMZA==
X-Received: by 2002:ae9:c304:0:b0:78a:32db:9df4 with SMTP id
 n4-20020ae9c304000000b0078a32db9df4mr4370763qkg.9.1711493025538; 
 Tue, 26 Mar 2024 15:43:45 -0700 (PDT)
Received: from n36-186-108.byted.org. ([147.160.184.146])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05620a0ecf00b007887d30dbb7sm3397816qkm.60.2024.03.26.15.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 15:43:45 -0700 (PDT)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, yuan1.liu@intel.com,
 berrange@redhat.com, nanhai.zou@intel.com, hao.xiang@linux.dev,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v2 1/5] meson: Introduce 'qatzip' feature to the build system
Date: Tue, 26 Mar 2024 22:42:17 +0000
Message-Id: <20240326224221.3623014-2-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x736.google.com
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

Add a 'qatzip' feature, which is automatically disabled, and which
depends on the QATzip library if enabled.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/meson.build b/meson.build
index 0ef1654e86..aa79ee85bd 100644
--- a/meson.build
+++ b/meson.build
@@ -1198,6 +1198,14 @@ if not get_option('zstd').auto() or have_block
                     required: get_option('zstd'),
                     method: 'pkg-config')
 endif
+
+qatzip = not_found
+if get_option('qatzip').enabled()
+  qatzip = dependency('qatzip', version: '>=1.1.2',
+                      required: get_option('qatzip'),
+                      method: 'pkg-config')
+endif
+
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2299,6 +2307,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_STATX', has_statx)
 config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
+config_host_data.set('CONFIG_QATZIP', qatzip.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4439,6 +4448,7 @@ summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
+summary_info += {'qatzip support':    qatzip}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 0a99a059ec..106c540ce7 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -259,6 +259,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
        description: 'xkbcommon support')
 option('zstd', type : 'feature', value : 'auto',
        description: 'zstd compression support')
+option('qatzip', type: 'feature', value: 'disabled',
+       description: 'QATzip compression support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 680fa3f581..1afd373606 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -164,6 +164,7 @@ meson_options_help() {
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
   printf "%s\n" '  pvrdma          Enable PVRDMA support'
+  printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
   printf "%s\n" '  qga-vss         build QGA VSS support (broken with MinGW)'
@@ -430,6 +431,8 @@ _meson_option_parse() {
     --prefix=*) quote_sh "-Dprefix=$2" ;;
     --enable-pvrdma) printf "%s" -Dpvrdma=enabled ;;
     --disable-pvrdma) printf "%s" -Dpvrdma=disabled ;;
+    --enable-qatzip) printf "%s" -Dqatzip=enabled ;;
+    --disable-qatzip) printf "%s" -Dqatzip=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
     --disable-qcow1) printf "%s" -Dqcow1=disabled ;;
     --enable-qed) printf "%s" -Dqed=enabled ;;
-- 
2.30.2


