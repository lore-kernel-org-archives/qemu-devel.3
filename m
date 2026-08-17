Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A7C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4KT-0006aN-2m; Mon, 17 Aug 2026 16:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KL-0006YM-PK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KJ-0006i0-KA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so48311425e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999977; x=1787604777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBZWsIiOBzxNYtURp7PYiUCHB7BOW6Efn63eFgp73h0=;
 b=Ut3cueUtIhUVP4SagyumaNzI9qc3scg8ZtG+oBu1OOI4HawRnuVuMGL/2p2J8ZeSpd
 ZssbmlqKytUItca86+NfeeblG9sffO3MLCEPu2D4gARTpah6bcb3Bg51nvPuF2fWeSjT
 TwuIsttt1xOGqvCE5kEzZpZHiIjzicNXTAh9gYOlqO4ylAIEr/ifku8jLNM9ZunX67Oy
 RFNv5iD0OL/6T2xlv3LNAF9CdUBofWp7x7tHtubi/F3n32qKRzJS2dFwxRsMv/1uBocm
 LUXxP6XUCnow9W9ixDhtFIy2O4opstgZzduZ61g4eu008CSQXplB/Ml57b54lr/mltN+
 TSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999977; x=1787604777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pBZWsIiOBzxNYtURp7PYiUCHB7BOW6Efn63eFgp73h0=;
 b=ljnb8Oqxx13o2+yKCNvsSfM1h0rwUriBtO3haYFJf937z9Lw/LPzRWQatJ+nRbzi0g
 kdUPJOhsSNWl1d7bv/RnMM1q3vqZVX7v0JHD8UWyYHiEz+yoiqKNemw8zRpY1li/boDq
 VE0ionQ3UKiNX5qi2VLGvDs1/aOjcWUO7GBOfiHq9p+nULfKHewnljPVg3IuEiyW5dS5
 V+shIlqlRvRhdP4BU0Geu9bgTsWPTdIldMU2pGo5aCktse0sHws2ZdZqn47dzFvxus8d
 sKKGQZwzcZGusFzxijW4ZPw+X3t6sla8XkpXbOVujkkwHBFjgziuAvQsknQSSfy/13MY
 YTaw==
X-Gm-Message-State: AOJu0YzxRkWg/nO3nRVV11417gr8JUhRmfJAqVo7shUquA0ZCFrs0/XV
 +iFwVgBfMLUERjVdY2tedIg2MXWqzDDhSrS7+xdo9+o5lbANpLhA/hF4gfrzOu6HSOa5PaOJBuM
 1FQKQ
X-Gm-Gg: AR+sD10s8BdtEQcSo4ZG72r0ifA4Ew1WeUy6vFUjh/ukqQPflNJzKH2DbXR3MVKikn5
 dyWQXFFDyGaTi7jbRoPG7vUwQfWkiUILLzkWKwDOBX8XRweP6zwYn8d1rOjiW06u7/3YxQuBkv0
 ctH9HAm5u40nN8vHKVbq8pGLdw1sNp7V3VniIY/V3z5VRkM5UzAxaUOIxhGcvVO3VJ/MkA+jPPg
 HHNj9NWwph757QA+oVexvoJtZG4a0i4QIpDgc/trhFtt1QIPg5DuaG8p7r91QaQWVasmNSjbZaS
 JFGeIGHKHXG5OS+33vNy/MljuSe3XxFrP6VzEVuK3SptWET8xpA5eg7JH/5TBa3phRjvsWYFMX3
 k0kPAD0beetIIdXy/FuWC/NwaMjZadCapzCjrVycyXVPAOSSKB964tXUM8VvEFvWSrY+rkGffnI
 f0AvBqpeZwdlnv1rxOL0g84zNug8rytYBu4p2beylQudNcAMcowQ==
X-Received: by 2002:a05:600c:3b8b:b0:495:4fd4:619b with SMTP id
 5b1f17b1804b1-4999fb04106mr56682945e9.1.1786999977111; 
 Mon, 17 Aug 2026 13:52:57 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:56 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 09/15] hw/ide: migrate the power-on defaults revert flag
Date: Mon, 17 Aug 2026 22:52:36 +0200
Message-ID: <20260817205242.1199851-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=den@openvz.org; helo=mail-wm1-x32a.google.com
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
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index ab8c23e5b9..c330508128 100644
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


