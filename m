Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A021C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEq-0003q9-7a; Wed, 13 Mar 2024 11:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEj-0003eC-20; Wed, 13 Mar 2024 11:09:45 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEg-0005wk-5f; Wed, 13 Mar 2024 11:09:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 94F9960A95;
 Wed, 13 Mar 2024 18:09:40 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-JHfDYuY9; Wed, 13 Mar 2024 18:09:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342579;
 bh=zZ0mJmmMXx0Ma28KnRdTxgIgXnMdPfvZcjlQY7vKVTk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=M3VPzHR3RQxmRKskoAN0Ss5qNI12Mgfvn9ArfOKV/xXnkgt2+E20vsLN5GqNpkTEa
 JFsBuSL5xodXZScZQp/7Y7d50OlG67HnAvoqVukyTx7jcny2L4opzb07Huy0tsAhZL
 /s/fM8ShrXidoTDH6BmGKXad/GHPrNHOA7s+z6Ek=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 15/15] qapi/block-core: derpecate block-job- APIs
Date: Wed, 13 Mar 2024 18:09:07 +0300
Message-Id: <20240313150907.623462-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For cancel, we have a new solution about soft-cancelling mirror:
job-complete(no-block-replace=true)

For set-speed, the action is supported by job-change.

For query, query-jobs is not equal to query-block-jobs, but now it has
enough information (see documentation changes for details).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/about/deprecated.rst | 73 +++++++++++++++++++++++++++++++++++++--
 qapi/block-core.json      | 59 ++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5ff98ef95f..7db3ba983b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -128,6 +128,75 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
+``block-job-pause`` (since 9.1)
+'''''''''''''''''''''''''''''''
+
+Use ``job-pause`` instead. The only difference is that ``job-pause``
+always reports GenericError on failure when ``block-job-pause`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-resume`` (since 9.1)
+''''''''''''''''''''''''''''''''
+
+Use ``job-resume`` instead. The only difference is that ``job-resume``
+always reports GenericError on failure when ``block-job-resume`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-complete`` (since 9.1)
+''''''''''''''''''''''''''''''''''
+
+Use ``job-complete`` instead. The only difference is that ``job-complete``
+always reports GenericError on failure when ``block-job-complete`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-dismiss`` (since 9.1)
+'''''''''''''''''''''''''''''''''
+
+Use ``job-dismiss`` instead.
+
+``block-job-finalize`` (since 9.1)
+''''''''''''''''''''''''''''''''''
+
+Use ``job-finalize`` instead.
+
+``block-job-set-speed`` (since 9.1)
+'''''''''''''''''''''''''''''''''''
+
+Use ``job-change`` instead.
+
+``block-job-change`` (since 9.1)
+''''''''''''''''''''''''''''''''
+
+Use ``job-change`` instead.
+
+``block-job-cancel`` (since 9.1)
+''''''''''''''''''''''''''''''''
+
+Use ``job-cancel`` instead which correspond to
+``block-job-cancel`` (``force`` = true ).  For special case of
+soft-cancelling mirror in ready state, use ``job-complete``
+(``no-block-replace`` = true ).
+
+``query-block-jobs`` (since 9.1)
+
+Use ``query-jobs`` instead. Per-field recommendations:
+
+``query-block-jobs`` ``device`` field: use ``query-jobs`` ``id`` field.
+
+``query-block-jobs`` ``len`` and ``offset`` fields: use ``query-jobs``
+``current-progress`` and ``total-progress`` fields.
+
+``query-block-jobs`` ``paused``, ``ready``:
+use ``qeury-jobs`` ``status``.
+
+``auto-finalize``, ``auto-dismiss``: these are parameters set by user
+on job creation and never changed. So, no reason to query them. No
+support in ``query-jobs``.
+
+``busy``: it actually means nothing for user, it's a mistake to rely on
+it. No support in ``query-jobs``.
+
+
 Incorrectly typed ``device_add`` arguments (since 6.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -143,8 +212,8 @@ all arguments passed to ``device_add`` are consistent with the documented
 property types.
 
 
-``block-job-change`` and ``job-change``  argument ``type`` (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+``job-change`` argument ``type`` (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''
 
 QEMU can get job type from the job itself (by @id), @type field is redundant.
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 75c02e1586..793155f174 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1422,9 +1422,15 @@
 #
 # Returns: a list of @BlockJobInfo for each active block job
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @query-jobs
+#     instead.
+#
 # Since: 1.1
 ##
 { 'command': 'query-block-jobs', 'returns': ['BlockJobInfo'],
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -2875,6 +2881,11 @@
 # @speed: the maximum speed, in bytes per second, or 0 for unlimited.
 #     Defaults to 0.
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-change
+#     instead.
+#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
@@ -2883,6 +2894,7 @@
 ##
 { 'command': 'block-job-set-speed',
   'data': { 'device': 'str', 'speed': 'int' },
+ 'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -2919,13 +2931,22 @@
 #     paused) instead of waiting for the destination to complete its
 #     final synchronization (since 1.3)
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-cancel
+#     instead which correspond to block-job-cancel(force=true).
+#     For special case of soft-cancelling mirror in ready state,
+#     use job-complete(no-block-replace=true) instead.
+#
 # Errors:
 #     - If no background operation is active on this device,
 #       DeviceNotActive
 #
 # Since: 1.1
 ##
-{ 'command': 'block-job-cancel', 'data': { 'device': 'str', '*force': 'bool' },
+{ 'command': 'block-job-cancel',
+  'features': ['deprecated'],
+  'data': { 'device': 'str', '*force': 'bool' },
   'allow-preconfig': true }
 
 ##
@@ -2945,6 +2966,11 @@
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
@@ -2952,6 +2978,7 @@
 # Since: 1.3
 ##
 { 'command': 'block-job-pause', 'data': { 'device': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -2969,6 +2996,11 @@
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
@@ -2976,6 +3008,7 @@
 # Since: 1.3
 ##
 { 'command': 'block-job-resume', 'data': { 'device': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -3000,6 +3033,11 @@
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
@@ -3007,6 +3045,7 @@
 # Since: 1.3
 ##
 { 'command': 'block-job-complete', 'data': { 'device': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -3024,9 +3063,15 @@
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
@@ -3041,9 +3086,15 @@
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
@@ -3103,9 +3154,15 @@
 #
 # Change the block job's options.
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use @job-change
+#     instead.
+#
 # Since: 8.2
 ##
 { 'command': 'block-job-change',
+  'features': ['deprecated'],
   'data': 'JobChangeOptions', 'boxed': true }
 
 ##
-- 
2.34.1


