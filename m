Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA55DCCFA05
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 03:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFlOH-00068n-1H; Sun, 02 Nov 2025 22:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlNu-00062X-L3
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:37:36 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vFlNs-0000Cs-J4
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 22:37:34 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-340299fe579so4112216a91.2
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 19:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762141049; x=1762745849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=db+Ekq9ZlQ6OwPFUrOw9iSwB7ZjdaVlv1TkkdVkABH8=;
 b=HizgSWAutZE+TSnCwbR0Ma3okv6dMBLymPDdoJlHyO3bTQIC7K5jMoa4W+T+WMkh1q
 aMxDrmX+G6CjxBNQKCwDXYiwR4lsIcC5JTz0+zhVty1dnqdIT2VhFTFl5+6t0l0ltp3K
 uJxvpBorZ0W06Vz7rDMBHi1SI9CCg+SoDKK97NWxOuMsa5S4hafIlUTthKAfyr89ieZx
 Ylc4nXB4dw1fcgLhKmW5EMaN/uJXi313kZ0TjDR4rSqBXgHSr3zgnA/VkClHty5pOLgC
 x05uTSjKZaRdWPDEfvYXXMvLCwQgYyxZcJ9uf3lnCXVzbjRIe7kmOArTNFm32sifE/Kf
 k39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762141049; x=1762745849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=db+Ekq9ZlQ6OwPFUrOw9iSwB7ZjdaVlv1TkkdVkABH8=;
 b=jaJUFDXodvKbufrzMrU1slh4YVvBDfWl97ykq+3AYYTfMn1LcrLzi8tcurXpZS8rwX
 Ej1pxT/3QhDdkQmv5luImcIODbwxG/s8VTYlsDTvjrhYUPboH/dKYPBD8ZKFaDl4dQP7
 lmdTd+pzDOf6rKYNJHt/P7jd9PPFrnbMPxbLRkbry/rzoHkSfGK6YEaLoI+gYkBCGBY4
 vXECjYZNq0Fapdcm5Ym2xkNW2xyyzty0uW4vOBJnjYREfaEHGX9Y6CnMq8FydkSV5cYh
 N2ekLr7XyhecUoe7pW+ehvk90omdwrkJMavUWJOTY7XM1KJhkpjXY19Dmqsm3u/C0+kI
 zRjA==
X-Gm-Message-State: AOJu0YxVzQVhdyyq9TaHRkUxh4+t5ftlNxDrC/k68Izb/T16KyZQFvPw
 xmUc68v/iAkrLTC3Z9yVWwBgFqIESghsoXf1ZnrBqLVnYlIAjFccCgEHHArr+w==
X-Gm-Gg: ASbGncsGobjE6mw5iprVOFnGvgzRwq1Zu8nKaXeKCwNrZX0KLOYDlj725ga4YRvg/8f
 pSZSAPGGVS0sdSQUvG+R56tMMCI46h8cOAFWgZNFcibq4ljwqLt5mcwKZ30cTUP0FWE7vMcUBts
 V+LzGgXDc9QQiFQMqEfDB1crFsKxmyUQmv/H9kxdqhjj7YLbJwIBUf1aOQ1HI7twuV1Tux4Mw7p
 p0wHGT5smauQGLnipUVl9MAIJ8LGcENYQNUbGGUeqmDaMP8aIA2jpnmbDDILKuzUQFCFQI0P4nT
 XEbkJRybko68W05xwEvJfeaRz26dlJWqlfz93G34CmWQ087AHxXzDKNc0cIuuuBkHAy+xGSwV01
 lrR/UO04Ea6pLPMgnxZLlobqdBagNB2vWJj3mjbyROS5Dwh2+TR8j+qjVga3TI55YdDXvRRQ4CP
 b9mkR52ma6siornkK6e0TPiWqyrwOl8XekZl9dAUivNsJ/OyIR2PsQRbY/QWG4cW1Zi/HVYmBYN
 QoijBuQ4qF2wlMIQqUq+lReaDe2Ww==
X-Google-Smtp-Source: AGHT+IHsvlUHpKRjTGM/vIv3BOmn5V6UGnSPZizxxUaD3UT5t+oMKQJMSVRKf4L8VyNB/NLRwF00Kw==
X-Received: by 2002:a17:90b:2583:b0:340:7972:a617 with SMTP id
 98e67ed59e1d1-3408306e83fmr13999548a91.18.1762141049101; 
 Sun, 02 Nov 2025 19:37:29 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340a460ed24sm7939641a91.16.2025.11.02.19.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 19:37:28 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org, anjo@rev.ng, philmd@linaro.org, palmer@dabbelt.com,
 dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: alistair23@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/8] single-binary: Make riscv cpu.h target partially
 independent
Date: Mon,  3 Nov 2025 13:37:05 +1000
Message-ID: <20251103033713.904455-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

This is the first 8 patches (one of which has been removed) from Anton's
series [1], plus an extra cleanup patch at the end.

This addresses the comments I had about Anton's changes to
riscv_pmu_ctr_get_fixed_counters_val().

Besides my new patch and removing a patch the actual changes are
limited, so I have kept all of the Reviewed-by tags.

1: https://patchew.org/QEMU/20251027181831.27016-1-anjo@rev.ng/

Alistair Francis (1):
  target/riscv: Remove upper_half from
    riscv_pmu_ctr_get_fixed_counters_val

Anton Johansson (7):
  target/riscv: Fix size of trivial CPUArchState fields
  target/riscv: Fix size of mhartid
  target/riscv: Bugfix make bit 62 read-only 0 for sireg* cfg CSR read
  target/riscv: Combine mhpmevent and mhpmeventh
  target/riscv: Combine mcyclecfg and mcyclecfgh
  target/riscv: Combine minstretcfg and minstretcfgh
  target/riscv: Combine mhpmcounter and mhpmcounterh

 target/riscv/cpu.h         | 106 +++++++++---------
 target/riscv/cpu_helper.c  |   2 +-
 target/riscv/csr.c         | 221 ++++++++++++++++---------------------
 target/riscv/machine.c     |  99 ++++++++---------
 target/riscv/pmu.c         | 150 ++++++-------------------
 target/riscv/tcg/tcg-cpu.c |   2 +-
 6 files changed, 227 insertions(+), 353 deletions(-)

-- 
2.51.1


