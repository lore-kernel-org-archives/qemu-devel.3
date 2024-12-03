Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D75E74AD1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZgc-0001L6-Gt; Tue, 03 Dec 2024 15:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZga-0001KY-1O
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:56 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgW-0003AL-Gd
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:54 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71d40573d03so2352648a34.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258391; x=1733863191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J0jqeWxtWePU/eSnFWsMzVAcMbrPpuzs+5deb7wcigA=;
 b=gLn9ay1e9pHdvQ2uzeY/XtrtCMR92MA0NTxcqPSktthxuCg30zbApFNcHgI1xPhGaN
 E3gNC5Ji9+AyTWjRv0oaWCzusELOLXwgMVvT84GieI44Yi81hvJo5jNC8XBDxjR671Zz
 eCzkO/u/yWsUljAlB3QXI5LzAy498Vgm7HtBSJ2MHAHtOrJ24V0jUYoSH2g3eUvp8ETN
 ngFRbg3WFznbaYVtAVkBpMnIwKFdfglmEiDHrWnYGEJ1SNzMTjxT0apThgr6eYa1TJwi
 rBFTNiIcHaKZImWMRwnY/LRJcb630YIlIZb5WVQGbd89rKY7rFOVqQetypoQ8S07r/wF
 OtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258391; x=1733863191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J0jqeWxtWePU/eSnFWsMzVAcMbrPpuzs+5deb7wcigA=;
 b=LThmIv07LhRUf3XCZthTlVLnhfe2mM5LdUEEGyXriZ+pIzn5n8iE7D6TqcMvASaPtk
 Wys7fnps5TK/q33zpr+mQ1AFRh+tIwYxbSfyKItQKI9s4g5dfTU3UGshO92BNjx4EECr
 TeRfZYCZffqrHX8qz6Pj6XQsB7WTQIj2fblggZkFu2ObCIugb8NfiK5WaqBc1ynGlJ8B
 6MYDf8e7JBbaHvIdWmF2JFX8KOGYUzC+VGFC+mrb1gmzy7OJMsh2guINXIlPHGpnkTDB
 iXVLH/ppIjmgZev6gmNwV+cIQnhk9TF57fOkVT4Pxiawr+vueGas3DFbZIH5vWT6JvFc
 +FXg==
X-Gm-Message-State: AOJu0YweByzE63VxVAzdFIE1e0+lbFixPnPO8lIDiTpsXTaDwarfs7bT
 7BwyahzHm73HsQhG+HLltPBpvGbycFIEuW80ACNrRxljreil4ZXchbfwtargfrAVB+z6VkdCuhx
 /bUk=
X-Gm-Gg: ASbGncsEH52VjVvdBamNaF5NLsyeyO1LCwKbcH6WCscTlgXsCAQeuINyPXBiNs0qU3O
 k71UJzx9sepio4Pxo6rK33qdP7WFRzm6rCWqvept3HuS0EoG13imsai4ZS/eKkWv60GPXMwe7X8
 +57ZumVxNel7tm33OGmDHtlRfD8w8L3/0UBUBkLeNOx+ChbU0rowezp8sif+O/wfTDXqiCYcL47
 MxxA+lZP92rmx2VLQ5mYfaEzCv2gyjq01gvazECXNwYmvnzhaLc3Oc2fnOBf/QDXl4trupaiC6i
 fd9QZsRMe1G1S1bBfi+Ayi6upFXHdsvLKJp6
X-Google-Smtp-Source: AGHT+IGl5aWOZhxXJhlALUB6/H7iDleuWDY3mgfP+9Rczzk+Gh91URre8xedbE4UBEUGYOkg23TndQ==
X-Received: by 2002:a05:6830:488d:b0:71d:4385:665e with SMTP id
 46e09a7af769-71db57d463fmr1215520a34.9.1733258391069; 
 Tue, 03 Dec 2024 12:39:51 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH for-10.0 00/11] fpu: pickNaN follow ups
Date: Tue,  3 Dec 2024 14:39:37 -0600
Message-ID: <20241203203949.483774-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

Based-on: 20241202131347.498124-55-peter.maydell@linaro.org
([PATCH v2 for-10.0 54/54] fpu: Remove default handling for dnan_pattern)

The first patch needs to be inserted into Peter's patch set,
any place before 54/54 when dnan_pattern becomes mandatory.

The rest are cleanups that become possible when the
softfloat-specialize.c.inc functions are inlined into their
single callers in softfloat-parts.c.inc.


r~


Richard Henderson (11):
  target/arm: Copy entire float_status in is_ebf
  softfloat: Inline pickNaNMulAdd
  softfloat: Use goto for default nan case in pick_nan_muladd
  softfloat: Remove which from parts_pick_nan_muladd
  softfloat: Pad array size in pick_nan_muladd
  softfloat: Move propagateFloatx80NaN to softfloat.c
  softfloat: Use parts_pick_nan in propagateFloatx80NaN
  softfloat: Inline pickNaN
  softfloat: Share code between parts_pick_nan cases
  softfloat: Sink frac_cmp in parts_pick_nan until needed
  softfloat: Replace WHICH with RET in parts_pick_nan

 fpu/softfloat.c                |  19 ++++
 target/arm/tcg/vec_helper.c    |  20 ++--
 fpu/softfloat-parts.c.inc      | 136 +++++++++++++++++-----
 fpu/softfloat-specialize.c.inc | 202 ---------------------------------
 4 files changed, 131 insertions(+), 246 deletions(-)

-- 
2.43.0


