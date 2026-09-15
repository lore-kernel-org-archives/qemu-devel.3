Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE29FC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QgF-0003Xe-OL; Tue, 15 Sep 2026 06:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6QgD-0003XW-QX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6QgC-000393-4P
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789469183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WeyzZZUiLGeIrRoo9nKJp+He7XHtKP0SxIy/PtZiH30=;
 b=ffDl2HdkyyRC1noQ7nnJJwCbkUTdp7eDbkAHUI6WlvEqZo6BWqlPQaB6kbfB6mx2w/6FQU
 v+LG1OqTLCt1tDpRe89OJccIukqqMqbA3yMh4i5bem0iep5keBLO8lyfmYm8PQrlE88rEe
 PZrba0O84FFj7CeD9pZOcHcLQ8QRjKE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-wKWozQX0Mv263m7wLSOAJg-1; Tue, 15 Sep 2026 06:46:21 -0400
X-MC-Unique: wKWozQX0Mv263m7wLSOAJg-1
X-Mimecast-MFC-AGG-ID: wKWozQX0Mv263m7wLSOAJg_1789469180
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-486f3dbf7d2so2833350f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789469180; x=1790073980; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WeyzZZUiLGeIrRoo9nKJp+He7XHtKP0SxIy/PtZiH30=;
 b=bqBQZvKvt3kQWIChKhJGRkh2KWlRj/CHOnTTQuZAJcB7Yf59KPpKLXqSiZdzq/tJDJ
 IcsTv1CJXLUw9Wk8h74qYpaPVOQIcQ1xeD6Qdc5D+KtYgg1YrXvU5g4wYwm74QE5NdMf
 vfNzJlDr0WWeprzUikKVzgY3DYhwzpJZEWvhe+SovAE1AgpgtGupQR3jY8eu7JS8s+SC
 5JopRKaFJVwSPtQj3XANYIJdTBt0qrEtZ/kUwbx/JEy846vKgjJNKcvh+uds3+1UhRPf
 gTUPMc1HY32bMwlWJdkb1ugbHtfmTuuL4xA4xe1q55nqxRUkSbd1ifbUI9x8nuQ84zqE
 GomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789469180; x=1790073980;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WeyzZZUiLGeIrRoo9nKJp+He7XHtKP0SxIy/PtZiH30=;
 b=W20G/KP2iPCCxcMS56bzIuXxCQHSvYebov4RZWy8LTIZuNXHXwsKnOtUV1SQ/Ti0/b
 lYqmIJyhRq61dy2AixC6+Hd20c0Z40X6nrsmgLSI2eonzoTrUHi0ntT0vDFbH/fOTVYn
 TojMV2dRQ21nXjo4hRPPd3zCfuueusMCLk7OjJK7hbcPW4NwgFKEflgOjtgyBJ3yVeTk
 CjdephWz8sdXkXAMTFUY365BADd+2LPpp8HTylAuYgHZKcZI54NirZlO9EXm2idVZmKP
 WPagYltH+FgF7ZKYCktSEvRoVkY+Abj5h0r0pMsKInSrmDxm6V01MmZgIYVj4rEhWHGf
 JvZg==
X-Gm-Message-State: AFuF++lNfvz55IzOLuNbsb9Fg05o9bGpl3xSggD3Bwq6QUydZAeoatrp
 BK4Zzh0rb6AHmSHxekacN8UTGSwfXcA932R2eKfc3O4t1uKdsg8CnxtfOF71cl3ozURnIEelH8D
 H89GOqj6dLnsFzK4r5QsKBRt8bp98ltc9YYfQZoP1dAPJxpUXLDdxjG9GLbCBCFCgTpS86MhTdl
 rPzoavIXOpWez+ivoUxR0e0MsVsip03ZaQsA==
X-Gm-Gg: AYBFou35Pswbfp0eFNcKV6SiQqLaKZ4hayqL8DgACKQCrhzxecFfX7Ivoi/9VC5lgkD
 QKLn+JcgBLfK5IS9B7tb0kRJneEYRF0deFVkxXk8egjVO0EkSs1+o6XGQODWRj0s0FU/DwCDrSr
 JRugo4apokYINrWUzh5+OShEmX8OGQg9OwO1dxEVuCI5wLUBjLZa61I59vXM8THOgsX2Ccn1o3G
 VYtcR8MTduKT7AKJS+gVrD3Nzq3w06yFeK9TjoW8YG6mKfRwtsJJqM+cuuD1QuryhcNrSFgppqn
 ihTQFPPLMo3R0GwDwGucE96jUcM2ZN9/Mc9BfcNqtoiYjzY3xib+8F2d7H6EKZJyG1QzLCV2Pt9
 qeI6QQALGHVgHGwMre/QYUrk=
X-Received: by 2002:a05:6000:2388:b0:485:8c16:5ee9 with SMTP id
 ffacd0b85a97d-4870a9e3bbbmr227752f8f.35.1789469180275; 
 Tue, 15 Sep 2026 03:46:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2388:b0:485:8c16:5ee9 with SMTP id
 ffacd0b85a97d-4870a9e3bbbmr227707f8f.35.1789469179644; 
 Tue, 15 Sep 2026 03:46:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm33247794f8f.9.2026.09.15.03.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:46:19 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:46:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Omer Can Vural <can.omer.5306@outlook.com>
Subject: [PATCH v2] libvhost-user: protect against OOB memory table access
Message-ID: <8adc88f2f535ab0566a5df1c66db728112dd6f74.1789469161.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SET_MEM_TABLE handler uses nregions from the message as a loop
bound without checking that it is below VHOST_MEMORY_BASELINE_NREGIONS,
so a malformed message causes an out-of-bounds access to the
regions[] and fds[] arrays.

Frontend is trusted so not a security problem, but
an OOB access is not a nice way to handle errors.
Check, and panic.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4403
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: Omer Can Vural <can.omer.5306@outlook.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 2fed792e85..52817cc733 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1105,6 +1105,13 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
     vu_remove_all_mem_regs(dev);
 
     DPRINT("Nregions: %u\n", memory->nregions);
+
+    if (memory->nregions > VHOST_MEMORY_BASELINE_NREGIONS) {
+        vu_panic(dev, "Invalid set_mem_table nregions: %u > %u",
+                 memory->nregions, VHOST_MEMORY_BASELINE_NREGIONS);
+        return false;
+    }
+
     for (i = 0; i < memory->nregions; i++) {
         _vu_add_mem_reg(dev, &memory->regions[i], vmsg->fds[i]);
         close(vmsg->fds[i]);
-- 
MST


