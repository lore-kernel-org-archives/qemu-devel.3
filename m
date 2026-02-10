Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F835EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAC-00022n-Ug; Tue, 10 Feb 2026 08:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAB-00021P-IK
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:23 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA7-0006LO-9D
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:20 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso8901635e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731538; x=1771336338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Ci/Q1rJoWTvVFAzHOC9y2xpF4wfP74ZNNXf6tgbFQ0=;
 b=vIT+Lcn/NbqHQCRQgX9nfk5QYimwPO8eS/dcHqzVPGVJ/nwD/rQ0WrhE4hHWENH61g
 Kf15cR0vK7W+VPPwc3a3N77FkVT+h1WI+R2gVX3QR5bidycLBjgeNpyJeLB+m8xBUNNb
 /A5ONy4S/wo14sSn6D1588QnyJxgNsULbrXQbzwSm6QdEmcJ4o4mG608xl1qNZd7ZYFa
 FQN+pEBGHWZdzVfWGiZhPrMb2r91K+bw5QeGDTQ/2ClHKY8h/TesYK/rIRO1tyzrKK7B
 qw8iySntgmZHbgdqOXGkXDkQDlLI/7ul9MQ4tnSdaeFaKqp3/jst4JiTpC9qYlTZ58Jh
 OBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731538; x=1771336338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4Ci/Q1rJoWTvVFAzHOC9y2xpF4wfP74ZNNXf6tgbFQ0=;
 b=TOadXPn5Apz880WIwrnXB3THRS+U7bpm/Q23K0+eEr+5X74dsoLWCnBciv218nofZC
 4aTGnrR0o/mQINp3qSQK6gfqDj+tRBMLY0Kno6v0I0u5gRl9oJJA6P2HIMtkFReXCw2G
 DQaWE2sL7Qymcg4B8Yuojxlxd2Milhafc7vrYaj1wNVAxmoYyfclPmMHTVq866sbK9yh
 t0Y1M8wJ0q0EYivsCDgXE+h/remHLnMi6XjbAPIatBWYGC3OG85dNTSFDmOJ2lhnv/Vx
 hx4+51Nrzb+9xw815aOpvl+mHZ+mHESUhUZkppKXWJTS80CeeUYvfbNxlkC3zCuJkLLt
 5uzw==
X-Gm-Message-State: AOJu0Ywf03O63oEWT4D+oSJJ7KbrkmUp+NyShriIviT5bPXTMOuPswpB
 W417YceobmwBw8P55pHbOKJNIPaE9GF2LJ2r0EduYGr8O+g/i5t+KDi3dPceUVTXo3GUg0GygXZ
 Z5jXJ
X-Gm-Gg: AZuq6aKmReYrmdwb4LD4Rh6DIU+N3VzGh22N308yaYq2ZYg+T4+McGlZIkou1fQ7jtU
 P7Zzei7yZaQ5EGv7xbC8NHoG6Dexmjqmba4sta9MP3if0bn8LQ1OBr+IB9HgJc3Rks7SeTYNq8I
 a+bk7xS1qd/94lwHGR1tKmKRsWfhVbEMPVWYxXHXXSIcXNoqzfcGwptuUU+rRU5IEm9x+V0ZYTj
 nZrsKdXqRjQPnx2NdU/QRGTJz4Mp3uWQLO8WJXKe/e4/CddArjy7JOhPCYUju8WveI+IBKGxLqe
 y0YkhcEqRNdYTVO6hw2e00jaD8hUhjK2+0ZST2WUhcmG2yFSerOF+sVWumnqOnqbeUoME7/dm1B
 PnBp19DN+sz3HSlonvpIpzta6JMczrx+aRH8C+rWdFad579q+c6Qudbxu5Fo86PhjOFwF39c68o
 B0Qpfmmu5GB4AjBNV4hecY7DrZOys2A5t7H4rKlTz0zWBfSxTEVyzSwq+yedyUjAr7EK4e6xgQ7
 Y962dfDAAKQcqJnNOE4X0IHlOFs4/rZ4zFbRXIWUg==
X-Received: by 2002:a05:600c:3b23:b0:47f:8c05:786b with SMTP id
 5b1f17b1804b1-4832021eae9mr212406485e9.28.1770731537716; 
 Tue, 10 Feb 2026 05:52:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/26] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Tue, 10 Feb 2026 13:51:52 +0000
Message-ID: <20260210135206.229528-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.43.0


