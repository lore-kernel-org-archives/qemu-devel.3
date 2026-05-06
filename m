Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C9DCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcxG-0007nT-S9; Wed, 06 May 2026 10:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwg-0007NQ-Q3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwe-0002Go-Nf
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:50 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so99992675e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076585; x=1778681385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uaonkIYudK/xNKEuVvZ4LYtiC0muy271uDca+MHeHuk=;
 b=MVrfQ9DXlnZ3U2B2ukNrQxsq0nmFybljs0dlWJDkmsOE62KEZaybVoFK3fy2KZT6yn
 mEnBxzNN0NWiOLiRT/SQwbHA6DljYpT0V5BsGJYQyuU615i5lXghYELk+3qto6Of8BiB
 2OGUlnq1vAlxzm/jEKJcsJNf86zPFoD7aUTgUBDIrBslgYch7QRRwsA08u74zGUK/1r4
 FPsep/Ytuvg8u3Lcs2voRY/Hb6CLgO4qqZKL961oOMiKSlRdiujwe+T7Pb/hzYKx5iOO
 0KuikVTHFOKbZqal8FAE31EeALWgm9JloDaGoaQsB+6Uii4fnrJYv+MwLqrHo7u4gqwp
 qVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076585; x=1778681385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uaonkIYudK/xNKEuVvZ4LYtiC0muy271uDca+MHeHuk=;
 b=WmfZgXYirPFb0mZnZYQFcASrCS7a7p4wFe9f9jA0yyfx5FUaSMWcDJHOKCX7/5n+SZ
 2u0HCBL1x+pzLLUjEwCgzXV2MGa8McEAT0XWoAakV5iLktl+g2V0TpOuPqrLOUhuvuW+
 1U3/F0PoVy0d3LEDL6gAvjsc7HFpL0o2vlhWxV5ySKYykYLZRIEYF/a7UQ4jBvWvvdB6
 dLxvrogh2wVIcFwYsHz6xvYbaCy/90xFFYp5lmIp1/A8WX9NSiOMn5cqe/n+8PY5x+Gb
 U0s2BD31JDEuc//OUVOnCpvnpp+BFHIHJZDFSmdds9g86i50HigB8iqPTdpbAqhyZa7t
 eXWA==
X-Gm-Message-State: AOJu0YwF2gP+PP+pUFbfRobWR2A4PW2vYYmTYODIFn4xpT2mIPxHF15B
 zRcHh+dkJLxPKRPt7SE9dsXDog36Nc0Sut1TAwqTkRy6Cuty7hsJ+tZbpvnYcvgJsKPYFf7gzTr
 0uR1t3Fo=
X-Gm-Gg: AeBDietZhMEXG7tkP6b4Zcgyzp/dvp3gvlJqCVo+jvVE1m6670BGmtmF9ry3lrpRg8e
 bRvRjfXB7viF/gR3u4cU7Wb0w38xXAfuRcI7PdFDSe8jL7N7ojYAkWj/rA0MQ+d2m2BFqnXaOP+
 vZJTWu7QEjFQvX8Af3lPVOHgfZySQEXHAEnrdNg/wfnsHO/Ywxtt+NRHXVWa3sKuRyRV8nv0Nol
 KOGs5cAR+l9fFBbwDvjq0RX0vCWU0FaFkDFmjWPLLBoV4d3KjdkaooytbXWtZ9Hc5kHamM3iXWJ
 +i1XD2gnsp04k570pQZZfpYesSdFN+fLIgxQYZ8THHPb+qJRH2g9GKsbbOyt9Ms/72hgDsu1Rae
 ho9akWJisaOMmNNtFCVGKynHlGyZ0Dv75VzL6tXonFAhclmGrwJgt7Sfncta/rL0PpE7QyX1rQ0
 6q66Wkdg5SyRDwFpJ6ORu94sl6KvKWEjsGAJdXmOSvlPsx3ip/Ia2FLmxv30PmbviFUFZu67hCc
 ErjTtYGUrU=
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48e51e223ccmr60286685e9.11.1778076585089; 
 Wed, 06 May 2026 07:09:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a8159sm56958465e9.6.2026.05.06.07.09.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:09:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 109/110] scripts/checkpatch: Avoid false positive on empty
 blocks
Date: Wed,  6 May 2026 15:55:21 +0200
Message-ID: <20260506135524.20617-110-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

SUSPECT_CODE_INDENT checks the first line after a conditional statement.
When the block is empty, the first line after the conditional is the
closing brace at the same indentation level, so checkpatch reports a
bogus indentation error.

Ignore same-indented braces and else statements, matching with:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f6950a735f29e782bc219ece22bb91d6e1ab7bbc

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260424-force_rcu-v4-6-feccfaca0568@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d440553a7ed..2189db19f54 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2283,7 +2283,8 @@ sub process {
 			#print "line<$line> prevline<$prevline> indent<$indent> sindent<$sindent> check<$check> continuation<$continuation> s<$s> cond_lines<$cond_lines> stat_real<$stat_real> stat<$stat>\n";
 
 			if ($check && (($sindent % 4) != 0 ||
-			    ($sindent <= $indent && $s ne ''))) {
+			    ($sindent <= $indent &&
+			     $s !~ /^\s*(?:\}|\{|else\b)/))) {
 				ERROR("suspect code indent for conditional statements ($indent, $sindent)\n" . $herecurr . "$stat_real\n");
 			}
 		}
-- 
2.53.0


