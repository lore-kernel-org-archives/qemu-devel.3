Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAF2C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw0J-0006Jy-Dq; Fri, 16 Feb 2024 06:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0H-0006JE-Mq
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:37 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0D-0000oV-Ia
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:36 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d14a711efso681052f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081409; x=1708686209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11uvKBQ22hdk4Lseo0ZUQbLGXppus19b55fkM12lrfA=;
 b=VVtEuRONg16xx1oOe+nOWr24BGDYupjedUe7m/Ujf6aVZ+6pexCN+uWLFWnvv6/die
 f0p5imiKaKkivgTp0MnTNlr2Xvra4oKuMAKBKsNCGmky56UcgLPxTSbGVeIA7/qUmts1
 hd8JyMbK6VxjKivF4ClO3HOjxZ6DXyTYaRKR/pAf0ei7zKtKY3RtciPy8DQTwKH0O0mV
 PVUSfPxkL7VgsbizmdK9JWuw7bN5bzjwwdPbwgd6To7jkWDMgWn6WGmBNy85sAuq2WFw
 ReVQmnsYNRJuTvqgeU2ZhqCVZfMShzvN+mXHUSnP7xeSMjG6JH7Xd1Z+UHpwTVQCgv1e
 fmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081409; x=1708686209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11uvKBQ22hdk4Lseo0ZUQbLGXppus19b55fkM12lrfA=;
 b=P7LMImfzuersiKzc/KF0cXreZa50DDJUzlHICS/l8bnSiE3OVBmmQ9Onu0AhdMm0xu
 WbwP91Y7vDbrbe7722+nfvWmGBDFpSCXkYM3kwCv2AiKGCQ14F/qiSv/1mt38CPfl3wo
 ZabAxp6xFsCzK4mhfvLgooymdqd2O05OgCMEHfHwuO3PFzGy1AolUzl88FUN3F/7QKDJ
 K25+0W5/NnT9T25uowshkzrGysAH/CbstLW2VsAf2VsVzGLkCzbznmAendixsZ0TiFaH
 zt3UO+PVxFcMzucuP4Db8YHx3kH36SMe87+mVeHKvfGsKRrd5r4fWf2uYLDchODkFDda
 81Sg==
X-Gm-Message-State: AOJu0Yz1NyKC1+SkmLc6vuZ8+u1psoXTHQiLQ8BeL55Gsy/I6eFvZrap
 E62uJ5Uhu51RlHuabSeKZvNusKkkZPaNsBXrlpSYcPKstG/4yivQKg4+yP4L4ZjOlYpGVKAS+Js
 n
X-Google-Smtp-Source: AGHT+IFEGlWLlINId8jkLQ8/GP9ml2ND63LfgQ5zuvLNh4i2admrWyka8hFD5GkfVv0excP++UzanQ==
X-Received: by 2002:a5d:408b:0:b0:33a:fafa:8cdc with SMTP id
 o11-20020a5d408b000000b0033afafa8cdcmr3540983wrp.32.1708081409620; 
 Fri, 16 Feb 2024 03:03:29 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 ay3-20020a5d6f03000000b0033d1b760125sm1780146wrb.92.2024.02.16.03.03.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:03:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 02/21] hw/i386/pc_sysfw: Use qdev_is_realized() instead of QOM
 API
Date: Fri, 16 Feb 2024 12:02:53 +0100
Message-ID: <20240216110313.17039-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_sysfw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index c8d9e71b88..3efabbbab2 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -107,17 +107,15 @@ void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
     int i;
-    Object *dev_obj;
 
     assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
 
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-        dev_obj = OBJECT(pcms->flash[i]);
-        if (!object_property_get_bool(dev_obj, "realized", &error_abort)) {
+        if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
             prop_name = g_strdup_printf("pflash%d", i);
             object_property_del(OBJECT(pcms), prop_name);
             g_free(prop_name);
-            object_unparent(dev_obj);
+            object_unparent(OBJECT(pcms->flash[i]));
             pcms->flash[i] = NULL;
         }
     }
-- 
2.41.0


