Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5F4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWkb-0004e4-96; Fri, 03 Jul 2026 01:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWje-0004T4-MP; Fri, 03 Jul 2026 01:46:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWjW-0003RV-98; Fri, 03 Jul 2026 01:46:42 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jove036784
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 3 Jul 2026 14:46:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=851A/JXMMn6GwDOP12xrolOCWBX0QezLyRGo803/850=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1783057565; v=1;
 b=i78UPtYwoS8Yl2fhpzn5PGis683FaDaDFL+PekDANPIsFDBXeNKmJm3CiVouZctI
 G8kU/47ZeUOzatPzTDiHrlTeuynTeg4teCLQ7+IoksB68eJYyY/yj0tbnXwMQwjZ
 CqjktQeTrrw1oqaWFmhOsYMRQaJIWuoFcxAprCNtF4RW3/x6dul+SLbvm+m0zvh8
 U4JOAax+WHaJ5ysagNzNRfq0/ky6RXiGo3kL0XaZFcKoasQw1RC+korUrf7eLb6A
 NmSo+EONd2Ir5jk+NaQXY2P25tPw5wL6rB0pzgI00l/xKOLv2OtPLw04KIv4JqCv
 vp4pTUj4Y0e9+TW0ArdieA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:36 +0900
Subject: [PATCH v5 5/8] i386/vmsr: Stop using qemu_get_local_state_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-5-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260703-run-v5-0-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260703-run-v5-0-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yan Vugenfirer <yan@daynix.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=oeQZYiyhgFq2eVkoVeT1tGWrYZPG4NXl4cvC4qX3el8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z/SPswPmTuRUqrTceF/M1s37Tp3cx/XFCndf+P/wm
 MWg01HZUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJGiSEaG3Yfnq8bqXVumcPF6
 5+WFdWtvfL9+8ujy1148yv6Fb+uP6zMyrNpm1Lzr4ZPp70Us9VY1CD/vsOVg2P5324aZ0w3+n1h
 9mAkA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The qemu_get_local_state_dir() users only need the QEMU "run" directory,
but the Windows implementation is not suitable for that. It calls
g_get_system_data_dirs(), which in turn is documented as follows:

> On Windows it follows XDG Base Directory Specification if
> `XDG_DATA_DIRS` is defined.
> If `XDG_DATA_DIRS` is undefined,
> the first elements in the list are the Application Data
> and Documents folders for All Users. (These can be determined only
> on Windows 2000 or later and are not present in the list on other
> Windows versions.) See documentation for FOLDERID_ProgramData and
> FOLDERID_PublicDocuments.
>
> Then follows the "share" subfolder in the installation folder for
> the package containing the DLL that calls this function, if it can
> be determined.
>
> Finally the list contains the "share" subfolder in the installation
> folder for GLib, and in the installation folder for the package the
> application's .exe file belongs to.

Use get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run") for the vmsr
helper paths to allow removing it.

qemu_get_runtime_dir() is not appropriate here because it points to a
user-specific runtime directory, while the vmsr helper and QEMU are
typically run by different users and need to agree on the socket path.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/i386/kvm/vmsr_energy.c | 6 +++---
 tools/i386/qemu-vmsr-helper.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index d24e827a214a..77f39ed12b98 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "vmsr_energy.h"
 #include "io/channel.h"
@@ -22,9 +23,8 @@
 
 char *vmsr_compute_default_paths(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
-
-    return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
+    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR
+                              "/run/qemu-vmsr-helper.sock");
 }
 
 int is_rapl_enabled(void)
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index f12fd3c3e816..7c507695f571 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -62,10 +62,10 @@ static int gid = -1;
 
 static void compute_default_paths(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
+    g_autofree char *run = get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
 
-    socket_path = g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
-    pidfile = g_build_filename(state, "run", "qemu-vmsr-helper.pid", NULL);
+    socket_path = g_build_filename(run, "qemu-vmsr-helper.sock", NULL);
+    pidfile = g_build_filename(run, "qemu-vmsr-helper.pid", NULL);
 }
 
 static int is_intel_processor(void)

-- 
2.54.0


