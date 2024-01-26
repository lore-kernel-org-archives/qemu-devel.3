Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8141AC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHQ-0002fx-Pm; Fri, 26 Jan 2024 09:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHM-0002T7-RX
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:00 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHL-0007zT-41
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:00 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-339289fead2so522702f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279638; x=1706884438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=28nbiWFQ3dXc2wMfXx4/3I1JNB6kABMI1o1Dd2Ej4Ok=;
 b=YXVVmRfMnPNwIz5OvFi1mkRn59oMkASYDDtWUrRnlC34BDVQDHjGIQJlxfALkxm7vL
 o2xIxZ4hiLn3l+SKPxmRZjaFN/JWKxD28bOKGxUVBZuBaLMZStCDFsKVLxyScOlm5tTy
 Qe6SM0hsQwYN8p1JHWOV3lv/szQZBRhjSt+2iNra6iHV3EXgTdQE1sjOb15R8NRpj+jk
 aMYyFWkGEtl9gB8bk8LtJ6jveSl4kHINKtuuEttpwyhvQsKOx5JKp8sxfiCVvpkVM6z6
 ZeF9bMGOyITPTc4hFknoZCI+pl5TIHj4Z3Tb3Ob2mQ5CJRZW2zv5hSev246bxSUYXE8J
 IDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279638; x=1706884438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=28nbiWFQ3dXc2wMfXx4/3I1JNB6kABMI1o1Dd2Ej4Ok=;
 b=YxzH+YPAu2q48YLDct/41lNmtn9STsPiu5s5QUR853sAiik7mBEJ8Uk1zyej2416Q4
 oFwfalG+UezCyGWHlnU8PkvleMFhCQL7xbbz+4xjdAPxTb6DYX+TcfpD8EBGoW9Nw3sY
 7QHi76S7vmn6ZEVhj3C8M9gLDUKe4l75/4/sXVkA8/qOiLeFS39SLfxfA8PgKE0d2OaD
 vNBNX1nTP6QXqEVN/BTt54TljdA5E/fMRgyi4lusXBi22oM8XtHOGg+vAZ2HkOfYNVnq
 SVrxDLXOmqYYzDc5eVR/I+WRfluzCVculJilwQ0srj1Z3vAaCBOsbWupIWUhcRjTHgs7
 BmPg==
X-Gm-Message-State: AOJu0Yy4lC36GSOtL1fqTjc/pRCIFw4fSySePI1yLIZjfL/R6l1iJeey
 P2/4SqU3/amVO0W1jvG0RatiP/5pWT2QrH/jTcl4IQ7wPM3anUa7m0loEfUEiNeORSUjeHSNrA8
 2
X-Google-Smtp-Source: AGHT+IFOfNiYrNmobatReAw0ULuW1hKCIhApIbEgmXU7B5i9gurHKy8t1YI/+quUBvUSSqpEB8Vmtg==
X-Received: by 2002:adf:f88e:0:b0:337:d649:da70 with SMTP id
 u14-20020adff88e000000b00337d649da70mr834366wrp.138.1706279637863; 
 Fri, 26 Jan 2024 06:33:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/36] bswap.h: Fix const_le64() macro
Date: Fri, 26 Jan 2024 14:33:39 +0000
Message-Id: <20240126143341.2101237-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The const_le64() macro introduced in commit 845d80a8c7b187 turns out
to have a bug which means that on big-endian systems the compiler
complains if the argument isn't already a 64-bit type. This hasn't
caused a problem yet, because there are no in-tree uses, but it
means it's not possible for anybody to add one without it failing CI.

This example is from an attempted use of it with the argument '0',
from the s390 CI runner's gcc:

../block/blklogwrites.c: In function ‘blk_log_writes_co_do_log’:
../include/qemu/bswap.h:148:36: error: left shift count >= width of
type [-Werror=shift-count-overflow]
148 | ((((_x) & 0x00000000000000ffU) << 56) | \
| ^~
../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
409 | .nr_entries = const_le64(0),
| ^~~~~~~~~~
../include/qemu/bswap.h:149:36: error: left shift count >= width of
type [-Werror=shift-count-overflow]
149 | (((_x) & 0x000000000000ff00U) << 40) | \
| ^~
../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
409 | .nr_entries = const_le64(0),
| ^~~~~~~~~~
cc1: all warnings being treated as errors

Fix this by making all the constants in the macro have the ULL
suffix.  This will cause them all to be 64-bit integers, which means
the result of the logical & will also be an unsigned 64-bit type,
even if the input to the macro is a smaller type, and so the shifts
will be in range.

Fixes: 845d80a8c7b187 ("qemu/bswap: Add const_le64()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Message-id: 20240122173735.472951-1-peter.maydell@linaro.org
---
 include/qemu/bswap.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 933a66ee87e..bd67468e5e4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -145,14 +145,14 @@ CPU_CONVERT(le, 64, uint64_t)
  */
 #if HOST_BIG_ENDIAN
 # define const_le64(_x)                          \
-    ((((_x) & 0x00000000000000ffU) << 56) |      \
-     (((_x) & 0x000000000000ff00U) << 40) |      \
-     (((_x) & 0x0000000000ff0000U) << 24) |      \
-     (((_x) & 0x00000000ff000000U) <<  8) |      \
-     (((_x) & 0x000000ff00000000U) >>  8) |      \
-     (((_x) & 0x0000ff0000000000U) >> 24) |      \
-     (((_x) & 0x00ff000000000000U) >> 40) |      \
-     (((_x) & 0xff00000000000000U) >> 56))
+    ((((_x) & 0x00000000000000ffULL) << 56) |    \
+     (((_x) & 0x000000000000ff00ULL) << 40) |    \
+     (((_x) & 0x0000000000ff0000ULL) << 24) |    \
+     (((_x) & 0x00000000ff000000ULL) <<  8) |    \
+     (((_x) & 0x000000ff00000000ULL) >>  8) |    \
+     (((_x) & 0x0000ff0000000000ULL) >> 24) |    \
+     (((_x) & 0x00ff000000000000ULL) >> 40) |    \
+     (((_x) & 0xff00000000000000ULL) >> 56))
 # define const_le32(_x)                          \
     ((((_x) & 0x000000ffU) << 24) |              \
      (((_x) & 0x0000ff00U) <<  8) |              \
-- 
2.34.1


