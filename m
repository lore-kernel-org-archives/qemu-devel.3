Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6194FFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6X-0004sc-4Y; Thu, 30 Apr 2026 13:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6V-0004nG-JF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6T-0004Qu-Lk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+j0fl0DNtcWoFMMUu4/jC4alYmSV0o7g9FyZIwu1dMs=;
 b=fkBGuMYXLmN/KCaEoxlYwx0Q7LYID5pCkimb+Gz/ocCz/g/u2LyT/+g01z/f0h5tcanFbA
 0pSsXyBQM+i8AtXueRbRvsl9hEcvurEnWGDmKYYK2WKeVQQuwwKlPFDW/4J96LfVx+0DbY
 lPkXeqOgPnTJ68S5hD20nDUU6vT69Wc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-NXr-__kOPzaUjF7ZpEqmeA-1; Thu, 30 Apr 2026 13:23:07 -0400
X-MC-Unique: NXr-__kOPzaUjF7ZpEqmeA-1
X-Mimecast-MFC-AGG-ID: NXr-__kOPzaUjF7ZpEqmeA_1777569787
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b49260e3d5so18117406d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569786; x=1778174586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+j0fl0DNtcWoFMMUu4/jC4alYmSV0o7g9FyZIwu1dMs=;
 b=n/gLD4fH4M/eoplLJ+ta5nF7YhlRlK5Mo7p1aoHFISxLj06jQ+tSwkpSAXD1apZ3dl
 C4K02Zgj3vFDeaX4qaBt7uwO1vRBjONa/Qmaj3sojWUJBcwSLqPlV0q5X2psZYGk6cNI
 IIMFrvnoig5XZMkr89vAPy5aZ/NhvCuLgU8TshCC831H6iOn/EuEM0mCc2O9ceC/tal3
 LbJsvl8cI2GqPyqHeZbxNO1Ey2E6l4m11HQ+HqyjeOeD2S14oL8lh+h9rW98mRhQ+lwp
 upVeWDavTSBrz/QaMbZGIhZBj6gf7o5ZQ4GZDS/ink0IB0aAq/LuXsnf8j8n8JRO9j/7
 C5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569786; x=1778174586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+j0fl0DNtcWoFMMUu4/jC4alYmSV0o7g9FyZIwu1dMs=;
 b=sbZrBLSfDUrb7AbngSZwLiOHsj2oc/5IhsfJJfFq7H0i/JxPt/MYXx0Tjx5nSHILtu
 qbcU+d19LOhaqb20pJREGPMNUIcHmXudW9UXVX3RR2UcdnkN2OXyFKGn7NJFeynmoZX6
 ZGLCRonI9pDvRUkMGI8xEpQm7PYJfIBKM3vIGebtRJ5N1SCpJTR0y8yfFzFfJ8H4oC0h
 v4tQOPpXk9w4W25WYPYMkgAU4rYx38VBWZh6I5Ppz9BoPiTP+uMrL6JBfYsazj1SBUsP
 JwgSw6xp9cmwlNKTx9P0iMR4zXoe/O4HpjH/aKQVyxtkmNwjfnIkVlZoEIVwoWxgZ4Uk
 45LA==
X-Gm-Message-State: AOJu0Yz/bX1kmACAzdNwQhGGuUjckiBuy8IjPvP6GgxcvDCrlSKbON63
 UMBA7vGEDuWkTlF0zlOUwUGRb8BWByjAd7ClR4quTTH6lWuxaA7T85ujWWMfdCbCr2o9fxUvrK2
 VlXvN6AxVz7cmCTnWQi8A+9+rcwK+ePxCqzcHD2kcKUNTQSfGbfn2yaiLs9mbxw3+o9rZtj1Y6P
 83jQ2dyXr9nlVMoosX8b5UjwmYsIwQcXd5T776KjJ9
