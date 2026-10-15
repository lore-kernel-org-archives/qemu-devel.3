Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD72ACC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHC0x-0000Ah-Ep; Wed, 14 Oct 2026 23:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHC0K-0007Sq-S9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:43 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHC0J-0006rD-AU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e83d2cc8a2so8889975ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034378; x=1792639178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xGayRwOwvphvAxw942c2AcE8znviMgTw5tQV3iQ4IQQ=;
 b=JMCaPB0DSaOcuYo8gg0xjhoKY7AewXohnQ8B1i79era2BZQGTZ1UGSmvbP5cH5owxw
 Qr7MslTE8qT8uFdLCk2gEEdXpeC5PYs+tF51sDpw9zicWnocDfVvn1M0vkwE8/vGVv9L
 K8lmnxpaakuG2b8r/w9HjQY/hBw792ij74+vA9Idwq44KXvAVoyuNg3kmlzB3nU10EiI
 CK8df3TDsxvf3H3KdbVPcmM/9CLAy7T/lEV+3K6HP3P/hCoM4X8vdp6JAIop5x4Fd262
 5YK/eGcU+Yx8aiZtuGccRsdJrRXKJWuzJEXDxv45bw71m4zdAd5rfD2xDw0wwl1xuzCP
 4x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034378; x=1792639178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xGayRwOwvphvAxw942c2AcE8znviMgTw5tQV3iQ4IQQ=;
 b=Dg6ITCaGN1gdnQiRwN4Z4VaQVbCOepVnpGMxw8BSKyRiNgZjOnBJpZGhJpC07D/XnB
 rhP3V4I4Q4s8rOEaXjLZ157NTGcHZrnAVkyzc71GIS7Xbkq+0hveZxEmyfZp369R1+3N
 vVl5bNRIjWz8oZb1MgyaPr09kcC7Q5k89Sq34hwdMIfl9spOcYMkEl9f9zwXRJpLSHCT
 MjqoJnGxIySflaPeizJlt7QIEVxyvDYDH9ugIfMBvBmsPsP8vjFvNsaVKTBpfZCvUoy8
 /4GQFKhkIzWTISNb7I7m5/uG1+KgnT+2NO+f5zVGideAdQ/tFtpoANEgW7n4XfT8MMlk
 qV/A==
X-Gm-Message-State: AFq9FYKl/XBSWaUc15x9lSL6hnGmMdK7GFXUEWVlma5WFAcp13vFyWeL
 OSeMRKl6PtLFR0LVvv66u6neZMu6uY35RksTY1Px6HriTmvl4q9h8P3Ek84nIqfVGXjtMBsOXH1
 5Z/H6NOg=
X-Gm-Gg: AYBFou2WhgfYXY2djONsgwf9dMQ5nqzJpWq8KDf/5AQ7BYqGmvDUUILC9QciOhk8f7f
 n7NjHmQgkSGOgOfAwcVhFyMaWyYSnLHePdp5vzkNym/eYfP8Q6fWF0RFlVZzDw8iFKNAzf7S0+O
 uu4LuS5FTqhXnl34eLliMdC3xOusTV05/z/vYUzosuri1hlZImV6fuUWZn135hGGLqCKmyqzp7h
 t1P4MTKt8rTPdTF6qEb3WSoi+lnMd/Xu8vtzI3s+B9GMauzA6YcLRF+JydSYiGu97hgltArvLGy
 lCoUe4Ucdmw+jpFCqtSHneGdAt2mWdoyeNT3APDgX4OTC9z5cYs6Wfi9TMKPj08Y2S8wrcNsXOs
 1bAo3/NpEdTecqo8d3OT3cFggE1906SFAhH/era+nN/7WCS3nYSyHMMMr4PFOUBtaywv8xpApGx
 6o6XU7P60g73xkhvFoheRWFtkXeGFwg+qNd+2zv9JePgKqVfqUCVXnlX55empk6wrLPxV8jgLlL
 G5K8wHupIllf2doi1kRc0aiUGqTUk3WgWrtHq8MjLxYbOI=
X-Received: by 2002:a17:90b:3a48:b0:3a6:e61f:749d with SMTP id
 98e67ed59e1d1-3ab3a33ce37mr25574879a91.1.1792034377331; 
 Wed, 14 Oct 2026 20:19:37 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:19:36 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>
Subject: [PATCH 12/12] docs/atlantis: Update Atlantis documentation to include
 the RCPU
Date: Thu, 15 Oct 2026 13:18:04 +1000
Message-ID: <20261015031804.2406055-13-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This updates the Atlantis documentation to include new machine
properties for running the RCPU.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 docs/system/gdb.rst               |  2 ++
 docs/system/riscv/tt_atlantis.rst | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index b6d8f8e77d..3777630337 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -79,6 +79,8 @@ debug some interaction between kernel and user-space you are better
 off running your guest program with gdb either in the guest or using
 a gdbserver exposed via a port to the outside world.
 
+.. _GDB multicore:
+
 Debugging multicore machines
 ============================
 
diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index d94d064f4f..f7265813d1 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -12,10 +12,27 @@ tt-atlantis QEMU model features
 -------------------------------
 
 * 8-core Ascalon-X CPU Cluster
+* RV32 Real-time CPU (RCPU)
 * RISC-V compliant Advanced Interrupt Architecture
 * DW8250 compatible UART x5
 * 4 PRCMs (Clock and Reset Controllers)
 
+Boot options
+------------
+
+ * ``rcpu`` enables the RCPU model to run alongside the Ascalon cluster. When
+   the RCPU is enabled, ``UART0``, the RCPU's console, will be mapped to the second
+   -serial on the command line.
+ * ``bootrom`` binary to be loaded into mask ROM and run by the RCPU (no effect if the
+   rcpu is not enabled)
+
+To enable the RCPU model with a custom binary and the RCPU console on stdio:
+
+.. code-block:: bash
+
+  -M tt-atlantis,rcpu=on,bootrom=../path/to/binary.bin -serial null -serial stdio
+
+
 Known limitations
 -----------------
 
@@ -39,3 +56,16 @@ and Linux with default configurations.
 The development board hardware will require some implementation
 specific setup in firmware which is being developed and may
 become a requirement or option for the tt-atlantis machine.
+
+Debugging
+----------
+
+Ascalon and RCPU are on separate CPUClusters which allows gdb to put Ascalon
+and RCPU on separate inferiors. This prevents issues with switching between
+RV32 (RCPU) and RV64 (Ascalon) targets.
+
+By default, gdb will connect to inferior 1, the Ascalon cluster and the RCPU
+will be on inferior 2.
+
+gbd does not handle multiple inferiors by default, see :ref:`gdb multicore`
+for how to connect to inferior 2.
-- 
2.43.0


