Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E16EE0211
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH7x-0000fh-Nw; Wed, 11 Sep 2024 02:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7u-0000Wf-6U
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:55 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7q-0004P4-37
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:53 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so6447734a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037208; x=1726642008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tx23oVrPLG6g8Ksup34Nr8GIz/4sQ5H+rc6lFUcsHVA=;
 b=ctNjs1HKOrfj7KxMUUpED/y4Ro2/6EFPzBwbQxqxrkJtaaCn5win/Ss58Dfd0u5Zxi
 Dalz2VOhqaQDdzYMXDkWlOJlbVbQ4Q0ynI22hNXLQDsTyXEKWgOd6olE92Ba8Q2mdTy1
 tLpecia+NjcutmhISI/s+Ho2+nDs/pvRwoNrBV8mKv0D8W/A0sd/H9lZ7m08lzdEzM1/
 3QtrlkWIanCNzkWbQxNQ+YQhES5CNgF9BCmxX81tmjtTSsO4+bWe7UkONsrZFojxw6jx
 h2ZI0/afaVPN8YF1/hEsO4yHbNHsi/DW9kBtcLL2vrpMTZKZvn4isq2X9Sv2fr/74bIM
 87IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037208; x=1726642008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tx23oVrPLG6g8Ksup34Nr8GIz/4sQ5H+rc6lFUcsHVA=;
 b=XzW03tesY3tofP7pHVsKxRS530mFa9wOEyBJwFBWfVL8Wep3noQ4Jo27AAz9rjLytS
 Y2FCy8A7MabtN93vnnpp6dQURGhaEqEUglf1j6Wd35ojagzQprXhJ8uTC3Ko9iUIwvuq
 e2Rn/CXLLtDbs8SNSY0V+Ge2d/DntG0WMQSPYsaNN5+KnwiQfiQ3Jm0J9p5j6oaQJVzA
 R79jLLDm9gYxV4vQ01JIH7XXnEZe7q0JMETqMPAUQbsEvvomyyXjqQHTPwVpnRuVZz/n
 Iad8xf3z2dBf19fBC+Rs5AVsI1/sARElWla/G/KMssCWZ8RMGW+WZalfIUGdjpd/NrzL
 5nOw==
X-Gm-Message-State: AOJu0Yx4E649I3XYOR/vg2gV1zekLyOxwA8qpv3M6sNSDw5V2onM20fh
 5qkq2XqBaowz6o/KDbl40yPV8frIxs0kVLQNhxAQHXdJU5HOop34JDQjZbrov+aD7LnDdV18IV4
 kPQg=
X-Google-Smtp-Source: AGHT+IEMfeEiKMZcSo2cqfTt8EukMldppA8U27scG3Ka9uj5wAw1nr5j0mBk06+Nnd0Q138Rx0IIWA==
X-Received: by 2002:a17:907:7ea9:b0:a86:8f8f:4761 with SMTP id
 a640c23a62f3a-a8ffab29500mr272630966b.25.1726037208105; 
 Tue, 10 Sep 2024 23:46:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d259526c3sm575089666b.69.2024.09.10.23.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 54EE85F9EB;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 03/10] tests/docker: use debian-all-test-cross for mips64el
 tests
Date: Wed, 11 Sep 2024 07:46:38 +0100
Message-Id: <20240911064645.357592-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
References: <20240911064645.357592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

While the mips64el cross compilation environment is busted in Debian
we can use the debian-all-test-cross image for building TCG tests like
we do in the CI.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-4-alex.bennee@linaro.org>

diff --git a/configure b/configure
index d08b71f14b..39a284ddfe 100755
--- a/configure
+++ b/configure
@@ -1328,7 +1328,7 @@ probe_target_compiler() {
         container_cross_prefix=microblaze-linux-musl-
         ;;
       mips64el)
-        container_image=debian-mips64el-cross
+        container_image=debian-all-test-cross
         container_cross_prefix=mips64el-linux-gnuabi64-
         ;;
       tricore)
-- 
2.39.2


