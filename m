Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0E5E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJduy-00045u-Ka; Fri, 06 Dec 2024 14:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdut-00043d-9F
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:07 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJduq-0003SR-Ul
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:23:07 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-725935d001cso2137387b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512983; x=1734117783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqKHYpUulGdIWayEODwJfBo1zUyakQeh+AqqbYk0b0Y=;
 b=RdVLZ8H8I6jONDHA8omg3S/HjZ0VU9DPX8qbRmvASf/S4ODmp5tssX7a8/8YLsVVo5
 9nrPsV/6E7ORxNolviqaGr19pBsKNtnc7+FNXCEaBWHN2zCjkzPUe0Zdc3T7wuQmY8kq
 0l5+Ywdr0Bc+qqU2cfjyt0KANrXYLZFm7vYcXv/tg7Ngvuazk9BivBpLNy7sJYyPliGm
 ifgVC6hgAPf5O7ZB3bec7mLX2P/PZJxCczLIrr7sdVORMebsmeWcJOLHdeilgkfgl/TF
 dnN4LA6T0qJU7lA/xr1S6i15xPL91Y9v9WT0TIv8sxxyuFjZ2dO9vtaszVKgvhvCMEsp
 oqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512983; x=1734117783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqKHYpUulGdIWayEODwJfBo1zUyakQeh+AqqbYk0b0Y=;
 b=lxbb0OkUcyYStO30IJeWczw1tKq1k4YzZbKz6czne9B95OdpkTnK05tESfiARsu7Zv
 EehmOnzu9svGkiIyd2GTfGZD/bEPMMefgrNJbuGCjx1RvHvs1fL2pS6yOrhCWxZDrxvq
 aiqLkKF0JL/HaMxxJV6gXOZ9TuZRKL+MZYrcD4fh4f0cw8aRxq7EGPfJQtAU9f+Us/K8
 0YMp3Dq9Ne1DNgfpNfB1wpBqCRjqFzs7SeXnds1wYGasPDSzMJIWRzrVHZY0Pos2Ep62
 LSxs0REZyyhyQnMnjQY3TGwnPrxN6MK0eYHCMMjSv7zWQ+fpcZsIFSf+JT+wrdKonmyW
 NTAA==
X-Gm-Message-State: AOJu0YwTphRv7hHl+A5kETgymm6L1tXTjPR6/syX0/g41ReTlM+o3EEG
 2vOoskX9MjU9IMq4+VCaGPDYH337YUAQ1L98nQaHZNmHB5uYbwvXFl3Bb3/6KBu8uGtIky0NNTI
 2keg=
X-Gm-Gg: ASbGncvnO02uLEjZvFgG4slL7hE2SASdBAPnojriGpii5YMkvTtxYimzWkrex+Jczmy
 gIwyW4kx7ML2/QKNGiX2pPRWn6ysPbgT9Ae6heKTK4uA1zz9+/9y7qtrESdLvB283w07exdDnde
 VqfGO1o8AtI6ZJMylGVfK2CmX5gYk3vz0LgQqEQDbo5NaL0QBkePt3iyBADgd8DTB6AKEqJnHqX
 tcAxwY5R4f03TJjFXPyiENTNuPM78nZkHKePRjvzH6furvG8clG2ldLcDLQePZyKaVFF14HNyhp
 qNmyrGZb
X-Google-Smtp-Source: AGHT+IE3hWhbmAqmAFRiFIlqMJOhPZ5Gd5Wz3hnKcz1qwEXSS3c1bzMvZHawdGbUvNW1T3ct+LNiiQ==
X-Received: by 2002:a17:902:f644:b0:215:75ad:63c5 with SMTP id
 d9443c01a7336-21614d497aamr73931625ad.22.1733512983238; 
 Fri, 06 Dec 2024 11:23:03 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2161e5a6f23sm11720395ad.266.2024.12.06.11.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:23:02 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 1/4] docs/system/arm/orangepi: update links
Date: Fri,  6 Dec 2024 11:22:51 -0800
Message-Id: <20241206192254.3889131-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
References: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

www.orangepi.org does not support https, it's expected to stick to http.

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/orangepi.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
index 9afa54213b0..db87e81fec4 100644
--- a/docs/system/arm/orangepi.rst
+++ b/docs/system/arm/orangepi.rst
@@ -119,7 +119,7 @@ Orange Pi PC images
 Note that the mainline kernel does not have a root filesystem. You may provide it
 with an official Orange Pi PC image from the official website:
 
-  http://www.orangepi.org/downloadresources/
+  http://www.orangepi.org/html/serviceAndSupport/index.html
 
 Another possibility is to run an Armbian image for Orange Pi PC which
 can be downloaded from:
@@ -213,7 +213,7 @@ including the Orange Pi PC. NetBSD 9.0 is known to work best for the Orange Pi P
 board and provides a fully working system with serial console, networking and storage.
 For the Orange Pi PC machine, get the 'evbarm-earmv7hf' based image from:
 
-  https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
+  https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
 
 The image requires manually installing U-Boot in the image. Build U-Boot with
 the orangepi_pc_defconfig configuration as described in the previous section.
-- 
2.39.5


