Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46064F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHQz-0004CB-Oi; Fri, 10 Apr 2026 15:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQw-00041O-J4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHQu-0001vC-W8
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EC2mtSmBN/QpQXCOVvzyWCJ+zIxqCQ8Cl/n8dli4yDk=;
 b=RpmXcH99SruIKP4lPRaRTbwjSTJd2EkunkX5JcSHfb2YnJIKvA2jnRfc0BM5GRQm8tq3Ox
 NNsSKVD6MZsEA2uwe/2kmlwFX9sVFCu7lAZIkuOUl9LzziSUl7tuoyyBmIi58h220Cb65S
 h44l/vQilTvzAUeOIThf+Io3zwEVas4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-doYNB4NBM-Og8ax6zSP9bw-1; Fri,
 10 Apr 2026 15:22:23 -0400
X-MC-Unique: doYNB4NBM-Og8ax6zSP9bw-1
X-Mimecast-MFC-AGG-ID: doYNB4NBM-Og8ax6zSP9bw_1775848942
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BE80180062A; Fri, 10 Apr 2026 19:22:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06DB019560AB; Fri, 10 Apr 2026 19:22:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:56 +0400
Subject: [PATCH v2 34/67] util: move datadir.c from system/
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-34-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GnyGZFXxnwQTX053ioyr310RQ/Jwl1OJBR8gcP9DCrY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0Vkbw3IhZw7lFLSU8wW1asF2gmYIZeDBVCH
 RjQJEZ/FEeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5afuEACqUuHlq/rqHDVVNtjMO4j5+dRv5GU4IM3URxuuLwHDxYinDNa95I3n73SPW0gIDiIZ1/X
 YT+/h5r7DEoqWz5gwShQAYGkpIyb0f0LW8At0yRgvfbQEMxi1MV2wwAEXHM8+MoH7P+pWkFQDsg
 MMv0UcI/YEX95oJbWrpRnlToKovU/+NBKnbTWlmxeoxpvB6R4Jqcl8R9xDXVky7OrmLKaHMO5/E
 OY5E8WDpm/bmD66gLmAsw3ylKJP+ZPDUj2KU6ceC4x1tNkduxGEz1Ru+gJIldnNacR73tyeI2p3
 RzxftO9X6mArnXOhPliP7b5ISpLnYHXhDTC4vntx8c0m4ZVypoDnFY3CtacrG3E+KF3IvM8bPme
 l5FK7IRkQAtqaiooUtFVT2v9aj9QG6vHr4lTIoWKMr9/LO+cQTvVotUibzgFpSgYrDVFwuTD/J8
 Sp2cJFmAQkqH0X1MhrHzDYAStJtkHg+9Hi9ut57xUllxkK8Q+0LIAk6ckhSyoDD5eOMYSTEDS5f
 sjWhxct/+BMMQPtki3tymufHLcZsdDcPCVipqTnnByveRXRGw0MhFv/JP+1rU7fs/6fP0NjWn4D
 Q6aBwoR674Q61SIF5asG/EVYreoMkhxSt3rJ7In9zXS4s7chVWC3O+GEyqKFQPgCjk/Rkk1FiyS
 hscadYdQYN2FGLA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The datadir module provides general-purpose data file lookup
utilities that are not specific to system emulation. Move it
to util/ so it can be reused more broadly.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 5d3fff0eea4..8bed0267c07 100644
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


