Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3650F513ED
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyt9B-0005Hm-UT; Sat, 07 Mar 2026 10:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt97-0005HG-Bo
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:00:49 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt95-00053W-MZ
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:00:49 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso5061325f8f.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772895644; x=1773500444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BpZayEwljuHmzha8l/5Pm3Mrxm/PwPGrHhiCKFiSClI=;
 b=WMTPXuZXSZS5m6hYx0ojQP3LSDPYUo2PETTv9eEe3XCFbtQ4ETd7nXhJ9CNhuSZO+g
 rUShD39wed6zdxcC5lvzUX2wwgjJsBchFCxz8ASYnfe/6awsfOB76BkDbtTjCUaMr4kS
 wAb/x0x9VjAgZmcjLYJjLrSSocdhr2VD4UJsxEbzrZeufZBsnEyCzTYvXxA1Rb8tunPh
 ygzSB4U5SOD2hFlfUMd05RpLbbIDc39gyF/6mD+a3ACIOiEV1HTc49TPImKZ+bA71QlY
 Uz44upK0KnzTX9EwBia+B7U1aUiE1w+9sTcNnxUyt2lZv77tCnw4eDJD30eHMx+6cA1m
 tDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772895644; x=1773500444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpZayEwljuHmzha8l/5Pm3Mrxm/PwPGrHhiCKFiSClI=;
 b=jUtRX17S3Wn6Eb44Vtt1zBFuFBJFJnYEd5shmHuHFtezEH+pcoN43ZVKL6vd6Xj5Ii
 ZOBAe3SaZPLUM9j+wKjSOWJyeZQUNBhYkox0HUfHj9YCRBctlxaT8JvSXtgka43Nzamr
 7BrdbrSAz+3XTx7C9IcrsBaQ/4Mg2FHkn38c/4WC3RuhAQfb4i1TWPisIs+lTS7kAJ+D
 I/l/jr0nRxhMZOJ2Asv796HwbL+3IP4tta/LSzbrul+fMm1CHQsLLuQ/NsQIyT2+vlzr
 BM75PMnZVOkIEzuPmv6bZqPY20ryclnDMSDIaklltv0Drxa0YhrtRcWJvfONJ8sXNOko
 YI2A==
X-Gm-Message-State: AOJu0YzKPtRjdQvCLIYwaFf+IC+cYqsW3dsw9IRXpE7IsFV9P19Inkco
 QBWuuGWR4iKyRdkn5iH18AG+AV+4kpYV+YIB/VkoOum2GXqiO7CWE2qehNd1PRjntKDVO1GYTZ9
 FnoyCkRI=
X-Gm-Gg: ATEYQzygvQTgKvzU0TxmfUJ4r0SYpdEl3fXXim3SKL/FHmriEVJQhFbLYl2spFIIB82
 kO8G9QoZ+ao4YKdP6/P1vllQQ0wA9RGvDeKL5h5hqzpDiui5POqd2w3wYpBGGlaBnS/W0foYV4z
 j6aJcq9LF1GwuVvbU5RnlHq6qhiRefdbeSYPPiiOeRKpgtwK0p1GxZ24QLYXDBhL3XE0cZyfVON
 RYEKMFhTeMCTQ7J3nDFc+Jua7nMRuVEHDi1ZzCXFjF9zBaibNlOMPjBrq7pdlE6Q8VL1rlOKHZX
 mP0DLLhBmmoPyX8veXEP/8T6Wlo2iQzUnNTMfS1mLdq7yQ2kcJzJpoUIEodP0BIgSE+6mo8E9vr
 Pt2l5ThcwGUJxu6yBrZSFDw+hB2NhPmrokGGdp2F3lK+1wTmxxwJuqgnbMfeNvGIPS/+gga9LRd
 mSUMgopYsP9Ll3xprZqmB4xuy8nbGioNcVRPggA4H67hyofdLE7zefpvEHrgaUCHENF3f5ZyQT
X-Received: by 2002:a05:6000:1acd:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-439da885f92mr9341472f8f.28.1772895644385; 
 Sat, 07 Mar 2026 07:00:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm11489315f8f.27.2026.03.07.07.00.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:00:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 0/4] hw/i386/pc: Remove deprecated 3.0 machines
Date: Sat,  7 Mar 2026 16:00:38 +0100
Message-ID: <20260307150042.78030-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

1 y.o. dust Thomas asked me to post:

The versioned 'pc' and 'q35' machines up to 3.0 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

Philippe Mathieu-Daudé (4):
  hw/i386/pc: Remove deprecated pc-q35-3.0 and pc-i440fx-3.0 machines
  hw/i386/pc: Remove pc_compat_3_0[] array
  target/i386/kvm: Remove X86CPU::hyperv_synic_kvm_only field
  hw/core/machine: Remove the hw_compat_3_0[] array

 include/hw/core/boards.h |  3 ---
 include/hw/i386/pc.h     |  3 ---
 target/i386/cpu.h        |  1 -
 hw/core/machine.c        |  3 ---
 hw/i386/pc.c             |  7 -------
 hw/i386/pc_piix.c        |  9 ---------
 hw/i386/pc_q35.c         |  9 ---------
 target/i386/cpu.c        |  2 --
 target/i386/kvm/kvm.c    | 15 ++++-----------
 9 files changed, 4 insertions(+), 48 deletions(-)

-- 
2.52.0


