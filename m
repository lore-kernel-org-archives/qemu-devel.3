Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A3CC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBse-0007DT-Uq; Mon, 03 Jun 2024 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsJ-0006zf-Hd
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsF-00008n-2z
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35dca73095aso3880319f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437213; x=1718042013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgDjv/yNA+r/3CuM/gO8/vu8/drYzlHihSkbPO1TE7o=;
 b=t5753XUMbTFw+hSKdA4HaNFXFx3KYwt4ytY3SDbC55yma5FCRVUSZQ0ZBCAPGorkpR
 g4hdMCxeg4BwD18sYzVDrl1nuwnOYzLfS5oss2CQ+M5S3tK2L5v0kedz+byletTRpr65
 SsgcK1xKwMyRfufqdY/rvPVnlx82oWD6cugWnbWTV/QmN2cZ0A0XColf0ECw0oYPrL/e
 gyJNvLOFOmLDr9euv80MbOE9W7Xv65keG5H2Y5J04SNJSbraLzLFK76Xhq0vAt4iFIco
 4AV7gLcK0q7u+mHYU/sz5+lgqNHXgpsKlfdhNezFUUep7HQqWo/88N92VJSCTkaXiPAa
 im7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437213; x=1718042013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgDjv/yNA+r/3CuM/gO8/vu8/drYzlHihSkbPO1TE7o=;
 b=OJIbRU+qauaJOUCc5QKPPtF4iX3H26D/+4ZkcnVr/7nu29H6HcfY2qCQb3cbmGwxfo
 JyiQRIzwSViOp0h9CK7dsBzVg5FwpVt73gug98GfpfKUFS3HVco5TPhGRJYHh7kypwaO
 2MdurtybrVFmmQgEAcrm4gWDPJL0KNioTUF5Rv+pVxqd1vPmJHtI8kVaUB0nkWsPmTnY
 o/bZduvkM1pBLkdojwTGwsOMrNTN0x54S/qGsrbjxa6UL7ftqoKi9CtniEYrNAl/788v
 JL9mOAbI5md8AnHtLKNkrqciL8QkMmU8yTCxKr0lq7/sjFYSbAKSGzR7iLrGNSJDuIxH
 k5/g==
X-Gm-Message-State: AOJu0YzxLK+ckVxnkC2brC7Y4huJttT62It+McqPuvT6Uf7fNqlruCmE
 r2R8TX2ndp3Pt7sDTY5xFmka4iEdnVnZnUHZj4gBT+V88D28bIPQmAlH0f1GsiM=
X-Google-Smtp-Source: AGHT+IFPMVOs0cZxyUpMZWaqXcWqMLE7CRhMxhhqYX/DOQFE7h+Us9X/uZj47qK5TckI4QVw4nXhDQ==
X-Received: by 2002:a05:600c:4753:b0:41a:9fc2:a6b1 with SMTP id
 5b1f17b1804b1-4212e075ed3mr85037035e9.22.1717437212889; 
 Mon, 03 Jun 2024 10:53:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212278b24dsm85913135e9.0.2024.06.03.10.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 327DB5F9FF;
 Mon,  3 Jun 2024 18:53:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 07/12] tests/lcitool: Delete obsolete centos-stream-8.yml
 file
Date: Mon,  3 Jun 2024 18:53:23 +0100
Message-Id: <20240603175328.3823123-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We've missed to delete this file when removing support for CentOS 8.
Since the current upstream version of the lcitool removed support
for CentOS 8 now, too, we have to remove the file before updating.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240601070543.37786-2-thuth@redhat.com>
---
 tests/lcitool/targets/centos-stream-8.yml | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 tests/lcitool/targets/centos-stream-8.yml

diff --git a/tests/lcitool/targets/centos-stream-8.yml b/tests/lcitool/targets/centos-stream-8.yml
deleted file mode 100644
index 6b11160fd1..0000000000
--- a/tests/lcitool/targets/centos-stream-8.yml
+++ /dev/null
@@ -1,3 +0,0 @@
-paths:
-  pip3: /usr/bin/pip3.8
-  python: /usr/bin/python3.8
-- 
2.39.2


