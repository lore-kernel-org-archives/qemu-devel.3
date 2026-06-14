Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656DECD98D6
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDS-0000NH-4X; Sun, 14 Jun 2026 15:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDL-00083k-Om
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDJ-0002in-TS
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFGMyc+0ZCdk1q8E2z0hqTjCrgd8ApTKlIJGppaxQvE=;
 b=d3C8V1X9dsKiaAIEIj169aq+42AnI4zmgcT6Xfjp1C5Vgu1KrIjZjQxrqvKUIUX7WHJ1g1
 rwAa/soakPQ63fCctXC6DJrq7ol70p0tp3KGIe7A0nlGHK1hzoVJajzjb7rUHWdMX1RU3n
 5IH4xIE0ryi2r724T1Hu2ueSr+98iQE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-dqBqso0hMIiXdFXNkweXZg-1; Sun, 14 Jun 2026 15:09:44 -0400
X-MC-Unique: dqBqso0hMIiXdFXNkweXZg-1
X-Mimecast-MFC-AGG-ID: dqBqso0hMIiXdFXNkweXZg_1781464183
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45eecec7667so1758809f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464183; x=1782068983; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nFGMyc+0ZCdk1q8E2z0hqTjCrgd8ApTKlIJGppaxQvE=;
 b=YVXXLfMcVctkpIuwSzrANTvhSgdBcnBH06qQ5TR7WK6K+QoHCbKefQFQwayZdyNPlu
 Ze9axDNie0wQj6c2E1MF28QLiv3BXT0IQqEVGgSamtKREeeBjDY6Nxq/s7Lc0PBAqL4q
 9qn+S50xuepqM3VuaY/xU8p/BjHXAc9qcvk5kad8e1jRrkHhtsi71T4l6MuQofCGnTKI
 bOgnBIfQckUzmEul0AEkXFo2nHlYjTnkr6hmXZWnbTurFvyWCftUwylTwpb1f2ABUVZA
 1fIU9DFSV7FigwUf7Nd45EnuR94D6pvFgu7CHV4YiGe98hCWht505YEq5dqmMQA/r+1X
 hraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464183; x=1782068983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFGMyc+0ZCdk1q8E2z0hqTjCrgd8ApTKlIJGppaxQvE=;
 b=Pje3VUlM6/t6udoSoQ4OOWQjG7prVNlGT2kt299+7hH6CZWZivdVco2Q0kQoX6de0E
 KblUtV3d+AVtoDscG+LDYMd9MvISEc1GbeYskvq2dza8xc2TSAPqbON8W2bkxy0Qi3gi
 uKt7uo+dbftiC97UIkuAOjfcRD/Wp9qUq2zoitOa39IBQCSgVC+oKE/i6HLjhGYPpTAt
 fjFAMuLI8LduFJsMa+GeJPN8iSCD3/z/uO500t2+bLMcig6BM0sGvUXNxN6Q0OS3a/eb
 V5ujgIYqODUCoKJb7T3FFKagWv0tlJMSUafyF0F69TP3G4BQ6Z/z1wKsYTNqJB/c7FON
 XGig==
X-Gm-Message-State: AOJu0Yy4Y5LzUQ76hud8E0XR2grkgQbKmIPzI+b1kbII/u5DqEntZx7K
 +F4YpkgWBWlxWDuslN6Q8aj5eE1OCBPqS7Oe5DOPPeRRd2EDbCEaCSXKzDc0FOHqAXbW6yM9V6P
 POb607aJzb86DOb+3dGY4GJ0HIb3PGetNserCJt9v6qwJcwpodeliEl/xnf4fyAS8NOO0zK38xe
 SlT+tbwnCF6o6wBPC9TtEZvberF+OuJageRg==
X-Gm-Gg: Acq92OGz2y0RFlbj618uJp6wiLhuKGRkEZOLw4Gn1b54I533g98jclFohv6MuXdqIho
 +q30YW0jyRCis09qos6svDDW4ksWtI2WakD3igfjoX+njAidkJsYl7dwj0golhQsU1/sDG57Rnz
 5MWQKMaTdiLR6gSMwI9n4FRLZt2Di+ig33YA+qxSr9PCmmzfJl0MZydPQCzUXXw6pEnJUaZjtCT
 vGORNd3zwM3n4+OdGlRkaGt1CYCIRWnmku+fB3cWtvr4QjgB4MnfavoSO2geF4foQdCq7LZEq0m
 YE9uYeKylAKjIqBeHUraAFDdCtPJ6TGHONK2WnymQP+QuZDJYGP7FdnW1+WpK9HFXwMKLwyQWjp
 3YCbbMoX3j5cUdw9CTqL7PbHgSnDJCT/+U5aWMnKGAMM=
X-Received: by 2002:a05:6000:220d:b0:45e:ec47:aa10 with SMTP id
 ffacd0b85a97d-4606dbba154mr14980880f8f.32.1781464182867; 
 Sun, 14 Jun 2026 12:09:42 -0700 (PDT)
X-Received: by 2002:a05:6000:220d:b0:45e:ec47:aa10 with SMTP id
 ffacd0b85a97d-4606dbba154mr14980853f8f.32.1781464182348; 
 Sun, 14 Jun 2026 12:09:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm28704170f8f.24.2026.06.14.12.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:42 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 095/106] vhost_user.rst: Add GET_SHMEM_CONFIG message
Message-ID: <060ed6a4bb4d50e3de257a29137e84843f069312.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Albert Esteve <aesteve@redhat.com>

Add GET_SHMEM_CONFIG vhost-user frontend
message to the spec documentation.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304165223.2166175-6-aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 4182d721ca..c0ae4cba98 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -384,6 +384,22 @@ MMAP request
   - 0: Pages are mapped read-only
   - 1: Pages are mapped read-write
 
+VIRTIO Shared Memory Region configuration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
++-------------+---------+------------+----+--------------+
+| num regions | padding | mem size 0 | .. | mem size 255 |
++-------------+---------+------------+----+--------------+
+
+:num regions: a 32-bit number of regions
+
+:padding: 32-bit
+
+:mem size: an array of 256 64-bit fields representing the size of each
+           VIRTIO Shared Memory Region. ``num regions`` specifies the
+           number of valid regions (non-zero size). The array index
+           corresponds to the shared memory ID (shmid).
+
 C structure
 -----------
 
@@ -410,6 +426,7 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserShared object;
           VhostUserTransferDeviceState transfer_state;
           VhostUserMMap mmap;
+          VhostUserShMemConfig shmem;
       };
   } QEMU_PACKED VhostUserMsg;
 
@@ -1794,6 +1811,28 @@ Front-end message types
   Using this function requires prior negotiation of the
   ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
 
+``VHOST_USER_GET_SHMEM_CONFIG``
+  :id: 44
+  :equivalent ioctl: N/A
+  :request payload: N/A
+  :reply payload: ``struct VhostUserShMemConfig``
+
+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
+  successfully negotiated, this message can be submitted by the front-end
+  to gather the VIRTIO Shared Memory Region configuration. The back-end will
+  respond with the number of VIRTIO Shared Memory Regions it requires, and
+  each shared memory region size in an array. The shared memory IDs are
+  represented by the array index. The information returned shall comply
+  with the following rules:
+
+  * The shared information will remain valid and unchanged for the entire
+    lifetime of the connection.
+
+  * The Shared Memory Region size must be a multiple of the page size
+    supported by mmap(2).
+
+  * The size may be 0 if the region is unused.
+
 Back-end message types
 ----------------------
 
-- 
MST


