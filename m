Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D790EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpARU-0000f1-40; Sun, 08 Feb 2026 14:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQS-0000Zd-3e
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:46 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQP-0008Tb-4Q
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:31 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-408778a8ec4so3174553fac.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578786; x=1771183586;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+t1iHUqtREGyGrJCLj2fqTNeBuRk/na2OctX3Jzxbs=;
 b=xHVxhEEKGochiCQBAFmWLVLQAP61um15L5rMaJS8gHFDfxCF7ulYOQlVPR5mCjdnm3
 yfQZPzbwMYbUd6+ETlv2S56rw3TAxHwt9nL79+fH0fLo9/4nZe1zmogpFCdNoptwB/A1
 ud8rqUDeXWxFypFOA9zQheQ6p9nUoQTJPRF0kgeWhAaKrsPHYKky0SJE6rVg6rLNQQP5
 qsBhIqrM9lSFodZJhZOwVjQiN9FwZqmejrjmBZciQq7+naSPVu/B4XrDjUSav6VeZ1t6
 tMPb3xF6XOhoBgUbH4Mj4P6JMGBy46Sn2sXRVkaJ2+rdA+zgCONSDLHi57uee5taIoV7
 mkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578786; x=1771183586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d+t1iHUqtREGyGrJCLj2fqTNeBuRk/na2OctX3Jzxbs=;
 b=EDX1SpuBb0JPB6ySCbPuGj8vPe7BUq4d9CaRMSJpyYFgz6jK3RSpy+iOboWC1byh9O
 97rJOeSRHFTLUk2xByIeA2pqhCW1gIb4WzVkLxeqH+8WdrZXY2BTC+5WbrgiveUvGBgM
 1GfrcriJQIDtcNYUJGgrQrKMucewqmOor8LYxnyHWOe/N0NVUSnzgQ3V0fB+jXDhoTSb
 O924tILCFDBJV4X88Vw10d7brqWtjzA7/IWm22X9EoqkuviHRuC8vhvrz9+3EWC3MYVN
 HR6e/Leie1oRwF56D6p7bgX/GAKuNzhYqb0EJbvDK0Om1dDrPPUAYDBiuY831KhVAOZd
 iXeA==
X-Gm-Message-State: AOJu0YyVi/RthrdaI73ghKEdu5FrtQtz4rClqtmT5ZHFyAyr8Gna5LPw
 nh1kuKp1VF3E8NqkfBQO2glRlI9OkjjXfCwSo2QfL0jQIvGlpxobJHLqhv7JwlPRtBo=
X-Gm-Gg: AZuq6aIAJeHf5ErnuPYU2QgS0yVLVY0epLiZazHVQa3/r5JyWhUGvB7D8laAwbNBQ2K
 41IGyZXzkSQLYFrv8IU1VirO6I7VCDylhJNjIkmqsbwXPoA4wtQTYcC7a3092A9mo2NnGgXKJfi
 4Jf9jKKUwm1TL30xQsSNXTRmi4ayQOk9D6ubR58ZBMx1AdEVDHYfFcMwjf32iGRTvjVCZlBx085
 S0CVwzmopxWeQz/ktpABspZowL33jG7ZYxhBOHY3dFokIHSUrNSa2Kjz9fjjgugavMVudxfRk1R
 dRMHyzFiUyw1QBK4qc4PUIER7uDN+o2aYY8olgKy89KH1ZiGusPxy/lHWbCxcIr69ZzAvAM93w8
 UpN4Ozu0SGUWEYCv+XkLJ66xlp06PHgVxOJeac5QjLGVVNjnL4V14fatNg/CYv23ldBzeP1Zr1Q
 ==
X-Received: by 2002:a05:6820:1807:b0:662:f493:181 with SMTP id
 006d021491bc7-66d0d015e45mr3818704eaf.76.1770578785993; 
 Sun, 08 Feb 2026 11:26:25 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:25 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:11 -0700
Subject: [PATCH v2 02/24] common-user: Drop __linux__ around
 .note.GNU-stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260208-bsd-user-claude-v2-2-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8f1kgvOYIoToweJ4bia5M92ZB5KgOcRUK3PIe6pRhak=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONfsRxPc94yNtb3IvMlGHWvP+ef6lKXN6BUW
 NE2ifHThNaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjXwAKCRBsHNEofbAR
 AMvPEADi8/0fc8gbaAXiBfoDQgangZ1zdPKxArxXjc1X6vyCdq/ux8esiQHBxRRO03ojIAQdf3/
 2UZWBv8UyuQ6Vhhoc7a2C3PbgO83rec4dw00ltv3u7tfEeV45OYqzRGrDdH2OrwcObcEfCosRZ+
 6gFFZwpQbljR7xZEpzskriyVBVPD805l85Nllcq/wXhf3m/V3zRy+FSCmBEGtQwUa02CzwJVLyH
 R6sHtGa9EBKihStqu2qIKxw4TsS7kCxJikhXZY7W8eWMnT7Hxti59ZMrtQiGfEKy7P9223wYFHv
 ZT6ypdN3F0ugSQwFbNmUj7SloipBrpQjpzsofNizL7m+xCqNtRMggn7zF9jDlWMY07rVV9qb7yK
 AL6rCEU/kmO5sz/yCxeOzWuBM1lQc37Jk4o9ynqtTDW7Wewoq7zOhWctLMQOyGP+cxNeWy25aoX
 4amb3xofPSX6rewC0zXPqi8OWDegFHtBEZqxWNDNC5ngL5enSdTjEhYcVjDvMaqRe18/OwXAdfC
 HJDokk55s9GIDjxkikAiD1s0bMrChEQ7MN9L7YP+rLFGw79vo9KIcd1QXR1SXB7M0hYX5uzTLm+
 4xTokmz6LqIrkURv52jYG1rwr71V648ifQ26CGWX6GOrKnI/z8FKyt1egk2BQkLhseWdul2hTGc
 69YEZjMGZJ7LHdA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
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

GNU-stack tagging is a toolchain issue, not an OS issue. All the
toolchains require this for ELF.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 common-user/safe-syscall.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common-user/safe-syscall.S b/common-user/safe-syscall.S
index 74f7e35694..2f714cfbe8 100644
--- a/common-user/safe-syscall.S
+++ b/common-user/safe-syscall.S
@@ -22,6 +22,6 @@
  * assembly needs an executable stack and the whole QEMU binary will
  * needlessly end up with one. This should be the last thing in this file.
  */
-#if defined(__linux__) && defined(__ELF__)
+#if defined(__ELF__)
 .section        .note.GNU-stack, "", %progbits
 #endif

-- 
2.52.0


