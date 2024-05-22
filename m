Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F32C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jRK-0003JM-Jp; Wed, 22 May 2024 06:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jRI-0003IY-OM
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:43:20 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jRF-0001g8-VM
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:43:20 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6001399f22bso916829a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716374597; x=1716979397;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CinWkEJu0fAiLknHwCrn8NcaRcIHtVxff81S7d3fju4=;
 b=YfiR/uKfhaNzAPzy2LVKU64O6psqslmowr5kyGWsrs46mawDbcqndPXnXssNgtOqew
 8iU1+Akel7obH4XqrSsn5UNV6hpIsmcBMhFoYWoQWDBtlS0nCx6CicR8z7V5o6VPuHUe
 EmDklFkgo7QOCNxZuHIRHR5XWxf1QH2mYeHRc7RXUi6HSiJGS71fgH6tUU18Y+Pdhxmy
 PZoP3yLgIhhSOKCuhI8nC4+NgpkZTcYNPFHI0Jg1U2sPtlrBat64Xq035xK3Tc6UB0EU
 bnWzceph/AkCzEwVnJoJkIJ3wr6HJz8g0+Bvf5LeLCYqJXLQrUoXj6HJ8hkYzJX2DSrT
 cHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374597; x=1716979397;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CinWkEJu0fAiLknHwCrn8NcaRcIHtVxff81S7d3fju4=;
 b=DPRSbqOBKCywxH4HfEKDEmc+twGLrJr/GwRKp+usOjYbTqzH53+WdkorNMruGPG5bN
 NAxfTc64L0+AaLpMOXyBcnun6rSQaDUm+yReoGUQT9F4ptogv5+svzjbQzbRaa4KmIMS
 GA/2fRsffIgdYT0hHZIZKWhtGOthwPFjmExmeD42rlDqUxbLLDsljj27T4yzZzRr5aU7
 bf+tMHsaT5pXHO+Ut+xlT/Npx0UL1T8K2BZvnLTwziStyKN0NEJGl0LrxbvRCL7HiAtn
 5s2Py7Zy5udemUdpMRIWcFvIfD6e5YpgCA41dfJGe+OAtkaRCTMBnprNQ7Qnz4M8mh4e
 VCMQ==
X-Gm-Message-State: AOJu0YwH4OTkqaUTITtkPYHdgf89eBsylgRrSmnhEV5X3PHyMCClUk0q
 0f0fb/ew2PwO8IsmRDsCEEpZtWXp5UWHl4toeh9Se5S+nbRnGWsp9bkRjdnE6rA=
X-Google-Smtp-Source: AGHT+IEuTUPOSxEd/SrrnpQXi7eNP9o2TBbZNHvU/ocZTTaFWRlkYK1ttPQGzIppCF5omy40Z7zkug==
X-Received: by 2002:a17:90a:d303:b0:2bd:7264:ed8d with SMTP id
 98e67ed59e1d1-2bd9f450ae6mr1566342a91.17.1716374596659; 
 Wed, 22 May 2024 03:43:16 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2bd878b9725sm4366645a91.54.2024.05.22.03.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 03:43:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 22 May 2024 19:43:03 +0900
Subject: [PATCH v2 2/3] meson: Add -fno-sanitize=function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-xkb-v2-2-67b54fa7c98f@daynix.com>
References: <20240522-xkb-v2-0-67b54fa7c98f@daynix.com>
In-Reply-To: <20240522-xkb-v2-0-67b54fa7c98f@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

-fsanitize=function enforces the consistency of function types, but
include/qemu/lockable.h contains function pointer casts, which violate
the rule. We already disables exact type checks for CFI with
-fsanitize-cfi-icall-generalize-pointers so disable -fsanitize=function
as well.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/meson.build b/meson.build
index 91a0aa64c640..9eaf218609eb 100644
--- a/meson.build
+++ b/meson.build
@@ -298,7 +298,7 @@ endforeach
 
 qemu_common_flags = [
   '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE',
-  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
+  '-fno-sanitize=function', '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
 qemu_cflags = []
 qemu_ldflags = []
 
@@ -3462,14 +3462,12 @@ endif
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
-                        name_suffix: 'fa',
                         build_by_default: false)
 qom = declare_dependency(link_whole: libqom)
 
 event_loop_base = files('event-loop-base.c')
 event_loop_base = static_library('event-loop-base',
                                  sources: event_loop_base + genh,
-                                 name_suffix: 'fa',
                                  build_by_default: false)
 event_loop_base = declare_dependency(link_whole: event_loop_base,
                                      dependencies: [qom])
@@ -3703,7 +3701,6 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
-                          name_suffix: 'fa',
                           build_by_default: false)
 
 authz = declare_dependency(link_whole: libauthz,
@@ -3712,7 +3709,6 @@ authz = declare_dependency(link_whole: libauthz,
 crypto_ss = crypto_ss.apply({})
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
-                           name_suffix: 'fa',
                            build_by_default: false)
 
 crypto = declare_dependency(link_whole: libcrypto,
@@ -3722,13 +3718,11 @@ io_ss = io_ss.apply({})
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
                        link_with: libqemuutil,
-                       name_suffix: 'fa',
                        build_by_default: false)
 
 io = declare_dependency(link_whole: libio, dependencies: [crypto, qom])
 
 libmigration = static_library('migration', sources: migration_files + genh,
-                              name_suffix: 'fa',
                               build_by_default: false)
 migration = declare_dependency(link_with: libmigration,
                                dependencies: [zlib, qom, io])
@@ -3738,7 +3732,6 @@ block_ss = block_ss.apply({})
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
                           link_depends: block_syms,
-                          name_suffix: 'fa',
                           build_by_default: false)
 
 block = declare_dependency(link_whole: [libblock],
@@ -3748,7 +3741,6 @@ block = declare_dependency(link_whole: [libblock],
 blockdev_ss = blockdev_ss.apply({})
 libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              dependencies: blockdev_ss.dependencies(),
-                             name_suffix: 'fa',
                              build_by_default: false)
 
 blockdev = declare_dependency(link_whole: [libblockdev],
@@ -3757,13 +3749,11 @@ blockdev = declare_dependency(link_whole: [libblockdev],
 qmp_ss = qmp_ss.apply({})
 libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         dependencies: qmp_ss.dependencies(),
-                        name_suffix: 'fa',
                         build_by_default: false)
 
 qmp = declare_dependency(link_whole: [libqmp])
 
 libchardev = static_library('chardev', chardev_ss.sources() + genh,
-                            name_suffix: 'fa',
                             dependencies: chardev_ss.dependencies(),
                             build_by_default: false)
 
@@ -3771,7 +3761,6 @@ chardev = declare_dependency(link_whole: libchardev)
 
 hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
-                           name_suffix: 'fa',
                            build_by_default: false)
 hwcore = declare_dependency(link_whole: libhwcore)
 common_ss.add(hwcore)
@@ -3807,8 +3796,7 @@ common_all = static_library('common',
                             sources: common_ss.all_sources() + genh,
                             include_directories: common_user_inc,
                             implicit_include_directories: false,
-                            dependencies: common_ss.all_dependencies(),
-                            name_suffix: 'fa')
+                            dependencies: common_ss.all_dependencies())
 
 feature_to_c = find_program('scripts/feature_to_c.py')
 
@@ -3909,8 +3897,7 @@ foreach target : target_dirs
                  objects: objects,
                  include_directories: target_inc,
                  c_args: c_args,
-                 build_by_default: false,
-                 name_suffix: 'fa')
+                 build_by_default: false)
 
   if target.endswith('-softmmu')
     execs = [{

-- 
2.45.1


