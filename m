Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7AE6FE3D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdN6-00021Q-29; Fri, 06 Sep 2024 14:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smdMn-0001br-Jr
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:07:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smdMl-000562-Kw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:07:29 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-375e5c12042so1207868f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725646045; x=1726250845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+YGETogEe7QHs3kpO72TeOLSF1g7K/mh6DUXFGQKYAw=;
 b=DAuB+IaGYs3ggEL+OBmHAVbosnorfVHiUShC/Gxdaf0DuN2mTDeUAxoBeMX7jmm9aN
 JniQM7sy8Vl/ZsAGl2spDobcRz6bX7BK/84lgutyELfvGYaRcAByiVYZkc47OjhCAqkc
 q0+LpP03NXLkjw3lbClMU6UjOtvMzRezQ2B70/HPov/z9siGEKSQS0RvgPCQBP+INxeZ
 +DpUSZdSxT6QD1hNa1KRjhAlFne1WZ8zkqhjizg05ImVa30+1mLhqS0C+8hvzDdKC2p5
 t8tbussIvCHD0KcBCHjxnZXmfNvVNUVriqRaNIcA8tV2h1cOR4IZhdDusz+tL9tKH2lR
 +RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725646045; x=1726250845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+YGETogEe7QHs3kpO72TeOLSF1g7K/mh6DUXFGQKYAw=;
 b=KBBp9yzHPtBR/p4DDQGcjyRX8/Y6W8Ct4qJfL/0W0b1/p5uBkDbAcwm6SSs+9yZf6o
 iPAJI9WuntHuwBPXs0Azcw/kOhmh/C0hans63dxXjNylNyPInFMVr0d/Zud9ZQgULbra
 544lX/FyrmqLP95Pk2clJ45WKGsL0g+yRSb3ytg8QpiQ+tCQzCGXbE+cjEBFzcZdP6Wv
 Y9PySfIp7ZDA9vpg6eNTWaMW388jdO67wJkC750yZiCbPXHUCEOKqpOk/RYU1/FrdoZV
 1o7MFgsBHwHscWfV5AcfOIFXZ8ZGsyYWRR5IudSIMUj6DfQBPozaq948UowUZfosj0wS
 CXlw==
X-Gm-Message-State: AOJu0YwdTlN1vXFkir3VIiIWVq7EOPbdGSojMuIERcSQcCVe8sabLOD+
 rCfnKqzRMDnlTdicRQIYeEmGKqud37pJz/JdTfARpCNO7xYlc1y2M0nqhKv7PCf62ZcF4OaoflW
 o
X-Google-Smtp-Source: AGHT+IFp2ilXsxNvxEZsdHpkJ/fDpgF42CqfeZNxh6JvToyu3Lllv3J9sgTftN0ADOzQPqzKdojynQ==
X-Received: by 2002:adf:cd8b:0:b0:374:ba7b:42b5 with SMTP id
 ffacd0b85a97d-378895db877mr2565719f8f.24.1725646045319; 
 Fri, 06 Sep 2024 11:07:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37891657a2csm441860f8f.95.2024.09.06.11.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 11:07:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] gitlab-ci: Force 'make check' single-threaded for
 cross-i686-tci
Date: Fri,  6 Sep 2024 19:07:21 +0100
Message-Id: <20240906180723.503855-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The CI job cross-i686-tci has been persistently flaky for what seems
like years now. Stefan Weil had a look and his conclusion was that
this happens because we run too many tests in parallel, and so
sometimes they starve each other of CPU and time out:
https://lore.kernel.org/qemu-devel/9692cfcb-ef59-4cec-8452-8bfb859e8a6c@weilnetz.de/

To test this theory, force the cross-i686-tci job to run only
one test at a time. 'meson test' has a handy environment
variable to let us set the parallelism. Unfortunately meson
prioritises the command line '--num-processes' argument over
the environment variable if they are both set, so to make
this work we need to adjust our mtest2make script to not
set --num-processes if the MESON_TESTTHREADS envariable is set.

I don't know if this will fix the flakiness, but it seems worth
a try. If it works, we might want to consider whether we should
do something similar across the board -- at the moment we
always use a parallelism of num-cpus + 1, because we use the
same amount of parallelism that we do for the compile step.

thanks
-- PMM

Peter Maydell (2):
  scripts/mtest2make: Honour MESON_TESTTHREADS if it is set
  .gitlab-ci.d/crossbuilds.yml: Force 'make check' single threaded for
    cross-i686-tci

 .gitlab-ci.d/crossbuilds.yml | 3 +++
 scripts/mtest2make.py        | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.34.1


