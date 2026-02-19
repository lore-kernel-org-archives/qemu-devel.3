Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAD0E9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9eW-0003O8-OI; Thu, 19 Feb 2026 14:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eT-00037y-Vc
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eR-0000j3-98
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so1046346f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529125; x=1772133925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRrWfM810SbEXW6VfJTS6QM5Ed2OgRIX4ibNdi9Gsj0=;
 b=jHCzd9BehW2EFUhqtcIty/n7zrEI/fhDCxtel4B/Q5FIQAX0sP2HbG6NZEwkEW+cDA
 z7DsmIhIzTBk3VLddRVAcYd+ucPv2G+06gObnQWmEio3fpRLe0q0OnBOmS4II1jAVLcy
 XWPMQ8YX0zyChpEg3KPycfa1OYXPZS2r83N1rMDjvd85MdMrlEaAw9K7X5nOgv6Ke+wn
 CSzx/TzAT4YMHgxScNxiSSEjdM7Ac3yX7bxPGcSIwVyo9cI5gh6+iFoAKFzUvDx/YDDL
 Hq69vH8d+Ye0n/VPuH0AUkFXbC2sfE3gKXdT1C4ZsRttEwZn3CimV6cZ86nyfHLc2Fba
 ThYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529125; x=1772133925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cRrWfM810SbEXW6VfJTS6QM5Ed2OgRIX4ibNdi9Gsj0=;
 b=PqrKCRBlFaomrn8N/V/f0IFw8JhIAPyYKCVbScYpvdN0qftyISlnoomiyRdUgTWPvS
 2OxdWHrIwoyVN8+9uDgWge2rrrirMXs+daG4XZS0BYCfOBfd98/IRpDByG2CEo2jjqLP
 bTN/rFjwW8jpHkccKViDPvF7MpxdaR/JixwsoEqmYIYa34pf0diFXoyj5Iof4Httnaug
 H71RtcxOn4qXGo2mNw75c+7crQRjWaiJg/yOMWYkI5aA1ngukBGiWH4f4jXNsupUBONB
 3VDwmb7ep/6JP0PL4qiUMC5L7B9NM00sp2k/c3o7MP4A0k/rTtygsksKvHMNnLmAfPjE
 5DuA==
X-Gm-Message-State: AOJu0YxuouYys2VqZs+cRlxZtt2OY/6PnjguOV6wH7NxzzLCVzX7TEZZ
 jzDaPgkx7Yu3sc79Si+7zjxs7MZAkI4m+ykSTST2SphFYkPB2lYJAMLD5aIgpOplWmJpjhzxamP
 OHMRNXYuG9A==
X-Gm-Gg: AZuq6aKXdHdYKyRVUMryi9me9TmJiXepupMnJPbTomFtAdFph38F/QMqio45bgPyoST
 mQX6ODjLE22d+4SAv3GbmDEZYGKFqv2hcouMDJ7KoowqVDvsLNXJqDdGj7xkbiCtJHH21HXVFCf
 lZm6xitqd6NQdyk+7IIFIQ8oa/eQgvUF2oIQHl6s6cZNxFrvXgOLXRg4jYtQ8l4rTX/aCr/lGtB
 pRSDWyUp/ozvog3YR5cqfvl3iJRPy6gm3gXVtK5OEx94t6ep/6EPK0GECvZIvKtqtuCnsRuXeOI
 womTN1RWYTWjYnk2tjOr8ARXY+N2G3F7LHulNrSfCdR9B2myhimR5h50uNTlnY3Ys5u2OTcTvIB
 l8MDqrfy61BV1yRD/0Gv/Fy882BKAzBVlbWOrV6tH0ZdKqml6SBvMnc6s+P1DQsWv0XAxltB2Fw
 eRLgy24slgvKHqJklnv9wiscj2dedAGj11gznNT3fog/Of3GUQ0htOJn0L14Sp/zAIPPV60BBq
X-Received: by 2002:a05:6000:2306:b0:437:7010:1cfd with SMTP id
 ffacd0b85a97d-439625c6742mr5636833f8f.4.1771529125399; 
 Thu, 19 Feb 2026 11:25:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439567aad3csm17182452f8f.36.2026.02.19.11.25.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:25:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 46/50] target/m68k: Build 'gdbstub.c' once for system
 single binary
Date: Thu, 19 Feb 2026 20:19:48 +0100
Message-ID: <20260219191955.83815-47-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

There is a single qemu-system-m68k binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/m68k/meson.build b/target/m68k/meson.build
index 4d213daaf67..c36d817134b 100644
--- a/target/m68k/meson.build
+++ b/target/m68k/meson.build
@@ -2,13 +2,18 @@ m68k_ss = ss.source_set()
 m68k_ss.add(files(
   'cpu.c',
   'fpu_helper.c',
-  'gdbstub.c',
   'helper.c',
   'op_helper.c',
   'softfloat.c',
   'translate.c',
 ))
 
+m68k_user_ss = ss.source_set()
+m68k_user_ss.add(files('gdbstub.c'))
+
+m68k_common_system_ss = ss.source_set()
+m68k_common_system_ss.add(files('gdbstub.c'))
+
 m68k_system_ss = ss.source_set()
 m68k_system_ss.add(files(
   'monitor.c'
@@ -19,4 +24,6 @@ m68k_system_ss.add(when: ['CONFIG_SEMIHOSTING'],
 )
 
 target_arch += {'m68k': m68k_ss}
+target_user_arch += {'m68k': m68k_user_ss}
 target_system_arch += {'m68k': m68k_system_ss}
+target_common_system_arch += {'m68k': m68k_common_system_ss}
-- 
2.52.0


