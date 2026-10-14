Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392CFCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvOo-0006FT-B9; Wed, 14 Oct 2026 05:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvNg-0005Vm-0D
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:43 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvNc-0000fv-Hy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:39 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-15943c9c005so1160773c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970475; x=1792575275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IAa9EYHeaBZV1We1wS0Pw4Gbkg3A4EQ75sck0EgY0ZI=;
 b=LbmZWUAIbHt3z2zBA75HKVQQGMDF8haaEm9QDZZV0AHaLV19EZYJPWPpBJyurG5+O2
 naD2JSuweR9TaVypEddIlF45hTifdeTRP8tD8qzRiRHornQt/Wk0INl3ZkxUxmKQLNEM
 YLuqGIR4VR7s+EfbEJwxz8SO6Z0KIVA5jiaSkllcsQ76GzY14DHu3vnu6/WmIEbm6WsN
 BDXrJuDovWFr4Aq6tk0j2om/pXBjEDXXilvd+wMkJpjIIAh4PDOArYBvFWT9CIej8MgD
 2nDQJ+IxB1pRSrj5dWIoaTGXuqFfDW7vD8A/TeEH2D1I5BsJcBEL7GPmXhKRx0/V26CI
 8qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970475; x=1792575275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IAa9EYHeaBZV1We1wS0Pw4Gbkg3A4EQ75sck0EgY0ZI=;
 b=BocFJnMCPGRYSjv7X9u1DS+u/xiG9VogBMZZYgzUGirjXYCxYEdz+BT16A0+ZUrk9T
 RY0QPOUfn2QMsHn10GidqjCNyM/y/rXcYLakO6XgS+AWakq9QCvgwGwRlutYoc/O7fMI
 rbfbuFSowgPYXhvnfSEBep/CqIl89jCk3Cqwh4m1rfXa0qJxQbb+5rEtx+yIlJOXLaU0
 ujR7DrvthiYU3ThZR53O0bMu8qdaQIhU8PWERkwLJhU3DvaP6VgH1Jl301uXlyIlbEhM
 CHCEh+8kI9Dj0SqJEuP6Dj5ZNKe3opuPw9ALF3jecdIPB0zwFLEZQCf97l4ub/3IkQwC
 edSQ==
X-Gm-Message-State: AFq9FYKzfzKVKfkPuz6TpuFBdJ0da7CTytvWTpamLTybyGvc36sv+am0
 4H3AHfW8QRaSKtLd/T2opeDjO3AkfHdgP5pBR0bM7WdxL0WJZYhTb9tMCEoktIX4WDo=
X-Gm-Gg: AYBFou3sTgaUDnRUcM2fH02uYrIXdh22z+w2LZT0M8PfRQnHeWcXEB6FOGI8BcRzzqp
 BpyR9e5ccF2iAL5A+cZlJIu1rPV1e+sJOKKVnI+F1pWzgrnTgVxYXqtRviQhdhRefIAByI2mf9Y
 Kpl+6YB0KL1CN+R0/mjhqGf39lS7e5BgIzCaq94APz+kqdl+cVvB2pHin6rC5NZiqExDFPWSLEz
 tG1u2syBtnCIPov6IfrWyG7TFmqyxM6JOOu1tHthH/w/2aIcILNX1vBNpHZkkEuJl2IZhiYb4RI
 +onb7S/aZmVTB3rOe1HX1XgxuQNA50etJQ2lxUUCek4AGCp+ADIsWbUO6czWbKADHMhfZ/oFtLf
 E7NhDsx3xY2+35FYAXVukXegc/wDKwuY66cCLYeWHAO0AH+JPQizE+hcSd3Bl1oaTIWwLetjPr2
 e8mUB7va+3VsjnwUJUQxncyBoDwWsXldPgkBjYz342XcsE5aBaAeiI3YgMK+4U8yEKuU8KmUtV4
 eWDfBtWB5nbPi0bfg==
X-Received: by 2002:a05:701b:2713:b0:168:6ad8:e8b0 with SMTP id
 a92af1059eb24-16a6187f095mr23324103c88.14.1791970474962; 
 Wed, 14 Oct 2026 02:34:34 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:34:33 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 15/34] hw/scsi: Avoid guard loadparm with target_s390x() for
 s390x in class_init
Date: Wed, 14 Oct 2026 17:31:25 +0800
Message-ID: <20261014093152.834-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This is for avoid call target_info() in class_init.
Now we directly guard in scsi_property_set_loadparm instead.
Don't know if its an API break, but the smallest change.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/scsi/scsi-disk.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index deb33ac1dda..276941ae537 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3179,6 +3179,11 @@ static void scsi_property_set_loadparm(Object *obj, const char *value,
 {
     void *lp_str;
 
+    if (!target_s390x()) {
+        error_setg(errp, "'loadparm' is only supported on s390x");
+        return;
+    }
+
     if (object_property_get_int(obj, "bootindex", NULL) < 0) {
         error_setg(errp, "'loadparm' is only valid for boot devices");
         return;
@@ -3196,14 +3201,11 @@ static void scsi_property_add_specifics(DeviceClass *dc)
 {
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
-        object_class_property_add_str(oc, "loadparm",
-                                      scsi_property_get_loadparm,
-                                      scsi_property_set_loadparm);
-        object_class_property_set_description(oc, "loadparm",
-                                              "load parameter (s390x only)");
-    }
+    object_class_property_add_str(oc, "loadparm",
+                                  scsi_property_get_loadparm,
+                                  scsi_property_set_loadparm);
+    object_class_property_set_description(oc, "loadparm",
+                                          "load parameter (s390x only)");
 }
 
 static void scsi_disk_base_class_initfn(ObjectClass *klass, const void *data)
-- 
2.55.0.windows.3


