Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AAEC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWkg-0004kV-34; Fri, 03 Jul 2026 01:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWje-0004Sy-HN; Fri, 03 Jul 2026 01:46:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWjW-0003RM-BA; Fri, 03 Jul 2026 01:46:41 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jovf036784
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 3 Jul 2026 14:46:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8TGlRMXNgJkY6XRsWpl74qtD3NJg9sImsPCOCPuebGs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1783057566; v=1;
 b=ENHPtltnRWQYbx7zoo3CzMmmOph0ygdocL8AZsLvd0IU6BW/+KxVQpF4qcjnWrVs
 oR8/sZeb4rcXR3sXpTIHjuW9J45pNc46V8mbrDqPYXcz/s7CTqpadn41OBOoDAUS
 yjo/StrN5DmYKJiQURcLupGbBqaNQrRVmxi1mfVHUJPhZGnP2vkAGQM8D1VpfdCg
 8fp+ZpfoUoUapZ2sFS+MqeMn/ijX9m7RiUYgV5aV8lg+xRyOXpqNFmD0+fHLc2ja
 bmowknJ398HSySysooyHB5UTO5jtfvpSEkEWKlsmM6aWFClLBmQc3Rr0j0CSUTA2
 FK3lTezkfrW3IpB4qgY46Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:37 +0900
Subject: [PATCH v5 6/8] module: Use qemu_get_runtime_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-6-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=4PXnR6ZdLkaqz4pRFi//hI5Zh2wnip4Hz54KkyfWdsk=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7zwzpir8bLjUYX5R8L/pYrzBw6+mFnALODF997DsSd
 Pq+3YnvKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmMjiDob/JUcN5I9KS2alVt7Y
 u+O768nMxk8mAZFXGWPmFDNKbw+sZGQ4Fz5h5nr9hP7V66+WCMZWrCzfuG3yn6xtwsLfFd+z+qj
 zAwA=
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

qemu_get_runtime_dir() is used to construct the path to module upgrades.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/module.h | 2 +-
 util/module.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index fccf017bf9e8..a22755c6f026 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -76,7 +76,7 @@ void module_call_init(module_init_type type);
  * directories searched are:
  * - getenv("QEMU_MODULE_DIR")
  * - get_relocated_path(CONFIG_QEMU_MODDIR);
- * - /var/run/qemu/${version_dir}
+ * - ${qemu_get_runtime_dir()}/qemu/${version_dir}
  *
  * prefix:         a subsystem prefix, or the empty string ("ui-", ..., "")
  * name:           name of the module
diff --git a/util/module.c b/util/module.c
index 09dc43f51eb3..eff64fa7ab0a 100644
--- a/util/module.c
+++ b/util/module.c
@@ -242,7 +242,8 @@ int module_load(const char *prefix, const char *name, Error **errp)
     version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
                              G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-.~",
                              '_');
-    dirs[n_dirs++] = g_strdup_printf("/var/run/qemu/%s", version_dir);
+    g_autofree char *run = qemu_get_runtime_dir();
+    dirs[n_dirs++] = g_build_filename(run, "qemu", version_dir, NULL);
 #endif
     assert(n_dirs <= ARRAY_SIZE(dirs));
 

-- 
2.54.0


