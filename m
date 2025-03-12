Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59B4C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsORI-0005XH-Bs; Wed, 12 Mar 2025 11:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tsOR4-0005TX-A4
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:56:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tsOR1-0006BT-DT
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:55:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so36952055e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1741794950; x=1742399750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UOdaUTcClFq5xfQidKy1NhBGiVo5JORsaakmaIBhmno=;
 b=eIhfiZ4imoLL5KU3MEQQt0s9L2+KbVZ3tthXWb7jssdQ2aHLLTXdyIvs+ur9EC3t8A
 M/wfgvSRzd7sr1Ikov8dn3Xdmcb53fy/SEdsTGxHhaZ7QD67JfO5TdxKaPkA+qEn7h1e
 2/gJyS9Mbt4YwFyyWk4/ysS2YDInQ2YSD1reDdSSCEC1NmAcRt9d5E8Sncq036qx8QmV
 /QAbEqtqiqybWlFJCoEx0AKUjLdz7cP6ULnjJG6SoPMVrO0RIqBPmPMZQrzmGLK0sVOK
 uLLYaWl8lsgZ7sz6+SPMAHrq5U9OrA/lhTT0ZorQ0oamXngX7TsUFFLEiUZEp4YA2X2w
 wM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741794950; x=1742399750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UOdaUTcClFq5xfQidKy1NhBGiVo5JORsaakmaIBhmno=;
 b=dPPIAYbdYgAxUWkv9A/9NJhhPgvEs4kmi7/UnIOFKz8Ig0lKLLJaIIKdPyPH1zqRY3
 3+L1J+dtlYbuidpy4amBp4TsxU3UqNIxcWQ5awd7PW2+ffhyhZAbDqcqvmOrN9EhxNjg
 Rpg6zPzcK7qwWe83nWKo1SYAXCuofaNCBYb4FwuL4vYr2mOv1i8B0mxTyIGQcWo0AtSp
 RCEACxyoWL+wKtza+/4XFEYLS/mB0tOd946u2qtmSEDKvx5Vt2wE+cE+Nw7NfuJ1gKEb
 FeLN3gGIPMVTagEWLqP/2iO8VIKLOf2sGu30TV1vNovxNRbMoczcjv9/o4SXWStn3cCO
 C16g==
X-Gm-Message-State: AOJu0Yxz9F96KDiPhWyqcq34RXU0oRnMhCCzxFbvjBaf/r/z6lU/OLbz
 3rtxYJ7MdrpXkCjkqHZ/7cOlxYyZKVMU4Q/HrdjJDsZhYR8VZrGHMP/+E6U3RoFOo6vVPD8tV6M
 fHRE/ew==
X-Gm-Gg: ASbGnctPbuJjVdx12lp0p1jndC1df74YpOWQHKzpO5h+Mi+kBV/OcAQ1NwzZBF/RLWT
 LqKwlmQVG+r9R5istheYzCIC09PzWfPY3d6Q8ZQCLmwZJPXWOwTidm2AqpQi6HZIwnMCB7UVd5G
 ZBVmzVVpsgxxQ/5YbBK+Cs8Si3zLXGyVcTEIcsASiWfX92yyEPvGeBTb91PNhry9cX5JMk2KWjH
 v6iQ82+JxGmjAaBbZpvMQnNWicXnjQdsR1OlxRF6k5OzMc0bkJCSjm4q3Wnmxs1s63TVoLvzr5j
 FOJb8oivTyrQTMtDqGKiRCBrduBc4+Yy9tYZ0dVLnbxrK98gC9PXyYCv3KU27sjNSRTNDgMCpg=
 =
X-Google-Smtp-Source: AGHT+IGS5LCdMh0dqpnxbcxt/VveBsr57HrqT00nn6Y1Zwc6SbVwJkiFD4DHvhbV8eUcEOQgj9knbw==
X-Received: by 2002:a05:600c:4fc5:b0:43c:f969:13c0 with SMTP id
 5b1f17b1804b1-43cf9691636mr124446855e9.29.1741794949779; 
 Wed, 12 Mar 2025 08:55:49 -0700 (PDT)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:3f9b:7278:8381:286b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0ac26758sm23583115e9.35.2025.03.12.08.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 08:55:49 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [PATCH 0/1 v2] [RISCV/RVV] Generate strided vector loads/stores with
 tcg nodes.
Date: Wed, 12 Mar 2025 15:55:46 +0000
Message-ID: <20250312155547.289642-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x336.google.com
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

Previous version:

- PATCH v1: https://lore.kernel.org/all/20250211182056.412867-1-paolo.savini@embecosm.com/ 

Follwing the suggestion in the following review by Daniel Barboza:

https://lore.kernel.org/all/9be2ecc4-fed3-4774-a921-259f36e23b1b@ventanamicro.com/

we simplified the emulation by tcg nodes of such a complex operation as strided
loads/stores by breaking it into two separate functions.
One function implements the loop that performs the main load/store operation
with the supporting logic to address the vector elements with the right stride
and to fill with ones the inactive elements in the case of a load.
The second function implements the loop that sets to 1 the tail bytes if we
are in a tail agnostic regime.

Cc: Richard Handerson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>
Cc: Jeremy Bennett <jeremy.bennett@embecosm.com>
Cc: Craig Blackmore <craig.blackmore@embecosm.com>


Paolo Savini (1):
  [RISC-V/RVV] Generate strided vector loads/stores with tcg nodes.

 target/riscv/insn_trans/trans_rvv.c.inc | 323 ++++++++++++++++++++----
 1 file changed, 273 insertions(+), 50 deletions(-)

-- 
2.34.1

