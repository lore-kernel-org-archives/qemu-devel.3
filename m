Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2B0C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNxm-0000YN-8c; Sun, 05 Jul 2026 10:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxH-0008SW-HW
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxF-0001Vq-Jj
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=517GJyNBuZi5k0iP+IHcA4L7bP/uK04jnda2MyKM78w=;
 b=eNmkGFWK5QTWCU5jHLPfdifXLXdgJVuYla8nMBFP4+B8iyYmS8sbBYZVexYjjYQK8Nv/c6
 2ph3H/9xPP0lRR2ArWDlnCHhkvSJ1wCtiN1h+QyWcehVCTVQw2yYuJYVDOqilA2NC2VX21
 e4C0tQqODKDB8/7eNWFyaIRHYyuJTes=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-yZG6lKdpNzqmuQ_d4ac6fQ-1; Sun, 05 Jul 2026 10:36:19 -0400
X-MC-Unique: yZG6lKdpNzqmuQ_d4ac6fQ-1
X-Mimecast-MFC-AGG-ID: yZG6lKdpNzqmuQ_d4ac6fQ_1783262179
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493c1bc7a70so17075645e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262178; x=1783866978; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=517GJyNBuZi5k0iP+IHcA4L7bP/uK04jnda2MyKM78w=;
 b=PiplPxfngGyo9lc0JiK47eON3TsOMDZ1RymiyJKIy6PKKBts5qEQusKxAl8m1GIboq
 L0FKK8cfFTrXi7lLD46FWYTQd3rv6BIyo4igClqApMWtiqH/ATpfn3r3oq0u4WLzLjJG
 QOp3ANAJhjBdFqUAJO6WdnAU5ExcU6DbocuD/gglFcugcmLofS06b01OBFXPXsUMkIWn
 odhoDdW3QJJ3d/RU0J0XpLDE9g/uQKUUPX9C8GZ0wYv14UYMpxHNbSH54kWK0lCxGAMX
 k1ZKDvcWtO62jNOhi8CdUydGNM2xvWcgMSuOfSyY+adMP3LM+X1Vg2sB7HODQIPxUjsP
 R8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262178; x=1783866978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=517GJyNBuZi5k0iP+IHcA4L7bP/uK04jnda2MyKM78w=;
 b=JIEe1ZEcum8WgAt3c0r3e+TZWf+FMYVS01KxGyTjKDO+Grw9pcE09UHz/PeQtCDNhl
 g9i3Uxng5n8ASdZTbRevGbbaMagb3yAUpuRo8SLXq3hT3Fl4UCgI77op520LzZ/ZmgBp
 s9rJVzw4/bldYuojBxF0/Sya+zGJZFPY5y+tTYKXEteCfZTGSSRO/N4YNWp0i3Y2qSJr
 shfzf68941tfdfwpt1e/OywEvszZQqg6HqCz5g2x1gss7LEfL1nWvA0IgLiTGOm1e3gN
 zUhvsqoXwCyemZv935DGdGpQvNm8vXwmiue70wQmanLF5vk5jefIJBh3fGSW1CXj7DTO
 m2VA==
X-Gm-Message-State: AOJu0YzazTX2qnZtpD70LcCT46Lm0bxP62A6I/Gv/p3h4Nq8zsakEy+5
 1de6iNb/3+03Zt9siEFJ1paEiP+B719lZLjaPxpt/ml+ZkxG8WQqaTBgKYd+blzZiPUyD8Znkxc
 oUyY20o5TMApq1axU2z/5PZcpamxDwLQEKZkgh2osAjlc89LVGwhvjR2Bf4c2PjNE8rxIs/Sc1P
 SIXxxkvmNXd2objUus9sOZa3Bw5gcqxiFEDQ==
X-Gm-Gg: AfdE7cmjLVAsDuJZvXopgeYw11EevKUJk9JxIuhiFLxniCZFYMuanrRaiirRC7hYPPT
 x7Z9u1VcPjPwGld8JPqjBl5dsofZ6/rJUyn74wdts2WiyZqj4bg5R7Ml0NVN9Fr2bKtQ1Uwa4xi
 9U/ynX0bGTv0HT4SZuyZVxMMl/IvvrE0RCBZiXmub164TNsfSlp3vt2rZqDRcgtW517iMcXB2IK
 e2nsGBIrgz5Ig1aBCSUqAmayA3qh8lMTi5XUgzrjw04JBQrvbeD4xWNrF/6P7wxvqsZ6VAOVGml
 lK9/eDmVZsR4wmhxy0ZyfBLTNR35Uz2I4SirOwL4NwcVGLE8mmB5t71yCRDWFnQJJ6N52/mdbsY
 q/JgQdjUom1s8e+/s0juBdA8+inbyglL6
X-Received: by 2002:a05:600c:154b:b0:493:b6c2:cd96 with SMTP id
 5b1f17b1804b1-493d11d9d42mr76068745e9.12.1783262178568; 
 Sun, 05 Jul 2026 07:36:18 -0700 (PDT)
X-Received: by 2002:a05:600c:154b:b0:493:b6c2:cd96 with SMTP id
 5b1f17b1804b1-493d11d9d42mr76068315e9.12.1783262177945; 
 Sun, 05 Jul 2026 07:36:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdabda3sm211307885e9.5.2026.07.05.07.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:17 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Demi Marie Obenour <demiobenour@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 40/44] vhost-user: Guarantee that memory regions do not overlap
Message-ID: <a63a6cd694cffa772e97bb37b0a304c8c7129397.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Demi Marie Obenour <demiobenour@gmail.com>

Otherwise there would be an ambiguity problem.  Suppose that:

1. There is a region from [0x40000, 0x50000) with mmap offset 0x500000.
2. There is a region from [0x48000, 0x58000) with mmap offset 0xA00000.

A request has address 0x44000.  Which mmap offset should be used?

This problem appears with both guest and user addresses.

Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260522-vhost-user-dev-v1-1-b31646cf19b8@gmail.com>
---
 docs/interop/vhost-user.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index a704f3cb53..ae8c7ed995 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -214,6 +214,18 @@ fields at the end.
 
 :domid: a 32-bit Xen hypervisor specific domain id.
 
+For all memory regions active at a given time:
+
+- ``[guest address, guest address + size)`` of one memory region never overlaps
+  the ``[guest address, guest address + size)`` of another memory region.
+
+- ``[user address, user address + size)`` of one memory region never overlaps
+  the ``[user address, user address + size)`` of another memory region.
+
+Violating any of these is a bug in the front-end. This ensures that a guest
+address or user address always refers to at most one location in memory.
+The front-end must remove a region before it can add an overlapping one.
+
 Single memory region description
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -745,6 +757,15 @@ The front-end sends a list of vhost memory regions to the back-end using the
 ``VHOST_USER_SET_MEM_TABLE`` message.  Each region has two base
 addresses: a guest address and a user address.
 
+Memory regions can be added via the ``VHOST_USER_ADD_MEM_REG`` message.  They
+can be removed via the ``VHOST_USER_REM_MEM_REG`` message. These messages can
+only be used if the ``VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS`` protocol
+feature has been successfully negotiated.
+
+Guest addresses are physical addresses in the guest.  User addresses are
+arbitrary opaque values, though they typically refer to userspace addresses in
+the client process.
+
 Messages contain guest addresses and/or user addresses to reference locations
 within the shared memory.  The mapping of these addresses works as follows.
 
-- 
MST


