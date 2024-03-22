Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E03C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhXh-0000fX-TS; Fri, 22 Mar 2024 12:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhXg-0000f9-Ak
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhXe-0000oT-U8
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4147f659353so648445e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711124089; x=1711728889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3jectw/kExol21Tl/VOhcbnait7BaHf+x9145daJsc=;
 b=pABTf919d9+eW0pdvw9yCl9wg1eJD/xtdWDH+WhEf7Gz+ykAH68Pj3pWqmwzSG5NUY
 p1OzkP42tXwKipPZivi/P/rmbuEeRhRKr4x6lTWlNnT93ZiVhM+u/ZANW5OW8cQQTLwl
 sMvobVBQ925x6aq28lpYgC4Evas+kqMLTPSROxQ37qHNARFU1BpOE8bfAkFtFSM8Ee92
 DVHgnxde+RA+xQouxccekHde+aqbKqv5+XQmvf/9/SvEaGKommVBNSaZw6dEzxAMjYE4
 G/oZYi6XtJPOBEynIkD/I6YCMNXmU5Fb1024MvtICTQ476MbTQzXFpSYLGNE1oplZ/O1
 5UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124089; x=1711728889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3jectw/kExol21Tl/VOhcbnait7BaHf+x9145daJsc=;
 b=tWujU4YU5ilvsZ2KDmgRhWpVQTPNpkF4ngewID/N1DECxhOC6dPrpKNWZmkfuf9Q4S
 fBahfh1Q6D/X9EMsQSbBovc3A0kcZ0+XeBKDzPP/9nQTC1R4xjgSm/KP84o157/b7vxe
 aEiLsdpqs277f6dhRrIBx6GjPdriRPcQkbcVTF6iJD1FG3/iyWDBFZKrNgcx7DouZV3a
 l2DoL7X8hHgliR+4PI+H27yXJMRMWIkS/TOhdOMxjf/qUv/+APJAcFSBXF+z2aRJFeBK
 eedYNGnU9yarijDVPK6se5jbYKYxRP6K9KzumceWm+QAcmP4uMoiDU/5qS5Q5uHduK9s
 yOhw==
X-Gm-Message-State: AOJu0YzSeU7ikIKPrKLKV2W8wohsBSbFbnqlrhATywdy8LPsyQ5Bm6Wm
 Uizl0nJlGinI/QFqNKHnWx3ePoze38puHK3GvC+72KV+Qg/1nmh7zCWmp0I/YuKgRCNnWqWV5+3
 9
X-Google-Smtp-Source: AGHT+IHnzpEOVwPDsBW32NjuihDhDnLtCe0iw73ewhehZA9lITU/6L8eY957zXmL0DGUCSwgDESxUw==
X-Received: by 2002:a05:600c:5617:b0:413:315f:9e8d with SMTP id
 jr23-20020a05600c561700b00413315f9e8dmr1991336wmb.18.1711124089140; 
 Fri, 22 Mar 2024 09:14:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c1c0800b004146bcdde06sm3530094wms.6.2024.03.22.09.14.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 09:14:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.1 v2 1/3] gdbstub: Simplify #ifdef'ry in helpers.h
Date: Fri, 22 Mar 2024 17:14:37 +0100
Message-ID: <20240322161439.6448-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240322161439.6448-1-philmd@linaro.org>
References: <20240322161439.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Slightly simplify by checking NEED_CPU_H definition in header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index c573aef2dc..53e88d807c 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -12,7 +12,10 @@
 #ifndef _GDBSTUB_HELPERS_H_
 #define _GDBSTUB_HELPERS_H_
 
-#ifdef NEED_CPU_H
+#ifndef NEED_CPU_H
+#error "gdbstub helpers should only be included by target specific code"
+#endif
+
 #include "cpu.h"
 
 /*
@@ -96,8 +99,4 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 #define ldtul_p(addr) ldl_p(addr)
 #endif
 
-#else
-#error "gdbstub helpers should only be included by target specific code"
-#endif
-
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.41.0


