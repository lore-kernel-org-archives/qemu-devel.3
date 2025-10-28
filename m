Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EB9CCF9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd7r-0007r0-JK; Tue, 28 Oct 2025 02:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd7p-0007is-C5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:24:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd7i-0000bQ-2d
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:24:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so32781985e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632639; x=1762237439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9r9PbSxEc5vkW3NMHjI0QVQXtgDxRcrfGpveD6M8q14=;
 b=xViHHJuJmL4FiQDEtOC+NFAOzgtulS49F21wQq5CNP9tUbOmnH64QOsjWe5IJUoTR/
 cPww4maCperenJcN7CB6+ksKavq1E747re28lXDF3b4/PJK6m/XqjyGdtmJ/PKT0LlVM
 LsR83tdkVYX3ARu3Ua/Y1aj7iUX+gDY1eQLcO3BXFGoQU1s4szgSvD36Jvqs5corFN1+
 /yBF6t7v84HmgrR4OGKxBjl6oE3Hfoh0V2bie+oZ4uqvYrxNQ+oLhTw/6A00b/Mwg/bh
 bG8/UbOW+1ptkr+cUI4oMOk7hDEQX9RBnALmpUdyWZIa3sduUKaUB2z0IeXgYvcwEfbt
 RvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632639; x=1762237439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9r9PbSxEc5vkW3NMHjI0QVQXtgDxRcrfGpveD6M8q14=;
 b=izHdCFSoBXCq7jMWafDehLzYe56Tm4zLiRDSjQZbjj7xKgViC+/xKWfhZU4D/KumOv
 DtDejAzLO3QzvBpvYTg+VN2/k5q23oT44lyceUWgIQ4hhCpw4dxHRxkIgbq8dpmHM88y
 hMHBI+uU4TREwkin86Ryhz8UO1HtSomaWKDaTvxoErjsYHSvuZxysenhtabI4GtTv0mW
 IFaokCT0uFZUVapljg9A4ke203emCX8elWR0lpxVxJEKBG/rZo9PnVmLA/g/+PwjI1KL
 cY7B4cSyUjLwrpvZ6V/mSnwlW/j7q33HlCynfIsYc5KVvxFwS4DJzQwtEy1/903U0/98
 65SA==
X-Gm-Message-State: AOJu0Yx1VwKRdFKjbS50oasQO4TkufbjIE6YNzlE4u2kqUEfi0yCzx+k
 Bk6yWTD60IMRgO46yjS/dVuBSuG8ZKuiaCzUh9fetbMYRhrgYuOQW6Parc/L4pmooOnyLAEYOWD
 Q0S5Ib+0=
X-Gm-Gg: ASbGnct4cpa0Wmpz2jAo22iiuqdcIiEERLohjw/i4tNZ0aq/cm6VkpPkxUhAFwgyUrj
 3iYBFbeNBUCr0zK276nFDkQ+EI5oT5GNKaxLVlb9PIiNpDRPDr9Bbka+s4+MIwu67MgZ7hpZdgG
 R+vqA2py8JNdPrS88KuOgF99K89ciyrOZDzbk9VfLaS9zO8hYoyVsf+bpFYI5F2+d/4OVocryXV
 UEKNa4Y92Xd+nWcsdzGDdqAVlgbH7UpGQqBtf2898iYpLQR2L4OMwFerMjFU8YwD8mlFDyG/FkV
 NQAQkABE5pRzxb8O1EPKUzI7CTwrzIVpGInqb7aaFL5OhrZ7VvzCpzPpDr9/1tvUipucqYAWMLn
 Rlc6xI8oIDL97jwGhXwUQpHeRZdMnACmPL1bUQmZc6wNcF6iRCTuf1c3fcyykOgKtGxt0PoQzX2
 GAqkdLh2l0Gta6ajQlIY3/hA8yJ2MlfbKa+WjQk8a1GFrfdr7i3gEKv2M=
X-Google-Smtp-Source: AGHT+IHVpoikpIYvHguAxwl+ojwpfr84RrZQqfwvBbRZQ/v9FUNcKjrLABeFbnw+hXNPR4eozlW99A==
X-Received: by 2002:a05:600c:540d:b0:46f:b42e:e366 with SMTP id
 5b1f17b1804b1-47717e6ae77mr18617665e9.40.1761632639025; 
 Mon, 27 Oct 2025 23:23:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd478202sm175898915e9.14.2025.10.27.23.23.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:23:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 58/59] target/arm/hvf: Emulate Monitor Debug registers
Date: Tue, 28 Oct 2025 06:42:34 +0100
Message-ID: <20251028054238.14949-59-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TODO: audit it is safe
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 639eef3b800..113f1415011 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1616,6 +1616,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         }
         break;
     case SYSREG_MDSCR_EL1:
+        if (hvf_sysreg_write_cp(cpu, "Monitor Debug", reg, val)) {
+            return 0;
+        }
         env->cp15.mdscr_el1 = val;
         return 0;
     case SYSREG_DBGBVR0_EL1:
-- 
2.51.0


