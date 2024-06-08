Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C124C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2Ys-0000lA-Dp; Sat, 08 Jun 2024 16:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sG2Yq-0000k4-Oo
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:21:12 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sG2Yp-0006Vv-5v
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:21:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35f188e09a8so376309f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717878069; x=1718482869;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RqSz/egwUoLX36Oqb4G2UnTOgtv4z+/AsIJrjeRIuk=;
 b=0Bu6jdxJnYH+OGEIMQCM467CT/5OrXdefT3XyeI3sQ88AtIPkZDQtSCGAynUTLPZHm
 Xks81JYR3W/vrBaOD1Yg6hkMNvbmMvUvX4Cqk2cRfQuwM3XspcmJ70UkbJ14FSMOB+8b
 8wl6axvw8KKesnIA8uwIiv4ugvxOXKYxpiPbVAYzDTPZfVHT+xxMZJsHBbrLBVbM260A
 VjvyzJ8wVOmWF6PMEWlbnRq+m/zmlcRqn+pLVCqsiTZ/KZ+FW5U3D52THek+Wyw0U221
 j5Yw4TU3y2khjLW0sHFCVfviuCKVlnUZVhGvC/WTOIPehB+kb6XsByoMKL7QxAWN+l8j
 G4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717878069; x=1718482869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RqSz/egwUoLX36Oqb4G2UnTOgtv4z+/AsIJrjeRIuk=;
 b=DJQUkVzBQKU0iyk6QxOOyzpglel5w9qZBk3IhT0BbUUC0/3Iy7TOQ+P8k2coh/C5Hf
 qkM4Jv5FM6dnGXc6Z+36AvBB9hzodkKscpaRFRKaYjjDK6HNQfXuMl4kcuaE/mG/YKto
 xPn41m8kdWQn8vBXIFBtcsg6IDyZfA5AspIkQlpL0rL1yHEJszTJ6ToUBek6O5CqUQT0
 tVF6jz1GyUutVcYK/JLSYOAqoQZ3yTb20jy7I7v3qNM/CKALtEDBdqIOTcZMgHE/d++Z
 Y34G8VQhBjWigsWigrqRFJwwNk4uFNbk0loLitMNDT9cyYp3/mbDv9z0y+EMKcHmkYPl
 vOTQ==
X-Gm-Message-State: AOJu0YznlOOAya/HZmX+t99qnhJ8R/4ZXGqdr49L1RY2ZPZptODYeqbf
 4jkMaYxxZQ/OAespsGkGxkT2WhZkbyl4HGNP7jq//hOVLEmMPNN3iaIF4ZgDKj6+yDdWUhosFRk
 =
X-Google-Smtp-Source: AGHT+IHJgNwAAZiMYxz/nmPYcxHXlfgs2Cv3Ym386VHzGBgJF/Bg3JUEy07EUrhSWJJzx/qot/zd5Q==
X-Received: by 2002:a5d:56c2:0:b0:35f:d70:6193 with SMTP id
 ffacd0b85a97d-35f0d7062c0mr2341623f8f.41.1717878069442; 
 Sat, 08 Jun 2024 13:21:09 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0ccc5f03sm3803845f8f.88.2024.06.08.13.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 13:21:09 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 marcandre.lureau@redhat.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 1/3] Cursor: 8 -> 1 bit alpha downsampling improvement
Date: Sat,  8 Jun 2024 22:20:43 +0200
Message-Id: <20240608202045.2815-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240608202045.2815-1-phil@philjordan.eu>
References: <20240608202045.2815-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::431;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x431.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
turning alpha values of 255 into 1 and everything else into 0. This
means that mostly-opaque pixels ended up completely invisible.

This patch changes the behaviour so that only pixels with less than 50%
alpha (0-127) are treated as transparent when converted to 1-bit alpha.

This greatly improves the subjective appearance of anti-aliased mouse
cursors, such as those used by macOS, when using a front-end UI without
support for alpha-blended cursors, such as some VNC clients.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 ui/cursor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/cursor.c b/ui/cursor.c
index 29717b3ecb..4c05e5555c 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -232,7 +232,7 @@ void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)
     for (y = 0; y < c->height; y++) {
         bit = 0x80;
         for (x = 0; x < c->width; x++, data++) {
-            if ((*data & 0xff000000) != 0xff000000) {
+            if ((*data & 0xff000000) < 0x80000000) {
                 if (transparent != 0) {
                     mask[x/8] |= bit;
                 }
-- 
2.36.1


