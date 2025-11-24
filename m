Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08FBCFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTJQ-0008Nt-Fy; Mon, 24 Nov 2025 04:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGU-0004nG-23
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGR-0001p8-JQ
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:45 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b38693c4dso1803634f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978019; x=1764582819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHuNPaQRBQVs0pEJUsFGuLTgH0d+VE0aZRSkud9qPBw=;
 b=D+oCWQWXxxBy8CIUhDRk1pYZlY/SXCbg9QfTgxwG9PIf1B1gxkd8Nhx6xvL3f8oh29
 qk2CV23c0Z9rVuunVUxgPQkBxxLIC1DUVewiTohQ6xtpo4UkSL+ez829L4HZCxoEx6H/
 trBQyoGFaJ2Mfp46kHXfCVsfkYZAXlcllhLMqpxU3LXfizJ8Bsg7mfZNXB8bTid1662+
 OVXB4z6CLIbB4+BaBAQ151BGzgmYtVm6nN6JFbCajrwHUQuPEB1Ud6tVYB0hp20Ur0qv
 HJSKiJDPsL5YlBDLnTWc6AFudusP2mpJxDKZp+EnKS5t3s6yzeqq8j/gSgTm6/SdvBtM
 LeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978019; x=1764582819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eHuNPaQRBQVs0pEJUsFGuLTgH0d+VE0aZRSkud9qPBw=;
 b=W7oHW957AEWaaxTsATpU0BfjKlUTqJJCt0zmNzwTtwk8v32vL7enqlFXrX7wtZ9GwK
 70PTJz8nlYIiAPm6q+c+Py3k2ayJq4CvcjHfA//NtckGoGOzraeiaU0A4oG7LE8bmkI8
 7WjCsiCeX6Urq1MU3ZtCET3g7ebQgyVQpXsFcsTpbg293U9tAMG/ESLRUjMr3GrxYhRe
 HURAjQkY+zH0eFHD6xNVFH8xWJsp+agrjyociPNy4yH4Sg+wiaJYt0Xc0cc/SExyX2R1
 cdjRrgoHH0c8RPseIGTqAHPBmXqKgT48IhiWVdvPcSbc5h6QFgloOwLJkOL+sbdUPEwK
 zfZQ==
X-Gm-Message-State: AOJu0YzNpNnUpfv/e32s9nxLiBkD9+8gGyJrLurC5McYTkhfor89/fjL
 gbXBLkq5cu0iXGvf/oL9bpF3Xbg2z2O7z6bqBLnAx/nSIpjXhuCW5glnCG53FQCJNBtQaCYeRjT
 DwvWd
X-Gm-Gg: ASbGncsvxFKJ4nVySkEDNKwcr7mBzduYKFxEn+aFxry3AaDNNhxEt+h8/JfYpAHCHO1
 35Sbu2Ey31/zzm1UmykAzUzTJC+nrK+tnQyR2GBkp7ICY/N7TBmLupzxj7HugmylGI79CDShJox
 rL6bVk5uqlgvjfewGVqaVcxt+pba9qQPnTovNueWqKE+gpgmqlJiXgny/KEmqmpYgIRemtxHead
 L0tuWc8yMb9SHO3boRIBDxUsFgrtRwLqdIA7gTSeixCq6TwzLtwXZTofVPuQnz1Q7+swSqelLs5
 QRGar/juT8EIlwKknMAQJCGIHSdQon2y3b/oiSCF9Enn0pcRSdGZaxd6pOBiUB9iI3beI2R1BL4
 xk7JVwDRMIeal033EOcKpg94djlsFotEhmuEcJD7HKmlkTFlCVvOmyfO3q9TzHD+nsdh3h/Wyim
 Zr+9GnlK0mKwY=
X-Google-Smtp-Source: AGHT+IGmoLxV4rX+fY/lOxzdwy9s37gRBIIOlVzr62XptcWth6U9xB0hwPnbwEN44iXgv5tUqJlmGg==
X-Received: by 2002:a05:6000:4383:b0:429:b751:7916 with SMTP id
 ffacd0b85a97d-42cc1d18d22mr11328201f8f.45.1763978019410; 
 Mon, 24 Nov 2025 01:53:39 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cc231dc6esm19160041f8f.7.2025.11.24.01.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 01:53:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCBBD60217;
 Mon, 24 Nov 2025 09:53:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 3/6] contrib/gitdm: add University of Tokyo to academic group
Date: Mon, 24 Nov 2025 09:53:34 +0000
Message-ID: <20251124095337.537277-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124095337.537277-1-alex.bennee@linaro.org>
References: <20251124095337.537277-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

From Akihiko:

  I and my colleagues use QEMU for academic microarchitecture
  researches so it is indeed to appropriate to have an entry here.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251119113953.1432303-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
index 082458e1bde..40865b01cd7 100644
--- a/contrib/gitdm/group-map-academics
+++ b/contrib/gitdm/group-map-academics
@@ -25,3 +25,6 @@ iscas.ac.cn
 
 # Université Grenoble Alpes
 univ-grenoble-alpes.fr
+
+# University of Tokyo
+u-tokyo.ac.jp
-- 
2.47.3


