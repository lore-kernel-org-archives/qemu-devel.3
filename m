Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68573CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99DB-0003ee-N3; Wed, 15 Oct 2025 17:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cy-0003Zr-Gg
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:39:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cw-00050G-Qa
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:56 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-267f0fe72a1so466665ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564332; x=1761169132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CC+r7Wb6n6cAdbv0+2LZtn+JgBjXFbtsFceXgXxGGs=;
 b=wiYi2C4qV6618hPpwjOm2oEkUxXnqi1wxPM+T/NBnIfq9vgI+/faJigew3qFNXl558
 1gWrf7ZaGqj5CIHx4K2JnIqOkk1IfOz0T26tWb9Dh/ByMtRdqxPOrWbSV7v/dKntyvfb
 5veW7ePrSEeNLXqamOjC3Ov8a/S2zb29DjgaU9ft0moD+0/zHpt8kl4oayhr7ZhahvYP
 5OMSxO5sNB8fVqD3jICEA3+N6pHZiIa/2HjuDqZW7vmex6V9Rqwe1cqbSMqvJCL4GuNq
 AgTbnUKbzaBqkNyjsQ0MlEVoySBx0Th6vr0/OzJedG3G1IFVJGwmEY/UxbbpsdboqCtl
 mrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564332; x=1761169132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CC+r7Wb6n6cAdbv0+2LZtn+JgBjXFbtsFceXgXxGGs=;
 b=IiXddGBR4PleASKf5tt1NLyvOkO6oUeLEZSvaxuX+bboc5qObiISfM6XXQjWcqatEk
 DKA7TsXJ5ikJCIGSiiMD4ZHmY7RQNsfok+JBUnOUQbt2upHEFZ47vfNffZg1NMabA7d6
 t2NJNM2wWElkvl6CUoB+GzypkbbyC1aWT81cJ75UpLWJcgO83V9c3pPgcCqGaXjmd6dS
 CI/hZLJbmWwSx9JNr31vv2idVwBgphPbL5K5GeEHj/FPta7z5ql40TQbk8Vru2zHhQab
 q5dPqoTnCEhWnKW4Ik3cLbCqoDAJgTCF7AfWp5J8EH3AtwgUlmJKdMRTmAviPrV6hxiI
 taXA==
X-Gm-Message-State: AOJu0YyafiS7AIgTC1XYQ0GeMG3YO0jy00jqxLD9QOXIBHfG9+jhle9S
 3HT/25ocGPtZzQItjasNw0JvcgaDRfnATjSjxIRuzjs8kweSb7pkajOfxIeO5KjOmUqe8knCC9P
 sjd8hXEw=
X-Gm-Gg: ASbGncvHCSFEJmOpKdsiLiwXMb5DNhwxovjpm8rfvnT9yK7IdcpWpWg+TuGcPjXKYjz
 bCjW+1hPbBfQAJALT0Sa9Fcn7Wguh169skWAJSUOH8RMnulOlIwP1FWBMsbhCeS1KOpy/OVEhtB
 zrmK5ioJji8NdWU9DyxClpfIIgkNZUVLWxgcWaXe23Ff0hwos1p8YW80wzIDq0iHNX0AT12RxOc
 5MI1B2l7uhlqRGVdOrNdI7UY/oMhpZVzZa65jTXuUfkfwG2PQNQfwozoWcSg4Km7HpIFpcSNFUU
 ZsDeFZdfa39T9mQaY4fgp1tSCJPyguBRb0yaU4q6vGWe9DoKCe/VarDP61PFxRInf6TatLgBOur
 pzqH7nz4BmzenTG+jQxNlYeocM2zHArfrFnWWxQeTDFeV9BBWWD/w4FpEO3PNcw==
X-Google-Smtp-Source: AGHT+IGOaHYx7u1w0PQGoMYCKUdJXd/BeCuUV7w5xNpiHHx1ScTDZvDPe/uY9HSvysQLzlM1w5Gvyg==
X-Received: by 2002:a17:902:d485:b0:290:91b0:def4 with SMTP id
 d9443c01a7336-29091b0e19bmr18969875ad.29.1760564331724; 
 Wed, 15 Oct 2025 14:38:51 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm6247085ad.65.2025.10.15.14.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 9/9] tcg/ppc: Remove dead cases from tcg_target_op_def
Date: Wed, 15 Oct 2025 14:38:43 -0700
Message-ID: <20251015213843.14277-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015213843.14277-1-richard.henderson@linaro.org>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Missed some lines when converting to TCGOutOpQemuLdSt*.

Fixes: 86fe5c2597c ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index dad9d24d48..85cda6ecaa 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -4206,11 +4206,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(r, r);
-    case INDEX_op_qemu_st2:
-        return C_O0_I3(o, m, r);
-
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
-- 
2.43.0


