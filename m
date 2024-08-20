Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE04AC531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 17:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSMG-0005yn-7Q; Tue, 20 Aug 2024 13:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSMD-0005ru-UI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:21 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSMB-0007h2-3i
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:21 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6bf7ba05f75so38826706d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724173758; x=1724778558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6kzDBDnEq23R80njs6FyZJuIYVc6qdV8gw3M4/+OWM=;
 b=i4LNfTqz+o9pAMFD0Uba7DGg+f+3fdDTkNqj6qoOwwXzTiKhSm7bu0nLf03PdQfDmc
 GyyYwajB9HYA0daNB/5xYbPPkNs/rrNP2Lt6+SzIS7mmE3zmk6hK6v8tcOJBVs1bWViN
 gXwWSiqyqbQx8SuJpxhgTJtC3BTyCFyJFhonAzU0q+9LBwSrQ/ps5/57l/4VFxrQ9D4o
 TMz4tnGqpGwIxgs/wRSMCLvmWQsOPwN9gj+qRu/sv/Rj2o8GqbYzJKWDwjZAGTmaJ7Cb
 o2aUsL/n1NeFWqvZo+VdTRVgDV192YgTJIHzZGunl7yYWEqKOf/gpouhDn6sTn8Wr6Bf
 jaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724173758; x=1724778558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6kzDBDnEq23R80njs6FyZJuIYVc6qdV8gw3M4/+OWM=;
 b=j71EhBcPzcJD8l9hGjoGaI+zJooBTPJKbTmNLP44ADHSCFv2fwuVs8XhPGh4tDGG6k
 K8CDzdhFqf858/xA3BIaDCWYac7IjmdrRT2wF7JELam3B5qrCUmLfgDjBB+NrvXFTZ1R
 lZScAEVM/CTif7P1lpQ3f03A7dIKpaY/Kx60iEb+6fiuMewYmIawMncE4G+WqWWt7YXb
 OiBOFHya8lQ+77Xj9VZDmrQm+ftETYf8UeOR2zVA8RmJhxVSkRmxXejAeQfkhNytd/kf
 8BiuPVqcB4iKnsnMYmHGKpoAYb8Z64JHiUzV4XZh84CFdgBMKDCZqGzTJtWbW11/6mc3
 cBmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4rN2mAs9Mu+ZRRO2NSkvtplLgwyvrrlWfWnboCtMYHfu172s1oSIzRuZs3WhrK2svdR4V29kFP21e1S8asI8m1dHKCdM=
X-Gm-Message-State: AOJu0YyENhgQpMN9Q1ooNVA9gp4dxHmUHbnv+38268BcWLAbCMN3p4mU
 1HALeWDSxYZaApjOUxZC36jQcrz/e+bLiEdjXl+YsaPbcNS/X7gn1Dm6fcBz4dY=
X-Google-Smtp-Source: AGHT+IHXbRAdnhxvzhPI7H60DxxKgWxBwlsNXbKXlcuZHPxQ2t4mPDx1anr2i5EEWNCY+Hg6SuBxsQ==
X-Received: by 2002:a05:6214:4981:b0:6b5:7f19:e61d with SMTP id
 6a1803df08f44-6bfa88dd5aemr79875446d6.6.1724173757971; 
 Tue, 20 Aug 2024 10:09:17 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-52-8-182-0.us-west-1.compute.amazonaws.com. [52.8.182.0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fef2372sm53599576d6.114.2024.08.20.10.09.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Aug 2024 10:09:17 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 "Xiaoning Ding" <xiaoning.ding@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v8 2/5] meson: Introduce 'qatzip' feature to the build system
Date: Tue, 20 Aug 2024 10:09:04 -0700
Message-Id: <20240820170907.6788-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240820170907.6788-1-yichen.wang@bytedance.com>
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Add a 'qatzip' feature, which is automatically disabled, and which
depends on the QATzip library if enabled.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 meson.build                   | 10 ++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/meson.build b/meson.build
index fbda17c987..b89b713e79 100644
--- a/meson.build
+++ b/meson.build
@@ -1262,6 +1262,14 @@ if not get_option('uadk').auto() or have_system
      uadk = declare_dependency(dependencies: [libwd, libwd_comp])
   endif
 endif
+
+qatzip = not_found
+if not get_option('qatzip').auto() or have_system
+  qatzip = dependency('qatzip', version: '>=1.1.2',
+                      required: get_option('qatzip'),
+                      method: 'pkg-config')
+endif
+
 virgl = not_found
 
 have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
@@ -2412,6 +2420,7 @@ config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())
+config_host_data.set('CONFIG_QATZIP', qatzip.found())
 config_host_data.set('CONFIG_FUSE', fuse.found())
 config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
 config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
@@ -4535,6 +4544,7 @@ summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
 summary_info += {'Query Processing Library support': qpl}
 summary_info += {'UADK Library support': uadk}
+summary_info += {'qatzip support':    qatzip}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16..f7b652b30d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -261,6 +261,8 @@ option('qpl', type : 'feature', value : 'auto',
        description: 'Query Processing Library support')
 option('uadk', type : 'feature', value : 'auto',
        description: 'UADK Library support')
+option('qatzip', type: 'feature', value: 'auto',
+       description: 'QATzip compression support')
 option('fuse', type: 'feature', value: 'auto',
        description: 'FUSE block device export')
 option('fuse_lseek', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c97079a38c..5f377a6d81 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -163,6 +163,7 @@ meson_options_help() {
   printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
+  printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
   printf "%s\n" '  qga-vss         build QGA VSS support (broken with MinGW)'
@@ -427,6 +428,8 @@ _meson_option_parse() {
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
     --prefix=*) quote_sh "-Dprefix=$2" ;;
+    --enable-qatzip) printf "%s" -Dqatzip=enabled ;;
+    --disable-qatzip) printf "%s" -Dqatzip=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
     --disable-qcow1) printf "%s" -Dqcow1=disabled ;;
     --enable-qed) printf "%s" -Dqed=enabled ;;
-- 
Yichen Wang


