Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA46CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzy8-00042h-9m; Fri, 15 May 2026 17:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxo-0002wV-2V
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:59 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxl-00039p-O9
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:54 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso362111a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880052; x=1779484852;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A+5aUwpxsBxmkp0v1KRTDP/3FzgnZ1zbfgxvhFFILBQ=;
 b=rEsFsl1PBAzpnzLlBNvw2uCNOInvmBcmSYLQYfZdUZ5DZoye9R9LtXr1axabuWl2nZ
 KO3UbbMy5C1C/Q29fIVcxFio2ppw2MrD0dRTS42Um1RMJFVC3rC3gv4KW1LBUA6cxBGj
 U7ocozaY1JRiZIdhKQxGmPNvWSOOEvOmxx/VHW0OU8NEEvlZRWlf/OiCSXDDfYiFUK+e
 /ZiSccY0NNol3v+iupCpqi3i8TrwtsWxN2UMaVY+9y6+Tt3/nhfvbwnOBipKtHoLpGzL
 cqFzr9V3TGYPpOh1pzZh7HP+ilBwQn8tsjtwWtOJ5RXfyjvpa5ij3383N2f5tBI418pJ
 tzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880052; x=1779484852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A+5aUwpxsBxmkp0v1KRTDP/3FzgnZ1zbfgxvhFFILBQ=;
 b=A+YM+aLJckvTK51N+gnGHpWNCFQHWxEjVFtCUwu2JY9ZUQ/3y2FWztzPUD+bd3fnTo
 KWhsc22Pyt5ZpVXsLF3cnz5whSc4t8O/6+l8uQy0dVAPaoD6jERCE/eZTOUciqr98HiP
 rdEnVdezYcxOTeHCM44mqQoPffYnxH8vB3Jhj62bMrYbd9mEkUZg/C2PPFfTMD/Fcg2Q
 LSjloy/Rx+S4yS9K5zF3RYIDsDZUqYBFmSCLqYv8cSTeylsTB/60fIjGU/eTBenZ4mM2
 uFwhMOH3ZaBKh0mFVz8Orb7/YLCl5LlvosPtq2mhiLd2XV1jhapMIuAKxiGjdfDEC3vY
 xtkQ==
X-Gm-Message-State: AOJu0YyTtM4YMYHa/6POOuWssbg7z5+pu8tWjJd9gBlyImveRQZQXqMb
 JV5l/fDd5bWmx3W4vQQ2ycNdGjEdrkUpcMT9f9Xmo5lT+A+900QONAX7cMNHwvB6LY76hdDZ6Cg
 cwsdJEo0=
X-Gm-Gg: Acq92OHaCVEdKZ1Mfa/BAUEnfPBFlIrPO5RgamoFFSfJJYzeiXUN6LV0MiGHj3Tp9Qw
 4NSjd1SVJxYc7Kv8EV9qB54Zb+9e3g9flxlDIbpCt1xt4yObmeyguUb330MvT3HcC61R7Nc395b
 QPD7Gk2Kef16DlQuQtSrecmD2mEW+qUBFZ+aZnrpbGZoZy/akPIpMKueHYHfc8wWK4QQIWLgJe3
 WAnX52NOOn5BUlmgcpitimNx+NP56qC5VVHQ5XjgkJEZX8Gn2v7n3rk2adv+0OS8PGp5lX73uUV
 pwrF26SwtX+JG44GQ3Ua+6q5VbsgfUlk1DMmV62jrHf/sL6NlWCCHzoezUyICVBLcKO60Pdi+4G
 U5wJO7R/VtBlBpjWivDNLZs3fPd6AIcWqkvl2D+WUxInyboNC+P2uTO1lDG01nzI1i+8KeboOvx
 yWC3WJiUv9HSFGTgAPdOHs
X-Received: by 2002:a05:6830:6010:b0:7d7:570b:6800 with SMTP id
 46e09a7af769-7e4f2baf0fbmr3889761a34.23.1778880052179; 
 Fri, 15 May 2026 14:20:52 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:51 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:47 -0600
Subject: [PATCH 48/66] bsd-user: h2t_freebsd_cmsg should use SCM_TIMEOUT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-48-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=803; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Y7XfArYy0pNn3Hvj3eWUBI8iL0EqWHCP022vp3Eg9FU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43m8Q2jvZypBe0S79pqS7zPzi/6tBKRX9mx5
 6LeNyDCJCuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5gAKCRBsHNEofbAR
 AC2iD/9iT4nQicK0GSjRS29vwyC21MujYZPYrJ5E77Qp6+eSMC/pKoourZXlp4IudWlYCGXwCaV
 51eIX1CGC0xqoJ6xItYZsdAt8uleDL3ad4kjSmPKNqqAzs6rSz+5mz7BT4WwcLqXl9LDVoEQXLE
 aExyhZvgSA/xblSYMZy25VddD7O1jBG+bs7KsvMF8bGIz5dSS0Ep+s2Gp2vhgMpIkTS20SxrbQT
 gqNL8LVNGVdmg1qkSiVNzAJnspxOZDKxUYlIIx18a9tXyVr6Qdh6VLEuEcQ2q8T3j0k/lZckDMX
 TSAoSQINzdFv9qBKbLrD/mTGILiwBHCFRiQPNRRcdz7vFDjGYwtSjKxnGhOE+eXrnuE3MrNYzq3
 vduA0Qn31hi/+DhqTvs5PN/ha0KRNHQ5EBBSwwIMW+42V5OfAdC5V+kg5aPGC50i97smlWu6ePF
 qgWsAHKIywHvNdyu44b+u3rzuKcF5q6IuVyLfvhU33zJzVRCSkA+RFlHQIOCS0VCq/4QsV3ddcI
 tXfEWP6W4zwBYfrWlPLL5rnMtkfw04X+XH6M5vnAwYoS4jYvmmWvprfL37r5+L8GlQDCu1OfCNd
 1OOON3ze9FOJWqCBmmlwu7ze/9l8HhyurmoLFz9bFKOIpBE9Wg+x4tx/oi8TT7smwzVxQHqqhTH
 jhfPjZGIMshchkA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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

Logically, this is SCM_TIMEOUT, not SO_TIMEOUT. No change in behavior,
however, since these values are the same.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-socket.c b/bsd-user/freebsd/os-socket.c
index 543c9c10a6..41e40d2913 100644
--- a/bsd-user/freebsd/os-socket.c
+++ b/bsd-user/freebsd/os-socket.c
@@ -186,7 +186,7 @@ abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
                 }
                 break;
             }
-            case SO_TIMESTAMP:
+            case SCM_TIMESTAMP:
             {
                 struct timeval *tv = (struct timeval *)data;
                 struct target_freebsd_timeval *target_tv =

-- 
2.52.0


