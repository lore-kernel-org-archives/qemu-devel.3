Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04A6C021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj74z-0004Bh-Qb; Fri, 14 Feb 2025 20:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2NO-0007TM-SQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:32 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2NM-0002IX-P0
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:30 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F3D421182;
 Fri, 14 Feb 2025 20:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4seZA57hu09V3I00/1rURrrFtCTriO0ttU2uqwkIA2Q=;
 b=UizfHk1PIeSVPvWoiuBEgY9S7zcqOokx8t5eCpY+Amc2bXvf9EuB9LaQM4YYRzTcE7Ulz9
 DehyeK/ssOHaOtkfP6+D0Dk83B+dru7aT02ttmc/YNMnEm0c7s7Fzdvhz0iDv8jhVtZXf9
 NL87GexbzAeeNny57iFsYzW2tKhWU5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4seZA57hu09V3I00/1rURrrFtCTriO0ttU2uqwkIA2Q=;
 b=JR35HAL7BL4s2VgQoWW1b/GQEQJ/HH95YwfVx6HbvDhJhdp/tkpnOIt4dNDeoZRGYwS1nw
 HBzjOWfT4OsBquDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4seZA57hu09V3I00/1rURrrFtCTriO0ttU2uqwkIA2Q=;
 b=UizfHk1PIeSVPvWoiuBEgY9S7zcqOokx8t5eCpY+Amc2bXvf9EuB9LaQM4YYRzTcE7Ulz9
 DehyeK/ssOHaOtkfP6+D0Dk83B+dru7aT02ttmc/YNMnEm0c7s7Fzdvhz0iDv8jhVtZXf9
 NL87GexbzAeeNny57iFsYzW2tKhWU5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4seZA57hu09V3I00/1rURrrFtCTriO0ttU2uqwkIA2Q=;
 b=JR35HAL7BL4s2VgQoWW1b/GQEQJ/HH95YwfVx6HbvDhJhdp/tkpnOIt4dNDeoZRGYwS1nw
 HBzjOWfT4OsBquDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C91013AEB;
 Fri, 14 Feb 2025 20:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SP6KLmmor2cgEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 20:32:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 22/22] guestperf: Add test result data into report
Date: Fri, 14 Feb 2025 17:31:59 -0300
Message-Id: <20250214203159.30168-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214203159.30168-1-farosas@suse.de>
References: <20250214203159.30168-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

The migration result data is not included in the guestperf
report information; include the result as a report entry
so the developer can check whether the migration was successful
after running guestperf.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Message-ID: <6303400c2983ffe5647f07caa6406f00ceae4581.1739530098.git.yong.huang@smartx.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/migration-stress/guestperf/engine.py | 10 ++++++++--
 tests/migration-stress/guestperf/report.py | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tests/migration-stress/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
index e11f6a8496..d8462db765 100644
--- a/tests/migration-stress/guestperf/engine.py
+++ b/tests/migration-stress/guestperf/engine.py
@@ -24,7 +24,7 @@
 import time
 
 from guestperf.progress import Progress, ProgressStats
-from guestperf.report import Report
+from guestperf.report import Report, ReportResult
 from guestperf.timings import TimingRecord, Timings
 
 sys.path.append(os.path.join(os.path.dirname(__file__),
@@ -276,7 +276,11 @@ def _migrate(self, hardware, scenario, src,
                         src_vcpu_time.extend(self._vcpu_timing(src_pid, src_threads))
                         sleep_secs -= 1
 
-                return [progress_history, src_qemu_time, src_vcpu_time]
+                result = ReportResult()
+                if progress._status == "completed" and not paused:
+                    result = ReportResult(True)
+
+                return [progress_history, src_qemu_time, src_vcpu_time, result]
 
             if self._verbose and (loop % 20) == 0:
                 print("Iter %d: remain %5dMB of %5dMB (total %5dMB @ %5dMb/sec)" % (
@@ -490,6 +494,7 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             progress_history = ret[0]
             qemu_timings = ret[1]
             vcpu_timings = ret[2]
+            result = ret[3]
             if uri[0:5] == "unix:" and os.path.exists(uri[5:]):
                 os.remove(uri[5:])
 
@@ -509,6 +514,7 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
                           Timings(self._get_timings(src) + self._get_timings(dst)),
                           Timings(qemu_timings),
                           Timings(vcpu_timings),
+                          result,
                           self._binary, self._dst_host, self._kernel,
                           self._initrd, self._transport, self._sleep)
         except Exception as e:
diff --git a/tests/migration-stress/guestperf/report.py b/tests/migration-stress/guestperf/report.py
index 1efd40c868..e135e01be6 100644
--- a/tests/migration-stress/guestperf/report.py
+++ b/tests/migration-stress/guestperf/report.py
@@ -24,6 +24,22 @@
 from guestperf.progress import Progress
 from guestperf.timings import Timings
 
+class ReportResult(object):
+
+    def __init__(self, success=False):
+        self._success = success
+
+    def serialize(self):
+        return {
+            "success": self._success,
+        }
+
+    @classmethod
+    def deserialize(cls, data):
+        return cls(
+            data["success"])
+
+
 class Report(object):
 
     def __init__(self,
@@ -33,6 +49,7 @@ def __init__(self,
                  guest_timings,
                  qemu_timings,
                  vcpu_timings,
+                 result,
                  binary,
                  dst_host,
                  kernel,
@@ -46,6 +63,7 @@ def __init__(self,
         self._guest_timings = guest_timings
         self._qemu_timings = qemu_timings
         self._vcpu_timings = vcpu_timings
+        self._result = result
         self._binary = binary
         self._dst_host = dst_host
         self._kernel = kernel
@@ -61,6 +79,7 @@ def serialize(self):
             "guest_timings": self._guest_timings.serialize(),
             "qemu_timings": self._qemu_timings.serialize(),
             "vcpu_timings": self._vcpu_timings.serialize(),
+            "result": self._result.serialize(),
             "binary": self._binary,
             "dst_host": self._dst_host,
             "kernel": self._kernel,
@@ -78,6 +97,7 @@ def deserialize(cls, data):
             Timings.deserialize(data["guest_timings"]),
             Timings.deserialize(data["qemu_timings"]),
             Timings.deserialize(data["vcpu_timings"]),
+            ReportResult.deserialize(data["result"]),
             data["binary"],
             data["dst_host"],
             data["kernel"],
-- 
2.35.3


