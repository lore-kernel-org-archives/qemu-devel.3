Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E515DC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2Q9-0006od-Cu; Mon, 05 May 2025 16:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pu-0006hs-L4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Ps-0000Mg-R5
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:27:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22435603572so61174205ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476873; x=1747081673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qYe9cilYrIw7721GvcX7nL77dLgJMtBKsyyr61R06XI=;
 b=YpByx+2+Iiu34wRJ6chDlgUwpgyaZh5zYSR5HvHmeAnxONvXMyS/17qxdmtnsa4sKG
 r8TrSK1I31174KtIHmWiZH86ajwB/9iio7HbI0ptfZkMqUNrnUN6vHxVnU7SLj13rUir
 NBMYeQS4e/QpAjxTSvf5/bpAtaaVhJhmhMQj65U92dbwHVEfkVssFjMGJtFuaZsKZ4nl
 5t5vG7CUp9gLNte71OeoxP1StP4Puw1CgwFNWP2PKhuzBBl6ExU3ivgXvJOShgJjbO3A
 3npG1MTobk9b4PDEjm4ZAqAkDlFhNuMp8hUz14dVWRui5h+SuLFN2f+fhkZlAhkuCFs7
 rs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476873; x=1747081673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qYe9cilYrIw7721GvcX7nL77dLgJMtBKsyyr61R06XI=;
 b=O0FbSTbRB+wjge3czLG2Mhl7l8RiWpYbNLTfnxbtHGF0OieXMjyegAotprPMsMhm3H
 5lfLyA5inpt+yjY1x/HcQ/G/lSqlMWGRPMAZYWCpq8H+o/jL7TI8zhX9HRo8EUiQNMlN
 tFV30DvoVXc3yYVmfy5YI1f2PnUeqM0fHELb1HXMTkFBgXlxh5BHCh+1pmj8EhZc60LT
 5potW/qWktYI84ln/RKXbHFhTDI3Yz/UYsCFSBs5g2Cv9pFt5m16mlLvnoPpHGIBKBBb
 qlzhQ5GI3QN1ChlFaT/shHkOOLLIrs9vyaNEHEo7JB8RY8UMA/qQsxS2gCfV4OyShMvZ
 mNLQ==
X-Gm-Message-State: AOJu0YxANPSuJvxkV5hb4EeYMCuxb1DGmjKRqO801F7RbuMJcV+B9Bew
 mgqIBspITcHJMQDxKKtG7Ff7YAO68K6xRYyKW3PbiX+8GygIK1Mc3RKK21RLXNvaY6GNW2Fhipa
 /
X-Gm-Gg: ASbGnctf/n7fuSz8uhfvzee4uhEUjFjJ4PBHsMFWfcICKmk+ryv2WBBfIIRB6E8DT1f
 iTIxNTAerFuBBvKg+zBhGg1XNBJORyjFGIPtBCWoWOXiLZOx5zw9HOhF6h2Lnha+h/PKzS+62ID
 AAbT2y6mnQS5QzA6Vh9jhDewJgOBDMOWCeyETJ86kA+ebAgIuB3FH6PndjYQgzRTl5fI6y1UX3v
 7UrBHuqC5Zn8DDLqwhthSLUhlj8x7Qz1tA3GI1ggI2fhloPOhTvyaWLxiEGURSCqqeEZdwkHWpM
 2E9SqV6q8leVsNVSGbW9c5W7NDm682GuQIhA/Pxdl0RYtvM4YvmmgyjMf6VtHZGAn+ZJ2nmrinU
 =
X-Google-Smtp-Source: AGHT+IFybJg8+9OXnDpjfjDRwxBMPhP1f3fhlNwj/BbWCgYu/UvU8+CNs9xfrIGroQhL+cfAvIF6Wg==
X-Received: by 2002:a17:902:ec85:b0:21f:988d:5758 with SMTP id
 d9443c01a7336-22e1ea61942mr124999665ad.35.1746476873349; 
 Mon, 05 May 2025 13:27:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/20] tcg/optimize: Track and use known 1's
Date: Mon,  5 May 2025 13:27:31 -0700
Message-ID: <20250505202751.3510517-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We already track and use known 0's; do the same for 1's.
This actually simplifies some of the logical operations,
where before required checking for a constant value.


r~


Richard Henderson (20):
  tcg/optimize: Introduce arg_const_val
  tcg/optimize: Add one's mask to TempOptInfo
  tcg/optimize: Build and use o_bits in fold_and
  tcg/optimize: Build and use o_bits in fold_andc
  tcg/optimize: Build and use z_bits and o_bits in fold_eqv
  tcg/optimize: Build and use z_bits and o_bits in fold_nand
  tcg/optimize: Build and use z_bits and o_bits in fold_nor
  tcg/optimize: Build and use z_bits and o_bits in fold_not
  tcg/optimize: Build and use one and affected bits in fold_or
  tcg/optimize: Build and use zero, one and affected bits in fold_orc
  tcg/optimize: Build and use o_bits in fold_xor
  tcg/optimize: Build and use o_bits in fold_bswap
  tcg/optimize: Build and use o_bits in fold_deposit
  tcg/optimize: Build and use o_bits in fold_extract
  tcg/optimize: Build and use z_bits and o_bits in fold_extract2
  tcg/optimize: Build and use o_bits in fold_exts
  tcg/optimize: Build and use o_bits in fold_extu
  tcg/optimize: Build and use o_bits in fold_movcond
  tcg/optimize: Build and use o_bits in fold_sextract
  tcg/optimize: Build and use o_bits in fold_shift

 tcg/optimize.c | 359 +++++++++++++++++++++++++++++++------------------
 1 file changed, 226 insertions(+), 133 deletions(-)

-- 
2.43.0


