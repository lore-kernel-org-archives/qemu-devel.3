Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEEDC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8m0-0000EX-CF; Wed, 03 Jul 2024 18:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lw-00086p-Bl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lu-0003tg-Pj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxEb4qxo9i3miZ1US5mo9RXgQJuGwUKVIRe5VRPOVeg=;
 b=BK9PRDDb7owX58Nwe66Y6glx+VHarnPU+M9o9W+K/RuvYMhudN3P1S3oCaMkbYSWh+Bar2
 m20q7rZHfxN3dhfO3xv3SUPUiBma0xPvrlCeHTMrPHk015kKqL0A91RdTkKMBZ8cluxpyT
 ECJo16SVy78PET1CRL1hsxR1lpPGyEI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-OMtj9WM9OzeN_l9XyFz52A-1; Wed, 03 Jul 2024 18:48:17 -0400
X-MC-Unique: OMtj9WM9OzeN_l9XyFz52A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e98693f43so1141085e87.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046895; x=1720651695;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SxEb4qxo9i3miZ1US5mo9RXgQJuGwUKVIRe5VRPOVeg=;
 b=ws5Rbkc5vmF2iXl8QzYWRZL98mUT0NTmVoMB5MiyhJuLSzysFj6mZZPEH8HSFtgygR
 +D5rA56x02D4nYSsaa2JpmcFGdrkX49r9uVXVmaNpYmJvBO4RWe4HJPo/OKwZO1GRCP9
 x9Tx1O3s0XCOIOBsrBXMbKWOrUfYMfKJyoBgXMmwVNDGMOK+iDX1RQG5Y3HIaiqOl4nK
 N8F4j5k20Wf022drgeXLdoBVT+QaGYGYVLsncW4gO7w96aYjKYkzHr6q9FAMJPKWa237
 kWtAoBSljdkb7JxzCrRTy8lLIMxMFjJxJUTdJv6z9cUayvPpV5EqIEe0aX+jQ5Akic5x
 P4NA==
X-Gm-Message-State: AOJu0Yyy/n7qb2rUMLs15vTWaDkZYHJz8a26wqqBVXNcdtXCIfqJQX4g
 8Udwkn6WOKXBZ30r1wh2U81lij1QFkni9OfoINbhqTBZbjlRZZBwSwJ9bIT06bneBSmce5Istar
 uvmMyNO/manKRsHefueGAAo9kYo7tSNbeDYPsoqdksG3fyd0LTRvcwAEF4VTEhsBPBDtxbMy/4D
 SJJY3GND1Dm7qxMVD7mPTPmT7w0LYfJA==
X-Received: by 2002:a05:6512:1387:b0:52c:8339:d09b with SMTP id
 2adb3069b0e04-52e82651f75mr10349876e87.1.1720046895260; 
 Wed, 03 Jul 2024 15:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ2JSk5VrTqKVB9bK6M/xzcvPqQ4UVmgwFKg9BdWTWuzkobEjD+y57MmuqE0ry9ZOiIL50Bg==
X-Received: by 2002:a05:6512:1387:b0:52c:8339:d09b with SMTP id
 2adb3069b0e04-52e82651f75mr10349857e87.1.1720046894636; 
 Wed, 03 Jul 2024 15:48:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a751561bb1bsm412719466b.37.2024.07.03.15.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:13 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>
Subject: [PULL v3 50/85] vhost-user-server: do not set memory fd non-blocking
Message-ID: <4c58843e5d3192c67394b28a3330144ea56eefac.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

In vhost-user-server we set all fd received from the other peer
in non-blocking mode. For some of them (e.g. memfd, shm_open, etc.)
it's not really needed, because we don't use these fd with blocking
operations, but only to map memory.

In addition, in some systems this operation can fail (e.g. in macOS
setting an fd returned by shm_open() non-blocking fails with errno
= ENOTTY).

So, let's avoid setting fd non-blocking for those messages that we
know carry memory fd (e.g. VHOST_USER_ADD_MEM_REG,
VHOST_USER_SET_MEM_TABLE).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-6-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 util/vhost-user-server.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 3bfb1ad3ec..b19229074a 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -65,6 +65,18 @@ static void vmsg_close_fds(VhostUserMsg *vmsg)
 static void vmsg_unblock_fds(VhostUserMsg *vmsg)
 {
     int i;
+
+    /*
+     * These messages carry fd used to map memory, not to send/receive messages,
+     * so this operation is useless. In addition, in some systems this
+     * operation can fail (e.g. in macOS setting an fd returned by shm_open()
+     * non-blocking fails with errno = ENOTTY)
+     */
+    if (vmsg->request == VHOST_USER_ADD_MEM_REG ||
+        vmsg->request == VHOST_USER_SET_MEM_TABLE) {
+        return;
+    }
+
     for (i = 0; i < vmsg->fd_num; i++) {
         qemu_socket_set_nonblock(vmsg->fds[i]);
     }
-- 
MST


