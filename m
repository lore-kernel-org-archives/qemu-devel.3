Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C68FFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6CE-00054p-UP; Wed, 29 Apr 2026 10:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C9-0004qK-93
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:21 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6C5-0004gQ-4n
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:18 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6948d7ccfbbso3973842eaf.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474036; x=1778078836;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1e+ElYrsw4Uwy1NUtuxiSSVkG57IJLzK/avf8LppdA=;
 b=nKf78z6gf5glfqbwjMvkZOBKy8FmZuJLYtqs2IGGT4zPxfnFSeBEJNmW4Jz0AqOX7U
 Y/6u9dPVVskCQm2qyZrz7YFJzDGDur+A3B/suaeGcUmKRj56K7TOGhDNSTkX/4RCu5tN
 Orj1dtm4kkb9/xYMJx+25qS80jBEZPN7+9RnFCox11RvxgJqFlH4gQlMeQCV8pl1rGNi
 YOjAxsmXIknODVAArO+ysYBTq7Nr0b/1Jk2SXALOyxmgkhpbpkmbyD9r5bdArB2FXmKY
 GPupgjQzccP6SmyEdRGCony9hY+UTuAzMbbOScTQSCW/0UCUWM2xWZnENl00vBQFWNG8
 AP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474036; x=1778078836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o1e+ElYrsw4Uwy1NUtuxiSSVkG57IJLzK/avf8LppdA=;
 b=DvwrD5rl7F9pB7jq1K0wmmR3RgJmsBEVy9jsJzU314zB+arrrITuwjq669NxVbRp/S
 ebCjEJa/k+R1UYsQ2rU8rNfyXYaaEO6e0T0R7MdNSVEN5+iyCaBDq6he60Z+Q61zWPfv
 GwLikroHsQ+/ny2vBzBsb9AReCWO/8kNCLcvqZ/0So+rGTVPFRU1ZhPloHDWvYKOGCX0
 SZ5etwQrGPmAlPdrGkxFbncfPvSqY475kO0dPnNs6fyDZnIzworxyW5gLL5IG65sfLp6
 rX0OykpPAhCkwmC/ReF4ZwOSewOyCIqzKDU9qpZwZtLxHOxnl7OYLtYYT3Ywc8L5Kfy8
 Hc3A==
X-Gm-Message-State: AOJu0YwY+xMsgi1CYEulOJa0OzCDAeYzSPfp2LSIslhiJeVUGw9m6Xf/
 NwR1OXzS17Bzu4kz8rtkw0GdGIz2KBnk6lj+wNZPjJEsTF2bu+YHFu1Vs0yC31EGw1s=
X-Gm-Gg: AeBDieskxjk8qgVdec/7fyQfw2h03uExMgLL4Asdcccu7PQmGD21tBUoLJ8atMBniep
 PKsQwusfXPJR4QXmBG+lHY+GCbt+UNILeuVi277Ek1WBwQndsi8CPsATDoXtUlaLd2cUpfQBZoj
 GBMOhzGNJWLYqtqPrie9ryjYqZObTBTAuDHOSLustzYUbey4VoIcra11XVsx6Q+tAGItM0vMT6l
 GeoLvRtdpW/tAxy2supDtVyIhiKZFdv1ciHNXQDrzeyrwrT+oS7aWV1v2ZRC5H6/ulYkavvtbB1
 Kk6ZvuV80bXheKxYrWafiHXE524NkFH+aj6rVU9Kuo5b64iCavtACxP34VvzxNmUuUKKjxa8gfR
 6Vp7wtf76TOhk6TkemliVMZ1bsxFwZjZRWwrgwaUV0lKcfAwy9Jupi4+5ceacHHOyIrGOpbk1aw
 1YEZv7CxZJPyesyKdsMTA/
X-Received: by 2002:a05:6820:2916:b0:67e:21c9:ab55 with SMTP id
 006d021491bc7-6965ca67f02mr3988469eaf.3.1777474036019; 
 Wed, 29 Apr 2026 07:47:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:47:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:23 -0600
