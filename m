Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1414C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOym-00053K-7W; Fri, 25 Jul 2025 16:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOsu-0006gO-7l
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:19:16 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOss-0000vY-HP
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:19:15 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af51596da56so2119826a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474753; x=1754079553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5K1qtAriFHoDI4vOaduYpqQ8oUEBiN45bpDENPmumJY=;
 b=SwxqZTJ08jpc/Eqg5qVNU4WZMuFFJeUqCJQxSOY3KCREmRRAdj82CPqhvVQNte5i9Z
 wJxWUMg3Mk4N+hm3JQMPewSHteXEboab1/7IAABvYMBQP/WFs39DOGi0MVo9ZxcStVDr
 ivrd/G/Ebq5wx4Ev/wNQBBCuoEwwI4oorT9Ozb4QuSfjbBrhffLx/pIGPPq2BTwnGJYl
 /HwZuN5bWSn5wLkJmXE8DGcusTfRHFwzdnfm3JRyCqMKNnyr7sbpDwckT/j5l8dBAAaf
 Gf0sKaFuBJYMfCaZaQaBhAChgF+EScY07EZeyfLD0FZA3VEpqOGtkdw12d/EXeROOd/n
 7kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474753; x=1754079553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5K1qtAriFHoDI4vOaduYpqQ8oUEBiN45bpDENPmumJY=;
 b=rhSHU6Jhw5IBoEoOifaeCumLPkzaEDKpUqATHtDQUFdB6B+uSMo12wl/8OBQtC/oKu
 3LDy0bh4sQgGIcnOSPowOA4hweYlpcN9V1tqr3YlLowIeZ0/f+/tN3JNtLrc4gFC8vs1
 Zr71ENJ3SZ2p3IGAqXjzyWkbStFeUnIkfsdv8ji2YIYBQ79Saj9cJm7sfZLfGquvWkCQ
 vxN5roE83BFz0ewy+gXh6MI6jQ1jvcimSBjXQijMzTPA8JUazqJEkgS6a/QNB194kjcM
 HVtL2+dnrYYMNnc5vebLwFZlCNPdd25F/fvU4WPhyhc4PupIv7AIRFqu0+PQcfKLDAIH
 /1QA==
X-Gm-Message-State: AOJu0YyDfRCel1nAoDL4RX5Q9nI8e1rFV/WV8GqGpw1+155yWqqlA2vv
 8PpTHiwka45xQae1R68Zy0AhiNuXaJ0oqFcRCSfXQwCYp9Lin7PQenDZm2W23fQuAe19a2sNLG7
 uClf6
X-Gm-Gg: ASbGnctYZGBrAV0LdKPuDCRpZCeKrP8ZT5cizWoBCICMAexbQEfb2BLON7cZ9lMpNvh
 lhvZTceBEjaLo7saCnZ3NvaiGKb5FHcKMSEppATWaIvgwZeO1Ko75S6lnH4vAIPsgA1zDdR3xZX
 PGGxXJmS/SxK/HCCnDVgkzKuBqWwg/Z8QgTbtRJIBrKvBAHGFFbeUgS9Qs4MPS4wVTiloLTq9ZO
 g5H3wRrK/lGpP7NTICuWhgroXaO2lj5CkH3uJfXxgFGQ3LBW+VrjTjWvp4QShNw8gjDT6z5g+iQ
 IwXBsbkOASqvkAbQwiGMSGfvkkvoKY+zS0x1e4a1Gd/6jytyhzNaudU07A9k1r/Y10Ck/C3B++G
 NAuVHOqfsdpoLgTchCThzhiVAl7iShl+w
X-Google-Smtp-Source: AGHT+IFUxwD/snBE4ljS+0QN/557jbRNFw2KOEoNBB2wTCbbuq+V+o1vyzhWlugVy8o0+7ckdQojXA==
X-Received: by 2002:a17:903:41d1:b0:234:b735:dca8 with SMTP id
 d9443c01a7336-23fb307afd9mr40344335ad.6.1753474752771; 
 Fri, 25 Jul 2025 13:19:12 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6635f0a0sm4143309a91.24.2025.07.25.13.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:19:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
Date: Fri, 25 Jul 2025 13:19:03 -0700
Message-ID: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move those files to hw/arm, as they depend on arm target code.

Pierrick Bouvier (3):
  hw/arm/arm_gicv3_cpuif_common: move to hw/arm and compile only once
  hw/arm/arm_gicv3_cpuif: move to hw/arm and compile only once
  hw/arm/armv7m_nvic: move to hw/arm and compile only once

 hw/{intc => arm}/arm_gicv3_cpuif.c        |  2 +-
 hw/{intc => arm}/arm_gicv3_cpuif_common.c |  2 +-
 hw/{intc => arm}/armv7m_nvic.c            |  0
 hw/arm/meson.build                        |  3 +
 hw/arm/trace-events                       | 79 +++++++++++++++++++++++
 hw/intc/meson.build                       |  3 -
 hw/intc/trace-events                      | 79 -----------------------
 7 files changed, 84 insertions(+), 84 deletions(-)
 rename hw/{intc => arm}/arm_gicv3_cpuif.c (99%)
 rename hw/{intc => arm}/arm_gicv3_cpuif_common.c (92%)
 rename hw/{intc => arm}/armv7m_nvic.c (100%)

-- 
2.47.2


