Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A51C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmd4-00014b-Ha; Fri, 17 Jan 2025 08:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0000x9-JF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:08 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002CP-7w
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:06 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so328466466b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121378; x=1737726178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPhUiahc8AcG/DudZ+NnvJ9oGMqaRHCp9nDZpFVSZuQ=;
 b=QYRYaxlnaVtvi9VsrJl6JYzdghVQlTuNtC5Rrqe5skykCMHTWbbKQ31mhVgDthvY1b
 ylzNOv4rxFJbmgtTLQ90NKH88YsiYG/o8iVP604iQRI4kRYy2Vq9Ti72QN2iMwF/iC0U
 xBZpS5H1hJVK1yxUv3x9auZP3+wV01wkPw82nWB3MqTfhES/LwKAk4X/edJMwVbu87Rg
 5AXvS+E1E9OXV69xEH+2jVsJLhJ3crA/3nq3PjZMPF27oGsjhE8JrmctLFdjnnIuDSOx
 Wu9C9YSTfEfSLs2Qr9B4wHQiuAhC/99vauOqIiqJHyX4Z85LAfLTZ7xJiMNkRwfcGX0m
 K4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121378; x=1737726178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPhUiahc8AcG/DudZ+NnvJ9oGMqaRHCp9nDZpFVSZuQ=;
 b=l1uPKAGEr1tUS0JPE8u4YtYU0d+UhrKo3ARFpKlCQj4S3SgyEqHZ+PcV5Az2LuwNZn
 4miFtGdV+z2FtUnJWFfDYJPxVmOPvQ5uzSe1n6bKpsFO20m8HolXfQHvEI99alwRqYjl
 WZQb39dRVJuIRtqUNBCabCU5/TDbQCynUdMlSMIc90pZps/sjTgGxrQbUbU2HvjNereu
 PPmzixPpfbz8hnYwRe60jAVBq3Nfz5wxnAQtXCOfSzojGkcXcqRBBKEH6bVTMRLSI/70
 J7gS0F8otAAZ42qBtDN5AUkOyeMGR+xpG2jR4YsvawNDA/1YeVIa/CkAi5dgIqffHKMg
 GsXw==
X-Gm-Message-State: AOJu0YwUteDWWV3lijE4HDX7BiJPANmtQJSwuNA9QrzBuTj9ZvlQ9mZ1
 JaChwOJPFuci0ikiM3jLc8DX5gpHXAilNxQoyT+VnDO4eJVghE2lgY5eAJTHij7m2bi0pJ9fmFG
 AnWw=
X-Gm-Gg: ASbGncsiTP0blQlFEv0xVf+Dvaelkv4QxBSCrHa0pTX+LfgX9nNKmDtQto94zIW47n+
 zyKKM/4N695Imh9BZBJVleFfBsgaFif1AnD+WcH0/2g8xdkHti5StgktgZ946RxVnVeW0E8mYCk
 xbXaHq3ECqYGJX81KICr5XaF4iFl462deWmkG3FmJfOCMW6bQoK5SH4x6XgwHpKI5asPjjVSyCM
 z1+hOl+PBIf8jmfdnFQfFR/DIFMBTuJPMAEVfM9mpf1iySuHdldKwc=
X-Google-Smtp-Source: AGHT+IHWymvHQFT/Kb8O3h5piJK1U+wH0Hxx/H8XzS4NpgH7ag2xPRorb058tFVpzgn647tGJgdS/g==
X-Received: by 2002:a17:906:6a20:b0:aac:23f4:f971 with SMTP id
 a640c23a62f3a-ab38b1b45e1mr280462566b.33.1737121378166; 
 Fri, 17 Jan 2025 05:42:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f22fd2sm171481766b.110.2025.01.17.05.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:42:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1D386084C;
 Fri, 17 Jan 2025 13:42:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/37] semihosting: add guest_error logging for failed opens
Date: Fri, 17 Jan 2025 13:42:20 +0000
Message-Id: <20250117134256.2079356-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

This usually indicates the semihosting call was expecting to find
something but didn't.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-2-alex.bennee@linaro.org>

diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index c40348f996..f6451d9bb0 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/guestfd.h"
@@ -287,6 +288,7 @@ static void host_open(CPUState *cs, gdb_syscall_complete_cb complete,
 
     ret = open(p, host_flags, mode);
     if (ret < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to open %s\n", __func__, p);
         complete(cs, -1, errno);
     } else {
         int guestfd = alloc_guestfd();
-- 
2.39.5


