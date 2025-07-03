Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B76C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiJ-0002j9-86; Thu, 03 Jul 2025 07:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeh-0006Us-Is
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHef-0003FY-Fh
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so43394355e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540339; x=1752145139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7w2y29aMH8m2GXB1cVKamGcDeB4cPEpvmgmQ9G6W5E=;
 b=DKhIUGU52Hs/cVEastS+Eu9UsQ0UJ0q8iq+V9xMrtiLZHBzjBHOdG5x3Eq2f5x9qu7
 jKg9FlBLTfurFtUtYKjpIGhGhJzn0V11OYOEKNPwW3bpmH0hOwoPGxz9EgMqm9WzVEXY
 6mwWH/5pnlNwGo7Z0/nyjGS1CGZISYj+hK4aWkJPqWzAI8+2pK+OVDEsB2XYzGC+E4JI
 nQtLONvmjR8qdAePZS+aF9fWiLGxXg8Nq19w8iqApC45eaxyx/aoa5u0pPk/QH3TCbBR
 gO32RTQ2buMTQwJ4PAzEqpHdVF3uENApqoGQaTk9WGk+FuPXhcT8aUQiD5ZO1bv4rws5
 k18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540339; x=1752145139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7w2y29aMH8m2GXB1cVKamGcDeB4cPEpvmgmQ9G6W5E=;
 b=cMRg8XObNneyP3oGnqHNPGkzXlOw3X7eJ8ACEnt6+otCX0hBjfXD9rVkoNU+vQiXGw
 fmbPqX8F6wzaS4Bf4y1j88FygP4zZl9G9O5stk41rIht6ffCDtaH6ChyEh2zpmZveDjl
 2umScWheNWc/nU2g2d8ShbevS4OMqsvZ50AY4ubOmSwBOS75WFIfwlr3BWsyfiR9SHIQ
 ikQQd+mDZ4iU3IlWG194KAC8GF/thNWtcuSttmvcjHH8Xch7fmMyHPNVCYS8/onKII1H
 EKp1kjBgr+pGHGbV7ckFUUVsKhZuFXlQr/FAdGS3CCkJpzGbmtu9rajXao3gIybfIGqr
 5hDw==
X-Gm-Message-State: AOJu0Yz3GIwF/C6X6+U+M72f0zUJPdNdoZou2YO+XvcYmPLZitGk66um
 IM/LZxDsImcWJ6MxyjNI/mYyvPorcWnrDyEoxNWMMfD2X/b3TIZjOmeAgwAJd0s1XlZ9pFMOMic
 ZfGRbTfg=
X-Gm-Gg: ASbGncuAipOc0jsXz83gdIN7gt+yA4Sen04cc/nlgU2oi3yKERkZomn9x4TT4gG2Y15
 ot87C6Ke9/8yzoHQI8paigbKjSNsnQQQCT0jmdI1SFb+YZOqTHA0z+p2AnQfCsxdfC03NkaIdBE
 fcPCibmnV+OURXrOd2BuhlsY+N6M/3oxzcOsnp5RdjvaqaUEOyq4rYQuSvA1G00vQ+WmrI0F77A
 8tFUWVRz1CC1ptq5pN9W+A/SH5ZxmbzNYU/TfJp2uQkfPbabRfQfFdtevtQEyeXlWWwgdtmpHoJ
 BZit0fuTPXFjWD7UCmdATd/d8jPt5+D+9bNZKHW8WWrve4JWsrv5/HvRp8eL7IZdG8eaefzapJq
 j9LY1CfeLeeQ=
X-Google-Smtp-Source: AGHT+IF5ahPc5pVpL/RRiZOMFhVAwIuTvCHpmYwi9QJmIWkfcSRYSeWG3E6EuXcDJdUkQxQiYDk1OQ==
X-Received: by 2002:a05:600c:8b33:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-454a3b33b8bmr66043455e9.15.1751540339032; 
 Thu, 03 Jul 2025 03:58:59 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99b1c2esm23268505e9.30.2025.07.03.03.58.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v5 37/69] cpus: Document CPUState::vcpu_dirty field
Date: Thu,  3 Jul 2025 12:55:03 +0200
Message-ID: <20250703105540.67664-38-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 162a56a5daa..5eaf41a566f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -442,6 +442,7 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @accel: Pointer to accelerator specific state.
+ * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
@@ -538,7 +539,6 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
-    bool vcpu_dirty;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
@@ -554,6 +554,7 @@ struct CPUState {
     uint32_t halted;
     int32_t exception_index;
 
+    bool vcpu_dirty;
     AccelCPUState *accel;
 
     /* Used to keep track of an outstanding cpu throttle thread for migration
-- 
2.49.0


