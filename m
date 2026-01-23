Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F252FD74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbq-0004Aa-24; Fri, 23 Jan 2026 09:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbo-00047z-Qg
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:00 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbn-0007kt-2C
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:00 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1481195f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180277; x=1769785077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nT3H45Zvi+rSAkwTxllxj0xxmzYQm/YC35tgToRHJLg=;
 b=OU9OMe3PliXOsxqyCnfHpxQBBdacFlxuBOs251aLYW1yVDdP+kO97I75+V+9Lx1/OM
 HThUA3Zgwe/VHsKLab9kLQwOoooBWiIcsJvg/ripXbGWs63cjZAlI9Y5OVDfhmL+xCU2
 wldvpAsN7G3503en/lHxEW/QQeT1J8aA+atQ1VvrZZaigrn2+Nwn5k+WYz0iXyWjoTCh
 itkikLNNXi/sNOnwh/lDWUJbPt/RjOomlJZTNuxS7v6eSiD0MPy29HEvZx/1PBUPIghJ
 31PWtTd1WqKY8KAgh9/rb+1Mjl8nxoyLoowZ5j0/JzWFeAFr0F6mGJZQQjBaGV5z2V++
 X7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180277; x=1769785077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nT3H45Zvi+rSAkwTxllxj0xxmzYQm/YC35tgToRHJLg=;
 b=UQSDmA6S9Dg6rnxS+7zLVeFDV9vRi6Pr7fyxA/21HT1ZTTPnZhPljNk/McZ4wSG4mz
 qeMHAWIMjA8kC8L6nATh6qCC+1wXVMpePWqzkKypxHDiWaREQXXvG+ouWyncEqCIskSr
 SXSHGyTejcn7b1Rji2s7aPLLQt6b/VOt81K+EUXaC2PwDO1e9mmvkhTCIxOuhi1si31N
 g149NtwzidKrHM+pJC9CzE2DKlpNXbWAl7SCobBYsr5gjcGPnwa6D6BWM8rxOsasTCFD
 7/T5WqhGiYeCSvqWRA70ZIZ3ezf9lHyg8iNYvSSqz7obrT8Dyl7apyTzsOHvqRFZi+/C
 0CwQ==
X-Gm-Message-State: AOJu0YyS2wwhPqrr7uGPvIfsfjAG0IHlJRpICEC3sucNq5fwIZoW4dXR
 byC/loNPZ4UqzJAw0WBSqBcI1NHclTtex2qmwKUHr3SutGy6gMfqLdSJ6wibrwmykE0=
X-Gm-Gg: AZuq6aIjyqlYx3IWRD6plzMxIIY0wBBMcVH+UkRNwOIw6ftzUwYFClD6nUw6clQ0xLU
 fZt1+Tx72W1TSjbPZiuJDBEaqfF3u+IuCmSyhyRIjxUpiMQNNX/PNlNo+Pj0KM+m9kAJXHASpEo
 uYDbmgwc/F+tmBIkjpHJxiky5C4Oy3VISFKcpY/+cHs6MZqXXDWdADzLj4xrRJtB04+hurPrLmn
 3GAvR+AN6womVa0x+8zpRqyI2BJ9Xgf5g/mYmzECW/mc1WbD63B1hgUe38V5Q1Gwgzo2NDkz7yn
 3C1v/TiCHZ335MtcFaTYE7YunqIqDm4UvBWnorx+3baaTbitrd3pS5oCICUl+y3UCxA6KM0+IXq
 sjOtV1LMS0CCCW1iZFQYsKjO72x3QAomj3j7WO4ChTvN35p1yVOdWCqYDGWLsAeo2Y+lW4KKo9d
 ZYyQy+jyY70xow
X-Received: by 2002:a05:6000:220e:b0:432:c05b:d8c7 with SMTP id
 ffacd0b85a97d-435b160e067mr6041511f8f.49.1769180277495; 
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745c5sm7857952f8f.32.2026.01.23.06.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF5BA5F8C7;
 Fri, 23 Jan 2026 14:57:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [RFC PATCH v2 04/16] MAINTAINERS: remove myself as reviewer
Date: Fri, 23 Jan 2026 14:57:37 +0000
Message-ID: <20260123145750.1200879-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: Mads Ynddal <mads@ynddal.dk>

My work has changed focus, and I do not have the time to continue.

Signed-off-by: Mads Ynddal <mads@ynddal.dk>
Message-ID: <20260121112725.40060-1-mads@ynddal.dk>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 851fa3b3d69..3604422f8b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -536,7 +536,6 @@ F: system/cpus.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
-R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: target/arm/hvf/
 F: target/arm/hvf-stub.c
@@ -553,7 +552,6 @@ HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
-R: Mads Ynddal <mads@ynddal.dk>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
@@ -3655,7 +3653,6 @@ F: stubs/
 
 Tracing
 M: Stefan Hajnoczi <stefanha@redhat.com>
-R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: trace/
 F: trace-events
-- 
2.47.3


