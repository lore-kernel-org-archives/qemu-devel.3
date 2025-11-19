Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A10FCF31AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXh-0002yP-SQ; Wed, 19 Nov 2025 06:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXc-0002u8-Iz
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:06 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXa-0001uX-6W
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:03 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso526220f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552401; x=1764157201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYZne6GwJ4NRY+gBlHbSmEnhm1zZNl5Dbbbd5zH8REo=;
 b=wBgj70FoInEE1prI1jF4CW42hZ48MG18WYlessVbDnj7gamc/Pf3jvAmH8vTu9PQ/g
 56UpwkdFqCC+vTZU74yLWQ7JnwnZaVB6gAqAEFQS+xoIKH/KZkljOOrxDBPxIFm7/Q8c
 Zo8JTeC/L1jbzkJcx0OLN+95oZLpylhx//W2IxzC6I7vgJDSEhEvBCPyuqc6mO86ej6T
 R6oquTemkCjfR0Ki8pErK0CixXFzCt7wTVKxpGaoJYreek3G5zJwOR/Ib1sM0QOwCx7e
 STbUfcoHt+hWR0NCU9/V1ATH82CF/7h75CXd6015wH87NuzhXoJ6DcVdvfY6dVN+Ct2I
 53Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552401; x=1764157201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uYZne6GwJ4NRY+gBlHbSmEnhm1zZNl5Dbbbd5zH8REo=;
 b=s2RWUi/4de0JmFrBisePdrOPiaGxOkNqxf8CafHdmGDUbfCq9uFuedD7ACFbnHfoka
 J0PgTXcuvt/irJ+3+EYGNrCC+Pqph90M6eyVXeS7R6Bq9sTwDWVMz9QvB+0DZipYQ0iQ
 ui5sv7ePkf1FqxYU8TII1KoDSO0XfUViSnnu2z9yzC6uzeXIswbDa82ibATg+U1q84FJ
 GluAW+Um3btNI2mIVQ/Kh1yiXU914QsV13dkmnfaB4fSfFPoBfNIGJpdUndHDukF1IiZ
 MpJE45mdwd4w5mp5Ztr3CithzXQtXar1Zg7j5X+mloph3aPnfjzh/cLHH0bCj3HG5wkR
 w1bA==
X-Gm-Message-State: AOJu0YxldxqZswmuB0d4gG0j/Bj+wTsQHwgEZ5j4YpkNqeLE2VGiCPOs
 b3EsaaFkcI5a9TMyvpha9UCWB3gwFMy0PCqhr/RyLrul2J+mPiF0F5PtgZT8x3NZf9A=
X-Gm-Gg: ASbGncsX7ktMX/Qwg7DHC+7ARlbGCKaJpHZg1mhnYsuuX2uxSFnnESMZqCrR0pPcnXr
 w1jvIzDzutOJkUz4sa1OPphutvx31aisHB0w22ROj7Gchh2el6HGMWmNnJ8FtCzHi5xYerS+C1+
 yAAP+XAo85mTtCqHbeC2gUSY+78Bynym57l3tsAGvOjHLuRw9TgirtsDlnLm/3x1ryh1D0gXskO
 bWynkmPFq/noGDy4lD2vVJHPYoNwrs07Jhlg4Rh0I/1nAlQ1sd+nbrUhbDpzhqBDUw8Jo9WAmQO
 BpyHpjFtekQmHCxTRbthtoPdYaWd0ZgYLum4vvU4/4JmXZzEJC3MaejCPLc4vDZfadHYN51NlXS
 Gn6yhYpWZZ3+F8ywZhP/Xdggsy27nPLNPjVc8mg3swFz+My4nJeIRsU7eii2Mz3ZcoCwklcwaXg
 cW6j2hz9oVcfV/KrnMRT1hiA==
X-Google-Smtp-Source: AGHT+IFKoV9ZrjgZBin+Gq2kkIO44t+RzV9DnJf9ML+EZoZDgkzHFH1nFL8vgFQYQMV5PRZX+LjcTQ==
X-Received: by 2002:adf:f18b:0:b0:429:cb8b:b58e with SMTP id
 ffacd0b85a97d-42cb2221642mr1816532f8f.28.1763552400683; 
 Wed, 19 Nov 2025 03:40:00 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f206aasm37830717f8f.40.2025.11.19.03.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F198C5F932;
 Wed, 19 Nov 2025 11:39:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manish Mishra <manish.mishra@nutanix.com>, Tejus GK <tejus.gk@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>, Jon Kohler <jon@nutanix.com>
Subject: [PATCH 7/9] contrib/gitdm: add mapping for Nutanix
Date: Wed, 19 Nov 2025 11:39:50 +0000
Message-ID: <20251119113953.1432303-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

We have a number of hackers from Nutanix, make sure they are grouped
together.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Manish Mishra <manish.mishra@nutanix.com>
Cc: Tejus GK <tejus.gk@nutanix.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: John Levon <john.levon@nutanix.com>
Cc: Jon Kohler <jon@nutanix.com>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 4e67c3e484d..c07dffc51bd 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -35,6 +35,7 @@ lwn.net         LWN
 microsoft.com   Microsoft
 mvista.com      MontaVista
 nokia.com       Nokia
+nutanix.com     Nutanix
 nuviainc.com    NUVIA
 nvidia.com      NVIDIA
 oracle.com      Oracle
-- 
2.47.3


