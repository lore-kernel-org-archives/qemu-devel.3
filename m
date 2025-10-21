Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33281CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJZ-0005YZ-1f; Tue, 21 Oct 2025 16:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJR-00054T-90
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJP-0001YZ-9C
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-471bde1e8f8so14477055e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079828; x=1761684628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XmIazvnMcS62evWaxsTSFabokho2yYFz693QcRgJ7JQ=;
 b=B0nP/4oNgLLbSsyMveFlgJXdsE+jJjhbrDrQvZRJgjcbrRHrbDR8hiNhb7XviD2rGO
 JjX+r+E1NnOOfWEH9YdEPoij8J4mdXkBk4HIyWrINlNlCO3sWvyrPKh0TPb71nAc2T7h
 bHDA5143RtqT+PYLeZolPuzaBrAUk+U0zQble9alNJVog4kQZuY8pLB8W/rL0AHMNH5W
 pNnvBZpBdA4i26pRKBiwIC4zEuNCzDNqMzb9ChhV1huGVogbeoTa7Br8Jeeqj2Bxxumm
 oHFNoPx9puOopDS4nxYoJGMAzQ2NqTMhe47E+s2FADIGMLMjr8Y3a4S7DeDJI7vEhFe3
 NZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079828; x=1761684628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmIazvnMcS62evWaxsTSFabokho2yYFz693QcRgJ7JQ=;
 b=CvuYQy8RAwCBOSkxfS8HsOkhxOFgWzJf1VpoTl5ifW/IEkSPvfVvlHGBYx9O/1Q2z4
 AeBMZ/9ttbQSP6BfjUr+AkAGOyxLiwb2J2xFSLDumHY75zloUJpiztPYvH9bP9N8ANvV
 uRc49+aK19DOVnpzTFa45bIsL+pmRz++D9dJ2Xvsy/ANcVtkmcFXZCpKDgtU5a4L3kMW
 Dcm2kQt0VboKwcA6sq56Yytcb59Yu0IjfgizoTS9R+iBm8oaZUP2BKtcSPQ3ux7EWdoI
 gxE6JSvdEUvwKAhMYS2pSRzpQV2GaKWcvuYbwnSZFPs+C5Eny9SVNqN4YJyWhRKAZV7I
 RJ8g==
X-Gm-Message-State: AOJu0Yw8H+i9gLMnUiqWFuQAA342L19RBv8/EiqsZYBJFTtV/MAhYlrp
 XQdSn6d37RHHeGDOxYM2wLX9MedBwYn4h+4XB6k64GLIl+VL5oqPtX86/R7ftfhDmKoSNexfIU9
 1joH94Ww=
X-Gm-Gg: ASbGncuVdXRdaV8asLHYAOmdsr6r10Hc/e86NIJ8iVhaxMXJ1KCGgM16tM3ykzIg735
 JWlV47liwryHYABS5u+Z0fv9yGScQIzBa3JjSBeCamX7cSqcmH5Gc98RvZXDHlfPxEmdR1yIVXC
 39zR2y/8+qMkwbYxXwQN5izs0SYXeC3JqRXZgx6YcWrjTuqUVoI6JLqRkPsq7Xl0WJf3jtv/7cn
 xTUigUPC6ru45dEpiwXWeAvh/KR9ZQeQjgxrGYaYmqigDkfmZSukzyGuPAS+f5sjOTVwR2d+k4H
 XwKqQBO17h0h/svoj4JdieeUNnI2rXVQKASWQo2xu1O1skIS2UPpL6m07EDqrA7CiuehQ26s35L
 39980cdQN3sX4p/yEXXuU/gxjjPKYO84RIQKdFpPElkk75fw2PgtFEAs/Nfwov80QTHwdGVFAeP
 lIKLstw7glXgH0hDaLHdhmmZalb2CGnnf1zVfZZd0xxRDevpSIb3b1hadUUssFt3OERxtHodI=
X-Google-Smtp-Source: AGHT+IFD2zqidMb3YwCAOpr2QWjvLy+xm/westVdlBAQozpnhsbyCRWRM9DdfVYm+sSDkpgfJp/RZA==
X-Received: by 2002:a05:600c:4f89:b0:46e:3edc:2811 with SMTP id
 5b1f17b1804b1-4711787750dmr123687955e9.14.1761079827785; 
 Tue, 21 Oct 2025 13:50:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427ed3fsm11858105e9.1.2025.10.21.13.50.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:50:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/45] docs: update -soundhw -> -device list
Date: Tue, 21 Oct 2025 22:46:58 +0200
Message-ID: <20251021204700.56072-45-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

(note: I wonder if pcspk was really an option when -soundhw was
available, since it was not user-creatable)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20251021090317.425409-8-marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/qdev-device-use.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index c98c86d8280..043ae461140 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -324,8 +324,10 @@ Map from -soundhw sound card name to -device:
     gus         -device gus,iobase=IOADDR,irq=IRQ,dma=DMA,freq=F
     hda         -device intel-hda,msi=MSI -device hda-duplex
     sb16        -device sb16,iobase=IOADDR,irq=IRQ,dma=DMA,dma16=DMA16,version=V
-    adlib       not yet available with -device
-    pcspk       not yet available with -device
+    adlib       -device adlib,iobase=IOADDR,freq=F
+
+    pcspk       Not available with -device,
+                but audiodev can be set with -machine pcspk-audiodev=<name>
 
 For PCI devices, you can add bus=PCI-BUS,addr=DEVFN to control the PCI
 device address, as usual.
-- 
2.51.0


