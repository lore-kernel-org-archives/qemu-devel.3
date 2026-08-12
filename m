Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47528C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwsp-00042M-0P; Tue, 11 Aug 2026 20:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsn-000420-Gh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:49 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsm-0000S3-01
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:49 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso521450b3a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786494706; x=1787099506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=grB/2qbgv6sRksIzLWUbIyNsuT6NjV25by/+emYq0wQ=;
 b=Mu10FlDB3ZMQWUFxGqV7doiqHZm/zD7zciXhydAB2D3ookDSLWXHy9tQWCUwdrie2F
 cLF2ALV8vxhpjIzT+BOyXlT+wIG72uscXL6anq1x1dNNFKQkkA2enLXdLjINGc34JsKa
 dXDsZDvSV5dUS8okKyvX/fjAKvJmrxIse8KWmkRrpHDSFNVRIA3I+lImANqfno4dKDuj
 gkgT6bVpmL9QGjjPoOitxq+cbBQFMtiqA5v8+bHFKipyO7c2iPZ4sVDe31x7w916IwWl
 eAsWmplAPXaZ1Kn88wb3gIrrxFjF6uEJfb/Xl7mNcpM3GfmUEvr6HUZqBR3B+V6e5aMD
 5RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786494706; x=1787099506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=grB/2qbgv6sRksIzLWUbIyNsuT6NjV25by/+emYq0wQ=;
 b=jvPWC49pAs742Qv/H7VXdVjawRW8F1Z/E1qoir+hnBxu9yg2IFms+iE7Aree2/qlzV
 NuLvOquNFm0cun8BdAck9es15MvnK1Yk9fef7kSKl3uzwKN17cLdvBdZa66FEsIdpi/N
 qPk/a9hZfpuxo1LdF4bEdriY+YbjcEEC/2P0bjH+fX6qV2mTwz+EL3y124wNQvUQOH6D
 yc8f0VULu77CK5UMxNTGu1FqtaF/GG3uNUGnSawDhj+DCbXc9tRXl7IAGEcNBqP81GFH
 htWSYV9RU1f3r+YgtY2C0u/eYpDxvUQ3mhb5iR6rhjSrf54WLQk66/rIpVO5cN8RpPql
 Kyvw==
X-Gm-Message-State: AOJu0Yzwn9MAq3fb/l1V24QrUOe+bxwXSTIIT3727YtqRgkCzg9XBwHq
 qg1I05BdpLbgnyukGy+jkCfQ9BYuBnfUosWLHlMsfw2BebqjbjRf6rWD6lIqQl1pRkAF15ehMmF
 kCo0s
X-Gm-Gg: AR+sD11FZKpBa5Nhuk4h9DJ/qW57WKpbB6VL4QAmFrnnJYF1ARkmW5Ub3+pTx+K4BUe
 A4PKPgoytUv94Qak6u6mmRyHNjrl4wCtlahC79IjyyfDgxIk1wEAt/MKV4cqmXKAfDIg5IIa6aj
 jjRmp350e2e2MOurPCvVqdG9jpPH9LXenFObNqmr4C0gE1fT6BJ9E7PJJHbmSjaWTsyLNg+Z52j
 b+8GbAqadMYmT5vLODCyRO4phdLdsCaf69Ye0yPQhi2Yne/TWO55UpCj+CMidq9dDuB/FBqQ9dy
 JuXTr037sZRkaLp21DWWnRl67Wt3f3RoZQHxAE0NsiPGqFm7z0O7Klm+TXQHulS0xe6LTBgZgoE
 KxBtFr5uGK94QZrWKf/Lhe09/4rFh/6pYKrb/FspnLpH5lsqGrDj8O+FJAvzeh0Lp7sxRk78T4R
 TZKzjbTJM2Gz8Ug3iU1Ge2U/3fVk/Q4i8HURi9dAVlvaeWcs3Twqwmw0uV2NujInP/aBDgxSR8x
 CoMOqSTsTNsWasR3iGd
X-Received: by 2002:a05:6a00:8084:b0:84e:244a:98e8 with SMTP id
 d2e1a72fcca58-84fb55490b2mr1208354b3a.30.1786494705605; 
 Tue, 11 Aug 2026 17:31:45 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2587fsm321466b3a.49.2026.08.11.17.31.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 17:31:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] tcg: Add min/max opcodes
Date: Tue, 11 Aug 2026 17:31:36 -0700
Message-ID: <20260812003143.225228-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Since two hosts now have (optional) support for min/max,
I thought it might be worth implementing natively.

While I was there, use some more of the FEAT_CSSC extension.


r~


Richard Henderson (7):
  tcg: Add integer min/max opcodes
  tcg/optimize: Handle min/max opcodes
  util/cpuinfo-aarch64: Detect FEAT_CSSC
  tcg/aarch64: Implement min/max with FEAT_CSSC
  target/riscv64: Implement min/max with Zbb
  tcg/aarch64: Implement ctpop with FEAT_CSSC
  tcg/aarch64: Use CTZ from FEAT_CSSC

 host/include/aarch64/host/cpuinfo.h |   1 +
 include/tcg/tcg-opc.h               |   4 +
 tcg/aarch64/tcg-target-con-set.h    |   2 +
 tcg/aarch64/tcg-target-con-str.h    |   2 +
 tcg/optimize.c                      |  52 +++++++++
 tcg/tcg-op.c                        |  48 ++++++--
 tcg/tcg.c                           |   4 +
 util/cpuinfo-aarch64.c              |  13 ++-
 docs/devel/tcg-ops.rst              |  14 ++-
 tcg/aarch64/tcg-target.c.inc        | 169 ++++++++++++++++++++++++++--
 tcg/loongarch64/tcg-target.c.inc    |  16 +++
 tcg/ppc64/tcg-target.c.inc          |  16 +++
 tcg/riscv64/tcg-target.c.inc        |  52 +++++++++
 tcg/s390x/tcg-target.c.inc          |  16 +++
 tcg/sparc64/tcg-target.c.inc        |  16 +++
 tcg/tci/tcg-target.c.inc            |  16 +++
 tcg/x86_64/tcg-target.c.inc         |  16 +++
 17 files changed, 435 insertions(+), 22 deletions(-)

-- 
2.43.0


