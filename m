Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F91C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9732-00035S-GO; Tue, 22 Sep 2026 16:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972T-0001TF-R7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972Q-0000bx-Q1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gR49i4+niEICCi44ryps2dZ91z+ksJEBI0Zh0aQGr5E=;
 b=avwH8B15r4hTQj7skFdP7KXcOuoWL5t6JjRiq8AkwMoS5N/vzN/12QCyQDL8wXrDNUa2kr
 zbWY3AFyk/EMoDE+nJrDEsO2Z1IDA7erzyQgiH5AX7+fG6ciqg5LLKXvCZ/wfeYLWyb9Mn
 E4O6Bpy5y7sVyLvhl9WVeIyHg7XIPas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-jHVxkblvN-SBepJ4uU9kfQ-1; Tue,
 22 Sep 2026 16:24:24 -0400
X-MC-Unique: jHVxkblvN-SBepJ4uU9kfQ-1
X-Mimecast-MFC-AGG-ID: jHVxkblvN-SBepJ4uU9kfQ_1790108663
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D315F1800630; Tue, 22 Sep 2026 20:24:23 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2464300106D; Tue, 22 Sep 2026 20:24:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:34 +0400
Subject: [PATCH 87/88] qemu-iotests: remove HMP framework support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-87-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8553;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VOUjYlRNJjQNTrtdMtPqLAZ8ycUHBKNzr6j7Y2dPJHE=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqy4rSgow6t+neNiZ2tZxP4SuChH2wdKTkkSVPlGxH7X46R+
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqsuK0AAoJENro4Ql1lpzlUyIP+QHI
 2rZ+OOpBzg2Nzf+q7HaRoT4SSS7Zz0hGS7qXNpUmjh50NsFQvIrg6hOY4KhKnvSZXzy68kPyTa7
 3Pnb1VCcGUAiB7wkfSVobgJxsJNBI8lcd9AA+HDI/IEcRRRbNdbYavlYVkqfV0JHDj49E5r2brs
 jk03pVAJsThcs1+wxvbxVvxiqcvf1yTyLwS5pxQmp94snkOLWKd2pWEgD9+w76b7xU5GTx65JFj
 SdlVeX6MDp2C6BlfjusbKRsfGcdxvOptJaZtCaqE9rOTmp4IWZTKxRBCOBlz79XEWApkZNl0a5S
 C1Hvne+qdtY5hbDNn856ehzMknCIQHucKjXUNQSxOt/EbpGoa34GbjLC1gIp/kBaSIWnyLUGVLi
 IsbBkmS9Me5ulNRD2ddbvWB3m4PkgLQEhsQtSxvKyX3eDGZDFVWrJOGktokfaJVO8XKezrnzo2W
 HRJZ1VgTbzk/TFRgrYw+/jQ//ycvwT7zwKDBZm5evk2C9CscbEtifS+SvGyMp9e9HT0AOhf2lRl
 kRxusW2IKWaJwUC3KEBgo96pBHf1I6OoIRdHXw8fXKx6PNvhmTKRvVtlZ8AGV4CvpcJEh6HOmvZ
 jhhF+v8SG4PYXPW68I2mOzR5XtylI1mRciGBwKYt7hSmlohnZgBFr6Wj74rF87aQ3psxMjQHCjT
 T9CrR
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All tests have been migrated to QMP. Remove:
- _require_hmp() from common.rc
- _filter_hmp() from common.filter
- _filter_hmp from pipelines in common.qemu
- HMP monitor mode from _launch_qemu() in common.qemu
- hmp() method from iotests.py VM class
- _verify_hmp() and require_hmp parameter from iotests.py

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/common.filter |  7 -------
 tests/qemu-iotests/common.qemu   | 34 +++++++++++-----------------------
 tests/qemu-iotests/common.rc     |  8 --------
 tests/qemu-iotests/iotests.py    | 28 +---------------------------
 4 files changed, 12 insertions(+), 65 deletions(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index f6d94f993691..1ed2004c494f 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -102,13 +102,6 @@ _filter_qmp()
         -e '    QMP_VERSION'
 }
 
