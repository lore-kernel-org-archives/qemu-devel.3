Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B76C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Ey-0003k3-I3; Thu, 23 Jul 2026 23:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Ev-0003ih-8F
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:06:22 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Et-000841-Oz
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:06:20 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so1189982a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784862378; x=1785467178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=REXTOEsp2HyYnmAdGIMEoBoC9BJd0XoRd5PTLKWdkXg=;
 b=KwEt6MBIR5HCUdQ5Zx6nHpy6wRxydMKBj9p9bNfau2tjO4OMpmDScKTu5tnw4zgxC0
 Oh3VfF1gR9i7noakXIMKFcRa+FS/JsDcF2dl95sHpi3fnmppwkNx15TJlugMKYKK00in
 xDbGutt3Bv+0PIdnC7jSKhZ12KVbfNBZGPh74SYBNc7Irnj2llCJ0aiewczFLTZMekrz
 bT+gyNV367OLU1a40MoeO9og4sKGdYLV94DXj18tv//SCm7SpuWMNBxTt4badp89NoDi
 jk2GouFgVLCOSwCzFedlawqkiGE0BtmR4g0HCf2sZtSe18x9yvqx0fiKfF24HGT8Ai+q
 NKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862378; x=1785467178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=REXTOEsp2HyYnmAdGIMEoBoC9BJd0XoRd5PTLKWdkXg=;
 b=Cu2hereJZGLB59DrLiXVedRjOko7JFFMpjZDUDeIiN94O5WZ+noU3VqbgCStboSzi4
 s9MGLjZ2cQbRNrXAU96ZesPqHVPj4a6lGm1zGnKhLR4WgFCpxdMyHV936B4vzafzZTOK
 CokVdiC08uelpr9d1I5jIty706DEEZF3eABVhNwcfruSPRGS1oI56cw1skrx5vNJjplV
 KWmHaM3zVOIU3cW4cxYYbt/eXFfresW7C1h1L0cNTLSf5XPyVyQJCo7cAV4/DzbiwCAn
 SpLD/4q4tpZomtGQnRQRx/bw6kMg6p0g8faHBhvoL58E8HgLKZ+Iy+MBvn5oJcmRHb0s
 Dx9w==
X-Gm-Message-State: AOJu0Yz9iFDZTuQeAQkuVZ+AF1U6a5BKr93Gq8xgIhYc2rfkv3kz0gZt
 fvQjdIKbjdv0n90ihc5BU6zi4qzyYWbwsLFsNxeSrb7oFI/m8r76EGe+Dnt59wZMl5aWTglU+9N
 qqM7/
X-Gm-Gg: AR+sD11NA8IM5jwOU4oSONAZws8qjy4Fwy1hofpQV3/Cz/D5InDAdlH5PwRtTbaZBjU
 H6loZJGuWDFjouc+ClpqGG11c083e9Dos8/nawhWAuV44Y6yPmOi0iQiKc+reQjGB/ZRu/ZbSw2
 5sRLlBthPZmuj8gcS1lXj7JvNTYPQak+qNUA7DZH+2VEJBfPaiLcfFXE/QiTjadaolQziIt36nL
 75RWZJ3vjRQKOUa8IpnBA9RNqwMhfsYRC+b3CJ2faOZ5VHeAPDuuDdUHY5X2K46zIfzgm8oX0jq
 GG5LkBaWvMn3hFKLuZKoAO8Lp5d8ftoi2rLn++iIBornkP5cP7CfFaAbXDxtmN5Jt/e201+3RHX
 OvpmnNn/SMP2sdW9cghZ3ceHeOu0HLQCdyKP8g/k5ELUNElUiUUsIUDyx5j7lUB+FqG4d8nfi6a
 pBL72wWiYdByNHo6Gu/nADed5vCS3W8/Kmhw==
X-Received: by 2002:a17:90b:2708:b0:38e:6aa7:686f with SMTP id
 98e67ed59e1d1-38ec6aae578mr5297902a91.36.1784862377680; 
 Thu, 23 Jul 2026 20:06:17 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03ad0e0csm750777a91.7.2026.07.23.20.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/6] target/arm: Implement FEAT_FGWTE3
Date: Thu, 23 Jul 2026 20:06:10 -0700
Message-ID: <20260724030616.76180-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Similar but different to FEAT_FGT.

The EL3 version traps writes to specific EL3 registers from EL3,
and one cannot disable the trapping once enabled.  The idea being
that after firmware boots, system settings are not expected to
change for any reason.


r~


Richard Henderson (6):
  target/arm: Add FGWTE3_EL3
  target/arm: Add FGWTE3_EL3 bit definitions
  target/arm: Add FGWTE3 FGT bit definitions
  target/arm: Implement FGWTE3 traps
  target/arm: Set fgt in cpregs for FGWTE3
  target/arm: Enable FEAT_FGWTE3 for -cpu max

 target/arm/cpregs.h            | 56 +++++++++++++++++++++++++++++
 target/arm/cpu-features.h      |  5 +++
 target/arm/cpu.h               |  2 +-
 target/arm/cpregs-gcs.c        |  5 +--
 target/arm/helper.c            | 66 ++++++++++++++++++++++------------
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/op_helper.c     | 36 ++++++++++++-------
 target/arm/tcg/translate-a64.c | 13 ++++++-
 docs/system/arm/emulation.rst  |  1 +
 9 files changed, 146 insertions(+), 39 deletions(-)

-- 
2.43.0


