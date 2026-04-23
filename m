Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE82F9936C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKo-00015L-Ub; Thu, 23 Apr 2026 06:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKE-0000nD-FN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrK9-0005n8-UB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1EAW752fwbHwayHLV05aNOwJKZc6TGPZUvpqkhrmX4=;
 b=aPXp66xglUozw9NOOyDyl1J4bL+vIbMcv/sbPk/9mDHrfQcZCZ/1xVKV8mlkIB9zVO0j4R
 O1V0VuPzObnkwcZwhrTVd238FxGLRMJoGeJ20P4vyzrQgcLAl4Ge1Gz2bNgZJWWjdgltTo
 p65RiKOijkEadnevgpxZQmRbnn+iEt8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-GkVIaYBzOXi8KYvQDrCnfg-1; Thu, 23 Apr 2026 06:30:19 -0400
X-MC-Unique: GkVIaYBzOXi8KYvQDrCnfg-1
X-Mimecast-MFC-AGG-ID: GkVIaYBzOXi8KYvQDrCnfg_1776940218
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4891f97aef0so23563655e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940217; x=1777545017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1EAW752fwbHwayHLV05aNOwJKZc6TGPZUvpqkhrmX4=;
 b=LfxFAbSmH9nb8G13nlKUokoSsFonmMjSP5zbA/Qrx9flAj3ol8J7vqVtQ82p4TVitm
 mRY2wyooU4AkqSkTu+4hgWBNf8sIn8dRC382R969g/vB/DpT6nCIi9VUKvcbq4oinT+n
 oygL8mlGy1f9JiZZUPfP/d3oJZtivwIvW/gYJ8/Lf0F3YAjnQFj88PtWMOOPKsKY/KrH
 PetOchojGFBK28jpx4RYaosXkfvOux6cSP3AMRWLhnZSUZDF3gaNeuR+Ksr/P9SGGNju
 vVrScUffG0hvA3lZSgOmLBbpVHclr6q5pVBTyF2YZkbjqNmF1OBcZxxI0X2VKHfCJ3A1
 NU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940217; x=1777545017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w1EAW752fwbHwayHLV05aNOwJKZc6TGPZUvpqkhrmX4=;
 b=rhDqRzUuYKy84LD2gbbPmjopUmbbsealGP0+7l12lxsNAXMjsDwwa+X4cxNgW4oxR0
 BvWVLhVh+ra1rpOqwC1alI4puaUp04YSCuxeMumVJjReOFjbxv2iat62Fvp88ejSQh0j
 XO+hiGvCZ4hP7ZEmkNxNXsfVLpW1S2dFT0JTuFepi2Vh3x+ZtbU8nc6XJSTXSohceMPI
 ehgwoA8hwOfNVLkOjiqa4MOdJVyCR6oePeGvwmKi7xXRFCbdtG5gvwb/rCepN9AqjUHr
 czj8jBHUcVpiyyfPX31ZLrYO0Aa3yk/BVYqZa3XzRspJ+/EQ6NiL6hhr6gIkYst5oRKS
 d/zQ==
X-Gm-Message-State: AOJu0YzIu6M/tat/eVxfEwSv5SZA9a8tuC95fEsVOuOIYhy5zq4lqfDc
 auSbQl/mDVgXH39DNVCxpnrMFvLR9282x4T7YxYvx5m+KboczB7/Wm8epYxBdkozJqYZ6ILDavs
 WzCw/e2Dl4RwuJo8rjU6BGjtYBG/kMbCGXA3A7usgmYHN5gGj87s8bdXvv6W89oo00cHKr8+Maq
 ENPSnHqaFXDAxtJ1U3kxDgibRJwHKWs52uGOczzUIa
