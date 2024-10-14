Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91754D1812A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mxk-0006G2-W7; Mon, 14 Oct 2024 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxh-0006Ez-Qd
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0MxZ-0000vE-RS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so3823346f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728919572; x=1729524372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qO/4HKWHrVuc6GQ36ulz/Nn1mmzauBCzpX9YAoGCMM=;
 b=CtarFoZbgg2jyd1mPrDYklVrhA3Mp1hIU2xqNvGKmzCY+Pag2Uk8Z2blO0fID7pRyI
 8bQLTaYvbkVd+MjUKXZI5UaN6EuXNJ+KP8AboCnkJkWeUphAb8fC+eBKJCfPN98WoBo2
 +h2UzpP8ad/OsDdhp+u7ldZMJ6cRKze8cKIzkFuaIBszMEsk+Ak3HeoYq6WpNzS2+5Ys
 BSIiIg+mv3Et33sO+OVAihczwasPKXulaezHn3Mj04lGLsSVgu6zo4XHiBkT+3WQ2MND
 tBUNGEiR1Mb6MvkTmnc/AxYHrdiitMwKbknYLw1U9+ncgadsYftw1CMtDRPnthmQh0SU
 6LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919572; x=1729524372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qO/4HKWHrVuc6GQ36ulz/Nn1mmzauBCzpX9YAoGCMM=;
 b=G+gKKcnE1HhyS51ua7rNF7fYBZ2pvYHYcEmhnPSaUGcyLdfsITtwtFjHGNC9NUFU4P
 hNaUDH1IhjemjYQ3UjK7dH84nlQYVhkbnq3kd82KUfjigXw38+eD3hOo7IX0/KrxZxop
 da7hx7uLQylxHXlrePUxLIhfxAVvnVr5Ye4spNI39xHDdLuT6WE2OLI0MTN3AdUhpTO9
 wgRYf/T05uwDtIQaKr0K4Td8tmgAOIBtwI1wqvhC61mkW0w9MISNDJ889ZHLCHW0DDgo
 T3iYHClqLrlaa9UdZx5WqsIE2hUdDXB3mHUJ85zPmg0jB0ObR7pEiqYwTUPAPj4kxW0O
 FyJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIK3CYkfj9Wlr+PUYq4h7fX0FKl4Vs7IVfN0nhycu07TGO0AUaY57JPrRAwkwGCWfLSGjlgDP3OxnZ@nongnu.org
X-Gm-Message-State: AOJu0Yxq+/XvmdT0coS0KpnoFnD2ki6oQM8Rtb1Otfnz4lEoLPP76Ohh
 5XqAvlY0A2tEtR2BnTThKC2ztAYyrXUubSqwzq2sNs9U+ct2+yrN
X-Google-Smtp-Source: AGHT+IF+ivIgMofxyM1n+FLoNmRJtFRgrfpTFcdNKheNl4E3/jec6DDMLCdx7DTj3ctmPebozXnIUA==
X-Received: by 2002:adf:ecca:0:b0:37d:2ea4:bfcc with SMTP id
 ffacd0b85a97d-37d5ff4abc9mr7451308f8f.13.1728919571672; 
 Mon, 14 Oct 2024 08:26:11 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a13396603sm133689966b.169.2024.10.14.08.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:26:11 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] chardev/chardev-internal: remove unused `max_size`
 struct member
Date: Mon, 14 Oct 2024 17:24:02 +0200
Message-Id: <20241014152408.427700-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014152408.427700-1-r.peniaev@gmail.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=r.peniaev@gmail.com; helo=mail-wr1-x433.google.com
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

Clean up forgotten leftovers.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/chardev-internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 4e03af31476c..c3024b51fdda 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -40,7 +40,6 @@ struct MuxChardev {
     int focus;
     int mux_cnt;
     int term_got_escape;
-    int max_size;
     /* Intermediate input buffer catches escape sequences even if the
        currently active device is not accepting any input - but only until it
        is full as well. */
-- 
2.34.1


