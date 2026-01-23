Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B03CD74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbv-0004FF-Fi; Fri, 23 Jan 2026 09:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbs-0004DO-H6
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:04 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbq-0007m2-J6
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so18468135e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180281; x=1769785081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRjnKlHaglM5KNRL34gnS1g5I/h03KmLN/ZqQyvVsXQ=;
 b=S02vzy5RdiT6T4dBbJ+x2p8/WqSlsWzd2CQ61tIJFLo2lbntHp/3b32IzXeJUlSesL
 Vzx1lpHRq2UN9mPGXBXMfg7xAhsuFlq9pFaSuy8P5aR3FgjDWHq20NMq5dQXLEKp1Jpy
 787vArqiwbuSqQai9GzvU5iZ8SboZssEtA1VbFbTN5TvIsQM3qb+/lqUGAEP7Wa1JLJm
 E6P9yEl1Noe9cN+OnZMaE+nhZ17nsYUxOnWjhZ0nPLIbsLWKttHFaxglkwN1TXrMtlyB
 echCsGY8M0fj1sAXi7SApPLo+ZqS3wDC1iMQAQQxDJ2tbAwIT4GgiVoXjqrpHmsq2TIQ
 hbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180281; x=1769785081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uRjnKlHaglM5KNRL34gnS1g5I/h03KmLN/ZqQyvVsXQ=;
 b=Y77h3pr1MNfgFjgdxJYedg9X2Zz8C3nMX7+YFY04H9ppEBeLY+Ju2Y+OsWAivOlsSx
 WE+eS5I1d6ZLiIxrH9GXd/oEIlVZ+KhdTfwQYj5W5g3m4B43cMJ88sVC/fgD4XIyWM9L
 +HxKmozPcaCG54TRilpLSHWbLtD2rbXd1iFPKPbfUOT67DJ+Z+TVlabws16mcmm00jsN
 fTHyIXkqKxeOchwQet1cv66MRJpu5E4SSxQBir6jAuOgXQfNHvcv2rf+1H95nmtNxCUU
 PHINtigM19b76b9luMTcXJjBkgNxiIHtz+X0zBbmVqP9Kc/xnVwb7JyUQKUJmVCAdvFa
 3pXA==
X-Gm-Message-State: AOJu0YyI/NYnmwTDgdEYUHUj+IHTA+T4QuqfVylEYBgnPio4rYT782+5
 /FjUxbh5DvSl4tBEdLSHnrNamRP1mTwpCz3nkh+S6WOaxY3o0Y8+RI21eX3/jQZgBgI=
X-Gm-Gg: AZuq6aKdEwTvRU5oYwO7CYuirmES+HRiYDXRbC8Q0w1mk6DXNEywj98eNFEsG5pN8IH
 5GwQKAgP0K5KjTLE8yVAHjKz5KVw2Geoli9Ka/Fg9luU8pH5mk3vHXBdILjzdbe81T29uz5AbOx
 +Mzg/eyyLolDPDWaZ+X/zZXwIjZ7ncMuoIdFWjgH/UvSgir2uqVLYHXEoqnTRRdMPhCITtjQI4E
 q8AkSO8iQoi2DCytYAT9347CDTd+0GmcRAr18KFzN1PlcCkUmG0pFfgh7jknE6/LHBya0R8LhZF
 As1Q3aPbMlSA9gd0c1KNei6ITnVSy8UA/CPvAf5Q7XZHHh7eYj/2s656kpSlPeIvr1yR6cwWN7X
 /5YRem1BujoxC5mXP+1rhnmr46vEpEYD5AWYZ/Z3TxrxL0IhQvm6CWQBNKMKVPUiVWUcpMq2he6
 WPUkAxzFqzh8QG
X-Received: by 2002:a05:6000:4201:b0:435:96c3:da87 with SMTP id
 ffacd0b85a97d-435b15fb1a4mr5140355f8f.30.1769180280765; 
 Fri, 23 Jan 2026 06:58:00 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745e6sm7259112f8f.33.2026.01.23.06.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26EB45F915;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
Date: Fri, 23 Jan 2026 14:57:41 +0000
Message-ID: <20260123145750.1200879-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Looking at the merges for the last year:

  $ git shortlog --merges --since "last year" *-user/ accel/tcg/user-exec* hw/core/cpu-user.c include/user/ scripts/qemu-binfmt-conf.sh scripts/update-syscalltbl.sh scripts/update-mips-syscall-args.sh tests/functional/arm/test_bflt.py tests/vm/*bsd

  Richard Henderson (4):
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'pull-tcg-20251019' of https://gitlab.com/rth7680/qemu into staging

  Stefan Hajnoczi (12):
        Merge tag 'linux-user-fix-gupnp-pull-request' of https://github.com/hdeller/qemu-hppa into staging
        Merge tag 'pull-10.0-testing-and-gdstub-updates-100225-1' of https://gitlab.com/stsquad/qemu into staging
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'pull-loongarch-20250424' of https://github.com/gaosong715/qemu into staging
        Merge tag 'pull-misc-2025-04-24' of https://repo.or.cz/qemu/armbru into staging
        Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging
        Merge tag 'hppa-fpe-fixup-pull-request' of https://github.com/hdeller/qemu-hppa into staging
        Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging
        Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
        Merge tag 'pull-10.1-rc0-maintainer-140725-1' of https://gitlab.com/stsquad/qemu into staging
        Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
        Merge tag 'accel-20250715' of https://github.com/philmd/qemu into staging

None of the pull requests have come through the maintainers and while
there are a fair number of commits overall they have been mostly bug
fixes, re-factoring clean-ups and the occasional new syscall/ioctl
handling.

We should reflect the current status so users don't have unrealistic
expectations of how quickly things can get reviewed and merged.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---

[AJB] I realise this is a slightly provocative patch but given how
widely used *-user is downstream we should be clear about the current
state and hopefully encourage those who rely on it to step-up.
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee64a528c7f..1f313bba84f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4016,7 +4016,7 @@ Usermode Emulation
 ------------------
 Overall usermode emulation
 M: Riku Voipio <riku.voipio@iki.fi>
-S: Maintained
+S: Odd Fixes
 F: accel/tcg/user-exec*.c
 F: hw/core/cpu-user.c
 F: include/user/
@@ -4025,7 +4025,7 @@ F: common-user/
 BSD user
 M: Warner Losh <imp@bsdimp.com>
 R: Kyle Evans <kevans@freebsd.org>
-S: Maintained
+S: Odd Fixes
 F: bsd-user/
 F: configs/targets/*-bsd-user.mak
 F: tests/vm/*bsd
@@ -4034,7 +4034,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
 R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
-S: Maintained
+S: Odd Fixes
 F: linux-user/
 F: configs/targets/*linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
-- 
2.47.3


