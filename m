Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4772C61CE3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWXz-0005cv-93; Mon, 24 Aug 2026 11:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXx-0005Zz-J1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:13 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXu-0007Cm-8U
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:13 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so6596788a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585109; x=1788189909; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fk7uubtzSeMFSEdxFQAVJoDUo/ET1OY4igZB2LIiDIM=;
 b=I0f1eib4qOtJSqp7XainhwAfcfiRjWIhqlNeSX/Viv+JIpQsx1OWa0LzHyfeovhSQS
 kOXsLIiZW7j2f0ewc7VKl3Kz6O1qAzGg0H48ry6Gf4cKCSoz/csRWYQCkkc7TlbBONcf
 ZYAepG1OQs1qXmYwMr2i7MVCurySeh4DXv/gfmyr7tI+znl3Fs50RpwS7lh4ZFDgre+h
 QgwbPjdd7hX43FtEg32Qh/ts5eR8RmKvPlyEFHsr8u1QSLi9/vp6cli8hDBg11tU/+mp
 U52+ITa9l2emUmDUrJgidNLnEDde14OyLXwEJ67rFjv/yNtf3HjpWAznL0U6FD9+vL2q
 xFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585109; x=1788189909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fk7uubtzSeMFSEdxFQAVJoDUo/ET1OY4igZB2LIiDIM=;
 b=TnH2hO3stHkWJfbVTGt5FTuaGOIP1b7A6WZLtFksbIjyEDz93Lm5arx3yD8ROacx+/
 nPxgf6TkF8cmkbSm+xnevxG7VGS2tf099xblY6FAtyfDWFZqpxOyDwDN3nix5r7O44Z2
 7vjBxZkuGHu4kopugve4w1xEKY5pk4Sl8JkGegD2LG6qZUfJDo07DROdoVQpzaXnSOQ7
 gB6e5mw4q0SkWuucHsBIU5kQRE7G0exf3FasDbc3pIvHyvafxfNERkciXZ/feN2sJYnm
 cQVW4FiBkBIGEZqisHDffb3fq81fNrUDyssi4LZkcAeOXk+bBXekLZL91jeNm0eb3WjT
 ErMQ==
X-Gm-Message-State: AFuF++nYM7qcTygkCc5RE2yMboD/vG70TmpVzHy4EKMGUzV2xlw7ooWX
 OxBZS7hCiutgmjusfbMaj8A3I4fUe+8mTw67dWZj7kOoF4JHhVzwqqLgTsoxhlNHjbw=
X-Gm-Gg: AR+sD11KiOpqqoyAXsg2neKNEpnVYelMh4FJjcN0oRBo2oz8DUfALawUGm2Wfc0N7ng
 N+/nOEewpqoX6Fn1hIf8AjPHcivQhEVM93t4qKYMxpVSC8bZ+IRzPpC3lGsl5nLWMRwGv5Q7K+X
 w9URJLa9wwi6B8k3Tv0OBBWjrRwjp2HFkM2AnWdWz9kxY4rSqb08ek2wHJ0jD2UPju044V6dNvE
 NiY8ttuYAq3HiL+T78VnWzWhbhE9Kp5/bPCmSC6duUQIPCrDpAXaGhezP5xhzDKxByVCnxlDf6K
 OLId3cLSkZDRNCyJnOsXiG7gP/FHPvj1OhEb1tmrlMnKj150nmDakaO+n5lc8tkzcmR6eaq/kvl
 GEWCSEKgrENn5ZUCiET+KZJH3m0YZSI3bodFOAXpFyRP2ZmP3WYn8dxRtW9ZVWMGxAiVP0ndZSr
 jJm1MnXcxJjTBAX51YoJTPkxGTqXDHwiQug4SE8pFHE05btcLf8GhCrnX2GqY6i1QKvFs8JGY=
X-Received: by 2002:a05:6402:5194:b0:6a0:8885:e6f0 with SMTP id
 4fb4d7f45d1cf-6a582b05208mr20853357a12.3.1787585108696; 
 Mon, 24 Aug 2026 08:25:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e0190d3sm8925819a12.9.2026.08.24.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:25:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 67F415FBD6;
 Mon, 24 Aug 2026 16:25:02 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 24 Aug 2026 16:24:52 +0100
