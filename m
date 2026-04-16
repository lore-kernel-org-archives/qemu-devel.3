Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB4FF8A14A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrC-0005Pg-Vm; Thu, 16 Apr 2026 05:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqa-0005F3-TV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqY-0007mF-F3
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso78446775e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331032; x=1776935832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=23Oy57xs+bclVlMhemFNB8YHTiEX+rZeE9kF1B0kY2Q=;
 b=SCu1P8FCWcFpthVn1pllWKlXG05OqnS3QKZlHQE0I7ccOf6WNaQTnAEAZRBQhHn/Rl
 Tz7W6IKqsA5AJIWcaAHeOHmsqn8xJLNujE/O7R8LG9f/GWGuW/Zde3xRbGaAQhE6Dm1G
 IrGCmnH+0dIulT6qWoNQK/Qjl7S25COIUejS3+kgFALA8W3+cH08OGrdPjEGAlHZnejo
 Oefwr/YOSQv9QijliSZnPz80mxQmZpWjLDq6HT082zUyM9CPQ+PHtCw2q6NRjvAqiAnz
 ddW5TTRFzJTbskanlj6B64ISNUDpJZRvhD/QDRURWRHDsFOWdafW3MoaTZtZgDrmd3Cw
 jPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331032; x=1776935832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=23Oy57xs+bclVlMhemFNB8YHTiEX+rZeE9kF1B0kY2Q=;
 b=QNux10qnPTp6aA2PdcXrdgAq2F2jR0F6R6tVamhm9tDF15f/Ex2IFMD2hUnfZjW7ye
 kDJEE8styFb2/AMwlY4ZdWGpnZ24e0aN9ccPo7YalkT7O1xBEjgPhQ19vUUWeFgv5EY6
 Lnk0/qwLm/CziNilqYMf8QmwfRrxUnNa4rs/KFCLFcCyVnMn9SXJnENA+NxlGmke3dat
 cZJU5ay3fYwEtK5bZ9XokBvbQBBcTdLM3pt3hqABQL/vQtiWhKoxoX2bv9Se/zbAYZcY
 ouH2750whFbiQ75LxPCakwEkzqjV0wN3MnGj1QvJNUXxlb9Tukw0RVD/Q5D/9efsLKN6
 T34g==
X-Gm-Message-State: AOJu0YyKbUMXpybL4cVrrzIvaxfZfgWcw9o8a8jbUVBT9F5y2B67jWCl
 t5QDC7+p9zFZnMJeK7+grztVK/3zBtGJ0R2gbWqz53gdFSK+WqvDwcyg7SgpPY0AxsUbM5Wp4BX
 Pq5MKV9c=
X-Gm-Gg: AeBDievqakhVpT6WtveHiftEAQiAmAnBhsaT17TS63OhSp8rZiQ7WcSgXnDxJQKs+W5
 CYP/uXOYG1VLnzhtcXIhxU2k/1f3Ylac569y70w4Znk44+2si94KqgwgGzgsW21OdbcCEPHPW8T
 JUGROSbKar/VQboGwz4vkKn5bi7m4pHQmO+oV/X7dXpcA535E5P26/rlPQCAS0Nsxg+5R0dBJHJ
 LEFM5IdKTfvI9Q+mbQqJjWR4hXNX7WBHftwnIFSsW3MGKUoqIIMNM+m+e7wUoeE0fDUd7rYtW9V
 9QcGkyg/FBnGAnkC45AGJqGvuAgkv3mzmDzQebTVdDAAzY2dnsBcCk/rbrt640qn60BE+VEO0fA
 DwsP2UKcEjswqr1C1YZgTILM9rzW09zypIprooSiW9HUh2JdzoHGlJ7aXnVb/mqU8orcpzZquRi
 TX3esNxNkfBMikzIyiETjFIknZWJdSXs9dDjqa8xWOnlYDflhxMlPYk9UQ8wtJMhE7DDHEXERSZ
 zf35qfe4GvVFX2gUJITQCLWUh3632C9a2UN01/Cx6B7M2mz45O4
X-Received: by 2002:a05:600c:871a:b0:488:c683:be89 with SMTP id
 5b1f17b1804b1-488d67f0b8fmr362080215e9.9.1776331031849; 
 Thu, 16 Apr 2026 02:17:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/28] MAINTAINERS: Remove Aarushi Mehta
Date: Thu, 16 Apr 2026 10:16:41 +0100
Message-ID: <20260416091654.316158-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Aarushi Mehta has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64c97043db..6cbb1e049a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4319,7 +4319,6 @@ F: block/file-win32.c
 F: block/win32-aio.c
 
 Linux io_uring
-M: Aarushi Mehta <mehta.aaru20@gmail.com>
 M: Julia Suvorova <jusual@redhat.com>
 M: Stefan Hajnoczi <stefanha@redhat.com>
 R: Stefano Garzarella <sgarzare@redhat.com>
-- 
2.43.0


