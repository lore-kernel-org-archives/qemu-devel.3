Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC392C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcM-0003au-EZ; Fri, 25 Jul 2025 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbu-0002nY-RI
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:34 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbs-0002Qz-Vt
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:26 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae9c2754a00so392184266b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458322; x=1754063122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnSza4lTBhV6Q/kwVg/CCfLpPpYvuTirTlEa76oijPQ=;
 b=SfVYize7HKcIfsxmhquLd4rkiRSiaEQ4gG3o0DG1PnouZY0tRedsFooJB7OdeJ7WzF
 5vq3M2eqGCZiqRE46ZLVCQ9PuNmEk+S+eZHMS32FlOrRTCVWJxWaKE6M9wNQvXOQdCfe
 J8ho9wktrIa2cfuAy+clyp/rsQqMu03WIOi+TLxT4msNrQQmZVCZenkIftpN1zM6s7f2
 Mk07Cr6WTgn8Vrp7v2TbNHDe9+nz/os7ThVsA3ttoPSlm9DuRTWad7jCEZSkcZ7ce02x
 4E8mHSDVtOIUvW/dmAiC47dapLSncJbk5U7dH4WxrLNDmBS2rcpGerc/qZL1bcssy6IP
 oJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458322; x=1754063122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnSza4lTBhV6Q/kwVg/CCfLpPpYvuTirTlEa76oijPQ=;
 b=ugWfNlCNm7RR9uit67oCnAAwM6EhlbfmZw1OFsjRxRH6MEL7aHNPcRFmzXIg0ZLAQg
 0afMMKbZH0AR12se5Cd5KalBXrvQXduBe37EMv5mD23+HBuVutPVjgO5v6HxuoXr/cbP
 +6yF5Yq8qWWsbQmpVI9f+wKS/ZOmRLr4lOTE6zeJoOF/gSFDWzEP5MljtEHvN5ApLgof
 eNNPC3BCgUe4I7ANoQ+pwFwe22WkDRPyI49VlFXKqNtahoPA5sJRjLadqjoSIKLDM9iE
 A8HkgqlUYd0UO0qhsszwxoiLO0wmrhCMdT/58PDeEvCWfcWlw73WzdHJ1/TKv//oAsgs
 Ku3g==
X-Gm-Message-State: AOJu0Yx0hfAk2VdCUA2IsAJ5SfXJkP6w+CZoJCeukv/OyqLQVD2PNmRe
 7vQGZ28Hhqvbklcye27ejpfMX5aH833qJA+ZbUVLdz7dNiytgOQghyU+ndmxnn1iCdM=
X-Gm-Gg: ASbGncsszjCWQCqw5gRCrOF3rqKeb8MXvEYHsD9378oIxbWLq+NAiknD8efM1UatBRO
 +VbjH3PTnvYhGIeHRJr01uh5/8xQK1icebi0s4/68TSMm4ujoWTXALXV1opvAgSHhuW9BeGKFVQ
 RjNvuacwWTl0E1tTGHYpl+UHt573+eIR1hOgweTEQiOZmPVcAmqaQqJ90nZ6MXJvMU6aQueuFEJ
 sp/Yz3PmIuhF9+BmOChIDcbOZZ3GpC+VIlCa1mZqnmhk8KxZ5gjKWjQaTELyPRKVhm0MQCmoQYV
 +DOFwnLQhCJwqqtro9nutD9eLBXiVfb0W7oQhPl3+Ps+1KtVpzQoPI4pxkmYSpxsIBfPtAuXjti
 hwQgIsFyOs87jdezFqM9rS4c=
X-Google-Smtp-Source: AGHT+IEwL92+C60pzCCLSdE9B99WZrLxD7f3VT8aXHl85p64E1Yv5nqhdukC4adqO1nesInb+/7NQQ==
X-Received: by 2002:a17:907:60cd:b0:af2:4257:fa1e with SMTP id
 a640c23a62f3a-af617d00e58mr336283966b.25.1753458322456; 
 Fri, 25 Jul 2025 08:45:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635aa68e7sm8411166b.110.2025.07.25.08.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 331CB5F8B5;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 04/14] docs/user: slightly reword section on
 system calls
Date: Fri, 25 Jul 2025 16:45:07 +0100
Message-ID: <20250725154517.3523095-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Expand the description slightly and quote ioctl(). I did ponder
mentioning something about why DRM ioctls are often missing but I see
we have the I915 ones so I guess its just no one has done them.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/user/main.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/user/main.rst b/docs/user/main.rst
index b8ff203c212..05de904225c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -20,10 +20,14 @@ QEMU user space emulation has the following notable features:
 System call translation
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-QEMU includes a generic system call translator. This means that the
-parameters of the system calls can be converted to fix endianness
-and 32/64-bit mismatches between hosts and targets. IOCTLs can be
-converted too.
+System calls are the principle interface between user-space and the
+kernel. Generally the same system calls exist on all versions of the
+kernel so QEMU includes a generic system call translator. The
+translator takes care of adjusting endianess, 32/64 bit parameter size
+and then calling the equivalent host system call.
+
+QEMU can also adjust device specific ``ioctl()`` calls in a similar
+fashion.
 
 POSIX signal handling
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.47.2


