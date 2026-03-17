Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628EEF3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QE8-0005Ty-1e; Tue, 17 Mar 2026 04:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBt-0001E9-Qh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QBq-0005zc-C1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2tiXkQUButPcdvhDbOgDCuPStfuovK+PgHgx264dx4=;
 b=f/6O+m2+ZEA70tlgBAqoJON+GOxr9HYG8RRGP+GOrAmuB1L4rAj5EazqSMYS5ta2lze6tx
 MZJcLV0okIs9jJlsUdbGig2xybInNqeneZt8jYOlBb+r4x81VLp3dWOPkPZYtPRZWk5wzQ
 2k8eTbb0eR9D2/O6DJlZf6waxZIoZxA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-bgbCFA_0NUyOgJpUuCQLOw-1; Tue,
 17 Mar 2026 04:54:12 -0400
X-MC-Unique: bgbCFA_0NUyOgJpUuCQLOw-1
X-Mimecast-MFC-AGG-ID: bgbCFA_0NUyOgJpUuCQLOw_1773737651
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 383B11956077
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:11 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 304CA1955F19
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:50 +0400
Subject: [PATCH 36/60] util: move datadir.c from system/
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-36-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K7IuTTL5eOIUvVD/UX/oXHOXc2eSfE+3CHdr6yiVJZ4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXb6yvLCuuEW2HI5PUascDdUknfouo+CxmfI
 4BgYdBHliaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5TW2EACdN5Di8mliNmvYODYhCo/H3Ed4K2D1tK9KHKp7fQ0/13Ftl7JhtMbxF63srn24mlNr4c1
 Ku+XRFU3lVALwRtYeyUfuwuULDL8Eescn/6y5OOynzMeMcgrfV3G8Z33dIMmpV7tEpfNOQ//E5B
 rdFoGMbLziIwWTh+gno8ZJ69GHEl0NtrYL/D9MHrzeT3lUAKazKX6Uy5xCTlEv0Fwba83HJPB4o
 KTLQWUGPylCGkRhAvuwBMI2TL+BZYEQyE3Bo476EUxRSHckVRH0s9imUETRzlQTkZVjV06UKrxY
 e/SFD9JPpr7Hu1VCMPaOb7/1am7VG6oYv+0wdPUSaPQI+Z4LXMAsPgR/+u3UUUs/QrO/h5wYgqk
 W9OQ/gtCGPNIIdwcdbISaCVhQ6Yb/22sa1W++0+Vc+iqKvIiFgC4zMOjDZT8Hh2JKokEeyV4GxD
 u3J+h+CPrsk+cxNvO1HmoHC4O9BdEymWAVRsJokmsgUerOa7llwldiI0ehSkhomae8jXnxjZOv9
 kJ5LLhessbw29WfjrdRzXN2YcuqHqLZQMrlRNLyF/bNc+Kl7lAf8+cdyIYiBx5RkqF7u/nZ6Wj8
 5lr44miEhYfTdV4lblncN5xK/REo8PPlWqi+QVLyTCtRS05KH8Jv3TqNWBMLGQQ7IjRojRZEow8
 OwrufHiQZnoZvkQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The datadir module provides general-purpose data file lookup
utilities that are not specific to system emulation. Move it
to util/ so it can be reused more broadly.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 {system => util}/datadir.c | 0
 system/meson.build         | 1 -
 system/trace-events        | 1 -
 util/meson.build           | 1 +
 util/trace-events          | 3 +++
 5 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/system/datadir.c b/util/datadir.c
similarity index 100%
rename from system/datadir.c
rename to util/datadir.c
diff --git a/system/meson.build b/system/meson.build
index 579e8353d53..9cdfe1b3e75 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -8,7 +8,6 @@ system_ss.add(files(
   'bootdevice.c',
   'cpus.c',
   'cpu-timers.c',
-  'datadir.c',
   'dirtylimit.c',
   'dma-helpers.c',
   'exit-with-parent.c',
diff --git a/system/trace-events b/system/trace-events
index 6d29a823f04..e6e1b612798 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -46,7 +46,6 @@ vm_stop_flush_all(int ret) "ret %d"
 
 # vl.c
 vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
-load_file(const char *name, const char *path) "name %s location %s"
 runstate_set(int current_state, const char *current_state_str, int new_state, const char *new_state_str) "current_run_state %d (%s) new_state %d (%s)"
 system_wakeup_request(int reason) "reason=%d"
 qemu_system_shutdown_request(int reason) "reason=%d"
diff --git a/util/meson.build b/util/meson.build
index 33132c04ad6..cd56fe2ffe4 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -30,6 +30,7 @@ util_ss.add(when: linux_io_uring, if_true: files('fdmon-io_uring.c'))
 if glib_has_gslice
   util_ss.add(files('qtree.c'))
 endif
+util_ss.add(files('datadir.c'))
 util_ss.add(files('defer-call.c'))
 util_ss.add(files('envlist.c', 'path.c', 'module.c'))
 util_ss.add(files('event.c'))
diff --git a/util/trace-events b/util/trace-events
index 540d6625073..df549646d12 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -114,3 +114,6 @@ uffd_unregister_memory_failed(void *addr, uint64_t length, int err) "addr: %p le
 # module.c
 module_load_module(const char *name) "file %s"
 module_lookup_object_type(const char *name) "name %s"
+
+# datadir.c
+load_file(const char *name, const char *path) "name %s location %s"

-- 
2.53.0


