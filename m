Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE94EC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLH-0003hA-VX; Thu, 16 Jan 2025 11:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKx-0003TR-Fm
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:15 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKu-0001D9-0z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:15 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so611815f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043388; x=1737648188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DqQTTK9Sh5XJ9myCGTy9pkOibsLIRbJz9Tu9rOcYZ4=;
 b=ScnNga2Iutp8Sefh0kNKsZQ1ZLaEsQIkxcDKSqtzoeMlGZrcVFk2ssdhPAq3bjDfeZ
 zPHnuu+qZhVxUUfVvtFAySdOkkhTjOifaHFk1qUcKgqobDbkmretN3w7yCymDkN9RYac
 KFBS8BRhWeBB7+rX9OQtFP5HI9qG3OMq1dWjS48d3BlEA02s+pzKyG8C1UTAlOG2QkGk
 W1CmT8Rj/bDdpDxtMLkFmnJS2uarUSXaEaLI34t+buAkILe5C/pFjqh9fH5XSaGpWZd8
 NVZLTFhJ5i5eYO1/4uAhF/8URg4j8mgGpzVm819tOVUfUBZo9MTv+BTMw9JFec+Q0e1T
 KhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043388; x=1737648188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DqQTTK9Sh5XJ9myCGTy9pkOibsLIRbJz9Tu9rOcYZ4=;
 b=bcX79DxijG2KCBlc75QNuM3ifSrJo8YUFAXpRpKkicSI5jQL2KDEO79WSsWqSvwO1I
 5KOjtNvVUwCOPdSOf/U2dD2lTa1eF7hFzukqLUwJL6oBLzK+WN05jXUpwb735WfcDbhe
 8BuHw1nDbKfcZ/W9hRYX3iwZrVuXWWTcAHX095vJkl/g6lODv+uCpjM1yk25JgA6DRrz
 RFqGid37MgiXaVAn/Z31Sd+r4bdNVqrdfGwaAOCD4alsi6/GUIMl+9lpuhxjT5dcDYgv
 bZkmUpARMS+KtaTkUHO2WICfiHWr0K3nyRUovvADEjpa3NruHOX/svHEjqej1M+sj9LP
 a/Gg==
X-Gm-Message-State: AOJu0YwegVrsk1JDijNJ6DqkIde9e/khe2LMh8CPAdTahC79uVx0Y3sk
 NEX8wat42Y8R7YbUGZEUzme6fXE3V3ACULiZm7QluUuvfGaZpIR7chK6tJARRiQ=
X-Gm-Gg: ASbGnct6mSrWcING+Hty3xYslcQF39gDa/KEkmnfFmyvfA6sH24UTkGE2O8mXJCAUiZ
 hp02/ejGnE1gVG5dSHHBIv6WfpmLRGuNvBL/0l0Jb2uU2W1DcLI6Dd+PXzqQ+nLrKFTUZI/5B2T
 7/2fNCUK5zfhppQ/jpwskJ9xYviK0+xT1c0oWgtuRBnDbgZwiRlDPdwNM4EgPTxTbEh9M3H8q6g
 /rhFyYtyhxeccpQnBHX9/msePpoIn/7y86jbt19T6qkex50V0ilk90=
X-Google-Smtp-Source: AGHT+IFjXrx6hV26VekQ0h5aiHI1xGLmXFw7J29CAJUiN16IAGtskqvfNK6mTS+xIsxnetNh74iGpw==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id
 ffacd0b85a97d-38a8733a1f9mr31718915f8f.45.1737043387970; 
 Thu, 16 Jan 2025 08:03:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322b337sm220758f8f.59.2025.01.16.08.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7ED716082D;
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
Subject: [PATCH v3 01/37] semihosting: add guest_error logging for failed opens
Date: Thu, 16 Jan 2025 16:02:30 +0000
Message-Id: <20250116160306.1709518-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

This usually indicates the semihosting call was expecting to find
something but didn't.

Message-Id: <20250109170619.2271193-2-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/syscalls.c | 2 ++
 1 file changed, 2 insertions(+)

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