Subject: [PATCH v2 17/17] bsd-user: Add init_bsd_ioctl function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-17-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=27UGPnZgjmD1mPVP14mIEYcoboWhKhyrLBLgJZ9KMrg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl+kDTgmMcGQ4NI1KAyRRa7VMkc+7LKb6oyk
 2Ton5UGLriJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfgAKCRBsHNEofbAR
 AGo/EACS05mwjRl9ceJRe4qdolGGUfnbspHuk9Sxs9eTYqIiyI+BInQbXYRQmlmwqaL7QyVWFVW
 aYW+IEQ6G/dorhGP38NQW423m/ncJSlnwK7oCDmK+IDbOt9zSvMx65yDLXXcibS+vbRv/0wIlrb
 ccq0HB1zmqknKoRNFh8h9SMwnUV/U2ku7DxPHf15enCZroUlOsLgFFPp1xTxYKfkEykK/jp9KLc
 WkoEsCy3unfbGR1WfxeVHUfciZvedgwUVfHmkeTsOzjqRN05/QEVkYViGyOEQeSQ8+5lb12amUo
 vr+bt6RmE5P2yPM+UHyBG/nEv1CLQLCW5JPckoA7uddSKrt5SNTsp+xSAV5Cr4nI3HPGDvHpql1
 kq+zY/j/vJj75M01EsZSoBcUmHeAwyIVbeABZdgARiTprtNm0WL293bpz0xjFOG+TqhxFPVwxkY
 i4DSaPHTeA/QKNk1fG1oyCKmf4jizlh2Hy79Ep7Kc9j+d1YBUSNyf6dUdZBx7HnC/nOxnE1xNKh
 wclzrUvsNwEv/PSIVmrnWjr/hPajWouWlQctA+xJLuk1QhplhuXChj8tkh0fPEjMInJxYvhVwBS
 lMAmBWs55ei8q54bOUw8GHtvdRdCyjqZ3dx5akVyXMCY1mGyA1jexdx20ovG5dfTyK14wiuZjes
 zEMIq2RUWdfRfoQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c34;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc34.google.com
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

Add initialization function that registers thunk structures and
patches ioctl table entries with correct size parameters for
target architecture.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index ae3ac7ae24..0b6a0943a2 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -394,3 +394,45 @@ abi_long do_bsd_ioctl(int fd, abi_long cmd, abi_long arg)
     }
     return ret;
 }
+
+void init_bsd_ioctl(void)
+{
+    IOCTLEntry *ie;
+    const argtype *arg_type;
+    int size;
+
+    thunk_init(STRUCT_MAX);
+
+#define STRUCT(name, ...) \
+ thunk_register_struct(STRUCT_ ## name, #name, struct_ ## name ## _def);
+#define STRUCT_SPECIAL(name) \
+ thunk_register_struct_direct(STRUCT_ ## name, #name, &struct_ ## name ## _def);
+#include "os-ioctl-types.h"
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
+    /*
+     * Patch the ioctl size if necessary using the fact that no
+     * ioctl has all the bits at '1' in the size field
+     * (IOCPARM_MAX - 1).
+     */
+    ie = ioctl_entries;
+    while (ie->target_cmd != 0) {
+        if (((ie->target_cmd >> TARGET_IOCPARM_SHIFT) &
+                    TARGET_IOCPARM_MASK) == TARGET_IOCPARM_MASK) {
+            arg_type = ie->arg_type;
+            if (arg_type[0] != TYPE_PTR) {
+                fprintf(stderr, "cannot patch size for ioctl 0x%x\n",
+                        ie->target_cmd);
+                exit(1);
+            }
+            arg_type++;
+            size = thunk_type_size(arg_type, 0);
+            ie->target_cmd = (ie->target_cmd &
+                    ~(TARGET_IOCPARM_MASK << TARGET_IOCPARM_SHIFT)) |
+                (size << TARGET_IOCPARM_SHIFT);
+        }
+        ie++;
+    }
+
+}

-- 
2.52.0


