Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D5C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 17:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiya8-0005t7-GP; Mon, 04 Aug 2025 13:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwuq-0000jG-0e
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:15:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwum-0000aC-9L
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:15:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so5124435e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754320551; x=1754925351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OgUT+NYtubqKmrBWdnKwxLf5SEkQ0g2Bbn27XpVNia0=;
 b=kxwgKZhpoZlgbU3WAprVHgLFzwwUMvb35wDN6Nu/mQvEWi5g3+gCPgvRbVn5sz1X0+
 EvWFj9lUzmKcJT2rYVa95yvM93iRW3xdmx7WpDfYoY/Jb9sukTo7Ec/c7GNkS3Jre/f+
 I6ODdhBs2YifX9rolZaY19RCBqp8vKWVPEsE6/AuAwb6b5t/xu7w0esYtBIsTw41e7vZ
 onzXw3JFLZcpR7ieWj94NN/GMScCwTBTF0MGJLakDTlfp9OZiUbTY8gWrzQ7I/8KdPp5
 tbBuslNBAXSPQs+2wnVlVXTRkyYH395sZvDWjOLkZq4yOtS6vPDpOT1Dqn9/9TPzRF7J
 Bsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320551; x=1754925351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OgUT+NYtubqKmrBWdnKwxLf5SEkQ0g2Bbn27XpVNia0=;
 b=qXEC7KKiM6++52RkHkGFtoqO/PoJfoslVELfnS8FGUxvS71Cio0F41a6c6tmqN9JrB
 uOQV8INxjnrGYmz2dNfPLWYYy6aGSRhclz/tRxDbUy8amP3acnLfgElM3sP1nmtSahT0
 yybEB4ridWMkjlg9caVuLXkLbhkQNyCmy0CxYNRpzvr6tJQZKuy+F9iHiRs6XtysEwsE
 KmQ2ioo9SIqyqv90ZqqiTd1toNrqI3V6icYLl65SMZD8OwhEiuimwBu1tjV2h8xQEAVh
 QD4CsaetiAZYVGb8LZN6sCk4VylJUl0BCvDrQBI9ASHEfTrJgci6hJc+UdhmWPa4xSHW
 4kIA==
X-Gm-Message-State: AOJu0YwCJafP4mx0JhPJDdoxo4k5mAc+b2Ttyz5StFdGrxr2CUxkL5L5
 f2LWrZIBpCsuVz+cYcqznyl+mduD0r9apHhNLX4W0nwVbwRe/8pFol1qSfWqow7vVWTf0h4gRQy
 wbRQd
X-Gm-Gg: ASbGnctJZSPNBwVte5YZgygDvqBhZMOPHSwTdvym83kPG4hYpr3OrETqiViH+T05tgE
 QMZ4FGEIIjQEC/62VUgPFN8IX4NfVUCInKkfDVAnbzh1LO77urdjm00oVI0nOfxJSAXAaO3NHne
 7Kq22oEKjM7iaSVjhoaoAygEDLf9Ak2Xdew/zhhsLZiaUq1KeRoDgfbaHDjiC4n1uzTFIRBabcv
 O5XLHB/cLoe9WcT2PBh3/UYRoUJ7HbHhoURzJT5h3iejh7t/vfkF8kUt1fWhx9J5Sh9pZrgJHKf
 heVxf3Meq2h+hBN/FTApxzkiXpOWSbfKh1yl7GAe9XAqI56ff/QLIezNVAcAUGdBvk1CSH7zl4R
 /GlY2mZ3LQ6wddQktuqb33mw=
X-Google-Smtp-Source: AGHT+IH9pLgSc8hHzlCcMa6sqrtlHiQHyjIpkMM1lJK7FlgTjwlOSWbRn3m/w8zt3Bemj4R3zrJ9qA==
X-Received: by 2002:a05:600c:4685:b0:456:161c:3d77 with SMTP id
 5b1f17b1804b1-458b6b36b94mr80932035e9.16.1754320550641; 
 Mon, 04 Aug 2025 08:15:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dfa64da0sm15985975e9.3.2025.08.04.08.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:15:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1014A5F88A;
 Mon, 04 Aug 2025 16:15:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 10.1-rc2 0/3] doc and testing fixes
Date: Mon,  4 Aug 2025 16:15:42 +0100
Message-ID: <20250804151545.311042-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

The following changes since commit e5859141b9b6aec9e0a14dacedc9f02fe2f15844:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-08-01 10:46:00 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.1-rc2-maintainer-040825-2

for you to fetch changes up to 61432e805e5028df0a3df5a76915cdc3007ecd41:

  tests/docker: fix debian-all-test-cross (2025-08-04 16:13:38 +0100)

----------------------------------------------------------------
Testing and doc fixes

  - add information about patch submission with b4
  - fix make-release script to include all EDK submodules
  - fix debian-all-test-cross docker image

----------------------------------------------------------------
Alex Bennée (1):
      tests/docker: fix debian-all-test-cross

Manos Pitsidianakis (1):
      docs/devel/submitting-a-patch.rst: add b4 section

Peter Maydell (1):
      scripts/make-release: Go back to cloning all the EDK2 submodules

 docs/devel/submitting-a-patch.rst                  | 40 ++++++++++++++++++++--
 scripts/make-release                               | 20 +++++------
 .../dockerfiles/debian-all-test-cross.docker       |  4 +--
 3 files changed, 48 insertions(+), 16 deletions(-)

-- 
2.47.2


