Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C660C27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVdY-0001ea-1k; Tue, 04 Jun 2024 10:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdW-0001dG-Oi
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdS-0005Bu-Ud
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35b447d78f1so3460458f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717513176; x=1718117976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sVfZ7RnxrIitCipB6DhYYkUgRM5pdkK34pyZBP4MlZ8=;
 b=sF3tQj02aMlw1E84vIvWNI1f/dtpePdaXL02CR4Mxa7MrF14L4R+isoyIhnvFGbuaq
 kClCuecaFCB7XJ4/Wvzw1un9tn6ZtDmVtYXdJDEX49rZWerxHIrX31ZkUBxrB6e25Oh4
 ZDBpqnoOUpRa+eZ01pcyenxNrdVEQBlxXBWr6Ex+cW9kasnLtZZrd6lfEcY9RNMY2Uc0
 IwoyVU6UtXlcvjdil7K0AIvtD98hu21YA+etZziInTf74y5uwp5dRWQHGKT+yd0BFDUl
 sxad5OJoic0+2k38GVGmw4OKeB/VH0pCS+e9TxOL9pz8MM2QciNgnp+03h9/1YyntMMX
 hlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513176; x=1718117976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVfZ7RnxrIitCipB6DhYYkUgRM5pdkK34pyZBP4MlZ8=;
 b=MkAtfVAzpzpqcYs5IbtpAvZ4CyDIps/a6dAypgvDrK0nR5ViWSOqKINVP2NgE2Dnw+
 PKkCI4h2RxJdMvS2h1MVhmfR2WdfDm1Xcycx5arzhZQZl4gIqjQ+nGmCudp+xZ6IsrLY
 OPZoQ6VNJCed4o4ro+ZlLMSrq+F29XZWHPhIwu4UQUcUVtKknMlmqu2lk4yrtorUevsS
 hddhs/6sF7Ge9AGMz6j/wPIRHq/Uk+ffO3eca+Ljc5qvxsy+odqPZb4Py8MbCBHF1o4a
 KHCZN+K8Y96fvouw2WoP0XYjzyrxYASx81fjlEBbMOj7tdOkdN8O5IHGQjbWC7MbnU/L
 zNEA==
X-Gm-Message-State: AOJu0YwCAvrZLdrfNqxo/sEFi7X9XBZSNl13hylvvf6B/UcsoN07DAKT
 duRg3NdCf78yA9s5TT+BYB2ETW+MPNMFi74j/MeFVMi95mVfjq3rBf7c/oViV7oR+scFWn78yaD
 W
X-Google-Smtp-Source: AGHT+IEUmyFg/hneJYV7wkHYaaia0ThqWjjnRhnJS16RA4L8CEdOfqOXqS5wk0GGOUJ2ruoRI284ow==
X-Received: by 2002:a5d:45cd:0:b0:357:8f8c:2dba with SMTP id
 ffacd0b85a97d-35e7c557cbamr2730011f8f.17.1717513176201; 
 Tue, 04 Jun 2024 07:59:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bbb1sm11767869f8f.101.2024.06.04.07.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 07:59:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/5] scrips/coverity-scan: COMPONENTS.md updates
Date: Tue,  4 Jun 2024 15:59:29 +0100
Message-Id: <20240604145934.1230583-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Since commit 83aa1baa069c we have been running the build for Coverity
Scan as a Gitlab CI job, rather than the old setup where it was run
on a local developer's machine.  This is working well, but the
absolute paths of files are different for the Gitlab CI job, which
means that the regexes we use to identify Coverity components no
longer work. With Gitlab CI builds the file paths are of the form
 /builds/qemu-project/qemu/accel/kvm/kvm-all.c

rather than the old
 /qemu/accel/kvm/kvm-all.c

and our regexes all don't match.

The main aim of this series is to fix that, which is what patch 1 does.

Patches 2-5 are minor updates where we were missing files in some
components because we hadn't updated them when we moved things around
or added new files. They're worth doing now since handling patch 1
will require a manual deletion of all components in the coverity
web GUI and re-adding them. (There is, alas, no automated API for this.)

thanks
-- PMM

Peter Maydell (5):
  scripts/coverity-scan/COMPONENTS.md: Update paths to match gitlab CI
  scripts/coverity-scan/COMPONENTS.md: Fix 'char' component
  scripts/coverity-scan/COMPONENTS.md: Add crypto headers in
    host/include to the crypto component
  scripts/coverity-scan/COMPONENTS.md: Fix monitor component
  scripts/coverity-scan/COMPONENTS.md: Include libqmp in testlibs

 scripts/coverity-scan/COMPONENTS.md | 107 ++++++++++++++--------------
 1 file changed, 55 insertions(+), 52 deletions(-)

-- 
2.34.1


