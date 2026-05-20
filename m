Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A242CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgOx-0006pI-8r; Wed, 20 May 2026 08:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgOn-0006fj-UB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:51:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgOm-0003c7-G8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:51:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso27260075e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779281502; x=1779886302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LPRd+bVfcQK7botC68tihe/FDd0dzes0Uaf/oJ7gtn0=;
 b=HVfAMte94VRzBWRD2d1ZHolajUGxk6IpbHHkBdIm9JJpHf4Uzvbf11MzlF7gkSMj92
 VP56IG2PG1LuFy+WJLMylpqitdHzR74lCL0Aq/KaoCWVWIxtPTHF/wOq1yIn1eHgKV13
 BVLLw48SSwraLPyeLTx0ft1n6xZ3syJRHGRdN8LZaCf/SopMubNMJaCEN5vHVDEZRjly
 oPGkNa+Zs1iWTLHIdei3fI+Fo903YyOugd2KHqchLJVms2/l3RkjUZejYAl1Dwy/p6qk
 lquvhSvr7YgPQMfraUCdGC5QPenS04I2Irk213D5Xo9N4S3YL/f870qjMtfGTiATtG9Q
 38gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779281502; x=1779886302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPRd+bVfcQK7botC68tihe/FDd0dzes0Uaf/oJ7gtn0=;
 b=b8unfSXHz0iEg1YpXnj+S1GIczd9vXcfrcKF3YYzeUvmBv3xgGKzQ8iWEuhkZPU7AC
 cM9AOwRy6fpo3L6fjGk+WI1153NvXIgRD8D3VcZ9IL3H2wB1WgCouOFUTSIiEdm4qWJI
 0es62j1nzG6QLuRIgMB7hrUZtXS1MTJcv07GNrtL15O8S9naLzXePv1Kj0brRB0zrGhB
 f02vJeLC/oqiGq3EmArncp/cPi9SXa1Z3Hzh7pnYHILguwvLQPArowgJVarlha7Duz0Q
 N0GHiHjl/aVLIeyVhb1IXiqoV3arPvw56/WUwD/El1wGgw1dP+Xr5/w3oDwsGSUjuVSd
 ePLw==
X-Gm-Message-State: AOJu0Yy2CUBUWSOeS+Vv0lu21ZX0Ix1H6pQt7rlONvY1eyOgzGNLZDGc
 XOezhyx7rhFhJK1zT3/shQNYrPZAMVqvoEyHcqiO2otdApz4B6WvLD9sJbv2mxYohGxIkqNsTOd
 GSxFhq9E=
X-Gm-Gg: Acq92OHB3g1q5Cym16pZ/YjlrSlmj6Rr/Ca1lusFNFRYoLUBdJyEJXJ3JNre7/yqAuB
 g/efacaeWhhxWMRykkkn1kdUWvdK5c6d9q854zFyqL5tJ9miHTbbsyYrudWGhcL0Nmk+aklwrm4
 UwhsRwrBxAIY2l6+PfCHK1a48FrMpqfXC67mUhsD5xHsvOhNPY8GmeWVne+RUnP270A7YTzTARP
 Mz3M/mdscKpVbr/PWeWYNciu4C5TJMIsO0pX1OF1LdVIw9ufRLMBZfzXrGR5ZK0eLdUoau+keZg
 0ltlSWsi1BR+yBK21/QCFh7OLIVVNPAjDZiagZufkLbey1vWO1K5XFux7NuTbn1FfofZGV7pJBU
 zGa863nPPa6Jk4rUtKB48Npo7pciRTjyTZGujhN50l91exvjRt9B+//982AuWR+kbAEsz6+VYJn
 /bEiE0xItCfJh8FSdp2+6ggQWf+NMa/DFigFl4dut5NgSzJA0+qPGrLOciWgbTeUeHcC4Q9N9Dc
 Q/6egAqG7U=
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-48fe60e510bmr359917545e9.5.1779281501642; 
 Wed, 20 May 2026 05:51:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf86db7sm199062475e9.6.2026.05.20.05.51.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 05:51:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 0/2] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
Date: Wed, 20 May 2026 14:51:37 +0200
Message-ID: <20260520125139.13352-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Respin of Richard patch split to ease review.

Richard Henderson (2):
  tcg: Massage fold_multiply2()
  tcg: Optimize INDEX_op_mul[us]2 for 0 and 1

 tcg/optimize.c | 90 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 31 deletions(-)

-- 
2.53.0


