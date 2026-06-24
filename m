Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D590CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNnZ-0001gJ-PQ; Wed, 24 Jun 2026 09:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wcNnP-0001YZ-T0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:37:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wcNnO-00015K-4L
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:37:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso5862485e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782308256; x=1782913056; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Igs2cWS9/DjzYb7edb7nIBFIUBT7Wl+0MlW/qg0nhh4=;
 b=YkQQ7Ozcd4HrpgdItR3ppIMjoaN2y7koD1r/S9ZtsC0ScT9y8FcgAXNZLz2wSJfAdU
 u4pq+y5hGF2emMv+uPDLxdcQtEcsdYMTVspGgJffhfbVCSVOnVls/QCTeOEbCChjAkCS
 8zw4nqCIGiI8sC8seaED5xdPbzrbzS1BXtUVXlqe9N/UYHiU3Wejx31l6jd8+nqKVU7V
 mkPyXCoUTyEEwNut560Jtglg32C9Xcedt4jmRHwiuPmr+4TXREjsQxVzrzfwYP5y7ylR
 hdmGYKe0hD+OXrA61fk7xxIF0EttUsHW4Iucn9y5crdDekCfUzmqjOz9XiUm5KIIr40l
 +7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782308256; x=1782913056;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Igs2cWS9/DjzYb7edb7nIBFIUBT7Wl+0MlW/qg0nhh4=;
 b=ZjUGmXHZphBSdPM6ejkEYS2+QxhCzNsfu2CpC1tJLeopED6YVJHCoO8zipfl0NkFyG
 oI59r652e29e+Fl2dfff4Vv3R9e+FQwfkWmcJq9ZBNbhod25q3YWRs+age0+e0GDSKbl
 n89rNTfAGzEGnZDgqMDodRvV3PCmZLShE5PvIu8v6TaUHl0FdbdXYkE6IyAYktxbgW0b
 XKXl5NdY1EwykjO8gBBTh0UA6WKWtHCQHu1NCvCRaxGjDrop8zl1U93YRfqx97sssQcK
 Ez4QEsa9Fzonoe5wAuI2qzVohDQznI4A2YhU6K39LEmW67LQ9Zec+W90A0JSk/gw7ejS
 rhsg==
X-Gm-Message-State: AOJu0YwsUpT5qUvBF3iG9ih+U9ES/JnsbyLj49XOhdYeHq7Q7X9WvPWg
 BQFs7m/C07oCm6gyfXLP0LqYxHC83eR0scgAMBIwd1ppRPLsG87DwMTJy2irVB39Uq8=
X-Gm-Gg: AfdE7cmQgLqiNNOflvmBAiPq3+7py+hivyQeLb0Y/0lhsqAmvM0i6Bpw83NhWkf+qku
 lATJcgxsv2V9oCFahAYIAFDzM7G/2FLm0JibAM1f6sqPNITJYW4vkSHuBGv9lSz7q4GX0jL0pKV
 ouSX5gNQB6lYgBUdUqeZ5q4NVk1JGHD8u2CAo5+Ufh0PFYyr1qR1zTImv9/djiARpH1Ce3vY+aJ
 Dp773QJ2SJ0i2r4zg8HuqN2dJD5God0ol/5zhUbUZvm0HQUU50yMgwZXmcTxybAARuEjO6ovmG3
 3IhvYJ51ugE6JOMz63ZYLX4hjF6CR3y8IyKSXLXwvULo789E2gbVbOzS28QXGvWVLoes01vQfAf
 S0NKg9A7zbRtdBZHJ1HwOpaFTSQcLmhQ4pTwcD9c636SGZ9Uua1JtIMwtcGuoS6Pf6j1IlstL6g
 ZknraxWiflz8dkBIk=
X-Received: by 2002:a05:600c:81c5:b0:492:408b:86e9 with SMTP id
 5b1f17b1804b1-492490b7e7fmr268504365e9.34.1782308256142; 
 Wed, 24 Jun 2026 06:37:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:2e21:1ee8:260f:9a76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1e840efdsm6646334f8f.5.2026.06.24.06.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:37:35 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v2 0/6] Implement FEAT_FPRCVT in cpu_max
Date: Wed, 24 Jun 2026 14:37:24 +0100
Message-Id: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJTdO2oC/23MQQ7CIBCF4as0sxYDBCpx5T1MF0ChHaOlGRqia
 bi72LXL/yXv2yEHwpDh2u1AoWDGtLSQpw78bJcpMBxbg+Sy570w7PGynsWVfNmY0FqNyhvuvIH
 2WClEfB/afWg9Y94SfQ68iN/63ymCcSacUhftrI9a3J64WErnRBMMtdYveGx4xqcAAAA=
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alex Bennee <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x329.google.com
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

This introduces new forms of FCVTXX instructions which convert floating
point to integer but place the results in SIMD & FP registers, and
forms of the [SU]CVTF instructions which convert from integer to FP
with a source in SIMD & FP registers. The logic for conversion and test
values are otherwise the same as the versions which use general-purpose
registers.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Changes in v2:
- New instructions are gated on FPRCVT flag
- do_cvtf_simd removed; changes folded into do_cvtf_f
- Some vector forms of instructions are now allowed in streaming mode (new patch)
- Tests restructured to avoid the duplication of fcvt.ref
- docs/system/arm/emulation.rst updated to indicate FPRCVT support
- linux-user/aarch64/elfload.c now reports FPRCVT
- Link to v1: https://lore.kernel.org/qemu-devel/20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org

---
Jim MacArthur (6):
      target/arm/tcg: Implement new instructions for FPRCVT
      target/arm/tcg: Allow vector FP conversions with FPRCVT
      target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
      linux-user/aarch64/elfload.c: Add FPRCVT
      docs/system/arm: Add FEAT_FPRCVT to A-profile support
      tests/tcg/arm: Tests for new FPRCVT instructions

 docs/system/arm/emulation.rst     |  1 +
 linux-user/aarch64/elfload.c      |  1 +
 target/arm/cpu-features.h         |  5 +++
 target/arm/tcg/a64.decode         | 15 +++++++
 target/arm/tcg/cpu64.c            |  1 +
 target/arm/tcg/translate-a64.c    | 89 ++++++++++++++++++++++++++++++++++-----
 tests/tcg/aarch64/Makefile.target | 14 +++++-
 tests/tcg/arm/fcvt.c              |  7 +++
 8 files changed, 122 insertions(+), 11 deletions(-)
---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260618-jmac-fprcvt-1554d4c80bc8

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


