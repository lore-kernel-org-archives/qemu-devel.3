Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607E2C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbT-0007mG-DL; Wed, 26 Aug 2026 07:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbQ-0007it-Ba
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:32 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbO-0004FE-KV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so1235212a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742929; x=1788347729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XyPzbjMy6v/JTvTk8bqzZDyIH2YLdq6RbLehiJKH+ZA=;
 b=J5nN/JX2waAiooAIBvYfy663LllO5evDkAIKraLVyVmoxEUCzR1zyLlXYiR8ig9Yaz
 ereOSAnTSfDsz2hZPGxnJDh0LDbdnpCFhbhfTewYTGrWeV2V3Pv4CRwUbOSm+qgUyNq9
 re3b08y7w94DrtlCoNUqj3fMRhqppA23sAvZ5lcO72SqMt3xni22/7rdFOSJu19XHWvg
 5ATT2QY6YI3kICGn2lxQX+3hQTOpJ15RbzmsId822H0I8JD8cxSRcm1jw0cuwwRUIDtL
 3Km+bL02pxRx/uT03U5XG2mUxWF0+WDz2ZfhS8NYTADMvgzYAcPJSx1zUin54ZEcHDxh
 /3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742929; x=1788347729;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XyPzbjMy6v/JTvTk8bqzZDyIH2YLdq6RbLehiJKH+ZA=;
 b=nNGuGX5va7/igc4Xd4brfNqAVj3WxQ9ruStaaQQPehP5xWKfCxM/pY4Ax0KjDMLSWa
 Sd68LrQOzLbIWtWhxykYLL3MSiJRfB4MAJDRarHWbriIcqTbUnE73hNikFocHcI7Wc3a
 1HCPwQB83tSfuSkupQ8tPuIAeeK3Y7ZeIYfOhkX5zLysQSZDvu6P5p5rsSx1CQCtPk9Y
 fzCorn2QlShgAuQoWgqvziVcE2KEKIlxh0l5oCe26O4xAcLJypoM/DN7rH3QCA2HZEp1
 IrqGomCBlIJo+1RumL/uFwVDYgPHr9HhIy+EGcpE3qXfVTVppK+ZOkvTp4gH9eMw7U7d
 qMXg==
X-Gm-Message-State: AFuF++niyY9P47n6VVntZhx8EmQ1jZuvjv2MqVMY/mjEf+UUvypAbwgg
 vUPSeEHEd4Qg2PB9eAc6pN454grhapwLmFhlLIFqfotBbZFeIf6NhvUlAvdH86sDFA+0ENYzjyy
 CL0Fz
X-Gm-Gg: AR+sD12stj7RkK+R4eIm3bOSG0gIJRKWH1WwOcLqHfAuf9FCB+rky1inEEDryVgTsA9
 p54zDyu1C14lxEHWeoTAd2idtQtXxQeD4NdABV3VaOLjqa+gNshNXR5lMl3xVfynFXfYYG/1ni9
 M+9nGifgMgk90SPGGMhgHi2hLoojE8IUJCJrRt/wEpKSjZlq4cHfgJkbl0psIbxSppGNS7Z54FF
 pX77t5QtoyeJKzZ0zLB9lPCpnUy85ml1G4UxT5kX3OK04hUG1+8YwNWsj6UDonvP/idTzjp+Q0h
 CrfaSDixXM892bGnXzc5lmdWiItChSBWQJFNThR61jv/AFoguLRfd1NXgT36u/QK2GyD934Nlh3
 VEIKeXYpvKjjmgAChc786+cf/dA1UdiyHKzHpBdUDBLEdTLYMV+bgLBAeqlThXgZHVPKICRJnUG
 5ZcVstH8KiikR0DKnL7LYasYTbPRNM5o5UesrTY/2oAj/h2gcE0Q==
X-Received: by 2002:a05:6402:5287:b0:6a4:21c6:1d14 with SMTP id
 4fb4d7f45d1cf-6a5df31b7eemr8917637a12.0.1787742929005; 
 Wed, 26 Aug 2026 04:15:29 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:28 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PULL 01/28] hw/ide: reject an unsupported CHS translation
Date: Wed, 26 Aug 2026 13:15:16 +0200
Message-ID: <20260826111524.3383479-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=den@openvz.org; helo=mail-ed1-x52b.google.com
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

ide_set_sector() divides by (s->heads * s->sectors) when the drive is
addressed in CHS mode. Both come from the guest via INITIALIZE DEVICE
PARAMETERS, and cmd_specify() stored them without any check, so a guest
asking for zero sectors per logical track killed QEMU with SIGFPE on the
completion of the first CHS read or write. s->heads is safe, as the
command passes a heads-1 value.

The count has an upper bound as well. The legacy sector count register is
eight bits wide, but handle_cmd() takes the count from a 16 bit field of
the register FIS, so an AHCI guest can ask for up to 65535 sectors per
track, and the CHS branch of ide_get_sector() then overflows the int it
multiplies cylinder, heads and sectors in.

ATA-5 6.2 numbers CHS sectors from one and ATA-2 D.2.8 limits IDENTIFY
DEVICE word 56 to 1 through 255, so neither end is a translation a device
may accept. ATA-5 8.16.6 requires an unsupported one to be reported as an
aborted command: do that, leave the translation in effect alone, and
refuse the value rather than checking it at every use.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: qemu-stable@nongnu.org
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2399
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index fb9bf11b45..747fa71677 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1655,14 +1655,21 @@ static bool cmd_check_power_mode(IDEState *s, uint8_t cmd)
 /* INITIALIZE DEVICE PARAMETERS */
 static bool cmd_specify(IDEState *s, uint8_t cmd)
 {
-    if (s->blk && s->drive_kind != IDE_CD) {
-        s->heads = (s->select & (ATA_DEV_HS)) + 1;
-        s->sectors = s->nsector;
-        ide_bus_set_irq(s->bus);
-    } else {
+    if (!s->blk || s->drive_kind == IDE_CD) {
+        ide_abort_command(s);
+        return true;
+    }
+
+    /* ATA-2 D.2.8 limits IDENTIFY DEVICE word 56, and the count, to 1..255 */
+    if (s->nsector == 0 || s->nsector > 255) {
         ide_abort_command(s);
+        return true;
     }
 
+    s->heads = (s->select & (ATA_DEV_HS)) + 1;
+    s->sectors = s->nsector;
+    ide_bus_set_irq(s->bus);
+
     return true;
 }
 
-- 
2.53.0


