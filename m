Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08255C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdWM-0001DG-9j; Fri, 07 Mar 2025 14:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVe-0000uX-GH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:38 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVc-0007WB-A2
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:26 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso3663512a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376242; x=1741981042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9HouUG8niuHw8Sf2QTc63hh0W5B3dkdBWi71GrcJcio=;
 b=Qc2znFrLBgvl8NIhfenStgOxBZtc4UydCS7i5/iHTXjeLebxG+w/CObABuWSpUWvyC
 F81bl0gdOHBhEp7/wzpu1ri9YaPq11fiAdosatcxxyhP+wkiADAcivYKhBxEpRltLs0v
 SBdvbALGFq4HIpZsy73NvoWbs9Ac4t6ItNTQ87x/ewE52GzzMo70PfWeLuW0HkzgAeL6
 GKugz73A637oflYPiHn+FrISx6XuOB+GrhgwXdxyr9oCdBCOzNzDAKEiXz3aP/GS3j7b
 BVAiuyVT/PhnhqcifPRLx3hio9UeH1RxRteX+YXaCgjCcXbPtIuYwmZQBk52SrAiHcWY
 u93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376242; x=1741981042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9HouUG8niuHw8Sf2QTc63hh0W5B3dkdBWi71GrcJcio=;
 b=JGpbAlur2DSG8OGLWC5slpDGjZ2xfiG/EqkfujkBDCmE9FXs9oezpBzF3toct9rAgv
 9Xs/WOSp0j+SO/TBSeZwQM+xeUDU3z4ocRXLIZmhlR4Hl2szF8tafNoFC9AjaLT0L7BR
 rRsWN4fgL6f3p1f0WaYbpIWXcDTRdb8yGgcG3GSdFkGUAla9H/1MUolRL94DBuwHbu3e
 JvQmZHGk1BhMeoUkFZRiekI38pSI40qk8HZCJfGGPFkVL6ReH/W1IUbnkXrTcSs8MFLA
 ZAkGhglORw+9vFjDTS1OByij/OkmHpPOv7f/RF69WA4AHht0tBQe42DU06Wc+C8A3Lub
 vLOw==
X-Gm-Message-State: AOJu0YxLhanNt5G3rZIY2NZvrhfM2HOtTt++vV76TbaY6Ywtt1b6FNmf
 U07vPwRpwKCDjvFfrEOy0Xf0kr+9e7MbNrrZRxcQszgmwHWbRJz8aGvIFn+NoTPI/WwwcGjjBkD
 o
X-Gm-Gg: ASbGncsmhGEB10d7pX2Crf3PlqzgsHkkSNIxLQVQKg2mldXCK7acf7V7FS/fLEJnGLK
 g2boXeqdFI3WOEWaf7XUZ2UsdRCpvNS+S6A7/USYGfJ7gOZN6ul7FcjnBos4mGuOnXvIhTFtm5Z
 /7QvRvqpCkDY0pwu4Y2NQZwkRpC83wH6mbaoeNX81GWlchmcSCZyJ0mPvv6fUxgfddXTwv+x4/A
 jLM4oYIMhE603jmKmCBtN+VCm0w8yjyFzh8sOobxPDF7v/NllTBTm2378zpSmU/hZyiBOgwdLau
 9LLwdnCa2hmXP2n+wQ8LrHt1T3BYWvvT5cy/hhVFjZ+h
X-Google-Smtp-Source: AGHT+IFJS++w8dzKDaOiSNIqEF9LrcEsboBc4OQa3FNMlu4p0lXjJGWbKjKjpc9ao6Lot8C40MJZdA==
X-Received: by 2002:a17:90b:350d:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-2ff7cefbc61mr6158126a91.26.1741376242639; 
 Fri, 07 Mar 2025 11:37:22 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm3821757a91.26.2025.03.07.11.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:37:22 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 0/7] hw/hyperv: remove duplication compilation units
Date: Fri,  7 Mar 2025 11:37:05 -0800
Message-Id: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

v2
- remove osdep from header
- use hardcoded buffer size for syndbg, assuming page size is always 4Kb.

v3
- fix assert for page size.

Pierrick Bouvier (7):
  hw/hyperv/hv-balloon-stub: common compilation unit
  hw/hyperv/hyperv.h: header cleanup
  hw/hyperv/vmbus: common compilation unit
  hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
  hw/hyperv/syndbg: common compilation unit
  hw/hyperv/balloon: common balloon compilation units
  hw/hyperv/hyperv_testdev: common compilation unit

 include/hw/hyperv/hyperv-proto.h | 12 ++++++++
 include/hw/hyperv/hyperv.h       |  3 +-
 target/i386/kvm/hyperv-proto.h   | 12 --------
 hw/hyperv/syndbg.c               | 10 +++++--
 hw/hyperv/vmbus.c                | 50 ++++++++++++++++----------------
 hw/hyperv/meson.build            |  9 +++---
 6 files changed, 51 insertions(+), 45 deletions(-)

-- 
2.39.5


