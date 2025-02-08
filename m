Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EFCC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 20:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgrtS-0001uU-2s; Sat, 08 Feb 2025 15:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtM-0001sb-MU
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtL-00057k-4L
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f53ad05a0so28320885ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 12:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739048250; x=1739653050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2FzoHSuAoX+1zQ7RA2/urh/hio8OfZSmlzrSvDG4W4=;
 b=EM9g0quJb+N3RL+8CFgcIMquKAfT365FU2Z6hfcklfUS1t/sT7No6cM0xtq00NbmI2
 wUKxJMEuULZfGWiG4nMjFEB6x0hhZrXQ96tyV2JQGcKO0lQ0W9sEW2SSTnivUf1MIa7o
 CCF/GMcLpWkClRkvNe7XTKNJFiu+H+LW2c3blDS5DpZLM44T1dwYCRHK9+2jXrUbYnee
 jW9olGWkHkoWHNq0FImWlQfMGQJkYu6J73MwGkO4sbxfZ8S/WPAbH5mCyfnrR/t4ffY5
 pluGP9rCJLaXCpdOQnTyrI78rKDJZf/Ku5Q83XAdM0dGtg7RLMZtYEfaapNR9p4wgiEw
 0/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739048250; x=1739653050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2FzoHSuAoX+1zQ7RA2/urh/hio8OfZSmlzrSvDG4W4=;
 b=XFZp3ZlOuFXF2Q85qZS6zlg6KBkzYD03oZ95ryskA0PMK7VNx2vP/gfv5eI9pGZaiF
 pWPBf21REabPVtUY911ETPSNB9xp2DPYMGBOHqUrMEz928Jq7N7qGZ9OhryiNiy110GN
 sJ21Ec9ZhF1Z+xOrl1u4IoSND8EOsD73iqHm5KIBijSxO0JHXT78a2MXlQRJL2lo9yhX
 I3DVrZgunRKa7iItZCm0ipaMtC6ntFfISTQiF4MZpd2Vef3gUpiI7j8CJ+kZSl+6avOC
 WQYu1SEsqjnHupBYM03WOQt8Q+n/MW2PUEPyvtgg3IGkxovyJ1I6zYuEzP2uTX/aGhte
 y8xA==
X-Gm-Message-State: AOJu0YxcKEsbzZlIPAAnmFd8P2Zn2OHadoe0qe57Bze4vT6BjxFQuUtq
 wp6GhVc9fliHgL3NHtBqhW+GT1PvtqzhLh3vhNxRXlc91TdtOdkdX7Hk/rxETcufkMM94/U4/SB
 6
X-Gm-Gg: ASbGnctX6moPK0i/sqQbY9SQgrfxBLH5C02lIGQ354KczxL3BwTPoOE2xXy+VzCUWuS
 e+eUQFeEDbWES/ucumy0uc/h9UfxJCbiKwoNS8vSeMhtGpowTFP1MQeXjqHdu9W+Au87SJ4ChRF
 a5e9PPYr8X/1oTPO5fD6C0T4wz8cOB1vXcedwsEciGbzShBlKBUhDsrC1H5gpye9c6bNQvn7WTb
 Pz9pY+0rBTMoC3hF4ZyOn9K0HRDrrxkUCpqffy1OKCEWSwy3xhQ9jYlF1E09vQRxiksuS+1KxeD
 6RiBcEBDP9srY9V2dZhwOrDu22s8veGyTO3/sELcn0+4RI4=
X-Google-Smtp-Source: AGHT+IGzc0jiyUgdQJtK1eufS6pLuTxjzL3AiQUBpJNMenVWLgTbVutyoXfzW7H2XuAd5DGiNlCs+A==
X-Received: by 2002:a17:902:d592:b0:217:9172:2ce1 with SMTP id
 d9443c01a7336-21f4e6d7d8bmr158877355ad.22.1739048249867; 
 Sat, 08 Feb 2025 12:57:29 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d58fsm50852685ad.122.2025.02.08.12.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:57:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 5/9] gitlab-ci: Replace aarch64 with arm in cross-i686-tci build
Date: Sat,  8 Feb 2025 12:57:20 -0800
Message-ID: <20250208205725.568631-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208205725.568631-1-richard.henderson@linaro.org>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Configuration of 64-bit host on 32-bit guest will shortly
be denied.  Use a 32-bit guest instead.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 95dfc39224..7ae0f966f1 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -61,7 +61,7 @@ cross-i686-tci:
   variables:
     IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
+    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
     # Force tests to run with reduced parallelism, to see whether this
     # reduces the flakiness of this CI job. The CI
     # environment by default shows us 8 CPUs and so we
-- 
2.43.0


