Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80936C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwziA-0006zH-P5; Thu, 20 Aug 2026 06:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhs-0006th-Us
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhq-0008O3-PN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso21321285e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220545; x=1787825345; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5cfoTqeUfsT7GA5iC2nqqY7WKdSsJfkybOKIrlz+Kvg=;
 b=Z0tgKAfQe6hCnjQYy0+AC6NidiyowIpJftMlZ5OTVeTgHMj50jyiizdbEk910fg+Ra
 GFgn1DJneR2bEO+gMuNQx3TYs5YC9VWKm7g5V+HOjPEjGaL4Lw7S+lNjEOt4eWg2GxVL
 qpIJ/RGZo48Y38v+JL970scmeggi0qu3tKaWOkRrATF/XfBOHHJbPA40m9yETOy7vO1X
 exNjBpS+UtLw/t1KyUAgArEWlFbqpl51OWyuqaNQkmAZNam528/Mugt/o0dsFY3bbixc
 0hvT3zILEL2oMNNnh1PdmBg7vXoUpkGXwrPdHOQ3K+76IRZZUMveMsJtJydU+SIEMRRN
 eTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220545; x=1787825345;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cfoTqeUfsT7GA5iC2nqqY7WKdSsJfkybOKIrlz+Kvg=;
 b=S+9EC1aPtG+1D07UblSYpmdup00MQBtGZaivhqWzUXgznIxzPatQMiglJ9q4WBBFI7
 YRPe6o81DmyUqI6tzpZpvqAno/wCyps3hbcfUFxuXtVZf6S/F/zwlPI45Z3a0jFvj/9v
 kPKuL+6HrKuRUHCopUgz057qwRMhNsAAD8ap9Vk16r6ie5aaC135nms7f5kQzNgRAnQv
 ALZqiZ7EAq+XWaPXAw/Bt2CHXh9eZNx+jmV+n272WyF1a+R1ByNQxQhl1mpU2kN/d8go
 YJjMX30cDiYITCkoaHNKH0q9Kjcggl6SpSssxA2mBAxCXzXASpZpa2lK0eLGVTiep9m2
 B8iw==
X-Gm-Message-State: AOJu0YzAc99UjU7ypmi8UhfSynZRxMwI1dfghoDf326Pi5+hZ3BX4JP/
 PnkK5+5Ag1ud6t/PN/Z6pAKD75XMq+s8e0FWzBeGVPpjLKLcvBC69CXGPVni3qUs498KgTYSaT4
 hGU3I
X-Gm-Gg: AR+sD13Hs36yfpIq5Oz9uut7xvorfIgZuE3OgWed1mOcOvInhTAr1YV6ihctmLGK35t
 xP/KQ9AjMSUbz1E6maNjZIQAefFhqN5HN2IqUobtCB4+N/VyFVTbLjJHY6B+qiQFzAaCsuSYHvF
 opNSOvyDll2QGanJsPYumiDgueq397HKTTN9fqSRYxl/Hhe+4JZRSbNki0zXIEZsd17v9VvyCXg
 J7wQfieNIaiF2UU2Hx5szLTxq2lnq6fd2KsRv7YVJGY+NjCfgUt2zAUvta+lUgUzZhDrVOR1zSP
 joqFXYPeC+Esvo91PzQVJPTT1d5c8UFrq5Nw+etse7NybEENBPjG5VGBGPwHzUqY1gRWfr/9heo
 lrQgBJYOmmiXRfNe5H1TY9GyMqHlnpuXXztzIPJ4Y90FuOZYybwv2I7/yGjwqWeMya4XOBMZ49c
 YKXyhTAp4lDF6ZHSdECjGvCTNm6TotgavzDtqkbBuMgBld4WSCAM+rYJOXN67DwHe9KfMR
X-Received: by 2002:a05:600c:3596:b0:495:4749:16a7 with SMTP id
 5b1f17b1804b1-499aa1e269emr199503515e9.14.1787220545340; 
 Thu, 20 Aug 2026 03:09:05 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 11/17] hw/ide: migrate the power-on defaults revert flag
Date: Thu, 20 Aug 2026 12:08:38 +0200
Message-ID: <20260820100844.411717-12-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=den@openvz.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

SET FEATURES 0xCC asks for the next reset to revert to the power-on
defaults, and 0x66 cancels that; ide_reset() restores the default CHS
translation only when the flag is set. It was in no VMStateDescription, so
it always arrived cleared.

That was invisible while the destination had the default translation
anyway. Now that the translation is migrated, the flag decides how long it
stays in effect: without it, a reset after the migration reverts the
geometry on the source and keeps it on the destination.

Send it only alongside a translation the guest replaced. On the default
geometry it reverts to what is already in effect, so such a guest need not
lose its migration to an older QEMU over a subsection that changes
nothing.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index b074325afa..5a5f072630 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2988,6 +2988,25 @@ static const VMStateDescription vmstate_ide_drive_chs_translation = {
     }
 };
 
+static bool ide_reset_reverts_needed(void *opaque)
+{
+    IDEState *s = opaque;
+
+    return s->reset_reverts && ide_chs_translation_needed(opaque);
+}
+
+/* The flag decides nothing on the default geometry, so it travels with one */
+static const VMStateDescription vmstate_ide_drive_reset_reverts = {
+    .name = "ide_drive/reset_reverts",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ide_reset_reverts_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(reset_reverts, IDEState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ide_tray_state = {
     .name = "ide_drive/tray_state",
     .version_id = 1,
@@ -3052,6 +3071,7 @@ const VMStateDescription vmstate_ide_drive = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_ide_drive_pio_state,
         &vmstate_ide_drive_chs_translation,
+        &vmstate_ide_drive_reset_reverts,
         &vmstate_ide_tray_state,
         &vmstate_ide_atapi_gesn_state,
         NULL
-- 
2.53.0


