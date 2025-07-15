Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E390AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubd5M-0004Wg-Rs; Tue, 15 Jul 2025 06:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5C-0004J2-7n
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5A-0005l5-Ds
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so48681165e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752576018; x=1753180818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XGSrmDCR8wpv1EuhboPdK3VNEXK0BwB+Fm4Uly57pRU=;
 b=TKsL9hsFsOqESmbP7UEz4NHCMdcNKdrGOcfC1lQ2OnYQ1pvv8XCbupgKYbkTz1K4O7
 ZuJaQM6i9XBh/cnybZBU8hI5GUDpwrz23Q1/GVAdbI+otMApZ4zl56DEenfE1UHIriQX
 dphBrJHWWaoTYmuJVZ2BMFwfPjOZGGWE3E+FdjdkA6RKHFpSt4b3TM7Wi5bsS+1S6ROe
 +poLLqvaeVMQ3n9IXtHVdLWsz+dYNtAlLZH6QgU2IbBxfVv1PR0/r/QsTTxisIPbuJ2S
 /zXqU9SSBuPmCTSwHmvH9goE4N+U+EX8NzAKyXqDBF6RL8bi5SMJoMxVySeRPon15cs7
 opbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576018; x=1753180818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XGSrmDCR8wpv1EuhboPdK3VNEXK0BwB+Fm4Uly57pRU=;
 b=ImyMjAa04PvZzx7EYzvg4ARGe7v6ySlzbHoozOcCwivceQenX1xr/1hdSNzZOqFpeL
 cjbEqovdbHg3gYvnanFOWkPx3Ahj+mx5G1Yog4pTipRiJIpICc5pMTLoVvpB3aUnIQc0
 mHCp7C5fARELCauSBNXsoJg+LkLTNMg0AxQ7ZOORiqQofK+t6ICousrUyQcYhvOBTUJq
 p7l84pHPo2fJRfAhBaw/EHK1Zp+aKdA5kOZ55DA9/vpS94P8zDfXkPAti94zMvXA0ia3
 FGmAI/cal/9oJ0gN3WPBr6iYdbnPoN7WuVhc7Lx5xq0p3T1AGDMskxC9iN0iiNuoKALv
 L5qQ==
X-Gm-Message-State: AOJu0YwUPp/MpmKj9O+QS+Td+URyd3/XG4Utrco9Q3e7c7NkEjRNlB7Z
 HBixe+rfz5NIZdcA7EspqNT71ennFCpDglHBesFQhZEVozYKhuWUUby+xaVyJXoqEvun04NalD/
 FFIl9
X-Gm-Gg: ASbGnctfi+jPxLebsBJv8yO3+wdA+segeHUoHE2xkfII7Hw7CCLDBq9t1MjtRJSdp2H
 ArpVsmVMIB5UJXobwkLV5wLsUzeZRxPUwXYUeVE26IVEkN1v6AIQdiKOfdaVx5IGmoXhoudIAMy
 Iq6A+laOkNWwnauEbO1U9Kz29lQ2LKg+ntwdE0TV65chs6kqeuC8+YI+EWHkWq11Y1rPLo8lK/Y
 7JsrXmzFjhywPQWWLkmU6h3pfIAOludFQ/A4HZ5J2eceuz1ikBchdKYA4lshLNEP7Jjq7XgH8BM
 xK4jcVzWrodmVTxnpS0kNW5V7QmOdfbs7Ap6f0ebjd7KiMZiaoeaxeUwDaAIBryOcf9Ikd/v/hq
 ySzKI3sFg6bR5AFl+0SigQCMS5O//vBdkoENGYv2tO8dgyyhfmVKopRe44MNEuI24ykaR8JAV9+
 LeOA==
X-Google-Smtp-Source: AGHT+IGT55NU0BlDJ31etzAZzwwdbo6oK3auVttjNUBLIcttNpXx7p0ZPMVe7KbzfCl+NmgFG+Zxcg==
X-Received: by 2002:a05:600c:4595:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-454f427c3b8mr167076405e9.30.1752576017641; 
 Tue, 15 Jul 2025 03:40:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45614aeba29sm72541985e9.11.2025.07.15.03.40.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 03:40:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH-for-10.1 v5 0/7] accel/system: Add 'info accel' on human
 monitor
Date: Tue, 15 Jul 2025 12:40:08 +0200
Message-ID: <20250715104015.72663-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Missing review: #1 and #5

Philippe Mathieu-Daudé (7):
  Revert "accel/tcg: Unregister the RCU before exiting RR thread"
  accel/tcg: Extract statistic related code to tcg-stats.c
  accel/system: Introduce @x-accel-stats QMP command
  accel/system: Add 'info accel' on human monitor
  accel/tcg: Propagate AccelState to tcg_dump_stats()
  accel/tcg: Implement get_[vcpu]_stats()
  accel/hvf: Implement get_vcpu_stats()

 qapi/accelerator.json         |  17 +++
 accel/tcg/internal-common.h   |   2 +-
 include/accel/accel-cpu-ops.h |   3 +
 include/accel/accel-ops.h     |   2 +
 accel/accel-qmp.c             |  35 ++++++
 accel/accel-system.c          |   9 ++
 accel/hvf/hvf-accel-ops.c     |  24 ++++
 accel/tcg/monitor.c           | 202 +-------------------------------
 accel/tcg/tcg-accel-ops-rr.c  |   2 -
 accel/tcg/tcg-all.c           |   6 +
 accel/tcg/tcg-stats.c         | 214 ++++++++++++++++++++++++++++++++++
 accel/meson.build             |   2 +-
 accel/tcg/meson.build         |   1 +
 hmp-commands-info.hx          |  12 ++
 14 files changed, 326 insertions(+), 205 deletions(-)
 create mode 100644 accel/accel-qmp.c
 create mode 100644 accel/tcg/tcg-stats.c

-- 
2.49.0


