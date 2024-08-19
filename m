Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C31C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBDq-0000IU-CC; Mon, 19 Aug 2024 18:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDn-0000Ap-KP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDl-0000fx-RB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42819654737so37531655e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107888; x=1724712688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXvH5zTUg5dAcDnGKaZdfrZjdGQ55VlC72RabvGbTBU=;
 b=hYkphleQqaKitRHcdH+7hxl3x/XQytVH/Rb2tNWoGAOi/8KG00EsW/V0EUtiWdHZX0
 j2pQjCuriAxQgLm8sKcBqT8cBq7zLdRpfPjM1mV577UPd62P6Ur7hY4jmfKqV8lxwQz0
 etktUwGf/nD3RFDsB3+xBLhK6a3XHssXMNWKfdQtyc+S/SuqggvkUWYQ5JZV5j8yh9Tm
 gGh599hO21enp22FvcYvcE/mVLD0D49JuInP2OZnLXehoI5I+SCcELhGVd6qq/RNgPvJ
 eWGJbNee2L5HL4LOWtXJJUkQAHJ9MSAOJSroPChx6Vqyd45/DkcPyMaxFJ+PliRuWq7W
 Ni8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107888; x=1724712688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXvH5zTUg5dAcDnGKaZdfrZjdGQ55VlC72RabvGbTBU=;
 b=aaEGWqq5X9pszdtnGW4fRFQ85+uQ8zno4zJfNH2oIIbKGslJVpH9WRDiG7xkbfvOc4
 PpHkApaVWfaNqNc+kwfMMuNcUbISy9wqYXxl3Fzv66iTm6nq7S8LqV4JkHkF/6RC7Dka
 VkhIHV0PN/FfjLPKasb0awjiQHw5Mlajr+VGIvJGh3yZXFCWM4qbm9Z18UG5XtLqDMUX
 qT2w4qTFzzDsEVIEN19qkI4pZKiM6yII4vWV/GPxzUN1pO+0WiQz1l5fwyzjh/pKruaR
 OjqyvGOxPt0OOZPwIoULH49rD8aLTYOyJypcy2Uw1C/xzBMqd733nLy6yCqktmwT72tS
 WfQw==
X-Gm-Message-State: AOJu0YwrOPYaE7Nkb7OsD9VAOd2ci9YR+46I+C++75ONtUEP1tlyI7Og
 pw308env7iGZ2+PWmHqWB3wm4MQ2OsFIFErQFMUpfF6bbDxMhGjOXJhxdEMMfGxinGygZ/gzmvC
 fLU4=
X-Google-Smtp-Source: AGHT+IGGNiGIQkR1rIQ7wD85FGuvaB3dypQJelSJ6WeeYiMj902uQCAF5TN1Q1bDLoMJpIbTLndSWg==
X-Received: by 2002:a05:600c:5494:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-429ed7b8c11mr75319395e9.19.1724107887915; 
 Mon, 19 Aug 2024 15:51:27 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded17cb3sm175578825e9.10.2024.08.19.15.51.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/20] hw/mips/loongson3_virt: Fix condition of IPI IOCSR
 connection
Date: Tue, 20 Aug 2024 00:50:58 +0200
Message-ID: <20240819225116.17928-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

>>>     CID 1547264:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "ipi" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.

Resolves: Coverity CID 1547264
Link: https://lore.kernel.org/qemu-devel/752417ad-ab72-4fed-8d1f-af41f15bc225@app.fastmail.com/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240621-loongson3-ipi-follow-v2-2-848eafcbb67e@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 27a85e3614..2067b4fecb 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -574,7 +574,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
 
-        if (ipi) {
+        if (!kvm_enabled()) {
             hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
             base += core * 0x100;
             qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
-- 
2.45.2


