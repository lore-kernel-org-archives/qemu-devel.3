Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F54C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dp-0007ek-WA; Wed, 02 Jul 2025 14:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dY-0006pt-MH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dV-0002Xf-Vb
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso2063595e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482605; x=1752087405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlBOE8V4jVPken7WCnMtNpY/1Zbf/V//8TkK0yzKABw=;
 b=tK5xHDXDc90g/VG8gugCgQBvhDjVlkTtQx76bgqVAoAufMVdjjPHeqDcH2SjZZXhEZ
 sHAiEEersLmQUe/pvQt7LjsOkd1m1WH4kLuR0TuNO/4NOCy1mw2m/NAg2HxOcv/09j9j
 h9Z5Cnzkb53TiZyyKO3MikFQeo6H98yD4AR2+2odcFPISyK4bmLXb4fsE8nCvntZzGjA
 lnIjZOmVUiHA4CTFAPTswLzDx7qintNzMZf0UEY5B6uIZdHuY9kVsdpH4PHTW/qx3lh9
 b9ZhhPFbKr4vPYaWKRPr/rbU5ApRmVGVlF5PhlJy71kMKdyFZZiO5e7OVufX3EnbpQVX
 VAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482605; x=1752087405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlBOE8V4jVPken7WCnMtNpY/1Zbf/V//8TkK0yzKABw=;
 b=ISVDC50uiGHSoxtdRQdwzQD9ed5cUB+V0rLswyRvOlB4Y1jOhqOSo6WQeWGRueseVU
 plm3aFr0vT3MmRMnpn3fkErL5E9jsdfkw64c9hE7H0ps/Hn9j8I8vw+3GHdSufxuamCy
 GhoSZDBRYKmpWYXdbYeF6v+yTggO1ATT6WgBzJiKCX9ZEh3iVRB000sJqj2RobaL94MM
 olunTkRuufdzGH9usPcwYO8HhEf1duX0vhNPlu282cKHsQRIuq0bFNK2oxBSQxT0K2M0
 zh+QAXAlDtX0xfc2aOSYjo+oDLZUYqzn/IFCePpEvzDGOmC3tHl1/Yf42DhR8jwJCf8a
 B2iw==
X-Gm-Message-State: AOJu0Yy5PwcvJb/dro66XwVb61wlTzJ36N+7mySl9gsnQoJnHtN7r2t3
 HYtNBKER6q0L7OLi7HzXCNHWLvJNoX/TyLCmrP2199VmtaLd3gxBkt0ru6YT6BG8E5xKndyz7H+
 Lkrke
X-Gm-Gg: ASbGncthAhoE9QXuPFK1B6+BN+cP4tzF4T53Wk+shNmux/rokhOL3dADE7JG5FEjhR+
 3+JGyOlgh9wD5waTsHZMdvqNYoOauN6Beu+f5PO91LS/pxzRRdFW+mCipQ04v5VR7GMCc4xHmWf
 O7evF07HVbu1paZJHEedyX7HBzUCmNgzjul7MPGFnhPwzFcl8nIKYOfp4GvwL+6ML/P88yaZR3b
 mdsYWEXhWCJ9iBkzaClJzxp9YrFINA/JdFgqojhOdzvdR7Ou4yQvKom5eFEDGMA26Bdr7F0uDk0
 zCaGUyupdmInGLV04KAqUSVm4XNMRBHuK6MNjuRrvN5mQwoPzuUJCpXViKnB6Gby8KKHIZt+oAV
 Z6pa4gTneZEGL6e7v2MvBt6tY19Z4RFh3pVis
X-Google-Smtp-Source: AGHT+IGfarBqgsPD1JhSPtFJkEdGOfpnSdg486mnz3y+RHy7AE1p4zMdqb9XzvWN6deqJSxmCyEepg==
X-Received: by 2002:a05:600c:c170:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-454ab3200f4mr202115e9.6.1751482605465; 
 Wed, 02 Jul 2025 11:56:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969a20sm5753315e9.1.2025.07.02.11.56.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 26/65] accel/tcg: Implement get_[vcpu]_stats()
Date: Wed,  2 Jul 2025 20:52:48 +0200
Message-ID: <20250702185332.43650-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index ae83ca0bd10..d49d2b3b0fa 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
     }
 }
 
+static void tcg_get_stats(AccelState *as, GString *buf)
+{
+    tcg_dump_flush_info(buf);
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
+    ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
     ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
-- 
2.49.0


