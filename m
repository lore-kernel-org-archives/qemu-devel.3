Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3CCC49EA1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQiA-0002so-Tj; Thu, 01 Aug 2024 03:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZQi9-0002sJ-RL
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:58:57 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZQi7-000652-Ku
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:58:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fed72d23a7so49575455ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722499133; x=1723103933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cvSBaOjYUWst5lQGGF5lSfdqUi1l6xFL1uXDSqJKRIw=;
 b=AEYWDhDIWAoybsVtRsxCtRrqLQn8QJ6qwhSU+oSVBsUZY+nylupXwVHmtqyp/VarFK
 4Pl1TwCLWJTD0X/dMM1LnGE376tmiMkQ/mM1tCcI6Ilsy7E19kcZHhJwXC0ZlU5kYWjE
 lbjS+Jjq49WZu0ViZtovat9b8zKj9uH0Z1i7rKjWLdkuqvrXqvctrTZxF+oAXngu0Z8Q
 qtmoCage846k1lD6r4xWWojauHAsgiZNEmrk/XXTarrL0Ir+bDJ5RpCcgFFe/vWOAMsf
 6dd1HhuX3VWCiewBjbgN0VYwaT28v91g0bYUe4pFuRMCOcxNK2u9B18lddY+ktyWILqx
 LNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722499133; x=1723103933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cvSBaOjYUWst5lQGGF5lSfdqUi1l6xFL1uXDSqJKRIw=;
 b=RK+cpWx4WCQZ3/lKfeMjLVMMD0BwBju9BtrCuDhkVOOJ1z/kgNc/OFniFjCVimuQ9z
 YRxHHv2mO+VsMFLoi/5i+2XV3IEEqPeCqrVIWEdOjhLbHfdTtqVfoXNFYI1/sHjetchT
 wWYIFbbRtZySPBAlUqZReZE2eZT6J6MiO2t+Y3BQBnG4BgTAvxMowRBnyOaQPiAlspRE
 6Za0PUtnFGURFY1CHmluF87gMf3Jzx/UzoPIQHDGeXO1fGBXUtXTFpJnvgZZuAGInefJ
 OTrhWZYFysYPVGRFbiLDQWPMhzFmldb+cbMgtAqLCDPIhxhOvpzIzIvHqkxlWKjmWIBW
 3dKg==
X-Gm-Message-State: AOJu0YxM/aFQ0yFLzGjmdR9qAOtJCQnmnSeLtvxfjtBbGlSejT3Rn3Vu
 wmX3bm7JeoXnzIG2lUf/rwFfTvqmLQ0rQuoykS0K9m3wTJvVDzQ97XuqjxBxviESiRW4Sk5fkWO
 vXpNoTw==
X-Google-Smtp-Source: AGHT+IHeEDr5bkVT8/UGUdg1ccmY8kD0I0rOe7enxT8bzFcMFbudcvm0HRX+tHLERo0NdWKMQg7u5w==
X-Received: by 2002:a17:902:e54f:b0:1fd:7fe2:1f26 with SMTP id
 d9443c01a7336-1ff4d215148mr19649575ad.52.1722499133271; 
 Thu, 01 Aug 2024 00:58:53 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee148dsm132195755ad.144.2024.08.01.00.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 00:58:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 0/2] target/i386: Fix carry flag for BLSI
Date: Thu,  1 Aug 2024 17:58:43 +1000
Message-ID: <20240801075845.573075-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Fix #2175.

r~

Richard Henderson (2):
  target/i386: Split out gen_prepare_val_nz
  target/i386: Fix carry flag for BLSI

 target/i386/cpu.h                        |  5 +++++
 target/i386/tcg/cc_helper.c              | 18 ++++++++++++++++
 target/i386/tcg/translate.c              | 27 +++++++++++++++++-------
 tests/tcg/x86_64/test-2175.c             | 24 +++++++++++++++++++++
 target/i386/tcg/cc_helper_template.h.inc | 18 ++++++++++++++++
 target/i386/tcg/emit.c.inc               |  2 +-
 tests/tcg/x86_64/Makefile.target         |  1 +
 7 files changed, 86 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/x86_64/test-2175.c

-- 
2.43.0


