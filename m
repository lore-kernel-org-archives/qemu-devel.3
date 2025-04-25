Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EAEC369D8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2R-0008J6-5z; Fri, 25 Apr 2025 11:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L28-00072l-Ut
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L25-00047e-Ss
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so16114045e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595123; x=1746199923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbFk5T/Gx2RWDfL/8OYFT9numZ3eK39ufVSLHy/LkBY=;
 b=bCaVA4ZiSXabzNzP8I/NsEVXtdtCxEGhwS1KvVFyzQgIoIErNO5FO/r7xA99yGSjLv
 /dYhxCf69OqR5DqHCRCdeN7vWrV26yZ1q51HiNywVXk1vHM3UCCEKip6fKJGw8HlTP/x
 NVt3BpIHL9xwNnqvTEZ9dM24XPZbuyOReart+//aiXYFL1qkXHOmOQ/wWPqB1g4a6jvP
 3b4oupQUwiUP6Ob6c2DbJEIgs1zzbIoCJuOFQF5cSHIW2kLZBHCrKn3fSdq1yav+goiF
 moNs9XmBBBLZFQI9+6p7PrKHiJ1oVmXs2ti3MIdMRtfgjQ8HYaAZQXwPoHa4yVjKk2nS
 DIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595123; x=1746199923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bbFk5T/Gx2RWDfL/8OYFT9numZ3eK39ufVSLHy/LkBY=;
 b=ZhPQWGoKgrDVt8PoFGHUa8Y61K9dNJfgGe0gpAXTaVxQehTzkWnTEa6hDtvOg7Iqbv
 zAUzGHdNimJlBdS0h4HrffrwH86eep1Z9maGyrsevt+hp19wb8+SgeuZp9BPEp4XVucq
 OsJIO43PHDpCCPypaVGmf7XlPWOSmEeT7srjxSy3JyNfDmW734l1DMstS4KY7JEvwtfB
 7bW5p1XD+B3b8ULhN0JSRV5vbN2M1BBf+B/z7OirjRAjzTJc3uEkNPkDcrHsh3UnH4tV
 9cc0Wab3OWZ2DvQvicKTOsIABz0iWXg1Jf/CNEREXM3Kg7HEvKCzhoCL8MZPunhjVU23
 pERQ==
X-Gm-Message-State: AOJu0YwWB/ffoLqdW0t4nhPRJiPCyxPcoCbP8CYrli0kenr6KQ9l8tEF
 RhmySGaIZo9o62OyoPmv0sfFLEGWlyO5I1yGbn5tfSYeDiMXeeN8y3H6C8ER/gcjLyFGegdt4Nr
 0
X-Gm-Gg: ASbGncu0vO2cqQOUVxnxdbtICITtQhFLnaHlrQAL1mL1UphgLilhUM9t2v1926vwlZn
 MtTED/fJY5cQdia4TTVyZdmK4f8WcM6u8AwaemL1kkG4AfE2RNtWemujKM9/YOx9nFnFEXkKSv4
 Jem/DCjq5PFS/C2QdbvtM3I6tJ9mSOmshbAodAF76EThFdjQAnwCSRPR80DOLoI+0m/wfPYoyJy
 maRkwvRqUGFHeMuYHX3tNGP3/m/lNC00Il8CYrpunekCEfcixMlg5fFdpkEwmAOAgT3DAZVhw+w
 gvwWgQEMPFbLaPVgQZzMpgQd8iTB+bdw1SynSS8TN96UAuHyS/frFcT/yvf1L2AoSKQ7AV9XVYw
 WHCbRmjeAkB8POFM=
X-Google-Smtp-Source: AGHT+IFAprrNEoVYN9Y7KeboHnKCfngfv0yNbo5SV1cksQNE593lFogn8o6CMm6Cr3v16jro2BpuBw==
X-Received: by 2002:a05:600c:a41:b0:43c:eeee:b706 with SMTP id
 5b1f17b1804b1-440a6698266mr21912505e9.24.1745595123372; 
 Fri, 25 Apr 2025 08:32:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a52f8794sm29256445e9.1.2025.04.25.08.32.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/58] meson: Use osdep_prefix for strchrnul()
Date: Fri, 25 Apr 2025 17:28:24 +0200
Message-ID: <20250425152843.69638-41-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

macOS SDK may have the symbol of strchrnul(), but it is actually
available only on macOS 15.4 or later and that fact is codified in
string.h. Include the header file using osdep_prefix to check if the
function is available on the deployment target.

Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424-buildsys-v1-4-97655e3b25d7@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d93dbde194f..c736a6f4c4b 100644
--- a/meson.build
+++ b/meson.build
@@ -2193,6 +2193,7 @@ osdep_prefix = '''
   #include <stddef.h>
   #include <sys/types.h>
 
+  #include <string.h>
   #include <limits.h>
   /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
    * function availability on recentish Mingw-w64 platforms. */
@@ -2657,7 +2658,7 @@ config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_alloc)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
-config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
+config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
-- 
2.47.1


