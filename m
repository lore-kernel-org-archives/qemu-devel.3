Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D7CCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7te-0001bu-WC; Thu, 21 May 2026 14:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1wQ75M-00020V-QY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 13:21:28 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hemanshu.khilari.foss@gmail.com>)
 id 1wQ75L-0004HV-20
 for qemu-devel@nongnu.org; Thu, 21 May 2026 13:21:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2bcd730e090so50073895ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779384085; x=1779988885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0/vqKnfctXheLh+DrinGSmWd6L4vhZmexk0Jfbf0bNQ=;
 b=W5BbSfw/QCNZEhrxfo+kSfQR8jFQ/sFzJwRMFel41ioIE7hafrYukmuKxpDB9PT5Lo
 qBAwKWfUuGeNeTLeyiiRb9HgPzGJ3wAOeRxBpLIleFY4PA8vTOJoPE4m4l5TIAGAw2oE
 LuSp1KxQsqU9O/2htFxPtjnBUbnw52EO2qEfSaXpmOBICwcOmoGyw32asEzIh6T7HEKm
 bgmAyBhU9BaY9Zq8cwumUP+1ESg0/Yyi8MEkJXKlqXZE0C/sqTyVyaf2011jonL/eeln
 KdG8rA4Xx8EgMIDZltx/q5EkRU5ScqmpGBz1dfywaKfJAFKk96VmMDtt4dVeHLWUGEcq
 so5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779384085; x=1779988885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/vqKnfctXheLh+DrinGSmWd6L4vhZmexk0Jfbf0bNQ=;
 b=BUS/kS9V6SdqlbloQspHn7Grf6FF+3HbnHc8QMmkNmvxxGHMSQ+X7DeLfnh/yeBXGg
 Y4l4okj77gn+FUgr6EH/kbBalWqIuw0VDcLOrW/EWrh2F5vWoEW19iGv97tkm+kuoBOu
 NcnDRhlWl3fuaeGmbUhbPDWRqzDQgNeTSp/NV+GNU/SAFQCl8ZcsAWeYlocctO+7agne
 QTL4dWsX4kYKgBxSaoPJ1Hp0v1OUMC55DzH0nbHu55ydqU7SDFpxWuXZXq3Kbe30JgF2
 8Rf6rtZOzq9IkIfr5tM25B3zDgQF8jv7BknfQJtoQh+SUgWK8XjqEtW+CKLcLbDGt0tn
 yNIg==
X-Gm-Message-State: AOJu0YzdnQZSN+wwKTVO7n7o+iVIEKQVFmWj/IZZAyYGHYf0vQBds6pr
 Be2BrNRWyiWMe8JVMaapETGY3h53fgJ9o/n/ZEoeTnSajl4H5YGtiCgRWWMOIFvIm19GDl87
X-Gm-Gg: Acq92OHTWftzF7mGXYrjXMbBxm+RCI/R9iKlGC1GssS/zFxsdqQO+YISsvU4QnHyRm9
 fUjM5xBAOdefVZH7HkwM64I3vGOFbVybLKnYVk/6C4C1CWnOjq7WCY59xbHG0+gSyS4/Ktgwzb8
 WYoutqv2MgB9CrjWCgvmBfp+PRqEiruglWRhQ6YkjgnLc9FBrkp12z1MLZFfVr+4q4llTLLwMnA
 zrtgthLiH3wI1oaYM4rR+3TB/uQCLSk7KYh/FYjMEuirT/Sy2dmvwovf1Z/BSgyBIStFGNCOIgu
 BlUa9Q1z6lyln5tAYQGfMrRTwQB0giewJsrquz9yvw45OKx78hnfq4Y4pbUFriL1AeZqXrExWDV
 qb9ev4Tzr40PyaHVeHo9kst/TKh1sIdJIpwEBpyjw6OpI6VFeR6t8+k9t6ERN8kAxVnp7divWqz
 GafabdnBe016heqoF6xGVfquH8w6Pr+bKgJTaL
X-Received: by 2002:a17:902:f54d:b0:2bc:6784:5260 with SMTP id
 d9443c01a7336-2bea33ec741mr41266885ad.37.1779384085419; 
 Thu, 21 May 2026 10:21:25 -0700 (PDT)
Received: from fedora.. ([2405:201:3005:d220:a108:acea:3f09:6f0f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea992413csm16655575ad.67.2026.05.21.10.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 10:21:24 -0700 (PDT)
From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
To: qemu-devel@nongnu.org
Cc: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>, luc@lmichel.fr,
 hemanshu_dev@proton.me
Subject: [PATCH] hw/core/qdev-clock: Fix potential null pointer dereference
Date: Thu, 21 May 2026 22:50:33 +0530
Message-ID: <20260521172032.85047-2-hemanshu.khilari.foss@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=hemanshu.khilari.foss@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2026 14:13:25 -0400
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

qdev_get_clocklist function returns a pointer to the NamedClockList
struct. This function is called in qdev_alias_clock and the returned
pointer is immidiately dereferenced without a null check.

A null check is added after qdev_get_clocklist is called which prints an
error message and the function is aborted.

Cc: luc@lmichel.fr
Cc: hemanshu_dev@proton.me
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2342
Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
---
 hw/core/qdev-clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 6e2967e433..cf09f3d09e 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -157,6 +157,11 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
                         DeviceState *alias_dev, const char *alias_name)
 {
     NamedClockList *ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("Can not find clock-in '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     Clock *clk = ncl->clock;
 
     ncl = qdev_init_clocklist(alias_dev, alias_name, true, ncl->output, clk);
-- 
2.42.0


