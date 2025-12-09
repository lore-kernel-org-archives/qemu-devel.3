Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4F7D3B7F4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStxz-0006mJ-QV; Tue, 09 Dec 2025 04:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vStxw-0006jU-BJ
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:25:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vStxu-0002HF-QG
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:25:04 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso50740645e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765272301; x=1765877101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9THmgE9FxGdmnfvfnPpWimZ+vaexgQkKA5pzaXkAXJY=;
 b=QWqo+iPPhSOVN3HsX845ObOOSA6xgBgjmNJ8rgwTclbvzN1laUk+kFP5PwqhesvRZy
 ZyIdt0KoJnHzi59JljHCrP7x+dTCKeODuDlgwQU03nZ3Z50x7JPxFFmtvFDCG580E8p5
 kAbUB+/lHh02gtqvmRW86qb3AkswUw7SmmFJhlmW1SOyQHm4rNZL2FuZvW9DGGiIj4Fw
 Zq+C2cT4dqCW3cEPhNFJHUh6N9dMC2OEKwU//y2w4k6fYqjK7/4avFEEewVaREr7ykvH
 sewlTnYHyZK+bW+Vs3Fz6WW6iH1r4h3RnTFbptPKaIP5SU+aP6lsp3dxszVR/t6ONlsK
 nygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765272301; x=1765877101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9THmgE9FxGdmnfvfnPpWimZ+vaexgQkKA5pzaXkAXJY=;
 b=wHfDqqYZ3a9kRiC2n2n0nprc4NGiEITI3ZWYd7hHlCt8ZRKn/tfS5HpspUqgCkWwRW
 X/IAVmn3l15srbxgB0kwv5yCXGDEI17eA7Rn6jtqXQK0OqDXFhRmK8D/1bvUTBu0XN+r
 hv1atgq3RXXSg7588FP1skZhyzu6I9WDrw/JxWIAIg67vzt6c6rzdwlPJbdQmOXnbsAm
 t7mvJ7aedVDO5ON+D6TGie/tckk0YAcWp5EzNmPlsVmjYUP5+t1BZ2x+bw339h3TuhoJ
 rthVU9p0lhfOOCSWuBWWeFxoAa03NyGTopzcxEApYZ6EUlH6jOtIkgWCG4zv29KDfuaj
 1Chw==
X-Gm-Message-State: AOJu0YyuHlLxCtTKMKMiP5/DkSo06ItEsLVchWCCE+a1vALfGDyi9qcG
 2F4233m6H0DDZyv6698ZCazQEEQxwRmeVBD8PR05CLU1bWjgmZxmm92d41XA7T/LYF0=
X-Gm-Gg: ASbGncsbIRzHyST2neEQuiZagIrqCyuBa99H5nu6dh4MF/h8O/d25MHbObCd9OJA/b0
 I7s97gvoxOPrJSGnoyLv144puuJF3TW1TVryf3ll3Zf6Lm6xYOu2XehoatXF4YxphlC4QyvjKod
 NIx9LzdTFdjFd6av2mZhUW5LZto9ZTRdip4qXJNz0VXly1OP4tfZruW5dmipc6atUAR+mLBSvcC
 kaONnPO3Sw6hqhCN8d87RaVATH8s4rnVQvI7zd5bKRF501KZ7gD4/u0Jw+/CnZmR03cbo1QkukK
 EpbOTnbXbOau3TPVX8/RWqjugTVxMQX2Kdr/5jggdfrVpj5XVHOtbNfDm0ZntSNNhbbg+S/cCqG
 RctoRB+y6B3Axq4aHVWrO/9boG8Be1aSNIHKDZ6c1ycGUJBcr2pZBLXAKodMKpn96blGvDP8X7P
 qqOJ2FgFMMLjQ=
X-Google-Smtp-Source: AGHT+IGkP6Kh0IPnG57RNCUqHZKRmf2oJs0Weh1mxZc33haa0YGFD5V9FDIBMBtGqHJ1U7n3J/te6Q==
X-Received: by 2002:a05:600c:870b:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47a7fa3344emr8579115e9.9.1765272300969; 
 Tue, 09 Dec 2025 01:25:00 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6eb1f1sm29352845e9.2.2025.12.09.01.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 01:25:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A5A65F818;
 Tue, 09 Dec 2025 09:24:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] Final (for real this time) patches for arm - pre-PR
Date: Tue,  9 Dec 2025 09:24:55 +0000
Message-ID: <20251209092459.1058313-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

These are all bug fixes for Arm including a recent regression to the
Arm HVF code. Last chance to object as I will roll the PR later today
once Richard is online.

Alex.

Alex Bennée (4):
  Revert "target/arm: Re-use arm_is_psci_call() in HVF"
  target/arm: ensure PSCI register updates are flushed
  target/arm: make HV_EXIT_REASON_CANCELED leave hvf_arch_vcpu_exec
  target/arm: handle unaligned PC during tlb probe

 target/arm/hvf/hvf.c        | 11 ++++++++---
 target/arm/tcg/tlb_helper.c | 21 ++++++++++++++++-----
 2 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.47.3


