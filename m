Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD245ECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38D-0004Tt-36; Thu, 05 Feb 2026 12:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38A-0004RX-K8
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo387-0001Qe-Nn
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40418578e28so451273fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312416; x=1770917216;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4ReIJRsorlhiNXVgemAxtTwAjOpjMVj9VahoA0vg7RE=;
 b=aEYAUUJwNHRysatChtfhwNZMEK1QbppEz2KByKWpjIHexyhV9eI6RQw108jW/cvWdE
 bIWOs4c34J9PAX2fd4QPtWvxnVPp4BuLAx/6jEULXjsHsgG0aYcLemSOeZpgIByMLM0j
 UfYOaub6zMPhNV68pTkn03oK2Va6daE2RG010Bmp4Mtwni7G4Sev2ANI9xVBwArIB5Sq
 9MLvgQfRpp7XtyrFjwPE7xdfQzUPoVw7oeN23R1rEMfjw8ZnjmebnAL6KQDuse44wq/W
 +w3c7S9s1578O4/xo8/xvpWRnGJuwYEXNpdxS7kuW8iuNpcZZ7crYZ9kstG1BVka8qQx
 4aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312416; x=1770917216;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4ReIJRsorlhiNXVgemAxtTwAjOpjMVj9VahoA0vg7RE=;
 b=jcnYIwH8tx4GAiz8cai/Ih54E9YSCWFEpUhpIiwDgthUspE8Rf391NGlBnMTtKlTSz
 m0WwbEdLRYCaX9fwtJhn4KBbIGduQ1awn9BC6A4zQj6tgnpJks8Bt9uqRhoC7fz7iBtc
 6qZF/ksv0BlvIenRby3CNei5fbZVlXUg8Y2fhGhNZ4srGj6pPMOxxKSWXc4pKcVSjpCW
 lcYqTMJUbXEaRMnZfP7W/vPnUszztZQKvUuYdhtLuzdRpHtKiFVn0hlZXF2zgTwx/xpi
 w2uTJ5PgB9jVzesOhqZYdSu7ovnDmBcrLnuVJAnQWxhHBENro6y4mJ844Xnno3A4F9Ve
 Eitg==
X-Gm-Message-State: AOJu0YxIztsosM8tvq6CWYLh2JpBaVihZ65rPSpVwN4nFJ3HVO9vHiyN
 wr4AWFDNH4RslntubShEAxHp6a7idaVceYJhc+mjEX9NxpadL9Dgiw0M8bL0Gy9nOkc=
X-Gm-Gg: AZuq6aJ7qpmfJznivwgoh3RVZFcLsYHGb02MO16+TJGRVRQMSg9p3md1yF4sbe1vOdk
 MWFKnGsZmIn59NgWAG1QvJB/1dLqU6vyHVq94Ec3HHrsTmZk6VoOXDmkGVcDsDA0VmNp9BaVMVs
 BoQkkLfQO+OYt3QmtOEeNr+9ljUbJ9SmkGrYOtQGbUYHTWKF/81/gzfdvATaGl1Am5ThsMSWjBL
 6Fpz03urK2rFXT2KTJ1VTSHsf9yW+TEyHpmHpe5jKuAfLLpEjMXsC2UrtLrN2noaRENoq+Blu94
 660b0EkiFWkvmd2eOyUUnBQItgtEGVAT6iEoO4Vo7wnpV9HsJxjjMmTrGZNA7Egl2V/Ebh5VwML
 o4ObZshrg640yIC3qhgdnQ7um3A79xNkB2cATRr+hNTb7nGDyuk5ioMGmfLfVkaIeQDAqqqoP7A
 ==
X-Received: by 2002:a05:6820:4def:b0:662:f759:4eac with SMTP id
 006d021491bc7-66d0a667296mr63253eaf.32.1770312416435; 
 Thu, 05 Feb 2026 09:26:56 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:55 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:47 -0700
Subject: [PATCH 14/24] bsd-user: Add do_bsd_quotactl, do_bsd_reboot and
 do_bsd_getdtablesize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-14-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=MTr9zFWCmgi6CbLN6AiFYEMn8CfX5cmEIy65yFuNsdA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLb/6O58oXrEzzddItGmpdEfF+NR8W03TVln
 oqFIZSfyyKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 ABKqD/9iOyAHhd74qVTb85F9vEwgeROT6Ua+o9KDCK5T4sIHvR8Xy2cTcxVYmSUNb+0qxFSOg8/
 Nokgqx31MfwD++2Ql0hUb7p5omhbqtDzqi6cUP/87msK7mahN8zodODMUsBJ1J60WTBfwxUVeOd
 2JBd9EtBFdPbYQmDTjelYMDu8tSBqDkfggDTntcn0zRBn4G4oODGcveuNAoEB5k95bE0PuVIRbY
 Koh7HTE5OLycvtMtmmUGf4ocQOPwK1lYroj6wxFglEOOqZAEhRiMGKyAjhn7V6LNbv2+SMxlGga
 FMs6+57IEnuLvrBTgA89E1XiqhJaySKn2QXDzmN4RMwqNzX+RXoearwsOyZX/fIk4XhBAGyU0E3
 FDMGl2wDM1XQ/4Z0bVbbVUQrbUgwqbQe7oO+0D6s2oM2oky0xd9Btg2yRQ+Vc4oTEqkhEjQSq+Q
 8VzATN+9VIp+UixBxaDxXatLaOY9UV79ZvjZ3RpYYBUVbnmGJXdNly0UHDK95nS4WJInB8a/AqF
 g4sV2nhjiYEhJrTRdOHDX2+XIdIYjl9zUyZ4VgjmOULksnKaqjJZ5w1RMdpf09bdDScdjFSFEAK
 85rByYPqA4hvIVAP4Q+sbh5LjwJYsFGsoIH1zmvNG94Pfj/aMBgeDdrb8Idc/BXOm3weNdy6NzI
 IYzxew0yjYRPAgw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Stacey Son <sson@FreeBSD.org>

Add some trivial misc system calls: stub implementations for quotactl(2)
and reboot(2) syscall; a trivial do_bsd_getdtablesize that calls
getdtablesize(2).

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
new file mode 100644
index 0000000000..d81b4fbaef
--- /dev/null
+++ b/bsd-user/bsd-misc.h
@@ -0,0 +1,52 @@
+/*
+ *  miscellaneous BSD system call shims
+ *
+ *  Copyright (c) 2013 Stacey D. Son
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BSD_MISC_H
+#define BSD_MISC_H
+
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/sem.h>
+#include <sys/uuid.h>
+
+#include "qemu-bsd.h"
+
+/* quotactl(2) */
+static inline abi_long do_bsd_quotactl(abi_ulong path, abi_long cmd,
+        __unused abi_ulong target_addr)
+{
+    qemu_log("qemu: Unsupported syscall quotactl()\n");
+    return -TARGET_ENOSYS;
+}
+
+/* reboot(2) */
+static inline abi_long do_bsd_reboot(abi_long how)
+{
+    qemu_log("qemu: Unsupported syscall reboot()\n");
+    return -TARGET_ENOSYS;
+}
+
+/* getdtablesize(2) */
+static inline abi_long do_bsd_getdtablesize(void)
+{
+    return get_errno(getdtablesize());
+}
+
+#endif /* BSD_MISC_H */

-- 
2.52.0


