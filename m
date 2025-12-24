Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0E4E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRQt-0006uR-Bs; Wed, 24 Dec 2025 11:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRQs-0006tD-5C
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:09:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRQq-0008R9-Bp
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:09:49 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso25925485e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592586; x=1767197386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3ue69dF4y+RRw9SNMPWHQQ6jENvoAh9E9CAJY5WT63U=;
 b=waFGGVwrM0whuH2+HKe1nH7KuIIn1yY+ZzNLIaPhWSZbqIaPEzyOZkz8LIebg6lH/6
 MX0E+XNAKZvh17m6EV6p1r9cpqF+PirwB8MiEjljW4CliXwQnJSpsT1DfXjra6MYKKh/
 fiop+SuB6MWl2UL7iLi+gzmE0FJPSrKz4bc3SMZDGsRZ115ej0K94whIuv0/C36GDrCO
 tp6FwhjRJpQnL1MoHbDhKOeTu+jCEJKEeK4WyAMnfwqKkAKjRbs2dyIyzEHLKX/A4ZLG
 P/xtxUqZ7I9lVWHz9V976y2tDBCByLJALO7ZU2Y6oe6FxU4wp+G7TN2ZSfJFsuJALwvR
 dSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592586; x=1767197386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ue69dF4y+RRw9SNMPWHQQ6jENvoAh9E9CAJY5WT63U=;
 b=nzT3kpxRI/fcZfFFdEGJY41xd+uJhH7ByB8S/Sw491TLrGUb5I1HE/Qw8piBx7L1Lg
 9YQ4h3M+hEXEZSILNdWiyMTmebJXExrR6l2Tm4la6jKJyZUUUlqo24qlw3Allf/reEil
 p57ev4rYoyKwx5xzSbbK4hrzZDgkXWTjw9nqthymfmpRFgcV4bzPsI7ovUu66TUnvA5d
 LWH+1JemX2PMOxy3QhN9p0IgrL5DjlJIHApaFZ2GiI/7guIlvT2JGImayaLFdTnyhP9E
 v/ECU3NIji0Ph52yRYrvgHb0cChsjHRIgoMxRRRl4Ly+R5yQfv1w8R/9HC1D5X31frN9
 ztsw==
X-Gm-Message-State: AOJu0YzlBkEwL86gDDRxCHmTlxXPTcD4BOGleHY1BvW3fom+torJQogk
 YUbTM3yGCaGtFisPbVxXTOpXn2zzk7ixphRd2E1/LmRP7Tum0PHSGoajK9CY1K9HsAdMlVRwiuR
 ZHzaFoAA=
X-Gm-Gg: AY/fxX6+ZwBHDj54RLHbtbHfqfExYHEcmcb3IN10WphzhDmadJoWOPacRNmxTTgCY64
 8pXJL+eCm1wF12G6hMT+v0FZQt5ZBMOf8dpHrd5rimXN8/GKVQwt4K+xrec5OS88eBDesurj9aK
 IbIJYWCFFbeQ40KvbXZUyQKnWDHli5kSxM0qTXXtAvJtrV8kqgL37HCmw6lEmkk13sRA7eKEnmQ
 eE8dBoV7wbVqeHxieLz8H3j0BTqnE3JCKe4uQoW09J2iVTBk5HMVE+vt7ryoKRGnAciUvp5vfHF
 03y4KwYHaChFWMKeRh+5Ll0uNeKgfvPMfrhKzlgZ2uyNqierF4yRRTvmuUlT2AFFd5CQJo/EK4F
 md5uaz0FQy/mdi+uRZ2ip2PiUmPL9CKcd+Y3M2e7Tcg+W8p65ipmgiUR3FR7wGKD9PMiE5Be/6V
 XqKYrBOQK1iEr7eRBNNIJgYCHOLgHmpxN2c65xMX8Ft3HJAC6jqf3CmXLKjTp4PVYzsw==
X-Google-Smtp-Source: AGHT+IGN8Ngu3D6HunKhSilas3BYZD/0Ga6DsN1Sb1lo5HbRmvPxDta24sUu5zMBcvNFYzjeqkhLXg==
X-Received: by 2002:a05:600c:828d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d1954a14dmr182169025e9.9.1766592586375; 
 Wed, 24 Dec 2025 08:09:46 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4f09sm305834235e9.12.2025.12.24.08.09.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:09:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/hppa: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:09:38 +0100
Message-ID: <20251224160942.89386-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

PA-RISC is big-endian. Use the explicit 'big'
endianness instead of the 'native' one.
Forbid further uses of legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_hppa-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (4):
  target/hppa: Use big-endian variant of cpu_ld/st_data*()
  target/hppa: Use explicit big-endian LD/ST API
  target/hppa: Inline translator_ldl()
  configs/targets: Forbid HPPA to use legacy native endianness APIs

 configs/targets/hppa-linux-user.mak |  1 +
 configs/targets/hppa-softmmu.mak    |  1 +
 target/hppa/gdbstub.c               |  2 +-
 target/hppa/int_helper.c            |  2 +-
 target/hppa/op_helper.c             | 44 ++++++++++++++---------------
 target/hppa/translate.c             |  3 +-
 6 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.52.0


