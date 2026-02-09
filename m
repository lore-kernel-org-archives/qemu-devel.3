Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8835FE81BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSWs-0007G8-0c; Mon, 09 Feb 2026 09:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVz-000729-Ac
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vpSVx-0005jW-MU
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770648324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIiudUTMNNN0/LJEZJOC2fdLoE2aboeP06B1vEbAhME=;
 b=BcWtQrkRNVXtUZUfyBgVeWUh8rf9aiGOB4Opplq4AUWJKg+vUoMxP8lL8jdqVv7Szn+yXu
 yHj+ANDoH+bf7gx9eWjTGMS33r1v68aGN8sDnR68ffKnaIOS3pciXJ8JkAg3gwlLcZX8Jx
 cBIzfn5dIWQ9/cxIoMTs9EFd2hCdaMI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-L4VKO4kDPFyZqvrAhXEgRw-1; Mon,
 09 Feb 2026 09:45:21 -0500
X-MC-Unique: L4VKO4kDPFyZqvrAhXEgRw-1
X-Mimecast-MFC-AGG-ID: L4VKO4kDPFyZqvrAhXEgRw_1770648316
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF8A819560A6; Mon,  9 Feb 2026 14:45:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C3D0180066C; Mon,  9 Feb 2026 14:45:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkrempa@redhat.com, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/9] scripts/qemugdb: timers: Improve 'qemu timers' command
 readability
Date: Mon,  9 Feb 2026 09:45:01 -0500
Message-ID: <20260209144508.45268-4-stefanha@redhat.com>
In-Reply-To: <20260209144508.45268-1-stefanha@redhat.com>
References: <20260209144508.45268-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

* Add the 'attributes' field from QEMUTimer;
* Stringify the field's value in accordance with macros from
  include/qemu/timer.h;
* Make timer expiration times human-readable by converting from nanoseconds
  to appropriate units (ms/s/min/hrs/days) and showing the scale factor
  (ns/us/ms/s).

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20251204105019.455060-4-andrey.drobyshev@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/timers.py | 49 +++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 1219a96b32..916c71b74a 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -21,14 +21,53 @@ def __init__(self):
         gdb.Command.__init__(self, 'qemu timers', gdb.COMMAND_DATA,
                              gdb.COMPLETE_NONE)
 
+    def _format_expire_time(self, expire_time, scale):
+        "Return human-readable expiry time (ns) with scale info."
+        secs = expire_time / 1e9
+
+        # Select unit and compute value
+        if secs < 1:
+            val, unit = secs * 1000, "ms"
+        elif secs < 60:
+            val, unit = secs, "s"
+        elif secs < 3600:
+            val, unit = secs / 60, "min"
+        elif secs < 86400:
+            val, unit = secs / 3600, "hrs"
+        else:
+            val, unit = secs / 86400, "days"
+
+        scale_map = {1: "ns", 1000: "us", 1000000: "ms",
+                     1000000000: "s"}
+        scale_str = scale_map.get(scale, f"scale={scale}")
+        return f"{val:.2f} {unit} [{scale_str}]"
+
+    def _format_attribute(self, attr):
+        "Given QEMUTimer attributes value, return a human-readable string"
+
+        # From include/qemu/timer.h
+        if attr == 0:
+            value = 'NONE'
+        elif attr == 1 << 0:
+            value = 'ATTR_EXTERNAL'
+        elif attr == int(0xffffffff):
+            value = 'ATTR_ALL'
+        else:
+            value = 'UNKNOWN'
+        return f'{attr} <{value}>'
+
     def dump_timers(self, timer):
         "Follow a timer and recursively dump each one in the list."
         # timer should be of type QemuTimer
-        gdb.write("    timer %s/%s (cb:%s,opq:%s)\n" % (
-            timer['expire_time'],
-            timer['scale'],
-            timer['cb'],
-            timer['opaque']))
+        scale = int(timer['scale'])
+        expire_time = int(timer['expire_time'])
+        attributes = int(timer['attributes'])
+
+        time_str = self._format_expire_time(expire_time, scale)
+        attr_str = self._format_attribute(attributes)
+
+        gdb.write(f"    timer at {time_str} (attr:{attr_str}, "
+                  f"cb:{timer['cb']}, opq:{timer['opaque']})\n")
 
         if int(timer['next']) > 0:
             self.dump_timers(timer['next'])
-- 
2.52.0


