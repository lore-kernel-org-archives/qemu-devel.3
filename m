Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A0C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 13:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQFG-0001Js-7Y; Thu, 16 Jan 2025 08:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangboyang.id@gmail.com>)
 id 1tYNMw-0007za-P4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:44:58 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangboyang.id@gmail.com>)
 id 1tYNMu-0005q2-VP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:44:58 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so1365614a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 02:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737024295; x=1737629095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b7M6a+QRFUhW0+lJkp8rK8ltbV0q50Rg0edDr8j7U5E=;
 b=lzO8ZSQx9fdUYzzbRSwvVI4ULu1eAiWtHDJhooVcSQTPAoInUfY15iiQCyZzrDvuGf
 t5sDUZHLackvSO1aJekTclQ5oVKJWZ5SejtOub2U8+o2PZWmq6lUYrfcWCYUrmdUJ4lF
 /Q6uMRjtus3NXn1mdS+4m9k3O1VOaJXZIzwpcdonj79ZU5ZCxPdKod0V2ShZ/U7Fe3uC
 AROR9gJ+VbMlFj5EqKmCzqOOOjQt7X25r+3wo4rF3ykBMwQkNEtZX8on+6D9dY6aviJM
 1iR6BdUpthJsg0pXL+Ux9dSSe+ZRgisuE2+5eVSe3MRGMeKG+yX0hNRpKARyzlMmqRZS
 hC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737024295; x=1737629095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b7M6a+QRFUhW0+lJkp8rK8ltbV0q50Rg0edDr8j7U5E=;
 b=KZDBmEJF81jkz3lFOO+GHacK+d17J1OPduSYrs4FwPZ7UT3W9VB35fmGbMcwd2F3b4
 0V6ur7PwTEPPgG2PXQlsvitvycKRASaFOWUwIohx9KX2Ypq/pgSDSRxK/Q6WGObZO30v
 AraIxofr37d7cSqZMpByVaJESriGQPVzgbh14kiQOr6GKyRrpEZA72bBvXFGIUkmYzya
 J/EVYwgS2mla0mlBDgwLMKLWUK9DPkCo1JJ0Khib5IHrLN1fc748ea+DqRAtJp3Xu2zS
 KWDYun35FEgTgSWO9WvgpeyOw4GfHdxrj+nilcDkeUsgqpFDOyox1fvtL04Pl/fXEHS0
 vrvA==
X-Gm-Message-State: AOJu0YwS1JXACH5ZE+gAKk5o8gIdsb/us23OxAMyplIxSa8TsMWFaVye
 +Kef89UvW9ZSe8c1Uut3subSAzqY42QjZw0Kd8Gcue9ud54rhdOMPbH4aw==
X-Gm-Gg: ASbGncuPtiACFS3T1DKcx3YVOb78UK9C32iXezSr6zf6Kg8dUyjLC2z5WAZT80AhXST
 C8xpDdZbd/6h5Ee7jq8nzqxMjpJ5/lji7IrTRdaXmDfYQ5MzDyLAj4YM/OZ5zpB9TTaNP+KT1mu
 opadI98R2//FBDBD/2nNpxGphvMN4ry0QmHDd1gUeVsRtfxlxo5Djrzr5/VFJFDzJL01n1g0q7Q
 kugeYchkm7qm8HlA6mjn8fS/vIR+rMQBN9QdNov/Z//t8QpUL/tdIsV1+dSUaIMjGWkkQ9tPPp6
 A19g/CjBJ3F3motS+rqWDncjnYR0QHS9ySZ8z48/YDAUs46lLpc1Qm74AcM=
X-Google-Smtp-Source: AGHT+IETJk2baRgkmG84Cc+SvcvkD3qp1zqpDgfvjG5VWLGsFppqdLGSpeU/A1CozsERIuZ22prDXw==
X-Received: by 2002:a17:90b:3d47:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2f548eae904mr51095015a91.14.1737024295305; 
 Thu, 16 Jan 2025 02:44:55 -0800 (PST)
Received: from localhost.localdomain
 (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10e0c4sm95153885ad.24.2025.01.16.02.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 02:44:55 -0800 (PST)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH] qapi/ui: Fix documentation of upper bound value in
 InputMoveEvent
Date: Thu, 16 Jan 2025 18:44:33 +0800
Message-Id: <20250116104433.12114-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=zhangboyang.id@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Jan 2025 08:49:09 -0500
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

The upper bound of pointer position in InputMoveEvent should be 0x7fff,
according to INPUT_EVENT_ABS_MAX.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 qapi/ui.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 460a26b981..7b18662018 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1133,7 +1133,7 @@
 # @axis: Which axis is referenced by @value.
 #
 # @value: Pointer position.  For absolute coordinates the valid range
-#     is 0 -> 0x7ffff
+#     is 0 -> 0x7fff
 #
 # Since: 2.0
 ##
-- 
2.30.2


