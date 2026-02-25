Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FEBFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO6S-0006Lv-I6; Wed, 25 Feb 2026 18:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6P-00064t-Ej
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6M-0002nF-UQ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-480706554beso3662205e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061329; x=1772666129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kX0Uvz1Dx40n3H3Asawwjw5H6+gWbvG6un6Zwo2v/I0=;
 b=UaJNSpn49ilqQ71VbvryAZluGt4PKEjAAyF+YaeQI5QNE8TBEDl83D+LEH+Qfz5gL+
 lza/s8SMU3/a3yFMCO695+QFfP1KaoHtqfH0DR5tCmV3JXjJADMD0MUFiQIQ0JUYxXAc
 XT9hYd7fuhqqcmeUzt5TjWpBCO2WKyJ2aVyFSP3xXvwFMY8p7/CtbXUsvKT4E+chMzuP
 oyboTjDI/trpRM6Wb7wh7uGTdzZdJdb4ATijtXDRdT+ZUd/yMCkQX5hi0GpfBHonm0R3
 nc8+AEuRarj9lzryaBedgnoi+TOJw7q2JaYmfg/XfgUE+A0FOu5wrSLW9bqfmFQi4am/
 P5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061329; x=1772666129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kX0Uvz1Dx40n3H3Asawwjw5H6+gWbvG6un6Zwo2v/I0=;
 b=jvziBufwVeO/af51tYJvFEgabr46EUMXFR67Ywzg/th8dqm/IWmH7nqBz6euCgArfo
 vkO3YLBeQY0MGPmuhMEtJAEmBF/j0prXn2gNDCukmVFOtg06oKp2SeRqmbBVg05yfsrU
 C4LwS7GK2N+cLUWpFhBPoTVShWuUfYmZ/AKd2OFHppiKPTS75hS340hqrnkrDL4opo0x
 0fOXBEVcImqjfqjJWK9okt+MiEJRuZA+LvTkMrkIkj/bbT2IBevbNTDERnKH+VM+lTLQ
 AZZuCkxopLHguFhKfITn73d0RBaL0+PLqyDaod4mWJi2JxKprDmUJZc0x4wjSn51kMNe
 CilQ==
X-Gm-Message-State: AOJu0YxZTSf7+VWXj8MfRzy8gb3P0pJS0e7EAcP/RzhLM/A4kuoApQgs
 PKokXqi1Vx0gAbbamL/AHn0lH1WIJKjpRBFaz+pq7k/B3Qszgw2wKV2/h55g0SPifLyzuQCax1M
 jkISsGj0=
X-Gm-Gg: ATEYQzxg4vCce4i/93F1YJUbH7T3xnLnPwPpC4CcE9ztpqqRLfWZqCuZi2TdW5GzHT+
 FRCXN4wPEaptbJUq5xKgMYMfHaBz/4i4fp7zgTOh1+U83SGesuTJCCtTpRawbqBoGubhc8w1SYP
 R1F+51Fzg/jcMQ8Wi9qulMz6glfz+L51hd0uo0ABykGG7AeTZAbOnT07w5WqWPBW6/CfuvVhsZ0
 heEu/Hh71P/kmSY76yUun49wN4K3hAyFYOQ0ZMd4Y9G6Tt9gIHK3tOWReW/RKow/oELYcAseqff
 XaA+5xsICOS/XwhTdDdh4VDDcRoSXwJkRjphJ4MiNWD1Vk2U+b1hQm8ULzEQ8A+QDk1oFCuib03
 RdmK0xccnNtpu5RE0NqRmxCX7GkRG+3fMyLRfMQRhmLcmhSph6TEFXcYiIi803c6JIuvKXlQCOi
 W/sr5Wh3b+iupXyhMOz3lSSGZ1ta+Ykfgixab/07nDxIYHDnhPUGfEhgl9/zDx16c7ZvUdLJiP
X-Received: by 2002:a05:600c:37ca:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-483c216ab34mr35057475e9.5.1772061328936; 
 Wed, 25 Feb 2026 15:15:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf789sm20667015e9.17.2026.02.25.15.15.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/70] target/avr: Fix typo in gdb-xml feature name
Date: Thu, 26 Feb 2026 00:13:11 +0100
Message-ID: <20260225231411.96482-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

While GDB doesn't provide an official XML for the gdbstub
protocol, it is still better to name it 'avr' instead of 'riscv'.

Fixes: 12b35405476 ("target/avr: CPU class: Add GDB support")
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-5-philmd@linaro.org>
---
 gdb-xml/avr-cpu.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
index c4747f5b40e..926cf053210 100644
--- a/gdb-xml/avr-cpu.xml
+++ b/gdb-xml/avr-cpu.xml
@@ -10,7 +10,7 @@
      register descriptions.  -->
 
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.riscv.cpu">
+<feature name="org.gnu.gdb.avr.cpu">
   <reg name="r0" bitsize="8" type="int" regnum="0"/>
   <reg name="r1" bitsize="8" type="int"/>
   <reg name="r2" bitsize="8" type="int"/>
-- 
2.52.0


