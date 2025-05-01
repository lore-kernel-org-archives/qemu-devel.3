Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E96C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcW5-0002ej-0T; Thu, 01 May 2025 18:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVw-0002OQ-Pq
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:36:21 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVv-00030p-5X
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:36:20 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d8e9f26b96so12001695ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138977; x=1746743777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8As/hKAjswxkqY1TECVvJ6P3zOc3craDH105h0De0I=;
 b=S86CeXL9+qJ1Y1d+Dm5gQBD6M4OeMM8QdIShj8CHqfntGysZXixq52Ixko5xrt4Nch
 5cKBhYaGRVpNEo0yQMerQxfe8otUcuMraCA3xvHN+tQd36ycucmf18g+DYQ2y/RHlPdV
 25h7p4LPfteh3M6ez8kmSauchcn5/fZzzcpQr5IhNxRc/PMj48FQpdI+/E6yrmbaYlOv
 0mZfWWYLNSw8uNuPZ/BhmVSzVEVOuJLZ0TSV823uvDJb8x426m1WRvqzy8jdHdzn7GID
 h9sgtTAdPPRGQ/I6N23i1SEg0IfIQzsEZu9gJVoDv069L5jx4n6J4DeHkK5i0sYYpw17
 VEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138977; x=1746743777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8As/hKAjswxkqY1TECVvJ6P3zOc3craDH105h0De0I=;
 b=O8G2pIzth4+/f92XeEEuocp9UoSeuqOVz6Bh9lUFBX/o//d72DhNrPooVH3twQ/xK6
 e4YYiMYucr4SztTla1bm3XUxodTbuVq1+nzJ6UC1OJNzJB5YK5pQqUxPs5P+Y6uI0xfO
 9e7gM2pOg0sJVshDU3Lax9u9sP07ssF26eaAIaSpgoJyr4wOh9ECP4NwNSHcxwFe0JzU
 gAryriPleX3yH+51s2vpWGTxZxjqcVZ+W9P6KmitmHR7rXRdVuyhVyTey6Va6f3a8yYw
 4VoOiIqJw9U/5IL/+OaV1xY4yRr4g51I35S5PdxRT8cJ/SqJxDtAfIczRo/P3SRHtw/9
 w3nw==
X-Gm-Message-State: AOJu0Yz82QVMj6Xf63oZNPnxaSMc+x8Un2CEZGDduk2dDPg95ZS4YMI3
 wxpdPcVz0tbhuR/FZ3x2+DqcA4UZd+ofq/eckaa+OneBTDuLgPr1HyNktLoMDkQt6yPtXKWnCqh
 G
X-Gm-Gg: ASbGncsK5J18GO7hwqtJRUoAdh4gXzsfyR6RtlH5RJZnhllIpXJcfaIp56rTVC4dWS6
 PaPpNoYTNmW2SNcuTLP0XghWkPKVolUER1C6PDEUo3ZQjnYKEQVy4YYsbUInvpAyjU/2fy3ihce
 UVqUybHMWwLBwSyGpLj5MMimiDbqRkcNeGfJtwvIzCIjNx9CNJqn7w3BBVkS998ek1DlK/X+QQd
 XfkXxraiXQ8aqI0gvN+nnVCr72Wexw3/8rql6ET6nWSbxRrmX1rOhcp1w9LivieYKEQF3+ZoOyE
 BJZHOE3zSRLca5FOF8gb1bVwJfz7IOPW35zoyr9wyoPnyeQcgCTo+VIkI5WkdupI5w6eLZ+zqON
 tUAYWNFAO2VPV9yFpo1u2
X-Google-Smtp-Source: AGHT+IHk7xaMP7nDBQ28NC1Y+yJ9V1pfYQamiECBSIjpInT338EYTv2/arYzqIm4pxkWURqozNvScw==
X-Received: by 2002:a05:6e02:188e:b0:3d9:6485:3a03 with SMTP id
 e9e14a558f8ab-3d97c155cbemr8558535ab.4.1746138977118; 
 Thu, 01 May 2025 15:36:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975f58f41sm3326465ab.49.2025.05.01.15.36.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:36:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] hw/i386/pc: Remove deprecated pc-q35-2.12 and
 pc-i440fx-2.12 machines
Date: Fri,  2 May 2025 00:35:21 +0200
Message-ID: <20250501223522.99772-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
References: <20250501223522.99772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12a.google.com
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 9 ---------
 hw/i386/pc_q35.c  | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4de84bce8ef..a8fda35bb9b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -709,15 +709,6 @@ static void pc_i440fx_machine_3_0_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(3, 0);
 
-static void pc_i440fx_machine_2_12_options(MachineClass *m)
-{
-    pc_i440fx_machine_3_0_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
-    compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 12);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4839e8c5731..0c7b407952c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -601,12 +601,3 @@ static void pc_q35_machine_3_0_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(3, 0);
-
-static void pc_q35_machine_2_12_options(MachineClass *m)
-{
-    pc_q35_machine_3_0_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
-    compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
-}
-
-DEFINE_Q35_MACHINE(2, 12);
-- 
2.47.1


