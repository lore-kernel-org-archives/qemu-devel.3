Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F53C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAss-0005ZL-9v; Thu, 07 Mar 2024 05:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAso-0005VJ-Ln
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:52 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsl-0007Eo-B9
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:50 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-299b818d63aso557752a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806906; x=1710411706;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5x59V7N2Snccc4Fu7ozWsaURAyB+hFzG8uxYs6vkbiI=;
 b=VdMW3ByiUeegC21ya5aXAGk1Sv2cimBUk2l8IX9RsBi/k7wlielcNMFHAX+ElZ5P3e
 Jb69qdy3zXKLU65BeIpXwQLgnoF4ogIRpt5YfYEOTaa+aP0w7jCBwKnSqOY/KJvxl/Y8
 4zyXfn2DiZqdkS8Rtsaa7soKvercO8+ZZBic5AO53vMMZel4uo+R+HxSoI/dQwvjVvY/
 r/T91dgnoVYRFArj5CnuEnThDaEc4qzkj0EzY6Qj1FHG7CWx8JOB88FBBGLT0FXForB5
 i7HivU71P3tEaGG4c+lJfhE7/UZRJ9vmYmLpAuw+ezqnIkCFOWOYNLVfxnGMgQVxbhVT
 uxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806906; x=1710411706;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5x59V7N2Snccc4Fu7ozWsaURAyB+hFzG8uxYs6vkbiI=;
 b=RPMNNQVidkvzBJg5Sj2DFpP5UKt+VLx8WZXs7bOqedSFDbs6q9MFBOU5V2GYPBuyqX
 j7R+/tR67SNrKatIxy53iLgxPbUsrC6ivO7VIwV+up0j0s2Hr6sI45ew9rSfFc+CtGn2
 YcsZ5w8qgznzYKn/Da1WX+QCS80qqa0jJH4hjezVCauqInG1E2cjalfuTALGaGEjF6RA
 GYlGDlu83kQ+ZvDC24JMyZ7AuGKsAvMsYCXM1miPsGcBZkCVnh2n8zr7xbpX1y9NuEM6
 TmCYtq+7vFG2OY+eqFSOuXSDn2pX7B8Bg9soEWcOe2y0eZ43P6s0SWaTC7+xDsyonPPU
 Xd0Q==
X-Gm-Message-State: AOJu0YwfTLznps3LXkL4v03t8QQr1lO+RhbNzJ+9bcxCzFkwuPilLnhe
 oz5NMHp9cWX9pJtCka+As94bMrnqtdxdQU5gcF79JRJTZ/5iUlp67QODubuDHqE=
X-Google-Smtp-Source: AGHT+IGM+22Aww+KQMPaqiVvSGwfBGsH2hsx8DDihAHHo9PMU1xwhHj+AFMIeS2g0gNjCq48HNpYRA==
X-Received: by 2002:a17:90b:128b:b0:29b:931:37f1 with SMTP id
 fw11-20020a17090b128b00b0029b093137f1mr1612067pjb.19.1709806905891; 
 Thu, 07 Mar 2024 02:21:45 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 oc11-20020a17090b1c0b00b0029aea375586sm2123245pjb.1.2024.03.07.02.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:59 +0900
Subject: [PATCH v4 16/19] contrib/elf2dmp: Build only for little endian
 host
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-16-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

elf2dmp assumes little endian host in many places. Build it only for
little endian hosts until they are fixed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/meson.build b/contrib/elf2dmp/meson.build
index 6707d43c4fa5..046569861f7a 100644
--- a/contrib/elf2dmp/meson.build
+++ b/contrib/elf2dmp/meson.build
@@ -1,4 +1,4 @@
-if curl.found()
+if curl.found() and host_machine.endian() == 'little'
   executable('elf2dmp', files('main.c', 'addrspace.c', 'download.c', 'pdb.c', 'qemu_elf.c'), genh,
              dependencies: [glib, curl],
              install: true)

-- 
2.44.0


