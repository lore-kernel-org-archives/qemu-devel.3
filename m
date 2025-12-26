Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C19E8FDAE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 16:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZB2N-0001r9-8p; Fri, 26 Dec 2025 11:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vZB2K-0001qp-UV
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:51:32 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vZB2J-0007yd-Ir
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:51:32 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so9053499b3a.3
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 08:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766767889; x=1767372689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vZwiqJ7sTM7no+pp18nB52qbLhqqZihvbYGHPTEUmy8=;
 b=k8hGbrLDI4qGSsLZJhjEbxQHiZ0F+Xdys0e3hb2v6TgPI7fOnu/TssRPMpWOMmayDJ
 0h/CNkddMYSpRXIzvKGnftpvES78FB7oRizFm2WpnUacNGeBjLRbPa+o9iNj3HZNSTEN
 sy8H9EbqP91i1Ip2tVfeWTdVtMZehP6IwKqoiNMszAaJAFutClPOgCxFAQ7U3f24qRDb
 dCBS0/HVh+nRNfcH7qhl20F3ad8UZUf9TygGirmN7Oo+KYRGnvzokXvYm5/ee0WExv9B
 lLqkB87RcREYiD5OsgZKIS2ZYqHEIIi96fs2S8pkzfcFdeyKSuCr2k/tu31m4trp1n/5
 TqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766767889; x=1767372689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZwiqJ7sTM7no+pp18nB52qbLhqqZihvbYGHPTEUmy8=;
 b=nyWWePTDE1QrDdMjmrIz0QTS8IixvUztt+7GBoTJebSAQbvL1O8EajKVYPm08p6wxi
 7bGbbr37hW6AL3p7z5KgLnBgfSKWTVQiRXDyMe4MHUrQ96LA92274xk8cX2SnbqKVLWP
 lAqCR5vSgeqqPNCDEDapPZuvavS2kLgHbJrk8nBA0YmEJKgbnn0k0oFHHHpyBlarxjJX
 UTAr+yU3X1fE+XG6Drd1aj/bGoGiKhMelFegcx1qLe/Q0VnCKX+pUK9csABDqJkNh+pC
 OQtWgLJwPFheHjZ0s5SEQ1HKTY7O34j3P8X4fevrdbHKFKlocif61hHCQ6tJusYw1DVH
 k69g==
X-Gm-Message-State: AOJu0Yzrf+xfx8X9T8ZapqrPlom3CAkVHtcFopjWkWz37Lat3p5Qdohv
 zbsbSh/MhC0l4OgFlwIjQSwaQnPTSH465e3FWUI558Ilz3UPyT5Csaav
X-Gm-Gg: AY/fxX64clIZFxb1TBSSJOtsfZM0ZCMvuRsdkkYZSyZqdcAjlophs9WdzaATZQASwSU
 pekfNzdVGCCn7O9bv8gBq4Xy++6fNGtLx7nlsWVl5eEECZI4ldmAsz+2claMWJdytdCakhtvmCH
 XViAQUi6vqK5oXzFzyS8knCjQxMCd4B0jWlTgLPVvbO1yAVok9SN9LF4dQ3SsHQbl9rZEXAjkha
 CFl0BRXsv2FkfQGobdkZmBvQ5EC4nnvvIGO4Aow64R4dYY8wQvxG4/0w8xW2lU+3IZdbIktjBtg
 gmiVK7GNNe8zzuVZ+3WKhTaE77UTU4CETv7uEK5D/3jVSz8Yicqn5TOWZlHKrajZ7cud+5RX+my
 eDsoqmj7Y/ZDaEOwl8XC/dUc3SVGvDZl6r3jC+CLLq7evJwIS4zwSwI2hkbCXFO+h52cac7+2XJ
 O0AhX6sjlAno2coSpoq9w9XJNMxzBTuQ==
X-Google-Smtp-Source: AGHT+IFBhpHrgvnHclq6wvNvMxPiCM99uHaXxfd0Ys1kULNBsOfIlQ3IhoRUq+pQT+tKos+fU2pOIg==
X-Received: by 2002:a05:6a00:a88f:b0:7aa:a2a8:980f with SMTP id
 d2e1a72fcca58-7ff657a3c1bmr22310103b3a.20.1766767889381; 
 Fri, 26 Dec 2025 08:51:29 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f300sm22522225b3a.54.2025.12.26.08.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 08:51:28 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: richard.henderson@linaro.org,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 0/3] tcg: add tcg_gen_print helper
Date: Sat, 27 Dec 2025 00:51:18 +0800
Message-ID: <cover.1766767299.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

This series adds a printf-style helper for TCG to simplify debugging TB
translations.

The first patch implements tcg_gen_print plus the runtime support code that
formats the arguments when the helper is invoked.

The second patch updates scripts/checkpatch.pl to warn if a patch still
contains tcg_gen_print() so that developers do not accidentally merge
debug prints.

The final patch documents the helper in docs/devel/tcg-ops.rst.

Usage:

```
    tcg_gen_print("const value = 0x%lx\n"
                  TCG_PRINT_ARG_I64, tcg_constant_i64(0xdead),
                  TCG_PRINT_ARG_END);
```

P.S. I think this debugging feature will be well-received. :)

Finally, happy new year to all ~

Thank,
Chao

Chao Liu (3):
  tcg: add tcg_gen_print helper
  scripts: warn on tcg_gen_print usage to the checkpatch.pl
  docs: add documentation for the tcg_gen_print helper to tcg-ops

 accel/tcg/tcg-runtime.c     | 187 ++++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.h     |   1 +
 docs/devel/tcg-ops.rst      |  33 +++++++
 include/tcg/tcg-op-common.h |   2 +
 include/tcg/tcg-print.h     |  45 +++++++++
 scripts/checkpatch.pl       |   5 +
 tcg/tcg-op.c                |  89 +++++++++++++++++
 7 files changed, 362 insertions(+)
 create mode 100644 include/tcg/tcg-print.h

--
2.52.0


