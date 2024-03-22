Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB45CC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhXc-0000eQ-7M; Fri, 22 Mar 2024 12:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhXa-0000do-6w
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhXY-0000nw-PO
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:14:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e285a33bdso1081206f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711124083; x=1711728883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5bUm49VP7Mf87j+48prRGAAOIN94P6PXBy1Yvr/+KsI=;
 b=DsnVaNC0u1x0tY9SWJ390lBM7+E8o4arrq1tut23czpCWaa/G4ny3t4acAPMJ0xqTF
 FMZFSU2K9guMcY8cRqbuzOA8DisRkVv4tzNMnwTqOlib4BJw3WubuJh4wt5eRxRu0EOH
 yw2RFlfMeFwtypGuFlAU3eBXrS+rzBI++vG4IiU45H7GDEKo77jX2G6yI3YF+1sSTxz4
 HuPbwLzHuozwpgOeNRLzMXZs16et1LwezU0sJBXpeftD5i4HT4xTIBklzTulK4BqZgBv
 UOAAaJQwXoKhTM8gGgwtFju6knun1FAV/Yp7fgcRIsdHhFtOrFj1KXsn0DIRhvlPoxHU
 Xgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124083; x=1711728883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5bUm49VP7Mf87j+48prRGAAOIN94P6PXBy1Yvr/+KsI=;
 b=qq2U6WMvdq6uxMYejHVJ0CJkC0EHVkFyNJH6hX3nil/FSyKkWretqAi+Gs6281AdKr
 b6Pd1FW8WQH26g1H9y4dOoVmS+moUq+E/gv/eS7ToD9UZ4VOLPu8hbuP7CgpDyrJtCP5
 jFpgvF9eH8mE8VGA3uIK2g3+w7kqj/dj/AxHKIc0M0ph9tJupMM3/xnP4U3RCs4XDwKE
 o5RhCrIoptr+93qP6koaODrMakHJV9miywYlNy//tnui0cp1hNMx5LZVP7s+Iijge+xe
 0lMhbBJ6gskhyFjMdM9sGk+ltcAf6IQpz3IcG3Z3Y6tk1z479XOGMx3TFOVS6bVcxWeH
 lbaw==
X-Gm-Message-State: AOJu0Yy/psx/kA58NLixm/WBqaDVBO33Q7EKEPJO3KvnEEtvMvAkE/YA
 orlS7fPKkAeXpvvrMbeahF5FZ4+7SV2AcfUC6yw2a0Co9wvSijx3UAs1w9OAWuMpV8wJfqO8P90
 A
X-Google-Smtp-Source: AGHT+IEDVYp6n8N+kPfYR9rh0qkEGDmpS/Fpb1POBgZYiskRZi37vL1PkK9XsuJ+ID4QEuHo2Z50CQ==
X-Received: by 2002:a05:6000:1143:b0:33e:d7c1:a132 with SMTP id
 d3-20020a056000114300b0033ed7c1a132mr1565774wrx.29.1711124082879; 
 Fri, 22 Mar 2024 09:14:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a5d62c3000000b0033ec94c6277sm2351162wrv.115.2024.03.22.09.14.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 09:14:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.1 v2 0/3] exec: Rename NEED_CPU_H -> COMPILING_PER_TARGET
Date: Fri, 22 Mar 2024 17:14:36 +0100
Message-ID: <20240322161439.6448-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Since v1:
- prerequisites merged
- s/CONFIG_TARGET/COMPILING_PER_TARGET/ (Peter)

'NEED_CPU_H' guard target-specific code.
Clarify by renaming as COMPILING_PER_TARGET.

Philippe Mathieu-Daudé (3):
  gdbstub: Simplify #ifdef'ry in helpers.h
  hw/core: Remove check on NEED_CPU_H in tcg-cpu-ops.h
  exec: Rename NEED_CPU_H -> COMPILING_PER_TARGET

 meson.build                   | 4 ++--
 include/exec/cpu-defs.h       | 2 +-
 include/exec/helper-head.h    | 4 ++--
 include/exec/memop.h          | 4 ++--
 include/exec/memory.h         | 4 ++--
 include/exec/tswap.h          | 4 ++--
 include/gdbstub/helpers.h     | 9 ++++-----
 include/hw/core/cpu.h         | 4 ++--
 include/hw/core/tcg-cpu-ops.h | 3 ---
 include/qemu/osdep.h          | 2 +-
 include/sysemu/hvf.h          | 8 ++++----
 include/sysemu/kvm.h          | 6 +++---
 include/sysemu/nvmm.h         | 4 ++--
 include/sysemu/whpx.h         | 4 ++--
 include/sysemu/xen.h          | 4 ++--
 target/arm/kvm-consts.h       | 4 ++--
 scripts/analyze-inclusions    | 6 +++---
 17 files changed, 36 insertions(+), 40 deletions(-)

-- 
2.41.0


