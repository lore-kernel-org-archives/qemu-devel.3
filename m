Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2FBEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMK3-0004NS-Eu; Wed, 11 Sep 2024 08:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMK1-0004Ce-Ln
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMK0-0007j4-0K
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-374d29ad8a7so4296125f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057182; x=1726661982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4ODDkRuTQd4wN0i3JOMpaQJDlIDNPjXst/vtGiwOCw=;
 b=WmzW3iGJVDjy7SlD84HYR5Lt4+f+VsxRjoC2BBpro91nycvZcqP77OMQfqK0fQI5Ej
 B7TlQI7rKDTKeml8lYN2mPIpUTLB8dIU/TyI/cWpf4ZwkrNbWX805FVVlu1OODvEygml
 Xg88O2ymEJE1IbcfeUeQsI+Wc6HYyLaTMDSIvhj+rjsK5XlhJsHfrqIe7RXFn0b7AYqK
 AdYEZVVtsI3/Cf3xXdhD1jCvvHhUS7R6ZZFLOB/kTxyxYAEohH6vfFdq1gwxUXD/8eZg
 Y8np8FEEQ39KrxNiS47XiJ7MskfTqYcygPp4cTRQrQydqiSx/f8x6eJQzWc7LNdcEice
 EHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057182; x=1726661982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4ODDkRuTQd4wN0i3JOMpaQJDlIDNPjXst/vtGiwOCw=;
 b=XBw+T3U0xXOl2qAiC9Rx8QWcBoikCYWSBk+Ty618I8L0gKB0Jvcn+afCUDYrDkDwQk
 Nvf9o+hBOkEQVw8v0g7ZY3Y4afpr1E3HiQGyBC1+Fi7W1dl+5YuHsBjyHMc3KYbLsVZw
 pMy+pVx5D0OOCNquNZyxANKP5Fxd7lRsZqbdLeOHAC4llrsB3fSFbU4XL4OLb304QesH
 ZsoXRPYoMtqMp0XLEzEAhIJE4TSFuSQ3GDXXEu59LcTDrNjsInTDkQ0M0A9IRFSXcaMg
 0YGcWn1zadUSwTdHjZj6c2Y5mgAltC56ukRDIWFMhZTOWNYyRVSHSowa2WEU/UoSJDR/
 abYA==
X-Gm-Message-State: AOJu0YzvBpaiEPwuUD0v1410vuGSu/nWRDZ9VKiWWES90j+6SVqhG2G9
 cfzESa6lSWp9iRCIkKCXYnn8d1Q36WCxwLrhYPnxYBhqWpzYLH6koZ9Jbks/KtxeVNFZAXLbXzf
 P
X-Google-Smtp-Source: AGHT+IGB2U0vT/TYFE9Fd5sua7ehIwEN73KuDwPKCelkuNd7bYncrXm4LHePegnBVZ/k99ruEirrcg==
X-Received: by 2002:a5d:68cc:0:b0:374:c56e:1d4d with SMTP id
 ffacd0b85a97d-3788968c7f8mr9008437f8f.54.1726057181894; 
 Wed, 11 Sep 2024 05:19:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789556aa7dsm11817122f8f.0.2024.09.11.05.19.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/56] hw/char: replace assert(0) with g_assert_not_reached()
Date: Wed, 11 Sep 2024 14:14:11 +0200
Message-ID: <20240911121422.52585-47-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-5-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/avr_usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index 5bcf9db0b7..e738a2ca97 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -86,7 +86,7 @@ static void update_char_mask(AVRUsartState *usart)
         usart->char_mask = 0b11111111;
         break;
     default:
-        assert(0);
+        g_assert_not_reached();
     }
 }
 
-- 
2.45.2


