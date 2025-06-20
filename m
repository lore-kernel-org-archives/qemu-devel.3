Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C68C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTI-0002VD-C8; Fri, 20 Jun 2025 09:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTC-0002ST-Rf
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:52 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbT8-0004Y6-Si
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso1475149f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424865; x=1751029665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtS7m+vqlh7Qr+Y7luF/PvAhAhpP9RBj3It7GX3FL/4=;
 b=zH91U74iSn5GtKsckcmd0iBoAZcTzYYPUUmewBX+jAwbdVfmmN1EuXv+brh4j0I12o
 gR4YEtvCY5ITBDpicYLQWEXI0qypQo3B7kZJS87cbhefYFe6DFiB+xPZB+cYnc2lVJwj
 dXEJ6jT4TetBaCvmKfuMAAr51vAFCX4f+k9J8Xw9lLXU0Rj7UH8t5gyy5lCNNPxpEQpI
 FphVgY9gp1STY5RtfadBWPqcQmtyXBJbLBYrMEguJ6pBMjwS7aGW6uIaMZVW6zslfhtn
 0zrerrI3o5abNi/7F5/i/n3Usp9UqdF8TZ4txoemzEvN9XF93sHrn2PyjmTIpZ5nsviq
 M7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424865; x=1751029665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FtS7m+vqlh7Qr+Y7luF/PvAhAhpP9RBj3It7GX3FL/4=;
 b=Vh1B+GZnl0T+lA7/Vw5U0LdAexh7jed30uoKdh8bqd7cq/+4/o3ytk/t2pSAEl9n/c
 i+UnWcj1F2quwqDKglr2WoccN3OyGGIIWeOXyatFFMS9PU+MTqYhD4l5QgD4hIYTdhvc
 6RUffT5K2OfD3d+IxCvLnnxHL2YI29K9VxL7Oz/euJP5SetgQRN1l1dWtjkHdsK7AhiA
 4GfhVNAHJifYw3suUTkK6rTPqp1LhgCy9klZbceSvUDJ88aWFtWW4M+mPMm2HIFB+1Rc
 mlaYJVie/2t1gNxbOn/OSqlR5TXokQqLY7ruTOvg9cA2Bz1xKskKVTbUEs4BjD0zZUA4
 ngZw==
X-Gm-Message-State: AOJu0YzqaouZGUsIK/wC7zl8jOkNcg0iCThYRQ9+yzAgCRwVWSdmsyWV
 PHmJcRGkgaQQSR9puG2AHTUqGALqxSIxrg73S5FwlakdvY21Wfxd5d0bOrm/a59VcS97vJZie74
 XXBMSAJY=
X-Gm-Gg: ASbGnctU6h2/ckRjnicKxmGmAQZU3QCVg1UVMOnRsaHS8eunUONlPDWJn7lfo8ObAGP
 P7W7Ja6UZfU3SWWGGRtIYFACLoo0x1hCpdh/9UzGktai60jmhYVwGl+2cfzryWxx8XDkKYBRItv
 qed2eKOSssBGEwODphnDdsQCf7mWGV0aSetlH0mND+1TL70l3oOCfoGYU+fysgPhaKhXFtfubvM
 lDZxMUftPPrAVtVneysUqiNaaUAH0E2VoK/ZJL7dm9LsRF/0CKdYRI/4n4DiLhnVA3AkLP0LOHR
 Bf/Y3nAE3aGXujdS0pzUNn4NnMmX2dmVs412ms3eQdIaIKEpoBkqkVx4TsqCqHOapkJ2qS8CADh
 GMUw+OogolBJIsxHVq6mxrCc2eivJv63jUIvF
X-Google-Smtp-Source: AGHT+IEu8ioD15jbsMdE6dCvAm9djKzVzv/o3I1P7WHIydoF4yyDTcP15aw9RWPaSxBAHXijuGZgUA==
X-Received: by 2002:a05:6000:310a:b0:3a5:8cc2:10aa with SMTP id
 ffacd0b85a97d-3a6d12fbab7mr2059859f8f.32.1750424864938; 
 Fri, 20 Jun 2025 06:07:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd6efsm24774235e9.19.2025.06.20.06.07.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 06/26] target/arm/hvf: Trace hv_vcpu_run() failures
Date: Fri, 20 Jun 2025 15:06:49 +0200
Message-ID: <20250620130709.31073-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Allow distinguishing HV_ILLEGAL_GUEST_STATE in trace events.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        | 10 +++++++++-
 target/arm/hvf/trace-events |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ef76dcd28de..cc5bbc155d2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1916,7 +1916,15 @@ int hvf_vcpu_exec(CPUState *cpu)
     bql_unlock();
     r = hv_vcpu_run(cpu->accel->fd);
     bql_lock();
-    assert_hvf_ok(r);
+    switch (r) {
+    case HV_SUCCESS:
+        break;
+    case HV_ILLEGAL_GUEST_STATE:
+        trace_hvf_illegal_guest_state();
+        /* fall through */
+    default:
+        g_assert_not_reached();
+    }
 
     /* handle VMEXIT */
     uint64_t exit_reason = hvf_exit->reason;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index 4fbbe4b45ec..a4870e0a5c4 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -11,3 +11,4 @@ hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%
 hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpu=0x%x"
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
+hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
-- 
2.49.0


