Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68385C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYhS-00063G-JK; Fri, 23 Feb 2024 11:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYQM-00063o-0g
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:29:22 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYPx-0007Hz-9Y
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:29:21 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512ed314881so307209e87.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708705733; x=1709310533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+Lu1aUTzILJv+8PeOqcfRU9ypZOJg6L0bg1/V/uBfw=;
 b=J/KRmmowADFlAtBnGoqzU1KZyO+jTwJQG+wWxx1iYc24huxWQiuq+ppWtYJrauVuTV
 mQ8Ib0QlPwvi0IVai74tSd9BTRuFh66GktmCpMxMMxFSQ5WyG0st05LY7hmupGu3pqn8
 td+5BLfhLuzi0GHEoYrPw5ucDQWw9lNVxNLifBzpkU5RnCAxtDWCM1aFV1EuxqaNurJa
 nAHg4OHgEXi/bUEOlQeXOg3sSVaET3kbH36NqW3oXk9NW6dnosiqGxKSqT8Ye+i/hFBJ
 Pkp+QOueVKs/MJYlMWxXejsYJLV0JVh/KP1+8G90OzckcXMN5yIaT8zxeRueJcHzQ6V/
 A2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705733; x=1709310533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+Lu1aUTzILJv+8PeOqcfRU9ypZOJg6L0bg1/V/uBfw=;
 b=InYTNRAaNfTzSIOxTlP1wZ5pM3oJOtlQ8i2ULNRK/TVn1QRAxV3017S0/+8jAhRny2
 hDMUMK+XFifP7n7fALGsO0Zpt0vWj46duWtI+kkLcwby8kdkaX0tecuOHl0/viIOs7PC
 Wkn9PFzlnwI25K81JBbhysiRdk3zJfXYbpir0vGZH4sqFaKc0zUOZg81rFF+tZffFEnO
 BvFH4OV3RiBgnxAdI5QLYbS1mWitA5vlYF5euipnuuQjcszyOv53n0Tw4F0q2hfCtYfH
 mBDfhfeBJFLWTzoFrjT/RryuV+TvcY69sBmmxEfHBPnAdmwVlxXJ+GjG3Jnu/A68luH4
 Hghw==
X-Gm-Message-State: AOJu0YyVlpXUgK4C4ZzLZg6XBDCnYd4OyiKhdiCHY0tmseAX2QyNPogo
 ngwlM+jzHMuB8gR2SoBGw/8631WAeLu7sOBsTFhW/4Th6eap+Oz54it2frrAEao=
X-Google-Smtp-Source: AGHT+IGplN59rkQLEB1uSrd2cCAiWoie3bboaYuyype8i1MvIe/5fGf1ZlOLRAjTeemqlxnv/K4+Iw==
X-Received: by 2002:a05:6512:ba2:b0:512:e394:5357 with SMTP id
 b34-20020a0565120ba200b00512e3945357mr251388lfv.54.1708705733398; 
 Fri, 23 Feb 2024 08:28:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c0a0600b0041266f5b041sm2984960wmp.34.2024.02.23.08.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:28:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D92085F93B;
 Fri, 23 Feb 2024 16:22:04 +0000 (GMT)
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
Subject: [PATCH v2 25/27] docs/devel: lift example and plugin API sections up
Date: Fri, 23 Feb 2024 16:22:00 +0000
Message-Id: <20240223162202.1936541-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223162202.1936541-1-alex.bennee@linaro.org>
References: <20240223162202.1936541-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

This makes them a bit more visible in the TCG emulation menu rather
than hiding them away bellow the ToC limit.

Message-Id: <20240103173349.398526-43-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-plugins.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index fa7421279f5..535a74684c5 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -143,7 +143,7 @@ requested. The plugin isn't completely uninstalled until the safe work
 has executed while all vCPUs are quiescent.
 
 Example Plugins
----------------
+===============
 
 There are a number of plugins included with QEMU and you are
 encouraged to contribute your own plugins plugins upstream. There is a
@@ -591,8 +591,8 @@ The plugin has a number of arguments, all of them are optional:
   configuration arguments implies ``l2=on``.
   (default: N = 2097152 (2MB), B = 64, A = 16)
 
-API
----
+Plugin API
+==========
 
 The following API is generated from the inline documentation in
 ``include/qemu/qemu-plugin.h``. Please ensure any updates to the API
-- 
2.39.2


