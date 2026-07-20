Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7E6C4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlpSZ-0007Ik-LN; Mon, 20 Jul 2026 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpST-0007Hm-53
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpSR-0006kV-OM
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784559543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HeOrZ3kheAnQ2xd1pogDdp9y6fqeqok2+BTnc0fWCE=;
 b=d4L5e2ILG2b9X3YGLW5Kh3OVEHnKoYeRzthDJjMJrrYtMoZbfWa1ii+wUaZVXjvkC0SxH0
 lFwgstQ1ip40PIMxImoOtNDMDCYSLk7oPExKhfe5Ko5piP/+OfchCeGcb3rBIgT9gnvo+Q
 919GEqv1nN+oXFIp9xp2ajTgLIBmooU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-k2SWkQdsMDi3dL6hEd_ltg-1; Mon, 20 Jul 2026 10:59:01 -0400
X-MC-Unique: k2SWkQdsMDi3dL6hEd_ltg-1
X-Mimecast-MFC-AGG-ID: k2SWkQdsMDi3dL6hEd_ltg_1784559541
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c01ff996dso76591561cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784559541; x=1785164341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1HeOrZ3kheAnQ2xd1pogDdp9y6fqeqok2+BTnc0fWCE=;
 b=Z1j93MNH22ao3bMUHnhYh5RWSbchgF2Tw5+9Dm6PMhwfUCrejdeu/KPPawEqXMvq6m
 T2CIwwjDT20PSk+cu3FNWIJt2bGvpcfEGY9yYeXBdYtheAwg7O1jUgpT6R7simcpXtPs
 P9vmIOa6M8SZWNNjs/zmUPUywMRq+8Sl/xLKxF74VtSWLuwkcBI3X6tblThu6TGmA2W2
 MDxJFXs0KcA5OZG/pvizFCcJfqsQxUCkTahLQVDIPcjLe30TcQE21Z7qGpzSQYxyxvml
 MQE5EpPGAAvGWjap2ZOOGN8eB/woiuAkhS7H+I+6asSh947w3OVh49qVczri3qKoYsxB
 J92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784559541; x=1785164341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1HeOrZ3kheAnQ2xd1pogDdp9y6fqeqok2+BTnc0fWCE=;
 b=iPs7/8hE7xKgnV1JHMYAE3BKRtMinvxsKg4oHce83WmQC5sz+wwnwjs4NMKMgj9UzL
 YZ4YOsh3fvAfMcT88hT/4TxCnjDX2Zs6O9Ld6ehIyz3rcXS/zxgXW4mhfz75W2OB7SlT
 T5GMd06QgMbG6LaUneP/5njyfNlTZhhYKcbUHl9of8iQU6qkNLdpxjQGstcuS7ekfKuQ
 WEV4dP6VRqOBdnn63yTNEU4jnGkUVNvVtBG1LO/hXcmRczIrPa83vhH+ZcahCREhPk5l
 i2oTke8eXrFy6yoafQo61LIvyVydBz6TeBmivoD7QD3vpxSvxDbUY5i79LcPRAr3C3ji
 Ap/Q==
X-Gm-Message-State: AOJu0YzvR3U6qh1a4x0Bt7UtSRS4exzMy1bzA5UElfaOUqOilZxDWwhT
 mWkXlIXwdU+pXwgZS2436bEnnx2hNWxz8JChr+p3RoWcGSZLvSc5pmwjfW6GyYd/wVNIQ5BTrvi
 jhQRGuf/YwOQO6+XDg/5p9Fwf+mxb5p2v61nctZe+XJNd5D/roTUSXQ/NGvDP4bXWgi8sX4Pfwb
 Nrl7MWyJzqw9rPcunxtr0l7DvMtpKJzXrBcW97hA==
X-Gm-Gg: AfdE7clh0v7vflzvy9dGLO3YkFTDwu/PRSMVXXtD0ruGG798EY1poi0O8F9i+xbn30Y
 qn15WX+fJLti/wwF7zwuQgzATpU4id0us7cBKwWbEanjyW36IVYlAYlXsAiXqPwxJcYvjpNcthA
 2OqoppXErQV6Wqth+iiK31O4mULdVnQvpOLXgUCoOG00FgE7LXuaRddQz8Hk4btgANZoK1qGR0x
 vFAv8OazF7MjW2vgGV03zpbr3i5oyxoTUpntBd4Poh+5VDO78vLpKLnvs+DgvtfuFBq5/WIzLXd
 3jaD8zCUyRkGI5mdALs1+g87HbXsXIauUB8y1Cv89lclSVkd8fhlPQiAL8A63pmuQA==
X-Received: by 2002:ac8:570f:0:b0:51c:1c2c:a8c9 with SMTP id
 d75a77b69052e-5213e48ba34mr120036631cf.43.1784559541155; 
 Mon, 20 Jul 2026 07:59:01 -0700 (PDT)
X-Received: by 2002:ac8:570f:0:b0:51c:1c2c:a8c9 with SMTP id
 d75a77b69052e-5213e48ba34mr120036171cf.43.1784559540418; 
 Mon, 20 Jul 2026 07:59:00 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-521502b9d5bsm75640391cf.31.2026.07.20.07.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:58:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 2/3] migration: fix ineffective overflow assert in postcopy
 blocktime
Date: Mon, 20 Jul 2026 10:58:52 -0400
Message-ID: <20260720145853.1483307-3-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720145853.1483307-1-peterx@redhat.com>
References: <20260720145853.1483307-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Bin Guo <guobin@linux.alibaba.com>

vcpu_faults_current[] is uint8_t.  The overflow assert was checked
after the post-increment, so 255 would wrap to 0 and the assert
would pass silently.  Move the check before the increment and use
< 255.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Link: https://lore.kernel.org/r/20260716101952.65329-2-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 980b938a4c..b0828edb3e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1093,7 +1093,11 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         /*
          * Account how many concurrent faults on this vCPU we trapped.  See
          * comments above vcpu_faults_current[] on why it can be more than one.
+         *
+         * vcpu_faults_current[] is uint8_t, so assert before incrementing to
+         * catch overflow before it wraps.
          */
+        assert(dc->vcpu_faults_current[cpu] < 255);
         if (dc->vcpu_faults_current[cpu]++ == 0) {
             dc->smp_cpus_down++;
             /*
@@ -1103,9 +1107,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
              */
             dc->last_begin = current;
         }
-
-        /* Making sure it won't overflow - it really should never! */
-        assert(dc->vcpu_faults_current[cpu] <= 255);
     } else {
         /*
          * For non-vCPU thread faults, we don't care about tid or cpu index
-- 
2.54.0


