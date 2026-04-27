Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824CBFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH3s-0002yv-2Y; Mon, 27 Apr 2026 04:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3p-0002lk-TN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:11:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3o-000345-DZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:11:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso80757325e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277479; x=1777882279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s+q06IceCN1KLToOU+ythjt+hQZ4+sEQyBGiYFrPOm8=;
 b=GVFHTrfZCuf/zQciTR16JU7udSZ+92Tt4U1krGlYVV0HXXZgdUsqBXNYMQYTEBgWZW
 HLOMLu4gqMIuyQT5wxyd9eyS1GXq2HJhda8arTmj/X748OARBEVkm3U9rJVCYy2pmL88
 1caLINaW85xOigi8BpWFTqoIXQVYpZp21NeAXokKnqdjJ4FlGqpf0Pp9i5cSDcrV4Wf/
 F4M2+5hWUXnKO9MEuawBiUV0fuZ/0nbuNaYesXsTRiFbxhavKZpiMPHIaDcI5iTVf7A6
 Kfxo7TbWahFGaqdtkHOHC4QQeR3tczyqXK1WNXS+60nGPYCTOL1bZLGDCPDfi9QDQPCP
 Pqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277479; x=1777882279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s+q06IceCN1KLToOU+ythjt+hQZ4+sEQyBGiYFrPOm8=;
 b=cBGQS8fB5VEdRPNiKwMVzSr3HCas3ex5Si3auWjQuBmKfkMgOGdPw3jKvQl7mftqny
 /XE1N7YKsNBgp22sKJn9dJor1qLXFcJwnIhwXegQrV3OHLSnCEZTL7v+2/8yeHpZI+IL
 0oxd5gHSKhE+InM2omGOkYyheD4IwPMpj0s1IV+/ia/BYHhk+MCNTkci2PjZ4Iwn0zCw
 u6jMNnvOsGRbZG9CyaG0vbKhQ2ns82O8R5EGJticCT+6pPFt866JKMV2GHFLSj1M+k7b
 bBeThqVAr+rltqD7d6hWG0PWohCPu+zbJiyRdntpHyQOXwBY8MVXm/8r8hk6SpohcG/J
 uGxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bVLui7zxU6AQSRhf8xkqQKQpmvxwWQrucbXX8g2tbCUGN/Ms2mRmik8qO2OPRHTCV/PdG45wny2BQ@nongnu.org
X-Gm-Message-State: AOJu0YxFKp0RdS4fSuD2Wiums/zENR3LOk/4sXhajmwi+kz990UhPF0F
 +hz64y93o5woJpl71hZEG7mxE8imEmP3HWVR/mA9x4BZBkXjyNurxCoOYQ1dkSAbEAc=
X-Gm-Gg: AeBDiet9vpNpbXrVaJaf9687IFGMLGbDQnjyaVZs2GYao8Nvavtyc+YfdlvJ/e4dODH
 wJC7YSCuKtr3MkMMTwxfIWuMvJ7FYEhXMW0S1pAHcjgfQfcDEB/rVFXVNOVFMfD4vv0DcJkCS+B
 80Ggp8IjqeiUnOapkkntDYEw3LYtgPGX0Zv5nBna+PxHqR1+syWdBuemcc4RVs6olAu5iPMIIEj
 Epv+8zLM5kLv99td5oZm9+DHYdDx+D0QR40LVfuE4CPM22ivMQStNltOm9icGvxWUrz0TsleuI+
 wrS//RB4rFwXQ4uDo+Yg45n8YJWQ7YN/IweeMi2qxir9nY0UWhmgKIGvylg8PXsP2z1u9VBwske
 hVUsmLm2MfOOuaY8G92yVTqdPfLsF5P4sz/9dZ7OG0W9ioTFPBmqVUdmKUO4amc/TUnM/jfZplj
 UlO34TwLwFQNus6nEPtwcec5Ddk/PDT4lqWthv7FXJub3SsDbvQxqmIG9YDlJKTbgfw6dYeeNsJ
 i1WKYJB65A=
X-Received: by 2002:a05:600c:a31a:b0:488:b239:77ec with SMTP id
 5b1f17b1804b1-488fb778db4mr467279995e9.17.1777277478770; 
 Mon, 27 Apr 2026 01:11:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891df9e50asm470997225e9.0.2026.04.27.01.11.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:11:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 32/32] monitor: Remove hmp_info_pic() left-over declaration
Date: Mon, 27 Apr 2026 10:07:38 +0200
Message-ID: <20260427080738.77138-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
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

When converting 'info pic' to QMP in commit 795eaa62fa6 ("hw/intc:
Introduce x-query-interrupt-controllers QMP command"), we forgot
to remove the hmp_info_pic() declaration. Do it now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index c8ce8579424..f9b4c4e2982 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -52,7 +52,6 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vnc(Monitor *mon, const QDict *qdict);
 void hmp_info_spice(Monitor *mon, const QDict *qdict);
 void hmp_info_balloon(Monitor *mon, const QDict *qdict);
-void hmp_info_pic(Monitor *mon, const QDict *qdict);
 void hmp_info_pci(Monitor *mon, const QDict *qdict);
 void hmp_info_tpm(Monitor *mon, const QDict *qdict);
 void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
-- 
2.53.0


