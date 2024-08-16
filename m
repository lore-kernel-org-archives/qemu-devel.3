Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA7BC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serIx-0006gX-3U; Fri, 16 Aug 2024 03:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serIv-0006Wl-CL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:21 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serIt-00041O-8h
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fd9e70b592so17717265ad.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723792997; x=1724397797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7o74z2jYqMnAGW52/hRgkdhTpNI67oRRMh60yVxM2GM=;
 b=Yd8zNlF9ZWNfxFZltf2O+BoBuNNi7HmVLZWYBPEJ1TTDtjLB5+w5B54BimiHg44kMf
 iDZVn6t2gm6izKFPoKdgqRdQfDLBfoXSGROorvd2H+cm8terrFVWHoHDK+mQbIYn1lRF
 c6r9cw/p5Wmf3qrgUCbtF6ScHehrRVyvJeM5RBiM1WXG6lWw2ez/bHc0l7dK/jaZk+P+
 Rjh7rl86+/1IoBBfCVkR82EvMeAhryZqg9Pwzlcped0mf/qogPap1zGvhuZXU3zZI2tb
 XTR2SaImKWdpFGEihHCsyi2lZkUkLr7yBsuab9mfeFKP2lVJcPXa5Ow07QYghahenMOT
 jOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723792997; x=1724397797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7o74z2jYqMnAGW52/hRgkdhTpNI67oRRMh60yVxM2GM=;
 b=OkqkdvczKqZTtsvodcZ7dA3SBx2kVVqJMXp+nRIOFLeT/43OHWTFNrt/o4UTJuLcIw
 NGz3GnKId7QufwSOjRVy5WPezh9HMsCWI1NdV8HlJ+jEDfvwl6kSts5mg6Q6OGWWFz+i
 aMz0ubGikNZaCJfbe0cZjqDRwQVaGzXq1IR+E/80nHd3FgAPW/z085LLRT8IER+GtDwo
 8M/fy4Hk2IHtoQWds5ESbBSgBAFHYNI0q3mD1mUB0rsAETFD5rizgmd1CIKuxfAPXCSu
 5iLoUts95GU8/MgJEv3sjZGEKs9YTyof6yuecI9CN6pPFV/5Ewv7AVsXJZRCGc77Gyvu
 6bQg==
X-Gm-Message-State: AOJu0YynuKgxvKWG5mm85HjoqhFF+09gZnzmEsqee/uH75RgL6j/sxdj
 zCwlUvqgg/GhBBGIrMs3MEcc3CCB00XcBppNptTZ08KMpfnpJ+oRwPGZ3v9dT/0nnmVA8FTdgiI
 4K8I=
X-Google-Smtp-Source: AGHT+IFwcA+itW/JICDn47N7jviXopaKgM5Hlt1cwHGodVwHfBiXPuPBsh7L+pSPS+Uf1bRlQYARsg==
X-Received: by 2002:a17:902:ea0e:b0:1fc:86cc:4254 with SMTP id
 d9443c01a7336-20203ec5f75mr28991285ad.33.1723792997278; 
 Fri, 16 Aug 2024 00:23:17 -0700 (PDT)
Received: from stoup.. (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f037588esm20195525ad.171.2024.08.16.00.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:23:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: chauser@pullman.com
Subject: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps
Date: Fri, 16 Aug 2024 17:23:05 +1000
Message-ID: <20240816072311.353234-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Hi Carl,

While digging through the manual to figure out if we were really
doing the right thing raising the fp exception, I found the fpu
exception state machine.  I'm not sure it's worth emulating the
fp_exception_pending state, but it's certainly easy enough to
emulate the fp_executing/fp_exception states.

In addition, this simplifies the implementation of STDFQ,
restricts FQ to sparc32 system mode, and handles migration.

Would you please double-check this against your Solaris images?


r~


Carl Hauser (2):
  target/sparc: Add FQ and FSR.QNE
  target/sparc: Populate sparc32 FQ when raising fp exception

Richard Henderson (4):
  target/sparc: Restrict STQF to sparcv9
  target/sparc: Add FSR_QNE to tb_flags
  target/sparc: Implement STDFQ
  target/sparc: Add gen_trap_if_nofpu_fpexception

 target/sparc/cpu.h          |  30 ++++++++-
 target/sparc/fop_helper.c   |   4 ++
 target/sparc/int32_helper.c |  32 ++++-----
 target/sparc/machine.c      |  25 +++++++
 target/sparc/translate.c    | 126 ++++++++++++++++++++++++++----------
 target/sparc/insns.decode   |   4 +-
 6 files changed, 169 insertions(+), 52 deletions(-)

-- 
2.43.0


