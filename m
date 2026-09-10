Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57351C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ntl-00009A-WD; Thu, 10 Sep 2026 19:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTR-0005qF-GJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lT4-0003BI-OX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6oAhYiiIn3xpeHIgSvH0lgBJsq4uFVnZ7OcjCH2hOg=;
 b=A9JpJBBfATQsYi/UAM2pk7l82hjy6OIwiK8wl/y7N+HYXjjmKsdMFlJghNuxfTT7P9D9Aa
 ek6YUIWHgNEr5YXQ+BAiXpiPjPXycDfEvD5aDmrZ5tC9JDk0f5T5Rw8Ovk9J5osXWdx/JR
 JxT4z30vi5F/aZw/xg3w6yGwnJCpDeo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-4MBw1wCnOPW5En48PaM3Pg-1; Thu, 10 Sep 2026 16:13:01 -0400
X-MC-Unique: 4MBw1wCnOPW5En48PaM3Pg-1
X-Mimecast-MFC-AGG-ID: 4MBw1wCnOPW5En48PaM3Pg_1789071173
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so2919035e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071170; x=1789675970; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e6oAhYiiIn3xpeHIgSvH0lgBJsq4uFVnZ7OcjCH2hOg=;
 b=NEQMoBJCxjwObK7vqluwdy/S9QK3h40MJshXyBvWmjYN3Utbm6QHvMaL1wijBeSP2+
 Jfqy6NMzd9O+oEB2DqJ/vNp6E4BM+miroR6fypABIw5VaGKC8L+x//PM2pZVmB6Hs+G3
 NqnmzrnOpx+CgqK8yTlGEYo8R1cFdS3f5mSezQDTFtApetyPhUKhwsoeQu/NHi+AL+/k
 Y2P/1HRKFF75+amXSkUnJELdMrGnwQPMZHEyOwE7AZzBhIrLty0yUsa+yFnpc4uipAUL
 Bdmkb9Pp8TNCPVWVG6uE7Mwbu5uc0ypYHCfM6ZvE1Sh9Y1BL+DUU+83npOZ84/9+lXyF
 5+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071170; x=1789675970;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6oAhYiiIn3xpeHIgSvH0lgBJsq4uFVnZ7OcjCH2hOg=;
 b=sSHK+DffVDUo4TmDaqzL/zOS8z8d4Zj/BuPSH+zzSZbMp9js4CwDECvCw/o74xEgA4
 Cff5ecKjhWhMRIpqu7v1j6zckOtetc6TwPB9kn8I1FX3bG1+rUtzAKiFVnkdE/jOuqO8
 vaSCyoeNYkbtXz++PZgJnN4fZk0+evnmbbTvaq1fgem/80VmqISqV5QkGCEW9yzltNfq
 Ozss+9BmzZzZG6aoyHfuWSb7aHP4lBbh32YtEaXKtvLeQkaUDi4SLO1pooEFQc2Z6TSF
 qR2fv3u36CdM8NROIcZghUWYR5j5RWKzOD0Gc0u1IGCBIka8sl4w5Yaumzk6PicL2BvN
 W+FA==
X-Gm-Message-State: AFuF++mP633yHAaOhAjJDJxJGYYhYnwNoavNazmbmkjafxKvYDctr36h
 kPYbUlT8kEsMzGTis/KVEaSih3w+0mweFOjRj+IJy/ZsUXqLk5KkQK7jo8dlKHlOEh1MN9pvtwR
 JVgTICJ29zQiGVjR+e8IfaV88XIecw7eBERBQbZPjcdJWcGbRopeozdOU3wOCMnBaJV4O9qWziu
 HVgUJwOZeZs1jkTEKvPis1SrUdrSstqGz70g==
X-Gm-Gg: AYBFou2Ppo7NGQ7Iu9nb+CFeJFc31wibThqxnXtyNm29S2l0XDjfHgXmNPjaHRJim++
 ZLnWTARFPoj43Vh7QLhTHph+cY89l5Ss0nnjqhDkC3FQNBx2IVW2yPvhiLuOTAieH/CSd+epYEn
 BMeMIQY2Wp9XX5DK23U5BiDnJ5oqSe4m8ffqjBPYh8kVw2A6I6FeacWZpCrDPVYIPGdnpCNxErg
 Pmv2aHE2AWN1avHAAf8KpSdOnRuWiAJyfTPQJj7LfMWFCOGKfb3lHxiz7w6OKkGhmyF8b6kRvYI
 4RRCg5DpD4t6bm31qdGwSfmUdY3b7YNjKuo0RaBAzv0OPjUtqbY87FRwfV/C/qxl+oXTKpr8Gk4
 et3/uS63YeWPt1Vck9oIeJCU=
X-Received: by 2002:a05:600c:3115:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-49e61989e79mr7907555e9.10.1789071169713; 
 Thu, 10 Sep 2026 13:12:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-49e61989e79mr7907245e9.10.1789071169172; 
 Thu, 10 Sep 2026 13:12:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bc5fsm95244475e9.3.2026.09.10.13.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:48 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 32/90] net/tap: disable read polling for stopped VM
Message-ID: <1b08604011ee67bfb180503acfe0c70df8c8099f.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Polling when VM is stopped doesn't make real sense, as stopped VM can't
handle incoming traffic anyway.

And it's critical for introduction of local TAP migration
feature in the next commit: the TAP device will be transferred
to the target (open fd will be passed through migration channel),
and if we continue polling on source, we may get a package, which
we'll never handle on source (already stopped), it will be lost.
Better is save this package for target VM to handle.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-15-vsementsov@yandex-team.ru>
---
 net/tap.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index dd0d134875..51d028d956 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -36,6 +36,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "monitor/monitor.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
@@ -92,6 +93,8 @@ struct TAPState {
     Notifier exit;
 
     int queue_index;
+    bool enable_poll_on_resume;
+    VMChangeStateEntry *vmstate;
 };
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -145,10 +148,31 @@ static void tap_update_fd_handler(TAPState *s)
 
 static void tap_read_poll(TAPState *s, bool enable)
 {
+    if (enable && runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        s->enable_poll_on_resume = true;
+        return;
+    }
     s->read_poll = enable;
     tap_update_fd_handler(s);
 }
 
+static void tap_vm_state_change(void *opaque, bool running, RunState state)
+{
+    TAPState *s = opaque;
+
+    if (running) {
+        if (s->enable_poll_on_resume) {
+            tap_read_poll(s, true);
+            s->enable_poll_on_resume = false;
+        }
+    } else if (state == RUN_STATE_FINISH_MIGRATE) {
+        if (s->read_poll) {
+            s->enable_poll_on_resume = true;
+            tap_read_poll(s, false);
+        }
+    }
+}
+
 static void tap_write_poll(TAPState *s, bool enable)
 {
     s->write_poll = enable;
@@ -379,6 +403,11 @@ static void tap_cleanup(NetClientState *nc)
         s->exit.notify = NULL;
     }
 
+    if (s->vmstate) {
+        qemu_del_vm_change_state_handler(s->vmstate);
+        s->vmstate = NULL;
+    }
+
     tap_read_poll(s, false);
     tap_write_poll(s, false);
     close(s->fd);
@@ -818,6 +847,9 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    s->enable_poll_on_resume = false;
+    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
+
     if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
         sndbuf_required) {
         goto failed;
-- 
MST


