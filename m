Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9C0C531FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEDj-0004ry-AM; Fri, 24 Jul 2026 07:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEDg-0004qx-Sr
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEDe-0004ry-RD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784893052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=HYrlgk4NRu+atgPqtj2MinUpHk8QfqRGN1Pu3PAuDro=;
 b=dulAOOf537pDJlqiS/KePpNWMz62p7VRe9ZWdn/Yd9Sc5L9gmZaZkqvJZbTxG8sfEd8fVZ
 1MNyptxuuvfVoIDkZeIjPdOFYJ4kaqvj1fCFKm0T7+7mmZf0FSfmTm73IX2NG9p/fl4MhC
 CU8pXUyU4ld1fsDDUDTkRCj0C4MyUgU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-meWQh_o1OXS5ilthEh1ckQ-1; Fri, 24 Jul 2026 07:37:31 -0400
X-MC-Unique: meWQh_o1OXS5ilthEh1ckQ-1
X-Mimecast-MFC-AGG-ID: meWQh_o1OXS5ilthEh1ckQ_1784893050
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47407691804so287314f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784893050; x=1785497850; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HYrlgk4NRu+atgPqtj2MinUpHk8QfqRGN1Pu3PAuDro=;
 b=RSpQcbYfsz7Iwoj4QPZqqVSFy1EEhyXvjoIWF9F9C+DJqhZ2NIcfNuJZ9NUd/PV8y3
 EKdFYna0d7VlFI7UdKsGdi3FdBhRSmTopepMVPICleiZvDfJAft9s7IsV1MUb9SE+w0c
 owlQpzqL4OBwB99R6NKbvxfjrOPxDifYwFixGi1EX3f7u4hzI2l+jxpsu1NKopKF/GpQ
 GGszvq+YE4DvSgUfGISUs5AupU8FA6MqIb0aSoNdb2d4jag+30wtc4g7W7mr0PM4c7pU
 fT2CO+Kmc3UTyN5fcAyDoLO1ba14XD1Dbg5T/xAAX/dawlOZHSkF+oCbWpcMubAzUda3
 QeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784893050; x=1785497850;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYrlgk4NRu+atgPqtj2MinUpHk8QfqRGN1Pu3PAuDro=;
 b=S1vjr8pNZ3MWHw50/7QKD+Lp25Yof2ynzwLt1xKRzoXkKf2YUEZK1Lv4xUxOpAYHlU
 x/wRCTG+KM8KZ34KRz1zI6Ic8ctblgh5EkCplxoRaVah+6Rtz0/5rCVJTzCFjRj8FXTr
 S9pmu4kAsAb+f317DJr7e0MbwYSeSmXRiLrPCecdvp7WpsPpfNlKxnzw/ceHH/uyn+bd
 X2uUFrKdgnSFnb/egDUqF1lszHxPcTjW4/B36FufWYtBZ4EIv5f2rOeDP4lXjx2fL0R8
 F1ORW4Y58ND5Z/6Mbd4Qc+cJwdJGZF47BhU1BS3HeuRpqTuqtwYRpIZVIw+f/wgMTLpF
 4qbA==
X-Gm-Message-State: AOJu0YyTlEaErlDj0N5g92PAFH2corAr9dy/J6DHHz+TjThHsRw2S7V4
 CQx3i72yE0ZgWiTx27Sh/s6EKncP71aQuRyWKabipw6vmvfDoNXL3ns7yaz3OZhru4S3fvx2Hqz
 ZGUpGv5BLRlRppqe+BPXXPhajPihDidEwSNy9u5D5SmIxr0DQ51HNbdYc+q5aLqEm8mj6neUXAk
 brLhs+tot+Os08LyR1YVoMJTNI9x+Simozxw==
X-Gm-Gg: AR+sD12NA4IMl0w6gJ4mCFSBZoQLkCuG47q8n336Vj4YDr7mJ/u9+4fPdVa563/9chn
 uzYGuK4AWOEFJjtoKXDKDOmNMWxXBNW4xokfFA0maZvvmBK8RgPst8JmwQqehm9uiMwTsqzwkEv
 hZ4ctyYTdhAyls6SEJquilouSY32XMPHZoP6uUVpLz1U0UiDq+AtmeWouTKgB5s6eKFbNc5kw0z
 IILLRQAWFx1cWqwsZ3GxQC9lppZZ/pLgcrRaASthuBdRJ5niHeJhksBQs4Mx06dEhTxFr+I+H3y
 g9cyoTC1qgQfEsN7c39hK8aFIonWzxIdRFN11dmPG6D0W/66yGoZAI9T8LmO6A33i1Bv5qqP1b1
 Hec4oHgnfwmarvp/GGV6rIw==
X-Received: by 2002:a05:6000:1ac9:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-47f8d77c30amr8606718f8f.15.1784893049892; 
 Fri, 24 Jul 2026 04:37:29 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac9:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-47f8d77c30amr8606663f8f.15.1784893049300; 
 Fri, 24 Jul 2026 04:37:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96b9abc0sm5285807f8f.32.2026.07.24.04.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:37:28 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:37:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/2] libvhost-user: validate last_batch_head in
 vu_check_queue_inflights
Message-ID: <8133770c75c9907578dd551f4d468140a0a75cd2.1784892981.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

vu_check_queue_inflights uses last_batch_head from the frontend-controlled
inflight shared memory as an index into desc[] without bounds checking.
A malicious or buggy frontend can set last_batch_head >= desc_num,
causing an out-of-bounds write.

Validate last_batch_head before using it.
Note: the value is not guest-accessible so not a security vulnerability.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3974
Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 42a5e2f1f5..c1c13dbc90 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1379,6 +1379,12 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
     vq->counter = 0;
 
     if (unlikely(vq->inflight->used_idx != vq->used_idx)) {
+        if (vq->inflight->last_batch_head >= vq->inflight->desc_num) {
+            vu_panic(dev, "vu_check_queue_inflights: last_batch_head %u "
+                     "out of range (desc_num %u)",
+                     vq->inflight->last_batch_head, vq->inflight->desc_num);
+            return -1;
+        }
         vq->inflight->desc[vq->inflight->last_batch_head].inflight = 0;
 
         barrier();
-- 
MST


