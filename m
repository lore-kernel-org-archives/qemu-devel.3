Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB0FC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwcV8-0007pr-D8; Wed, 19 Aug 2026 05:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV6-0007ns-HG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV4-0001xJ-Ob
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso7810305e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787131341; x=1787736141; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4fCOt0OznbhBOvDSho9fI+DXpHx6dkj8m4gGLZPFe7g=;
 b=ar3Kc+vKHwcIJgmSs/pT/0rmrOfWyzaHrqsuQU6W+y6mecpBFcG1LakxneefacyV4W
 C50pF6eLJjUYu4/934zn0woZc8xgCsFEHbh5LbZKhnPX1h5/aRxM9hacinPdNL2u3uAf
 08KlD8luj1PXGybYOogM7D3qgbEk84PFlG3sw4mqJu++TpEH+6yWv+gzbydIHqTjAWst
 nhVQleMVf4pfGxOPDiL4wvFuYqA6b1sFUnnCcdMcNvEPa19pyyVAFUZgU0B7JESJy5yj
 1hp7x8u3rVuUvAzghGFBHgRzcrmFM3JcPlRJRKVOxW1cB2FNgcVH/SKJDv2qG2c9mfzd
 bLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787131341; x=1787736141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4fCOt0OznbhBOvDSho9fI+DXpHx6dkj8m4gGLZPFe7g=;
 b=fk0ueh3iu9b/8zLlsULJn0yN2SrDVqAyxSSQ3tIwSSp2tZ1IjjSuEYHuTL+RayLN73
 AeLIBpzDd3a92gXDCcMrkk/8xlhIfdxcs3zT0OVkGcT1Kf69sAeBrgrF2KYvls9qxhdS
 fwIm1+6OAa1CwTxy0Q12at3EWBYV7A836j3RLuST8Yd5CtzF5u3JNg3xWdjBe8i3rWvW
 s4QJq11gB+hRfmuf/BfwJ2YK0vMukRDUN2b1O2h2KKDOBS9OpglzaP7FegH/O3HdU2BG
 UqO8WSEOUJjIHFyvtCVl7wMd2vHLcJhwpS3Z6WGCtYRJDvxCmzoYQnXZNmQswATO3k9U
 CMdw==
X-Gm-Message-State: AOJu0Yzk0MWuqaUxeJNbnRM4rvuButju7XiAo8HojW9OJ41QCRU/WD9J
 YGXWoStnfoxxzuA2pED5tjw/dcY6+Gm4POaqdil0aaaUzt9XE+XaQWa7lbQWXqe8dc0=
X-Gm-Gg: AR+sD12HEu7XMuA3ADpnn4dnkcenfUP3oHApTSnVIR8RFhwpk2BDoCaQWj+rtQcPRz0
 3VYuPf1RbK45YfXL2Es6MoMo9sDAHNvZlHux+5FzyAZMHMv7MnAI4/jdKbiRD5oyvP9n2oWU1pE
 aXJ6kroFV27GdKcG0t5EbDJRN/t5aEkBvdFe6TxOeC0KYylZ08obD0aUegW5Z6Bkw2nBIUkVweN
 uSBFNtzr7p5T0fXqubR3lAbeLwYgxNLegCdYglUCRff3jved00xJbtMp0KJ78fTSsyyEJC26izl
 lMYn2h4H9Oelm6o2jBNU/I7MvnuWCyDqf/CVtwI1JMVygkCtDMRNSxW+eaeOy85R2OX7oP5H4U1
 gjMBfBbFom7hrWPK0QsBaBF0P9QgJvUOLDg8zDmtzlSLWGDo/FwmSySh8FdQbgXkvFvysUJqW0C
 qQQE04km+WKuACOm+WOYkcZdnXSZBd5hVOxMZ1GxbKJpWgnyOgBxqqPnEw/Vm/
X-Received: by 2002:a05:600c:3f0b:b0:495:4491:b8c2 with SMTP id
 5b1f17b1804b1-499aa14b191mr63229715e9.3.1787131341079; 
 Wed, 19 Aug 2026 02:22:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111a7sm48838695e9.6.2026.08.19.02.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:22:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AC3F5F951;
 Wed, 19 Aug 2026 10:22:14 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 19 Aug 2026 10:22:05 +0100
Subject: [PATCH 5/6] hw/block: validate the fdc sector position fits within
 bounds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-fixes-for-11-2-v1-5-b7981c2cc371@linaro.org>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
In-Reply-To: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
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
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3740;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=OEX2z9GvvKbNe5gsvOGBjrtH21eDSoBa+jvNaK6zjWc=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqhXXGNAi9uavy3WXrBtrOwQIiWOo6yYdUrRrxr
 QU1tJkP13SJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoV1xgAKCRD70NsJWp4q
 REzDB/4pLaXN3OGb2+yQgYXx7wM53dI6ydkRkDkAQEdFHU5Zv6CWLVjU/pBWTbwvW3GO84qrqnh
 +9tNUGxXqvUiYHEfU6Fb5e+OWFLsJlFZQuODLpKN6IlwrltUh1MMVnJ7LHwchbegwVae4kW5ycQ
 w1xm1vzivm3xLGZ28QjV7XfJJVzrQo7HFxNSBItbB7w+S1+1fFnICFBHwEiA2qKGT2j7nLcmgUf
 oVYuICmEwwSHCdMuMMx1TMyVIAXX1/bCVI6B/XYicmTHRbZyqWag/D3DYIwftpcWEzMEayRM0UD
 uIgZ4L0hPlBynxF+Xt+ITJ0yE/bxT9Kx2XQ5DAM0CwPlQjng
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
---
 hw/block/fdc-internal.h |  1 +
 hw/block/fdc.c          | 28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

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
index 1178b959a64..18a61f5ce87 100644
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
@@ -1983,13 +2000,12 @@ static void fdctrl_handle_format_track(FDCtrl *fdctrl, int direction)
         fdctrl->data_state &= ~FD_STATE_MULTI;
     cur_drv->bps =
         fdctrl->fifo[2] > 7 ? 16384 : 128 << fdctrl->fifo[2];
-#if 0
-    cur_drv->last_sect =
-        cur_drv->flags & FDISK_DBL_SIDES ? fdctrl->fifo[3] :
-        fdctrl->fifo[3] / 2;
-#else
+
+    if (!fd_validate_last_sect(cur_drv, fdctrl->fifo[3])) {
+        fdctrl_stop_transfer(fdctrl, FD_SR0_ABNTERM, FD_SR1_EC, 0x00);
+        return;
+    }
     cur_drv->last_sect = fdctrl->fifo[3];
-#endif
     /* TODO: implement format using DMA expected by the Bochs BIOS
      * and Linux fdformat (read 3 bytes per sector via DMA and fill
      * the sector with the specified fill byte

-- 
2.47.3


