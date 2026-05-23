Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C20CD5BB8
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 02:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQbro-0002sq-OG; Fri, 22 May 2026 22:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1wQbrn-0002si-75
 for qemu-devel@nongnu.org; Fri, 22 May 2026 22:13:31 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <demiobenour@gmail.com>)
 id 1wQbrl-0007xv-Gb
 for qemu-devel@nongnu.org; Fri, 22 May 2026 22:13:30 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7ca947f9b00so74971927b3.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 19:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779502408; x=1780107208; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EVAy2N7dENytRYyjuuIQzoC2VcTAeFY/cEVS/jn2bhI=;
 b=FNH6rYnduKj1FF8HBQfjSQM3Jv+mCLgK+48V1oVsdmI3XXIFIW8W0wHZfCiENqE8wb
 mBM87C9TYGvzY/he6ZmhMJ00KntZV1t9ZzxOlwi6HdeMkT/kBTC48VhIHRJuQ4gzYGPo
 j/JWcvMgJk0NSj0JqNkyIcLKg9OoVYvqlyAG8gu96H8pD/wD0C2N/bMqCYDTAi7l3PfX
 drWob7sXXs3gyD9sEErCZe2oyq5e4cYGG9WKeqphCA6uO0dHLo9ak4zaSfiBQs4szKX/
 XRE7zQEKeuopAgGUTh7rjLrtz/nveqFcsXglDrcfz+U2PRGPxtC+XKF98aVi6qBVTBgq
 hYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779502408; x=1780107208;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVAy2N7dENytRYyjuuIQzoC2VcTAeFY/cEVS/jn2bhI=;
 b=CSTKV9lX+FtihgUNkilaBU2cutMtjJjrVVLsqopWnZnZ94fyqJm66Z63Eq1WOj+Z8B
 NA2YJe8hNT6rRmLgMU9N7AW+eKNgoSwPHZT6CplGRxQlRHnunNxVsJKrIOAfGFV7vV4r
 HXs600vk1Z7YuIGIwLrtzA/aA2KLdPesnwHYaHiDg2ayRlCwcjoAyBoo4n3kQUiVT9O3
 lUh0wGPGCJPJmWLNh2Cep0lKPt+/5ux5YgJ9flxau5g0nbnqLG6QbMEEHzZQiOVLJtPr
 LvOl6bBwrVTuucurmRe+XQpj3VOChDVSC22uiO58wWF4EnlxPm/XGxOYOLqRq9k16SQG
 TgIA==
X-Gm-Message-State: AOJu0YwZk/DGLQLfuS/KuHuOr5NxBkchvdEjsWIUzGoo6OaKlJQpB62/
 hCNGlLZpdwqpt1r8zAbYf6DnCD88KhwTnWkt1yL9Fth28OKB0mD9g3WGCGoGew==
X-Gm-Gg: Acq92OHYFZWL3cSgdgE0yY8wpVzIh93T1dkdf9Ckwp3gTWSv5Cq14YICaDz6hOv8OCY
 189LzKa8js8MKjk9yVTVFhdfrsF8a1AhVDtjoel+UOWxRPwxpPeesaRZlLJaWtaIzkcUSMDQaNf
 eTm4dcq6eqxyvzwIkdEi3VpXtP6lBYRkMHrn57bFZlS4nwLr2oHuFiN8FgCutvh9gT8y8Ij5+AT
 Y+U/hm3X5U2AfvWIgZRFraBzhuEBoO1tf6dlyv+hkAW7Bv/kxMFhdsKoDVYK1WXoUx9Q1ekXLVt
 UVHilxKafGu8G/ZuvzlkX2ZSj7TnxskZZ6CqCFWJcrcxL1xKczicl4N68ZuaQmjJFJr5m7JvqwL
 Fgul+H8vmw+ujYMH+rSfVllg/Lif4fRBHMRCnbbVhF3F61mquXRivRCRMXwZB7vM7DozSDl9dVH
 92A03IqKGZA0uf09GkXce8Bzlzlg+U4WWskKa8FQeqhSNNfyA1Np6XAtxU1lGSUJo6suM4j6FZY
 yotj2dKGvGAxam8ePWIOKpF5CTQRC4cRH83ZVlyoybpPvA=
X-Received: by 2002:a05:690c:7402:b0:7bd:4792:671e with SMTP id
 00721157ae682-7d3368b514emr72489927b3.44.1779502407651; 
 Fri, 22 May 2026 19:13:27 -0700 (PDT)
Received: from localhost.localdomain
 (h69-131-147-66.cncrtn.broadband.dynamic.tds.net. [69.131.147.66])
 by smtp.gmail.com with UTF8SMTPSA id
 00721157ae682-7d389813ea8sm16006237b3.4.2026.05.22.19.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 19:13:26 -0700 (PDT)
From: Demi Marie Obenour <demiobenour@gmail.com>
Date: Fri, 22 May 2026 22:11:09 -0400
Subject: [PATCH] vhost-user: Guarantee that memory regions do not overlap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-vhost-user-dev-v1-1-b31646cf19b8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQ5AQAwAvyI9a0JlCV8Rh40tekG2bCTi78rc5
 jBzg3IUVuiyGyInUdlWkzLPYFz8OjNKMAcqqC4cEaZl0wNPyzBwQu+bmqvWfYBFe+RJrn/YD8/
 zAsb2tURgAAAA
X-Change-ID: 20260522-vhost-user-dev-aa76e3955555
To: qemu-devel@nongnu.org
Cc: Spectrum Development <devel@spectrum-os.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779502268; l=2474;
 i=demiobenour@gmail.com; s=20260522; h=from:subject:message-id;
 bh=DcOvHMZTfNqa4d8WJ/QyRMi1J6muszY9M8HHPZXQ7vY=;
 b=P6MyBWf+HUUR0O47l18m77HSa2SgibTdPuXKo7oP12nCRmEfopNUBi+7BGQt75PI5TAXiyFa2
 ovTIezBvYx/C36hk1CmMBa5oM/mVM535NBAcmjwASkZXIyonWU+7P8o
X-Developer-Key: i=demiobenour@gmail.com; a=ed25519;
 pk=nGU95VwdzJC/7FntDm86n3631qniCqHTUlkeI9mftck=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=demiobenour@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Otherwise there would be an ambiguity problem.  Suppose that:

1. There is a region from [0x40000, 0x50000) with mmap offset 0x500000.
2. There is a region from [0x48000, 0x58000) with mmap offset 0xA00000.

A request has address 0x44000.  Which mmap offset should be used?

This problem appears with both guest and user addresses.

Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
---
 docs/interop/vhost-user.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 137c9f3669..8c122c9d21 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -204,6 +204,18 @@ fields at the end.
 
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
 
@@ -672,6 +684,15 @@ The front-end sends a list of vhost memory regions to the back-end using the
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
 

---
base-commit: f5a2438405d4ae8b62de7c9b39fac0b2155ee544
change-id: 20260522-vhost-user-dev-aa76e3955555

Best regards,
-- 
Demi Marie Obenour <demiobenour@gmail.com>


