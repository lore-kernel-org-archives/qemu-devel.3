Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E99BC282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskPL-0007U4-UK; Thu, 13 Mar 2025 11:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tskPJ-0007Rv-FZ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:23:37 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tskPH-0001fJ-GE
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:23:37 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so965975f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1741879413; x=1742484213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9nVjncuiVzGqqYqTlXbnw4WnIwWipltA0nH22oS5ZUs=;
 b=cRBt0bOZZmP17WXeUnY1fhrnL62vuZHc957vgyONqkbNwMS1IBE5kOy2v4QQuUPuRj
 /B8tlfTbF9uwTvIKZilhIM9NsZitNM2BVP9Xu07f4N/GujiyhTXI2jIc6tdn9obhXbDF
 jrH0pzwtmdHMNyCC5goL0jT2LIsZMTMbD4oN2rnvL1r9I98asrfu1XFl+d7sZUt/MoHj
 avMn5W7BazlJdAvbZbTi1s5JSk7MCLduNqUnlFaXTKAFpbErwIUR3MpaFBdxlAZX4ORT
 yvPjaJZKA+l9VqU9NejZqqxqPO5ghaWu6lhJSYzwL9R940L4rXpWjmPO1ZGaOku2i+cA
 7E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741879413; x=1742484213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9nVjncuiVzGqqYqTlXbnw4WnIwWipltA0nH22oS5ZUs=;
 b=XebYA0R+JipV2ubEWAJvSJB1FcFP2coiO9czssxyA7hkEmEWTPwktJIHN5kWqwSTtS
 V3thLiqL/qa9ShPAIy5XOsOsJehHWfE4CtG/FiCMyrSbuJYaStrdvAOfOT2oPqnz+CpC
 MpBWgk3Y3V6xbakY1UroLCH2aM9MYkCESkb7jdUMWemJMvgJwFnKzXQji0L98wd6F/xd
 c1F8dI8gYvZjDRzt7aX+B41jJr58VNmgy4sPYxAT0kA8mCrCC4qEdLhkqKEq7xm0nIln
 pgYuG3YBAF/gRGLv19PlE6kw/RogGk3eQfm4RD6MC7odH5193OKdq6gIyXLI6S2bhk14
 1ZBg==
X-Gm-Message-State: AOJu0YxRCfP9y+1/uBc+yUKsdbO2ksuB0SyfvvdwjSE4kdcFHNptKR8Y
 taAxoBTGc9SVk4n1x9MpGpAGV2inlf032C8n/uDthl/4IpAUhWb9j61gwEBJss899j7k0M1S+Tg
 4GGlVUA==
X-Gm-Gg: ASbGncshJROYejAMAgrkKG0NGp2wABHMMKDLa3zJZNCEpFAsleMBR15/JVEJb+ll5fH
 pIBIJMhcT+RVZ5uoW8aFWhKS58jsM9u5Q1GdqNoKSCCjlgHY/pP0kpJwKO5sicuupynNyDi8Oie
 9T+zH7AqZFY8/fXK95/DpPgGkXBkl/LHgpMWVH6QASAmxmTVVSJItngsBlcOxfTeYjwgsSqwe2t
 ixIBMOQCYN7DHTo0vC9UX4aid3DBI0vpgBsSSGuKxsRlnZy9qey8ZfEsJBRbXWvd8Q4HOOtCkoW
 LTndX0rC1q5qBBwWUv9l59Glg5SmiybtnwxuDGy1NNvTpjMonC/ZfQXy0eak2t5qcnQgc4eUMe1
 jmnodpZZ5ZA==
X-Google-Smtp-Source: AGHT+IEQMV2Zhvynym5jPJEeBEzsOTWLlS4hmQv6E96166TOjIAPpd2etOrK8btyzJHoNfGsTQvKLg==
X-Received: by 2002:a05:6000:1545:b0:390:fc5a:91c8 with SMTP id
 ffacd0b85a97d-39132dbd475mr25968294f8f.53.1741879413146; 
 Thu, 13 Mar 2025 08:23:33 -0700 (PDT)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ebaedsm2462868f8f.90.2025.03.13.08.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 08:23:32 -0700 (PDT)
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
Subject: [PATCH 0/1 v4] target/riscv: use tcg ops generation to emulate whole
 reg rvv loads/stores.
Date: Thu, 13 Mar 2025 15:23:29 +0000
Message-ID: <20250313152330.398396-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x42f.google.com
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

Previous versions:

- RFC v1: https://lore.kernel.org/all/20241218170840.1090473-1-paolo.savini@embecosm.com/
- RFC v2: https://lore.kernel.org/all/20241220153834.16302-1-paolo.savini@embecosm.com/
- RFC v3: https://lore.kernel.org/all/20250122164905.13615-1-paolo.savini@embecosm.com/

Version v4 of this patch brings the following changes:

- removed the host specific conditions so that the behaviour of the emulation
  doesn't depend on the host we are running on.
  The intruduction of this extra complexity is not worth the very marginal
  performance improvement, when the overall performance improves anyway
  considerably without.
- added reviewers contacts (thanks all for reviewing the work).
- changed the header from RFC to PATCH.

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
  target/riscv: use tcg ops generation to emulate whole reg rvv
    loads/stores.

 target/riscv/insn_trans/trans_rvv.c.inc | 155 +++++++++++++++++-------
 1 file changed, 108 insertions(+), 47 deletions(-)

-- 
2.34.1

