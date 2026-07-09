Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6B7C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgk-0007js-Rx; Thu, 09 Jul 2026 04:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgi-0007io-1n
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgg-00089L-0N
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso5228435e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584045; x=1784188845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=utbr16OPhWil3cJSdh4EP0+c6AU4qwdtLRXf+B+3uqQ=;
 b=dydUTH7UobFwTAewnZcHoa4oDW+Gb/M7vsxQ6FWySYtKPaeWE1DttUs8Ev/yP+P14A
 ikn+7NAyL14k3hFcf512Ok0y5TKetAdZYHSD4QnWUb60SONCLmrTpCpo5aGbIdW0y/+c
 1oNzjTD1ZC2EWtfsghD9pYN3ECqy34hsp352ob9DA6KzeRrfsFWwEiAfmxatLw/tkxMq
 /449N9D+JO6uN3gig3zy+uoO50R29rDcTxBpEEGeov0syR08B5iVhAl2107lOWLF1SuL
 al52k1rWOZL34a9xPUMyr5lI+Wd/UoR5UJZqRBIRyqEKXyCvUvRn+znxVp1rH3B/Wk+z
 T1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584045; x=1784188845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=utbr16OPhWil3cJSdh4EP0+c6AU4qwdtLRXf+B+3uqQ=;
 b=PPJoQ5JZZy/jwTZBEI5U6l237VQnjMD2SszPqKG+TDR0xE6dhPltyGxkf3TAwnPt/Q
 vjrXAioBBnLUu96SyDprKyxIk+T9ZApk6mmDxCHa7DcCudtttHEtGF22wzs1yZkLX1dR
 oUMyyFo1327CadkWxUfwyYM5w7rO+/5cYol6YM9dRgSla7rkiDpkEOK2ID7/U0eLRHHT
 HqLPwzIZw3/xlpYpmKh8sIR3+MnX4JAyEVPjm6Gsvwi8bRZPA8f7KzdhMaUh8F4XevLd
 6dlWqoeAzuAdtq5yljR6AJiL7Ei7N2mBTPH1KAMAvQTrJMKiZabMW/Pb/+2GJ4cFKVt1
 Za/A==
X-Gm-Message-State: AOJu0YwdNhhFTC2sXy+5FTQXaan9OxJkVTyQZeW/pGtm1HAdwp2croz9
 38/8zp/0um7Pa77RqkCynkhhw0bCzjWENyspyRkHIVIChxEVVZba63Gm+eBKZQifVax8koqBoSb
 LJJmU6dc=
X-Gm-Gg: AfdE7cndjviMO5bZLkWU3DKxbiCbj4AIWLlXCr3uiuakYZ2aMGBRA6Mx2CLhHri0ewd
 4hAD9c0ZhY0AkgmvkXgA0nf6t14lQZ6DetBaf3Y7/DSR+wL0GsDq2/f1wpOwUamIx9i140ce/M4
 9QAuvIjw4Cu088numDI7lz4THJW/JNOCH4sk1hxRCGq5qfSRyiVNMvK58FT1iSnOSa4TcGh2OD3
 I9ZHfaiVJbEHaMjDutrVeZaBRo529EkZ4am2zim4kNiY2OMc4sgvSHhXzx3iQi16S89UbGw5Psz
 JFedxHm//XxsYXeNrALT86sZS8lORw4Z4dVPHIxoMgD6/2+Yt0wpvlQWEtnS+AwxeHiWH3FcxiT
 fs+8eFTWIINlhw6xxy1SNcfaSgj24m76o+xcWbIv2Z4m2vjbv6iaJY2+l6pQVDpqtPzavKTix2n
 PxVouzBPBJD5vD
X-Received: by 2002:a05:600c:3e0f:b0:493:9cb3:53fc with SMTP id
 5b1f17b1804b1-493e7e84c21mr47569965e9.11.1783584045135; 
 Thu, 09 Jul 2026 01:00:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6d5055sm43707915e9.5.2026.07.09.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 836EB60053;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH 4/9] contrib/gitdm: Update IBM map
Date: Thu,  9 Jul 2026 09:00:34 +0100
Message-ID: <20260709080040.4157324-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Joel Stanley <joel@jms.id.au>

A number of us have moved on from IBM.

 * Alexey moved to AMD in 2022.
 * Andrew moved to Code Construct in 2023.
 * Ben moved to Amazon in 2019.
 * Cedric moved to Redhat.
 * Daniel moved to Ventana in 2024.
 * Greg moved to Redhat.
 * Joel moved to Tenstorrent in 2025.
 * Suraj moved to Amazon in 2019

Most have either stopped working on QEMU or swtiched to corp addresses.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/group-map-ibm | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index 24d8dc1b865..39c53a42ca1 100644
--- a/contrib/gitdm/group-map-ibm
+++ b/contrib/gitdm/group-map-ibm
@@ -2,14 +2,6 @@
 # Some IBM contributors submit via another domain
 #
 
-aik@ozlabs.ru
-andrew@aj.id.au
-benh@kernel.crashing.org
-clg@kaod.org
-danielhb413@gmail.com
-groug@kaod.org
 jcfaracco@gmail.com
-joel@jms.id.au
-sjitindarsingh@gmail.com
 tommusta@gmail.com
 idan.horowitz@gmail.com
-- 
2.47.3