-# readline makes HMP command strings so long that git complains
-_filter_hmp()
-{
-    gsed -e $'s/^\\((qemu) \\)\\?.*\e\\[D/\\1/g' \
-        -e $'s/\e\\[K//g'
-}
-
 # replace block job offset
 _filter_block_job_offset()
 {
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index 458ea9566818..dbc286320b3d 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -119,7 +119,7 @@ _timed_wait_for()
 
         if [ -z "${silent}" ] && [ -z "${mismatch_only}" ]; then
             echo "${resp}" | _filter_testdir | _filter_qemu \
-                           | _filter_qemu_io | _filter_qmp | _filter_hmp
+                           | _filter_qemu_io | _filter_qmp
         fi
         if [ -n "${failure_match}" ]; then
             grep -q "${failure_match}" < <(echo "${resp}")
@@ -134,7 +134,7 @@ _timed_wait_for()
         fi
         if [ -z "${silent}" ] && [ -n "${mismatch_only}" ]; then
             echo "${resp}" | _filter_testdir | _filter_qemu \
-                           | _filter_qemu_io | _filter_qmp | _filter_hmp
+                           | _filter_qemu_io | _filter_qmp
         fi
 
     done
@@ -244,7 +244,7 @@ _check_cached_events()
             grep -q "$match" < <(echo "${ev}")
             if [ $? -eq 0 ] && [ $matched = 0 ]; then
                 echo "${ev}" | _filter_testdir | _filter_qemu \
-                           | _filter_qemu_io | _filter_qmp | _filter_hmp
+                           | _filter_qemu_io | _filter_qmp
                 matched=1
             else
                 QEMU_EVENTS="${QEMU_EVENTS:+${QEMU_EVENTS}%}${ev}"
@@ -312,9 +312,6 @@ _run_qmp_job()
 # Launch a QEMU process.
 #
 # Input parameters:
-# $qemu_comm_method: set this variable to 'monitor' (case insensitive)
-#                    to use the QEMU HMP monitor for communication.
-#                    Otherwise, the default of QMP is used.
 # $qmp_pretty: Set this variable to 'y' to enable QMP pretty printing.
 # $keep_stderr: Set this variable to 'y' to keep QEMU's stderr output on stderr.
 #               If this variable is empty, stderr will be redirected to stdout.
@@ -327,16 +324,10 @@ _launch_qemu()
     local fifo_out=
     local fifo_in=
 
-    if (shopt -s nocasematch; [[ "${qemu_comm_method}" == "monitor" ]])
-    then
-        comm="-monitor stdio"
+    if [ "$qmp_pretty" = "y" ]; then
+        comm="-monitor none -qmp-pretty stdio"
     else
-        local qemu_comm_method="qmp"
-        if [ "$qmp_pretty" = "y" ]; then
-            comm="-monitor none -qmp-pretty stdio"
-        else
-            comm="-monitor none -qmp stdio"
-        fi
+        comm="-monitor none -qmp stdio"
     fi
 
     fifo_out=${QEMU_FIFO_OUT}_${_QEMU_HANDLE}
@@ -379,13 +370,10 @@ _launch_qemu()
     QEMU_IN[${_QEMU_HANDLE}]=${_in_fd}
     QEMU_STATUS[${_QEMU_HANDLE}]=0
 
-    if [ "${qemu_comm_method}" == "qmp" ]
-    then
-        # Don't print response, since it has version information in it
-        silent=yes _timed_wait_for ${_QEMU_HANDLE} "capabilities"
-        if [ "$qmp_pretty" = "y" ]; then
-            silent=yes _timed_wait_for ${_QEMU_HANDLE} "^}"
-        fi
+    # Don't print response, since it has version information in it
+    silent=yes _timed_wait_for ${_QEMU_HANDLE} "capabilities"
+    if [ "$qmp_pretty" = "y" ]; then
+        silent=yes _timed_wait_for ${_QEMU_HANDLE} "^}"
     fi
     QEMU_HANDLE=${_QEMU_HANDLE}
     let _QEMU_HANDLE++
@@ -416,7 +404,7 @@ _cleanup_qemu()
 
         if [ -n "${wait}" ]; then
             cat <&${QEMU_OUT[$i]} | _filter_testdir | _filter_qemu \
-                                  | _filter_qemu_io | _filter_qmp | _filter_hmp
+                                  | _filter_qemu_io | _filter_qmp
         fi
         rm -f "${QEMU_FIFO_IN}_${i}" "${QEMU_FIFO_OUT}_${i}"
         eval "exec ${QEMU_IN[$i]}<&-"   # close file descriptors
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 262fe63da820..bcb1ec50a93d 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -995,14 +995,6 @@ _notrun_on_fuse_error()
     esac
 }
 
