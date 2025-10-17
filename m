Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA862CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jlt-0000K0-Th; Fri, 17 Oct 2025 08:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9jlo-0000FD-DJ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:41:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9jlj-0000ez-9q
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:41:18 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso1771375f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760704867; x=1761309667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K/ljs6OJp0vPBaOQuK7n9Nteu1T26Le5xczWwSTwss8=;
 b=uu5E0WtguEleQBTvK7XP2RFEqIfoLQs1tlxfNaR8fXcN3W6AanE1qv2wyDAgXAxxKJ
 lpPs+GWC3p1JRvVRLmPdLfeScQxAQ+GNuPFLlkFUsHvEyVIGTzF8A7rNCa5MwHQGZic9
 ZqtvtbenEcrvwicLRk2LXs/QUAtg408IBCjC6ZeFhfc0rsjYwZaJw1DPS5yemhlbFz+T
 hWib4wzFmF64DqVLVB3scF3bSx+QP3TVjP+6r3EMoqwVFT8VEBBBpjfsuJOFsTEldfe3
 9yAe78Nw487lvGIjO6jL2JNFx/q+wAmqSsNW9DLXc6pWSLt3iBSTV0xZHyiadTDK5Vbt
 9yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760704867; x=1761309667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/ljs6OJp0vPBaOQuK7n9Nteu1T26Le5xczWwSTwss8=;
 b=IwDXzpQxlIaNRHOcFfqfbZhgAufX2UjKI0P+474GktujGthcGwQ/DYuE759fFBRxx/
 aRkTKohavb7irq8qUKiisYIhPYMOeR3bPCTLrwSJ84Elb8Uw5v51YgzbqkhP4ZhFZvmw
 krtU04IvqlMGklEs861rbtwaBiKNAq5L55htC1AJrpHIinARhC5V9zRKv/P7u3URMUV9
 YZzknOSbcCDsZw7Y3H3GvE0EcQDfkJ3B+fAsfDG8VFyJLl+QFElU+6NCLX9kMAl6v2Fv
 xuYi6PmTZlY+KSC33bxBml3uhbn5ayzQsSm4Bsq5Wbb//SGJGUORto+ubhdpIlPtoqsW
 VIsA==
X-Gm-Message-State: AOJu0YxFvch6N5wHM05JJe7WtNLSi7i4mmAK/PckSdmEd9xhNgVOAJod
 +51mo6pe14OMuuIpNFLQwWUy5kL3boyJBptk7PyRIlVSmLhyoFYePlxd3ycwa52Dm10hoQvub6G
 cO94RmmA=
X-Gm-Gg: ASbGnctoQcorBuiDt1y38fHih4ONAApFPm4DOLkt4d90dFv36kpgv5h4iuxM9OzZuF0
 O5iJIig5JZy23lYj3ieiifFaOhpauVHOuhoUbsvDOWRPsUhZOCHiX9otJeCCJQvCnc477q/Or7n
 PT1fmiiiO0u9S42dKbV8NFYYhCQw0fOK+vBS+1yWwev7PM7lbOQwE2rVZCtvpbzNvcdPmQMvakd
 Onk/4Q+CSEMh/gTdbI5dYv1HlPbX5yuF7d9OYlUYu91x9gG+o9BSF9MUGlwnLHW4P2a0tcYPM6m
 b1zK6JfC0wQxefg8wF/D5aLmXAEkavr5fkdszAd5j6LZkzR8WTVoBq23FQ9HaFebwmfSybcmCPq
 QQsTkprZq98WiEOSs4HSN1KCIBia8dCKxp1BDDSv6t6lTCD+GjeXpwpQeV0F2LGcN0fApOKp5S2
 6FPQ/LjorVSRQgrH39LpYYK7MqUy2TZG77VSNcEqA/XF6E+DsHW8eUXKb7q0AG
X-Google-Smtp-Source: AGHT+IG2QlfOwXEqDKG9vDXVM4zvXvrTHl7hQhtcKWvM8YpFoWT9DMrZcDNe6knXQGFfx5D9YGJcqA==
X-Received: by 2002:a05:6000:3101:b0:425:7590:6a1f with SMTP id
 ffacd0b85a97d-42704dc9b9bmr2819012f8f.49.1760704867244; 
 Fri, 17 Oct 2025 05:41:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c29sm82387355e9.12.2025.10.17.05.41.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 05:41:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/m68k: Remove deprecated virt-6.0 to virt-7.2 machines
Date: Fri, 17 Oct 2025 14:41:04 +0200
Message-ID: <20251017124104.56199-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The following machines:

  - virt-6.0
  - virt-6.1
  - virt-6.2
  - virt-7.0
  - virt-7.1
  - virt-7.2

have been supported for a period of more than 6 years. According
to our versioned machine support policy (see commit ce80c4fa6ff
"docs: document special exception for machine type deprecation &
removal"), they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/virt.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 98cfe43c73a..1874499f43e 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -427,45 +427,3 @@ static void virt_machine_8_0_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_8_0, hw_compat_8_0_len);
 }
 DEFINE_VIRT_MACHINE(8, 0)
-
-static void virt_machine_7_2_options(MachineClass *mc)
-{
-    virt_machine_8_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
-}
-DEFINE_VIRT_MACHINE(7, 2)
-
-static void virt_machine_7_1_options(MachineClass *mc)
-{
-    virt_machine_7_2_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_1, hw_compat_7_1_len);
-}
-DEFINE_VIRT_MACHINE(7, 1)
-
-static void virt_machine_7_0_options(MachineClass *mc)
-{
-    virt_machine_7_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
-}
-DEFINE_VIRT_MACHINE(7, 0)
-
-static void virt_machine_6_2_options(MachineClass *mc)
-{
-    virt_machine_7_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_6_2, hw_compat_6_2_len);
-}
-DEFINE_VIRT_MACHINE(6, 2)
-
-static void virt_machine_6_1_options(MachineClass *mc)
-{
-    virt_machine_6_2_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_6_1, hw_compat_6_1_len);
-}
-DEFINE_VIRT_MACHINE(6, 1)
-
-static void virt_machine_6_0_options(MachineClass *mc)
-{
-    virt_machine_6_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
-}
-DEFINE_VIRT_MACHINE(6, 0)
-- 
2.51.0


