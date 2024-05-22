Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CF2C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 21:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9tUy-0004eT-UR; Wed, 22 May 2024 17:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tUy-0004eI-0N
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9tUv-0002d2-8f
 for qemu-devel@nongnu.org; Wed, 22 May 2024 17:27:46 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ed0abbf706so47970765ad.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716413263; x=1717018063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+mAwxYACA/+n1LxJbM+zRL2KxA068Bu+H5PyVFgDAjY=;
 b=vpjN9941ARPZuDw74+O0fkRPq5cS6Xlc2vKCOuHtEZ1oF9dtKCYGQ7nh8Yjp2XzAhQ
 EzkY9zVqd6Es/xEo+OKqtM2XdvwnbPOuDC6OPxv3QfwPK/lJouoKRtgQNL51m0K91Drx
 B185ixmJAwBfSijl4RjSmkx+w/qUxYXBOmeVsK73ZKm8KsmCSokBDJ92mBapDEMcjYhd
 SWNwvI2Cexj+MD5i5N5LHOfbED8wyazVZcGCdyI3v4eJxsd9kYMQZsWBreDlY6VBeGjG
 3LcefZ8kcMz8fsWzi1XzmPrcB0D3LsDmKyQyp9uCaNAt/Wi+6NACHxqpgbebLyqMXYsb
 ZQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716413263; x=1717018063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+mAwxYACA/+n1LxJbM+zRL2KxA068Bu+H5PyVFgDAjY=;
 b=OaaCNgadcw8PfwDZSERUNYIB01hKnLLSZf5rG5/OzjWzFkQIPazn8wEcQHKCw0j0OD
 pPkZZ415zXyeBbwg1kSgduZejOF5ThnCTdDiRRcSb/cI/2npiwJjunGOMZbwNP8yA2Gb
 4vQTf2oPWatNue16tp//uFC51V9JSQToQaC4lrEthNVWUwmImJCDBBZYaWIADK4Ezp0z
 H/LJaf+yyCvrw7JeohREUZYhMCeGJSONUWIdSU9nLHPS1Xh2m3S2ScGRhV8zKoDBL2Bi
 UzJUXsJIKC24786cRlGFsV9u324bbyrI8qxs+sItCH7/jZTDJjBZvTFLVpzwZQJWL4+z
 mbdw==
X-Gm-Message-State: AOJu0YyJ+JwjDfEnCdnlAPLJXLop+JkWrhPhoKnWuzzxbZPTnpTATGF7
 c44+un/WTuMVGZKytsrRxrhob/vrbRGIcJhpP4j6UQ0oNCLUXN1GvVVutKxnQWGbX4Po2RUm1aD
 d
X-Google-Smtp-Source: AGHT+IGAVtSNQrP58pPT+1AKwy59EGfEUqLmXQIEPHUbgpVEK3npb9VVHjednBCW25Ib5e4iiCDXyQ==
X-Received: by 2002:a17:903:2451:b0:1e5:9391:1d44 with SMTP id
 d9443c01a7336-1f31c9e726bmr37660235ad.47.1716413263044; 
 Wed, 22 May 2024 14:27:43 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fc06586asm64621705ad.201.2024.05.22.14.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 14:27:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH RISU 0/4] risugen/arm: Convert to use assembly
Date: Wed, 22 May 2024 14:27:37 -0700
Message-Id: <20240522212741.297734-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Minor simplifications as well, which are all the
easier for emitting assembly instead of binary.

r~

Richard Henderson (4):
  risugen/arm: Convert to use assembly
  risugen/arm: Fill general regs with 64-bit random data
  risugen/arm: Switch to thumb mode only once
  contrib/generate_all: Do not rely on ag

 contrib/generate_all.sh |   4 +-
 risugen_arm.pm          | 805 +++++++++++++---------------------------
 2 files changed, 262 insertions(+), 547 deletions(-)

-- 
2.34.1


