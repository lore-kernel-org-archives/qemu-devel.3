Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD14C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLQ-0003nR-OV; Thu, 16 Jan 2025 11:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKy-0003U9-FV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:18 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKu-0001DI-9X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso7224955e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043389; x=1737648189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swWbfqbBQuWTwxy/6Yz7+TAY9SVPbs3mxyJnC781jXo=;
 b=GLK8vyRyDD60NByImrO1vr9zCDqVSn5Q4iYpZTonThQ1VZ4F6/epwlQWvKXhNiRu9K
 ZvyXFjc0xa4Q6Gx+f71arOXCsv+keMSSDX7NnVo6VFgldQajT6TtHX2zXZLp1rCRQqbi
 tCH8twoG89MdxBs3+ljO7IhYhkp8VAqBJjZWq9dgIUWZ1cEGTH0bEacO9pPwe55G3n3a
 ommwJ3e5vCuYX8TknpdyjPq/rfqtFFXrhnzR5v+r3Z+kGHr7R8e9yT0xvPRnizw4gqz6
 dltxUWoXzERTvZdaQRgOp2aMHE8VWaV9/yRDB8svILSertR5OlAHapha0KjNT2xrNj+/
 sGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043389; x=1737648189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swWbfqbBQuWTwxy/6Yz7+TAY9SVPbs3mxyJnC781jXo=;
 b=sGdD9PXOBJzEqJnBNU+S9L9lMnYdpTNskx5xPnD23Skes5HZNEcIxojCxxk/UgTYMs
 VEKmjREjemTlTE1826akaaioFMkA3U2+s6yG9/4K7JghcT9fZW9+isL6+QyPr6ObIM6/
 EGc66ut5oCuyVx787FwqG3N3OvVf4iPpAf8IhPI3gXcAcfYMvRDvs8mF2rsmS+DB7PRB
 WqMNNik4OWygDF0HbVRc16zyBaY6VHU33eL0s9WFMfibZr6x1jP6yIXuyGkKtQvGsV8H
 HZDspsmutsIdeNyp+uJch702+sqUk/Xvb48yR4QwQruuD2cTTILPFEADXon0ec4t3giJ
 nF4g==
X-Gm-Message-State: AOJu0Yy8HW/AY0Gx+B0S+1epzGZdxYwjn6kclB8EQsKWxEMnWqLFvphp
 yoz+Jcyhppg4/HPewGIBhUy18J+8L+yuEAr7q5kjHr93KPHWJZpKQWCmIWWBqFM=
X-Gm-Gg: ASbGncs9AVI9i4pE+bcTsbOeQ+hIK5aK2aHRC/ZetdZ8j1FxuAYQi2UZ+twXTzWzwrE
 1PldncUXXnEGkmmOwBa68oKIY1Bl/Usalaa/L/eVwn0cP9SaG2HEvIa0JInQiMCIE/xb8wVc60G
 5uS92q4v+VMUxLvuWCY/dnM5pyGigD09A72XKEnkvQVsi8DpuiUUoJuef+5bnBrt6cRfGer3MHW
 28mSzoaRniPPOWIrPo3dwROiJztvCfKmZ3ZS9ID/SZoll6HcxZG2AE=
X-Google-Smtp-Source: AGHT+IGDVhkdNqtV71Fzt8tgrL7Sg15xkpEMJXUX56WGHJMVpFHHOLDbbkYOEd5mmOS0V7uYolunPQ==
X-Received: by 2002:a05:600c:1987:b0:436:1aa6:b8ee with SMTP id
 5b1f17b1804b1-436e2677378mr298564195e9.2.1737043388725; 
 Thu, 16 Jan 2025 08:03:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321537dsm232527f8f.13.2025.01.16.08.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF04C6084C;
 Thu, 16 Jan 2025 16:03:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 03/37] semihosting/syscalls: Include missing
 'exec/cpu-defs.h' header
Date: Thu, 16 Jan 2025 16:02:32 +0000
Message-Id: <20250116160306.1709518-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

target_ulong is defined in each target "cpu-param.h",
itself included by "exec/cpu-defs.h".
Include the latter in order to avoid when refactoring:

  include/semihosting/syscalls.h:26:24: error: unknown type name 'target_ulong'
     26 |                        target_ulong fname, target_ulong fname_len,
        |                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/semihosting/syscalls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index b5937c619a..6627c45fb2 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -9,6 +9,7 @@
 #ifndef SEMIHOSTING_SYSCALLS_H
 #define SEMIHOSTING_SYSCALLS_H
 
+#include "exec/cpu-defs.h"
 #include "gdbstub/syscalls.h"
 
 /*
-- 
2.39.5


