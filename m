Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9240AC021A2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 05:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti4vV-0004S6-Bd; Wed, 12 Feb 2025 00:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1ti4vU-0004Rq-Ax
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:04:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1ti4vS-0004J4-Lx
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:04:44 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-219f8263ae0so113014015ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 21:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739336681; x=1739941481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=by2a8C4n90HLKjPeUFHtKFDY0AFdblPaapYJ1v5EzU8=;
 b=JW/FZgHjx8ibG3jJBGhmrKrThdP06eorLs5n0czNlKMWbxh2stwhqS2Z1YKZ+V/E0I
 7bAfaIsif1FkJMJW3kKgJAdcZufFPXCd7VE5zcg8FfwfCHdIZad6m+Zg7L4Upge8gNwG
 SKmXMR6lftYfYyDXmtk3bw7TpSwuIZQ6I1sfJvW90kIr2TboK+f5eIwiwBpZbPbe7SaX
 7Pgf7C2TULoZWu7ohWHIkSTjNmhGf0SW57/gTU6hQvWxi8PMTm+zFl3N7z5IjA6pxYnL
 LwvSXvkgiSqC7KxRgKMADB2NKtiQVMLuyT17Na+KFG/nasQ86Z8nAa1rs7zNUs8Xcud/
 EGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739336681; x=1739941481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=by2a8C4n90HLKjPeUFHtKFDY0AFdblPaapYJ1v5EzU8=;
 b=VbfEWoP6r4kPgJSOf95xs+WeawYz9PIthxw5QMLnT6x6Qut/DXVo8583/YZxulSXHs
 VaVZyA2xgFJv7cDRRB9aJ87rOK5E/cDG1ZDyIVIugudTUP5YOfa3dyGKp0arlyR5lyhA
 jh6bTueR8ybXcIRA8eUM9kRsh3Et0WMk6R1vaYWNulaIaiwzIZMdkShcl/Cw1oYlUK5G
 IgcdYyRs6lbIwC90YTQo63Q2jKkCqV/fFAWhOpgL7uZAARrMwckaFpEfxifmEkgCAIPI
 +4/n3N3yfkXWVZwLC2nz/Zhk1+TXbW83Bnrue05HW5J2Q2OC2BqziejkGvd2TOz2vuMi
 rq2A==
X-Gm-Message-State: AOJu0Yy5HXV5tBiL0KzEoz3ubOKbf+COmY3PEj+MaBYk4EBVtM4d4cQL
 T9HlGIvCML4NVyvrXPGsNMIJqZhp5Xk35FUur1nC2CnQQcX/z3pB
X-Gm-Gg: ASbGncus46OdcLvpqko+1vUh0ANnGKFQC4rq6aBNE1hYrzPaaq3lq3OuDScgZwp0xUf
 I0g/XNyq8z4HUMS22t1SF4ChCaq8trYWneX68D9A+IS6AhGLRJ07L+WX0DOgAdEWxGlRB6HO2HY
 oNjPQdpekr2aIzy90I14ZOZIZi8fNMZZ6zl9JeJFQB/ceOzj3Pwe0fD/kd3XcEu2dTk1f4PReiW
 XpcLzQiFLNwXLiXRMbwlAxBK2K1RzXZ+isz7aZqwjHQCyJeeqernH7QS0MWcNRIbdHV6xypkb1Z
 e0TEJAxDDMzA9BQSQhmPpQ==
X-Google-Smtp-Source: AGHT+IFVHLG9dw+GA1jQjJe0j9S+oRGr6vO1QVPfnLq5gL90WZguVi8QYARxxeWCoMxHWj+LNH2lZA==
X-Received: by 2002:a05:6a21:164e:b0:1e0:ca1c:8581 with SMTP id
 adf61e73a8af0-1ee5c775f1dmr3647443637.21.1739336680562; 
 Tue, 11 Feb 2025 21:04:40 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048bf1421sm10480602b3a.101.2025.02.11.21.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 21:04:40 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: jeuk20.kim@samsung.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, j-young.choi@samsung.com, keosung.park@samsung.com
Subject: [PATCH 0/3] tests/qtest/ufs-test: Add MCQ tests
Date: Wed, 12 Feb 2025 14:04:18 +0900
Message-ID: <cover.1739336154.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x631.google.com
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

This series adds test support for UFS Multi-Circular Queue (MCQ) mode in QEMU.  
It includes MCQ initialization tests, a bitmap-based slot allocation method,  
and cleanup of unused code.

Jeuk Kim (3):
  tests/qtest/ufs-test: Cleanup unused code
  tests/qtest/ufs-test: Prepare for MCQ test
  tests/qtest/ufs-test: Add test code for MCQ functionality

 tests/qtest/ufs-test.c | 724 ++++++++++++++++++++++++-----------------
 1 file changed, 428 insertions(+), 296 deletions(-)

-- 
2.43.0


