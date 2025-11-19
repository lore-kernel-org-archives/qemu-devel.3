Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C66DCF31AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXj-0002yR-OO; Wed, 19 Nov 2025 06:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXZ-0002rF-F4
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:02 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXX-0001tk-SN
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:01 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso46224025e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552398; x=1764157198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+vnH+d1VURqyHPLSS3g4apsz4dArzYOcHNU5kFAgds=;
 b=TYWDKi/vkmHSO3clw8rM9L6ohqbCedD2VHXUPf0QdHBxc4bH5uG0xAxxjP55oHc5sl
 s88fjBYH1R83wZ6flCCKSagqAzZobg3CParW5Yq5zEs41EpRcGNy0Y8JIPp040KYAd2i
 5WSJ4bmOSErs9VZHfRFX+MaVB+rq8OLEk2nq8vlJmy5lqE3mNhPjbaVBRqa6kW4mnUhB
 AYkEvlxIpy8jc0XtAkwdWirt7U07Y+V10TcphssYAn6AfjpTvJcSrWrTbdxXlueOZxWf
 bEn/ZBvgjWs0Vo+y+ZsCYj/n1Q36MpgmbKqgpS5iDYDs09r9OcgHpm4ergbFlCOWeq5w
 OY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552398; x=1764157198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I+vnH+d1VURqyHPLSS3g4apsz4dArzYOcHNU5kFAgds=;
 b=v4RlSwvC3SiZTGH2JZsQBqPqhVsL+0IHztzYomoEcyOAwBnANrvheRx4k8gp/EjgNz
 0W6VdpXvzX4jto+Guz7gmTFYyR93/psJ78Q/qeTNt3EGXNw1r/mOsDXsTqJsiD3dRCQR
 I4HZz7seCD7JgEOeTJOGD0Voiyh0oV4nHF3qxp63ovwIoNOW7VDo9yAp4DSrdUbU4psA
 ywb89wDk4/QdUGsxhiwdIGMgRgWUr+sQ3d1Q6YJV+k0sgF2S0UizDjFx5dbmIS/pEk/T
 RAs7HHcCqcTe6zt9k5Izp1UAZDTtLnShGBbnlTaVhAVVNktB60zv3C1ganku07X88EHf
 ZSOQ==
X-Gm-Message-State: AOJu0Yw1VHn6YwPw+S2Y5Mp8Hoq1myFVkICVeDQSYBWt/lOnDRt5tcze
 QjaAc3hCXd655RqNyu8JBMCch3cqGbvr0/Hu9TeMYpvlmMfH4qOkhi/Ik0HqI+GqdN8sTDHoT7l
 2OZT2
X-Gm-Gg: ASbGncuGGKfQMJHA5P3vm3rw0MDQuVNy3ZIPMg4EkVzdPhNjLmgUiC7hjP/DFQm2vXV
 E9JLeL7MF8jSlTcnaAwSukIBHpa2q51Acr7vfkr5IVsIPPzUg1GbYHGQt63hzxpUTlXO8UuHjoH
 3ErQeenq2GTbmpBicI69t6oR3DqADa6TmVH7CtrQxkLRUC/e19rspPPMSNAwBpjvf7ygt/44Pew
 71z3OqrAB+KgRE4QA8gX8+7xVAPprV+c4BWiAzZOsjLixZ4hlp5+Xnn2nLRTtKjgxWigG9g8SB8
 qLPeT3dXVYwYyCvfS9gXGREVophMT6DCnxPzetYaImAblgo+6p8gKMiykvyNCHukgKILAgsxqPY
 BD6qo049b2a2Cbg70y/gNdEpOSguA1pjCMcmaZrcETvdXbLg9PvwpUqvc8XMQEBNvXwKi1l/CiR
 bAdWblqsM/zfY=
X-Google-Smtp-Source: AGHT+IEM4NXEDJVmWuXsm8Bp5ZY5Q0ik9QPlYyKdfYUyVsLfcvV7zeUOdcCe2swE0OTy3wnWU4RkFA==
X-Received: by 2002:a05:6000:2f83:b0:42b:3746:3b86 with SMTP id
 ffacd0b85a97d-42cb1fc8407mr2330498f8f.54.1763552398321; 
 Wed, 19 Nov 2025 03:39:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae16sm37935469f8f.3.2025.11.19.03.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AD4AD5F8FC;
 Wed, 19 Nov 2025 11:39:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/9] contrib/gitdm: add Nicholas to the IBM group map
Date: Wed, 19 Nov 2025 11:39:47 +0000
Message-ID: <20251119113953.1432303-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Let me know if this should be under "individual contributor".

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
---
 contrib/gitdm/group-map-ibm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index 24d8dc1b865..2d76bbe163a 100644
--- a/contrib/gitdm/group-map-ibm
+++ b/contrib/gitdm/group-map-ibm
@@ -13,3 +13,4 @@ joel@jms.id.au
 sjitindarsingh@gmail.com
 tommusta@gmail.com
 idan.horowitz@gmail.com
+npiggin@gmail.com
-- 
2.47.3


