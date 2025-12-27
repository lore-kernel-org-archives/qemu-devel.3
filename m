Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B9EE8FDDA
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvA-0004Xa-BV; Sat, 27 Dec 2025 04:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQv8-0004VY-VU
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQv7-0006zP-9q
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tX8rMfJf3i4TUGuBky3KUxKbjgf7gMEJ2PzJvdcKBtc=;
 b=Tr2kG9fzG+6kI5E40PZl38lP1gxkOd2WV7467xTYUrgUsrEYQ8T+3fdRFll4g0ftxs8S6k
 UHx55HcPf7o2BphE5gxMm91a6uX4D7ODZ/h9IHvQjWa9vMdYmQdGvqMayAiE/aeJsDki73
 v8CgvSEyNEY8rdBSuj/SBwPL64LzbXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547--U-gxSjPPvOw6zDhi1brcg-1; Sat, 27 Dec 2025 04:49:07 -0500
X-MC-Unique: -U-gxSjPPvOw6zDhi1brcg-1
X-Mimecast-MFC-AGG-ID: -U-gxSjPPvOw6zDhi1brcg_1766828946
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so73503705e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828944; x=1767433744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tX8rMfJf3i4TUGuBky3KUxKbjgf7gMEJ2PzJvdcKBtc=;
 b=VMGv7EommblJjXh0gVM1OZ0+5/pNgxCfaysa7lPD2nTEWBlyVGdx0ibGrfDOfoUUfh
 28YwBhRmAg+uOCFH6ZxNM43/r1OoPXpbn3grgHG7RJdpphSa18l3z2OwQZY2UOz4lrYC
 1Ij6Ejgwpx/PVPtt2/X9aehuXqdhkgm107id/WZGTafgq74coNM88ihI1wJXPUvU9Mli
 6XUdPMVd/ef/XZJlteLSBb9NK/NoPTCJ3bmbmsAunujpuGYaxte7rr4OQOBPVve7emLm
 /qGKWDSTAf0z/l4qPPSXK6YWpCIHNnMEu25gFJZSAK076UwkgUJPqCx1XxwEt8dcMpMy
 VDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828944; x=1767433744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tX8rMfJf3i4TUGuBky3KUxKbjgf7gMEJ2PzJvdcKBtc=;
 b=DNVXw35sMe3wpC5MCn8Wpl679r+b8HxEGg6qjP2o/q0cATg3vSro0THVkb6UKLrtCG
 Dge6Cn5Qi2ErAx1j0doovA6Brv1JRqh+Mihwwp02t0BO1aKV9zFR8V3H/kQvqKMoPzNO
 CHNbtq5wZpeKw3FGPqZBFgM/CAZAJij+raXTtDmQke/y6d0GzUM/p8Bynk+HIRPy+Mxi
 5qI/l3sQik93el8OljgziShQtCxh8G2bjN1BKufuv9O5SwN9T8Oejo+aLd/t6BgJAUK+
 YNEMn6j0I43LWEGyuQbG0yCAjN4KUszsjrYsOVJXc6xSPkbYUdL3kZbBo0LQw3X7bjUR
 sqoA==
X-Gm-Message-State: AOJu0Yxm1ClyaPd2Bzz/R+vqYf1yMJtyE/KlsntGgJXXKXiSkbtdTloo
 55UTNNEWViWaL3dIneND5BF8olKae6bEeBdzH62vIPanlWF7BBZm7JdR0vuLoVpWof9auYHNwgv
 lmst/qVUbe/chqtZFjHnJFVs0Uoav5YD/DTnN2YRZhxv7d3STpnoDxiLKl/n271yUenr3YwCnJ1
 eHyrhchOR2PO7sMXwhG982oxULzKEvpsdJ7gp7RXGS
X-Gm-Gg: AY/fxX5s6tcEBZy8iDM38+5IlJU/NdeG/c4tA/tco/aHf+y3Wep/a1zo37EjADAw2dE
 MOI9+suf8C4lh0+SIHbV2smhyvAKyu4jWFNceFQWZVF91ipdIptEgtbuIdfITLaB9w8/lJYpweL
 uvFIHEcvFqpuld5OImgz3oqCkWoHW1+//m6qVmpKkQ7OyedDoCXMe4HIQZL1WaRpV5Nt2J6ehvv
 6KEcXGs4CIRtJUPTWGmZQmKv9SItgE2k49Q6RxzZb8kfOotXIMw+pKC/EdRZ3ngWXnXDss3Wc7o
 gdIZlkMUarixNJcEdww4oxemkHh07r+uAy0m7o6ONw29x8plOQrWhC2WO8prjDhU5DJ47oZVfhM
 hQEKzQ30IxWxznTa1+nkV7lJyqFIqdLkd9dsBrTrgs9SHSpTQJo6+CjkqBbwphBPPD2kvWT3ORj
 2+/z/M+tY3j5WySNI=
X-Received: by 2002:a05:600c:4f09:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-47d195672d1mr274919605e9.15.1766828944078; 
 Sat, 27 Dec 2025 01:49:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqCW1jNqtu1NSlWtDmTxZGatj49K6GWHWJz/AJUqh08cTySxz5I7JoicTxnq5eo+EE5DsOdQ==
X-Received: by 2002:a05:600c:4f09:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-47d195672d1mr274919415e9.15.1766828943666; 
 Sat, 27 Dec 2025 01:49:03 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b0d5asm490545865e9.13.2025.12.27.01.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 101/153] i386/cpu: Add APX migration support
Date: Sat, 27 Dec 2025 10:47:06 +0100
Message-ID: <20251227094759.35658-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zide Chen <zide.chen@intel.com>

Add a VMStateDescription to migrate APX EGPRs.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 0882dc3eb09..c9139612813 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1741,6 +1741,28 @@ static const VMStateDescription vmstate_cet = {
     },
 };
 
+#ifdef TARGET_X86_64
+static bool apx_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!(env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF);
+}
+
+static const VMStateDescription vmstate_apx = {
+    .name = "cpu/apx",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = apx_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL_SUB_ARRAY(env.regs, X86CPU, CPU_NB_REGS,
+                                 CPU_NB_EREGS - CPU_NB_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1892,6 +1914,9 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_triple_fault,
         &vmstate_pl0_ssp,
         &vmstate_cet,
+#ifdef TARGET_X86_64
+        &vmstate_apx,
+#endif
         NULL
     }
 };
-- 
2.52.0


