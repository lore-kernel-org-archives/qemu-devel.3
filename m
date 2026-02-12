Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85764EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYNN-0004y5-LL; Thu, 12 Feb 2026 10:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqYNL-0004xL-Mo
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:13:03 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqYNK-0005Hs-5t
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:13:03 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so77140965e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770909180; x=1771513980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QrVBh/fRUymIPd9xBudqk/kqofgkCYeDTfJ3Oqohuy4=;
 b=osU0+YirrbFUIKUskEs0D9lQIgu7+/qRJfLwMpmSsdxaPPNNpaDvH6kHWEcZkBdVm7
 Q/8lTldxM+sq9liNszsImELjbYjakmCIQJ5IbYCZMYK4DAttbCjS8bXkAdBa1jJ8VWKQ
 FisM4X/4ue5RePFYWyDFJ9uNwJr8IF/w1ABcLxQh8oCKCtRJeQ1lYjzmACQSKe3mJwHc
 V5T0/6EdEhGxcL5zApH8C6kyqcEF7uN+ArJp0GF3RaCxSEKVoxgeQc/88ovw294wy+WW
 bOjS4sNCL399uem6PRmnm9RQX75gsIBrNdKRKIi3zSMchXe97Wg+/wnxdqahfTW+V5q4
 7sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770909180; x=1771513980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrVBh/fRUymIPd9xBudqk/kqofgkCYeDTfJ3Oqohuy4=;
 b=akav2X4D84m8qGiDymPIy6eLBkkQFpQYshpzt1sqVAjbRaDU45lfTd8p81sYs5dbYS
 dYHgiu/tCZ8ygcflXffadkZ8Dr34EMAQz76B0guQHFODN8Kz4fqqU/rNoZF1mqnMkeAb
 hAhLtakGqyjMdzfvEHWfoCjWztMGG/+fwvVMWLebQC9tNFC2EJidBmjtMbnI4MMR/w8D
 SiCKr9yntnfntomzF+GXb0wRU4I4yZkZQ6DbQJS7jdXyE8uFoQ/uVUV4L3tsbz8yxsb9
 0qZaRyuDTogJcKir+v+AeSIAWqq8GSjTmIWB+ljuIZ6sLCX9Q+UZSe/PuLgo76ID8EZH
 8rIQ==
X-Gm-Message-State: AOJu0YxzPiSbfIiyv55y9fttu/a91Asxbn/KnOM9baa/5pdBGLBcNRab
 lu3Na3hX/DPf1vND335XT2Z5fSgdoPRL6QCDZHDrQJd9QcXcfHHN9H1FrjZajA1wHSlalfoLHQK
 gfnBu
X-Gm-Gg: AZuq6aIu0Fe79iGM3jYGAV2oKd5POj6uAd5vZV/WOwSD1kPxtHKSxHtN+KBmoschBgo
 sjcqe7OKX828z8NoJIiJWG4gjQKIKqLoFIdCyxYf4mG6exnpU0mtAK30vn9v739ZZJJXvw9uWBw
 0yM9mhU//RD+pVw4iPMnhyXv96Uf8yWRsitZx6oPyAavweo72+UQZiUebR9oqemFhfdjfNJpj4R
 obl7EAvPTd52JlgNfODo3IlqwczJpkpq69PW5PKHKpPHrbZRDAVpO1vf+70XGltlsKjdSP7sN1y
 mQAmlof1WeQfBAs+Uu8NjZjeCmhtEMalGFz9uV6VSEwezUdrAmdllG3V3uKpZ4JZuOwTOse3GZp
 uKBZ8Pv4cS1AW/fSu6ufIrjUDfI8HsxGqzpS6dFCSFPJR6FtZRLwYcmtz9SUvMFx1bKwpI0H8oD
 JHzGoWkb68Pqzu2Q7qTI4xZKEhr51v7PPRKhuii+1PGK0gY12f/bwXXqk/7bu2femT4+5zu7Au3
 dZ5DlabN2d4MTUEbe6lm8g4sEEDUeIJAJgRRV93pg==
X-Received: by 2002:a05:600c:8b56:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-4836570d1a3mr44082035e9.18.1770909179766; 
 Thu, 12 Feb 2026 07:12:59 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783dfc55dsm12582663f8f.20.2026.02.12.07.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 07:12:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional: Make sure test case .py files are executable
Date: Thu, 12 Feb 2026 15:12:58 +0000
Message-ID: <20260212151258.1750268-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The top-level test python scripts in tests/functional are supposed to
be marked executable; "make check-functional" doesn't care about
this, but it allows them to be run as standalone executables to
exercise a single test, as docs/devel/testing/functional.rst
describes.

A couple of files have got into the tree without the executable
bit set: fix them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/arm/test_aspeed_ast1060.py | 0
 tests/functional/ppc/test_ppe42.py          | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/functional/arm/test_aspeed_ast1060.py
 mode change 100644 => 100755 tests/functional/ppc/test_ppe42.py

diff --git a/tests/functional/arm/test_aspeed_ast1060.py b/tests/functional/arm/test_aspeed_ast1060.py
old mode 100644
new mode 100755
diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
old mode 100644
new mode 100755
-- 
2.43.0


