Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE3BC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYf8-0007dF-W6; Fri, 23 Feb 2024 11:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYJd-00043J-6c
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:22:26 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYJN-00064Y-Ha
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:22:22 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d0a4e1789cso13028311fa.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708705327; x=1709310127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmH3A6oyXZRSyv0FlgeXXNzbTzs2PoDjMnFFS+ZsoEs=;
 b=zo7148q4VkJxdrSuBRoA8jqI5j35lV16/2v3ZI0k4nxV/SQku3402eaRgRO4xGVNps
 JejdVf5GoXJWxQAVqyDi5nRf4lxH0Nt3St6LtavEkcs5D4yhg6linQ+zhy61cqfe8xYn
 pMvNXViEPPraF44mxDOpJimJdONqsaUMX4ncgUzIy7kYsGPhZKsyfCILRR+hXC0PcGEY
 Ze1q2ioAtbyGiWjWWKm66g4YUNAfWzSc1iaboFzQI62bqQbxRQJM2iA86n0STy+thNBz
 XbBRVKu3J6pbJnI+AgsPeH4NgcJwcNBvriv2EdCni/Ik1BR97pUT+GsVrRE/hab770RT
 qyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705327; x=1709310127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmH3A6oyXZRSyv0FlgeXXNzbTzs2PoDjMnFFS+ZsoEs=;
 b=TCI4GDuTOky7/EnLo0ev5Fzu+W32KwVMdO/JIsUvAQ9dObHX4OpqlHmGwWHWus99q2
 snQIVXWiadaKkUA6TPSkc25dNO5DXKhBaorONjA1BoYZqliFQLNyKeIKaKNqpYzSTYk1
 n5XAgz0sF2k38dvBI8mwbBJ2WyjwrMS7QiVDRHDk8EoTqSuku6f2RLdqxOQaNTZY1iBf
 CmJ587rY5hoZpHSja6U9deOUKmxq5puu1k0OzRV9NDFrR/8okW4JyxuhbsuZxLv8RAtV
 0oJQ170iJIsMhcrU63j/mg9zxd6IyxAJvJEGA8T4GqxmqgU8dZvLL98S8rdM3KaF18j3
 Ifdw==
X-Gm-Message-State: AOJu0YwMbMEmAKxkDjFZ82Us0Fnyb3njMA5q/XGHgF7igqN+zV/m/XrT
 5ljFnReWGOa5MkTfN0Yo/OFtNt5eoZDTTR9Q3+PqdkUj3jpmiAlvRCN6P6+G+Uw=
X-Google-Smtp-Source: AGHT+IE6RHGe8V5I3NP4IK6i/jJ4jW3hbMMEj7S7eZpB+qvYHLhthQtdxEHKg8e6D2dbMiWuB9wz3A==
X-Received: by 2002:a2e:7c17:0:b0:2d2:4429:34c4 with SMTP id
 x23-20020a2e7c17000000b002d2442934c4mr233156ljc.8.1708705327096; 
 Fri, 23 Feb 2024 08:22:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l28-20020a05600c1d1c00b0041276d96351sm3029729wms.3.2024.02.23.08.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:22:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E1915F90B;
 Fri, 23 Feb 2024 16:22:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 02/27] tests/tcg: bump TCG test timeout to 120s
Date: Fri, 23 Feb 2024 16:21:37 +0000
Message-Id: <20240223162202.1936541-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223162202.1936541-1-alex.bennee@linaro.org>
References: <20240223162202.1936541-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is less than ideal but easier than making sure we get all the
iterations of the memory test. Update the comment accordingly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8cf65f68dd8..a4c25908fb7 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -93,12 +93,9 @@ QEMU_OPTS=
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
-# ??? Makefile no longer has any indication that TCI is enabled,
-# but for the record:
-#   15s    original default
-#   60s    with --enable-debug
-#   90s    with --enable-tcg-interpreter
-TIMEOUT=90
+# so we have to set our timeout for that. The current worst case
+# offender is the system memory test running under TCI.
+TIMEOUT=120
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 # The order we include is important. We include multiarch first and
-- 
2.39.2


