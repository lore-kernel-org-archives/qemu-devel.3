Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603F2CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEm-0002Jj-4k; Wed, 08 Oct 2025 18:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDU-0001Or-Jk
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:01:02 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCa-0007Rj-1S
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:59 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-78f3bfe3f69so271623b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960801; x=1760565601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IYbDL7ZzrPeJgVCiHhUdegByQ1ip3ofl4M+Y1UUBtM=;
 b=VeSQ9HqNqSBtzmOXLsriIwCZyQgSQDeEz7p+4wTdCWasloeVNRlHfp0rwGUsMvCdct
 C9RkAxpi8iLwYnp4r/GWYryzoKh5Fi9H8a3kabESHmkLQzLs8KWiMTLVZtiAwWerUO4r
 nz1VQeU93qpAofbixTuBiG+hMsX6yQTmjEQ6jPYYCJi5wtT7KAQRRm9fBfGR/pyCCb/V
 2iOZkHBHZbKnZTDnicK2MMVyXPrMPCfkvq4yBzKrZSf10j5znwVquqpwlq/LUl3JLRzA
 op+oWUfj6HQ7h9FYBflA02zvRSowkglSoR1alQhre+7GAZRbsJCDEIXgQ/2V2GdwEWg6
 piEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960801; x=1760565601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IYbDL7ZzrPeJgVCiHhUdegByQ1ip3ofl4M+Y1UUBtM=;
 b=DNGho5LV4p5LcEYuOn7Mg1sloyPqrDDoarh4ZuEYHBMR12/suHthQ+4Eb6MboircSH
 np9f6j3D9RMM8Wh4/6y34hfXqdnmnk6invUyzfIn8NDb4za5RaTu8OGTRku7ivv5Luvl
 7gp209IK56BZBY73Otr1T7Xh8RVf6PKzuk6bpe9Jcq5XF5+fxLQupoaa7LeFzUbQ5jfZ
 ZbJ/PKLaKwXHsN79Pr+ErrkbHFgCbLFNIn0J6f4rf6C7Kx/7bz4QTfUgOmvGYEluErbr
 B/53YNV/zXBa4WDtxSFJS+Ep4vYDvXFWo7J9iNYp59E6iMvr/7BS7jBDqifQ6H84tnRM
 CbSw==
X-Gm-Message-State: AOJu0YzbcPjBSHk20/JDxSCxizacmo85/0YCi0LKHU2oP5bk59KqmM13
 o6zK+bmCkiD2mkpYJzB9wX0s76G69mRbgpDpZPr6vW+JvSbgbII7B6ZsQIZHDzvp4T3+S/Ai4W0
 haHMvTs8=
X-Gm-Gg: ASbGncvO84MzGrT9vr/43f/80kBzrfFePtSZ3CkO5JBInme1yHrr7wt04QU/wr9z3Xf
 LwQYMvb5lxJIEttQfW4UnZzMhfZ3T9gBdbw3TdNaodwVc6aidC41TxEzbw+1MMWJf6S/2Xz7ciT
 +J7i+qU7fM9xNcorNsaZcvjpLDeHW/+UoJ+JyDmbF+3JfOtMPa8j1ywy+P4iQTCL+W4Z/AKUekU
 rFfs5VP5Vh4fQqksHd7Ne1WsY7LXoMyCNZouWF0QyWiuJgKpHTuNcWEs9b6VQJ0OlfMAmmB0K79
 xoLY4JLrFJH2nbBcB5oRdpL1gd2E3kihI35SOpwCTXih9j7BCZbxEp3k4+kDKOVhOFdVm1kyxjl
 lMM6YvdBPcwJhmjifdUzyGsKBU9DCSXVO0neyr+lNtIVb0QU5wbvByPpH
X-Google-Smtp-Source: AGHT+IGf/HYizIDf4VnHyN9VwXV+QrTakTxI9hy2ZTflQLcfFvpIA3aJAeY0y3aayfmSPQ5SAFZs9A==
X-Received: by 2002:a05:6a00:391a:b0:781:220c:d2c1 with SMTP id
 d2e1a72fcca58-79385709914mr6537245b3a.2.1759960801076; 
 Wed, 08 Oct 2025 15:00:01 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.15.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 15:00:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 70/73] linux-user/aarch64: Enable GCS in HWCAP
Date: Wed,  8 Oct 2025 14:56:10 -0700
Message-ID: <20251008215613.300150-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 77d03b50e1..3af5a37776 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -169,6 +169,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+    GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
 
     return hwcaps;
 }
-- 
2.43.0


