Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D5CC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNpZ-00077m-Lx; Thu, 03 Jul 2025 13:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpI-0006JZ-Uj
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpH-0000KB-99
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso885375e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564060; x=1752168860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7w2y29aMH8m2GXB1cVKamGcDeB4cPEpvmgmQ9G6W5E=;
 b=T28jY78Pqc7y1V29IVWN0gcxnYHa69hTn6z4lJI+Tif3S8EglTDr7XJM6YWUqqDZ5G
 U5ThG5VeW93x9KUFVwtEivmrTMd0ocm4BQwfM5GQ/wlPmiznCXe47DjLCZBUznI1zTrE
 GU0QcJddstUTnpxZr2KA51JhKzBc5qoqdNLkd5BPs94Dk6UHpPxYuyhrTzC6AvNSpUz9
 Fr1yt7pIvFgEj2izzOvJXb+cPnBXR09kxY9+iG5mBGqO+z/vUd+kz3vl7xiA/OcgP08Q
 /dqul3TWn+hOQOBulB4SZYnuQcMAIh4QtJfD/onzPbOYDCsTTBkQkm4W5N0L7DF+x8xv
 NVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564060; x=1752168860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7w2y29aMH8m2GXB1cVKamGcDeB4cPEpvmgmQ9G6W5E=;
 b=t3fHbd/M9rhVAZFiKopAWx48QmAGZe4s5lWO8PmGzsb/njyHQQkY0CO9YFNX0m1PDv
 aP0Pz64QfgiL8+LxsUy5vBJajwaUrpRunOZsS3JbfxDbECLv56axJMpD7LTYc7FNdjU/
 wADPh//vTBMln0aULtbMkgP3R87oypP3PvCM8tL4VNM3FueeO4AlNxGS1I59haOWZW79
 2rjO42FdpmQKXHoCcoeSw1AxI6cMNDmT9zPabnIZChPt3ldhUn9yDuVpj3YsLiRvZRvM
 KPkzFakg0wKaHLA6XAqJBM++6sI+IKt7mVo9Zoo/6GLpwnGcphrCpvVgCJsJnL+bFNXl
 C2ug==
X-Gm-Message-State: AOJu0YzpWCVvrYjOonYsif+EeAPXdyrIRvdw1cGjPL0VJYUwzYV+33eN
 VS8kVhJtBNbp2XGbTtex1GE8TQxGbbSuJhG8oCEiisEsq+A9zJWQxNLfdaxO9Wd3EsmQofqFpwD
 av5yi7+0=
X-Gm-Gg: ASbGnctqxSiMS05/Py9Zphp/UfXlYVT2b/+IqgsQutZB3EaWQji40u0pmSbIH3AVx+4
 NGkHFZE/yKvYoeZOt2y4yX3fKJ5J85lIEuND2sLGcEbtKjDx6WorqGMkVN5XnnL/wFYVP1fH8U4
 fBY5/VCQW1jtrUPlXH/y0E891vjBg1xE4ykNUU8AgZGyy9QjVaqG6eDLy1Tz3gSjI/JanMgWTKI
 6R92UpUTDh8tJBuv0/kXWgnqYpp8fTIpwlLiwq4ajtpz/s4V72+jo4DCXhvice2MNzDCmFAePzk
 DusKxln83ABTWDVxBuh9HGS+xhYUjE/h4C4LbaOOQOebp2k7lxS1aJeNrpY+0JjUGOKl9lI/gYG
 VByyU8hfQh3fcCIfSvsNMoOT1R0vDrqA0kF67
X-Google-Smtp-Source: AGHT+IF6eMSZZafa8TfN18jd07TqYP40t1K+4NkHapAdazU2PCoffmTqgnOFWnC4qDy+kz7lrdehrw==
X-Received: by 2002:a05:600c:638e:b0:450:d104:29eb with SMTP id
 5b1f17b1804b1-454a36d7ab3mr75862045e9.5.1751564060252; 
 Thu, 03 Jul 2025 10:34:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b16288b5sm3607595e9.9.2025.07.03.10.34.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v6 17/39] cpus: Document CPUState::vcpu_dirty field
Date: Thu,  3 Jul 2025 19:32:23 +0200
Message-ID: <20250703173248.44995-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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


