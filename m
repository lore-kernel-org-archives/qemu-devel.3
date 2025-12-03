Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA607D12D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpVW-0004BP-E5; Wed, 03 Dec 2025 11:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVU-0004A5-EO
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:08 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVS-0006Yd-QC
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:08 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e3dac349easo5217884fac.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764778505; x=1765383305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByvILIj3hIVKvB3nld8A94yUCZSu7vP7Hj6QwoTLuOM=;
 b=Ot2Y8h/lMZ3dwffRPF9DUo/8WrfJ2ruFuyWHGMLHz60M4HK7Crb4Hh4C5svcupvrTn
 tWz89h6fcTnt319KPXm3i3DjkzBIp0mZB+e7YTh7Dl3gS7EfEUJNw4yq+TNiVVYrXPcR
 cnhib9XFmL1EkCs3zSCx2desd+JpPVzIhIT1cvEzJpC+tOq8EYRxK6zgnW+Qpt8dLhwU
 HI1O01tw9kiYovemiAZzBv3dtAr3qmY5ww/XNIS2AQ3u6vaFemP5h+pL4wFwah/rmyVK
 ZuHWBtKGVnyaVVDK1djSomrOiYxkSGyY/r+6QqELyj9jRwJZDBVH3WTcceVXd9TncTxp
 mKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764778505; x=1765383305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ByvILIj3hIVKvB3nld8A94yUCZSu7vP7Hj6QwoTLuOM=;
 b=bxAHEYuPGGspdFgU+INi/PZctUWmcW9s3IDpVB7JVqcT/a6uYSleZhD3kM+661zNzx
 Mpi3OaSyqAhDhg3jIfY97j5AxUnBnobs+8AZ5samt/MfQZZaLD6pKA38KgAOKvy/qUtA
 ALA93omma3q7myt7HaxBTI8vLytSuff5c7PxqaeV8Wmau5Pqt9F+VuijTaL8bt+71nwF
 ocROC+b9/0rPbB17L+TJF0lMw6cSkU4Kbscs7tCIxMW/tJKRzOQocpmt8W0wfLmIueKT
 HraoQve3dEfNapFSRv9ed6ia0S+XrLvQ4wArAp2lf9aidJ1MGpFgxgIxMZZ1yCtNUAX9
 go6w==
X-Gm-Message-State: AOJu0YxtOeMgWN4ZXdgTIEtDOn3HlogGLEpvg1PyEV/+2C/FSgRozZ5r
 urmzc+LfRx1uHWcRpvY7vzTHFyegX7+nuVqitMcI0A46vEXw1ieFJmfVhyyfAwKZvRWr/rPmCUS
 +3/yKhzE=
X-Gm-Gg: ASbGncsYBv1gYGtdb2v0VgZWVj6cJTkWAJlR8JBPzCot3NayWQHebbib2SfOUV8SRCo
 HMRc0enmDw84wfNQvHizxvZ/rgY3n6UTMQTAG4+Blgq+JfW324ONU8Zkt52asnzhFjOXqNobeJh
 6DAg3q7OYrEGcQ6CP25pDOuyT4QXGk/B6X/n5NB1pAU76J4VpEOK7Dhu0zQfUl2IzPwOybPn4t6
 S1EU66rg67I8006OfjycRAzphpDxjeyL1D9VFIQKLdlAT611IbWhjUGjSkCBzNNNoVhqq4nlI5S
 UK5IcN8/ss0XKzgh4QU6PVcgTPFJwa/BDOTfLmVJPS90p2eSNOqDA5pQy1meMo1zPPxUdnZEYtI
 aoTD/7OvFpPeKmqIZZ7XWvgIHnQqxUpcA2iKN4stygKKaaCLljB8OhI+7mL+4fud/rc47Ndo6zH
 hwU83VRkH/32NO/T2qCQBTAV0uMFCH
X-Google-Smtp-Source: AGHT+IG0pl+gxlwdgno9rQgnnNl6tDykdBTtV+SsdxuTRECY3i9JFG+XmLE6cA9MDwiDWeefkndUUg==
X-Received: by 2002:a05:6871:a913:b0:3dc:b701:c9b3 with SMTP id
 586e51a60fabf-3f169473cfdmr1683937fac.45.1764778505480; 
 Wed, 03 Dec 2025 08:15:05 -0800 (PST)
Received: from stoup.. ([187.210.107.189]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca40d4dsm10141625fac.9.2025.12.03.08.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:15:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v3 4/6] tcg/tci: Disable -Wundef FFI_GO_CLOSURES warning
Date: Wed,  3 Dec 2025 08:14:57 -0800
Message-ID: <20251203161500.501084-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203161500.501084-1-richard.henderson@linaro.org>
References: <20251203161500.501084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Since we build TCI with FFI (commit 22f15579fa1 "tcg: Build ffi data
structures for helpers") we get on Darwin:

  In file included from ../../tcg/tci.c:22:
  In file included from include/tcg/helper-info.h:13:
  /Library/Developer/CommandLineTools/SDKs/MacOSX15.sdk/usr/include/ffi/ffi.h:483:5: warning: 'FFI_GO_CLOSURES' is not defined, evaluates to 0 [-Wundef]
    483 | #if FFI_GO_CLOSURES
        |     ^
  1 warning generated.

This was fixed in upstream libffi in 2023, but not backported to MacOSX.
Simply disable the warning locally.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 909fe73afa..49a27e4eae 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -10,7 +10,19 @@
 #define TCG_HELPER_INFO_H
 
 #ifdef CONFIG_TCG_INTERPRETER
+/*
+ * MacOSX 15 uses an old version of libffi which contains
+ *   #if FFI_GO_CLOSURES
+ * but does not define that in <ffitarget.h>, included from <ffi.h>.
+ * This was fixed upstream with
+ *   https://github.com/libffi/libffi/commit/c23e9a1c
+ * We don't care about go closures one way or the other;
+ * just suppress the warning.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wundef"
 #include <ffi.h>
+#pragma GCC diagnostic pop
 #endif
 #include "tcg-target-reg-bits.h"
 
-- 
2.43.0


