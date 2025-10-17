Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C3ACCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lCn-0004nK-NB; Fri, 17 Oct 2025 10:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCi-0004kX-Iu
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCQ-0005h7-Ie
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so10119565e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760710369; x=1761315169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtQk0GJuCq/JgD3T73Q/ujEtbCnLstw5lfgjKUjPFqo=;
 b=IbUvP/ttLHzkn03Vujr6uXLoSaDKtsfJhgXLxzEB3GdgcY1yQ8m5FFrYi2YuoUK5+C
 GbqFIE0NSqBNomDp5ypzJc0ToGhpumJwPWGu7OTh+ECy6v9Q1CeQUyfkGyJ/j17ZkMLU
 IR1cYEkO0476aMV4a5EwlNLcB2z0xsfU/UCp/2gvcsPA8RqpOnPqNacxkvqQiE1hLZrw
 BM0+kG4nQnPdfLEXlFXgQ22GXzqBahtb9SU5eePp1+AlcJCDGUugiFmSbfvK6N2CFvTy
 rpE5SJy02DaNCMinKgK47VYXnW1/5WrCBBey62shigz9Qh6877U9uIlIiRslb2ctY5pR
 jLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760710369; x=1761315169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtQk0GJuCq/JgD3T73Q/ujEtbCnLstw5lfgjKUjPFqo=;
 b=dVRD3XglOoUS5x2XyHF2yvdhv9tgsWeOlrLkAcFMgDSMpy2N4DxqzzHDCUMenvxVq3
 ZGPzcmgYQmZoceniJUEjbPodk3SKgqZtESgadGAmp0LLvHYW3r0Bf5rlzuh5iowX2aXO
 Fh/lgrPzgsPr3WCeDwTZMilMx0yPvuMaqBXMJGxyC7f6QwF0fmDpf7/76bnrdbpMTBre
 epC/E99JkdkdI1ZaiJgElPxxeTOxpZUx20iHB0GMYgH8DRvU+/bypTfXAvkPIgJGjGEq
 zX9IYlzN+99Q7Wa9cWKZLJRBe6ujLyHVyLKjMUjk+9APdQOvkwjzr/q2v9FMQau8rrKY
 opMg==
X-Gm-Message-State: AOJu0YxKfUdxuDp+uWuTLPvOX2CvFK1A4lKdu/6QlEN0Fgj+RjdMKoVl
 gTwAHrqYqL/JOuaFR3pr83FzltSyhDhz+uwgeTKJlg2Opf1UbhYw8xJdh+X+3g==
X-Gm-Gg: ASbGncu1p0bJ2I+0Qly+1JCA6bhj+BpzrQ1ARlMe28KjzRYZVI/XTr4WQDEkLcsTL10
 T3I2yZRTmZg6NHRh/XcVutasZ7iEBMjKxuGR2aTqC54ss+tF4LbwW23u2OSlpz8bqlKEQ5LSpy3
 4tXzlWfd6IDX7yTre2XE+/gmxmzpKVamdT1P5+yhZS/5vp0GXg70g8liIbiJw7/mEsvch/KaCmm
 sJrkvR8qJbdILDHZE19xlEquP7vLhscWucsjZCtcgE2zaa/JYFysTdZVRuJONoivY5/QYdxMDB5
 PCU5hcnEKNUNivJgIOrgvyjljnZD41qGlEn6opqg6cYLtrcI7C8EW/SkJ+2cmCDCd8u/ehe1cVm
 wP6ptPAi0xgJNVg++OU2mn3Ol1SbqIaFd7A1otiKFwTfMEM1GKmx0B1k3UzgGL9i05L46UAiZCq
 Z31YXK2v3fikRumGH84A8OjX+N6F+QVFOr9eBvICLyk8s=
X-Google-Smtp-Source: AGHT+IElsIb/+OVACplDy763YqEHBwFhKZ/w/iY2OrFjr2q46IPQug3eVaWvEqAmJxYiR/ktjpqWEQ==
X-Received: by 2002:a05:600c:3e8f:b0:46f:a95d:e9e7 with SMTP id
 5b1f17b1804b1-471177ab11dmr32479285e9.0.1760710369052; 
 Fri, 17 Oct 2025 07:12:49 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm51359675e9.2.2025.10.17.07.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:12:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 04/11] hw/rtc/mc146818rtc: Use ARRAY_SIZE macro
Date: Fri, 17 Oct 2025 16:11:10 +0200
Message-ID: <20251017141117.105944-5-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017141117.105944-1-shentey@gmail.com>
References: <20251017141117.105944-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Avoids the error-prone repetition of the array size.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/rtc/mc146818rtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 61e9c0bf99..5a89062b4c 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -726,13 +726,14 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
 
 void mc146818rtc_set_cmos_data(MC146818RtcState *s, int addr, int val)
 {
-    if (addr >= 0 && addr <= 127)
+    if (addr >= 0 && addr < ARRAY_SIZE(s->cmos_data)) {
         s->cmos_data[addr] = val;
+    }
 }
 
 int mc146818rtc_get_cmos_data(MC146818RtcState *s, int addr)
 {
-    assert(addr >= 0 && addr <= 127);
+    assert(addr >= 0 && addr < ARRAY_SIZE(s->cmos_data));
     return s->cmos_data[addr];
 }
 
-- 
2.51.1.dirty


