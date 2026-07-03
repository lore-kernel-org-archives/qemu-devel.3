Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F6AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWkf-0004gp-3n; Fri, 03 Jul 2026 01:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWje-0004T6-ND; Fri, 03 Jul 2026 01:46:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWjW-0003RE-82; Fri, 03 Jul 2026 01:46:42 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jovZ036784
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 3 Jul 2026 14:46:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZpynoseJZGc5/lwx/Wvu71NhFIkyJqaZni4O2jiSR10=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1783057564; v=1;
 b=H4quxTGBfa29RfYIM1qzFZ0MZ+kAW5L5ErtJ1uJfFBZAq5PAUf6dJ1OdxYqBRjLn
 rXFInz2PT9Y4Jxx4hgpjrlYbOFTx02aw2E1rnGplJ+6vIVYTGEJhTNQM/jHGsfSu
 PhFb8RYpHzpmOZ7mJ6+AIXDLuRcUptzXWmc5RXqt1KyeH4QcaNSvMbdmjIKQMIfQ
 1h+EPM+wYq71FNyAR+7PKUw77NPwdXgZyxTwPpBAQ4SwYdOX8Q5PU3p9D+U2c8Tc
 YSW6bvIlLZ7+qdfqLmCW5GZ1oNHUk34jpNtKLLtwdj5GJ+bOjuusQHta+DrU4J6O
 UwJSjTG5RjorEffUI9rd8Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v5 0/8] util: Introduce qemu_get_runtime_dir()
Date: Fri, 03 Jul 2026 14:45:31 +0900
Message-Id: <20260703-run-v5-0-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNSw7CIBBAr2JYS8PwbV15D+OCFGonjWBASZumd
 5c2ceFu3mTem5Vkn9BncjmtJPmCGWOooM4n0o82PDxFV5lwxiXj0NL0CVQPzHXgeyNFR+rlK/k
 B56Nyu1ceMb9jWo5oEft29wXrODCjJFcNaCNaCtROOOIUm+jqdHV2CTg3fXySPVPkT5XMgD5eF
 0kZVYOxvNMCQLd/0rZtXxr/3tjSAAAA
X-Change-ID: 20240218-run-6f0d91ec7439
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3711;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=bMSExKG35YRSyGy7dplM82VSWgj8vS92gW/L0PNl6Zc=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z4QJHMKnanYLp9448u8B+2sBnp8a9i8ZbrnvPWG4r
 fn0MV7NjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIm8M2L4K7rsTmKGoOPRSLv+
 E7kFB99ces/bLRekVVl2cblnkeMkc4Z/Cu5PNnFFbM906LQ4ts9N7N5+Ra+5cmu0stI+it67m/u
 FEwA=
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

qemu_get_runtime_dir() returns a dynamically allocated directory path
that is appropriate for storing runtime files. It corresponds to "run"
directory in Unix.

With a tree-wide search, it was found that there are several cases
where such a functionality is implemented so let's have one as a common
utlity function.

A notable feature of qemu_get_runtime_dir() is that it uses
$XDG_RUNTIME_DIR if available. While the function is often called by
executables which requires root privileges, it is still possible that
they are called from a user without privilege to write the system
runtime directory. In fact, I decided to write this patch when I ran
virtiofsd in a Linux namespace created by a normal user and realized
it tries to write the system runtime directory, not writable in this
case. $XDG_RUNTIME_DIR should provide a writable directory in such
cases.

This function does not use qemu_get_local_state_dir() or its logic
for Windows. Actually the implementation of qemu_get_local_state_dir()
for Windows seems not right as it calls g_get_system_data_dirs(),
which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
"/usr/share", not "/var", which qemu_get_local_state_dir() is intended
to provide. Instead, this function try to use the following in order:
- $XDG_RUNTIME_DIR
- LocalAppData folder
- get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

This function does not use g_get_user_runtime_dir() either as it
falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
available. In the case, we rather use:
get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

All current callers pass the returned path to g_build_filename(), but
this series does not add a helper to combine those operations. Such a
helper would be complicated due to variadic arguments, and keeping that
out of scope keeps this series focused.

V2 -> V3:
  Rebase to the current master.
  Dropped patch "qga: Remove platform GUID definitions" since it is
  irrelevant.

V1 -> V2:
  Rebased to the current master since Patchew complains.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v5:
- Expanded the patch message.
- Link to v4: https://lore.kernel.org/r/20240716-run-v4-0-5f7a29631168@daynix.com

Changes in v4:
- Rebased.
- Link to v3: https://lore.kernel.org/r/20230921075425.16738-1-akihiko.odaki@daynix.com

---
Akihiko Odaki (8):
      util: Introduce qemu_get_runtime_dir()
      ivshmem-server: Use qemu_get_runtime_dir()
      qga: Use qemu_get_runtime_dir()
      scsi: Use qemu_get_runtime_dir()
      i386/vmsr: Stop using qemu_get_local_state_dir()
      module: Use qemu_get_runtime_dir()
      util: Remove qemu_get_local_state_dir()
      spice-app: Use qemu_get_runtime_dir()

 docs/conf.py                  |  2 ++
 docs/interop/qemu-ga.rst      |  5 +++--
 docs/meson.build              |  6 +++++-
 docs/tools/qemu-pr-helper.rst |  8 ++++----
 include/qemu/module.h         |  2 +-
 include/qemu/osdep.h          | 10 +++++++---
 contrib/ivshmem-server/main.c | 20 ++++++++++++++++----
 qga/main.c                    |  8 ++++----
 scsi/qemu-pr-helper.c         |  6 +++---
 target/i386/kvm/vmsr_energy.c |  6 +++---
 tools/i386/qemu-vmsr-helper.c |  6 +++---
 ui/spice-app.c                |  4 ++--
 util/module.c                 |  3 ++-
 util/oslib-posix.c            |  9 +++++++--
 util/oslib-win32.c            | 26 ++++++++++++++++++++++----
 15 files changed, 84 insertions(+), 37 deletions(-)
---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20240218-run-6f0d91ec7439

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


