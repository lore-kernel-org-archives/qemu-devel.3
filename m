Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F40C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRdn-0001Dn-5u; Tue, 03 Jun 2025 09:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1844144@gmail.com>) id 1uMRAa-0007cG-J5
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:55:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <1844144@gmail.com>) id 1uMRAY-00033K-DT
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:55:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so33860775e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748955301; x=1749560101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mfUayeFNj169BN3f1yPfvwWtEStFaen7smBmqFXWwJw=;
 b=Bv8apTwhQpv+oHu0J5TKk7Up8VIyHIycklVNewsIx+9qLwJWE7ZP+ELNnE3HEknuDk
 jTAHWKrSWaMG5WXn/m1TwpSt7WA1NB4aazVFPnGS8w0KicAUdLrcKzLchGkLKLF9qNU/
 Yh5MrV9sLvP8ULhsmie6r2srrN5WH4Yk4OP4KseC/hnIipelPXUSHCxO8mrAeVxR7xwA
 E6DNbXy1Q6wiyCxs4UFNbQ++oUIxoWPljsi5ztp5hN7AZIlkz4Jozz58plekYoW0E6EP
 ZabzlmuFOufmTZBcWq1scCKM3qHx2xDBp9zphmv2flaD4l70BV/3nS1Ngl7T7UrHi7rF
 M6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748955301; x=1749560101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfUayeFNj169BN3f1yPfvwWtEStFaen7smBmqFXWwJw=;
 b=jKYdxN5rOH7PbNm3NOYItjC4c401dIYnj63faNBiKbY+UkB2mqhVg2NdzXSU1mqGeG
 yxPBbkXT3XI8d7GyCaS0Q6kZEO97N4KTPCjJloEu6ABqNNAvHwqYOwTlAYnHbCGCch8V
 XKh2tiOYVmM04Kd2YYagvcv8ixmPDFQopGwEMPJvXgswLNkLAUwDLJmYTx7pJvruFHDx
 bDCmNnHRcVcyzObHN18iEVtv9LXWjipoO98unbQ9baEXu5OWEbyILWJwHT9VIwAGN3jO
 A0Dcp7d5IXaPK+j0yzK1Cm73IHzMa4oNdOI7a8gqT4j6dRAueZ1+60ZISlE5CDCTd+Kw
 NQvg==
X-Gm-Message-State: AOJu0Yxkb4pO8voKl3hhOuEZX5BgUox5NuM1pDROC20C3VrGOOnf6xmf
 GKko0KOniAh8RENTULlMPHow+D7Ov2kGom+OznvEsBCVjYGY356HTmbpVEvjqDoE
X-Gm-Gg: ASbGncuC0NbSSG8q5Zkn1IhjmJtkZ4e0ARkLBFGB/ivRTvLlNfURm464vKYmcFpFtym
 4hOa/EoDABbgwrzYZ71NvbfQ+SVW7J1Q+h7HZyXgVhFImnserQm8DhoPlwO+KLHvslGwv8fLtUd
 KAq3oQzXWSwa/XY2/WrHSO2CqUCuFGRY8+eb1cY6AyuVUp/OkuH+iifafMzMaBJBg+OTPGyeVec
 4f5U9caAx9Cjz4ghQcnTtfsD3bkXFNa/nOmNpdE2Af5g9OukKT14uM/JJU15o+mQ0s6n/f2O5Ea
 DcwYBU2o8VlwtWxSIeOEa2pskafgdcCsTf1cAcvjhAJiTZbK0H+n/KXUspcu8sfm6KiJoV4vrg=
 =
X-Google-Smtp-Source: AGHT+IGUs+SyuBTefjpABJfUwg6uOHdU1q91eGY6TxI8fs+hi7/0wqrz6gVeXhB6IgoN0g2JRyeqbA==
X-Received: by 2002:a05:600c:3544:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-4511ec9eb53mr110067645e9.11.1748955301145; 
 Tue, 03 Jun 2025 05:55:01 -0700 (PDT)
Received: from localhost.localdomain ([213.196.101.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c94dsm18407052f8f.37.2025.06.03.05.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 05:55:00 -0700 (PDT)
From: Vladimir Lukianov <1844144@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vladimir Lukianov <1844144@gmail.com>
Subject: [PATCH] record/replay: fix race condition on
 test_aarch64_reverse_debug
Date: Tue,  3 Jun 2025 14:54:59 +0200
Message-Id: <20250603125459.17688-1-1844144@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=1844144@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Jun 2025 09:25:17 -0400
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

Ensures EVENT_INSTRUCTION written to replay.bin before EVENT_SHUTDOWN_HOST_QMP

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2921
Signed-off-by: Vladimir Lukianov <1844144@gmail.com>
---
During the record pass, test_reverse_debug writes a sequence of
instructions to replay.bin. Presumably due to a race condition or
host's async implementation details, the resulting file looks like:

...
12: EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data  
13: EVENT_INSTRUCTION(0) + 59 -> 44298  
14: EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data  
15: EVENT_SHUTDOWN_HOST_QMP_QUIT(12)  
16: EVENT_INSTRUCTION(0) + 5587988 -> 5632286  
17: EVENT_SHUTDOWN_HOST_SIGNAL(14)  
18: EVENT_END(39)  
Reached 162 of 162 bytes

Here, SHUTDOWN_HOST_QMP_QUIT is written before the last instruction
event. During the replay pass, QUIT is executed before the last
instruction, which causes the VM to shut down. As a result, the QMP
and GDB connections are broken, and the test cannot execute its final
steps.

Adding replay_save_instructions ensures EVENT_INSTRUCTION is written
before EVENT_SHUTDOWN_HOST_QMP_QUIT.

Tested on my arm64. This does not fix the bug on x86_64. The x86_64
case seems similar, but slightly different.

 replay/replay.c                                | 2 ++
 tests/functional/test_aarch64_reverse_debug.py | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/replay/replay.c b/replay/replay.c
index a3e24c96..b2121788 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -263,6 +263,8 @@ bool replay_has_interrupt(void)
 
 void replay_shutdown_request(ShutdownCause cause)
 {
+    replay_save_instructions();
+
     if (replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
         replay_put_event(EVENT_SHUTDOWN + cause);
diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/test_aarch64_reverse_debug.py
index 58d45328..0ac1ccb0 100755
--- a/tests/functional/test_aarch64_reverse_debug.py
+++ b/tests/functional/test_aarch64_reverse_debug.py
@@ -26,7 +26,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
         '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
 
-    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2921")
     def test_aarch64_virt(self):
         self.set_machine('virt')
         self.cpu = 'cortex-a53'
-- 
2.34.1