-_require_hmp()
-{
-    if echo quit | $QEMU -M none -display none -monitor stdio 2>&1 |
-            grep -q "HMP monitor is not available"; then
-        _notrun "HMP monitor not available"
-    fi
-}
-
 # Check that we have a file system that allows huge (but very sparse) files
 #
 _require_large_file()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5d9b5ded64ac..b9c6878c3bce 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -934,14 +934,6 @@ def add_paused(self):
         self._args.append('-S')
         return self
 
-    def hmp(self, command_line: str, use_log: bool = False) -> QMPMessage:
-        cmd = 'human-monitor-command'
-        kwargs: Dict[str, Any] = {'command-line': command_line}
-        if use_log:
-            return self.qmp_log(cmd, **kwargs)
-        else:
-            return self.qmp(cmd, **kwargs)
-
     def pause_drive(self, drive: str, event: Optional[str] = None) -> None:
         """Pause drive r/w operations"""
         if not event:
@@ -954,12 +946,6 @@ def resume_drive(self, drive: str) -> None:
         """Resume drive r/w operations"""
         self.qmp_qemu_io(drive, f'remove_break bp_{drive}')
 
-    def hmp_qemu_io(self, drive: str, cmd: str,
-                    use_log: bool = False, qdev: bool = False) -> QMPMessage:
-        """Write to a given drive using an HMP command"""
-        d = '-d ' if qdev else ''
-        return self.hmp(f'qemu-io {d}{drive} "{cmd}"', use_log=use_log)
-
     def qmp_qemu_io(self, drive: str, cmd: str,
                     use_log: bool = False, qdev: bool = False) -> str:
         """Write to a given drive using the x-qemu-io QMP command"""
@@ -1464,15 +1450,6 @@ def _verify_formats(required_formats: Sequence[str] = ()) -> None:
         notrun(f'formats {usf_list} are not whitelisted')
 
 
-def _verify_hmp() -> None:
-    args = [qemu_prog] + qemu_opts + ['-M', 'none', '-monitor', 'stdio']
-    with subprocess.Popen(args, stdin=subprocess.PIPE,
-                          stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
-                          universal_newlines=True) as subp:
-        out, _ = subp.communicate('quit\n')
-    if 'HMP monitor is not available' in out:
-        notrun('HMP monitor not available')
-
 def _verify_virtio_blk() -> None:
     out = qemu_pipe('-M', 'none', '-device', 'help')
     if 'virtio-blk' not in out:
@@ -1711,8 +1688,7 @@ def execute_setup_common(supported_fmts: Sequence[str] = (),
                          supported_protocols: Sequence[str] = (),
                          unsupported_protocols: Sequence[str] = (),
                          required_fmts: Sequence[str] = (),
-                         unsupported_imgopts: Sequence[str] = (),
-                         require_hmp: bool = False) -> bool:
+                         unsupported_imgopts: Sequence[str] = ()) -> bool:
     """
     Perform necessary setup for either script-style or unittest-style tests.
 
@@ -1733,8 +1709,6 @@ def execute_setup_common(supported_fmts: Sequence[str] = (),
     _verify_formats(required_fmts)
     _verify_virtio_blk()
     _verify_imgopts(unsupported_imgopts)
-    if require_hmp:
-        _verify_hmp()
 
     return debug
 

-- 
2.56.0.rc0.29.g47ce80527c56


