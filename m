Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DE6C83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublsi-0007lI-Qb; Tue, 15 Jul 2025 16:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbt-0003V4-G4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbr-0002m8-ON
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso61067195e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608798; x=1753213598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nL2lXZw+q8MLc6/8xrYKH/mR5NWKLcZkaleiPZ9lfnQ=;
 b=xyEGcB3i7Gdpm+H6LXT9ARVlaecDZyL6mKhiggcq3R/rdWcAbWoe3skH2jHyUnZmmA
 ncr8q6wJlHsTQdiOZnB+/iFla9wUbgo2K0HK3YfpK6AE2oiCvBa85vFhUTkH7/RAEf/m
 0Pgbk1o7qnc4bk/3vF1Jkvpwen8NgOoYilIrqucRL59ylTGWhco5587sUhSSu4WBxIZ+
 pQyvwunEbvQ7VRDYZmOnp4TjuOuQc4sekp2bxs7N7+ucz7pRPxkaGQr8UJkBuo0t+b+k
 YLbUNVO/seVZdEpNR8hN3mHNXzBt1PeoK65jDen3jPR5erXU8081/7XjL1z4Nb899Rze
 kvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608798; x=1753213598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nL2lXZw+q8MLc6/8xrYKH/mR5NWKLcZkaleiPZ9lfnQ=;
 b=wrykgE7lZegEG/p+5YvpigCLj1x+qKJw7rthPhhFFx5gh6TWsetHOq5oAo77Lj5AX2
 EJOg9y4FgoxyxIXlcECuAect8h5wP8sQ7xaTfdQJSn7CbkfYXLSREDKYqjolHtWFeJyw
 JfN888VdofE7z80nyJmLiCDsVQEKVSYa743TQqWjVwUyHpEEU1jqW9L8HMsvhTfIr/YT
 9F99kQBgU+58glFVbPQLwre/0k3+/UnBHrxMvcEFqHm1ilshnJHuXRjbCGA+4CxKiTVo
 LkEaRQ+dmvACnP+uzVvivj+EFi9H7sV8Fs+qRl3Y4ypbdd/3NtuXCPeJTU8kmzcdZ6vg
 /RnQ==
X-Gm-Message-State: AOJu0YzEGTHzBsTmw02B0c3s2bwsjCCIJMHjaITk+03lo8A8O5uHtPXG
 s32nQkmc9Ay7LMOzWrH8RAwUokNjB19aoYDiO9cCJZy4CKDvRthJ4pc6hZGxPGfKYS13wKl21QV
 DUpZz
X-Gm-Gg: ASbGncu1+ASEeA/mm6cdw10TUlGb0QsHX4CBQPC6lL5rzcBOxuULvWKYkSUqNV0Acfs
 urpjcz9CeZS54uh7eCV5ay3CM6lhT2DwsUinGcDTgU6Y+KqicOhPiO/OpP+US3l4W5jnhF0DZmM
 IDiHxG9vA8ErwVwD00ypo16uv4q1tQ/WWf1Sl9Y0u9Nu/7tl6t1pSmeTKjB2RnpnxQvsvI3A+Kg
 +s0VIUtDaW+pQ9TdkbTz/2w1SLf2wjOHBU1Xv3VaAiuhotpy25UyCT2qtk5hy5boGYMBS/hS4EK
 sqG8KeNMnH6DhKRaw1KqNUau3WxLacc4q+T2jpJljtJlGtYzyH9EfHYM9ckiimfH7L1vuiDMbyl
 bSvfaJo1CUwKnUNJvgXsyqLPhFzBSoWcMsZn1+T8+0u50GQB6FnrRh9P3PLeGGtvRrylS5OMoMR
 JDQg==
X-Google-Smtp-Source: AGHT+IEcy8qqSFCGOyBdgUAzzlfNNPzfRZwJimXC08icgg9nbwvx73zCqxCGIC8IsO68iawmKXkPSQ==
X-Received: by 2002:a05:600c:4f91:b0:456:25e7:bed with SMTP id
 5b1f17b1804b1-4562e23b6a5mr1759945e9.14.1752608797778; 
 Tue, 15 Jul 2025 12:46:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-456030270f8sm113083725e9.22.2025.07.15.12.46.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] system/runstate: Document
 qemu_add_vm_change_state_handler()
Date: Tue, 15 Jul 2025 21:45:15 +0200
Message-ID: <20250715194516.91722-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-4-philmd@linaro.org>
---
 include/system/runstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index fdd5c4a5172..b6e8d6beab7 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -14,6 +14,16 @@ void runstate_replay_enable(void);
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
+/**
+ * qemu_add_vm_change_state_handler:
+ * @cb: the callback to invoke
+ * @opaque: user data passed to the callback
+ *
+ * Register a callback function that is invoked when the vm starts or stops
+ * running.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-- 
2.49.0


