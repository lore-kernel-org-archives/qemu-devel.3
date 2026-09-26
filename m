Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D2FC98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 23:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAcFq-0006Uu-He; Sat, 26 Sep 2026 19:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAcFo-0006UL-B5
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 19:56:28 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAcFm-0004O5-Hv
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 19:56:27 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so1115046a91.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790466984; x=1791071784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I2WBdUuO/e2dwvTQ22E9RGL58YanfA7r4S18IIvoBGw=;
 b=xj+ovhYJ+X/zBhZ7IL01V1nmF/AFGFtkq8k5XW95DbW9DaYksBk784jka+TUVyXmcr
 bRQLlfZ2u7vscuprNa/dXZNtv6pkZHxPGkkDqiMYksis+UfrjK44UP+RtEJZX16zXYPu
 A0wqWVTeWMnLwmkv7voGuvGkYlaM7e043QXogHcLzLabhOMqpz9ryXnVRnndbGDLrpEa
 +HLSW3+2MwovONMdziTJy5z50jNF8h0vJ6fgrKX0FVNiyIZ4HwB5/wX/0vrTOsW8BlX9
 jyirLzQuNMKZa35lx+kkhW7TFrgYcGp6CmIxGget6NzpO7Md4lDMkOh/MXIdX8ElLKY3
 WggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790466984; x=1791071784;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I2WBdUuO/e2dwvTQ22E9RGL58YanfA7r4S18IIvoBGw=;
 b=LzmC6DkZifYq+90wo0pB+du+UuEUd53ul3mldTELQNQ9qnvnyAZHrBBUL8f/N0ciu3
 AEJws4f3ZaABzYC9/6SK7RrpS8TiHM1Tl9wXjxZQ0SS72v5UXg5M7+v3kXNTcLImyNo9
 zbvAwlxyuA59Bt+yYZYTXFxkUvJDT1GuHs/sueXq2n6RemKxwQbFOrKsl0Hjmyzb+vtb
 KgfqS0D5y125+fpYK++G1A4ML2XMplqKs4iLLfJvh432SGt01MHBvaj3S9oSswgstuF3
 aMhhQ3497rBTStYKTHY/dkj5EkHr1eSACnA0xgZRWvr5HBeti1nRETRCq4M9ETSFRrKI
 aEHQ==
X-Gm-Message-State: AFq9FYLVFGqAUmSJ2wC8/wrJ5ySvXku5aRoCBZeBr9082KcuBNMR46cX
 PN7kCrUqwkj0S+waKMUP/T7LldyW9X5VuCI8E8vzAoDoNAiFNe+4DcNEA/S6SVR97WDzYG/i+xf
 tWTUW
X-Gm-Gg: AYBFou36Wpig1vOtJURWJOz2e2yCkBCHI+sJsFjbNLpvE6IE9H80vYRvtlBc95X4fjz
 EEAw4MBr0YDRWkBsKlbr+k9VxFhGSytoQWAqfRnq6VbhB8oYF+bvQk/rCJOZGU7j1NYO5uH/i/O
 v3MBVqVXtPpOvNYwpqGCA1ts9694IWHoPZ3n0jaerxsEncWzHv10rQ/5FAnGWw51C0mwjq8bRg+
 m3MzA+ZK0+x/UYcyrXf4H6FerkhpevIGvfD/lwht/7WXM8Rc5Io0MlKv89+H18Np4rBWET8YoVP
 166QMbP8Q87t7DOcGRC+5WUSJBmMoq23sPriH2uOLY/OaFfC/T2Bac7EJFePFYAeAOVGkF76Wgb
 NlakRgKMnY8Nx8a34U8qX4fxUpbl3Uvo74Jkn+As755RT5Xt1wHO4VcNg8TTE5xAo6g+QVNN84a
 05Hf9yLo1AQaPIJ2QRrMleivSGCY8BL3Ep1mkjRD1u5U9RrfLgmCPGw29W09xS7e9ecdmYbDJ3Q
 /h3BEecP3h2dSQkX5t32RA82oJmWw==
X-Received: by 2002:a17:90b:314e:b0:39e:5ade:f9de with SMTP id
 98e67ed59e1d1-3a098b431dbmr8461673a91.26.1790466984123; 
 Sat, 26 Sep 2026 16:56:24 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09773e7c3sm18136031a91.17.2026.09.26.16.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 16:56:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: paul@galbraiths.ca,
	pbonzini@redhat.com
Subject: [PATCH v4 0/3] target/i386/tcg: fix EIP truncation for wrapping
 16-bit near branches
Date: Sat, 26 Sep 2026 16:56:17 -0700
Message-ID: <20260926235620.851099-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Hi Paul, thanks for the testcase.

While your patch did fix the bug, it retained other surrounding
buggy code that attempted to fix this but failed to do so.


r~


Paul Galbraith (1):
  tests/tcg/i386: Add regression test for wrapping 16-bit near branches

Richard Henderson (2):
  target/i386/tcg: Add DisasContext.pc_save_valid
  target/i386/tcg: fix EIP truncation for wrapping near branches

 target/i386/tcg/translate.c                |  38 ++++----
 tests/tcg/i386/system/meson.build          |   3 +-
 tests/tcg/i386/system/test-branch-wrap16.S | 101 +++++++++++++++++++++
 3 files changed, 124 insertions(+), 18 deletions(-)
 create mode 100644 tests/tcg/i386/system/test-branch-wrap16.S

-- 
2.53.0


