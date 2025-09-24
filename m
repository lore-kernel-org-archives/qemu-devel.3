Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8CACAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 14:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1QpK-0003dw-Nl; Wed, 24 Sep 2025 10:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v1QpI-0003dV-Il
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:50:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <galush.horowitz@gmail.com>)
 id 1v1QpF-00085Q-R4
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 10:50:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so5208824f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758725431; x=1759330231; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDBxiHv8MUFfVnrLIAfIHpy4Rx3PdI+dUCQiy9ka1bE=;
 b=Dtnvqvob8smJ7KG1arEU7mHis7SuYhInxmCssJOLVYPTqLp94C07BwHpw2FBBRBdKY
 VARLCstfqY/rnE+fBq3RcH51YlI0OFkf/zOjejyakslaY8eJCObY9ar9ssHTbuQ5asng
 qA7IzdtT5AR98NNL6KV1+elom6j2JRPlhBIMcrUE2uRUrcKTabIaoPu7+9IjhhRomKPI
 ra8eAG5fmpXNNERM4nRfRdI2ugp0S1n7K4rgtGdDI4Lo1mDc2FLvfUqRw4Q9YsOwhOly
 1drHJt0aMArUqQGJtmxk8JgON2EzuYtgO1vqhxdrTTVGxdrKIZrR2bV9RP7+3JMk0kwC
 DdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758725431; x=1759330231;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDBxiHv8MUFfVnrLIAfIHpy4Rx3PdI+dUCQiy9ka1bE=;
 b=rkV5R1nMSiGx2fXQ+podvmiQwA98rD5G62GWJj+keichoUO6qGEmNV0BKM9yJxhU1c
 JndtPGhzprMfju+fLOK4p2NqFRmi6qd1awJsR0jYmXPgNtbIx/cfkvvsvjqln26MXCir
 3F5y518LJfuWnJCA4QEYOflL4AXY9qAqWbSSaPq0G01PP8btubQzBk6ZZJAwgOEpqsmv
 LxoUXNgzPCb5Tl4CC2BEcfW4E3SK+xTRcAbRh/6V9uE8MKiDSd960ivPT7xQKEhdKStM
 b8qlEtFNVT16azXQPJR5QkwfjJzNvGIm65rdLOQs7pb8yR5T6uKLaf68c1S59C7GATla
 zbUQ==
X-Gm-Message-State: AOJu0YyH6OrzIS1/G/R9+O+AafjSx0QNmJ/UV8yG0HZit7BVqhFUIfCB
 yDniC3NI5xaEV9UHj6Ib47s/argls+Alk7ifCvBzW9PO20+9UToeJ1Q8
X-Gm-Gg: ASbGnctQZhOqHUqrM1c6h/zOD4tRP4X1LhNBKe+9LFiqMoMXucq/n3PlmuXh69AY0Pj
 FBUm4Jimmg/nYfyc4sKTROoDb4frd98G3wm4nJmxVgZRcdAtpXnjqtqYGSCvNs/vkX6VY5mrhUk
 vPF7KpEB4vw63Uf4g0RF4l86bnhyR6fySlYEhYoCjtZhlIlewocy/Ot7gNawqMs7fpptdBPRCws
 QnFbP2o/HD/2fT4Fddqqqx+UA0StMo8lmG8fXczd4FECS3W8ihX1o/zj1naqTChmJnOZCK7TxMD
 fRegw6FyhS6taKYMY8btHJhTYOTwKvL7rr7PQhy3ATpDbmq74t6h/k9WCPjtAsqHsAb2038VtEo
 aVC8/bgtuKj+GULPZJiNllzO90mid+rISuI8/pgEFieFP/8vMsy8CAF38w+IMdtonhxzYYKgH8W
 2KvfFD3Ljls1uU
X-Google-Smtp-Source: AGHT+IEpS1CuD2iuCbaJqO7fczgXTChjyMUkgJWlRMZKpRknJEUbAWRUW1KpFXCL42e8KGBtLuMmrw==
X-Received: by 2002:a05:6000:2507:b0:3e4:64b0:a776 with SMTP id
 ffacd0b85a97d-40e4bf00f46mr195595f8f.52.1758725431267; 
 Wed, 24 Sep 2025 07:50:31 -0700 (PDT)
Received: from GAL-PC.localdomain (bzq-79-177-159-123.red.bezeqint.net.
 [79.177.159.123]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407cffsm28188158f8f.16.2025.09.24.07.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 07:50:30 -0700 (PDT)
From: Gal Horowitz <galush.horowitz@gmail.com>
Subject: [PATCH v3 0/2] tap-win32: fix multiple tap support
Date: Wed, 24 Sep 2025 17:49:48 +0300
Message-Id: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAwF1GgC/4XNOw6DMAyA4augzHVFHoDoxD2qDiExYImXEpq2Q
 ty9gYml6vhb9ueVeXSEnt2SlTkM5GkaY8hLwkynxxaBbGwmUpGlpUihoTe8aJQChme/0NwjLHr
 2gJbnxmBTW16weD07jKuHfH/E7sgvk/scjwLfp//NwIFDjai4NUZwaat20NRfzTSw3Qzi7Mjfj
 oiOVWWBmTZK5c3Z2bbtC6QH4L4GAQAA
X-Change-ID: 20250920-fix-win32-multiple-taps-ed16ccefbd17
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Gal Horowitz <galush.horowitz@gmail.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=galush.horowitz@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently when more than one tap is created on Windows, QEMU immediately
crashes with a null-deref since the code incorrectly uses a static global
for the tap state.

Instead, this series allocates a structure for each tap at startup.
We also take care of cleaning up when the tap device is close.

NOTE: Checkpatch has a false positive on the first commit, where it
mistakenly flags a cast before an address-of operator as a bitwise
and operator missing spaces.

Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
---
Changes in v3:
- Split to multiple commits
- Link to v2: https://lore.kernel.org/qemu-devel/20250923-fix-win32-multiple-taps-v2-1-d497e5ac446f@gmail.com

Changes in v2:
- Add cleanup of the structure fields
- Terminate the thread before freeing the structure
- Link to v1: https://lore.kernel.org/qemu-devel/20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com

---
Gal Horowitz (2):
      tap-win32: cleanup leaked handles on tap close
      tap-win32: allocate separate tap state for each instance

 net/tap-win32.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)
---
base-commit: ab8008b231e758e03c87c1c483c03afdd9c02e19
change-id: 20250920-fix-win32-multiple-taps-ed16ccefbd17

Best regards,
-- 
Gal Horowitz <galush.horowitz@gmail.com>


