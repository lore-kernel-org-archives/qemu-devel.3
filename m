Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA606CF31AE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXl-0002yj-WC; Wed, 19 Nov 2025 06:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXa-0002rN-Af
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:02 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXY-0001tw-Je
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3ad51fecso4874370f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552399; x=1764157199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWFoMzvL5gC25K4imKNMLFdTsbgzYSdBH/lndv5XZNQ=;
 b=V8jwPppgewJQywdCZ9+E7b4eXN5jX6s46spTtogDBTdB+iGpuWzp50hgH97ZfPt6dt
 pS5BD1BPSShXIPRTd4MdeGf2G0798GqvSeJ9w6MEezAcTLNk2poUXl4hZmcd/0X1wWcx
 v6j3tjiKEX0WBkfS93dqXeCd4ylgfoot6vt4zOhrCL4jQiyyU0Rlr/osfSeA+Q+xRLcZ
 zyjx6kadCbWviD1FwPO3LoKwPxA4FwXmB0ZcJE3ghX/Dh0aVAe9mF3xygY1GAkNgkxO5
 4xoco6n+Tw/qYwxHsqfYdMnTaKDE1xoCp72rlDQCMAW/lMVF15ZUO6qX6PGUgts+dh7R
 ZeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552399; x=1764157199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SWFoMzvL5gC25K4imKNMLFdTsbgzYSdBH/lndv5XZNQ=;
 b=NcQi5o6acoeUgEDr3x6WYnvl5CyKjRIrtRYQFFC/IwqnzLZ0rojhkDtePC0ZOaUZs6
 FZRuGmQZ3P0cPhRYW8zA9HZbXRXcW7jpu17vuq6e8pBTYFGpQAp/SBUXHyHFR3dgziOK
 YrzOnrkvZUjEK4pZkQSr13TauOM414qhHVPJ5Gd9ivO85QQvSAHok6FmSj86N7XVtyQe
 +yTZDhL06XCZR0vPlkVTAr00FfQJZxnXCyhJFRRVKx3bfVynt6uZHPpZxVJlDPTWfciC
 wxEVgFT6QFhN+kD9lpm9cKX/XMgS9nGHSp1hdgvxSvBeye0GrVG0rSGyYlKdV9/+1ioT
 cXBA==
X-Gm-Message-State: AOJu0Yz36GKdGOs88MYkeYZnFNNYhQ0QgQiVtfIlFqu+9UYzn4afI3EK
 fhRIYm+dcZxsSDKh+GuSOCB5lnVWOvs5oNry0ocGE6ds89p+9kPH8MUrgR8UTAXP3E2wqplC3fy
 Cwm3C
X-Gm-Gg: ASbGnctIJQEmreY9OoYbLsAH59VAIPkVwTbyBhfpODcSeEDTNqalJWjfPoPUUzYayVt
 7heifpRFoj4h5fffs9VD9BWs3n3UiTUsZo/+oPU2yi8fW5nJIp2BDKy4e+thYGOqXlYLWUCvFsi
 rABMz9D24GPajDNt10zmXNIrOLfOAvAuhM81f5y5gCDbO9frOlZMxFhQac6CvlWVqghW/ZP9+Wo
 24eFbgKmnFWRYHkKIqSpkerVKegQQHParpxzioUhCHeJuRJrjKKKOqkzKd0Py3GkCpEItIV/aAu
 YUjO1jPrzjw5dyYyqNBOu3fH2p5ynq+Y+mHDE56uz8gCyVHf+TSSKr6kvlubwFsNiVtmL/5QA/c
 2857iEsyXO4Ut/S5gZ2zUIYAbGul8EEjv6khdUH46VeCujtqxGANEG7ReAFMtCvPEljrswsRFMX
 MBO+feeSlIwj9fmtsNtMUW2z4WqVvGlCTo
X-Google-Smtp-Source: AGHT+IGjxt5QBB9oGl7JNay9ATHRTGLBN17q7vGBghld6GjjXiYhVCZ5dITJNtVqJlE34DxF0J168g==
X-Received: by 2002:a5d:5f47:0:b0:3e8:b4cb:c3dc with SMTP id
 ffacd0b85a97d-42b5933dee3mr21035143f8f.3.1763552398894; 
 Wed, 19 Nov 2025 03:39:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b622sm36862330f8f.29.2025.11.19.03.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1619D5F93E;
 Wed, 19 Nov 2025 11:39:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH 8/9] contrib/gitdm: add mapping for Qualcomm
Date: Wed, 19 Nov 2025 11:39:51 +0000
Message-ID: <20251119113953.1432303-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

This might be sub-optimal as we also have a mapping for quicinc.com
where a bunch of open source patches came from before. Maybe we should
just have a domain map to collect this together?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index c07dffc51bd..bffd2e9a3da 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -40,6 +40,7 @@ nuviainc.com    NUVIA
 nvidia.com      NVIDIA
 oracle.com      Oracle
 proxmox.com     Proxmox
+qualcomm.com    Qualcomm
 quicinc.com     Qualcomm Innovation Center
 redhat.com      Red Hat
 rev.ng          rev.ng Labs
-- 
2.47.3


