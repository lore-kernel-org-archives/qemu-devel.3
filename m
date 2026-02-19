Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A4BE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswV0-0002kD-5W; Thu, 19 Feb 2026 00:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUw-0002ih-Qd
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:46 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUv-0001Xl-AG
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:46 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40438e0cba6so393662fac.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478564; x=1772083364;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ybcbFI1+bWLheJn1D4q055qQBEYMdVh+FDDr2mQnLA=;
 b=ItBfJM+BvxQEXAhEXBbuMTriv1BNmFcbkaY5Bl/bkneSTClBFQgjD0K44XTEoPhSSm
 1/bPLv6xkS2dnSQWH2ev8I3MTLNc0ykffgIPm5pia1pxmKAtCIbUzo+pxI/xqsCMVpQt
 ioWo8ntkG276nkTpEXiw2CW7KfVs74bAKl21wbDMOEGMFafsz4BlwwArmMGFVBtkzkq2
 hZtALqzFJxd9ruvoFu+4RpvWhWnxiIb7VKz94tbi00SupIj5mYaTr0DyGBsRh9xHRhPy
 kmxvVME6U7FjOpwUY2aTOh5uAFxypiMZ1Fml1XyxeVPc6eD4d9IxhWM5XBeoNxslH9m8
 eVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478564; x=1772083364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1ybcbFI1+bWLheJn1D4q055qQBEYMdVh+FDDr2mQnLA=;
 b=RBcD8u+emklFHHW546NrgZR3iZI2U93N0LW3KpxsT3sAlf1XmowE56MtO/Ud7qt9Qy
 Nhyl+3qv11BuiykL07hacyqmKqQ3dET2o2tE/w0J31XK/lHP5Qv1IQ87sQH6k4vH1dTD
 b6+FqA7NCu5t/uNBLqTqd4mBaKej7zz/NSJL7ax8GvVPSd4DFAs5vnKDCMT4gaeAZSHx
 ycz/U+kpjkd7L/A4Gd2IUF+R8FL2L+zK4mlwzRAvPF/n8+02FDMjk3O8MysATo+hbs3h
 jKC6ChzGyaZaUApMaQ3gFzGp75jP8WXT2L+ZxiOMyf3WVQoZsjjYQhFe7LSA+5pnUGi1
 PxFg==
X-Gm-Message-State: AOJu0YxY17TQr4deV1qXaU5cZ5nyPzodGssSfpXdBbrreZn4wS+624tK
 iYTQ01XoelSvZUb6zFyrEynnSLrdm3DA1iWw32q9y+RvbnQPWiYK3RpMt5Yu/7lA47GRme6TOc1
 Gd7b+G1g=
X-Gm-Gg: AZuq6aK7UoinJnEmOBJH8XmJKF8d1UyCalrUpa+7wtcij7TJHKRke7Dc5c1KCwVEeCh
 B6HoF6e5h8aLF1sji3ynboDzr+vYmsWqYN0k85vKci7k2bu/qaFhCATtTJ59R0i/0qDKNCsXYt4
 ZwKCmWdI2JnVsKnp6y6nWd4d6gxLfa6PrxsygdI2qJosU24myfoVU84kFv+mKPlketZDNari/sQ
 nIe/1YyhfvCXgjV/Th0PEm1KAOVHvA0eNG5enr6oqCAJaRrNnjbLWQeqDfFYexkCv5QeH6/KkJu
 E/SFAmg8PbmLaNRBjhcKAomoninmH9yhWd/p72pQKVgXO9skEKWvIjVDekOSuYj1SJq/f9IExQX
 Mz+nY7xg97/WIFS9t1DOruyYEdawBybf/wDgQVeZG4yigEVIyxZSopFZimQs0imzkxQJlqTODYr
 nIOGZtasISpXiISYErjLll
X-Received: by 2002:a05:6820:4b12:b0:66e:61cc:80e9 with SMTP id
 006d021491bc7-679a742d318mr2306471eaf.47.1771478563998; 
 Wed, 18 Feb 2026 21:22:43 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:43 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:30 -0700
Subject: [PATCH v3 07/24] bsd-user: Add target_to_host_semarray for
 semaphore operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-7-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=eU3/9GcsUmR7R6CZ+cId5a+3Dosb9k3GJT2jhlhOAhM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4r3GKyf1I7YqMe42wFbbj/s/8TQA2M7r+tl
 FNmK1bsxgWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 AHc1D/wLC/RaH5E+t83p2JbpMBDFra/W18Nq+jLXrbCcK6k9g9H0HViQPe6RKFDU/haXsobz8Su
 hFjdq/1nB3u3zBbr0CGzF/FnhFHpkByHBSY7TKt6uapBfATUNqrOjxKOuz4uC2t1b6G+uK+pTii
 b+xXQUFdXtS37MR5aY6WyflmfkByeTQyBW3npOv6KkqK9k52SfWgiNmV/Qn4DmuF/uOBgNEA9lX
 IXSUX0di5hnDvnUjMLLFWtedz8qleyisExRCUs3P+4+Em1DVubizAue1GOsVAR6VF2T1dtX4FW1
 Ww+cJ7zzkQtsAZe0lR2NI6bTZdOjjzSiU8sUh05/SDGD9QfOc0Dep27aWtYjrXMOsMV6Lx9nNBn
 fnVWqJrWYnzIAGS6JIBDzsnnIGUNCiPiMVSIN3jcEpvoJ1FxKCFk+BHrQTu3A1UNuq1pKGeBZBy
 r6VdBwi75iRtkcLTL6fuBWlChCxpPLSP0xG9bn+yWSIuwD6x3184oM5eX98lUQsJRIvVLO5u+Ht
 YI8hlYEUPM52Yc4trX+7PYU6OEu340FbGR2b+TygOealYC3OysZgfhnr6uzIKsVsgm6Q/3s62O3
 lcZJ1aYI0lhh4o4thnkEXghawtdgWblXys0dKkNLS2cJ6oHS7uM66Q21Yoh7i1tnipMkiRS/q3/
 Lm9DEW+giHncTRw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2b.google.com
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

Add target_to_host_semarray() to convert target semaphore array to host
format for semctl(2) SETALL operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 68b67f37ba..d1645db46b 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -7,6 +7,11 @@
  */
 #include "qemu/osdep.h"
 
+#define _WANT_SEMUN
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/sem.h>
 #include <sys/uuid.h>
 
 #include "qemu.h"
@@ -33,3 +38,33 @@ abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
     unlock_user_struct(target_uuid, target_addr, 1);
     return 0;
 }
+
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr)
+{
+    abi_long ret;
+    int nsems, i;
+    unsigned short *array;
+    union semun semun;
+    struct semid_ds semid_ds;
+
+    semun.buf = &semid_ds;
+    ret = semctl(semid, 0, IPC_STAT, semun);
+    if (ret == -1) {
+        return get_errno(ret);
+    }
+    nsems = semid_ds.sem_nsems;
+    *host_array = g_new(unsigned short, nsems);
+    array = lock_user(VERIFY_READ, target_addr,
+        nsems * sizeof(unsigned short), 1);
+    if (array == NULL) {
+        free(*host_array);
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        __get_user((*host_array)[i], array + i);
+    }
+    unlock_user(array, target_addr, 0);
+
+    return 0;
+}

-- 
2.52.0


