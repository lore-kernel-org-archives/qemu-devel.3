Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107D1ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sninH-0003VW-1w; Mon, 09 Sep 2024 14:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninF-0003DJ-I4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:17 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninD-0001wO-Nx
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-718e9c8bd83so1166214b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 11:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725905234; x=1726510034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+jTEVG+XnH2tjor10MScLxMkVt4FhiNIEwMtqUjev+0=;
 b=FpT5svoI83teRh1eikclMYL92YXytF9q8GSQ2NKbOKHy2Jy3aveqpKa6wKUR2/u/+W
 r0l9jnMe5JrDJBX4m1F3fVFRBgvOpjQSkgAcpPa6tJGqxfligWXn2RLfL/WXBFyq72sb
 /Qso/ElLSjCUVX8Kpxt0C7Y2so5NxCiEwjUgqoZCtiU2Cqk2aDlGg2FP/rsP0PXhG6fL
 ry1As25B4dx3QTyQ3+OpNKRmO68yJ4ePVpRMPGpWEiDjRtEOXzOqG5M8wpKyHlm+N6qZ
 kqP9KhN02ps8BhFpk+AoR+TDsoWINeqaaUbBuTkmunhhvdE1svc3K194biB9G8oVsKo0
 y5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725905234; x=1726510034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+jTEVG+XnH2tjor10MScLxMkVt4FhiNIEwMtqUjev+0=;
 b=gtumWPTUgZpum7z0TH/ZaJCjpvp7D5hWh2mTomBBhWQot4LWMgvM9i/od8dgqa0oBO
 5Mzs0NN/WFEYksdR7vTE3LpegdXMjVifuQDo/Y5SfzSwXHFBEEb5C4XgUkflpgSZtMni
 4OfOLOV++yQBEVaqcrWyGV65PFRqVMBMhzgH7/4HZpdBh4QehUgpfTJ7Tj03jB3eKa+z
 pk+Iypc4CvTdQEsGgjW8r+nUTe8fyNL+5gCmZXph0PtgFwhPqpunl9+z0j8k0ZdMAHpY
 ihceUGlnxjej+aBS1Qtm3FLIUNryQG48KmHOp5gMOkzRZMm3w0cJynVjNSNZuJkTGGna
 G5UQ==
X-Gm-Message-State: AOJu0YxWF4hgQCaJKm8t6EMz5yDPhimIBLDR87WpzY0fkMXvJa990p8l
 Qy6H7ODC7xOPTr09/5I8nId+7tLAdr2+M528DeyHxLQ5ho96alOu4dacGTxHN7mFZ2UvHC7Z27p
 W
X-Google-Smtp-Source: AGHT+IHpex90i4j+kMHyKDUfpBEkh0cm46hPB0gxEZTiZvdnYICW2IPMcZGi6B4g5z5EuNjicANIyA==
X-Received: by 2002:a05:6a20:43a0:b0:1c0:f114:100c with SMTP id
 adf61e73a8af0-1cf500944d8mr680958637.17.1725905233963; 
 Mon, 09 Sep 2024 11:07:13 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc84efsm25431b3a.8.2024.09.09.11.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 11:07:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	chauser@pullman.com
Subject: [PATCH v4 0/5] target/sparc: emulate floating point queue when
 raising fp traps
Date: Mon,  9 Sep 2024 11:07:07 -0700
Message-ID: <20240909180712.651651-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Changes for v5:
  - Fix stdfq advance_pc.

r~

Carl Hauser (2):
  target/sparc: Add FQ and FSR.QNE
  target/sparc: Populate sparc32 FQ when raising fp exception

Richard Henderson (3):
  target/sparc: Add FSR_QNE to tb_flags
  target/sparc: Implement STDFQ
  target/sparc: Add gen_trap_if_nofpu_fpexception

 target/sparc/cpu.h          |  30 ++++++++-
 target/sparc/fop_helper.c   |   4 ++
 target/sparc/int32_helper.c |  40 ++++++-----
 target/sparc/machine.c      |  25 +++++++
 target/sparc/translate.c    | 128 ++++++++++++++++++++++++++----------
 target/sparc/insns.decode   |   2 +-
 6 files changed, 178 insertions(+), 51 deletions(-)

-- 
2.43.0


