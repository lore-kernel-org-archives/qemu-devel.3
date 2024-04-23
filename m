Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B94AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnG-00050C-BU; Tue, 23 Apr 2024 11:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmc-0004Mv-CT
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmZ-0008VT-VU
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnI6DCmLAMWxPAP9lwBd3x/oOvf7U/X+eCnp/KlwmH4=;
 b=MpH3vTNmjVQLqxAmLKvPbfDLfshDBSzjLon6N40MdsdBYHCw24EcTrP8MZ8aZtARMilvjO
 kZiqZSvcDzXNJYMv3EGREk5zappJqunzehv7fGcI1mg/sLt7F9xfMrcAd/vrsud1XKT15X
 17zR6ci+GchUVvjAWsuviVw+kzGXMus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-LMmqroikOaCM9JQzuHBl1w-1; Tue, 23 Apr 2024 11:10:02 -0400
X-MC-Unique: LMmqroikOaCM9JQzuHBl1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA8F9811000;
 Tue, 23 Apr 2024 15:10:01 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 659AF200AFA2;
 Tue, 23 Apr 2024 15:10:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/63] hw/core: Move system emulation files to system_ss
Date: Tue, 23 Apr 2024 17:08:55 +0200
Message-ID: <20240423150951.41600-8-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

hotplug.c, qdev-hotplug.c and reset.c are not used by user emulation
and need not be included in hwcore_ss.  Move them to system_ss, where
they belong, by letting the linker pull in the stubs when needed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240408155330.522792-8-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 {hw/core => stubs}/hotplug-stubs.c |  0
 hw/core/meson.build                | 14 +++-----------
 stubs/meson.build                  |  1 +
 3 files changed, 4 insertions(+), 11 deletions(-)
 rename {hw/core => stubs}/hotplug-stubs.c (100%)

diff --git a/hw/core/hotplug-stubs.c b/stubs/hotplug-stubs.c
similarity index 100%
rename from hw/core/hotplug-stubs.c
rename to stubs/hotplug-stubs.c
diff --git a/hw/core/meson.build b/hw/core/meson.build
index e26f2e088c3..f20d4143f7a 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -3,7 +3,6 @@ hwcore_ss.add(files(
   'bus.c',
   'qdev-properties.c',
   'qdev.c',
-  'reset.c',
   'resetcontainer.c',
   'resettable.c',
   'vmstate-if.c',
@@ -12,16 +11,6 @@ hwcore_ss.add(files(
   'clock.c',
   'qdev-clock.c',
 ))
-if have_system
-  hwcore_ss.add(files(
-    'hotplug.c',
-    'qdev-hotplug.c',
-  ))
-else
-  hwcore_ss.add(files(
-    'hotplug-stubs.c',
-  ))
-endif
 
 common_ss.add(files('cpu-common.c'))
 common_ss.add(files('machine-smp.c'))
@@ -40,6 +29,7 @@ system_ss.add(files(
   'cpu-sysemu.c',
   'fw-path-provider.c',
   'gpio.c',
+  'hotplug.c',
   'loader.c',
   'machine-hmp-cmds.c',
   'machine-qmp-cmds.c',
@@ -48,7 +38,9 @@ system_ss.add(files(
   'null-machine.c',
   'numa.c',
   'qdev-fw.c',
+  'qdev-hotplug.c',
   'qdev-properties-system.c',
+  'reset.c',
   'sysbus.c',
   'vm-change-state-handler.c',
   'clock-vmstate.c',
diff --git a/stubs/meson.build b/stubs/meson.build
index 0bf25e6ca53..f87f5c1110f 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -14,6 +14,7 @@ stub_ss.add(files('fdset.c'))
 stub_ss.add(files('gdbstub.c'))
 stub_ss.add(files('get-vm-name.c'))
 stub_ss.add(files('graph-lock.c'))
+stub_ss.add(files('hotplug-stubs.c'))
 if linux_io_uring.found()
   stub_ss.add(files('io_uring.c'))
 endif
-- 
2.44.0