X-Gm-Gg: AeBDieuJG8nSmmPBjHcjw133Alu9foDDKJiqk+nuiTZFmOOzVcUw6Fhu/Gw60F8qcki
 Q+p6xYUE2HLYcFixYCsMM+mGbTkFks/xmU4IrZ0s7zBQFDKSFWCejUtWqNm5xvvv207VposnU5U
 xejVOxqSmDDlcu5Ibs/1WGVjfdXPmQsrn9sgXgUSWGoV7agXRrHblx3YEwz0DZtiW63fl+keDw2
 KWCFYgFt5SGq8IEyj+AC1B8vIQAqqCOyyLcknP9zgLfLUTLthshYyPXdDAti6VtlVDAIm/Q7YdF
 zxKpvnZrGc6Ykj7LHdHX14h8ZTMEqfF0XxHqetldgDgYfZgktertU2nBtfJhoMCQAJkgjzGXYwy
 vCL+UV2L8bnk+G3yGQlI2ixOtJFkh7Xr3ooW/5hS6GH3O2rMoMd38iQI2sxg/E6ZHogL+BLowvi
 VKrvtwlNwPDH+uez7imrPBN2C9Qg3CsEkrIBc=
X-Received: by 2002:a05:600c:1587:b0:489:1f97:6b1d with SMTP id
 5b1f17b1804b1-4891f976b4dmr124433595e9.28.1776940217138; 
 Thu, 23 Apr 2026 03:30:17 -0700 (PDT)
X-Received: by 2002:a05:600c:1587:b0:489:1f97:6b1d with SMTP id
 5b1f17b1804b1-4891f976b4dmr124433115e9.28.1776940216495; 
 Thu, 23 Apr 2026 03:30:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cc84a1bsm116263315e9.0.2026.04.23.03.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aastha Rawat <aastharawat@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 19/25] accel/mshv: fix ioeventfd deassignment to forward
 correct datamatch value
Date: Thu, 23 Apr 2026 12:29:16 +0200
Message-ID: <20260423102922.443639-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Aastha Rawat <aastharawat@linux.microsoft.com>

unregister_ioevent() is not forwarding the datamatch (queue index) to
the mshv driver, causing only the first VirtIO-MMIO queue to be
deassigned correctly. Subsequent queues fail with `-ENOENT`, triggering
a fatal abort().

This failure was discovered while booting arm64 EDK2 firmware with mshv
accel.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260409-fix_ioevent-v1-1-053b810ae6fb@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/mshv-all.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d4cc7f53715..e1a8d62f8d2 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -278,13 +278,22 @@ static int ioeventfd(int vm_fd, int event_fd, uint64_t addr, Datamatch dm,
     return ioctl(vm_fd, MSHV_IOEVENTFD, &args);
 }
 
-static int unregister_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr)
+static int unregister_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr,
+                              uint64_t data, uint32_t len, bool data_match)
 {
     uint32_t flags = 0;
     Datamatch dm = {0};
 
     flags |= BIT(MSHV_IOEVENTFD_BIT_DEASSIGN);
-    dm.tag = DATAMATCH_NONE;
+    if (!data_match) {
+        dm.tag = DATAMATCH_NONE;
+    } else if (len == sizeof(uint64_t)) {
+        dm.tag = DATAMATCH_U64;
+        dm.value.u64 = data;
+    } else {
+        dm.tag = DATAMATCH_U32;
+        dm.value.u32 = data;
+    }
 
     return ioeventfd(vm_fd, event_fd, mmio_addr, dm, flags);
 }
@@ -337,11 +346,12 @@ static void mem_ioeventfd_del(MemoryListener *listener,
     int fd = event_notifier_get_fd(e);
     int ret;
     uint64_t addr = section->offset_within_address_space;
+    uint64_t len = int128_get64(section->size);
 
     trace_mshv_mem_ioeventfd_del(section->offset_within_address_space,
                                  int128_get64(section->size), data);
 
-    ret = unregister_ioevent(mshv_state->vm, fd, addr);
+    ret = unregister_ioevent(mshv_state->vm, fd, addr, data, len, match_data);
     if (ret < 0) {
         error_report("Failed to unregister ioeventfd: %s (%d)", strerror(-ret),
                      -ret);
-- 
2.53.0


