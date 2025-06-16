Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF058C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 20:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRGC8-0002Ub-LL; Mon, 16 Jun 2025 16:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRGC5-0002SA-AH
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:12:37 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRGC0-00071c-NV
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:12:36 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so3291601a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750104748; x=1750709548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8dpPuIQm597ppmYcZK6ONNClkflv0azexsjBdfcITAU=;
 b=a6s9H/iHvqL5sFlK9GmVTWpeLA+2uuaHDaGnC4GbmUliSpJ6nJqOlIVGxmHwxbxpdp
 XRI0MbCReou03alRR0eUYNOROVdvF6rwSZHDSZCiIltd+130S6j8RYWegXw116yj1nL7
 Q1RMnQ51Wsudz2jSTXiAOzJj5T+4dpcMOqMxoPgC+bks+AjsDHcVWUgsXj6J/9dnMw6X
 QgGfEowPjvm6XjEh9j+pUOCDIup4bKKvumkPE81ovS+dcUUcBBvpZ088ziTN0WTR9w14
 6eeMgJBPa47PoCqL/oyOHOK0qSG5lspSVCQWwVC6q/QccFItJ1oZIkbJvaGFuAALtv/U
 +vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750104748; x=1750709548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dpPuIQm597ppmYcZK6ONNClkflv0azexsjBdfcITAU=;
 b=S2oqV6zDwzsKsFB1+s3s+Q7sAGeodHH2GNdYcTwxz3vuD9u75LeW7keBoY/JwlP9TI
 aXd1tTnxWGtcQgyXw+sQeSv68+fiNoH0c3gqvYgZCsS1Uf6+LWpqgq+mLIuBUXKkfQW7
 7QDdYHy/tGOj3ZAb49RrmlbdzyMIbc1lXuYn6Xmc9jWQq0Z4m6uGq/i/mci/R+2QmYLn
 QFAxBHU9zHNeFoqv3/07qBqZSFLYGUVvBWL+qbIr631mmuWdq8yfI4og0SXV87IgW9AR
 SoM+7faLze7fjErQlotYIp8Hedp5lGvibo53Q/brmsaH5G9E74S5V6KQCXUxY2r9sLnN
 Hu4A==
X-Gm-Message-State: AOJu0YyUc0Xb/KVScOmsG/QehzvcPteIxXP54n4KMadHn7HrGAhvicM7
 yKZqjfvw5DP7LYPH5sBvn+LcUretPQM+3qpwGVg1I2N5bPbJYkB9QyoGN7qXooS2aLjR2w==
X-Gm-Gg: ASbGncu9DD1lqK1fvk/l7XkHdy/yt83U3ucQyYgfJQE8s15vYJSJWGKuXqRBb3RhbuD
 a7sjX1Zllbj/KCLuUOiOU5lXFVUOPZ2WbXnwX5ooMUun1VBFZAaXYPN5vSSf7Wv9e3BBmVSswZ8
 ELO+23CdZVm0YZnBYK58JJUGGNSPeZbGDB2kWxrVUkEIMYS03t6pU197shn/J9Am434363RMQaP
 AqyUwL1DDpvBmmlgr0WOoIjbz2NdRsuIQALFZUYBUpUC8Gu+PM/C5JZhGVs5HAFaDSml6PLEYSV
 w6lYrld0dhv3cNhclFbz9Blvt6+6vE6ix3V+vOlYyQjCVM/++TkCQNzMB6Svw3bmybUYqH/Se/T
 8Tg==
X-Google-Smtp-Source: AGHT+IGRbkk4OnsviAjT10VTMOttBHYZ/PyQ9S/WqLKagWq5K0LBFyHWrb9D1Q41dnExJJTiRD0EfA==
X-Received: by 2002:a05:6300:4041:b0:206:a9bd:a3a3 with SMTP id
 adf61e73a8af0-21fbd63496dmr16758585637.24.1750104747984; 
 Mon, 16 Jun 2025 13:12:27 -0700 (PDT)
Received: from ubuntu.. ([49.207.59.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe1642dfdsm7369494a12.18.2025.06.16.13.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 13:12:27 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 0/3] tracetool:cleanup "if(true)" check from trace_foo()
Date: Mon, 16 Jun 2025 20:12:19 +0000
Message-Id: <20250616201222.6416-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series of patch aims to removes the leftover if (true) condition from trace_foo, a remnant from the TCG tracing feature removal.
It replaces it with a proper trace_event_get_state(...) check where necessary(for log/simple/syslog and ftrace backend).
Additionally, this change centralizes the generation of trace_event_get_state(...) calls into format/h.py,
eliminating redundant code across individual backends.
This cleanup results in more consistent and less repetitive backend code.

Tanish Desai (3):
  tracetool: removed the unused vcpu property
  tracetool: introduce generate_unconditional
  tracetool: remove redundant event_get_state checks

 scripts/tracetool/backend/__init__.py |  3 +++
 scripts/tracetool/backend/dtrace.py   |  3 ++-
 scripts/tracetool/backend/ftrace.py   |  3 ---
 scripts/tracetool/backend/log.py      |  9 +--------
 scripts/tracetool/backend/simple.py   | 11 +----------
 scripts/tracetool/backend/syslog.py   | 11 +----------
 scripts/tracetool/backend/ust.py      |  2 +-
 scripts/tracetool/format/h.py         | 13 +++++++++----
 8 files changed, 18 insertions(+), 37 deletions(-)

-- 
2.34.1


