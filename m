Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698ADEF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpARB-0000cv-8P; Sun, 08 Feb 2026 14:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQQ-0000ZY-BE
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:46 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQM-0008TP-Rl
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:29 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-66a12c77a2cso2115550eaf.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578784; x=1771183584;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dFq+oPxxItGu2b8jP2aawOAXaYxohZenMCkJA3+jSy4=;
 b=qJqlAy0ZQhM6RbghCewDVxm0uMY7yTh7AM4YMmrSnr7l6CU3hFQkVoidszoKGNF0RU
 vY4Y2LBQFXupT9z6tSQCisHwgZvY51rx/YTEbbApXJREeOuRKkbGCKtVKalOY0iS5JQE
 sZmdN2f0SHYGH0DYYAV3sepvnQpz1SH7EiOvb5ph0ejzLvOf/itK12qnw5kzLCgsoNYM
 zyI8rZtMQV5zs3DEEtwCWk5MdZvrAjGgduq+D+aUVpnr5NThbFV5I016osoM5Rv9K+R6
 4P9mm/eold2YFbAmdYMTWRHX15lpwlTlseHvfvCGkPn4o2nadSE6/Hwrgws6/k+HhE4i
 Pqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578784; x=1771183584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dFq+oPxxItGu2b8jP2aawOAXaYxohZenMCkJA3+jSy4=;
 b=IA0HFGlgRVmysewZCywRBBkRNzjyd13VvM7eyQSDj9UCzyjeydcmBkcnzEnQ6/EcAS
 P4EzITyeaFW4TWgZit6jfqDqPAlgh0pXa+1n3CaCu7gw2nCCXPUl/x/fTINwFbEBqugm
 dRcuk5SXrNCgAuvyZYIc71pJ4e3o10jtGaSvLLiMzGLefBHI/bMR8zmfLmdqErJpKQg6
 0kl5RSTW4/Ba/Lr6/W0LUoTs4KV6P9A62QNxhLvn52+UxNIcFtMhMEBknhy+HOSjJ9RG
 D0R6QvNq65Agut8L4ZNMPHIw4+EBGuLxgELmB4AQnLhw0U7pAFJjaavjXcuvOOLMCA3P
 9bPw==
X-Gm-Message-State: AOJu0Yz7vnz1SwRum0NElOG0npuZM9tvnfbMz4y/UZIMnOwIuFuAZ5aF
 5bvUrJPmwtU3D3XiaKk0ocGTOjjdA4lp8Y9Sxttgwq//QHviRZ+4bc3nG8bWnB07bhESN4Mrnwa
 TQxa9nMg=
X-Gm-Gg: AZuq6aLK/FCtXCece5pTnWm42SQGlMy35rZeqeF4DjsY/HERRHFAvux+QA/bt4us2Gn
 dsE4Dq+0X4uNLt7iedXRlmRt9pYntLT7k5Y+zrRUYtMNxFXdxsfXry/O+uw9jES+fOTL9lyqka1
 E/gnjb8bwQSNYZKAri5xGJrqy9gb1znOVDBNyvL8A4jQnAX41YNYeyR+fbcZ93K9yPcwwWZDksq
 ilmBYi+mgJow1lBxyqIjyoxb4D89/zCQLWR3OXd55wvdEqNl3WcsThff1tsxVJbbfoz4TWDGF7E
 Sd87wDTmfrexIGuAlVG9HIZS/qCL5+w1d2dbagiBS60XwHYcFH3xRgTwXE8GWycnffJdexysJAP
 SRx+XFM01ZAaa/jEDAGrhxIML9/7JDXB2uNS5Z8E0SauRbfLoMmdjaoxBiMUh7Sodieo7oS2UTk
 OpxppOfjTN
X-Received: by 2002:a05:6820:22a4:b0:662:f486:cc7e with SMTP id
 006d021491bc7-66d0bcba2famr4426350eaf.41.1770578784480; 
 Sun, 08 Feb 2026 11:26:24 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:23 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:10 -0700
Subject: [PATCH v2 01/24] freebsd: FreeBSD 15 has native inotify
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-1-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ZcI16IKOjKD5KTPU+Y8Z1y1BUdJsK1hqCtySawrOOoY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONfvXPEzFPuZcwJ88UwdpFx5qtQuLiNm99zz
 G55LiuFfPyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjXwAKCRBsHNEofbAR
 APxsEACWyfR9/0oIOTapKzlWAUc2auOp+OjYIaFjhAP4ScbEdweS6dMXdBmbL3QiYF22n3yghea
 Bgam80kQNiz5BL9aaLmjq3h4kIzZo1JWjPOchUd3p0lN/nMtsjsy7Y2Q31gJTNulknyj9Oh1nLF
 CHV2ThfQ7JH94TLe7HQLEWcl+1QSty6qeCE+PWAFuynzjElWZAqr2Tu8boWYvbBq0NQB04S5h6D
 ISUTkA+kwycGhK8fPc11aYd3574na12mYFbmia+Enn5JT6YY0BH7VwmNvp07h1yhsmOCFoB+UnO
 aT3PnDEsON8cBfjx0TAVCs355awqtuenYBkPQyBbrlfgBpUMJmwLOAPr2FDlim3Zv9VtAWpvhBd
 yfRVQ2U+4Y1tiB7nqaCyO0bRcC7TsccHxEwo0c2BVsQ9Qa2fXJnwYvGW//62kR73k2i86eYmR6x
 bXII39kJMud7zcLVS/ErTcYH9F5Ft6LNufWXlQitylqVR6RY27ccTEjQkIDJFYADLkwuN7hh/L1
 h0Unm541PpU0BcMvh7sKTO7GmO5oemsrtfpQcx2FWnVZngdvEaMiZUfx5Zaf6hai8isKPpzokAW
 xTaUAJkCCWWfUd8D+b7BkFH8zFvydQAZTwhjwtf178B3As82+Bht1nCHr7rsmtPE30KvchffAt8
 EzdUtPYUW77a3GA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
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

Check to make sure that we have inotify in libc, before looking for it
in libinotify.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 meson.build | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index cc0dfed066..4b6574a966 100644
--- a/meson.build
+++ b/meson.build
@@ -2660,13 +2660,15 @@ have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
 have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
 inotify = not_found
 if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
-  # libinotify-kqueue
-  inotify = cc.find_library('inotify')
-  if have_inotify_init
-    have_inotify_init = inotify.found()
-  endif
-  if have_inotify_init1
-    have_inotify_init1 = inotify.found()
+  if not cc.has_function('inotify_init') and not cc.has_function('inotify_init1')
+    inotify = cc.find_library('inotify')
+    # libinotify-kqueue
+    if have_inotify_init
+      have_inotify_init = inotify.found()
+    endif
+    if have_inotify_init1
+      have_inotify_init1 = inotify.found()
+    endif
   endif
 endif
 config_host_data.set('CONFIG_INOTIFY', have_inotify_init)

-- 
2.52.0


