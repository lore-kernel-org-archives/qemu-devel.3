Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F15C79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tgf-0003JX-9b; Wed, 09 Sep 2026 21:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x4Tge-0003JF-2N
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 21:34:48 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x4Tgc-00022d-JI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 21:34:47 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab201ecso1103507d50.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 18:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789004085; x=1789608885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mNG+iEtOq5yLs4fQjwc1YyMg0x2e8vA3tAQ5a1gJh4Y=;
 b=IYkPa/ju4W5N5r/FShsg6YasjtUo5ogEj1JGpfF7zkc85epbgSVaKGUjqOQN8MFHal
 zih+4EGEV3YJEO2+X/qaWYeuBVcQz2IKewSPHC6o55n3MGCvTa9HSTo4Nc+Z/BFNC7s8
 U1ZrXitpK4AXGbtj62RHkuMgA0Kz5WWRAO0r4/JUWUO4QBbe6rd7rZis7vT9Ao28imjo
 maW0m6knTVPQViCBNpZDGQgEnprXC+N2DEAr3n/FNIU/iamtfSkAXiqQF0x9koq5IdPH
 oZlLqbi80jAX+ZWsej0fMpCULxA3/Wms67w0UzNx4dbqGLtQbHuvd1ZKqrWm2ICpMunW
 yg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789004085; x=1789608885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mNG+iEtOq5yLs4fQjwc1YyMg0x2e8vA3tAQ5a1gJh4Y=;
 b=nRDmHpzciTMaXntTiAsddqMcQuMt5MfTcLemjfMFEMyJzXs1Zm6puMsLjEUC3b4yph
 N5lipXQa4/v6EhguS/B45pcqhyZKeblmzdCW0DPJ0n3g5xcoYsdT78vIt7oNqCTyL24E
 4ptn82WaIpr282HoAdyObjaJGvKiO9A1/J/q3GNXlZ0wO221F1kJjSjn0WcB4CtSqGJd
 tdj5zsQ9mRcDmIN88SvxQFKlMq+8qFWbGcK+XIlNDGk3hPCZ6PWI9jYQNdgOayuZnIXb
 uH84jcPycEE16KoyhDk9yxlXtoWM4L9cKg+l+eOQ4j3BN+Go14xUwxBOyVtLvnXBVbDj
 /1Cw==
X-Gm-Message-State: AFuF++kI4mMPQybBVMRkDtVgeSviD4gEt0UCn2jB+LJUBrpWMiigusMZ
 CBf66fbd3Yk/H2yqkTjQgdU8UCfQOlekfmr+AKV62GRuW8zhtYthy3FkQpEB/KTb
X-Gm-Gg: AYBFou3/Bct2ocsFjJJAKQkvfFcpv/fnTRnVDEuFCeTC+Tn2IjBstg7UQiMMN8SvqyP
 qViEhcyuvJIYsqbF7nB3u4EfGRV18OKMGDAa7Ab5b1VMvNCuRLtPFsotZGoYhKozOS2AtBMDmOj
 IrriI+YfO4YHkFHhxqdcPRpeldxJgJKX2LWy7YrFoqzP759ATkx1fjIYNseFIRo5/4xkBZAWDI8
 dyX77CtCYpFJ55P4fLyozkxpcnZ+gMRy9hKkfix6+HMTk3+D6RH3v7+UETpyjQr0yVg1hiHhzyP
 YwWBTPurc6u03ejhzCzc4iryX0Mmqua1zGVMqsqwjxddU7KbqTPWn32FZjpEze4DXjVDG/5C0wx
 OZu08touX0EF3t3i/b/DEYjR7zDhvzUHGP+KC1KdWwwuf0SYIH4QUQssI7W7o85zs6jWPRr9A6C
 XveDGSRAmQ+F2tnMuAaC+AEv7cUHcKytKrWFw9LrgB69FvCeJYC9vGP6Vg3ldFaDKzCALa7HY=
X-Received: by 2002:a05:690e:43c2:b0:66f:b4c3:154f with SMTP id
 956f58d0204a3-6710fe437f6mr1820444d50.4.1789004084581; 
 Wed, 09 Sep 2026 18:34:44 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66fb4939b30sm13257905d50.15.2026.09.09.18.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 18:34:43 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/3] linux-user: write the x86 floating-point registers to a
 core dump
Date: Wed,  9 Sep 2026 21:34:39 -0400
Message-ID: <20260910013442.1517793-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x10.google.com
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

Guest cores for i386 and x86_64 carried only the general-purpose
registers, so a debugger opening one reported the x87 stack, and on
x86_64 the SSE registers too, as unavailable.

These add HAVE_ELF_CORE_FPREGS for both, following the same shape as the
recent alpha, mips, riscv and sh4 conversions.  x86_64 can reuse
cpu_x86_fxsave() as-is; i386 needs the FSAVE image without the FNINIT
that FSAVE performs afterward, so the first patch splits that out.

The SSE registers are still missing from an i386 core: the kernel puts
those in a separate NT_PRXFPREG note, which the generic core dump code
has no support for.

Matt Turner (3):
  target/i386: split the FNINIT out of do_fsave()
  linux-user/i386: write the floating-point registers to a core dump
  linux-user/x86_64: write the floating-point registers to a core dump

 linux-user/i386/elfload.c      |  7 +++++++
 linux-user/i386/target_elf.h   | 18 ++++++++++++++++++
 linux-user/x86_64/elfload.c    | 11 +++++++++++
 linux-user/x86_64/target_elf.h | 20 ++++++++++++++++++++
 target/i386/cpu.h              |  2 ++
 target/i386/tcg/fpu_helper.c   | 13 +++++++++++--
 6 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.54.0


