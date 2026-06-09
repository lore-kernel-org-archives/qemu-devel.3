Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72591CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0Cx-0007b7-Kj; Tue, 09 Jun 2026 13:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Ch-0007Nr-Fq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wX0Cd-0001qH-CS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781025924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTdK9UhiIM0qRwABF6UWGsM5x1elL2UrbbjIZlAcG7s=;
 b=DUsTE6YaEfAbqQmf4AwHlxPwL5AKx9QNIGqNmqiERrq2Pl1eg3PGzdDe55slE7B4cB476c
 ngQMwoomvfEk8RJ3vqiIvPIqcC2VvOQxemHUzOykTHrcaMM4yaGixiF72uZ1cp/YUEUYwb
 PIOy3SgYrAM591Ybb/X2KH0su5XaImU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-N3zhHAT1PDKwOu4b-PNZng-1; Tue, 09 Jun 2026 13:25:22 -0400
X-MC-Unique: N3zhHAT1PDKwOu4b-PNZng-1
X-Mimecast-MFC-AGG-ID: N3zhHAT1PDKwOu4b-PNZng_1781025922
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5179e5ba14cso63547581cf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781025922; x=1781630722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTdK9UhiIM0qRwABF6UWGsM5x1elL2UrbbjIZlAcG7s=;
 b=TktzWdHStHpw3i/M2RE3EtWX7Hd1r5VHiWRmq9fBniVILeIADPFthfxTvtBSyjzUkv
 8GJiR8Ox/CIN0aUgRC8UJEywoskB0mpsCxVd8XgaJJIDxbXKpapyhyHe+He6qL94AsIL
 7GE8LxFsGy2MgJbSaFSzxc7kx/Wn0UdBl3KUMEg5BIuE24XfzPQBAyiXYKQc+4VL2uwp
 pmSNLAl84wSrFbV3r03WtoPLbPOYMkZICW00ENuPLeNSwKJvimLZRGgTwFQ5gpDwksmQ
 S5fiXcDpMaY7mvLoEeUkMjwcZWhNAlD4Z3SrtWXW0KbAE1qrWaMK32moSqg60PrBLWaa
 MVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025922; x=1781630722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RTdK9UhiIM0qRwABF6UWGsM5x1elL2UrbbjIZlAcG7s=;
 b=XKI4Zks2X0GfT2tNrdcLC/bbqSHX3EX/SLpHkX67rMGtAIiqvf+UxDSpO66rqi8Deb
 uctKhM0qIFizF8F+WqHrfiqgr/onWUl72KsY73m5TF+0eP5rhRe58xtBGGBaYyz5Hwpq
 0CoY6RAohx67B1n+gbWxwwaJ57LI2/bo1IUBTt4EojlfA333OPXtW8i+2yss7Lx6LS+U
 OPgl7e1Vf0Skf63dXbKGIPuTxn2J8JiykStjuCh77qNs5Y3g75mlOcG6cq+0DArmzPW3
 +o0t8DHM26GavVAehPj3WflsjGgz/t7OGJ0315b0I5S0+nsGv1aof2nASJdxP/IoIz2R
 t8bg==
X-Gm-Message-State: AOJu0YwDF4NgFZh+v65FGkEYGTxXk1ml2o7jEU/X866T7m1wbItJ1ba0
 cXj3IzQMQgkdYAMo4G/sRIYM73uTGMG+GXevnEF8IRuMo3EKxlSA8S6Quq8uFXx5QNmCQGdeK0d
 GbrcyoaBMxpvUW0X1EtnK9CvjELQ6CvWv2NgnSq/HVqJipAwdqaDhLUGkQX4nLfkPH63W6+/An5
 WoYR1mDi/spM3o86mpCXi3vGCY+0jIl8xda6l+5w==
X-Gm-Gg: Acq92OHKBzAOiAOEHP5VLkOCR5OoOamSXLZqpCtgP1jFtS6TLPtpkTrf079L/O3ZkmP
 pDLSoQNgGWyI7HNToW7Ppa8jEaongH6IQrZVLuf6tS0lfYovLmNFhDAofxghhW3qjYNDKtU/DUv
 q4Iz3sXiW+nbxYYBJC4iPAqolujuCeoshTej9AA4DyTTLJxmjmyekuLX6bliRBLt7aqFEwBk9Ki
 g5IPY1GVYMuegv27mpBybxjbQ5RrRaFERUTpByENejU82up5XaKDgvKbsefPEt+aw5jmbLHg9lq
 Q/52c8cydcuf+0UXHeZOqGCT24fPxesDsCgo/pWKLavwBx+3ECbRZXAguD32+/gum0UJGsBTbaa
 oL6wODhR9hDKYEuvIN1xKKrQ=
X-Received: by 2002:a05:622a:1b09:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-51795c5be37mr317023091cf.44.1781025922107; 
 Tue, 09 Jun 2026 10:25:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1b09:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-51795c5be37mr317022371cf.44.1781025921523; 
 Tue, 09 Jun 2026 10:25:21 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775da2c56sm187524711cf.21.2026.06.09.10.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 10:25:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v2 02/10] qdev: Export global_props()
Date: Tue,  9 Jun 2026 13:25:06 -0400
Message-ID: <20260609172514.2037645-3-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609172514.2037645-1-peterx@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Make it accessible from outside (to apply -global properties).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/core/qdev-properties.h | 2 ++
 hw/core/qdev-properties.c         | 2 +-
 rust/bindings/hwcore-sys/lib.rs   | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index eba5436e53..248bbcbba7 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -321,4 +321,6 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
                                              const char *name,
                                              Object *val, Error **errp);
 
+GPtrArray *global_props(void);
+
 #endif
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 34d7b26a73..1d531189ec 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -958,7 +958,7 @@ void qlist_append_link(QList *qlist, Object *obj)
     qlist_append_str(qlist, path);
 }
 
-static GPtrArray *global_props(void)
+GPtrArray *global_props(void)
 {
     static GPtrArray *gp;
 
diff --git a/rust/bindings/hwcore-sys/lib.rs b/rust/bindings/hwcore-sys/lib.rs
index 8cef4a7961..85e71f5145 100644
--- a/rust/bindings/hwcore-sys/lib.rs
+++ b/rust/bindings/hwcore-sys/lib.rs
@@ -20,7 +20,7 @@
 
 use chardev_sys::Chardev;
 use common::Zeroable;
-use glib_sys::GSList;
+use glib_sys::{GPtrArray, GSList};
 use migration_sys::VMStateDescription;
 use qom_sys::{
     InterfaceClass, Object, ObjectClass, ObjectProperty, ObjectPropertyAccessor,
-- 
2.53.0


