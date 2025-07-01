Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD29C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSb-0005ga-PD; Tue, 01 Jul 2025 13:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSX-0005dl-V6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSW-0003c6-8A
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:53 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so3260663f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389670; x=1751994470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=il8MRx0ocqoWHUPwZJiya0xTcuVfrmMJ7yc2s+LkZk4=;
 b=gNuRDoOwtGnPxfg6pnuw++6cEmVsvW19K/ffHt1Mqli8CMKZRITAYYOpIhIN3I0rRe
 E+1kTGpCk3qulu1wWHZ3244weFmNraMwao8bS1HDHQ9Cm5GbVdiQN4ZIphygRAHmK4ZM
 vvBix94XrvhAHFUEFh3pKdV3fWjhhrcipmE79i5f/i7S5trmQbeTkwPF2fin0uAN/PS/
 xgWSzuWwIhxpYjkOuC5fJZ3aNEx6Hhg6Osq0oLElZdSIUBfVD3fjBoHOnf7G/ePCfB+x
 eNuk/zehfml9TT1gPa93ET7zogddJ/v8iDxpn5Gdfn6Uv9dy3bGrttEEYSsIyZml9Gmf
 4UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389670; x=1751994470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=il8MRx0ocqoWHUPwZJiya0xTcuVfrmMJ7yc2s+LkZk4=;
 b=waeF7y1IV3BN/Ba45P50fu/d8HJeTmhVgqtlkypUAu3aK52SH73YUGor6/V7EpfZaZ
 xTYb+5BQou6N/HoMOfy96ZlCe5ynpnaT5HubtZ8dBRXr9ZOGTA9hG/e9fOXF2kFHUmO2
 dS6Zt4v0auwR/3Amggw7VTZF+VEV7lXrFuBE0VWTUgI3vPEOvw81Pu9hK/J0GRZIiTKw
 T/gpyZewKu3Qb0dr4p3bUmTYODkTYVblXgYTydiu0JFDkFzkwCnKnEAOZ3dWr2tuQufg
 pAlNEPSGE2O/b0JBHOA8M9i+yS7LCYFJoGFstiDcm/kw2fdhCGBZNuNgATFB9BddAxHy
 BgOA==
X-Gm-Message-State: AOJu0YyHxOD79uZNcQ31RQNycM49SmupYXCghSzNpTrpmJiNpA4mJ0DI
 qZV/YBRn/vmhwL1OK+tdcXsnA0a445F6kFjlKkm9x7HpuyeKGfgnKFj+Ndo3xQM0by1gJj0Qdhg
 II0fp
X-Gm-Gg: ASbGncstSTUpyTNK53+RvQYA8ta6ss0sQlRziZO7tBqV2LOfhjjZ5XUAObIU/K6eMUg
 e1DtpEEmEMsOuaZNFmDX0ov0+P3aXlLilbvlQyawGzOmk61MDTkqAS69c8K1uKWzyAJYQ/lkvAM
 lARMKSAx+9V/pQSKjcw9Q9FrVulq7Z7bdOU8wQPCSVZ5cSJ142FtSykl/xah3gaC1PyFC7vPZZ8
 CADT0j0vmop2xfgZ8bmx5+SY7LZSR/k9zv5DdsEe8fOZNVCNB0jeVpgmREhXsrwmTd5nekzJ9tR
 40rXN8osn+N35YM6iWWpqy+uNQpQM3/+NVJm+iqJukbkq9yX21wa2VTVi8rz4LtHQ4G+
X-Google-Smtp-Source: AGHT+IGkKkf4tOCZu4mKECBwrAIeXocZCtNnBQhoRgIA0HSbynB3LM2H8ULCay9YSujCnPGvxZk6xg==
X-Received: by 2002:a05:6000:1a8c:b0:3a5:1240:6802 with SMTP id
 ffacd0b85a97d-3a90066a6e4mr16545566f8f.57.1751389670520; 
 Tue, 01 Jul 2025 10:07:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/43] target/arm/hvf: Trace hv_vcpu_run() failures
Date: Tue,  1 Jul 2025 18:07:04 +0100
Message-ID: <20250701170720.4072660-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Allow distinguishing HV_ILLEGAL_GUEST_STATE in trace events.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        | 10 +++++++++-
 target/arm/hvf/trace-events |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3c234f7b112..0943365a681 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1917,7 +1917,15 @@ int hvf_vcpu_exec(CPUState *cpu)
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
2.43.0


