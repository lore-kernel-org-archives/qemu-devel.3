Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EC4CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 11:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMOzN-0004dr-OW; Mon, 11 May 2026 07:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wMOyy-0004aX-Tt
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wMOyx-0005d7-5w
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778499568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K64EQDowVMrykWlT1JU3jppCrUA+y2flzFxRGyH22ik=;
 b=Ly4zcZYQHj0SaQ+GBI4r/cWNl2uSEpHPsL7fYCr0ifwUzl0nDRa+25LEYOhTUTjWX47KWc
 +HuH/K+a7Z+pquLBNGiIOJdsZsJYuR/KovpvE1A6WYRMDbVoELBK/0a/XxpFGnrDeKD9tu
 nPfzY3OAQnwLhD/QTUeP/v1B9cn4Azg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-dFkjFn59P0Skm1zl05DDjw-1; Mon, 11 May 2026 07:39:27 -0400
X-MC-Unique: dFkjFn59P0Skm1zl05DDjw-1
X-Mimecast-MFC-AGG-ID: dFkjFn59P0Skm1zl05DDjw_1778499566
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48e89faa62eso574665e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778499565; x=1779104365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K64EQDowVMrykWlT1JU3jppCrUA+y2flzFxRGyH22ik=;
 b=Z6M3Pb+feh/I65KXuUZkYgKkwcWOxLOTG5B+P4gtXtEtFtu0X+yw+BLThIHecsAopa
 vu7KP/ESkPjLxsDpfhi3NmnOk0MVjxsGuxQMX9KUmtJofOwzFnmVDGgtKSBGglEpet/1
 s+/3qGotypIlTjI3ZkNwqebdTU+7X3fFoBGI0kgu/1IhE8YjjsJTmt2D69XtfvVSzqTB
 Q3sOiNFL9nxrrif2ypyanUWnmWJ6og73M80K+0iPQvc9Zhw4UZihVZGxInPeEdKwv749
 Ljen5g2mcacABGLqS2kEgbJz1nTkS27ihKF3k1WtV4/LCfVVlkRujqFqh8DHRRR+DnY1
 ytPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778499565; x=1779104365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K64EQDowVMrykWlT1JU3jppCrUA+y2flzFxRGyH22ik=;
 b=iTcfKvUur++91mEVbUkrQ7vIMgc3xNSIdBCb3W+eP+zk5eKER0oxzzsB6Rc5+dvUZa
 y7HhKVxek4PY+T72V9e4rbYqeua1wqOGee+pMvgSRAJCXkFG3miaWxA2qe0qwWCO3Yc/
 5O0pK4Ln7XtRpCD+RqSqH8IBVi76qYCxMGb94TiVgWhV/7tEhKIe+wTgL6RGzTNC+cEW
 EwS7a13joPNVmwLRiCzutVheXwrWgjVHLdbBCqNsEBQjtlGI29QLmjkIQzDKbG1hQqBL
 OF8oK5Zh+ZBlXAajxpGrx1AXYm11TZnhDOAZhB678FAg9yTyIMJbRPxSSF3Mj/clrcbT
 2ARg==
X-Gm-Message-State: AOJu0Yz8Ys8zRT3JFz1o7KUcJKlb4Rh6pzSuVo47VoAylNmkEBvNBg1M
 cIMqlCOzFRapT0gfRwba6iVQFv1IElH6e2F92eK9C4H3HrRtx4VeNiynGzTtmipMAJmlz0BzUM8
 d4UTUzmV8BkZ2KezjthsKNQ1wia4/IObi7rka0k58AaCOOD8Fds7dT0hoLlzlqO6N5HsZmGgbog
 Ba2bC6j6yFjA9AxhgEOQo8vPZO/noaooaazZ0LUBKy
X-Gm-Gg: Acq92OGKFGezZhXKoZw2fErLiMlC/22Qwe1ss33u52z8T3tTYz3+0dqSwHqmQcTbgtZ
 HSyAK55d2w0o4idMljmJ7khjxCkBQ8+RGomNYSBFaNpqdHTXDFp+v513mw0SbesV1nSZ9DiXhNT
 AXnHVYBxj4yoJ1niIz+kval9GZLt1Uoy3evoBvIATNlJpdzuhMCjGgo1SR/KfTuRx4zZmA2ZEH0
 u/S8F+vwLyAbhz72C5s0j19B7/J+eBRxojPs7wm/rc7x2ouZq9CE9OkigPdqwGC4Yp7rkab+NMc
 LRL+tFQjAZrzZxhhW3b9abrjRE4Vdak8G+qjxRFvAas88Q8SMGyACbr6Liz2VWmDhKfUsiCLSIF
 4QMxE8vRojfzJbPTQfCieGExJf3Qz5KLti1H7Abah1ader5TGCcnX6lH9mVjmae823Ht+Q9L86h
 J33lb0JiE/8KCppsvHBEWS/EqSV3//
X-Received: by 2002:a05:600c:8011:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48e51f3bbabmr364922615e9.22.1778499565494; 
 Mon, 11 May 2026 04:39:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8011:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48e51f3bbabmr364922025e9.22.1778499564976; 
 Mon, 11 May 2026 04:39:24 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6db1742asm62561285e9.31.2026.05.11.04.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 04:39:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alejandro.j.jimenez@oracle.com,
 Yunhe Wang <yunhewwww@163.com>, qemu-stable@nongnu.org
Subject: [PATCH] amd_iommu: fix infinite loop
Date: Mon, 11 May 2026 13:39:22 +0200
Message-ID: <20260511113923.2478812-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The AMD IOMMU command buffer is a ring buffer of cmdbuf_len (a power
of two) entries.  Each entries is 16 bytes and the head pointer cycles
through the set:

The tail pointer is written by the guest through the COMMAND_TAIL MMIO
register (offset 0x2008); the while loop in amdvi_cmdbuf_run() only
terminates when head == tail.  If tail is set to a value higher than
cmdbuf_len * 16, head will cycle through all the elements of the ring
buffer indefinitely, without ever matching tail.  Fix this by further
masking tail (and head, for consistency) against the size of the
ring buffer.

Reported-by: Yunhe Wang <yunhewwww@163.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/amd_iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 789e09d6f2b..197e452e3c3 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1578,7 +1578,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
 static inline void amdvi_handle_cmdhead_write(AMDVIState *s)
 {
     s->cmdbuf_head = amdvi_readq(s, AMDVI_MMIO_COMMAND_HEAD)
-                     & AMDVI_MMIO_CMDBUF_HEAD_MASK;
+                     & AMDVI_MMIO_CMDBUF_HEAD_MASK
+                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
     amdvi_cmdbuf_run(s);
 }
 
@@ -1594,7 +1595,8 @@ static inline void amdvi_handle_cmdbase_write(AMDVIState *s)
 static inline void amdvi_handle_cmdtail_write(AMDVIState *s)
 {
     s->cmdbuf_tail = amdvi_readq(s, AMDVI_MMIO_COMMAND_TAIL)
-                     & AMDVI_MMIO_CMDBUF_TAIL_MASK;
+                     & AMDVI_MMIO_CMDBUF_TAIL_MASK
+                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
     amdvi_cmdbuf_run(s);
 }
 
-- 
2.54.0


