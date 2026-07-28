Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED77C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojtb-0003io-68; Tue, 28 Jul 2026 11:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtY-0003g5-VT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtX-0002mV-As
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so13527f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253142; x=1785857942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhfeGe/4CB094Qsb3YMVun3IRBzdJrjy7hL+hy4mT8o=;
 b=to7vuMGBX0XZJl2XuOS3A3K9mTXum4WeNtwIp2bqrqgI9AjdrrF/OvxFUVxLyq7AAJ
 ZuDi/MTgs0Or/hzSyaAnjiDPR/Bt7mUa6JL5Ezi0Crw57xD5bgsVlFOZLv3gnmOvXq9p
 qnBAmwjNG8Ud2dJUqqQpk4YMyEryDHep1vMtfDdzkGxql8BkclQ+9zbAnXGhnQy19cEF
 TDJKbBs7ugyy2tiGA37hMt5X8CEpkbL/i2QPgCwuPcirKwuWjub7CmqgGTgLPWll7QRz
 LIH7nPZ9QxMWfeYnW7R1nbIudpQIbX6WhjHN12feEAKTksISh3des3xFNlqTWgIOfnuu
 w1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253142; x=1785857942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhfeGe/4CB094Qsb3YMVun3IRBzdJrjy7hL+hy4mT8o=;
 b=hfphq53OHd4zQFPr65O33h4sufmwrgeHNohKSVK60n11FBHSd558R0ejUthvHEWPOo
 GWgIEzd3G5EpsEb+xWhvXw7YQjvMYCnY0nsYpHRTJ0l5Fs4Lvw/4bb96AWOtns4uSZtx
 G+aKN/t1ZpzIDDUiRVX/ju5sWBvfEXhRhQd2Agy3/mB9R+0wkpozICqhr9Fhy13RBprf
 ChVxXhDPXZbFwrLC01FwIsWSwa+9m6EMom5UmGqUYvHfrArHqaoIzF/AFy7Jv3Q2+pUy
 xmuUmzPhQzXtKfOlvHc6x46dteI/TQAVqGfWCd79AXfNvr4lqQFRti6jvnDd79/95bHU
 7ebw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtW5TIXue0dJZMZfBlhNJEw2HndXEuUW952P3EBRNU52w81UQwEo6OfvZntLCmlgSc0oEPaEykC8b1@nongnu.org
X-Gm-Message-State: AOJu0YyMZOrUQ+rJo4MxMtJdxBP3GA2G4yO+mCkcB1qsmrglUMict5CI
 BEta+DdgMPyg9v3P/N2Kp063hbMQ7W2n114q0Ka06jJQCWlVbt1sWTAvLuAcSHAe4SQ=
X-Gm-Gg: AR+sD12JcmAMqzLYr5f2SPwWyCb7Zw4WeJF6eFPnvWjZvywukMqWjBBDnFaJG5NQ/5k
 4qTFt0cYw/cKYjHulCBvdNC8M8bP9Yk7FE+yxSwYdogr6d68414+1CzYY+IeMC97+I4HJ0PE+WG
 uuJ3BeyTR4LCThXTqMva+FXfpm5fByFx0RfBp3cerFoC0gg0kcc4efmcynaYBeEArYMjhA0MnT0
 WNAuKLzfn6CGlsWLb7aMv3WtwWkrTWNxmDp2PpNyGkKYVV9WbQ8U4Gh7sdxKywsDWOj7JH3eVux
 PH9mexw5yCZYLIljCuE78vJR5OiC7TbTbCpcX4Viu16VRmZXTmW7nl+rjTaSp2POBuhIKpClKRW
 k+aPYVf8bEloDB329ajL8qTcsVklezNd5eYA7h5bK52TwDqajnbL0vua2YB0Z4W7G7BSShwuEuQ
 ==
X-Received: by 2002:a05:6000:41fe:b0:475:f100:35f4 with SMTP id
 ffacd0b85a97d-47fb1ee73ecmr3347316f8f.49.1785253141830; 
 Tue, 28 Jul 2026 08:39:01 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:39:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 9/9] MAINTAINERS: update parallels tree location
Date: Tue, 28 Jul 2026 17:38:49 +0200
Message-ID: <20260728153849.601939-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=den@openvz.org; helo=mail-wr1-x433.google.com
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

src.openvz.org is become unmaintained, point to the GitLab tree
instead.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a28935c898..902db77218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4393,7 +4393,7 @@ F: block/parallels.c
 F: block/parallels-ext.c
 F: docs/interop/parallels.rst
 F: docs/interop/prl-xml.rst
-T: git https://src.openvz.org/scm/~den/qemu.git parallels
+T: git https://gitlab.com/dlunev/qemu.git parallels
 
 qed
 M: Stefan Hajnoczi <stefanha@redhat.com>
-- 
2.53.0


