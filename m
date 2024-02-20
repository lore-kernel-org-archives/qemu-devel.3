Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC061C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdj-0002B7-FE; Tue, 20 Feb 2024 11:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdg-000292-2N
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:36 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdc-0005Ft-LX
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:35 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so61652191fa.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445190; x=1709049990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19euJWj2Bsd7+44lYFRoDEAxkKA5sWf1qGZsesZBvWY=;
 b=tkn6ECuCmoesHxSOsV0ZKKFXyGs9c1qULWX9ah9kscQsj7aHFxSvgkyKxUoydZF9Qe
 ue/Nu6XLpKO2n0E78b5Rdi9uh89OUGUZXSRP+Myk4o9sZk9Cl54UKG0hKfANzqWM2aUZ
 ExRPUFnb2rBxmZ6WscWmBfpY2jVGefp1YA1a2R47y+zuOB9Syp9B6soNeZ5f+vCiPYSM
 7zsbPIm0iJH4Zd4sD8NsOstinikgVhB7mibOtrn2gW6H8ZLqtkcc4v5l2IU5gzDPpNpm
 dHJ2LUKGRqT/hayh4E3Nln/QH3I/PMsZ4FhfaivzoZybLQ9W6V883rRoV6zbfmyeW5QY
 yAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445190; x=1709049990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19euJWj2Bsd7+44lYFRoDEAxkKA5sWf1qGZsesZBvWY=;
 b=HG90MbEWBDzDKlttfp4RfhyhTzUz+y+p5cQJ2KcroEp/sK7bcCICp0hPBdtZPYIr0O
 V6ssMRn9946KUHQi57AVorl1vGwy7SJfIiBpbTDoyV2D1TjlTyP31g7/48Qq5OMGO1mS
 3NP/eFXkAgotcFTaouM/zg8B3HAhgaBTVXvBpYKhla1/ShXD+4ip+yUYclYQwAb/v2Xg
 zSbm5SK4qZ7cTiRKo7p4lhcTtdJ6g9J0PAfFKAGfD1oDcU6VXsux5BItQqfu4ODoZqiU
 U5L5KCVb4HVUF84YFm85lwiVahf9FOmaKeEHtT+HmOrs3A5RqgDMKM6VxhzehjUT1cH9
 U91Q==
X-Gm-Message-State: AOJu0YwwtZIjY6zQ2kxCxA/sDFYsOeFzO5Jn1RnkbkXs9sCgd9GtFYiq
 FbGl1MF8HTk3hQd4YxWTW1nHDHz5oLix6hmPfb7lca2c5q62KVGJ87lmQlUXvSCJzopnWfew/4q
 H
X-Google-Smtp-Source: AGHT+IHki7Nk0Mbp8jZhjdeDsU4PuIArylIsKGuc6ehaVBNeaISCJ7Bb6fwEm+MGKoKEu5cHuC7Cjg==
X-Received: by 2002:a05:651c:1250:b0:2d2:3186:4597 with SMTP id
 h16-20020a05651c125000b002d231864597mr4262564ljh.25.1708445190048; 
 Tue, 20 Feb 2024 08:06:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 09/10] hw/core/machine: Use qemu_register_resettable for
 sysbus reset
Date: Tue, 20 Feb 2024 16:06:21 +0000
Message-Id: <20240220160622.114437-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Move the reset of the sysbus (and thus all devices and buses anywhere
on the qbus tree) from qemu_register_reset() to qemu_register_resettable().

This is a behaviour change: because qemu_register_resettable() is
aware of three-phase reset, this now means that:
 * 'enter' phase reset methods of devices and buses are called
   before any legacy reset callbacks registered with qemu_register_reset()
 * 'exit' phase reset methods of devices and buses are called
   after any legacy qemu_register_reset() callbacks

Put another way, a qemu_register_reset() callback is now correctly
ordered in the 'hold' phase along with any other 'hold' phase methods.

The motivation for doing this is that we will now be able to resolve
some reset-ordering issues using the three-phase mechanism, because
the 'exit' phase is always after the 'hold' phase, even when the
'hold' phase function was registered with qemu_register_reset().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I believe that given we don't make much use of enter/exit phases
currently that this is unlikely to cause unexpected regressions due
to an accidental reset-order dependency that is no longer satisfied,
but it's always possible...
---
 hw/core/machine.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index fb5afdcae4c..9ac5d5389a6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1577,14 +1577,13 @@ void qdev_machine_creation_done(void)
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
     /*
-     * TODO: If we had a main 'reset container' that the whole system
-     * lived in, we could reset that using the multi-phase reset
-     * APIs. For the moment, we just reset the sysbus, which will cause
+     * This is where we arrange for the sysbus to be reset when the
+     * whole simulation is reset. In turn, resetting the sysbus will cause
      * all devices hanging off it (and all their child buses, recursively)
      * to be reset. Note that this will *not* reset any Device objects
      * which are not attached to some part of the qbus tree!
      */
-    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
+    qemu_register_resettable(OBJECT(sysbus_get_default()));
 
     notifier_list_notify(&machine_init_done_notifiers, NULL);
 
-- 
2.34.1


