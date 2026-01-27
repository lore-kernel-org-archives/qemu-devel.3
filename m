Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE651D2F000
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhTG-0000rC-MF; Tue, 27 Jan 2026 06:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTF-0000ot-2m
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkhTA-0003wE-Rd
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:42:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso32450365e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769514163; x=1770118963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=67U4LolodJLAq86g7XVxrH3EV/UqE104BY4faHE3qgY=;
 b=pEv4rUewTKlM+wYH56RaQ/v8fVkVM5Iq0CmmWejzhOl/yI4dOYs3b6zFRiUI1MMNHP
 bvmcQiTQKRWbctXLaRxDAwOjoeVy5Igbo4LqybaZfZqKnM8nSdtLpfP89F0fVznVnxH2
 dQBv5DkQkTYj9ivWjdOUBGRx7UnwSvbzjLyA4HcQ6jlXlgm2GjXIgnOZ71VIFuuhdfe8
 GKjCTPFIB5JvUoDltFRxoZk9YgdBAMS4ccfD+i4ol0aM5SDOKgKJwipbI6BvwM3AcjEE
 hXlybgfxVkBBLto2YmZ9jH+6r4cuZoq4+SORQVgw90pYeGVpgvkg2ejXj1AIzSZt3vXZ
 Biwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769514163; x=1770118963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67U4LolodJLAq86g7XVxrH3EV/UqE104BY4faHE3qgY=;
 b=wsxPQpt/HqDF/bwWDHuECUbeAGRStrskheUCT1lMxkK+M2YyPLuhgOe0quBdNvDLQe
 qx5FptIvkdM0Lopbe+nqeKeYiUR8Cpp2I64Uz5kA0ar3GfW7zwMXIIYxjfZ4b2s0DE4G
 eP9viD0IbZpcjtY6AC9WjPMAur5QHIZ801ld/dskUPpqP+oonXgTm7tUVPWGRk9OUyro
 JjJN88S9qZu5WG9DV1hU4YDmMBKJrsthDLFs+zdajP0v+0qH6pzhNi0l3/wsM9TVRdaQ
 HM3OIqyyjyFvxdsHUeFi6Hks55rbXqyEBlshd/CyJBN2V/U3YuV6IzAUNJyfKX0oQ6nu
 3D2A==
X-Gm-Message-State: AOJu0YwwBAS1JAh6Rj2zdOzLf5o+Du+fP/66afXHQMWnzqc6NtznX0kP
 54Uiv1luR8TAxoDxm7S5KV36ohJE7UFlIDkiRHExKgruNnSEKti7nMDFO8UV/sdn7KrMEkUZMEF
 5KT+VBF4=
X-Gm-Gg: AZuq6aJiMVN8ocVHy2DBJJA3jWOCyZJq9abbc+yPDFNxI0xVtEIsGRdM9D9F+rmpW5x
 VAB9/+c1xb/9+NvMfnEt9EgdukdJv8xWeXRr8lqKlQwIewGaazLBBAIwSf+5ijkWqEJngVn1sGJ
 B2jdAwaHotQWWWBxchjPCzGCkyymgoG9QT08qhxYvxHiKwy9gkv40QgNc4rCyGsXFSvmmpuOXc4
 4kr8lbrwRAvWsfDmtB25LLGz2QkZk23Un49STCnSGkJTtGOpQrB63FVFKT7Kr2hYrej3OwclDPq
 d/btSpLnVn6ded7pPow+qNwZJIXL//TWs9tejz7tHzYB91ZckgHOfuVGtCr7KteXDpuv4hPIl5P
 Mt0lOT7GSSbSTfTpsmOJI6xNPh3eCCB9B+EMD/mnyLKnt0fNO2pcChAg9yqpKX/AlHu+q9P9WG7
 EyWeiDZrCQaW4=
X-Received: by 2002:a05:600c:3b19:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-48069c5fd06mr14266095e9.26.1769514162811; 
 Tue, 27 Jan 2026 03:42:42 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7c9cesm38351644f8f.41.2026.01.27.03.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:42:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 674485F7F6;
 Tue, 27 Jan 2026 11:42:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/9] updates for MAINTAINERS 
Date: Tue, 27 Jan 2026 11:42:30 +0000
Message-ID: <20260127114240.3009791-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

The following changes since commit f26976b9d30496d28bd4fd045f4300706e567a29:

  Merge tag 'pull-vfio-20260126' of https://github.com/legoater/qemu into staging (2026-01-27 07:14:11 +1100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.0-maintainer-updates-270126-1

for you to fetch changes up to 74be6f8bc918cdc532272efcb002b9146bfecc78:

  MAINTAINERS: add co-maintainer for TCG Plugins (2026-01-27 11:37:35 +0000)

----------------------------------------------------------------
MAINTAINER updates

  - fix some malformed entries (names, lists, status)
  - drop Mads from HVF and Tracing reviews
  - add Pierrick for overall docs catcher
  - add Pierrick as a linux-user reviewer
  - add Pierrick as a co-maintainer for plugins
  - set linux-user to Odd Fixes
  - update core Arm to "Supported"

----------------------------------------------------------------
Alex Bennée (5):
      MAINTAINERS: fix missing names
      MAINTAINERS: fix libvirt entry
      MAINTAINERS: regularise the status fields
      MAINTAINERS: update Arm to Supported status
      MAINTAINERS: be realistic about *-user

Mads Ynddal (1):
      MAINTAINERS: remove myself as reviewer

Pierrick Bouvier (3):
      MAINTAINERS: add maintainer for docs/
      MAINTAINERS: add reviewer for linux-user
      MAINTAINERS: add co-maintainer for TCG Plugins

 MAINTAINERS | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

-- 
2.47.3