Subject: [PATCH v2 5/8] hw/block: validate the fdc sector position fits
 within bounds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260824-fixes-for-11-2-v2-5-352c6b890402@linaro.org>
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
In-Reply-To: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4140;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=sswopZNOzgMSxJVdxe5RCz1lvwnKFsZ1cyXIF1SKEFY=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqjGJN+F0qlykLLME6nQbEm0pkTrfuGaWtoZvQJ
 fyhgmMbh4GJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoxiTQAKCRD70NsJWp4q
 RG9hB/0SkbGL7+5wJsXoKba+AlC+81HNfv36Mlo0M/4pvIULICfb4eM8re9m4u/tKYl9eccd5Wl
 TS1BoJxfgm/hTva7/FSKwD47nzQUgtkQwQxWDgiJokZouOiZW89Ob92S0l73HZalqwp75kNoWCP
 zmUwGli3/wa/9B/XbXaMRQ4K3+PEMMBrBQrk6vwFNWqRj0/3jzj7VowpuwovmxfgghuELOJdvv7
 tgk854dgWTMikJego2vTAHpElNVVsvjSD3dP2kiYGIVd6ie4PB3gmwqKPneypq04YzQfWHC9LQ8
 XmbwovKdVegMQwlaRwL+3hJb6PBB2fKvs12ji5tQNR6MceVb
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Previously the guest controlled the value of last_sec and wasn't
particularly careful to check it didn't exceed the media size. We
can't re-use drv->last_sec as that changes as we do operations so we
set media_last_sect when the geometry is probed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3800
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - checkpatch
  - move check in fdctrl_handle_format_track before we set data_state
---
 hw/block/fdc-internal.h |  1 +
 hw/block/fdc.c          | 30 ++++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
index e219623dc7a..3a39ac903c7 100644
--- a/hw/block/fdc-internal.h
+++ b/hw/block/fdc-internal.h
@@ -83,6 +83,7 @@ typedef struct FDrive {
     uint8_t max_track;        /* Nb of tracks           */
     uint16_t bps;             /* Bytes per sector       */
     uint8_t ro;               /* Is read-only           */
+    uint8_t media_last_sect;  /* Probed sector per track*/
     uint8_t media_changed;    /* Is media changed       */
     uint8_t media_rate;       /* Data rate of medium    */
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 1178b959a64..d20f749c1ab 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -192,6 +192,7 @@ static void fd_init(FDrive *drv)
     drv->max_track = 0;
     drv->ro = true;
     drv->media_changed = 1;
+    drv->media_last_sect = 0;
 }
 
 #define NUM_SIDES(drv) ((drv)->flags & FDISK_DBL_SIDES ? 2 : 1)
@@ -373,6 +374,7 @@ static int pick_geometry(FDrive *drv)
     }
     drv->max_track = parse->max_track;
     drv->last_sect = parse->last_sect;
+    drv->media_last_sect = parse->last_sect;
     drv->disk = parse->drive;
     drv->media_rate = parse->rate;
     return 0;
@@ -1905,6 +1907,17 @@ static void fdctrl_handle_partid(FDCtrl *fdctrl, int direction)
     fdctrl_to_result_phase(fdctrl, 1);
 }
 
+static bool fd_validate_last_sect(FDrive *drv, uint8_t new_last_sect_val)
+{
+    if (drv->media_validated && new_last_sect_val > drv->media_last_sect) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FDC: Guest attempted to set last_sect to %u, exceeding valid media max of %u\n",
+                      new_last_sect_val, drv->media_last_sect);
+        return false;
+    }
+    return true;
+}
+
 static void fdctrl_handle_restore(FDCtrl *fdctrl, int direction)
 {
     FDrive *cur_drv = get_cur_drv(fdctrl);
@@ -1919,6 +1932,10 @@ static void fdctrl_handle_restore(FDCtrl *fdctrl, int direction)
     /* timers */
     fdctrl->timer0 = fdctrl->fifo[7];
     fdctrl->timer1 = fdctrl->fifo[8];
+    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[9])) {
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
+        return;
+    }
     cur_drv->last_sect = fdctrl->fifo[9];
     fdctrl->lock = fdctrl->fifo[10] >> 7;
     cur_drv->perpendicular = (fdctrl->fifo[10] >> 2) & 0xF;
@@ -1976,6 +1993,12 @@ static void fdctrl_handle_format_track(FDCtrl *fdctrl, int direction)
 
     SET_CUR_DRV(fdctrl, fdctrl->fifo[1] & FD_DOR_SELMASK);
     cur_drv = get_cur_drv(fdctrl);
+
+    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[3])) {
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
+        return;
+    }
+
     fdctrl->data_state |= FD_STATE_FORMAT;
     if (fdctrl->fifo[0] & 0x80)
         fdctrl->data_state |= FD_STATE_MULTI;
@@ -1983,13 +2006,8 @@ static void fdctrl_handle_format_track(FDCtrl *fdctrl, int direction)
         fdctrl->data_state &= ~FD_STATE_MULTI;
     cur_drv->bps =
         fdctrl->fifo[2] > 7 ? 16384 : 128 << fdctrl->fifo[2];
-#if 0
-    cur_drv->last_sect =
-        cur_drv->flags & FDISK_DBL_SIDES ? fdctrl->fifo[3] :
-        fdctrl->fifo[3] / 2;
-#else
+
     cur_drv->last_sect = fdctrl->fifo[3];
-#endif
     /* TODO: implement format using DMA expected by the Bochs BIOS
      * and Linux fdformat (read 3 bytes per sector via DMA and fill
      * the sector with the specified fill byte

-- 
2.47.3


