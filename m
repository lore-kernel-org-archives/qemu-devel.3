Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD71BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpLd-0006m7-6z; Fri, 19 Jul 2024 11:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpLX-0006kp-JB
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:16:38 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpLV-0005tg-SP
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:16:35 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eee1384e0aso27241231fa.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721402191; x=1722006991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=juUywzcruZeR8Sw6FIIM6mtEtRuZk97PZ7ZGojKT+QY=;
 b=SJ2TyNRregccXeYkb/Ij/ZKq+Qe0LX8NfIXiguiqtwymprWsOTSYQhBd2BWShztKX1
 wX8iUNM8F5gL9YzJbiY95wIK5AuYuVDKrQSBhssvAuzt5SYlkTki3BwJusj/S5UfW8C/
 c5QXtIumDGNmkySPgNEo/ZK6JUj0zPjYPo2gtPdjrsy/NrQMfobtCeuc3sSVD6MR6KAo
 YTCdfQvAWloBGnpncnZlXbkxh0rfaYpfPiMHi+ED+TCzBYb6JhJN4PNvuwD/LTAGhWw2
 Izz7bpQv1P+5Sy2pfnOyml3CPHbfuwCa0sohbDCKov+Oiw69x1VHX7/560L325Acbizp
 Glzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721402191; x=1722006991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=juUywzcruZeR8Sw6FIIM6mtEtRuZk97PZ7ZGojKT+QY=;
 b=oS/F7HbNourHmpl5eSIe+rsc8Kw6eRjoYmZBLalEaksA/erRXQlaLcjTAjE3cOSy0O
 hi7F14IBI5ucsktgTYKlQ05a6zsdfuNsKiSegrsPCgDyXjxk1bq3bFhIT1ZD436SWQAK
 c3a1ThrXeRkdM8q74xHotpwcGP2UHpSJo4jONJ3Ey2J5ItOJu9xBnJcHR/OlGFsg0S0Q
 bEbLeLM/QpIek0HmfKjODm2TAeOR1MwcmA4ox3rVe8TO8dIbXtZng532f+jGTFdnKkZM
 JJtz+hO5L1QxOlBRgsw/sZmWI0FpvEa0YP0++b7a3692/a5/2TMWmzx9kHWNkWWftOlo
 2glQ==
X-Gm-Message-State: AOJu0YwZTHES3y63L+CjvONaNH+VOJ8P7o3bLRBS/3/dkP6NAWogmHUl
 VzXBjGP0I8P+AoY/esxoIShXr/u4FNEtcS6upTLqnOuGLVJWRh4VUrQ8pbUlCkPaEtZrJrTlzOs
 +
X-Google-Smtp-Source: AGHT+IEP7NQmik8JaLLZ4WU3veGPcgx/lsq/knNLivx/xmUk0iaz7j8XCdvGyw6HlgrQmdaV5KZbVQ==
X-Received: by 2002:a2e:9bd5:0:b0:2ee:699b:466 with SMTP id
 38308e7fff4ca-2ef1681bac5mr508201fa.36.1721402191269; 
 Fri, 19 Jul 2024 08:16:31 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a3c159sm56237465e9.8.2024.07.19.08.16.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 08:16:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] util/fifo8: Introduce fifo8_change_capacity()
Date: Fri, 19 Jul 2024 17:16:25 +0200
Message-ID: <20240719151628.46253-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

Preliminary series to PL011 FIFO work:
- Clarify doc in qemu_chr_fe_*
- Introduce fifo8_change_capacity()

Philippe Mathieu-Daudé (3):
  chardev/char-fe: Document returned value on error
  util/fifo8: Use fifo8_reset() in fifo8_create()
  util/fifo8: Introduce fifo8_change_capacity()

 include/chardev/char-fe.h |  3 +++
 include/qemu/fifo8.h      | 10 ++++++++++
 util/fifo8.c              | 22 ++++++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.41.0


