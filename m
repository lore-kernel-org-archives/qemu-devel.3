Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50E0C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4vJ-0001zh-Ja; Thu, 06 Mar 2025 01:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vC-0001yk-A0
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:30 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vA-0006F5-Ha
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22382657540so4155795ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741243286; x=1741848086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FkqugfpLmgZAYLYj9EQO2VXghr69/Qi0X4/l0AwFoQQ=;
 b=XqjGd2RN2l58tbzzu+VCjj7y6YyvoooLXu9EARv9o8DhA7fwL/PFQ/QmS6Un5xmvON
 7uCuDUe+rpXYVqCBuuoGD1al2viRgCSL2l4/1rI7cU6IPUFs7lfTAhAxDJ0F57/TDh0v
 QjR0NYFtnFm9FGqkQGsD+8pGTAQ5rRG7qtZ05PyfJ4HeCUT/oGgzSEX9vy2Wpg3uk8ry
 QTtTMJGhy6nrhb+Hl+pdnJop1AFsE4t3kX+pU/LLX+UGT/kX51zsO/liS22GxZbFd7ba
 Hv0Or/Zb2i7V7WAsRIS+hCjoAu0H3sxFGfzMLNJgMtKOtNdRgR/lV8ZC2fslo4VoApL1
 TeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243286; x=1741848086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FkqugfpLmgZAYLYj9EQO2VXghr69/Qi0X4/l0AwFoQQ=;
 b=tHMJmZMRR+HA5RusQsNH7oHoXx1dr0P4Y7koZP0nUj8uukiqW8P/sNCbrWt2Kk3P2I
 dULsdsr+5hgODK/g9F8BRuU4jEEfh9tg3uzgUzMqMkCSrgxfUa1DPiCwqUAiBXJaYw2L
 CVmDsqfcUrncMelTU9Jc150JklYfB2RBWFafgav6c1tar5ILuHko1qyhdVs/TJIaY46H
 oZ+fGjxZaG/XBD2yOZGAPR1b7BBpJnQCrNRocaYyKOBjad3OILIZp9N3Xv8ENoQumr3u
 VKKGs4A3e9wganIFSfF3Zsyrx/tFOD6jklZIzvNElFUuQhOIUBtizIWMc5wTgdqORCMC
 VStQ==
X-Gm-Message-State: AOJu0YwJDfPckqm37QJgrCA/WYVxDxArLu1ZK/I0QvuwHMmtoZQtxB+U
 va+tiGjR8ow04X/k5tLxUOytdPCkKJEKwrtSV/APoHRY3Rctl7q16gL+Zi7EmeBFjIqIhqjlhhr
 x
X-Gm-Gg: ASbGncuwdd7iBlif0uYrbgl0d16mDIwWWh7PGNfW5txcD/yAUScvgDRLSQWjH9ylDgr
 WUeWHF2kCoc+VoAbqJyZWRziyQ54KCZ+NP+gi4vlPZEFeMs/74PIrDspX4z1U8bcK9OW5vp2zf5
 7qdWb6/So03YF1maG0By8V8YIguNvbDNf0a5VY83SqFQcvAc58ghOA7ZEUKOnpF4NuIgFUraXfY
 Q1GnUkTLe0pK57saCyjiuTVrh1O/UBOii0U7U9YNogHxb9lCakmKdHcqmwAlQCVTBAEmKYlBlz6
 zgLWpbaeP5po4QJerLBncIVwKYnodOBd5TtjnsWREafJ
X-Google-Smtp-Source: AGHT+IEEsF3k9RGAHKI6byG+A+vkqd0wzsLFy6cQsq4ZWFCLH3YwKFMsHMGnrfim33vYZLZM3MjK9Q==
X-Received: by 2002:a17:903:11c3:b0:215:4a4e:9262 with SMTP id
 d9443c01a7336-223f1c6af8fmr81636785ad.8.1741243286218; 
 Wed, 05 Mar 2025 22:41:26 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cffsm4769355ad.174.2025.03.05.22.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:41:25 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
Subject: [PATCH 0/7] hw/hyperv: remove duplication compilation units
Date: Wed,  5 Mar 2025 22:41:11 -0800
Message-Id: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Work towards having a single binary, by removing duplicated object files.

hw/hyperv/hyperv.c was excluded at this time, because it depends on target
dependent symbols:
- from system/kvm.h
    - kvm_check_extension
    - kvm_vm_ioctl
- from exec/cpu-all.h | memory_ldst_phys.h.inc
    - ldq_phys

Pierrick Bouvier (7):
  hw/hyperv/hv-balloon-stub: common compilation unit
  hw/hyperv/hyperv.h: header cleanup
  hw/hyperv/vmbus: common compilation unit
  hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
  hw/hyperv/syndbg: common compilation unit
  hw/hyperv/balloon: common balloon compilation units
  hw/hyperv/hyperv_testdev: common compilation unit

 include/hw/hyperv/hyperv-proto.h | 12 ++++++++
 include/hw/hyperv/hyperv.h       |  4 ++-
 target/i386/kvm/hyperv-proto.h   | 12 --------
 hw/hyperv/syndbg.c               |  7 +++--
 hw/hyperv/vmbus.c                | 50 ++++++++++++++++----------------
 hw/hyperv/meson.build            |  9 +++---
 6 files changed, 49 insertions(+), 45 deletions(-)

-- 
2.39.5


