Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD51C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 10:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOZww-0004eh-OD; Mon, 09 Jun 2025 06:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOZwu-0004bx-H0
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 06:41:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOZws-0003XI-I5
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 06:41:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so2268957f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749465708; x=1750070508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Q/Ogs+91df7JDSU2cLauherZ26laONYOWUSDnOEinc=;
 b=reFaDTG8oNT9cmEh5OxJvhV5KtTeqoenCO5vmr1Mzg5n/ErOYLOVigWlmyyEzJ0NXP
 7vEziqINr5VFHu+qfNagWJBHXASf8C0yuwDH+w+09PX0YP+Q3q2CTYWebRaVwVc/hpoj
 7mo2pbAG5IPR5IAq7ESdoPLO4ehqKx6qb7KKi7GEZCben1mshDcEMCafrVz+z5MCxXxv
 sJFXxYIlICbflf4c/+EUexo70Cs9JTTM6LFJr/g1pzhdJxKR4ulNdCpVe2zT5CGCfl+K
 ZHn7uZsrHEF53VaUmKuTQudvYfOUQkJREV0uV/IJoK3Fa1g3iaZE1T4A61vDbMh7UdVq
 PpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749465708; x=1750070508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Q/Ogs+91df7JDSU2cLauherZ26laONYOWUSDnOEinc=;
 b=Is0QIwIBc7njvUDzKl1bzrxFilqzMtNyHbGMOu+En/osaNEopDQo0kdKrQY3WnzXTr
 2PP0xLeOuKRCHrQaFYX+NTUx/Hzy0zVUiTsbPxrXAItVHhqz6tK6vIjkZ3sV+KCjvgdB
 Ex3PTDrI4wE3Lf9fn7qlBgfv/b3GtS/wY/K42pETvuklr7D5G77N30SO9/tUDgvC2WJg
 PYStbC/0xiauRVTnvrUEsLsESCqplUuTNawH8Yi0xad+OhtIkbunkqKGXbFgEogBgeUT
 raVLQ3iCdB4cfMAX5bRfVRBRkYLirEqlHW2LTgytJldCkmKo8IJ+gRVjOS/q44YCRSIf
 5SvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6aybypFuQiBo01MUSDYR/K2RkoLhs5ZNi6KYJH2vxhwBfVAgs9ijGvpwZQFojL6O0RdN5BfSlXChg@nongnu.org
X-Gm-Message-State: AOJu0Yw39FYaIVs+9fkaKAmSEiNzXwi/3yGFYCAgaE3/QozG+IEgzqc/
 ioIIL1YjCUNTs/2QfpBzc08rNJvtsPVsflNJYrjAYErACn2tuR0Vt2IOkRu9ngcJrzk=
X-Gm-Gg: ASbGncvXY0i62BffJAr+H2EeohjCoO093m6xVyMhR+4oUzxXHV7FJaBJJau+3lyClyB
 NH9dkujd+YqUyRIOimVBP8ICmyOltROxDnHdW1nSgIPKocHBKepuN6IeVgQPscNxskKnTx/SSIK
 pys3+pHm3DAWgHAOaHI31FTc2Ak6x0KgROFV1t8w+LSDhjXDTS/9wWICLrJ689rl2oDfVrulelO
 n1alVBSQ891T/5OkQf6MUllJtmPt4dk6Pd7T2A0iL5km0L3TrGpdHsXa+wCWbxx+7ZhG/9hx9+G
 tzf30HiU1e3y36VzIxL7HEEC7+YbEKC4wImOZTyaejCEVe22fseTTKJaqQ==
X-Google-Smtp-Source: AGHT+IEeMPP7UzFRUbtEUFbqyAa6G87AxpvdfDF/Moo6NVxmoQbbW3dw+iwlmbnE+C1oOaNaZ8TPlQ==
X-Received: by 2002:a05:6000:1a85:b0:3a2:ffbe:3676 with SMTP id
 ffacd0b85a97d-3a5319b4571mr10389158f8f.49.1749465708346; 
 Mon, 09 Jun 2025 03:41:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324361ffsm9098991f8f.47.2025.06.09.03.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 03:41:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/arm: Implement ID_AA64PFR2_EL1
Date: Mon,  9 Jun 2025 11:41:44 +0100
Message-ID: <20250609104146.1547437-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The ID register ID_AA64PFR2_EL1 is in the space previously reserved
in the system register ID space, but recent versions of the
architecture have started to define fields in it to advertise the
presence of new architectural features. We don't implement any
of those new features yet, but will need to do so at some point.
(Notably, the GICv5 beta spec defines a field in this register
to advertise the GICv5 CPU interface.)

This patchset gives ID_AA64PFR2_EL1 a backing field in the CPU
ID regs struct, defines the field names, and reads it from KVM if
it's present there. The only visible behaviour change is the
name we present to the user via the gdbstub.

Commit 1 is a code movement one to clear some more stuff out
of cpu.h that doesn't need to be there; it's mostly because of that
that I'm sending this patchset rather than holding on to it until
I have some GICv5 patches ready to send.

(Compare commit f7ddd7b6a1f90c from last year which added the
ID_AA64MMFR3_EL1 register.)

thanks
-- PMM

Peter Maydell (2):
  target/arm: Move ID register field defs to cpu-features.h
  target/arm: Implement ID_AA64PFR2_EL1

 linux-user/arm/target_proc.h |   2 +
 target/arm/cpu-features.h    | 414 +++++++++++++++++++++++++++++++++++
 target/arm/cpu.h             | 410 +---------------------------------
 target/arm/helper.c          |   6 +-
 target/arm/hvf/hvf.c         |   2 +
 target/arm/kvm.c             |   2 +
 6 files changed, 425 insertions(+), 411 deletions(-)

-- 
2.43.0


