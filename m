Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8036EC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzxo-0002VM-M6; Tue, 25 Feb 2025 13:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzx1-0002Bt-I1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:43 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzwv-0000HG-I6
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:36 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so945998f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740509191; x=1741113991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSVra8nBfTZ84QaRLv+FUaCWxVEY3WH1UDqPpiF+8yM=;
 b=Txt8npCXbTlJhDYWeTJ0p5Bm8PUlsxol5ekRGeBFzl5RSsqfG4c7fCjrHFf34lcvfp
 /8XtXQ+M3Bh9aFC7YZg7783zFmkmxqLyeI1yvrRGh4ULB/l6EviK4GMQ0Em7b8Uu3u04
 imqrsFtsaBhmaOr7YBaU0fb1TDuMmd2WcHzWshKCLOTw+jt3Pi0h8y293t88RoRbwx2v
 FvVuqZ3fFMF/swlH4h8MIGOytjYH9gm2fviFITLLeTDrFf+aHUoSIiQehInoLmcYD+pu
 IgbJXqANduyWGXCSIyZxdqBXK+P9Ob+URm21xQfbcTqX4dcTkwEs/bNdHjE8E1eVthZV
 XqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740509191; x=1741113991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSVra8nBfTZ84QaRLv+FUaCWxVEY3WH1UDqPpiF+8yM=;
 b=td3lgdqQk+RzLbaYMrA3rnvzAfo/7aYfl0etntQH+tpyVzsK1BtlE3JaaMVmV/zQ5O
 Nd7kl5trlR01EOwM8MzRkQK0UOn4cwvqr2k8YFRkCicsJUHklYlaQK78n4cMY0T6bTmy
 C3dfaebgJ+EtqZow8M+97PwSutGhZ2dfS+khUSqv/An71tvnNVZTWEZ11KpjFyuq9+E3
 ZwhK8Xule3/4DEKsHZrNdTIdYoYOI48EAkQ/leEoi193BVpTlN+GpRJL3H5obNN1kKm3
 IDHiXD8jcDPKTVyF32PxgwncRGpSWwTrP2fNVkYaDR29X9KmaV9Yv/gch+NddjyBvRq2
 X4eQ==
X-Gm-Message-State: AOJu0YxX3wU/G8gNZvnd79UrtVJ4MsM2JuRptfInRBE3HlIQxBeLVrQl
 keP8/PrEfnjX2PjhrCQ4fgE1HyqiEQFYAr4nM99Jr691uhaXxzl6UdVAxvC1RXA=
X-Gm-Gg: ASbGncu8aPvX3uehSlwD/tTE9gTJ0qruzIXZqPx7bZh9BvqMwomWryOaoyBGRukP8FR
 jB0hFUwmOZ5sNxiXcAZb1S3puvvjZzBSrW8LGTZ5/unMs2iCekVefphKFJkKhLCNbc4n9U6yk58
 e3hlyquF/5Ks687uL619rhiokExieumUgF9Hu2g/RpUH15iGV1ek1BCfptBvuzDYSeGX5qH43rg
 eOkGaLVCw66EH307D2MujhHobJiKWXsJLGVnsfq4gnZ5hT0EyAZW5+e0FvqVJE2I4LIEn5exsB3
 8C/Lh2Uj8T9ZPa1xZA8pi18GtwAP
X-Google-Smtp-Source: AGHT+IFibIKuCXd0/zjGl376aEjluvPdXTC01vBJiJAv/QjlYySpH64ia9+neba1rTnRAXgYmn1iQQ==
X-Received: by 2002:a5d:5847:0:b0:38d:d299:7097 with SMTP id
 ffacd0b85a97d-390cc5f5858mr3915637f8f.5.1740509191428; 
 Tue, 25 Feb 2025 10:46:31 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd88300bsm3243560f8f.54.2025.02.25.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:46:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D5B55F7DC;
 Tue, 25 Feb 2025 18:46:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] cputlb: add tlb_flush_other_cpu
Date: Tue, 25 Feb 2025 18:46:24 +0000
Message-Id: <20250225184628.3590671-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is based on one of the fixes from Igor's series:

  20250207162048.1890669-1-imammedo@redhat.com

Rather than reverting the patch I cleaned up a couple of cases where
we either didn't need to do a flush or we could trivially defer to
when the CPU started running. For the other cases I introduced
tlb_flush_other_cpu() for users like reset and post migration. Any
other users wanting to do a cross-vcpu blat everything function like
tlb_flush() are almost certainly wanting to use a different more
targeted helper which still supports queuing async work.

Alex.

Alex Bennée (3):
  target/ppc: drop ppc_tlb_invalidate_all from cpu_reset
  target/hppa: defer hppa_ptlbe until CPU starts running
  cputlb: introduce tlb_flush_other_cpu for reset use

Igor Mammedov (1):
  tcg:tlb: use tcg_debug_assert() in assert_cpu_is_self()

 include/exec/exec-all.h   | 20 ++++++++++++++++----
 accel/tcg/cputlb.c        | 18 +++++++++++++-----
 accel/tcg/tcg-accel-ops.c |  2 +-
 cpu-target.c              |  2 +-
 target/hppa/cpu.c         | 10 +++++++++-
 target/i386/machine.c     |  2 +-
 target/ppc/cpu_init.c     |  3 ---
 7 files changed, 41 insertions(+), 16 deletions(-)

-- 
2.39.5


