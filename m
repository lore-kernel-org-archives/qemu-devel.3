Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD217FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuP-00064K-U6; Wed, 29 Apr 2026 20:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuK-00063K-Vg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:34 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuJ-0001hC-7H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-83178c0f29cso245912b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507529; x=1778112329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L+i1jTybChzyNmkhGpzqaeg2X7K0ju69Tb9WDIQFNbY=;
 b=A7Pqa9d2vKrnBv0p/5HDVZyxbT6hPH3bjzINeXAcodFanh2Ia5R2o4Ufh3yhWmUbDp
 wF4hHZhPsiuFIkdH3Hx6gfqwbyXvDaVQYfkhjl6lXoRf8K3hQKCdbsR4rx9tW7EO98zk
 /nvVq6Ce8hDy4ZTR748YqNP853wITCHpmZQM0+OnlE/qqZcqYs3UsY56qhApIibyYri1
 s3mYzqeWOyauqQzUtno8KbB3D5CIwQ1qKgItbuGzEBeEkZuHrW2yg5bynPe9uCB2KYqP
 XGG7locYcLS6AQlhWiEgTGKoA1grk/qi4CpKZ/zZZNI0qlLCu4vq8lRfokcNS/7pe4LV
 ewLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507529; x=1778112329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+i1jTybChzyNmkhGpzqaeg2X7K0ju69Tb9WDIQFNbY=;
 b=fwk06HVo2GEBaq9BTNi29ZUl78BOmTnvHX/sAmV+RQZ8Belg9dm9kqQx1moZEoixs4
 vAKHD5GWTLG5IJpAUdcylk5ERsnJlYwBOKnQ1uPjmMpQOOu7TzztER61ptBxqoGLuOuw
 rE9roE4FXf+0JrVpgX0MfHw8rqZT9CjB/HcGCCtonI/lDnKyBlCVx5DuPR+V4mUM73v6
 K8oonjtrWp6BbHJlQLUnoTnKapGWknb6ujUhyFCmK+79w6J86ar3UXsizeurCehQmd4L
 AzH4+A/FCDMdRUf9Kk7LKt5yIuo2K1Uy/CyWrR7Ka4mugSyozFpsDz6gVS2HYSC76ZDh
 5VaA==
X-Gm-Message-State: AOJu0Ywu4sNyjoT01Bk0d8+s2pZoXXNOxhYBdqgeKy8Sq42IybwsCmUO
 sYnWJqdamiosCEcFAtd88+tDmabi07yKhfMpzMdU79qDg6HJPrk40Myg3+NL7j3DP06zDcnxAq3
 OUd2ST24=
X-Gm-Gg: AeBDiesCXX7tOZFV5sBF0QM17NgILAtK+u9f7vBe44chpRvNEiPvliTI2O/g2Xx8mr0
 gpvywhPKN01sPxh+YUS5fOpF2aaoRlOTJRqpvIzeBjozrY4ZuJE/AHvG4+nL0GPF0lZMPo9BHRI
 PB526QbOxBmMlfz7gAFfNrk5+0vbeshJCzK0sQva4W3IEWYxMXlY/xBdMEjnFirCfHbDMRc6EWZ
 oUtYIuFfQ5AQ3XaVC1mwr6TMKUP+mepsPD+qJj8T27PitWUt9GbCcKGZVBjUh7m6mfD/ZPA9qjC
 pp85gaRSjR6i6eiDjqdhLeVQnLTbIDsX/GNxUMhao32hln7wYmJUGVjWr9MWnu4Fv5ZcRJFxhOh
 FPvUSHKcOAWwEDGwI5r9KuRQKEWLLdEfNzgyy4h3qvGaFx/ZekzWVgQ6pUCW4CRyr24sShraXOb
 U6ISnmXvi6ij4sqIkkt2YG/msOrA21UEEc87Om8b36
X-Received: by 2002:a05:6a00:2d0b:b0:833:22e9:2cd6 with SMTP id
 d2e1a72fcca58-834fdb34545mr851354b3a.16.1777507529448; 
 Wed, 29 Apr 2026 17:05:29 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 00/40] fpu: Export some internals for targets
