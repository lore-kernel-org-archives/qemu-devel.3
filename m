Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A6AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgu5-0006Du-KK; Tue, 15 Jul 2025 10:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDQ-0008T2-VX
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDL-00049O-3w
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45611a6a706so13588975e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588057; x=1753192857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcz9AsWsu5uZbgezgrC0y0pgPUlNjrUnxw6GAWvAVEg=;
 b=oscW/Nfh/6Jj6QL0c91FkheR0z9dQxHjrIxp0VXUJiEbBmgXb0VQp1Aduc65c3m+Hm
 a5/d5kzZBzYJh+nxgb1IAR43AQNV1N75FQNr8kahyQB3I/snm6JtuJBEC6E4fjmw157B
 IPBcQXy/Tf+dDg4l21ARUnccDXcr7l2bHX3hLx8hgMdA6VBaub+txiaeWErDudvnYtT/
 OrIh++cDY3zf4i86pDCgrj/psrBq4X4aQAyoy3cnriPdAdKQn4xqJBXefU+eSUpruRsN
 OqDgei1anJ7Rximl0iTyhF0CBkc5HEICHSd+Y1uEECBgBqfIvaTMEZsU3O6Dd2N93ikV
 mNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588057; x=1753192857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcz9AsWsu5uZbgezgrC0y0pgPUlNjrUnxw6GAWvAVEg=;
 b=H7Yy5Sqjo0O0fJR/eDMJM60iqK4Ra9IBSafb/2kSoVhKK4YH2autzgtV+bl0JhQ3Zg
 V/qxlx3Uru/71PKOWHtlmkdYF4UEjWMa9udOYoPYqEGxUK07EvI+UlYuZOdZeUm5ZM12
 MvQGVWuheqBAzP4lT2idA0+s/0ut6YBNz9PGTNGACbQqckuKbAHlCCH4Ms2Hf9DsHnyt
 fhBjYPEx+Jg3cRMjpBfoPooqMYSfyCNEN6Rih2MRfFSscLC8slpHz+rO7TJm3zv6kVbO
 quxpnmeku5uIdp91Ath8c8qDR9RlcSiUFbE1g+Nm25JEGt0awI5hqj8uT2L6zmWBjGLL
 FJMw==
X-Gm-Message-State: AOJu0YxrWnIB1CPzj/ayK7MTOn/FNHIxT3Qg2yziLDlRCDfVgmVfijY7
 k7x2oVoj2yIXRwqun5AGVWpnHjD2HFIHGixMatxGEg9ZN45a1OTlbOL4aAffuzcNiCB2FiP+T67
 +UVts
X-Gm-Gg: ASbGncsqYBZ+UPuTFnNtUgFDSybNxM3kUrD53k0K3tNNMIUy91+lcJt1NrdfdMPQ3l2
 5EZPehOFPfmIlVSEddtHJWCAfYHTqHMGr20FfEniFsPBJ6GxJruUrDJwER9dZ7u0UJwYkKvx0Gd
 zOS3ZgCYQ1d+c+wL9B+7/9h0g//eYdpE7qlTet2f7X8cclwkg8ox6Xv5C5/qzVdWOdKYmksTFty
 mahmSmZ6iMjLXqQ76/detZk78o+yAc5Yv1KDjdoxQKQMLVdZ4hDBP+e68U75bXwcKtN4hv3x4LB
 IaMDU/QkEXj5oW5r9urvazk+SYS9BHFIBLveW+/b5SrUKx4M0oYKbIUyWxHrlEgwAAHY5Hj/UoR
 aImJTyq81LrWNV6nYtE+WRPejwWaCaXr5Pyrej5vI8Fx4urUpKdf9V9r6MgkobZXme3wR6T90Xi
 /wvQ==
X-Google-Smtp-Source: AGHT+IGKTCdxSYA3t/b0WXjgOjGQ2opWhG+GU0bh/3I/XprYGF4r60bW2xqV+GipcFo668yTsofeJw==
X-Received: by 2002:a05:6000:4022:b0:3b6:938:86b7 with SMTP id
 ffacd0b85a97d-3b6093886bbmr3764283f8f.35.1752588056630; 
 Tue, 15 Jul 2025 07:00:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26f22sm15452716f8f.94.2025.07.15.07.00.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 07:00:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-10.1 v6 1/8] Revert "accel/tcg: Unregister the RCU before
 exiting RR thread"
Date: Tue, 15 Jul 2025 16:00:41 +0200
Message-ID: <20250715140048.84942-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715140048.84942-1-philmd@linaro.org>
References: <20250715140048.84942-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

This reverts commit bc93332fe460211c2d2f4ff50e1a0e030c7b5159,
which was merged prematurely, re-introducing Coverity CID 1547782
(unreachable code).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index a578698d071..6eec5c9eee9 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -302,8 +302,6 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
-    rcu_unregister_thread();
-
     g_assert_not_reached();
 }
 
-- 
2.49.0


