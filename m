Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE10C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 19:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0mmX-0003Tw-9y; Fri, 04 Apr 2025 15:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0mmM-0003SJ-3p; Fri, 04 Apr 2025 15:32:39 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0mmF-0001Q3-Uc; Fri, 04 Apr 2025 15:32:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 042C461A02;
 Fri,  4 Apr 2025 22:32:23 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:1220::1:20])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uVf6w50Fh0U0-XROKwORI; Fri, 04 Apr 2025 22:32:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743795142;
 bh=G6rNw37v3c0+h+0j6g23hzcC5gpnF41QnEWw8HdTPcg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dtteDE/7sGUaQBEt3L38wqlpcaW6/zIWIg8I9toHPe9UQuNacNW/2FLmWnLIin4Zi
 FF/0g4tkXIEIv/WQnr6wOrYGXvHTmvGTRc4iwTp/jhzXoKzlX04dWpcfGhyiSNrl/f
 YTRkVXcjPjp+PbgIOBrick7yQafAGqqVwGzCIny0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 devel@lists.libvirt.org, pkrempa@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH v2 2/2] qapi/block-core: derpecate some block-job- APIs
Date: Fri,  4 Apr 2025 22:31:54 +0300
Message-ID: <20250404193154.707145-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250404193154.707145-1-vsementsov@yandex-team.ru>
References: <20250404193154.707145-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ACKed-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/about/deprecated.rst | 31 +++++++++++++++++++++++++++++++
 qapi/block-core.json      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 76291fdfd6..afa7075051 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -148,6 +148,37 @@ options are removed in favor of using explicit ``blockdev-create`` and
 ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
 details.
 
+``block-job-pause`` (since 10.1)
+''''''''''''''''''''''''''''''''
+
+Use ``job-pause`` instead. The only difference is that ``job-pause``
+always reports GenericError on failure when ``block-job-pause`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-resume`` (since 10.1)
+'''''''''''''''''''''''''''''''''
+
+Use ``job-resume`` instead. The only difference is that ``job-resume``
+always reports GenericError on failure when ``block-job-resume`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-complete`` (since 10.1)
+'''''''''''''''''''''''''''''''''''
+
+Use ``job-complete`` instead. The only difference is that ``job-complete``
+always reports GenericError on failure when ``block-job-complete`` reports
+DeviceNotActive when block-job is not found.
+
+``block-job-dismiss`` (since 10.1)
+''''''''''''''''''''''''''''''''''
+
+Use ``job-dismiss`` instead.
+
+``block-job-finalize`` (since 10.1)
+'''''''''''''''''''''''''''''''''''
+
+Use ``job-finalize`` instead.
+
 ``query-migrationthreads`` (since 9.2)
 ''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d74a1f8b8b..aa2288d6fd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2969,6 +2969,11 @@
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
@@ -2976,6 +2981,7 @@
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
@@ -3025,6 +3037,11 @@
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
@@ -3032,6 +3049,7 @@
 # Since: 1.3
 ##
 { 'command': 'block-job-complete', 'data': { 'device': 'str' },
+  'features': ['deprecated'],
   'allow-preconfig': true }
 
 ##
@@ -3051,9 +3069,15 @@
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
@@ -3073,9 +3097,15 @@
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


