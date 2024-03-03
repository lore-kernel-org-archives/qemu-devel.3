Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50E8C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 18:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgqyH-0002zN-KL; Sun, 03 Mar 2024 13:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy7-0002xp-78
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:55 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy4-0003xy-Ku
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:49 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d21cdbc85bso43782691fa.2
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 10:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709492025; x=1710096825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8smuVSbO2fN2A9j50qsVKag41OVErk/e6VgB0UOyX4=;
 b=ZaE6lQlmDRXUmWs2yiijWw+SYR6lNkxOWarzsXDDuLXgrdL2Me3xOqLvJU+uh5MfQU
 SY3LeisXNIgN7zMK0UeiRSl6K9L908BtjuWg+updJts0eV4+I+iRAv1MCv7y/4+2uJWo
 quBuRde36+bITRNOEa53AKwNsVer87z3ErlzkHYA6QY5gZbBtUILiTlh4aro+ovsh/fc
 AwwfF1RmiSfuoqLJehRwUYGFZ+SBu4K+eFakm0YefG/oxH9rou7iOt+MOm1o3GMtKgbH
 q2C7d//5CdStAwsfWOdqkps2gComKJKbir5jEMyLayT1D5EOdRS0/zhzuyoZb6Oc/Kzv
 TVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709492025; x=1710096825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8smuVSbO2fN2A9j50qsVKag41OVErk/e6VgB0UOyX4=;
 b=dsrPuTXwp0KbNYkWjDvZc+5gUGghiDYn/1Efj15oL+daFXy+9iHka9e7+bVTBGnyaT
 xD0Ofiq2f6b1Yo0Pd3DMT5ZA8smmnA5E5YOsKMM7/8Y6sVysxgSS4L3Xdb5pPT6laS9T
 5Ev5gXsPmB5kKPWdSO/46NFk8vHiBiKXjqFVM6e73+sxv4yW/hWmDP96AmU9xvcj5S6Q
 R9brjcGE6t24xCienYonvZ5QW9NSRcqSSeKEQGyMDaOwaslslxvv+zKTSs06G9paOs5c
 n38NDYG+3hYym+3eTYIGWzSektKXyYK/oCfwOcNdty+9zfT6rgmnZHQIv/fA7JFh1LKo
 4tVA==
X-Gm-Message-State: AOJu0YwLTHRNUJvsl6XaCMRzjinZ3INq2tAheQZ9xvgsImkf9soIZFk8
 rVP0aNl766wzNw46xW+ldbOk3a2ZQZYgO2SI+xEghBSAVbY1ZkmlFUjWCE3i
X-Google-Smtp-Source: AGHT+IHActmuY6zBRxH+SNmBhoEzfZTlMjNDZ8xhM75p4rkW6eCBbhX+TNBEwwwG4Lgyaz2/e93P7w==
X-Received: by 2002:a2e:9d85:0:b0:2d2:d449:6425 with SMTP id
 c5-20020a2e9d85000000b002d2d4496425mr5029555ljj.35.1709492024878; 
 Sun, 03 Mar 2024 10:53:44 -0800 (PST)
Received: from archlinux.. (dynamic-092-224-118-014.92.224.pool.telefonica.de.
 [92.224.118.14]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b00412d68dbf75sm5259460wmq.35.2024.03.03.10.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 10:53:43 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 1/4] hw/i386/pc: Remove "rtc_state" link again
Date: Sun,  3 Mar 2024 19:53:29 +0100
Message-ID: <20240303185332.1408-2-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303185332.1408-1-shentey@gmail.com>
References: <20240303185332.1408-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 99e1c1137b6f "hw/i386/pc: Populate RTC attribute directly" made linking
the "rtc_state" property unnecessary and removed it. Commit 84e945aad2d0 "vl,
pc: turn -no-fd-bootchk into a machine property" accidently reintroduced the
link. Remove it again since it is not needed.

Fixes: 84e945aad2d0 "vl, pc: turn -no-fd-bootchk into a machine property"
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f5ff970acf..63b7583af0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -613,14 +613,6 @@ void pc_cmos_init(PCMachineState *pcms,
     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
 
-    object_property_add_link(OBJECT(pcms), "rtc_state",
-                             TYPE_ISA_DEVICE,
-                             (Object **)&x86ms->rtc,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
-                             &error_abort);
-
     set_boot_dev(pcms, s, MACHINE(pcms)->boot_config.order, &error_fatal);
 
     val = 0;
-- 
2.44.0


