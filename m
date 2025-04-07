Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8C5C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 18:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1qyi-0001It-CK; Mon, 07 Apr 2025 14:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u1qyd-0001IQ-6e
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 14:13:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u1qyb-0000x7-Fg
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 14:13:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so5554918b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744049619; x=1744654419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1zq0cs1SLxPrSQyFZvIU2gNWkcXI+aAKbM1wKJNHquk=;
 b=T3+vjBRBW8wMHWpZVkq8clWSQecOaewgKXCgzMFEsrgj7jCjCIz4STmaXy06eu8p+g
 Hg8YaTS+he1TjJuKbkaZ1h/i513yhIm1uCMUAW1HgYdYIUPMU0OqsZlw2aJc3Wc9dpG8
 7GSCs+oYSancOT+jGRyakI4ZWbsk0ntplIKwhDnvubSJj1OX53zJKyTB1Vqps7p4bd/w
 jjF9VusP9/7ZTEh9vx0G3+ozxB0PRuYzEWismEmgns8YDp58mURp3/k0luXx1bOaob1a
 +7kVpfuEtkDKuk6K/vriARdmx3nSKJl9IDo89pouB13qbd640hbhw0sG9G6SkBhvO2bC
 aOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049619; x=1744654419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1zq0cs1SLxPrSQyFZvIU2gNWkcXI+aAKbM1wKJNHquk=;
 b=MFA2oBoOM0YnOJ4XFPk63s/Ip0Fjq3zTIZS4QzexB0zqLpDxobNtJA2BSKUA9s+Kmc
 +cuTwByV0WeFRPMS+5JB0JSLkjdsKnfyTSPXRqiPquaz6wbqEfRz/PpdDVxN4Bi01AKP
 S9N7URNdqyucwgjLvJv5m2Tih9GlUPT3fVz+/I9qMPDddkDx4jcL7OJK6qIhe3cVF1G0
 dF+771BmwNuocznn5CMiahV3tjFSPsrPxYEwB+ixmLC19WhbMMHPLSxXqeu3P0BjvZ+U
 0yJB8vIvQXEAwDvrpeEiK57h1oE4PYDHdINqjol2TI7ysd/57rHHQ0ueWsRBgKleTK5r
 Nx7Q==
X-Gm-Message-State: AOJu0YxILhwvxRTDCCh36fhjHPVl0gprZugbBybLO5brzvDScbkOrNjf
 RTVN+L0ktUhcCKrC8JnJzMfX1G4XNoWXVDuVa2fXExGJl1QY0zU/v1epcPFT
X-Gm-Gg: ASbGnct4KIhAoiDRRuBQGfZDHFfDX5LgoSTSuo/6ncoibcAg6fYZYC+muteJtXQ4jHp
 cTQfL1R89CCB3rL4wCYXvLu8x379FG8Cr/PiwK63mZLfs69fbbwMOaIyUHf6EyZ22lo0i5WtC3s
 BVIx/MY3I6Ye1Do+MJ+VsZ4sZ8ZnuQpSUhnk2Rljm9P/P7xIZ5PaPAs3nHI6UJCqYxoJ0EJSXSt
 2G2H+LODlSNI7AhGG2ywnbGkblt/pN2uCln9zlgRJ9gNQU2xm9mfrkyDC1d0TLb31VvyiG+1JQ+
 EW7mHcNWu/P1b+JkUwKVGdmtbWEmpI+gTxCumigQKLbAV91ueIYn
X-Google-Smtp-Source: AGHT+IFpbTxnpZgBJNcbZkOLqWiAKi4Mrxpa8CYfIRYsJzxijHhJRGCutp3+RDIGflvIqaQnx6ViVA==
X-Received: by 2002:a05:6a00:1147:b0:736:a973:748 with SMTP id
 d2e1a72fcca58-739e4f79870mr18443395b3a.22.1744049618543; 
 Mon, 07 Apr 2025 11:13:38 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:1184:2614:d863:8ed2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7absm9084572b3a.58.2025.04.07.11.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 11:13:38 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	rakeshjb010@gmail.com
Subject: [PATCH 0/2] pl011: Refactor DR register handling in Rust
 implementation
Date: Mon,  7 Apr 2025 23:43:25 +0530
Message-ID: <20250407181327.171563-1-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pf1-x431.google.com
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

This patch series refactors the rust PL011Registers read/write for DR:
Patch 1/2 extracts DR read logic
Patch 2/2 extracts DR write logic

Rakesh Jeyasingh (2):
  rust/hw/char/pl011: Extract extract DR read logic into separate
    function
  rust/hw/char/pl011: Extract DR write logic into separate function

 rust/hw/char/pl011/src/device.rs | 53 +++++++++++++++++---------------
 1 file changed, 28 insertions(+), 25 deletions(-)

-- 
2.43.0


