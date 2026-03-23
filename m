Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41138F46124
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ft9-00060N-Uu; Mon, 23 Mar 2026 10:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fp9-0000pD-OP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:15 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fp8-00073m-1x
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:07 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2F30720B6F1B;
 Mon, 23 Mar 2026 06:59:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F30720B6F1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274395;
 bh=+GcfDGF+p4TwuNzdDU1vHppWDYVvy/FB9/c/HXYoevs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UVeLNgdI5nYWCu1OyAzf3VaXpB1gaFTPxadDDb6zHvYkUhmfNatrjByuo91FHcEXi
 AVJCN2Zt+lbprqjSuAah2EzDGjyvaOGFbM22H3Mt6XYwhgXiRwJB8tNALufhPHeiY2
 unvfwFRqfmC6PGyPiibJHBt4ed0rqPMOcSd2D39s=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 26/32] accel/mshv: migrate REFERENCE_TIME
Date: Mon, 23 Mar 2026 14:58:06 +0100
Message-Id: <20260323135812.383509-27-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is a partition-wide state that we use a dedicated handler for. It
is stored as-is in the "mshv" savevm_live field. We might have to extend
this later if we have more partition-wide state to roundtrip.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 70 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 22e838ede6..3927a82925 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -85,13 +85,81 @@ static int set_time_freeze(int vm_fd, int freeze)
     return 0;
 }
 
+static int get_reference_time(int vm_fd, uint64_t *ref_time)
+{
+    int ret;
+    struct hv_input_get_partition_property in = {0};
+    struct hv_output_get_partition_property out = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_REFERENCE_TIME;
+
+    args.code = HVCALL_GET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+    args.out_sz = sizeof(out);
+    args.out_ptr = (uint64_t)&out;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to get reference time");
+        return -1;
+    }
+
+    *ref_time = out.property_value;
+    return 0;
+}
+
 static void mshv_save_state(QEMUFile *f, void *opaque)
 {
-    return;
+    MshvState *s = opaque;
+    uint64_t ref_time;
+    int ret;
+
+    ret = get_reference_time(s->vm, &ref_time);
+    if (ret < 0) {
+        error_report("Failed to get reference time for migration");
+        abort();
+    }
+
+    qemu_put_be64(f, ref_time);
+}
+
+static int set_reference_time(int vm_fd, uint64_t ref_time)
+{
+    int ret;
+    struct hv_input_set_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+
+    in.property_code = HV_PARTITION_PROPERTY_REFERENCE_TIME;
+    in.property_value = ref_time;
+
+    args.code = HVCALL_SET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to set reference time");
+        return -1;
+    }
+
+    return 0;
 }
 
 static int mshv_load_state(QEMUFile *f, void *opaque, int version_id)
 {
+    MshvState *s = opaque;
+    uint64_t ref_time;
+    int ret;
+
+    ref_time = qemu_get_be64(f);
+
+    ret = set_reference_time(s->vm, ref_time);
+    if (ret < 0) {
+        error_report("Failed to set reference time after migration");
+        return -1;
+    }
     return 0;
 }
 
-- 
2.34.1


