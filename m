Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4471E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRp-0000gV-Ga; Sat, 27 Dec 2025 04:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRn-0000TV-Iu
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRl-0004QV-16
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/vVrG06Rr5jifGh9xz0OwdmLw8dMRsZZ4hi+JD78cQ=;
 b=Wf/4VmpNMY5j4TIUeZekBSnuqYi74Py3RF7JZQmBuUOAIUZhEotIYViw4h+5dXBYxyuI2m
 UyyTq3skEZgbcccE2e7LY6vcFXr7KsAcBzuQbsiiszia+kP+fOkVdytHsXdKn6+K/gjFDG
 itzzbbU4i7Dxp5vkrnqWu8PLw/y7Gd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-_oAY5Rt3OGCl9x54apX3fg-1; Sat, 27 Dec 2025 04:18:46 -0500
X-MC-Unique: _oAY5Rt3OGCl9x54apX3fg-1
X-Mimecast-MFC-AGG-ID: _oAY5Rt3OGCl9x54apX3fg_1766827125
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so77995135e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827125; x=1767431925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/vVrG06Rr5jifGh9xz0OwdmLw8dMRsZZ4hi+JD78cQ=;
 b=ftmQDcLPk5X8gjdX94+AIjM4qQpZhrvVV4wKCJ8NxPRRJ1YFc6poiwyObYjjg2o6v+
 eEFgDhlQl0npkcC5mvXVeIfWVXbTqYN/eFJcSCHP6MXW2Xef7XPxsffNADN2NDeoFrdG
 9wtRst/31edmY/XeJCo2rTja82LrqOacLAUGLKb+F6QgslUP/5Iv38I8o4FsW4qs2HSc
 hpQwPzIItXv8eTq5AU520j/k/g1qf+2OY1d6LdbbzbCuzgvBUFHwXgzPj0NrtpqTraK5
 xJymHsdYM2npV6ufDTf5R3B2jmepHpaOWLCPr9A39J5o4w14lFhDWaCstJv0+a+zRD8d
 4IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827125; x=1767431925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q/vVrG06Rr5jifGh9xz0OwdmLw8dMRsZZ4hi+JD78cQ=;
 b=v3MB5rdKrF/38q5c0Nd/forJlbfVn1SrzR3NnfLVoQmhxP3+DfTT/msqnQ7gMKKyoL
 CzxrM3s4LK6PP1zbAI+sCviSTnERtuxiswYpLDw6b997HNqDKH90WtTwLDx4fXnmgJ14
 QTrqmlECp1o4r3jzQpMooH9p2JA5JUridYuGq1Z6hs1QP+6t43A5r1T47d/4NOwySRMR
 yQfeCIT0Udp7RVrqR5AklCt45R18Q/fV/vEHUA4ljGeS413NihcFuKPxaYpnsQCJUBW2
 f4OLVKI2Y9yMd8tcTA2KvTy0A7TA9Z4s75UKoXPXFsLxemTLbg38zV53PrUoGmZ1AOOi
 kIPA==
X-Gm-Message-State: AOJu0Yyw9Y+CvTfx1aiV7I9XIUUGxLmWPh5ePv554HHsuA3UiFJGVjGd
 4ptA550/M4Zj+g2c53wmECE/g6Khg1Ii5WTprRnQHNra5ZIU4FFGmvEHUvEYlOGIBLPXUeMGKod
 C92bu/cu6kuIbWCqKoFh0sXQbw242Qd1Lv1TehoRMl7gI2BA3dIAPnTJHa7dBay0Un/bKv1fdWB
 OyOam7Gq4Uo3l6052sP+AOGtfb2Yy8ROX2whgN5Uxt
X-Gm-Gg: AY/fxX5ZHjDFTBphrOMsc0LR9WHtcjs8z05cNW3LEWcjpkcLURjn229u1dcvJXVTJ5Q
 amkReP+D3wmcLPPL7Fnsv48HGCmvsp9FinHIwhF1351EtiArV89OD3gXSh1IiM9LpJWKy5JTny0
 74kLXVDZIpkRUz8dUmjbxhBAih2dDGHxi1nBY0f5r8a2K1Ay+Z42i5GWrcfJmdtu7CvkLY+M/fH
 tta8XD7/PlCMQbMcA6y97fD/uos2oWy7oq4RKumSweLt2he3azoclXasHWDYmdDEf9u4HYybP9C
 B5nw1HCK+Ucp2qlfqY59o5ycJuKFYexSsV8XGlXqqnZ9u6IBbq8LtRJEpkWoyxH80H8gApb0Ae8
 zIKtxhK3ZHt2KYC0Vvs2RycfVHeL/fK6Iw1icfdUSyLXvkPZFsydWtw6stTLyKuTjBBaTZlEfo1
 kpacY8LZv2HmEl0Fs=
X-Received: by 2002:a05:600c:4e01:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-47d1957f712mr294941535e9.22.1766827124938; 
 Sat, 27 Dec 2025 01:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH7My0YJ6bXCTbKrST8rl6I8SJ6atVJZTu3q3CZYRAf3RAlVIHeJXxU7AQ4iNTDpUlseRgDA==
X-Received: by 2002:a05:600c:4e01:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-47d1957f712mr294941295e9.22.1766827124444; 
 Sat, 27 Dec 2025 01:18:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b36fsm49744289f8f.5.2025.12.27.01.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Julian Andres Klode <jak@jak-linux.org>
Subject: [PULL 072/153] qemu-options.hx: Document -M as -machine alias
Date: Sat, 27 Dec 2025 10:14:59 +0100
Message-ID: <20251227091622.20725-73-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

-M is used heavily in documentation and scripts, but isn't actually
documented anywhere.

Document it as equivalent to -machine, also moving to -machine the sole
suboption that was documented under -M.

Reported-by: Julian Andres Klode <jak@jak-linux.org>
Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Link: https://lore.kernel.org/r/20251203131511.153460-1-dave@treblig.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index fca2b7bc74f..ec92723f10d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -44,6 +44,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
 #endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
+    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n"
     "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
     QEMU_ARCH_ALL)
 SRST
@@ -179,6 +180,9 @@ SRST
 
             -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
 
+    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
+        Define an SGX EPC section.
+
     ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
         Define cache properties for SMP system.
 
@@ -208,12 +212,10 @@ SRST
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-    "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
-    QEMU_ARCH_ALL)
-
+    "-M              as -machine\n", QEMU_ARCH_ALL)
 SRST
-``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
-    Define an SGX EPC section.
+``-M``
+    as -machine.
 ERST
 
 DEF("cpu", HAS_ARG, QEMU_OPTION_cpu,
-- 
2.52.0


