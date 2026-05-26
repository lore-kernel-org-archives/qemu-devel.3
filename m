Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28730CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZB-0002lf-8C; Tue, 26 May 2026 07:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYr-0002c2-LA
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYm-00069o-9Z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490686877a1so12832695e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793375; x=1780398175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bg+tgRoSaMVPlPZYLq68vWgTbA0wBm36ShtmfRzn+V4=;
 b=foKwkTSl+qg2dvjzAJUoc09EEcPVj5fUc90FyxgaUfERAEwNsc+ZQT+Kd6y7ZtiRcN
 GmK+4SCnXYQcWFp+tUgq9hd9tjI88WtOecFFVQsmC1sDZ9j9zCl2Re2h5dukQyvwZ5ke
 gKnDhD/zYwu4IfnJ0xmFdGiGcV3eBbmsWD0BppPOXadYfrxBzvpEnvDqyyY6ZqAm/ByL
 J3yGoPVRO6Hrcfh6fOqX6mUkPvMgwPfUFgjVPIOmGFNa5fehwkYJVhMVtiRliETE1BSh
 5/Ly/fPmVnLDIbKu1a4ZSupxxSNsKhelDCPAyd286YCMkly3EZvKMdHFimgkhXefN5rE
 tGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793375; x=1780398175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bg+tgRoSaMVPlPZYLq68vWgTbA0wBm36ShtmfRzn+V4=;
 b=LqwWvxo4asJdMJaaiGZIETtN1W5WDRKux2TS5mmPhHQa4aaGNymhRQIoHF3nOG5jT6
 wOaIab5DJvJLGkrj7pQb9ww68CUoFKKh8anoOYjtGVJwOodzAGiD9EDkpOz9M/xSq55k
 UpNrbgUniTVJ2y3jDAYLY6nNGQ8MAhJOpGee7wUv2c9CO4YIiu17zrGUgSCgUoYfxA5f
 T9q1DrnYd6FCR+mae9lpZDE/iKtwyJI4G9LVFLw+LD+mF9brZY3vrWJrr2WakKUSk80m
 S1zIPFvDp/DQAiOqOvwAQJtVRtUKtJ5GHhN8FObDlXlEpl694/YNUtvFFOjpWfMfFkha
 d/JA==
X-Gm-Message-State: AOJu0YzHblgcy4cgOhX8V6Swicd/LPWi1WP3HO5gpkL1rKjIAp/eJUad
 arhB2vK8Q3fVRATDsHc/XQA2uKhIn0xMT53h3om3CFYnJn+6VEEePK+baea71naS2bI=
X-Gm-Gg: Acq92OHdf7BsSmZ62DSlbZbfbHEYWNxcnuYXAlpacMMcHtWVI3XEP0ppW5J7bZlKwCZ
 UwbMUOQFsqx8WPVCKSCVUHQftSxjsX8u0KUe7st590RoXFpeleBiGRcQWirudufmHIo2Bw+8N47
 oQPA8/UKqd/etAeMck3H0Qq7SrJp7T754leS4VErNFradGNnRZv4bvJTl44GzXp+nwLfF97Cxkb
 rIkySMhFTp2Ny1y3SuxM/44MdmI6rOzJW8JFJ/y09m0OVQFLBiQVCqfc2SUdsNav3KhSQ3Xzett
 W94Ng1jPAaJ4BBB3gbPGA/4NjQCbDuE69B4GsBIbb7FosG2roHD7fEOd5OQTLX+yD6BErFQm3t9
 9xqm2rSLeQ6irHcqZWXqeT7SRkjSNraqRyVPZcbSrbalSkUUaXAkLMhcnHpP3IrqjFk8YXzvvPG
 8PLxTfUhMeWAGoiqNHw4IGqFI=
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-490426b0c92mr214245655e9.16.1779793374516; 
 Tue, 26 May 2026 04:02:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561f2dfsm300944335e9.12.2026.05.26.04.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F343604A4;
 Tue, 26 May 2026 12:02:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 11/14] MAINTAINERS: Cover debian-loongarch-cross.docker
 with LoongArch section
Date: Tue, 26 May 2026 12:02:39 +0100
Message-ID: <20260526110243.470002-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 506f8d62467..31500ea2660 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -280,6 +280,7 @@ LoongArch TCG CPUs
 M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
+F: tests/docker/dockerfiles/debian-loongarch-cross.docker
 F: tests/tcg/loongarch64/
 F: tests/functional/loongarch64/meson.build
 F: tests/functional/loongarch64/test_virt.py
-- 
2.47.3


