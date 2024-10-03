Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CEBCF34BC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swR0g-0000ku-AP; Thu, 03 Oct 2024 14:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swR0f-0000kh-4V
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:57:09 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swR0d-0003IM-HU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:57:08 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5399041167cso2277800e87.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727981825; x=1728586625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QkDAThvHzn8nk+HGJi0H/5a08f7RDTFwzrMcXuWa4E=;
 b=blt0kg/ciKr3lHBLszQUlZKlcM+B0xX0jWfQLR0cieZsZ0F2MhD7opEqG/AtoGPGFI
 JbjIh1xNbo9i7jP8CPPB0u0weoBdskO+knIg+bcu30nNEkQ5lKpoaT5bW/yXek8UWAyM
 l8Bb3+F53c6W/sjcuaWZ1Tt/ZM/MurT7B3HxFT/5ABSzLidtLRhgTHEkCOYrBbk6Fotr
 r8w0iwGr+GywWY3IKhKf8Dre5cspjaspiDU84EEwQsyl/jbry/8IErxBU84OBgnwZLox
 8I7m7tcON2Pd93bGXu/zwN8Jdigl7tyoD7h5cQZZszsV58tkHEjQ9p8Kx0F9X8JMahYo
 BGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727981825; x=1728586625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QkDAThvHzn8nk+HGJi0H/5a08f7RDTFwzrMcXuWa4E=;
 b=gSw2BrS6r9mpJmOliTD7flauM7wu/ug9LakXQyY1b+csWPnb4vUbf5Lx3rl4+9mCm/
 TZYW6NhgXD+kJ0Lk1wpaBXAvA3NB/wzOn9oQc5idqFibSBnMCvMr8XE9V8oXMSTBMPSt
 Cu8EdS64BOi2qfEADU2+7sfdwIonn4+qNg5IaDW4gX38iRM3o/1TGWi0MmFXsc3myUdA
 XjJEYostKGAGws5QeFAcT15UuR+qKKpOmrHRqGaICYPE6PqdXyI/s3X2IKuUs3qUDFxz
 IvdMiB4G9WSN/VjZRWZTVAJLm7XM6ab/lSfHFPTutm6hzXxrqUT1H/gzCqC62BUaCPgj
 5UOw==
X-Gm-Message-State: AOJu0YzkM1bFGbulElJWC5kj/0We0yO7RPedB8No0B96hXNqThoU6dh8
 z+5Y0/i4cMM7UlZ6oi50MbrCu7YJ+riGEkC20znWrd5IJbPhWKHTaLrUUyUv
X-Google-Smtp-Source: AGHT+IH+YJp2VQbmukXoxo+KucnNQOI52hduggo5ZWOqudKcMJoLnpK4pu8dv199MzOrbVPSxfrmWw==
X-Received: by 2002:a05:6512:b29:b0:530:ab68:25c5 with SMTP id
 2adb3069b0e04-539ab84e022mr346818e87.2.1727981824696; 
 Thu, 03 Oct 2024 11:57:04 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539a82510b0sm239556e87.40.2024.10.03.11.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:57:03 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Anthony PERARD <anthony.perard@vates.tech>, Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL v2 1/5] hw/xen: Remove deadcode
Date: Thu,  3 Oct 2024 20:56:50 +0200
Message-ID: <20241003185655.1480819-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
References: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

xen_be_copy_grant_refs is unused since 2019's
  19f87870ba ("xen: remove the legacy 'xen_disk' backend")

xen_config_dev_console is unused since 2018's
  6d7c06c213 ("Remove broken Xen PV domain builder")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Acked-by: Anthony PERARD <anthony.perard@vates.tech>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-legacy-backend.c         | 18 ------------------
 hw/xen/xen_devconfig.c              |  8 --------
 include/hw/xen/xen-legacy-backend.h |  5 -----
 3 files changed, 31 deletions(-)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 5514184f9c..e8e1ee4f7d 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -147,24 +147,6 @@ void xen_be_unmap_grant_refs(struct XenLegacyDevice *xendev, void *ptr,
     }
 }
 
-int xen_be_copy_grant_refs(struct XenLegacyDevice *xendev,
-                           bool to_domain,
-                           XenGrantCopySegment segs[],
-                           unsigned int nr_segs)
-{
-    int rc;
-
-    assert(xendev->ops->flags & DEVOPS_FLAG_NEED_GNTDEV);
-
-    rc = qemu_xen_gnttab_grant_copy(xendev->gnttabdev, to_domain, xen_domid,
-                                    segs, nr_segs, NULL);
-    if (rc) {
-        xen_pv_printf(xendev, 0, "xengnttab_grant_copy failed: %s\n",
-                      strerror(-rc));
-    }
-    return rc;
-}
-
 /*
  * get xen backend device, allocate a new one if it doesn't exist.
  */
diff --git a/hw/xen/xen_devconfig.c b/hw/xen/xen_devconfig.c
index 2150869f60..45ae134b84 100644
--- a/hw/xen/xen_devconfig.c
+++ b/hw/xen/xen_devconfig.c
@@ -66,11 +66,3 @@ int xen_config_dev_vkbd(int vdev)
     xen_config_dev_dirs("vkbd", "vkbd", vdev, fe, be, sizeof(fe));
     return xen_config_dev_all(fe, be);
 }
-
-int xen_config_dev_console(int vdev)
-{
-    char fe[256], be[256];
-
-    xen_config_dev_dirs("console", "console", vdev, fe, be, sizeof(fe));
-    return xen_config_dev_all(fe, be);
-}
diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 943732b8d1..e198b120c5 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -50,10 +50,6 @@ void *xen_be_map_grant_refs(struct XenLegacyDevice *xendev, uint32_t *refs,
 void xen_be_unmap_grant_refs(struct XenLegacyDevice *xendev, void *ptr,
                              uint32_t *refs, unsigned int nr_refs);
 
-int xen_be_copy_grant_refs(struct XenLegacyDevice *xendev,
-                           bool to_domain, XenGrantCopySegment segs[],
-                           unsigned int nr_segs);
-
 static inline void *xen_be_map_grant_ref(struct XenLegacyDevice *xendev,
                                          uint32_t ref, int prot)
 {
@@ -70,6 +66,5 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
 void xen_config_cleanup(void);
 int xen_config_dev_vfb(int vdev, const char *type);
 int xen_config_dev_vkbd(int vdev);
-int xen_config_dev_console(int vdev);
 
 #endif /* HW_XEN_LEGACY_BACKEND_H */
-- 
2.43.0


