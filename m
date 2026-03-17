Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45B6FF6E9F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dlI-0003vG-21; Tue, 17 Mar 2026 19:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlG-0003uy-7B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dlE-0006Ra-Q0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773789820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKbmsVa0I6XnRkxq8tVtN8XjKOy2BuQjcC7lAo24P9Q=;
 b=FIzMYENIZm53FfsLxHF28FjhGfYS4LYzBLd+ng71r2/wgaW4nEqcd/wh5OeDRNiwD/IuzM
 2K5i5j2FsFmtLlzfAUASoiT8oer/yECf9m2zmxbt2y8xYakcWFhEH8as7givzlC8bJcmjd
 gPG6ajY3pXC8kxaEFculKarMQKkUJsQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-yK03Vk4IO9uUlvpvY4dNIw-1; Tue, 17 Mar 2026 19:23:39 -0400
X-MC-Unique: yK03Vk4IO9uUlvpvY4dNIw-1
X-Mimecast-MFC-AGG-ID: yK03Vk4IO9uUlvpvY4dNIw_1773789819
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89a0684d05dso15528846d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773789818; x=1774394618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKbmsVa0I6XnRkxq8tVtN8XjKOy2BuQjcC7lAo24P9Q=;
 b=C42g72OurAOOafZlGnizkSJ40x9Q0fFF5+YxErpu5vAY0VFJmrUhQRb62Sm14tPMjc
 TI4ehjtNfdao9tcN+qAqWj7SOrAV1XVhlSuvOybjjLEfQbc0FDQivlJnRuoWT6Wk7ZEJ
 tf3r1G/ZwAE6TcvUGj+gat0hMZxcCrA8H70ahYYc3ZoJrxV52yu2PThid6R51Q3QfUUD
 VPc1Y0lb2gvV5rwAe0lrTyLXSRakpcnOaRMaM0gpOu1fTWGxCJt4hFR/JYlwj4JU7fNI
 QWIOib7aItfiolzJsZKiyHNMncMgcW9AuIBdfkTyih5SYmJ819JK3rZrtr4DzQgwQxuo
 7jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773789818; x=1774394618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uKbmsVa0I6XnRkxq8tVtN8XjKOy2BuQjcC7lAo24P9Q=;
 b=IYVTzGaEUnGQwq3quBSAgHkAyWWOT/Dz9IjvFBH4TsB+ZGyXG9La7imH9eMdaxwOT8
 GdSzIQNcg3b4mHqI5gCkbJNouaf8IAqOV2+HM4B5U1LHhMtS435XrhZgXlY1FD7GJPeW
 3C+lh8qCttUnRNhM++15zacGzygOiNdldiao9N5DIgElbX7FOz0UkoF+wmZeVc9X9AZt
 niI72sTgdwhmXCkUFOJvd8pBq4VmPQ6vcHq9O7tSk8EtovxaJYFbHE0+UFsP4au6dLBp
 H2VGmy+HboxWIwq3Rurhsvd9wOWhAfWAUQ2ALsIaLPByEnuWHZMEXqS1TN01/imPVxuz
 J2iQ==
X-Gm-Message-State: AOJu0YyLur5MUtJSnKk5WWm+uhoilPcvRiSolc31NXbMFBDJ+wT4EpzR
 CPeAYs3im8P0hdWuZjIbCpES1Bv7YkulhQxIkntnUnS8MusV0nGDN3q/BW2OJbfEZ1/CEx81eR3
 UEwpvj9MKu/pH0nXAhm4CHxfBj9VRWWqot4G3Fi65u1MsiTxAxmjTpwKdLozFbVGWt0Pa6AUOTA
 gvu1mGOJUvSyVGcFn9E/RynhSwdwe78ywIflAkXg==
X-Gm-Gg: ATEYQzxqcnl8mLd71r6qxxMMV4mExav+5gt3WkvMSBYXvdibX/Zz6kXnLh7d6hN7SlK
 4+VWZjQl1G7vTIhhvBjbvKYSNMdkJ4zKISSzjl30Sv1R5T/YVdDgwA5EHby/L277TtVfIoGuzDQ
 EJwyfY6QKDWS5tyhCvkWtBG/gkBJtKh2Wv0+FDweh5gS/R3+tsRIGkR/rG7U7r7AeHnNoEMxtbc
 rpGIQRh+W02PzNTPQ1Jrm3rbp4sPbo9QFpSPUC/R+axPv21Q5cA1AthY6lfLsrpNReBNgAptlXG
 mi2nu9Qv6yC4TdyRcM4C3PYGe4TaRNR59l5uOGXJA0JifKvohvMT9WRtOOjG0NK7vCRiJXjOp47
 vT9+gQLH1x+R19g==
X-Received: by 2002:a05:6214:4117:b0:89c:58fb:d345 with SMTP id
 6a1803df08f44-89c5e36eb44mr64705506d6.17.1773789818262; 
 Tue, 17 Mar 2026 16:23:38 -0700 (PDT)
X-Received: by 2002:a05:6214:4117:b0:89c:58fb:d345 with SMTP id
 6a1803df08f44-89c5e36eb44mr64705236d6.17.1773789817746; 
 Tue, 17 Mar 2026 16:23:37 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ea39asm8203806d6.37.2026.03.17.16.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:23:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH RFC 02/10] vmstate: Pass in struct itself for
 VMSTATE_VARRAY_OF_POINTER_UINT32
Date: Tue, 17 Mar 2026 19:23:24 -0400
Message-ID: <20260317232332.15209-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317232332.15209-1-peterx@redhat.com>
References: <20260317232332.15209-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Passing in a pointer almost never helps.  Convert it to pass in struct for
further refactoring on VMS_ARRAY_OF_POINTER.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/intc/riscv_aclint.h | 6 +++---
 include/migration/vmstate.h    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 5310615cbf..0e0b98acb0 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -80,8 +80,8 @@ enum {
     RISCV_ACLINT_SWI_SIZE              = 0x4000
 };
 
-#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
-VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
-                                                        QEMUTimer *)
+#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                          \
+    VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
+                                     QEMUTimer)
 
 #endif
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 8992fba57d..68fd954411 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -567,9 +567,9 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                             \
     .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
     .info       = &(_info),                                               \
-    .size       = sizeof(_type),                                          \
+    .size       = sizeof(_type *),                                          \
     .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
 
 #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
-- 
2.50.1


