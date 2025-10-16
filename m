Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B90CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvv-0001EY-VR; Thu, 16 Oct 2025 08:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvk-0000Mh-Dp
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvX-0008Mq-Cs
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so506926f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617061; x=1761221861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rZA1fWSYzUnWZQGD1H1+GmKfsAyRn/bLV4Ew+uYFMHI=;
 b=Ia2ZN1kQGKI90UPFZCXfTYjTjndxXL6U3WhWn5IQ8KdO5rCqDRQ8HqnpV86jyIGy/Y
 NmlvSZ7Bcr5Eynof+99YXzxX+EONmTaDDDzVOhS0ENSmJQ2IQCWIke5SOsybPffVCBLG
 gJ5GWz5pMITWewBqe8y9dT4CuLSRZKRLZ4ykbEfNwww9lKSMXPYFQE7cF2KHcUwG2ae7
 DEpb/Kid76QQXhMgP+wV/ptHtXj8iaYNy9Ht/ZcLrHiq1BmkAVm8yFy9B0sIN2Y0avQy
 8BE8XVCp/5IdgWYw5WJjEnvewlirPIbkkVxbA8xGxLYbCPAKqqwsQcEty/esUIqSTF7x
 XWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617061; x=1761221861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZA1fWSYzUnWZQGD1H1+GmKfsAyRn/bLV4Ew+uYFMHI=;
 b=AmM/B9hgrYN2I2GDiLJJ85uVwDXCGxZUMC3W4afh8bAHEbefvxD3RmGSjCIC3JlR55
 yU+KrrKi7d5EnF6tZb1ZCI6iC3iw2ngoHbh/ar8yHsRKY+2qW12OW9ZziLc1zxHHl9Eh
 pjwG9qyCvGvVxnHPD2uVilqcpP8XR/xta3CN0XfhHLe8JIvD8U6Hipc2+igZvhlK/wYx
 sX3nqTzTmUCc6+iARY6+NnR2SHwl+IWpLaCvR9iFNHnZpCk4pmbwIPIh0oqgoRjuOfzE
 0RuhT4JcFH+FDnTSBAmhvSvfHeois7L0VhDv+uRvVg+khZSHtohmoIEliqGLPi38j/jN
 zzBg==
X-Gm-Message-State: AOJu0Yzen97VnKZjwduuM+V78FXdfWEp8C4qolOgCupNpVnR2JDThhV7
 HQKMeDmUBD37SVVYRKral/oyTzatqSG+u23i+MlWLddIqsHRsdeOnerbLyWagHOpHHY7/XWkYDG
 rP9uJdz0=
X-Gm-Gg: ASbGncsrOfoTUGf2vrtpBJyPVyfnD11WRpaX3w2rksVeF+VmhZktLuerwNURc60Gnlf
 ybWc41JoVuzzqjuuh5Cr7bW5gsOHXOE77R1mkE6cE1Jt258xEtefoZvRzbptbnQuYoP+08vPKUP
 Y58UY1CgoEXxjnnsRHojOdP+SGiTOetLQ22hB8lOZBcJe8QGMnDPBWBqmjeegrLO99tePPOByoJ
 pOitqF/V75bVML9BDuqB358ZflIWJN3LJ1pRfh3tAlk9FGfAuitZLKZvB3ZwBB0ECpQBCzXkeTU
 2KHMmAhEfphrtOj9arDWVnk+MjOpwv59MrIe3M4PDBvQFqmVXlLr+wUu0qxqsNDbFMdPb013vhY
 iOPcZVw+Wi0s/D8Tw1lq6pxNmSog9j2pYUs2dAV3+q04KeL9ic/y6rgBw6TQWrWswa2ZK7kEVrj
 vp047dY8l41q7MOoL41zXy3pl3GsLSBxK2AvIbKXDeWN8I1K/cU2JfQsGOo9oayKQn
X-Google-Smtp-Source: AGHT+IEWMEiDj+9NLP0wsZ7ohuqSeThP2M2HEBHSp6XQZxPvJZeNyqTRhUn+1PbpZyE6v+PTHjoJiQ==
X-Received: by 2002:a05:6000:71e:b0:427:72:4c9 with SMTP id
 ffacd0b85a97d-42700720595mr1334387f8f.26.1760617060623; 
 Thu, 16 Oct 2025 05:17:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5833dcsm34119256f8f.19.2025.10.16.05.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/75] target/openrisc: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT32()
Date: Thu, 16 Oct 2025 14:14:43 +0200
Message-ID: <20251016121532.14042-28-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Both OpenRISCTLBEntry fields are of uint32_t type. Use the
appropriate VMSTATE_UINT32() macro.

There is no functional change (the migration stream is not
modified), because the OpenRISC targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-2-philmd@linaro.org>
---
 target/openrisc/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 081c706d02c..fa054e528bd 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -26,8 +26,8 @@ static const VMStateDescription vmstate_tlb_entry = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
-        VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(mr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(tr, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.51.0