X-Gm-Gg: AeBDietEQ20J9EbiPT3UbjFGxUlV+gr4m6o8jqQbuFok+HiJ4wBpaT9Z4Zf3XSuHUSf
 ROvJejfzjny/fhJI6LiA0aAIFpX5eS3jQWqhyWkVNlBIiwii341Wv2MnJi2ktTghy+7NsZ+gPKq
 aWBCChXaXUT+mYzW8XNtSUN5ikvEoMWlV078Ebkz2uh6yjcskFBONxi2wz5qNTm/y9HydlCnSk4
 JyQvbK2/pv2Bd4VNwbhnpdzg+oSUu0zGJKa+TZzuLr/AUKNOZwVKvDFMo2Srj/nfZqPgSQONlAU
 +585yUAiQyQOwDdh4h5g0IiqrR2d5VxAJYr+Tv8bmOViBtFVpGUeCwDN6oAVYnpZQjTs9h2gpUR
 c/29NROfe7pVAV2wmTuD+8Dheayo6DelqKIMOfpC3daRmnh0L1lff0FrENN7CUs1Bv6x5JbNsmK
 jZ2bjLY2QjJ1yG77XH9kkXTqqgkuZT6Kc1a5c=
X-Received: by 2002:a05:6214:4699:b0:8b1:f5da:f811 with SMTP id
 6a1803df08f44-8b3fe808413mr62036386d6.48.1777569786153; 
 Thu, 30 Apr 2026 10:23:06 -0700 (PDT)
X-Received: by 2002:a05:6214:4699:b0:8b1:f5da:f811 with SMTP id
 6a1803df08f44-8b3fe808413mr62035586d6.48.1777569785340; 
 Thu, 30 Apr 2026 10:23:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff439c2csm22584136d6.23.2026.04.30.10.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Ratti <alessandro@0x65c.net>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 18/58] hw/qdev: Clarify fallback order in
 qdev_get_printable_name()
Date: Thu, 30 Apr 2026 19:21:24 +0200
Message-ID: <20260430172204.1006673-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alessandro Ratti <alessandro@0x65c.net>

Replace the uninformative "<unknown device>" final fallback with the
canonical QOM path (e.g. /machine/peripheral-anon/device[0]).

Also clean up comments to accurately describe qdev_get_dev_path()
behavior, drop an unnecessary comment on the dev->id check, and rename
the @vdev parameter to @dev for consistency with surrounding code.

Update the doc comment in qdev.h to reflect the new fallback chain.

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20260321100405.1525059-2-alessandro@0x65c.net
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/qdev.h |  8 +++-----
 hw/core/qdev.c         | 26 +++++++-------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 337d69ea2c3..226bd662901 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1067,11 +1067,9 @@ char *qdev_get_dev_path(DeviceState *dev);
  * user-facing error messages. The function will never return NULL,
  * so the name can be used without further checking or fallbacks.
  *
- * If the device has an explicitly set ID (e.g. by the user on the
- * command line via "-device thisdev,id=myid") this is preferred.
- * Otherwise we try the canonical QOM device path (which will be
- * the PCI ID for PCI devices, for example). If all else fails
- * we will return the placeholder "<unknown device">.
+ * Return the device's ID if it has one.  Else, return the path of a
+ * device on its bus if it has one.  Else return its canonical QOM
+ * path.
  */
 const char *qdev_get_printable_name(DeviceState *dev);
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index b36101f3a75..78156185d57 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -412,33 +412,21 @@ char *qdev_get_dev_path(DeviceState *dev)
     return NULL;
 }
 
-const char *qdev_get_printable_name(DeviceState *vdev)
+const char *qdev_get_printable_name(DeviceState *dev)
 {
-    /*
-     * Return device ID if explicity set
-     * (e.g. -device virtio-blk-pci,id=foo)
-     * This allows users to correlate errors with their custom device
-     * names.
-     */
-    if (vdev->id) {
-        return g_strdup(vdev->id);
+    if (dev->id) {
+        return g_strdup(dev->id);
     }
     /*
-     * Fall back to the canonical QOM device path (eg. ID for PCI
-     * devices).
-     * This ensures the device is still uniquely and meaningfully
-     * identified.
+     * Fall back to a bus-specific device path, if the bus
+     * provides one (e.g. PCI address "0000:00:04.0").
      */
-    const char *path = qdev_get_dev_path(vdev);
+    const char *path = qdev_get_dev_path(dev);
     if (path) {
         return path;
     }
 
-    /*
-     * Final fallback: if all else fails, return a placeholder string.
-     * This ensures the error message always contains a valid string.
-     */
-    return g_strdup("<unknown device>");
+    return object_get_canonical_path(OBJECT(dev));
 }
 
 void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
-- 
2.54.0


