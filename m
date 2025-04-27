Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B547BC369DC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 23:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Axt-0006TH-Qf; Sun, 27 Apr 2025 18:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1u9Axs-0006QM-15; Sun, 27 Apr 2025 18:59:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1u9Axp-0007AJ-VP; Sun, 27 Apr 2025 18:59:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so4896478f8f.3; 
 Sun, 27 Apr 2025 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745794747; x=1746399547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgTtq3pHpaj7n78orlTAZ+jsq9yxJtDldmhOoqc2tZs=;
 b=Y0XXuznKivFso3NfLigZVY84W422JA9Eiu6WogfVu0FTN7XIam7HMwNgjtErjmggHS
 4XuwZNVuAj+yPO8qrj/rXBDmOcfPgkvMP3uObDitskW4gDf4KSCaPwZqIn1dR2xJBXEJ
 +6b4T2gufrpR3i53fPWA3cDgh/OpTN4EW+PjBfmla/5H2eB+ZJl8/TnDNHg4QkmIlGqP
 rqtdeJEu7aBtJYEzh0XdxqkEMfCOOCqNfy1nMqPSVO3OfCDKM1P0p7PDn05dmzwwaRj3
 ZEZ2prk2Z/4rIkNRsOXPgK8sRDa9lZeNba9i0c7Gwqdd4b/SJmhU+u4pOJEW6jfscPFm
 PdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745794747; x=1746399547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgTtq3pHpaj7n78orlTAZ+jsq9yxJtDldmhOoqc2tZs=;
 b=VG9n+CjZcq7ObeOtRICwAbV2hlecrzFuWDzUkdV8Zgu8j1fWvWIBWjpUHyvZat1fOP
 oJ3eefkXq3/GWYtV4FU8ZT/x+w4WxPLxp6Qt72D7vHx4nMOHo6jp6eLrR+R0nsZ1yOmt
 zIx3tRt/liOMrnSKG4tZDW2VQqumnZzwuUsff5l5P4F851wWc0/s7tg5BcKXnCRMdrDk
 E+2joEJUjzX3IzRk/4UfjdabyCZHq28gnpJxydV1/Q5sPr7zs8ADAagV7LBxKT5rvX/b
 nVi7Ac9u3zA9thaetPHNCGcN7UlNfMxaB76rDrKFR5jQE/VURj4M8wQTtZmSMe3bMMqd
 MEyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW2MMkbG1lYUfP35txWAWIv1ciGJrYBb5jbLPq+X1WOt8pVKH/OiaQmXyAbcwY+iLaQtw5us8Dtkck@nongnu.org
X-Gm-Message-State: AOJu0YxvQkvPe7a2M6ZD0TUMP/2HZUZkgJ6p5xefnOxM4Hw/xXgDZD+W
 TWs5vp/AM1WuuGaSvg53zXfkMOu1Z4OfVkloCasg0c62p9XFcAyb3JNNjYrQ
X-Gm-Gg: ASbGnctsnGU8s2OGTOEYIn/QqJ8vCivE9n41MCZqetJvAtfHpfbWltNYgFuLRtxRcMJ
 HnHXHJfquwlTQNqlAhLEZHieV7Z+qUvVmoqSFghrt2wMvDhoyTfsQCR5axg0jvMglWywUSAXDX0
 b9TDunDIF2jLwDKIf6xceRQcdhzWqQUGwbsQtMEJY9WlyqatrhTPL29swptSUSONc2ZjYn35Gk9
 pjFGx2kGcs2UWZ5l0a6sLNOH4KEkdRzlkB+SHF5SMYwN7AP5qteAeNDwbWDOjnKXi4W0RQe8FLp
 yClH7+6pZeetaJr5T0G26vPPDpbBUwN5I2rLNfBb8jtIOTeyJir1S01QIwd2GZ5/i4BGMpHT86y
 cw1Z/aioeL+kOfUnW5urfMMjjC+YN
X-Google-Smtp-Source: AGHT+IEc+nCVkp5ZU+1JUcEW70h2wTqtK2DjgoElMWgFwGC0VJZqg6Ed8iwRbHNn3kUgxiJ94c8QAA==
X-Received: by 2002:a5d:6483:0:b0:3a0:84a5:4067 with SMTP id
 ffacd0b85a97d-3a084a5428amr859977f8f.54.1745794746924; 
 Sun, 27 Apr 2025 15:59:06 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da4dsm9499765f8f.99.2025.04.27.15.59.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Apr 2025 15:59:06 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH 1/2] block/null: Report DATA if not reading zeroes
Date: Mon, 28 Apr 2025 01:58:59 +0300
Message-Id: <20250427225900.24316-2-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250427225900.24316-1-nirsof@gmail.com>
References: <20250427225900.24316-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

If read-zeroes is not set, we did not report BDRV_BLOCK_DATA or
BDRV_BLOCK_ZERO. This is not consistent with other drivers and can
confuse users or other programs:

    % qemu-img map --output json "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}"
    [{ "start": 0, "length": 1073741824, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]

    % qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}" &

    % nbdinfo --map nbd://127.0.0.1
             0  1073741824    1  hole

With this change we report DATA in this case:

    % ./qemu-img map --output json "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}"
    [{ "start": 0, "length": 1073741824, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0}]

    % ./qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}" &

    % nbdinfo --map nbd://127.0.0.1
             0  1073741824    0  data

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 block/null.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/null.c b/block/null.c
index dc0b1fdbd9..7ba87bd9a9 100644
--- a/block/null.c
+++ b/block/null.c
@@ -239,9 +239,7 @@ static int coroutine_fn null_co_block_status(BlockDriverState *bs,
     *map = offset;
     *file = bs;
 
-    if (s->read_zeroes) {
-        ret |= BDRV_BLOCK_ZERO;
-    }
+    ret |= s->read_zeroes ? BDRV_BLOCK_ZERO : BDRV_BLOCK_DATA;
     return ret;
 }
 
-- 
2.39.5 (Apple Git-154)


