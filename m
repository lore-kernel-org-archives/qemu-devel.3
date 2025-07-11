Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA7AC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 02:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua3KS-0006xn-L8; Thu, 10 Jul 2025 22:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minglei.liu@smartx.com>)
 id 1ua3KJ-0006vf-US
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:17:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minglei.liu@smartx.com>)
 id 1ua3KG-0007b1-DG
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:17:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so1756539b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 19:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1752200241; x=1752805041;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uTgZ5bnnbftU8a8Cml1e0AOlXjJTra28u9pHp1iziwo=;
 b=cUN0MmZw0C7WeJP5U/ORxgqiY3nj+1P/K8cZ7hwhLkhMCmLxwWXnqRFbs+OrmjrsZW
 U0v8oImr1Rb/EklZAndvvTv22ZZHQnlSQ8xhZpGmaD6EuWILP2Jh/W0XWPatvPRJW/sL
 W2P32+96sIKTkzIx+IUOzFO5r8iuDKCwfs0JaFwQ5fF4twvuY8wrW621CBOgZHJA52EQ
 EU4A3jFUhZczfnH0DJ9JKkdpp/lP8NjdrqFhahIDAqj5gBOpzNYh3QOLhAKqcTNY/0Sw
 Vx2kFIndDY6G4rS/svpM37tE1imQiZPKYUOzffjmcZHmX+SCzmuqN7/XnjCqzR16Rhe8
 CRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752200241; x=1752805041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTgZ5bnnbftU8a8Cml1e0AOlXjJTra28u9pHp1iziwo=;
 b=vTfTtuht0toZ0A6bTfKFxoHoFUwJW8vLKuXTttURnWPl2ri/cI5CCgIRbRHhUD60AR
 8wOIQSDuouVzQBZDI/K9c3Ah0uHfIU9ZrUW6zJF6ds460PJJwdAaHckubUOXRNj/Cp+n
 oc3BeAFb9T2Yd5Bxj/aXsYT0Mhe2sofsE7dqSwqQw/PraRXgHfP44x5YnCgzdPh0DVIU
 gdiNnZ2TYIytO2ITD10W+CxBjYE1v2QHApRFllS6TNqJNG8NQQlib8Vy9pGJMMnyxCyq
 nKCNkYHtm9m7S5iv+DsPdwjYRUJ32o3vA5e7YnaUXvdbBM4HoyK58N+OoVWzP4rjO3L0
 /IbQ==
X-Gm-Message-State: AOJu0YzW6PEtu6r9PT0x0V+5iw7RQ+YDpVk0WHwmLDJ0ZVTGDX9BnCZx
 eKThR3YyDqUEIRFpQyJ/mFZWarzKI7jHuhTtMNbhHIIqWv03rXhC35zK5zaS+XboS38Fjn37umt
 ZxnA7Vy6lDcjj
X-Gm-Gg: ASbGnctajb8JtArnE5qzQysX6N76Vk50eMx8a9cVyu9UzRI9PAKxBtygHLS9288Mv5d
 nosOwAPAWayYai5fPMqxLUj4muMlgBgA8+qPuCv8EZG2AaGCEqRb+iwuW1kLOfiV88qLGvCb9Na
 jIkuthF7Z25xRxpXqgAfjGyrOtX+XLuIZBvbF+bGV4iMgrCr0W/HitZSpooV3a+8Oob2AwFgonT
 kNRRRatqVwB3K6ToHjDxz3qI/cHPiBrqcCfPzzA68El1/M8fA7udQtA3RtdmfiPYH0mcKbmatC+
 qK2OLmDG0FTzazF8PieI8tE4ilY+7hupPDD838zb3gerdzC5T0IiyrzB51yu20mT7+L705y/Vy+
 H65ytJDTUB6ya0eBvukoItku6FcX8V2/l24TXePvw22Zakg==
X-Google-Smtp-Source: AGHT+IEdSYK7T2ZFmDz+7hUeesx1q2MJ7m4Dwg5YvuHn7avqMui0R6wH57Poh7C6ZmB4C9FbZsw28A==
X-Received: by 2002:a05:6300:8d:b0:21f:62e7:cd2d with SMTP id
 adf61e73a8af0-2314937a8d7mr1940453637.34.1752200240583; 
 Thu, 10 Jul 2025 19:17:20 -0700 (PDT)
Received: from localhost.localdomain ([125.69.0.79])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe72913csm3569517a12.72.2025.07.10.19.17.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Jul 2025 19:17:19 -0700 (PDT)
From: Minglei Liu <minglei.liu@smartx.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 "minglei.liu" <minglei.liu@smartx.com>
Subject: [PATCH] qga: Fix truncated output handling in guest-exec status
 reporting
Date: Fri, 11 Jul 2025 10:17:14 +0800
Message-Id: <20250711021714.91258-1-minglei.liu@smartx.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=minglei.liu@smartx.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: "minglei.liu" <minglei.liu@smartx.com>

Signed-off-by: minglei.liu <minglei.liu@smartx.com>
---
 qga/commands.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index 5a5fad31f8..5f20af25d3 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -205,13 +205,15 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Error **errp)
 #endif
         if (gei->out.length > 0) {
             ges->out_data = g_base64_encode(gei->out.data, gei->out.length);
-            ges->has_out_truncated = gei->out.truncated;
+            ges->has_out_truncated = true;
+            ges->out_truncated = gei->out.truncated;
         }
         g_free(gei->out.data);
 
         if (gei->err.length > 0) {
             ges->err_data = g_base64_encode(gei->err.data, gei->err.length);
-            ges->has_err_truncated = gei->err.truncated;
+            ges->has_err_truncated = true;
+            ges->err_truncated = gei->err.truncated;
         }
         g_free(gei->err.data);
 
-- 
2.39.5 (Apple Git-154)


