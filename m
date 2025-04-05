Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C380C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169T-0000Wv-9j; Sat, 05 Apr 2025 12:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169Q-0000W7-Sx
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169O-0005Du-Bc
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:43 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso2542097f8f.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869620; x=1744474420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3DRTmhLmbjPLSrOpbcOACaj65qViLoVjxZHvJ/pQ1o=;
 b=ZYgR3DscDAnsKPUrWLdA7NNLkq8BY4ac8sJht+SjsMBlv1B6Bzvp31RVZBcILTuCjC
 rRbSU2tm3gQLZP/iiPbfjOfjfxJQCaLSPH/8aJobFZgB6ti66YGSfRPzKkrPn2bHEALq
 YrdeJS33e0ifv1qUYl3GaFEwNYRuiHDcpUaAPyk0+wcK8qAhnV/gg4HJ2k3SHZGAKyvx
 cG9nhOAluEukkMRxe0y3IzcibrLx28nvOJHzxif5/j03HLFS0mYOSrgzve+CxYjftLWy
 5wcakQNjTfrb9pnWoQU0F07krSkVnas7dXYy+7iH8avzOM2YnMYJYuje2BWXmxaRfNnD
 3QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869620; x=1744474420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3DRTmhLmbjPLSrOpbcOACaj65qViLoVjxZHvJ/pQ1o=;
 b=VV5vy9TOiKYYRwL2RmIL+bus8//iuSmy1jMmcFvbLUbn/2MIxSI/+MpmYh8nqHE3TG
 /uHuWLJdJYpM0ieY4AFs+tqcjgw99gnzcOG5GK7Q/I7fKCYo4E3nw2gHJeejne0gfXns
 kmil/Owd5ru40zhcWe+wYDohhtpNOJ9Gq1Q/fD1CTa3RAkUSvUpxOGdsxDv3gcJO54sJ
 K5ns1nJ1ExpDWOLCQeeBmTiZmQtz44kphf+9DQJG+E5wbWgZIVjqg5oiIU9LpJK6H4Sy
 Q6lhe2ver/awJiPP2RWACwdNkRrV65YZlp+NY0BZG/OnakY2I/NRvOYF3OUQ0JvHFopH
 5yxw==
X-Gm-Message-State: AOJu0YwNBVrtxg4cpZ/33XjxH4Aklg1di+BwyspIZIZmF3cmNCNTEqC9
 Ui23o3noqVxBFuIJ/eHaxNvt7e3/Lb1JTpg+xs8mPRHkeucphwyk08ioCe7UmJimJa1mO/ru9Dm
 W
X-Gm-Gg: ASbGnctcHK1u8YUBT0cq2D1RfQd8AKukbNGCNT8lzIcaEvJXE0TqNh9gzVoudJJP3zc
 gxknQg/VVOdG0aVFiv061tNFfQ8O+l7XHRvdEOHL/DqgBh7xBBalHq6W4iQkQBCFfKJxLnRu+TU
 t9eEp0jQPNqss0QAAX0x4gyyhg05F1rFPyVn3zh2mQH1p8cBKKOAFwdysjc0sQkNd5nShzVkRyC
 YuHMLmgo2G+wua7mnv9qOqug8WjQdn7ibJcBMndPpru0Yui7BSvRatDfOvzb2YYiYe+4TT5DPcj
 xux2zhgwYWXRiFUAFvgA7iH3w8sr5w8PDTBQf/It0vYtajbUzc1uegRja1rj+oRRTd0Tnrzhx7Y
 vvJHAH2JP7huocUxYYuqvYyihT6/YovzArWk=
X-Google-Smtp-Source: AGHT+IEVu31Zny/nOAU/Mka+yPjn0AjUXhzZse5LVpkGkTEhO+SjmKfSQI2UWZB8T2hTA8UHNNaqMg==
X-Received: by 2002:a5d:6d8f:0:b0:39c:e0e:b7ea with SMTP id
 ffacd0b85a97d-39cba942a90mr5797848f8f.20.1743869620601; 
 Sat, 05 Apr 2025 09:13:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3009644dsm7164710f8f.6.2025.04.05.09.13.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:13:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 04/16] target/hexagon: Add memory order definition
Date: Sat,  5 Apr 2025 18:13:08 +0200
Message-ID: <20250405161320.76854-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-ID: <20250404025203.335025-7-brian.cain@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/cpu-param.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 635d509e743..22bffa78816 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -25,4 +25,9 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/*
+ * Hexagon processors have a strong memory model.
+ */
+#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL)
+
 #endif
-- 
2.47.1


