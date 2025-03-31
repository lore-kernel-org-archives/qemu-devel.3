Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F67C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDss-0008RG-Bz; Mon, 31 Mar 2025 08:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzDsM-000898-Jj; Mon, 31 Mar 2025 08:04:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzDsE-0002jW-Ut; Mon, 31 Mar 2025 08:04:19 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223fd89d036so92609615ad.1; 
 Mon, 31 Mar 2025 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743422646; x=1744027446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e3Vflko7P43hQcWNkcdnjtMCZoIt3KeseCROzk0XT/Y=;
 b=DiQmksepPcGGRTN+kJjcpS1Wf06H029Yr5N+88lbVOgyUL1hWVaCXlyShYDg1x5KkO
 mi6+D1dXTT1vfPTIM3Y29W8AseGoms+//ySVWjjiN2Yl7a+BFihX6KMcRjfjOW8X1Hrz
 VDrjnj2Ede1L4ZQmOrNcWrOWzVZKcjKj68IE+oaUK7HVwpfQzLo58C9yNNCUGmcfbDha
 +Z/9/5L7wYYlfbw+4bSi6My4O6DUcPq9arNxaGKr8bS7s/YOjU00FgRqxCYPGABZVUxL
 hChZ4PRl+L8M9s8XDhdQQswc3TEtrDJcHnWJkFYbJLOwMRAUEK3TicUo6osLZDDqQ5Ws
 QqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743422646; x=1744027446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e3Vflko7P43hQcWNkcdnjtMCZoIt3KeseCROzk0XT/Y=;
 b=NrYxZ/FgE5HDWRjDcWOAs86ThfJqq6KWNT7aVIrjS8IegXm/pBDnoKJCGy2aC1FWt7
 uE/YVGfDfKLqI0rcQyVLEBWJx0mYDYrjJwWG1JsoeEQtz+Pu0uZFL7DW926h9iHy9FYN
 zRqCoFBnbUApCxhMbh5wBPHaw5h+YTvHetUI+yQ6Ssqf06ZpoRDx397hg8S/1tmyIWZq
 2Gk831cz87O9wXezrDpJ/C9yQZxuyo4ySh0p0yx5umB1oi2rGRXKZPK/PcT0DgJ5u0GB
 tS4ClheoUBlZl2KiD349sqqi3QmbobqiisodELd3lzTXkivV/VvmPpDJBFbvpszj1pS8
 curg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX11TEaChxPtHQB81TaWzfWJE4zmTmjcUzwZbj5pLrw6J+Ex6S0Co527lfbHzDeNxrW075/xopUHGz6@nongnu.org
X-Gm-Message-State: AOJu0YwxHXSLJSeGAxqw6DQu4lUAHuU7NTlyN4TVOEqY2CXo6dMvm0aC
 H02//Ub12n6mWS0uDJPibazntdUDotdnR2qv/buOCr+nNpKqYL+4weQfiw==
X-Gm-Gg: ASbGnctMN+eX8TmH7IZDQ/wLW2z08kEK+jysJ0HNRAZ7t4LG7X15WMYN2JfpPZnaKvM
 JoZ8o2fHOm+xdxwoIGs71s4unLoiT6cRxnEP3I6+bSxWmjzct5/0AjjhfeArouwovCvBNt4MODK
 FRE5h0b6xwtegk2opMRcEU7RNo69q9HEY+Ts3pgLz70/j4f+MSgUYdurk+Zrz7+olfnijpyKbVG
 bKWAw/fA4B8iB5NlEoZ/xN0v8NGjh9dGJB8/NuRgVRKO30FUmtimFfuu2BJR20Ge8V9gAm5j/0E
 v7JNlzIXpxe7kMcDN82o22NGS/0UoNECR58Gq9RT02yw+p3GhA==
X-Google-Smtp-Source: AGHT+IGf8IqTFvJXgG8237V+fXmgQfPXR+wx3uTQJ2kzNQGVyDy6kF7dRidEapIpJPrfCo30q4Jfkw==
X-Received: by 2002:a17:902:7684:b0:229:1717:882a with SMTP id
 d9443c01a7336-2292f946e33mr108576245ad.4.1743422646551; 
 Mon, 31 Mar 2025 05:04:06 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eedfde5sm67526105ad.78.2025.03.31.05.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:04:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/ppc: regression fixes
Date: Mon, 31 Mar 2025 22:03:54 +1000
Message-ID: <20250331120357.584561-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Couple of minor regression fixes for powernv registers. Minor because
they aren't bad enough to affect Skiboot/Linux (PowerVM makes more use
of these).

Thanks,
Nick

Nicholas Piggin (2):
  target/ppc: Big-core scratch register fix
  target/ppc: Fix SPRC/SPRD SPRs for P9/10

 target/ppc/cpu_init.c    | 23 ++++++++++++-----------
 target/ppc/misc_helper.c |  9 ++++++++-
 2 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.47.1


