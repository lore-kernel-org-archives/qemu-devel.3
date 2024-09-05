Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF44CD6E56
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFm5-0007rI-Eb; Thu, 05 Sep 2024 12:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smFm3-0007q2-G6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:55:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smFm1-00055I-W8
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:55:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42c7b5b2d01so10868185e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725555356; x=1726160156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TqCQOWtX6gr9Wrl2yH2SPZFSZsUhuq+Hl9Sn5uRRLVU=;
 b=kMAmlKar1eVgUIUhGjd+a/W4jq7i0jE9CXyY1Lo5oQtK9YcJtOq9lRvsEzrtQvYHE1
 c3MuORmVj1fLlYqLOajyTI/yyqRnWI5BZ7iyvc3fBeXOk8W4jCizidcigShske63ejxJ
 sKMe/03+r6VwkiutOcd34NUbKlkok2O0Uetv2gM9oZwUcQ8fsMj8EsP0eTU/9SO5xlTc
 pIV5kCA3wQyHyo5IdRts5vkB7cWIuc/E/odj15c8PnduFE8C51SRqOm1MO34Fu3lcRDt
 X2qS9TlleQVlVbryyU2sjOuhEkaADJcaKwn6GJqO0ytjGByjzLp2sqO/zj5AudlBKsuN
 K8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725555356; x=1726160156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TqCQOWtX6gr9Wrl2yH2SPZFSZsUhuq+Hl9Sn5uRRLVU=;
 b=Guk+lkNEAwMtlWBvFpd85tN/bBPQ5MaLVbKaKsSuzulnDp5BM0I/5QTh8LkUK35U6i
 Kiqhb+PSH/lANO8d8fSyDCVgApOGIlqjiMFDSImY/Ck06s05LsvEZMtcmXwkG+/DdjsJ
 KI1ndPtUtS2sE4jx3dz7VVzXU4Pe1rr2Tz5EVUu+wwgC6sHwi65RPFZKD3X6BcP3JxYf
 vjtdIBNVj2lu9xNINSiop7dHmmXEv+4cJPIoleqP0oneI50OKZSQqNT1s9wVE22sYbDj
 iR/loh5Y3tBc4UXVGawTmCxICck0ckrWJExjEVFLZPOB5iHy8C3uzhBlcZTjRjTo32xA
 WLSA==
X-Gm-Message-State: AOJu0Yz7SR3dPnC6ixhl2BJ7ctsHXWHrbVA4Kkw+NstteLg80SgrQHrs
 sLYy4PfnzJpGqBDRgNd7POF4L7bHO6OwL4Zk0ySBmRZ4ieBxWy3Z5VnXmV7TQjCQLFjbMzbzVhG
 F
X-Google-Smtp-Source: AGHT+IFCuJhKbHlGeubDlhg7C+XEmj5er7sr1Rxfxj2qbo+ZBjerPbbLfq7q+bTK4bVXaQpb09u7mw==
X-Received: by 2002:a05:600c:1994:b0:426:5269:982c with SMTP id
 5b1f17b1804b1-42c9a38b28bmr28840665e9.28.1725555355802; 
 Thu, 05 Sep 2024 09:55:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbd1eee1bsm206914925e9.9.2024.09.05.09.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 09:55:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] tests/qtest: Fix problems running with make
 vm-build-openbsd
Date: Thu,  5 Sep 2024 17:55:52 +0100
Message-Id: <20240905165554.320577-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

I noticed that 'make vm-build-openbsd' had bitrotted a bit:
 * two tests for the stm32l4x5 forgot a qtest_quit(), which meant
   they would pass all their subtests but then timeout because the
   underlying QEMU process never exited
 * the ahci-test timeout was a bit aggressive

This patchset fixes these.

thanks
-- PMM

Peter Maydell (2):
  tests/qtest: Add missing qtest_quit() to stm32 tests
  tests/qtest: Bump timeout on ahci-test

 tests/qtest/dm163-test.c           | 2 ++
 tests/qtest/stm32l4x5_usart-test.c | 2 ++
 tests/qtest/meson.build            | 1 +
 3 files changed, 5 insertions(+)

-- 
2.34.1


