Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D25C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 01:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tikuu-0006cL-9w; Thu, 13 Feb 2025 20:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikus-0006cD-1r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:54 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikuq-0004OI-Ca
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:53 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so36764755ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 17:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739498091; x=1740102891;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVFXlsrJ6uqFDQzwPn+Dorbteo5aZgEE94Bb7QudTvo=;
 b=LMvgGEIoGABrSlGSr8VXsIrEch8UBxBpcVxt4Wbg8bjKTtCBTeM8IcT3bdC8mmaAiG
 FwpGVt3ZK1wreJTGgAgReyrItFnhtIjhZJRygHvhLx+K4XuNsV+/AlY2iKIPLE5moqBM
 IS9N1zaBy+qUpyLp5q3IL0MkholIXQJGZb+B7OqTyruHeI76Tz44/dwj8KsagQbbwmQY
 rSz8aLkrOsd6uOWjfeEJa7/cxUwOUug3j94u5xnmrkTHvXkyeqvucRuetHnD9+9JuXPz
 yoRFaAUPyWZTtga9MVmby4qXMgzW3D3FxENYceP3ER9hr6hE6jK82knTfDnvyw0s5bT/
 T8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739498091; x=1740102891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVFXlsrJ6uqFDQzwPn+Dorbteo5aZgEE94Bb7QudTvo=;
 b=XzjEJcAvJGe0Bjvf3/CQ8llRJf0f95IgApwmtNayV6cUmgF9amykg4F3se5Co6E8fF
 Ke5QpaNj9Ymjx4NKo9/1yglsZzoC6QcTLgbSpc0xZ0O+9w9/+vS7ybcI8uncKkkq/9aL
 sYZRrQTHVNG/CrrGxGU4gL31pGZihVJn5+wq4BLTNMzUZYtlUOL2nxlzKuhp3u/gi5u9
 WnjNqlpYYTi2wj68DxoBczDJf6gMKVHAirqeV1iP+mBUWanrvgcymxfcAXJwgxTUx3VE
 +Z4pXNhGMnkZ+/Jqm3nLxrMytuxn5m2DQNNOUuNC6sxzKmzZ+YC2k69MEaJTSVMfdq6c
 qwrw==
X-Gm-Message-State: AOJu0YyppK4WEsw76IrAMPFf+lUef7qbHQjisUqQ1nRC8OTrpU6vr7i2
 0xi33m71UPNQyyKMCzRYhpUrgR30ob0XwMHTZmThfYBpq8ELxtHNBubr/r/rhuCrNPhwt5PPmkV
 QNey9Hak+
X-Gm-Gg: ASbGncsARCtrET1yf4kZjKLf9Ci8ZyuX7/p6Q7WW79omwDVfdYeI3/7ONw5lItu6TQE
 Gq+/bOzeg6z7QPA+ChNk5dc17vapXtQBzghrVIXvGjLnvC94ryWrXWh9neNbpXRiUVEQR59M3Hi
 74l5ZRp7ArozdlggVtCsFflK7l65pkRJvbRSW1Lml/JKEcnFLiFX5Q/ZruHy42hJMHppLiqrsoz
 IIXMmCE32VaNeFzds8f1KTkjuFgtxGqZv++tdK9CyUABw181vcxTMPHGKSa7m/o97QJF1rmq6S4
 Gzg5XAY5LpZxofT39i0pOK/sxZcS9vY2EsO6Hf87
X-Google-Smtp-Source: AGHT+IEMr8r1D2mBahIy+3Wi+rk8IKg9kZb7JYZS+mYYyKZBn8MzYAcHSk3duSVqre/rcDQLzIG0jg==
X-Received: by 2002:a17:902:d511:b0:21a:8d70:3865 with SMTP id
 d9443c01a7336-220bbb21947mr165166025ad.14.1739498090721; 
 Thu, 13 Feb 2025 17:54:50 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d67fsm18831515ad.143.2025.02.13.17.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 17:54:50 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v4 4/4] guestperf: Add test result data into report
Date: Fri, 14 Feb 2025 09:53:36 +0800
Message-Id: <6303400c2983ffe5647f07caa6406f00ceae4581.1739497707.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739497707.git.yong.huang@smartx.com>
References: <cover.1739497707.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
2.27.0


