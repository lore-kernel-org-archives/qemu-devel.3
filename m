Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62E2FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 18:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKKt8-0003OO-3z; Tue, 05 May 2026 14:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKKsH-0002hI-OY
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:52:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKKsD-0007AF-2x
 for qemu-devel@nongnu.org; Tue, 05 May 2026 14:52:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso40650475e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778007119; x=1778611919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k3WIGxu6tW+PCQB4oHpMW08L9nSdVmuE4N/LRCxxLRA=;
 b=aA8fN6H4va1mXJdzq9nqrV0LNgrZ06lmVdp4vfUf/S2mI3VxysMUZgtRt8napmOko2
 WqZwKDoTf852/FNcBternl9jR6xynUOzoC6eDvZizT40FFhobEJ4Yh0AC0gXc5Hwd4UL
 WzJuGObkiefFyC61HnkObHzHr74YTGxSJQQw7TbnhxztL4w179WpqPQztQTVSSmtQPeK
 zW2MJWCkaZurfVv7n7Mer4LQZJcTWnJcajfcbwuWHqqhA6hEFVbW2RP3DRYoHQ9+JDW2
 AzpXaVuzZNngdN+mgsD3ogzsUlT9f+QjbuX/F06IYbcMdzsMxwHS5V9+KVMfLFNtjuWQ
 b0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778007119; x=1778611919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3WIGxu6tW+PCQB4oHpMW08L9nSdVmuE4N/LRCxxLRA=;
 b=eaeOojG07Seq/PBG6QIDYPKZ5mPPCGO54UinigCt8pdqWn9P+QjBgMBsRPA8IT7UTl
 9knKG3HY8aPHAwTbf6516WUAcZSy6Upb0GgLLhxAdjQKIxi4ZNWhdM784nTjXe8BAS7F
 IgWpUF2BzfiTF//rH9sFZ3aO4gpAUb2g2HGq0Lc/yEKtLxftDxwuBjdiTLNRrSP3OGNA
 3Rzl/Tl7X/EQPzsalV7pGgFNkNPaVL+1Gp3ZZPRuvbCOh0WM2H8XLtyqP3ky1+ocT5La
 fCHATePgvevtSlBsmHT4cBqFQxAlbYhHNcSOxEKAdjq/IqhPugvyZWGO8cnQ2OkmP8ru
 AFrw==
X-Gm-Message-State: AOJu0YwTns64QHj255uogvPY5KjNwhMTnu/FOamX2ASHjN4WFt8Uw/58
 HcRmUEw4MyZJpGXySgMGsp2tRMY+LK7oQLOhPCbkt9hm+tjaOS9KvAUTXF1vTUNdHDbEimzLp07
 ruFDH
X-Gm-Gg: AeBDiesipHbkmgXUQNq9x9HDR5wqpsNNHIjn7RgO0VeoQnqK5DH+BiaLI3sNMVyoXh4
 f1qpW5b3X+o+lCJXIHQJ5Oi5wykv9xHRRS5CbZZOzmsVE+xmPG0MneSInpVUyZKQbEVw/S9M+DO
 vWvFixFOvmQLjs2gJ2xWlNGhffTo9/JzqggAlybhWfZ0tbln/e8Ou4uhXHljy268Xn7t7HfhQqr
 t4k2oN9PHnZJsMGxwccWox8nKDr432EDyQAedH/EmG7Zx9NaMRNal0Z2nxZp/TPrcZahVsEGeQa
 va8hG9ztKZRYY6D6guLks20w3MZnZffvaJ7The7Hirs46CJQOj5vH2TVEFzkizKFgGK1LhNmmVB
 aFQ4UxGiC8vZ1tpJEfFVbq6kF8/gOrg2Ls1BiDWOyuQqyiKy+irTgVXmuw/6+nOLzfYOayDuVmC
 rDOkKCa1BwjVXSbIbeUczVOHaTRQKRGIq1Z9/0/w9lrtCfxOPiTp1fw6tcBDV//wRbmosx06Woy
 pWAFIAhtPL5HTaQ2yxBTBiIH3X4L8zhCaa4St/tfA==
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-48e51f32aebmr7566205e9.16.1778007119010; 
 Tue, 05 May 2026 11:51:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6ffb7sm377086675e9.5.2026.05.05.11.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:51:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/2] hw/net_rocker_of_dpa: two bugfixes
Date: Tue,  5 May 2026 19:51:55 +0100
Message-ID: <20260505185157.608910-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

These patches fix two bugs: a NULL pointer dereference if the guest
does something wrong (reported a few years back as issue #1851),
and a sanitizer complaint about unaligned accesses that I noticed
while reproducing the first bug.

thanks
-- PMM

Peter Maydell (2):
  hw/net/rocker_of_dpa: Check group ID pointers are not NULL
  hw/net/rocker_of_dpa: Avoid unaligned accesses in _of_dpa_flow_match()

 hw/net/rocker/rocker_of_dpa.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0


