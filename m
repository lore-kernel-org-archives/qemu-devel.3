Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ADCC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2p2W-0001gK-TY; Fri, 03 May 2024 05:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2T-0001fo-QK
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2S-0003W2-1s
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41c7ac73fddso47135005e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714727826; x=1715332626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjIC0hzeanG/udtndv7wQlWjrcv140/3TttCqxYBKio=;
 b=vyAsJSFdzRAB59KiGFBTE1CgT6NAo+7hWEYTEt+7+xJcGa/egpYRQs6ZUiK78nmC9A
 nHMKPgaap9PS6wNbTMtfePZ8+C/NgrSab8MseYZKVQl3TLgiW/rfLBVvLZ76fvi1rd91
 B0wBHQRY5TV4mFfrRLXjhfO2qRvJgPfGQ5gHnmZTsy3dtjWmWDj7/EStihuBELz+26HQ
 Imei76ghl/CYBEgUPNUFjA0S1BbP7wghyc0pLcG+6A1Aw3Cx43hCGjSZDfZQabL5pNwc
 ueQ3xlcu6O2R6/5/UIqx6Btcdfnnr+dYtH9WHhYxMiffhh2AZD0bfDZTy6I1AG9vuoVi
 ydLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714727826; x=1715332626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PjIC0hzeanG/udtndv7wQlWjrcv140/3TttCqxYBKio=;
 b=b20RYfTXBqx1rNcFE1rTW/ErHpxHqnBhlRpCq+rp1Ew1y7PM+01XiB77cwlVhOPDtS
 akazTXB+pZnH+C58fe/ynYJGkvF2p/v3JZcTqF/541omiJlw72Evg7FE6Y/gRiUepbID
 km4q9CkhX+baztTYkNx7zHz9EnwkRD3S8c2vWpOrLZIRNk7ElomO1hJQVW2wZAfGpC2M
 VgCi029z8xbfm9O8weA4qBzF0xeH/OOlitKpkpWQpoMypsdbyq0mlFd7g90wGeouv9Mk
 Qka0kbl51FuhurTyfvgFZC/7WToVUXdcBRkyT3CZGIjDv2ApAksDMzP2Pj5QlxSBReB/
 BZwQ==
X-Gm-Message-State: AOJu0Yy9J2VIRjZvPs0yUYvZhr4M9KhqwOrXDax4HMZnPeq1Fi4PmHh1
 R/VoHq6PqylnmXUrS04EhFaCj5+nvZbX9xiQ8Ut+KfHOMCMFE3oPoYEgPqmqX01XgJ+MA4wV044
 /
X-Google-Smtp-Source: AGHT+IG/FFyoXSUNl/gadz+vDS7gFr30tHUVXGHIG9FXGx7e4jbsodR7p3jqV8YChuy9T1TddUipaA==
X-Received: by 2002:a05:600c:1d0a:b0:41b:fa34:9e48 with SMTP id
 l10-20020a05600c1d0a00b0041bfa349e48mr2099286wms.30.1714727825926; 
 Fri, 03 May 2024 02:17:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a05600c1d8900b0041563096e15sm8721875wms.5.2024.05.03.02.17.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 02:17:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] accel/tcg: Simplify meson.build using subdir_done()
Date: Fri,  3 May 2024 11:16:53 +0200
Message-ID: <20240503091657.26468-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503091657.26468-1-philmd@linaro.org>
References: <20240503091657.26468-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

If CONFIG_TCG is not defined, skip this directory calling
subdir_done(). Then since we know CONFIG_TCG is defined,
we don't need to check for it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/meson.build | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index aef80de967..f40959436e 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,8 +1,11 @@
-common_ss.add(when: 'CONFIG_TCG', if_true: files(
+if not config_all_accel.has_key('CONFIG_TCG')
+   subdir_done()
+endif
+
+common_ss.add(files(
   'cpu-exec-common.c',
 ))
-tcg_specific_ss = ss.source_set()
-tcg_specific_ss.add(files(
+specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
   'tb-maint.c',
@@ -11,24 +14,23 @@ tcg_specific_ss.add(files(
   'translate-all.c',
   'translator.c',
 ))
-tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
+specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
+specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
-  tcg_specific_ss.add(files('plugin-gen.c'))
+  specific_ss.add(files('plugin-gen.c'))
 endif
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
+specific_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files(
   'cputlb.c',
   'watchpoint.c',
 ))
 
-system_ss.add(when: ['CONFIG_TCG'], if_true: files(
+system_ss.add(files(
   'icount-common.c',
   'monitor.c',
 ))
 
-tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
+tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files(
   'tcg-accel-ops.c',
   'tcg-accel-ops-mttcg.c',
   'tcg-accel-ops-icount.c',
-- 
2.41.0


