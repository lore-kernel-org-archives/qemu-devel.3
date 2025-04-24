Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17D6C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lFq-0003LB-0o; Wed, 23 Apr 2025 21:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFU-0002pM-Lf
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:35 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFS-0007BB-Qv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:32 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso472487b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457569; x=1746062369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LvS1n+qlS73FdHFx8FlT1NvgH8GPjz2T857j7hIsMgE=;
 b=Le0CXtO7ZSS99h/jSYnyJARfse+VkCRNhtDQin/ayT6zpmvyB029Rvy2wmn8Yt2p/d
 4n11KPV++Pe3NTfuBCdO/sZ+kuaAXpM6sN0/Y42KeTXciF5IyXwECokSORdwt3jSOqQv
 +Pk5UlQ55/1yBBM88mDdSiCdWawHcAHwfhv6sv3EMLrFSnvotfXx/3Ex8o7RzNkGcpPm
 Q0rfEeAwnKmqSETknf4dBiMoQv9v1pelDbuyoYEX83dZF/FT9BJYWJX/6TDGyut5Fqlz
 Ojt2B7ulDg1+0mVVNcZ6zDWPkIP8dVUaSCZaHiDT1HVK70ERFtTFUQa7zOgyQI9XE/y3
 GHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457569; x=1746062369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvS1n+qlS73FdHFx8FlT1NvgH8GPjz2T857j7hIsMgE=;
 b=LkdKANbi4o+rQdZCPEFkL6GmoH8hrBT5qnIMghfYMUc9O1C/LVlOTTlHVsPy7zktIo
 oFwFpaGn0yFSYstjQ7WDQ0kJIlQ7yxh7cnUj0HCQFqcS88qg5c/QuLDNAxU8aFwSj3r2
 vnjzfr7LVc3e8uoxC8qYOd9x3XgIQQElDntOqDebZWNX0Px/ixTA4yZnK5zTNMXoJzU9
 LbFaotpyXvufvYN+D1HRm1M9i+9O2rBf47ItYk7BapqpOV9USZkgtmlDQkOylW+tcwCl
 q4k3b7QsGE5YSIbKYQNxqseuPYvNG0KAaoQSDlyqfbviuLLTff3/mzXM3Egz8sflnmA+
 nhYA==
X-Gm-Message-State: AOJu0YwWCj2EV2wzo1r10oC7m8/tm7D2T+z+4ph7d7dMKNakiLXHCloE
 C5e7nuFXFmumGLMNOG6UeEIvT/JR6Qf7Ha7u60y/HAsU17c4wjWoxnrZUq6iUDIxJX7hvGtWgGr
 Y
X-Gm-Gg: ASbGncvHDIsSe9AWRys1b6jjZpDC5PxhNTfrunOsLQe0khrIvODLsazTim+HuA8DSaO
 3Lk3mTY7nkUp2+nLHqYYTO+fho2VQzSsRe4RIyKpBG38LHQtHt+0LLmjrhk9FNEncxgc7KDgkUw
 PYS/frj9KykxGcM8yXuWCok5TopACFOQmS2TOCE9AnvGA2hNERJ0WMpKp9yHiCociKTadMtq+G6
 kVZ1kxZyDl2sTTQx8iTKgBtmslpIvITZd7vDv7eE1DiUFWQFdk/SQmA+ESBAyqgzyUVRIYwxBv0
 6Wz70613CyApDzQi3LchDR9ukKbmRVqOxvLDWBu2MdhuGe6nJWSo4FFytJ2v4/fxGAEBT/q35/M
 =
X-Google-Smtp-Source: AGHT+IE4W/f9ZtqEvJvGk3pKsHmem/x+QfesC/hXE1eIiy4QB2eKNK1AatJUOG+ajhW+IFVecNpCDg==
X-Received: by 2002:a05:6a21:516:b0:1fd:e9c8:b8c3 with SMTP id
 adf61e73a8af0-20444f8b15fmr878044637.26.1745457569049; 
 Wed, 23 Apr 2025 18:19:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/15] accel/tcg: Compile tb-maint.c twice
Date: Wed, 23 Apr 2025 18:19:18 -0700
Message-ID: <20250424011918.599958-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-hash.h   | 3 +--
 accel/tcg/tb-maint.c  | 2 --
 accel/tcg/meson.build | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index 3bc5042d9d..f7b159f04c 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -20,8 +20,7 @@
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
 
-#include "exec/cpu-defs.h"
-#include "exec/exec-all.h"
+#include "exec/vaddr.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "qemu/xxhash.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index cf12a28eab..512dae93bd 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -20,10 +20,8 @@
 #include "qemu/osdep.h"
 #include "qemu/interval-tree.h"
 #include "qemu/qtree.h"
-#include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/log.h"
-#include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 047afa49a2..3f7b127130 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -8,6 +8,7 @@ tcg_ss.add(files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
+  'tb-maint.c',
   'translator.c',
 ))
 if get_option('plugins')
@@ -21,7 +22,6 @@ tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
-  'tb-maint.c',
   'translate-all.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-- 
2.43.0


