Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411EECD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAS-0007gA-93; Sun, 14 Jun 2026 15:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAP-0007cS-2D
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAN-0001ld-Iz
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g1F4+IF5etRgwNV0vS9HbRXkwL6EBjEu8mYuHWvbVi0=;
 b=Hp254rLM2twkyQYr83J6dJiVzJjjcyTVwQKqbXf9tceJqFQmhq3Kp1QDW4yF2XFWJdR0gl
 1RmCwotUYtN+gzEtfQ+yJUxpgAIXTdxKhcJ6vZ7cKE0XIxoMXKQmYSUkgyXiFcvOn53eg4
 0TR7rObO1Y4mYer6z+V1TSfqzfpNMmM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-pDfqzd4hNmqkDuFJz6OPww-1; Sun, 14 Jun 2026 15:06:41 -0400
X-MC-Unique: pDfqzd4hNmqkDuFJz6OPww-1
X-Mimecast-MFC-AGG-ID: pDfqzd4hNmqkDuFJz6OPww_1781464000
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767b782so15954845e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464000; x=1782068800; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g1F4+IF5etRgwNV0vS9HbRXkwL6EBjEu8mYuHWvbVi0=;
 b=I+qLEFQSRorQAiUItuZbtnWhSBfdVJHMTSrZDLwsyMvfm/BR7whSc52tgHA1bUvWQm
 anxZcWDZ0Vm1MOCO+j8AT+U0kvqQH0efWsiMEwqALPiq2CZrjvVvFdEqQXYDJdzBnuP/
 5DgSg3pL40EpUq5jE7NN9ROIg1kf+jedxujYrrOAiXqlTPZvE620MTl2C71+qg/03rcl
 qrwmInm5lxKOmcmdUY5AcDUaw3JDAxrECsSQGPLxHpaF+Nnd6A5ZXi3KnbetV31Zjlk/
 DeydfJBM9dy95x4+B05KFHCA7H3sl3QwCb6M2Ut0I+f7c4HKFlhAGOh8HoiP57Pn+KQt
 d+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464000; x=1782068800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1F4+IF5etRgwNV0vS9HbRXkwL6EBjEu8mYuHWvbVi0=;
 b=mXnZDusfs5/sjTZR44lwEmTR0LytXLBcTp3Y7OaYA8BCg2WGdUU7FrerhNI9ZWLmrP
 EQggvnFrvzrbP12k+TiGQY7oXZYUju8sKLsMM0+ZFfVkXZ08+ovsP7kLSmGUM2Voof90
 QwFVywWJ7QPEiYGmZ1R6Xg+FJzhC7Lb27XkSy0P+bB9q9DNeKbE+ccbgGmZ7AcP7XDMi
 x30Zn+Sscyy7vflucquGOK7uLUP4soSA76RKmevcNIGSFhHvy9f42zavHhkeL1tTz6Je
 MLFF4R446d3Ca5nW2brXa6kTDuLB2BwgK0DPZ1h1FB2bn2eO5fO8DUsat5tdW+KRXUUJ
 TNcg==
X-Gm-Message-State: AOJu0YwUwH6BhBX0mbVUm2qtD+mB6bvlR2ZQGlk2QfzCo97CAqUZw3p8
 3RqWLps2e5yv9E0e/xZFviOOEkFsYgkNuUpq2Rpv0/uoi719jzKBx9i0euUWdKUR82PRcuzLqM6
 ZnD7yIGxjcH8md/wwaHvcjGfoIfMWGGYPGnbD96g3yed7Xo6i3SAT67sJW9uuQzSWcLMm55OXNQ
 TLoZzF+z7RdnPXvU6T7ycQu7eSEzqLgAmfsQ==
X-Gm-Gg: Acq92OHYSu0i7BeSLxRZzT0Sv4w3SxFIEs8YIp3G7x+GEGR4u31FW/PzQY7IBItuXJA
 5EIKhGu+UaheZdl/kSDkvwgctjEOhSSUO3j7GzR9T8IiSoJIja9K9QQQ/OinnFgU1ds4SoJV5kt
 ZamqmhtPm5ST73Veksso6Nx8lwg2BWO9YIIcJspsaJoV7IOTdPVO/DAlSUVlFcHJJzrJtlK5Y54
 LGb+S65Pkfec3aVPSXycDKRuZcPjFRQ0QQC3VaN6Wl+2mrnCdqP7zVly++MuxhZTuKpqyUm3HSi
 1pogv+ruc05D4lbYCLnDQDpBvKD8Rrj6JXuVOZav2o8S8poTW07wJOR8AG05AksI2PH2QN+z4D/
 Bz4Dl42GpEr7DrhXv4CO9J8UWeEbXFYmG4pgBH7Sii6c=
X-Received: by 2002:a05:600c:214b:b0:490:bd1d:472a with SMTP id
 5b1f17b1804b1-490ec4d7879mr102497195e9.15.1781464000167; 
 Sun, 14 Jun 2026 12:06:40 -0700 (PDT)
X-Received: by 2002:a05:600c:214b:b0:490:bd1d:472a with SMTP id
 5b1f17b1804b1-490ec4d7879mr102496835e9.15.1781463999627; 
 Sun, 14 Jun 2026 12:06:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922033156csm173860615e9.7.2026.06.14.12.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:39 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Xudong Hao <xudong.hao@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 022/106] intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED
 and VIOMMU_FLAG_WANT_PASID_ATTACH
Message-ID: <2b0d91ed44e5e0dc77d151cbdc0dba40c6101490.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

VFIO device will check flag VIOMMU_FLAG_PASID_SUPPORTED and expose PASID
capability, also check VIOMMU_FLAG_WANT_PASID_ATTACH to enable pasid
attachment, without those guest could not enable PASID of this device even
if vIOMMU's pasid is configured.

We don't expose the two flags when fist stage translation is not configured
as we don't support shadow page table on a PASID.

This is the final knob to enable PASID.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-18-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 31addb98e4..8bb2a1e339 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4788,6 +4788,11 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
     if (s->fsts) {
         flags = VIOMMU_FLAG_WANT_NESTING_PARENT |
                 VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
+
+        if (s->pasid) {
+            flags |= VIOMMU_FLAG_PASID_SUPPORTED |
+                     VIOMMU_FLAG_WANT_PASID_ATTACH;
+        }
     }
 
     return flags;
-- 
MST


