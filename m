Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40160C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tze0j-0000vD-8x; Tue, 01 Apr 2025 11:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tze0g-0000tj-8X; Tue, 01 Apr 2025 11:58:42 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tze0d-0003Vw-E4; Tue, 01 Apr 2025 11:58:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:4c7:0:640:d178:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0B1A260CC7;
 Tue,  1 Apr 2025 18:58:31 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:1225::1:31])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id YvYBgB0FXiE0-s8c21Eaj; Tue, 01 Apr 2025 18:58:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743523110;
 bh=Q8SoDfgja2U3rtpiEQGVU5h/G2sHUbP2eigbgPgc6Hw=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=vOSzksdkqyDIgmUKNFuW8sNbRkhj9Fn65rSJQict/LSfonXpq5j/VuDHepsZOAjyv
 cDEZCooB5OmDVysj9QYyUcTYvznPqyiXHdH/L+hXOxK4v4+rxz+2a0EVEdTW4vuOuh
 SamXqCJIuBwEWoOzJqVn74mdRb+i1RNQU5ZnZdWo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 devel@lists.libvirt.org, pkrempa@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
Date: Tue,  1 Apr 2025 18:57:30 +0300
Message-ID: <20250401155730.103718-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For change, pause, resume, complete, dismiss and finalize actions
corresponding job- and block-job commands are almost equal. The
difference is in find_block_job_locked() vs find_job_locked()
functions. What's different?

1. find_block_job_locked() do check, is found job a block-job. This OK
   when moving to more generic API, no needs to document this change.

2. find_block_job_locked() reports DeviceNotActive on failure, when
   find_job_locked() reports GenericError. So, lets document this
   difference in deprecated.txt. Still, for dismiss and finalize errors
   are not documented at all, so be silent in deprecated.txt as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all!

That's a continuation of my "[RFC 00/15] block job API"[1], exactly, the
simplest part of it - deprecating block-job-* commands which simply
duplicate job-* ones.

Note that the old series was started with trying to introduce job-change
command as substitution to both block-job-change (which only can change
mirror copy-mode parameter), and block-job-set-speed. It was rather
complicated and controversial attempt, which latest implemenation was
"[PATCH v3 0/7] introduce job-change qmp command"[2].

In [2] Kevin noted, that we'd better follow existing blockdev-reopen
approach of changing options (i.e. specify all options) than introduce a
new one. But, on the other hand, now I'm afraid, that rewriting in
third tools simple call to (old good) block-job-set-speed into
job-change(_all_options_ + changed speed) is too much work just for
"having nice interface". And too much for the only two options we want
to change.

So, let's just start from something more obvious. Finally,
we can simple keep block-job-set-speed and block-job-change as is,
as they (unlike other block-job-* commands) are not duplicated by
similar job-* commands.

[1] https://patchew.org/QEMU/20240313150907.623462-1-vsementsov@yandex-team.ru/
[2] https://patchew.org/QEMU/20241002140616.561652-1-vsementsov@yandex-team.ru/

 docs/about/deprecated.rst | 31 +++++++++++++++++++++++++++++++
 qapi/block-core.json      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e2b4f077d4..eed3356359 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -148,6 +148,37 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
+``block-job-pause`` (since 10.1)
+'''''''''''''''''''''''''''''''
+
+Use ``job-pause`` instead. The only difference is that ``job-pause``
+always reports GenericError on failure when ``block-job-pause`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-resume`` (since 10.1)
+''''''''''''''''''''''''''''''''
+
+Use ``job-resume`` instead. The only difference is that ``job-resume``
+always reports GenericError on failure when ``block-job-resume`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-complete`` (since 10.1)
+''''''''''''''''''''''''''''''''''
+
+Use ``job-complete`` instead. The only difference is that ``job-complete``
+always reports GenericError on failure when ``block-job-complete`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-dismiss`` (since 10.1)
+'''''''''''''''''''''''''''''''''
+
+Use ``job-dismiss`` instead.
+
+``block-job-finalize`` (since 10.1)
+''''''''''''''''''''''''''''''''''
+
+Use ``job-finalize`` instead.
+
 ``query-migrationthreads`` (since 9.2)
 ''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e1..264be8413b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2968,6 +2968,11 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-pause
+#     instead.
+#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -2975,6 +2980,7 @@
 # Since: 1.3
 ##
 { 'command': 'block-job-pause', 'data': { 'device': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -2992,6 +2998,11 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-resume
+#     instead.
+#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -2999,6 +3010,7 @@
 # Since: 1.3
 ##
 { 'command': 'block-job-resume', 'data': { 'device': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -3023,6 +3035,11 @@
 #     the name of the parameter), but since QEMU 2.7 it can have other
 #     values.
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-complete
+#     instead.
+#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -3030,6 +3047,7 @@
 # Since: 1.3
 ##
 { 'command': 'block-job-complete', 'data': { 'device': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -3047,9 +3065,15 @@
 #
 # @id: The job identifier.
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-dismiss
+#     instead.
+#
 # Since: 2.12
 ##
 { 'command': 'block-job-dismiss', 'data': { 'id': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -3064,9 +3088,15 @@
 #
 # @id: The job identifier.
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-finalize
+#     instead.
+#
 # Since: 2.12
 ##
 { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
-- 
2.48.1


