Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AF0CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV63-0004eP-Eh; Thu, 30 Apr 2026 13:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5v-0004bC-5I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5t-0004CS-Ol
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTtPLWKn1+6Itl3tIYBFRARvyQjFzHIf3U57NH9wkV8=;
 b=MWhLyfJvFlv/0zhjLMAVQ9z5zcuN3W8QCEJw6lGMuL9i9pKcWBpDCa3xKpBWc8OycDyUSL
 0XELYuP26fnVFyeKCkMZiTqtwJ0CXXw4MVhwEzQ22XGQiC0636ocPIxIWfn6uf/t8U7MDt
 /vjk6Ezph8e07ok2UR0c9LiHbi48EOI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-WzyYfblBN3GAxMnrzV5Ezw-1; Thu, 30 Apr 2026 13:22:31 -0400
X-MC-Unique: WzyYfblBN3GAxMnrzV5Ezw-1
X-Mimecast-MFC-AGG-ID: WzyYfblBN3GAxMnrzV5Ezw_1777569751
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-60599e65115so828008137.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569750; x=1778174550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTtPLWKn1+6Itl3tIYBFRARvyQjFzHIf3U57NH9wkV8=;
 b=Nvz4y0D1c+38caD6SAL3qreOLe4vj+m+oI+fL7DhO71oKAuokbfaMrRKDcNAIGXWPx
 Ok7mgA7HPlIFD4YPmtpBTevEnjcsBzxfVySytq8FfrCz5ZHj8rGd37V25aaMm/FRZFCV
 gnGQZRU56HuKkc8241v5HbFUc7BjAs7cazSie+Lqy3FjpFHZtcmpEoHF8EGSFuDv9sfz
 EqoDFd5g2hm+HDaSvDyTf5wBAzH1L7nGAC0/ql6FnBKswKf0aYWmQrq6bNiBl7Av/KdX
 9jY92F5sjg39/LpAiYN3RFzQ9aSw6fEaslZgHMG8SUUpmU4QZmLusGDujN+lo4HYv/9u
 MScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569750; x=1778174550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KTtPLWKn1+6Itl3tIYBFRARvyQjFzHIf3U57NH9wkV8=;
 b=TL6xqbz4WJZ+YRmy65ZDQdAJ9L94QrQouVAeIAIvl0/feNdQhf6ua3VsLMNhTg+9yr
 KoaP8DIo3P89YKU6Ewle8x+fPjc7mP7wzKkG29VQ6bujlbp0CRgiUwoOCz4eJrVmP8a0
 Pt8HBUf1Lja1L2ARHUMNZ9G7m74ZAaQPwCJ+Qpx46igTp8VgrcXXke5nzBPHdm6yJXGd
 gSyFQ8sNx0tjct1ne2gmq/IJdwmltoy0hOy8rY7Pu+mvGHDhFUKSEY5+vNLiweUBjiSJ
 PZGXFqyFuZcMJ8ch8MO8zGPUz3MCT4jhGyhoiwVm1UxOnE5i4KfcDeI//lG2Znleqbzj
 FDXw==
X-Gm-Message-State: AOJu0YzZKxEMLCZ0qC6ff2cBZoSRp/WSsofejrjGsqlZGF1yIleTVsnB
 giVx96+pSI7csQ7yiH1j8ZJwQZsp5AdSPCwFD+bKGz/wMbiU4fEs2le0zoQ9V9n43PPgaE6Af67
 r3eMm5fxU3nX8sxoQyGR3Uwoxplbhb5bX1BGy3kvCSmwp5V1k7mE4rxLN3F/5Xqmo5kJ+XcjzjP
 zyHzUYZtwFB9bbjKcRZsjhmdrZ4mog60sptoUj+e87
X-Gm-Gg: AeBDievFvhJ+hntqzAI4ydzlANJbvqhXODHvxw0cdXK7FcsMCEFWeMCN/4G1Qr38wBB
 4bm1t3Rpdbkw0bjd9WoF/mjGQdq30nL5ZC0EEyaRYDibwRCoJsCEr+l4kC6Pw77//I7y/srDzR9
 VWtr7WTQuQ0xuNiHAMBkx325e8VZ2Ibw+ikBO7d3Dnj9qVlF2LU9Qg3Ud+vajYQ+9keq8eutEYb
 VN0uLryy4YYAeSkWgO40+uU5ZBtVHdUbiles7UDMbLAvEGZ1/bKq6d657apdi4fVZYntgOxKDY+
 GLfn5hQa0PHYWalVKymLV6JFY3IlxdJKeh7z3ZwV7rQ/lX1aZ+sBYMfPU5zpMP5IsInDVCR8BAS
 HmQr0GbrVGLxUjOCyCHbmpdlDt+ttzdsmMu/GliO15M72mHEVAdnSe2mJLAXt5tjDAT15OwYoZS
 X1+ux71bTXbOuBshvVaWIY/LTWJYdS5OcG7tI=
X-Received: by 2002:a05:6102:808f:b0:605:5e9d:2e5e with SMTP id
 ada2fe7eead31-62ad21398aamr2256878137.7.1777569750123; 
 Thu, 30 Apr 2026 10:22:30 -0700 (PDT)
X-Received: by 2002:a05:6102:808f:b0:605:5e9d:2e5e with SMTP id
 ada2fe7eead31-62ad21398aamr2256837137.7.1777569749509; 
 Thu, 30 Apr 2026 10:22:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff459caasm22545666d6.36.2026.04.30.10.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/58] kconfig: remove duplicate declaration of
 CONFIG_MIPS_BOSTON_AIA
Date: Thu, 30 Apr 2026 19:21:12 +0200
Message-ID: <20260430172204.1006673-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/Kconfig  | 8 --------
 hw/riscv/Kconfig | 4 ++++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index f4d49248c08..99bdf09219a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -135,14 +135,6 @@ config RISCV_MIPS_CPC
 config RISCV_MIPS_CPS
     bool
 
-config MIPS_BOSTON_AIA
-    bool
-    default y
-    depends on RISCV64
-    select RISCV_MIPS_CMGCR
-    select RISCV_MIPS_CPC
-    select RISCV_MIPS_CPS
-
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0222c93f878..2518b04175f 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -132,5 +132,9 @@ config XIANGSHAN_KUNMINGHU
 config MIPS_BOSTON_AIA
     bool
     default y
+    depends on RISCV64
     select PCI_EXPRESS
     select PCI_EXPRESS_XILINX
+    select RISCV_MIPS_CMGCR
+    select RISCV_MIPS_CPC
+    select RISCV_MIPS_CPS
-- 
2.54.0


