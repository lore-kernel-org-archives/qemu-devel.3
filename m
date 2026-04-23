Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DB9F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKk-00011D-N2; Thu, 23 Apr 2026 06:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJf-0000Ys-Ie
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJd-0005Lm-J5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUM7sRP+EF1GJe9I9RrbGzDUC5BjmqJIysVBw/wHvzM=;
 b=haEXb0k2T5vSbJTmILftLZWLNbe3UDWCZdIpcl1m24rllyw2D9ajU0bgAldl9VIiA7ggqK
 VIIKAXmpLz4phz2DGPe0Gj0TB77rlqlO5agxqB1gzk0iLDn+m1LU/naOI0QdTuIDSaEpiz
 7GZOrXCiENB6speUGiZwv1QderITyGk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Ntfa6YtCO_uDLK3b-rucUw-1; Thu, 23 Apr 2026 06:29:47 -0400
X-MC-Unique: Ntfa6YtCO_uDLK3b-rucUw-1
X-Mimecast-MFC-AGG-ID: Ntfa6YtCO_uDLK3b-rucUw_1776940186
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a55ecc249so21962925e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940184; x=1777544984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUM7sRP+EF1GJe9I9RrbGzDUC5BjmqJIysVBw/wHvzM=;
 b=OBLBnB6p8H7YaidS8klGAw2SC2Q22aZ1NaMUvKFYSXIdE4NQBahBzlQ0lhOrwp6ILb
 ZQ8dLNLnD30vM3yZY69bYkYCrY+zsf/38tIcTbzYgS6vgFl8OWf1lxuX1rShhxs4WTQo
 pJH9GPv1NyGFiOkxXqfUmsvXm+WuqUJWmUem2wQBcf4OytTZ6ZVRFwlhrZGfFKoFeHTb
 f1d5YH73p0x5+lOQpdK85czPuvcE5k1D5bwf6P7pX3ikNJTgtPfvNtsRpqu7xoZrWuc6
 CVbrx/PF9+UxfFaB+v99SP4BA+EOaZwVdPRx5MHL4ZmwKSjDRbwIsBnQTqqLjj0Vk9+y
 7kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940184; x=1777544984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EUM7sRP+EF1GJe9I9RrbGzDUC5BjmqJIysVBw/wHvzM=;
 b=dE6d5f2swKegRk12QURzgLYuC2Fv7CeopVnwO0pDSwVvc/sfuq9zO0LJlwrKXus7ks
 kUgN+3nNCSrelYJjcD5q4p9UwyMqhrpIu+WfFrNG9Hz1xjBnxKUxMUuC9frdIboPBUS1
 8oJmkrD2P/6AEVCbCvHZa4w6YCRC3wqJ+eXho8wsass4VS9Q74iOgRm5As6tIhOsB3i/
 lycF8dNcFRAu+95zeDrq/LgSWpx0OLKiTwYRMxZnl9DV6vBScHP+Ra0+9ANPKo4DUAf1
 IOgWJHzF+i6O6c65zovWSnz21bC7Jaw+T0wKuS9Kx99NKe7zh4H88bp4n0YbJJkqNVc+
 jCbg==
X-Gm-Message-State: AOJu0Yz+K0JaKbT12VKV15eSFiMYHtBM0hCqk8BVU5p0SBFe4bgZwkJN
 w0hH49/cO1KeVdJbed2ufxasQ5lfN6rEqPk3fxOGwtzkfUDOjeHIxGKfdngkDuhUHcVF2umGCHQ
 QmPS+hc+nuNHYze8Gyni2ICm96cxzfycNzrDaSmRBbwPAynyUDLGsFpKmYjd94PiVolLN7ERJqD
 X1xaAZNysZKK7MLlRSJN/PEnIPzJl3OFioo6EZf0MI
X-Gm-Gg: AeBDieu/i6Bmf230Kz6XOPuQ8FheBLMQLjxi2KjHgYnOJn4EmrfmDm5Dw7FDINg1tI9
 7pt4o+EsZd1JSHr95RN+tGJUlVDDYVKSJMg7DOFQ2behnmRpWvQDqcIZbwtfik9km8q57p4OQeG
 InJ7WM3yoIStgyG67lWe3o0u+qWALsVRW1d7cuto6RY1UUkF3o33+ADWxJ5VaHhXk36t4m+ov9/
 CA+WtByc2LfFDFL6U6jiU0V4qHBrRw3SR4wo0sl9fZFBlYY29HFAU74lgSqPXtIHNClFA+LBd4T
 wOsw4gaci0HmhJE4KomJ+GeblhljY6xJ6CxbrEQQzO04zvbk62IBeQnh93QbDS3hmfAAElgfVjT
 yDcwko8a7H4L4RoQYwxXlRGZ27wJ3Mc0+kyWRIq+yTStgxmcOosIxFBzbYAB8sRgjtfBODqeWb6
 nSfRQDDKG9LAHat4R5CmWaa5tC338bIjKmN68=
X-Received: by 2002:a05:600d:b:b0:48a:56de:d63c with SMTP id
 5b1f17b1804b1-48a56dedadfmr106686765e9.27.1776940184541; 
 Thu, 23 Apr 2026 03:29:44 -0700 (PDT)
X-Received: by 2002:a05:600d:b:b0:48a:56de:d63c with SMTP id
 5b1f17b1804b1-48a56dedadfmr106686525e9.27.1776940184009; 
 Thu, 23 Apr 2026 03:29:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm539944375e9.2.2026.04.23.03.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/25] target/sparc: Use glib2 instead of strcasecmp/strncasecmp
Date: Thu, 23 Apr 2026 12:29:05 +0200
Message-ID: <20260423102922.443639-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here
 (2) we want the comparison on boolean property value to be a plain
     ASCII one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-7-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/sparc/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1493336e7a2..77046104284 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -174,10 +174,10 @@ static void sparc_cpu_parse_features(const char *typename, char *features,
              * TODO: remove minus-override-plus semantics after
              *       warning for a few releases
              */
-            if (!strcasecmp(val, "on") ||
-                !strcasecmp(val, "off") ||
-                !strcasecmp(val, "true") ||
-                !strcasecmp(val, "false")) {
+            if (!g_ascii_strcasecmp(val, "on") ||
+                !g_ascii_strcasecmp(val, "off") ||
+                !g_ascii_strcasecmp(val, "true") ||
+                !g_ascii_strcasecmp(val, "false")) {
                 error_setg(errp, "Boolean properties in format %s=%s"
                                  " are not supported", name, val);
                 return;
-- 
2.53.0