Date: Thu, 30 Apr 2026 10:04:43 +1000
Message-ID: <20260430000524.56046-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Based-on: 20260429222445.26301-1-richard.henderson@linaro.org
("[PULL 00/48] fpu patch queue")

Changes for v2:
  - Merge 48 patches
  - Applied r-b
  - Split partsN(muladd_scalbn) into partsN(muladd) + partsN(scalbn).
  - Improvements to partsN(muladd).
  - Export partsN(scalbn).
  - Introduce exp_scalbn.
  - Handle exp overflow during rounding.


r~


Richard Henderson (40):
  fpu: Inline float8_e4m3_pack_raw to single caller
  fpu: Inline float8_e5m2_pack_raw into single caller
  fpu: Inline float16_pack_raw into callers
  fpu: Inline bfloat16_pack_raw into callers
  fpu: Inline float32_pack_raw into callers
  fpu: Inline float64_pack_raw into callers
  fpu: Mark unpack_raw64 QEMU_ALWAYS_INLINE
  fpu: Mark pack_raw64 QEMU_ALWAYS_INLINE
  fpu: Split FloatParts{64,128} to softfloat-parts.h
  fpu: Export FloatFmt structures
  fpu: Export unpack_canonical and round_pack_canonical routines
  fpu: Return struct from parts{64,128}_default_nan
  fpu: Return struct from parts{64,128}_silence_nan
  fpu: Return struct from parts{64,128}_return_nan
  fpu: Sink exp_bias adjustment in float64r32_pack_raw
  fpu: Return struct from parts{64,128}_pick_nan
  fpu: Return struct from parts{64,128}_div
  fpu: Return struct from parts{64,128}_round_to_int
  fpu: Use parts64_round_to_int in parts_s390_divide_to_integer
  fpu: Export default_nan, pick_nan, return_nan routines
  fpu: Introduce parts64_round_to_fmt
  fpu: Return struct from parts{64,128}_pick_nan_muladd
  fpu: Introduce record_denormals_used
  fpu: Split scalbn from partsN(muladd_scalbn)
  fpu: Reorganize partsN(muladd)
  fpu: Return struct from parts{64,128}_muladd
  fpu: Drop QEMU_FLATTEN from muladd routines
  fpu: Export parts{64,128}_compare
  fpu: Return struct from parts{64,128}_mul
  fpu: Hoist nan check in partsN_addsub
  fpu: Return struct from parts{64,128}_addsub
  fpu: Simplify 0 +/- N case in parts_addsub
  target/s390x: Move float{32,64}_s390_divide_to_integer
  target/arm: Use FloatParts64 in bfdotadd_ebf
  target/arm: Drop oddstatus from is_ebf and bfdotadd_ebf
  target/arm: Use FloatParts64 in f16_dotadd
  fpu: Return struct from parts{64,128}_scalbn
  host-utils: Introduce signed saturation primitives
  fpu: Saturate the exponent in uncanon_normal
  fpu: Introduce exp_scalbn

 include/fpu/softfloat-parts.h  | 229 +++++++++++
 include/fpu/softfloat.h        |  11 -
 include/qemu/host-utils.h      |  60 +++
 target/arm/tcg/vec_internal.h  |  12 +-
 accel/tcg/tcg-runtime-gvec.c   |  20 +-
 fpu/softfloat.c                | 689 +++++++++++----------------------
 target/arm/tcg/sme_helper.c    | 102 ++---
 target/arm/tcg/vec_helper.c    | 127 +++---
 target/s390x/tcg/fpu_helper.c  | 135 +++++++
 fpu/softfloat-parts.c.inc      | 463 ++++++++++------------
 fpu/softfloat-specialize.c.inc |  42 +-
 11 files changed, 1005 insertions(+), 885 deletions(-)
 create mode 100644 include/fpu/softfloat-parts.h

-- 
2.43.0


