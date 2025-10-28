Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5E9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoHm-0002I3-Bc; Tue, 28 Oct 2025 14:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoH7-0001Xg-8K
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:18:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoGx-0002Eg-0l
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:18:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4770e7062b5so22028225e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675494; x=1762280294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01hqDrORZqT6m82C01ACWFcfM3wBkQW5SH2Nidv/XUc=;
 b=RlaLx+tSY+hUqtRkv0QBR+kj18iFR0oQwiDaIcpvqhbALvf1QNldhOUZchhfDJ9fYt
 vaJLMKOXc2HE5nEMIn5s0yUbQlp2h6G77348/3JSSWddUK72pMTU8cRU5AfYpkliAL0u
 /9Xp+MKzGgbEqt147Adgw/AuP4MFbbwS9Ioy+E0SglbSAUhCK2J5ugVBgLhCBRcJMMTH
 PA4NqPmrcu0gbUEWw/z9mM2FoygWvtk1JUwP9CIvDQ3JGGtheNX84ctD3fcw/97XMaLf
 aykIJjCpZF1pg9tEzDbKZRJk31Eahu1AjB8B1wFwdnIwo8cLqahYIUeU4svH4TzxOwvb
 6eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675494; x=1762280294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01hqDrORZqT6m82C01ACWFcfM3wBkQW5SH2Nidv/XUc=;
 b=YMvCGWOhfDYBIOhUqVIz3ak0KaX+tMEBU/zoL3JfphsR6lCSyeJkj5pfwqWOEdRYmA
 NPcsxT2PzCFvTHT6No0fLuYoi3uFfoWr617d9GHZKVvukcvM4z5Ab1x3MF3xDkVtWHyM
 I8Sc21y/9T79ac14RHAEotFTIvqyeNeZbBN9C5wpvjcwklCldPtJVekpTQLVumvMVpqo
 FYalf1zI8VdNV/tTUL3WeSeV1G2HsRD+VrY6CHQY87QRItLNgqjAcMXci+0Pifhowcjx
 nVzmYUiSg2714hcSz5gA8qhUJPomuL5C4TpCqDQS9otMjtCElI87kJCMtyYIAiksmy4B
 eGQw==
X-Gm-Message-State: AOJu0YydCvY0Wt0z7C7HKGPdfl+7vP+A2m8z3TtcDupnc6HEc+iEF9EV
 TfaBV6+b91PrmvTPrhEJ0gGSkbTaUBjc7F1csZpmkPhgXTCck53AxhgRQMEdWrO6i+n6f863owc
 ILVoNUAs=
X-Gm-Gg: ASbGnctO0Cpr6/Actm1Ajh1ZANWl4xPw694yNneFPuJw3cWlEKtat7nsXq0VmDNdNL9
 fCTY1wq3aiNZ5KN+lyJesV4bZOzaHQYqGH+T6nXV9Zefu8JyRCo9PJg+8mbLBPT7kWaytKeXTQj
 C+JAAPeAtSTNraWEBIqeG0ZXsC6k3E1+WTqcf9QHTUMOZekwgBxOKV6Q0pZcQKxboTHQ3Of980g
 pXIS8NkGRjgJxk2Ngh46FY1awsye5C+Pf9m9GSZWzSULvmRy/s5yFdJsBwivJACpsewRLhsiXeY
 VNc6u4nX0OiK7QXITdGKU1ffV9qZKswn2DLcndavnp5E86+gDKD/+0nsy69tHHKzh3H5iwy+0fi
 CV6c10GzOoW/RhKXwwNSbUbLXXE0C5xarKSPt1d2qHD70WDQ38ZptVxoj4MgxYF1Z9hBrt91zkV
 2jmE9Ig5OVED/J4xCHZkiIwzMf0KCJX/B5C8qkVFQTxcPN5NdQUA==
X-Google-Smtp-Source: AGHT+IGiptqj6/iCv9W/NsMN2YruISusc2YzRGdBP1Bs0Mn8UNzSF4baihJ10riNMKzZLg8Yf/0Y1w==
X-Received: by 2002:a05:600c:6218:b0:475:dd53:6c06 with SMTP id
 5b1f17b1804b1-4771e20a66cmr3592985e9.40.1761675494104; 
 Tue, 28 Oct 2025 11:18:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718fd69fdsm25186225e9.3.2025.10.28.11.18.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:18:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 05/25] hw/ppc/e500: Use proper SysBus accessors
Date: Tue, 28 Oct 2025 19:12:39 +0100
Message-ID: <20251028181300.41475-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

SysBusDevice::mmio[] is private data of SysBusDevice, use
sysbus_mmio_get_region() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 8842f7f6b88..fe1aeffe676 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -887,7 +887,7 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
 
     s = SYS_BUS_DEVICE(dev);
     memory_region_add_subregion(ccsr, MPC8544_MPIC_REGS_OFFSET,
-                                s->mmio[0].memory);
+                                sysbus_mmio_get_region(s, 0));
 
     return dev;
 }
-- 
2.51.0


