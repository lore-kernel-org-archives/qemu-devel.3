Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F024AC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfF-0004ID-Hq; Wed, 26 Aug 2026 07:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfB-0004Er-0U
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBf7-0005dB-Rz
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:24 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a38098734bso1371201a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743160; x=1788347960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5cfoTqeUfsT7GA5iC2nqqY7WKdSsJfkybOKIrlz+Kvg=;
 b=sFfGAdSKLiFpGWM0IipMsR0fSTKc61tTP06ilTRuUuO21M6r7mmY3aJbf2sGBTPwhw
 xdQwGftVne5I+u7uN9jl5sr6u7aOp4s+uoucea8r2JWxgm3lAm8joi/9b1suBdKmiQBa
 iqJuji/dv5ypABFKeF2pdECgg9zG+/O5ILiWTmBhj1CYe0/3ky5gs49OKQbL0wVpkFmr
 f6Wd3zGe/sprFV9xmwOrwFg0TeQzcPfPIGnyxrYRB5FVsNoQT+PQ5ox5CpgCHo3i10/T
 nZIWRK2fAdn6FKKZCDNy7ATneV0N6CLoVuhyUWpU8S9wqmSGQbGi/SMaClsCOQp3jstI
 fF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743160; x=1788347960;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cfoTqeUfsT7GA5iC2nqqY7WKdSsJfkybOKIrlz+Kvg=;
 b=fQxuZCI+ru9UPw3lxIumgX7FGxprNGryO+8xiz5vaRtUNGabZ+4AkRwSbAsgcbKdJz
 y6y2tUJdFZW7uX6uADunLFaA5pCADW1HL51QET5BMr2Nkmp1Ac6sFwGtkbzvjbijbTKE
 fnN2xgujBOBpNfGRd1beScY0yd9mVUCdu6HcNGcp3haEoVofG6UKpb6Vvx8J6pzloayc
 BivvrUAh/A6npFfduZ6S9idUGR6v8kt4MZTpp6uJwS4d4toTr7CDWXYPpneC/BP6w+i9
 dZFLdSIWSKx/NsL+eQNxJyxKqM7QSgL9ik5IrJVY86iUgFm7LX5yECRL3nCsc3T9LhTL
 yshg==
X-Gm-Message-State: AFuF++n4Q1l9HM6fJg/Uq8ss1tJaRfDmyuzVr6d5NtDALp0/9V05rdPI
 DsnTvotN3FWrE3akQYYupzezBdP+jskgzH0FJx8Q5U4rRJPfnkV54aOGczXg28qt2juk0l0LFK5
 YNcJ5
X-Gm-Gg: AR+sD11M8bYdWqe7Gmx9Abk8XK+0n8ttP4tLvFCp6Q69FqSPj1Y0CCuZU12h45Xo2x5
 UNRv6I7Nw4wjRbgzhUfLgUtwgqLWB3ZVM9l+GtAbVDIW8iAJgNamYci53M0/ET2YEW4gNuBpeUo
 kUiejKx9u/pVYujxwESaY1Q2p76zYjs3VaZGC34kLy+j7+QcDTigvNvHgOi8hGUsRnOdKKD0sEX
 4+SjWScvHWJ4IqqGgOL+kk/8oe785b062n95jcI2fXysKcJLU2tiwBOOLdHF3YVzPhiYg3BcwfR
 zg1nRRV23AK7y/s5zuo3pX1oWG18wubAjBlfJqnKGV3nB2kY+NI7FgJVooDo4nYoSPS0Hc2R3y4
 kmI5Qv5dQ6dH0i+nCn+faOnDzs617X3l5Q7vT65koD0STasF/4ZP9Dl/vZiIspWGg5G2VY+H2Bw
 DU/TRvU2jiCnRmvPMJ+of2EhhTt7uPAFLMgvI7LYhzzDzLU4rV
X-Received: by 2002:a05:6402:1586:b0:6a5:d8f0:dc12 with SMTP id
 4fb4d7f45d1cf-6a5df64dd40mr8306066a12.14.1787743159844; 
 Wed, 26 Aug 2026 04:19:19 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:18 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 11/28] hw/ide: migrate the power-on defaults revert flag
Date: Wed, 26 Aug 2026 13:18:58 +0200
Message-ID: <20260826111915.3387926-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=den@openvz.org; helo=mail-ed1-x533.google.com
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


