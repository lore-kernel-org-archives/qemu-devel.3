Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4124CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3g2-0007ge-Il; Mon, 01 Jun 2026 10:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU3g0-0007fD-Pn
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:31:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU3fy-0005vC-CZ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:31:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so1769867f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780324293; x=1780929093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JDTMZpcawyWOqyr+KGw142zG9E8Gm5P3YR3vkRbg/VU=;
 b=WWOJOxScm6oJRjbnV65azEEqgomIpdDCb7FPOiup63498vDgb7VtMcxfr/wOdxkLGL
 SEW3XCykfZXQvQN2PlD0Pd2+1pjmGPaNzqNw0F7rrpSgBpbh5QeYhSovnd2BJiU/I5Ev
 cz9CIp960hmhR/R+yeShp6y7fy7yMHyhAyvPZEy/Sd1OrtSTCPKl9zI/VQcSpqkVJtZk
 P2gWibPBuGIjRWzRW+sstXy283SAuyPot/sYzkgfPigM6zhFUn3WycymRir2Ksqdh3Uw
 ds3J0mVAF3lKect6Xy++qnLbNY32iqv+6Dye4SE/GWAWA47TulWyimcRwUB1a8cIfPkq
 ikyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324293; x=1780929093;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDTMZpcawyWOqyr+KGw142zG9E8Gm5P3YR3vkRbg/VU=;
 b=midD/J4w3L8jKGKpw64+15e4oxcRxh41J+/MiovFYJ1FCe+6SQo0qrpyrEKRxt1cWv
 4/FgM/GvK0a6TwBD7EXXL2nMXKnre8G+gFst+mbY20eISJ0Vd319ZFMe1z+ynuv/6ALy
 2QCXoXAsoChXDnOaeOVyDE3sr90cAu+oayjTaQe1/ffFnmBEuetQTxj3m8vZ8U9AqASy
 iK0F2iqolJM2eVouEcZCujPDWU82VzPbakeMtGYgaYcmvwYf45MpKqaYdPyMiptWCezG
 WEfHnkCI6szsqbll+lSq8/gonP/08wS+0gp1V0tBXPtdGL8S7mg7sPfyURsC/Cik0pf8
 wJ/w==
X-Gm-Message-State: AOJu0YyrjmK4KKJ2OCa07eETn5rk4AI10O2f8LxKEGEUW6Z+x1TrOaoP
 glVSVDBb3QSFtquoR4Qa/ZIf5//IAKQbUo8fvyGNTUasbU+zsQ4k5RaT9adzHeuGE9s=
X-Gm-Gg: Acq92OHqvMD5F1os74iY68sP4YN2nTBKxP2W3djKbVj8lMz13Ov8ETBGKsHcMbpYvK0
 3lMVKauWvPClVG/Q43+y+EMSvLQ5/WiAKDOKLpDQ880EGeG/yYAxlpYYOe80wyLDtKKKOAMqn7w
 av9JUHUZPSFTL7E0eVhv8NlTLxfptoOAPHEf8+AvNEr+Pb4QMLtELXuFvOJrwj3hnRivkiG3Yrl
 De9TRybGkwU6gYcFOhEz4taVTOr6HjdyKxeXPb91jJ/Gl+k4DyLsFYAV3GPeacZLJMn4UQGVF45
 OJ+I95jkWCkAC9ve9siB6BWEwexzXQc9Ia8IErSXZk3RnPtuHZknXXnzyN3499/7tySDHDb++Pa
 1w77/N9bHYrG0RU95cqC34e7a7Zbkyx2Stw6tXKd9d8t3A+LeDXFFEwRmibs00n/qktG0ISmr8/
 iuq23Qg+QYqcX1fEA2SEGBP1FBSgYGmhfl4g==
X-Received: by 2002:a05:6000:4b1a:b0:450:ad00:86aa with SMTP id
 ffacd0b85a97d-45ef137a154mr20847638f8f.15.1780324292531; 
 Mon, 01 Jun 2026 07:31:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef32fabcasm25033236f8f.0.2026.06.01.07.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 07:31:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D75F25F7C7;
 Mon, 01 Jun 2026 15:31:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/3] testing/next: hot fixes (Makefile, gitlab, docker)
Date: Mon,  1 Jun 2026 15:31:26 +0100
Message-ID: <20260601143129.144786-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

The last testing/next which enabled MacOS broke check-functional-FOO
(which isn't directly called in GitLab CI). Revert the offending
commit and replace with a more hacky workaround in the gitlab
invocation itself.

Also include a fix to select the right docker fallback for building
mips things.

Please review.

Alex.

Alex Bennée (3):
  Revert "Makefile: include tests/Makefile.include before ninja
    calculation"
  gitlab: work around the inability to build targets for MacOS
  configure: use debian-all-test-cross for mipsel tcg tests

 configure              | 2 +-
 Makefile               | 4 ++--
 .gitlab-ci.d/macos.yml | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.47.3


