Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9833CC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFGd-0000bD-AU; Tue, 08 Jul 2025 16:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDzo-0000Tt-Tl
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:29:05 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDzk-0002bl-Rd
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:28:51 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a169bso7760039a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002926; x=1752607726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q361PxA3oGLIS+vstXPMdLjk7PTidxEX26bP0T6K5Qc=;
 b=qNWiETjjoHOb86gQZrYNmw1z4gBnOqp2l+5glhmKGpJ2o6KZ2T436aIJ8/Zz34C7fU
 Ki6M7NdKVRsDxALwGmnKTx7fbXZRNX4Agn+B69B9MtWZf9YGQlx04hNjzMoEG1hGbNiE
 Zchn56y4ffBVBSt4gzmki2S1gIY4Cs/cV4reX5S45q3rKpMHje3cjZLeOPI6fW/ZUJMB
 sYYtVkhfZ1HIhlHY4+USweFuGySBeY7ijyJQHdrL0Uc6bEwfjnp9FYN20QcBbLQR9/oG
 gPOGGpgM8RJtxYsbzGsGC/272l72SXGAKs9+CUtBGaA60lAFn+aSoUl7yEjodIh4skA/
 XhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002926; x=1752607726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q361PxA3oGLIS+vstXPMdLjk7PTidxEX26bP0T6K5Qc=;
 b=icSR3Y/N2PfcQkcxiEIoMjh/XWvLzR14G15jiR/9nasiiBY6/jK0XaQ2awBg+DuAi7
 yrCkCP1h9UwpjQFqoR0KB0TMidPtFGbUa74CNN648Z25eSngIv4+hOruiWXln0NvB/aK
 1tTiNbjATBGljRA7kYblIv9TTw3hkiFByA1coCyezWZSaDcgs9tTA3TDY4huOMYEfZND
 sVJMlwa5YU+Yrs0FmbRcqaLI46IgI5HHtDfrnENeUSl0RyqRW7C8HhMf33pph1ceFVfL
 LVniiTQFbcIAWJ+tiEo+YvW21EXqCPxWMcDgeNCqmja3JCO9riCrhzffElvhxFeAzibF
 BUwA==
X-Gm-Message-State: AOJu0Yx2l+guSIyXgdqLh72+KoihZ2+ThycE/gjD1f6UtA/ii1RHc0fA
 Ks29RTmWRN13RTr91uR+3KLiUcApQy/pwxkHmhEDiEla2l5I0jY/3wx5R3l0vL63TrsfAq3JiJZ
 HwO4cSUA=
X-Gm-Gg: ASbGncvFzSCjWDoC6sGatp1GUQWrkZPKVUY9WTIiY/65L/j+3NibSsM7ZDiJ2JfBPqJ
 dUo1cIuVzoV+59eMz9qJbTpK2971KTo1NlYtUYlbGOgAbZlGYHDPJFaL9nLavY9kYR0UJ+aJFKp
 w0dFiWrIYQgBBVt+bMxAIrvaD1RJgGFYcJEzIwNzOjOPgue76NWS2XZ3AwiBUvNdpEAdvi7a0e/
 vDLSNw3QcYKDRN+auDV7byfvIZDrb79gATp2If8xSKdjN5iOA7DnDGscri3ydKc9fkQ6RUfaWhz
 rJRObJzNze9SjD0fuI5P65K5eP70TSUaYWntiEZkD4mOkyzS0zLrRoTIBwvyV5onlmHBwZaBBa8
 3kG/UogIR9lW6LdlEESVuFxq0JaMBGziXmVOk
X-Google-Smtp-Source: AGHT+IFvFw6bb2r/PXHR/lFrlTkPfLDn6QArrYo5NlZes/IYoj63eWnrlqp8NM8AH39tkYw8cggFEw==
X-Received: by 2002:a05:6000:2504:b0:3b3:a6c2:1d1b with SMTP id
 ffacd0b85a97d-3b497029501mr12768373f8f.28.1751965155921; 
 Tue, 08 Jul 2025 01:59:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c903sm12560697f8f.90.2025.07.08.01.59.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 01:59:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] system/os-win32: Remove unnecessary 'qemu/typedefs.h'
 include
Date: Tue,  8 Jul 2025 10:58:59 +0200
Message-ID: <20250708085859.7885-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708085859.7885-1-philmd@linaro.org>
References: <20250708085859.7885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Commit f5fd677ae7c ("win32/socket: introduce qemu_socket_select()
helper") included the "qemu/typedefs.h" header for the Error type,
but files including "system/os-win32.h" should already include
"qemu/osdep.h", and thus "qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/os-win32.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index 3aa6cee4c23..662cfabc5e7 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -29,7 +29,6 @@
 #include <winsock2.h>
 #include <windows.h>
 #include <ws2tcpip.h>
-#include "qemu/typedefs.h"
 
 #ifdef HAVE_AFUNIX_H
 #include <afunix.h>
-- 
2.49.0


