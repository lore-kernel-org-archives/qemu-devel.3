Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27C9C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjsd-0008Ud-Jy; Tue, 19 Mar 2024 20:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsb-0008UB-T5
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:29 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsa-0005WD-4L
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:29 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5a46abf093cso3592785eaf.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894746; x=1711499546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zxKLRwGt/Yd9jhWxRIakTso69321P1/S3JEGr1phd9Q=;
 b=uewdy6JGQ/7eBfNgwP6PdWWdLC64ns7IW71MZ8rClFwAMliohWcy6AIBlMtAEDbdrA
 iRPZDIP/4OAstODMUN46lOJjepIZpAHve0VWCtMooTyBWz+tZ8BYqZ7U+9cndWtL50Vp
 5H3Fa8JM+bDX3BEjQy8hAf7xc/eF1yqbDNR/LFNOBZdWAIoJIXvNDNOCXG/t4cA2ePKJ
 8CcZZlJWs8LLSmDOF/US/Tew75nnftqvUnPhb0pmNxlRvwILygn/N3c79qNknDCkgHwD
 dg8o7fB4SfArM0yZyIuIFCDJTzt5l8ISWtl1xJpuk98n4KDUfv3fAAUcnAqjsRXprU97
 tJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894746; x=1711499546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zxKLRwGt/Yd9jhWxRIakTso69321P1/S3JEGr1phd9Q=;
 b=sqC4m9+IugcGS2GXZqoRdF0+haGhPpSHhehlE8kCwFWCNlj+n9LNaLypOnr8BC35vi
 bQU+gDEGk6M4NIEe1XQBRPwmI2uJZCRoalOZX2+fcosIVXX9BQXDE8a63LYS/Y35+HMV
 fXodKSfKMYYHFuWEn42J6eDTjPDwbmHfNtITnX4sRRsVeghtpAw3SWOxb+9nFO1WyxUD
 4ND3ibffQPv2v06VCmLDDwMLIms0jEynfmdRECbEQEzDz3uWciXM02KlBp1ExXoxpkTF
 QdtGoRqMJa5W+3PFxksM2RrrzpuHxkqkG6bY5dPQQ4PXXefxUQPPciW8AxfauAtaj51f
 sRcQ==
X-Gm-Message-State: AOJu0YxziguPSeeChoZXusIrohvDLletc8JxQdJfiKq66MY4Wva1r+dj
 grMez4WJBLkdaTw+EK1Q8gC7gGGgVaiFBtlN5vJX9VSgIi/2+MROe90yOtBA9P+OTcrxGt1DJ9K
 n
X-Google-Smtp-Source: AGHT+IFUyn/ym+Jw7eLLoWIWLwAb79ar+MABtyHGQcfa7ufpMsFXcXe4OPh6aC1qC0Kq8xN3acyg1w==
X-Received: by 2002:a05:6358:7214:b0:17b:78f1:b4ea with SMTP id
 h20-20020a056358721400b0017b78f1b4eamr19774345rwa.28.1710894746025; 
 Tue, 19 Mar 2024 17:32:26 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target/hppa fixes for 9.0
Date: Tue, 19 Mar 2024 14:32:14 -1000
Message-Id: <20240320003223.554145-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33fa7:

  Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-pa-20240319

for you to fetch changes up to 518d2f4300e5c50a3e6416fd46e58373781a5267:

  target/hppa: fix do_stdby_e() (2024-03-19 14:08:02 -1000)

----------------------------------------------------------------
target/hppa: Fix load/store offset assembly for wide mode
target/hppa: Fix LDCW,S shift
target/hppa: Fix SHRPD conditions
target/hppa: Fix access_id checks
target/hppa: Exit TB after Flush Instruction Cache
target/hppa: Fix MFIA result
target hppa: Fix STDBY,E

----------------------------------------------------------------
Richard Henderson (3):
      target/hppa: Fix assemble_16 insns for wide mode
      target/hppa: Fix assemble_11a insns for wide mode
      target/hppa: Fix assemble_12a insns for wide mode

Sven Schnelle (6):
      target/hppa: ldcw,s uses static shift of 3
      target/hppa: fix shrp for wide mode
      target/hppa: fix access_id check
      target/hppa: exit tb on flush cache instructions
      target/hppa: mask privilege bits in mfia
      target/hppa: fix do_stdby_e()

 target/hppa/insns.decode | 55 +++++++++++++++++++--------------
 target/hppa/mem_helper.c | 80 +++++++++++++++++++++++++++++++++++++-----------
 target/hppa/op_helper.c  | 10 +++---
 target/hppa/translate.c  | 77 ++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 166 insertions(+), 56 deletions(-)

