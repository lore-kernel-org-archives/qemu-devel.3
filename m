Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18666E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIw9z-0001Ae-Jf; Wed, 04 Dec 2024 15:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9x-00018z-W4
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:46 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9v-0008Ew-9T
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:45 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-724f0f6300aso271117b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344782; x=1733949582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqKHYpUulGdIWayEODwJfBo1zUyakQeh+AqqbYk0b0Y=;
 b=DGXE5t661d+UyNLvGG+CvYHs8MQEHrqm2ntRrGcJHafkJQsNB9okpiVhXoqtcvgXZ0
 uEzFwgsvRMMb2zbXMTKT0VSEqYijOn+mLFSpjshD+qiV4wRXlSBN//x6g5Ck1po0+uTt
 m+yuQh1DiHVvW4/Tc9cb5+BdQ4j4eGtUgNv1hGwferjmZN0VbLHUnjo1lkDqry1NMHrw
 +aTXanNlQMeEhQuWQwrqp/ybrGyTLkR940rQV8MsBPyaCWMP5qtAMS6PuqrTrV33XA+G
 NsN6eK2rNqik7cGIOiQj/yTCIoJ/68x3pzDaxB/j2x5VZHy0eHNNp/glibCp1J4phXHl
 lAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344782; x=1733949582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqKHYpUulGdIWayEODwJfBo1zUyakQeh+AqqbYk0b0Y=;
 b=ftusAWPhCBr9FGsvjboxLt9hSH7SlacqM10qCoMuiX465HueO1f6TXrQ/HaKPoxnxU
 5zUqKaArf0c3+qlyDMziMeEV/wQ3xRNk54i6pX5OeiyiLxt++oWSY8XB+b/urJ407Wk2
 +mZ/CjzxCP5OPVTg+5meDWUG6Mojqm4hTowdnMHDfU79fbGa63+/myDsAGFoLWaBIRqW
 sQs7yHTmgNM2Bmh7hJF39fJK2/CPhhu0nSbBzB4wz8Fz0Dfl0HuoodP/ivQBeC+/DUN4
 z53rbU2gKZZqzCVclbLkuY1JwQY+p/LEdqOQ+WFdidMyop0gQ2kb8mfHz85npyocnrEX
 kjCA==
X-Gm-Message-State: AOJu0YzMd5C47Dbdcfo9o0g6UadFiM+JWnRPIG+1OFWJ1L7tZULh1FHh
 QFuUK3k+SiR2c+BSrxXPT2izsT1COxaJ8N6SAkaBkXm38x1WossSQnMAtBMfvwJQWb9zP9kacvq
 /2lU=
X-Gm-Gg: ASbGncsQhghXCBgwJIEWJ6nVIOX/4upjd41x/tGqAMfbSUrxCcpkTjcw1PqfuJGNJm1
 vUxC6b/ACgEGhNjpxmBCW9f5FZ+pM/ZZUkT4Y0ndMWrt+FZ8r0FLaIVeXnKRHOA94MaS9/xndc8
 p75uOSghf8lxSMzUAATeNTemfIIpiBNabozR/Xy/ItOP1y70YcC5Ls3pfvW6TRk4wgNVBItkOsH
 Xr6Uawn42C7Rc4QczShjaG+jAqQeUc/fWm7vkRgLkrqqzDzipP3dBU0gyyOp6YaSrd9rm4MI9Zj
 vi3F18jd
X-Google-Smtp-Source: AGHT+IEkMuELipHiPHIGPhzFUGJmfM2ncNF71WR2OThrpwcbDONKmux6JG3ZGIZxFG59jaEUyVbyRA==
X-Received: by 2002:a17:90b:52c6:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2ef0124eeccmr10621728a91.29.1733344781729; 
 Wed, 04 Dec 2024 12:39:41 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2700cc6esm1873117a91.21.2024.12.04.12.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:39:41 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 alex.bennee@linaro.org, Alistair Francis <alistair@alistair23.me>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/4] docs/system/arm/orangepi: update links
Date: Wed,  4 Dec 2024 12:39:09 -0800
Message-Id: <20241204203912.3037515-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
References: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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


