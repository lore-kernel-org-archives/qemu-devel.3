Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEB0CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY61g-0003FN-UI; Fri, 12 Jun 2026 13:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY61e-0003Em-3c
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 13:50:38 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wY61c-00083J-LV
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 13:50:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-842273a2c4dso908670b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781286635; x=1781891435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1cPo1txX8p+nS48gmGVF+iLBg3zRFgOVWKjwHALGe24=;
 b=Ms8dD8+Jdk1CBgvXMJcToEI3FtKhoItpDSSrOFEVqy4OYVQye9GeVoJIZG3tw3Xecm
 2cSwMNjnaOUFPWlup0MznlaTzGAB09J2pH2OzGsLSW7qzMZz2bJv1BZ0EkOy4RT1kmwE
 OHy+wT0wbd905Tb5KhSfZ7/OYAfMFh1Ck8FPsSDPa4ev5iywGYJ4UMf2ByJknhH6+Nfe
 yM8BM97rjqrAw9EbeGEiBXSfljMbXoxShPK/XhxKqkOt6a6qelEkwaPm2/3vWG5aVvdB
 k/6eucbs5Zn+UpR4ngT/II8S4cZdjXPF2seN2G2bNZvfeff9sEfjn+4IYYwC8kZsUpAm
 G5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781286635; x=1781891435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1cPo1txX8p+nS48gmGVF+iLBg3zRFgOVWKjwHALGe24=;
 b=SftXOpVzKSSkCx+pE40xZnWzC03gvJW2ECOh2lTx3B42cEWTXIopChwr1f3WkEVJoz
 x4olMJIEaIsCZZ+ft6QxlCWyAQZIiMDvGyoge0BsTSU77GesgcltNlpl6UZy8wTqkBiy
 Qr31YvVQ47AVj0IhZjhknd/TxtXmVkJGIVmASbNKTeAd4yADii5kQhLt238PFvaO5Fml
 Jqz7+mWVroUJP1IA8VjmRfoua4gOSZrg0j7Q6KVGe6VlXVb9Snuie37vpJHojPtzxobc
 GNPtx/xR1OeJQ2jbtc5rsNaIkIk3AVUr18xVvB47uz3sOK/KiEGBdLmAOzbCiBUum6lL
 UsiA==
X-Gm-Message-State: AOJu0YxRtTiXTgY05HXGf5aqHz5gHC0PQpaJwvVfIk/kNeq+EGKz0dIr
 dJj13bUdvO+kvxr/L6dgNWJwdMEokS3QAo9zrptHqoCFXlzfgZPFU59x/CAbAQctObeDO6o0gpu
 EE5r/bLM=
X-Gm-Gg: Acq92OHad3fC6XDBqh4RJxNS5mSl58MD4aV4sOgG0HX7N96RfaGn2cbzJRjeT2RXKi0
 iTzpb7agPalKKhUV7DOPP0SCpSYdzlVJj0w37f+481brpB08VWPkpI442eh/XrF5sV9mO2E4qUy
 LTF4VNjBdJzxVdRX4oPKbtUy0dfLipgvxVmK5CyEN6ARvyU/+XIQVlbXNjsIJ8tw2oROKGsZKui
 JZyfPsfTZ8QU2AmzSWWK2sCOkXtYtjoDNq1aOmJRGMOidz9MSseY67J0awa1z7gsSzSePRQj9Vu
 vxTIm+kKyMG+KrSH1zd6M1ObfkBEY3FCSEtnZL2gEF0hcDPVr6Zg7lxeazruyhgacKur7m3N1G/
 wUCWUroTEUUUmZ6dzAE7OAxeFwbnw0vtG2jzo/DKUdnYYCb9ipagmxiBkPOkgZKhQtCQi/iciKt
 cM4D+26q0n31rK2it/bpsQdqTmQ3Gm
X-Received: by 2002:a05:6a00:805:b0:842:3be7:4d54 with SMTP id
 d2e1a72fcca58-8434cc0b564mr4286366b3a.15.1781286634366; 
 Fri, 12 Jun 2026 10:50:34 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afc8a84sm3393319b3a.38.2026.06.12.10.50.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 10:50:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] tcg patch queue
Date: Fri, 12 Jun 2026 10:50:32 -0700
Message-ID: <20260612175033.58007-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The following changes since commit 193963218accbcf65f28ab1efa773ac6d1cc634c:

  Merge tag 'pull-ufs-20260612' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-06-12 09:01:07 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260612

for you to fetch changes up to f6ff5ec21e16aeb1d283e13d0fdc13fcfb712af4:

  tcg: Silence ubsan error on tcg_splitwx_diff causing overflow (2026-06-12 08:52:59 -0700)

----------------------------------------------------------------
tcg: Silence ubsan error on tcg_splitwx_diff causing overflow

----------------------------------------------------------------
Fabiano Rosas (1):
      tcg: Silence ubsan error on tcg_splitwx_diff causing overflow

 include/tcg/tcg.h | 2 +-
 tcg/tcg.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

