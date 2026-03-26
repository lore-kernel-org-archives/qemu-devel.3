Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E516810AB827
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rtl-00048H-6I; Thu, 26 Mar 2026 17:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rtj-00047e-Ve
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5rti-00036I-Hr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774559146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAsrRY7tNnPZNv7QX95Jwwlg0RE4QfNAnLAWQ9HKoeI=;
 b=PnR5viagpp76e/w2kFcESHagAJ3K0ZfXVU1NFrPLhwhre3B9AFO5BXhPR4c46G3dSM0FRk
 tw4cWJgbQ/DBg4ki/Et6mrozc24zGqSj032kAldgXGVW/kgNHk7LswnxcFLtdam6eZKnEB
 PBMrhPad4J0npzDNRXA4XhUNsqSc2Lc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-i4Sc2zJeOca-m3b6YFoF8g-1; Thu, 26 Mar 2026 17:05:40 -0400
X-MC-Unique: i4Sc2zJeOca-m3b6YFoF8g-1
X-Mimecast-MFC-AGG-ID: i4Sc2zJeOca-m3b6YFoF8g_1774559140
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cfdc479f5bso350116985a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774559139; x=1775163939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAsrRY7tNnPZNv7QX95Jwwlg0RE4QfNAnLAWQ9HKoeI=;
 b=BFBtj1gBOBsmK/HUhmWQQnvN2qZsrC9LZhol/4vJ5JCYxVQQ2NZr5UT0ri15RWzOHK
 r5pzPmqNTzvYsTtJjR+NRt4eQgI/73TAwpbkoSmL6xgWRBQ1IdeabbVvH3L+b0nW06ov
 UpCNCTTuwpQIeYU/05ZGoLfcdVFL72AxtYNjnqkoTww+y1y7m23s4Pbg51g0vgHcp+yG
 oas79yAcN2sHtu1dQ3S3OWkICYmf1HDA8Uu80LJfKu4Ln7yUyJWQ+zTPLtgz12Cxc1I4
 ol73yLxno8Olee9PBSNA75Nvkuj07qq9Wjl2EWxKxWSTSKOIfTy4FSrDBh4UH+jRwmus
 8lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559139; x=1775163939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yAsrRY7tNnPZNv7QX95Jwwlg0RE4QfNAnLAWQ9HKoeI=;
 b=IAsl3qxlcFPciomj/gwNwtz394a7kvZrH7bcVuKog682tvI1cmx2T3Kp+z3XZZg12R
 k/7RccJkqY3s/TJO5CTfALsWP9iBPUPZ29IO2GTrcK9jbONsC78L/2xheIMSDNMJ810V
 82ex4vzC6X7oXpnG1y/WLo5HAutoTrJ2ytcsFVfEBCa3xeziyXb2hs5fQc89o5XT855x
 G+dWPALb8NJCYE7SJ1C8g5qc+k3u43RJhxTH2vN8zzfNx8KsM3y1DNM5E6+j5NReeg9k
 yXrvqGJSUtQ7zs4/iDyJskVTIEGBQtNO57NT9IsbybdxDUXIxEcdqHH6L/fP6rYYB+ap
 FmrA==
X-Gm-Message-State: AOJu0YwiSLw6pFGBFn6QNzBgJQXRhDt6slFJiXEsDrf5Ffk8A02bOlSI
 nQFtYlpwSXbuInMxNk9Ys33xvo2qInaUSzfyWwxcl3liS0xYbN6zzW2P/I9j+Y95JtE6QbRDZm5
 mqsK4WLeirD0ALvqkBBPDo9lY7YfpG/2uYloHU5/Dm0fuMRKB+u8eeen/TLn0E+vzWVfPAeFoCK
 f/qPWICEW1JkZaTddFYtCuWDMavJJJNVdR4Ww4Cg==
X-Gm-Gg: ATEYQzy93RmZgHtWJbVo8/p7/4DqvcA1USbfc2BZZNgGRqAk70v7zKN5393uGBgSOQS
 Gpxg3CqOFXXDCFCLc07bjtg3kDGrQclVcvkYy09t0ockREa8bCaXwLxe6DNamn3elWIXrVAJGCt
 gpSQJiBQIn+eGPkBldxBylNomcV2Y1fiT+yXetpA4adtOFKhHFTpE3YD7iE6iCDu4k7s6R/mOKB
 MXaDfukVWcpIDrb4qltwAbMlW+mC8Cr6PdzUd86iP7+9QdAtZ6cfVg/MTCVA7/UhHponqhUl8aY
 jWjFNebL/NjXMiTXGKtPg+PjnwU33OOScqCibpE54XXKquYTRizO66rMp7K7IxlGO1imbu18IKS
 Pai3ovn/QvBQ=
X-Received: by 2002:a05:620a:2805:b0:8cf:e946:b2d4 with SMTP id
 af79cd13be357-8d00105203fmr1191627685a.69.1774559139188; 
 Thu, 26 Mar 2026 14:05:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2805:b0:8cf:e946:b2d4 with SMTP id
 af79cd13be357-8d00105203fmr1191620185a.69.1774559138515; 
 Thu, 26 Mar 2026 14:05:38 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e4fa7d9sm353479785a.32.2026.03.26.14.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:05:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH RFC v2 02/11] vmstate: Pass in struct itself for
 VMSTATE_VARRAY_OF_POINTER_UINT32
Date: Thu, 26 Mar 2026 17:05:23 -0400
Message-ID: <20260326210532.379027-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326210532.379027-1-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Passing in a pointer almost never helps.  Convert it to pass in struct for
further refactoring on VMS_ARRAY_OF_POINTER.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
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


