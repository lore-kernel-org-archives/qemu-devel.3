Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACF2C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbS-0002n0-Li; Wed, 16 Sep 2026 11:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rb0-0002Ig-K1
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:58 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rax-0001Wv-SH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:50 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633cd80so508545f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572646; x=1790177446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dM4u0r6eILzCbZESrBWVF/DDnjUwt9qXh1+CvKMqj6s=;
 b=tqT6fIFzsTg/gDqzfEZnO0iEP9sWwluipfoqMTIzSuGovRu2o00nqr7Wrwar03SY1M
 v4nDRQKXmttnJpMeJWgM0Z33VyqUhFzP0J6yuPvtdrvX2EWaC4CzxGGA2KmoGB/m4DHI
 Wmgr6RQlVw6ihWFgT4LSqlVvLtN4C6ueK4Omi4qv0N6moulQZl7NPTKEn6GaNc0BT/TQ
 WeX3+qbEzMu6WeJg/PYsumRsfCAIbkneSFivEnU09vF6l1LiFCFEOKLXc1+QqZ0q6g6a
 fzE12+LNgIB17RT9GebXWPsvG30XOaZrcsB2+2lQRCuBUav8rck8rB6dyvixLbtP9n3g
 Hkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572646; x=1790177446;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dM4u0r6eILzCbZESrBWVF/DDnjUwt9qXh1+CvKMqj6s=;
 b=eeGgbs6AiwbYKqWOW7TK+7TipmFw/E+KlEuPfyQW9gaubXI/SH7TZV6hNqqsN1gz4t
 rp+8SibA0tCkAt5a0x327ZN3odaXF1j42ayf977Eyk9F23zVOQEhi3cNe+JffuCz5oQ+
 6/kkppLEPVRAUlig17Iwa8GPAjZi306QRJFByWNZNumjHmEYndvARtG1O0mt5k9gDAGs
 UL+0i8a8gPIvfhZpY18HPH8XY2IldRTmUXGZ91MQFijqiLBg19olg0QH0aFTiS6ZQJs7
 lqzptnbOrmPpbaCTWZlUiv9hArng5G+/rpMbG20q9zozMpRX2aWahl3FqvVlVmILh7eo
 pDGg==
X-Gm-Message-State: AFuF++ltvyawP/mGxniYuJKiKDssW1CjNbvbNVYNLtwUddR3rHghKvLL
 IFfVTwVbfN7+mcT+rxKZOSf0ZXrL7Z+8utgVEHVrSBvSO1lVdht5ra8iN0lCK1td6/M=
X-Gm-Gg: AYBFou3tL1sa9jSmzXaFztD4DoxW04N4bEugDfBeVXZ0lSrVVfilS0k1muWTnYpEcVj
 HRNZHKKEvP38uZT25zLnPW6aqcYMMydz1SXCyscYKxisb5FVhcqHXnBQzZp0nc6A64HzF0YeLY2
 dBHoHkmBt9fFgM3w6d21qV0SbBuVKfkCXkF6nbpZraoY/YqOC3JWmGjJkZls8Ji/lP/a24SM0eB
 7T/faDZR0Y0v6l+LOycxsQdPtWAa5iSnl7ws07kYGdFQ2WdPliPADl6+9WdXJgm/7r/zL6w/sSk
 k/EXxdz8P5JDIIif4u/pVM1FiCi7xQF4pY02fq21ym8v2Yfus3gf1WjuboWGTuupoJ8ezgeAmC1
 U8QrM7U4ZAsyVS63gI3yz9VQtlu1N7vgncehkw7NORtawTJQ5oLr8OA9s5LF7+6mJ/kboIvTHbP
 TF/Flu65YW0S5CGwPgDV5oFZQSxDV6lxrSrMdwBG1t2ji7n88ddJri5J+GoCK5Y8IyTP37j7qt7
 wj4kDAtVg==
X-Received: by 2002:a05:6000:41e6:b0:487:981:4e0d with SMTP id
 ffacd0b85a97d-4870cef12ffmr3982043f8f.19.1789572645987; 
 Wed, 16 Sep 2026 08:30:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf342a0sm7668898f8f.24.2026.09.16.08.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C036161A0A;
 Wed, 16 Sep 2026 16:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 15/19] tests/docker: fix brown bag typo for docker-ccache
Date: Wed, 16 Sep 2026 16:30:08 +0100
Message-ID: <20260916153013.2134555-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 85825d74dfb..fa873e09b4f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -197,7 +197,7 @@ docker-help: docker
 # Where QEMU caches build artefacts
 DOCKER_QEMU_CACHE_DIR := $$HOME/.cache/qemu
 # Use a global constant ccache directory to speed up repetitive builds
-DOCKER_QEMU_CCACHE_DIR := DOCKER_QEMU_CACHE_DIR/docker-ccache
+DOCKER_QEMU_CCACHE_DIR := $$DOCKER_QEMU_CACHE_DIR/docker-ccache
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
-- 
2.47.3


