Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B251D3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0ak-0006Q3-70; Tue, 09 Dec 2025 11:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aO-0006CN-Rf
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aM-0001x4-DW
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIQ143FbwuvcuWa9O2RT8KNnC8vD3kmyJI+eFT9f6MY=;
 b=VPM8WMeR+TnCI6X7D1hOiPvMEVQxeARGDxVn91VIwsAPWEQX11x3KcDk81EPiSR2KyDe0P
 QbQpFUddWvnznZItisMzwiebpvrpqGVZDAKS8PCgYJ4DvR3zIXd2V4n3Wlbuv0YXb1PID/
 l2KrWA0x+a8n72DfIvUW35kdWz0l6bw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-M-hdzgjEP3aISRVi3E5mKQ-1; Tue, 09 Dec 2025 11:29:05 -0500
X-MC-Unique: M-hdzgjEP3aISRVi3E5mKQ-1
X-Mimecast-MFC-AGG-ID: M-hdzgjEP3aISRVi3E5mKQ_1765297745
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8823a371984so78086756d6.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297744; x=1765902544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIQ143FbwuvcuWa9O2RT8KNnC8vD3kmyJI+eFT9f6MY=;
 b=Q++fCxft5WV/445Y89SNgIKCF65nD5pjQ8YhYLRzjdY6Q1+2XyO1ueKUzGHPqDNtjc
 avinT7MSKkLIfhub+FDu5iYZoAZUOKuZtlucyAuonCq2yySnrtdLvm2Sf9B50gFv+Orv
 SJl35vsqvaCNepoa+50+ZGMbnKTHN5ES9FelIP8nJcEmKv0PDoK6nX6kE/f1gGRWWmyx
 nmu/urCZB8a4EKC5xsPZyoXXxA46TxdQsYXR1OPF9zSZFwd+InzbEXYc5z1jIHOG7Z7E
 Jj0UyLdMskK0OiojuBi8+UmIqugknZgvLB4O/ZzxROH/4DjsoQyUBP/0gSjKeC2G33iz
 ld2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297744; x=1765902544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xIQ143FbwuvcuWa9O2RT8KNnC8vD3kmyJI+eFT9f6MY=;
 b=T5PwSSAQgXhA6ydOuewdXyW1y2GLkqNJldcCohES2OKIV7voHBx09clznEe7SquH+e
 1bWp3x/IpL3I+PGe+kkPmT8NEfWiPM6UCuZ3hEGGUEdN8v+kqG6tIE0L1TcwU9wHsZRr
 rNlmWk6E25Arfzz1Cd/Uyec39PZphq4agTQY0MAV801f0lG4KfDEL5H89m1/+d1WcxZ8
 ZhdRQd2nUSc0ASfo16Y+lE0R7PFAi2QuIDM3jvtcuZYKYHmA8U6++v1wNY1q6fJnQ6wa
 gnNyxWL7MrihKjj/gZVY9NhXMDzQC4ZuTMVJfj7gsyUfPK4YSSU1ECT/PnF0PQ2u8ABB
 KG2A==
X-Gm-Message-State: AOJu0YyBd6gn7jP8iMinNbT4R4g+0QScbjNuu7/V52SShPAj0B4mP73L
 GRzfVPOeOndPM3GL5caPaxZ58FJPiVA1bblUgSf4CIUPrb+EWOqLS+I5qAJmjK3w8QsPvidbydq
 pgspWM1TbpO24Gpf49EawfZo7jr47EUHx91bxaz9fIHhUSd3ZEkvR3fEOFoE7doTM0OHF4hmHUT
 jgKTJDqyULKnjgNMERKVgqedhaO8zM3AU0Rc/IjA==
X-Gm-Gg: AY/fxX6+QDKvSYMpgkf5YyDTzDFY7rK3+qlwW7EKZlR016U52RleWhDyVoHKDvZU27f
 LOqFPy0vznotvGPtibyBrx16TvlyudS0WoT+hRrDGwCsc9uEcEFPJT9heIHkNMlS+GiSBH+nywn
 rA5Mibxpt1COr+XffvFW/iCKVM15OsKiXYWayBvFjTTiXz6TAeYkXN7n14LvASxu2cuHIecvBod
 wWYSFJ3w2eaU1jE86vnYbLhDzgfVCDRb2fG75dU6To4QVwnnqjmZTbcaq2cIYLYGHHKsnmSnAjE
 VkliQNvYQP8G4XQUPWURuM6xUzpXA1RhB91CQ5sjh6jdKwcBRY0FeWdmv1P9zWkM8dJApj7linH
 Nxec=
X-Received: by 2002:a05:6214:4119:b0:880:4f33:4666 with SMTP id
 6a1803df08f44-8883dae5d00mr172820876d6.20.1765297744302; 
 Tue, 09 Dec 2025 08:29:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyDoiyuziqrhqSQ8H6pE/cr/EpFgrlaMjzgafAwPjBOpswpL5xTKmO34VP7kqVT7F+Lg69LQ==
X-Received: by 2002:a05:6214:4119:b0:880:4f33:4666 with SMTP id
 6a1803df08f44-8883dae5d00mr172820056d6.20.1765297743660; 
 Tue, 09 Dec 2025 08:29:03 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 02/10] qdev: Inherit from TYPE_OBJECT_COMPAT
Date: Tue,  9 Dec 2025 11:28:49 -0500
Message-ID: <20251209162857.857593-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make qdev inherit from TYPE_OBJECT_COMPAT, so it's own instance_post_init()
only needs to apply the global properties instead.  Order kept because we
run post hooks in parents then children.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index fab42a7270..49504ff05a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -683,9 +683,9 @@ static void device_post_init(Object *obj)
 {
     /*
      * Note: ordered so that the user's global properties take
-     * precedence.
+     * precedence over compat properties.  Compat-properties will be
+     * applied first in the parent class (TYPE_OBJECT_COMPAT).
      */
-    object_apply_compat_props(obj);
     qdev_prop_set_globals(DEVICE(obj));
 }
 
@@ -890,7 +890,7 @@ void phase_advance(MachineInitPhase phase)
 
 static const TypeInfo device_type_info = {
     .name = TYPE_DEVICE,
-    .parent = TYPE_OBJECT,
+    .parent = TYPE_OBJECT_COMPAT,
     .instance_size = sizeof(DeviceState),
     .instance_init = device_initfn,
     .instance_post_init = device_post_init,
-- 
2.50.1


