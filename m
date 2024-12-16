Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC70E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN294-0007Lp-7h; Sun, 15 Dec 2024 22:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN291-0007KZ-Dp
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:43 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28z-00060M-Ql
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:42 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5f340d6db09so543711eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321100; x=1734925900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cXrXbfwgiws2bkMK/0sJxto8toVBigST19xjjR4sDbs=;
 b=uvH9vXAm6Z5+GZZsDLaS3X4TZiUdAnK0/wSG1VdNZ76sdcFfUZpTlYIfodK9WcGqXu
 z2OdZI+9MTfxNtsfl06KkSJQY03OFflDqL2Ffrs5WyirZxArLDNOgx7acGmMuvEUJa8b
 eSL2dLBn5UdnVuHt3na8vWTruOtQUrFVfkP20q0ezYTWvqZYJYd9Rwo0Wsc0rwerbFZH
 bve598QqV246KSIe0j2ulzTuZr3EsHmcCivvP1DYusw1oDe4dw0MVokmKFHPB/RAZNdJ
 wT38qBeGuwtgtms/YrmHfaI2jf4iy+fapaQ+bMuy+OfCkP2zkm9X4Vjs4xyLelCg0LFT
 7Leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321100; x=1734925900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXrXbfwgiws2bkMK/0sJxto8toVBigST19xjjR4sDbs=;
 b=SZ2whE3yBWQQb21T2PzWVTzsUHnn5zCRpIit59RpDZYuf70I5bmHfG82k6XWZ2v8qO
 pQ4iHZb322073KSizyc1ksdwV7CnUCAUr4vbEx4rPz+T9aPmdwSze8zZD1R/P5mL6t9L
 LPbmvrkqc9dFWbM3smSLRvLZJysGFC9vTHahaVQ516tiRfjRAC4qzKgX2eA/8V3qkW/T
 ovFLCtqAO4m8E+JwKhkQiHGPqxkMcQ+rnMaC2PaTSVXdU0V4Ar08d9TZ4/KPxGCvvHGi
 OKk2Ot8h6B+dzG8jKQR7ybId6Rt2I/546oeKA+Wl3o+/Wyt5V+lOGYwDjiKzyXo/vFOW
 En+w==
X-Gm-Message-State: AOJu0Yxp7lrtBunuxvEojWaEOQN9bfWiZhVKTsfY2m48nXk40/dwb0w+
 rSf+jrkxdznDoohJiCzmSVhPeS2GY4ZKSTBanTPOr4OBFHQbi08ngF4KnG7BPsB3Ct6lPaQTKTw
 ng+nGdGtc
X-Gm-Gg: ASbGncu5nM/ouLDKNoIQIl1A++TxOCozjNvk85bYt/lZOM4ne75Lku4Dknn0nPZleYu
 DezqdQfTh36uGtLkx7mYjWdcbnYZ6rXk5sQJ/XyGMV8TP9+JRcbumamI4FmK8BuxxkC1TscCVge
 f0IDeKN3bdFUmcsAleCuc1WB/2/0/ASDJZdboNo0o/9rMOwArGZNu9QYqZ+5RrKKHvEkUYEw72h
 BIZsOt4ETqxOlr1I9EP6vkoRJD10QX30lJ4QUnpW6YpLOOmEqNj98zyho008WNL2MW8KXmyQRiZ
 gaED798iZXPfcZFxnoz0smzd1bM2Ou2kOkZdqBzk5Q8=
X-Google-Smtp-Source: AGHT+IE/UFwQcxCn64toeJArnDUlyIzOvptCK6zwkkiyd9SAaXJVd2SABqJb3JQKL0NKF5+npYp/GA==
X-Received: by 2002:a05:6820:1c8d:b0:5f2:c5e0:452f with SMTP id
 006d021491bc7-5f32952271amr6415108eaf.7.1734321100569; 
 Sun, 15 Dec 2024 19:51:40 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/24] migration: Use device_class_set_props_n
Date: Sun, 15 Dec 2024 21:50:59 -0600
Message-ID: <20241216035109.3486070-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Export the migration_properties array size from options.c;
use that to feed device_class_set_props_n.  We must remove
DEFINE_PROP_END_OF_LIST so the count is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/options.h   | 1 +
 migration/migration.c | 3 ++-
 migration/options.c   | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index a360f93a44..762be4e641 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -21,6 +21,7 @@
 /* migration properties */
 
 extern const Property migration_properties[];
+extern const size_t migration_properties_count;
 
 /* capabilities */
 
diff --git a/migration/migration.c b/migration/migration.c
index 6b3b85d31e..d23d392685 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3822,7 +3822,8 @@ static void migration_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->user_creatable = false;
-    (device_class_set_props)(dc, migration_properties);
+    device_class_set_props_n(dc, migration_properties,
+                             migration_properties_count);
 }
 
 static void migration_instance_finalize(Object *obj)
diff --git a/migration/options.c b/migration/options.c
index 24cc8471aa..70ff56535a 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -196,8 +196,8 @@ const Property migration_properties[] = {
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
     DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
-    DEFINE_PROP_END_OF_LIST(),
 };
+const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
 bool migrate_auto_converge(void)
 {
-- 
2.43.0


