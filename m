Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184E5C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 16:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiyX4-0001qa-ID; Mon, 04 Aug 2025 12:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwun-0000gK-P1
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:15:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwul-0000YQ-Gu
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:15:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so3894981f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754320548; x=1754925348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6oEr5Vs3fmUjzOCI3T+a06J4NOhRz8MdlL63v2ufMw=;
 b=h+KIIX9r3v2go494ayWDJrCm0QKDC4oIadPbYR2hpU6c9XYcVwqW5XKuln1qWKkAVF
 Nq84VY2bxSRZrUn5bn4PCGEfBQN2oDdOSOU9pO/IvHOJ00R4PhXoD0tNctEXs3j8aZ6q
 hPIyvPAON6IaMYdU8SczAvCJayBTppZOFfrwYYWxrSV+wtyOPnFA74csDVUUOwRMDmtj
 cSnU3MgrtjC5Z4rV9rOsWRwFwXhlY6LF1bku2MOfTbnvX5pGL6nhtJJy+A3zOP3Bgyqz
 lIdNuUqhgf9NVEndLpqyFke1coHqUT152jCR5zjUX8l77ww0UY1e3WnG1q/nU08v7uLo
 E+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320548; x=1754925348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6oEr5Vs3fmUjzOCI3T+a06J4NOhRz8MdlL63v2ufMw=;
 b=fHlKRRTzAzcrfYSo8ZXypQelshCQK25WsSWXDQiXQMKlFh0ZLDWAEMZt990Fj9nXji
 FSpHE25m4/wVETeeKQjiKl+5g2cX+jfjj2PmHicXGE62SeGzAD2R2T487oqaD9l8e5Vk
 riXBB1hs8MxHIbQy97ghRbEYbozbpgS9ChIm/SxxjIiLgUzyHHo+6ElpSHojxIey4aCX
 lh+xzHnbFRXPB/BA5GdR9YGo3Lb9t7FORob3/ZZaY4C91YgCm9MTXdHw9Uud0HPdvyOG
 rfRLvAPoCMq1egFWdmN7Krpc3+1fz+d4QXDUOYPxVcyQYfstfbEP2GgcOlHMTlxBAU6M
 qVCw==
X-Gm-Message-State: AOJu0Yxx8XMSWi8CgSqhxgGbD5wo4kNaxO3Tkz9cQcicIF+63i2o+5fs
 UduP8jGv0uv+W2MigmTbvrB3LKfUHJQNkUm0jbqw3DIk7nS/pYtkFbXxpdik67as7Jo=
X-Gm-Gg: ASbGncvG26H9zzgmLDwEKi6m993+tpLd2ZFQvb4cs5ufzMSF8Zu4TY/cpXEqXEbkwRr
 abVWy0xAKR+nSgNa4g6+unp/KtvdK1y8wgYyLrVCbBIlzIaoB2IGvKXaEThq388OTTJEN7zplJa
 8/1epcKfQPLH73K8K0qfj7DVparWQcZgZX5Q3PhWzd1sWbijXMwNB/cQj5RKhfG16/YjTMm52ac
 TKq2Xo/Lwj3JWV69/kY8qCCwLRAn6WDCSxn6dWzXMLkORlBNzUcGcDTX4QZfDBQ97v7d6c+mc1F
 ccDeR9k2BpNhm46YvMbTydXINoiiqXEBQ90tZUDxEmtiSN83iRGKGUr6rzmEwlSiZASD2roNDeJ
 /kUD886YWXckp1lsfhOf+bvs=
X-Google-Smtp-Source: AGHT+IEJgDRoCLZ4bMDIIlTEtmkImQ41hv17qgJnXsxl68e/uIsLXxSUtOx5Zzz0yuhl9DHEKXIZ0Q==
X-Received: by 2002:a05:6000:2409:b0:3b6:17c0:f094 with SMTP id
 ffacd0b85a97d-3b8d9471798mr8546424f8f.14.1754320548324; 
 Mon, 04 Aug 2025 08:15:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ad803sm15778951f8f.6.2025.08.04.08.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:15:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5369E5F892;
 Mon, 04 Aug 2025 16:15:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/3] tests/docker: fix debian-all-test-cross
Date: Mon,  4 Aug 2025 16:15:45 +0100
Message-ID: <20250804151545.311042-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804151545.311042-1-alex.bennee@linaro.org>
References: <20250804151545.311042-1-alex.bennee@linaro.org>
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

It turns out you can't easily expand an ENV var across multiple steps
in a dockerfile. This meant we silently dropped the architectures we
should have even on amd64 hosts. As the updated AVAILABLE_COMPILERS is
only needed for the following apt install line just merge them.

Fixes: 6da616bb170 (tests/docker: handle host-arch selection for all-test-cross)
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250804104308.250949-1-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index ef69bbc8a51..420a4e33e60 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -62,9 +62,7 @@ RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
   fi && \
-  echo "compilers: ${AVAILABLE_COMPILERS}"
-
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
         apt install -y --no-install-recommends \
         ${AVAILABLE_COMPILERS} && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
-- 
2.47.2


