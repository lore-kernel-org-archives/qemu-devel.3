Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD178C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjI-0002L3-VH; Sat, 02 Mar 2024 00:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjF-0002Kb-D7
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:09 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjC-0007TU-6N
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:08 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c1c913508fso1687180b6e.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356564; x=1709961364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5Z9CdEPCUKQg0iv5SGMW8Q6iicBtVqSsJ6VGY9I+po=;
 b=k2OAYxWYKQM2OWxp8IAlHV4DsUODI9yR6eHhu7pCSplVXGF0kN/IE20Py08qCkC72E
 A5EBMNNtAH+rDFYQfXt2WOg7lHV8gq0vKVJYp0dUS94v56/9vDZ8fp08SWYrNFGr4nJB
 aEVJq+UOjkzxYuiGJG9Xg//Hr/4IZ30YLKIn9BibBEWghdS3w+0HAkPeYsyfA6ctffUS
 eWvAjphDiUjMNJb+F58JK0TOBZ4IJnRGffIlQy/9PSA2goovrYpbGLOt+6co2WiOFPO2
 hk8whSIT/seEtMfnOGfjjjA1k1hhv0DVdo4ChkJun+RUXyv8YWjHpAJtocB4pZleMVTt
 eYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356564; x=1709961364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z5Z9CdEPCUKQg0iv5SGMW8Q6iicBtVqSsJ6VGY9I+po=;
 b=gbCpQZB3V/j5K0XBky8sjvCcQdKLZmNCbcbL1pM+6phOdQdorAKlaD9BjwF3g6wmuA
 L6nHbCnMeDm/if4th7PmR8uAwmw+l/sejkxRH5tiqP1YjFjKU2e3cmjIhyNWO/mo0N1u
 Mp9ai0dwYeNYOnBI/5rLqb7o6VOgu+5nv22Aa4jLUNY3YMLduhnFTEhrII7LyYpAQvgw
 gDYqGwY/AaDwRaLYM6O39Za90SWBJMAffXYW5qadH/q7VMizf5WUQzalhhCrRosWinao
 sLmQ5t9del6j1aQY1xUGJou3NWIm3seRt41zkrvcsEpw0Mm3BLvic65NtkSwi5HQjenD
 gNXA==
X-Gm-Message-State: AOJu0YxYDA1sAbL3vVvwFma8BQhd18/TyGP25ToYM4GvrfoyTbgGGgfF
 Dy2CrbwB3VoS+vi4YOGLElGpq9jEKbmKhgdV5zmVxZMAklOQ3ccjApfFdKJadNX76yoVtu7+ax1
 K
X-Google-Smtp-Source: AGHT+IHEsi5ystCqEsnY3FLVtHLLNvb8AfuCK3Ycl1dLl2kjvm5GupBLPpZyQV6fk+biwxZWDzYqvg==
X-Received: by 2002:a05:6808:2082:b0:3c1:cb68:1f20 with SMTP id
 s2-20020a056808208200b003c1cb681f20mr4995847oiw.3.1709356564696; 
 Fri, 01 Mar 2024 21:16:04 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 00/41] target/sparc: Implement VIS4
Date: Fri,  1 Mar 2024 19:15:20 -1000
Message-Id: <20240302051601.53649-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

I whipped this up over the Christmas break, but I'm just now
getting around to posting.  I have not attempted to model the
newer cpus that have these features, but it is possible to
enable the features manually via -cpu properties.

Possibly the first 6 or 7 patches should be taken sooner than
later because they fix bugs in existing VIS[12] code.

I remove cpu_fpr[], so that we can use gvec on the same memory.


r~


Richard Henderson (41):
  linux-user/sparc: Add more hwcap bits for sparc64
  target/sparc: Fix FEXPAND
  target/sparc: Fix FMUL8x16
  target/sparc: Fix FMUL8x16A{U,L}
  target/sparc: Fix FMULD8*X16
  target/sparc: Fix FPMERGE
  target/sparc: Split out do_ms16b
  target/sparc: Perform DFPREG/QFPREG in decodetree
  target/sparc: Remove gen_dest_fpr_D
  target/sparc: Remove cpu_fpr[]
  target/sparc: Use gvec for VIS1 parallel add/sub
  target/sparc: Implement FMAf extension
  target/sparc: Add feature bits for VIS 3
  target/sparc: Implement ADDXC, ADDXCcc
  target/sparc: Implement CMASK instructions
  target/sparc: Implement FCHKSM16
  target/sparc: Implement FHADD, FHSUB, FNHADD, FNADD
  target/sparc: Implement FNMUL
  target/sparc: Implement FLCMP
  target/sparc: Implement FMEAN16
  target/sparc: Implement FPADD64 FPSUB64
  target/sparc: Implement FPADDS, FPSUBS
  target/sparc: Implement FPCMPEQ8, FPCMPNE8, FPCMPULE8, FPCMPUGT8
  target/sparc: Implement FSLL, FSRL, FSRA, FSLAS
  target/sparc: Implement LDXEFSR
  target/sparc: Implement LZCNT
  target/sparc: Implement MOVsTOw, MOVdTOx, MOVwTOs, MOVxTOd
  target/sparc: Implement PDISTN
  target/sparc: Implement UMULXHI
  target/sparc: Implement XMULX
  target/sparc: Enable VIS3 feature bit
  target/sparc: Implement IMA extension
  target/sparc: Add feature bit for VIS4
  target/sparc: Implement FALIGNDATAi
  target/sparc: Implement 8-bit FPADD, FPADDS, and FPADDUS
  target/sparc: Implement VIS4 comparisons
  target/sparc: Implement FPMIN, FPMAX
  target/sparc: Implement SUBXC, SUBXCcc
  target/sparc: Implement MWAIT
  target/sparc: Implement monitor asis
  target/sparc: Enable VIS4 feature bit

 target/sparc/asi.h             |   4 +
 target/sparc/helper.h          |  36 +-
 linux-user/elfload.c           |  51 +-
 target/sparc/cpu.c             |  12 +
 target/sparc/fop_helper.c      | 104 ++++
 target/sparc/ldst_helper.c     |   4 +
 target/sparc/translate.c       | 960 +++++++++++++++++++++++++++++----
 target/sparc/vis_helper.c      | 526 +++++++++++-------
 target/sparc/cpu-feature.h.inc |   4 +
 target/sparc/insns.decode      | 338 +++++++++---
 10 files changed, 1626 insertions(+), 413 deletions(-)

-- 
2.34.1


