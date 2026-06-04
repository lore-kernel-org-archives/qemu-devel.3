Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14BDCD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVEOt-00023Z-AU; Thu, 04 Jun 2026 16:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVEOl-00022C-Bd
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVEOj-0006Jx-QE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780603836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xyq8h8hqTv71FOssirA1M3dj1o6Kf0mKh1rpcCehnLQ=;
 b=FDifHlJqATppUUbdtmuKZTbCihUZJMzcMfQeQZ4Gegqty2a+aiJJZQbJrwcnypI3jGo+fo
 z/SNJUDicsqRe+hT2La29f/+9So9UmrB6GSOSqtV3kCNcljyZOZ7zrgx6ko9rJVmP4xlU+
 lSYDxsYiVxZiOHFHJ1QmMSAAxYzeYKc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-vX3H2CpJN-yTYBDycnLyWA-1; Thu,
 04 Jun 2026 16:10:34 -0400
X-MC-Unique: vX3H2CpJN-yTYBDycnLyWA-1
X-Mimecast-MFC-AGG-ID: vX3H2CpJN-yTYBDycnLyWA_1780603834
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF0DD1944D1B; Thu,  4 Jun 2026 20:10:33 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C8DF180049F; Thu,  4 Jun 2026 20:10:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, gmaglione@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, hreitz@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jorge Moreira <jemoreira@google.com>
Subject: [PATCH v3 1/3] vhost-user.rst: clarify when rings are started
Date: Thu,  4 Jun 2026 16:10:27 -0400
Message-ID: <20260604201029.250450-2-stefanha@redhat.com>
In-Reply-To: <20260604201029.250450-1-stefanha@redhat.com>
References: <20260604201029.250450-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Jorge Moreira <jemoreira@google.com> pointed out that the ring state
machine is underspecified. In the discussion that followed, we
discovered that the spec says one thing and implementations do something
else. This patch updates the spec to reflect how things are actually
implemented across widely-used front-ends and back-ends including QEMU,
crosvm, rust-vmm, and DPDK. Do this while taking care not to make any
other existing implementations non-compliant by changing the spec.

The spec says rings are started when a kick is received but the
implementations actually start rings when VHOST_USER_SET_VRING_KICK is
received.

Reconcile this as follows:
- Clarify that a ring can be stopped and then started again. The
  back-end must resume processing available requests when the ring is
  restarted.
- Update the spec to say rings are started when
  VHOST_USER_SET_VRING_KICK is received.
- Ensure compatibility by saying front-ends SHOULD inject a kick in case
  the back-end strictly implemented the old spec.
- Avoid future back-end dependencies on injected kicks by saying that
  back-ends SHOULD NOT expect a kick to start rings.

This way implementors have clarity on how things work while still
allowing compatibility for existing implementations.

Reported-by: Jorge Moreira <jemoreira@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 docs/interop/vhost-user.rst | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 137c9f3669..6ced95e080 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -462,12 +462,26 @@ Rings have two independent states: started/stopped, and enabled/disabled.
 * started and enabled: The back-end must process the ring normally, i.e.
   process all requests and execute them.
 
-Each ring is initialized in a stopped and disabled state.  The back-end
-must start a ring upon receiving a kick (that is, detecting that file
-descriptor is readable) on the descriptor specified by
-``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
-``VHOST_USER_VRING_KICK`` if negotiated, and stop a ring upon receiving
-``VHOST_USER_GET_VRING_BASE``.
+Each ring is initialized in a stopped and disabled state.  Rings are started
+with ``VHOST_USER_SET_VRING_KICK`` (or ``VHOST_USER_VRING_KICK`` if
+``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` is negotiated) and stopped with
+``VHOST_USER_GET_VRING_BASE``.  A stopped ring enters the started state again
+with ``VHOST_USER_SET_VRING_KICK`` (or ``VHOST_USER_VRING_KICK`` if
+``VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS`` is negotiated) and the back-end
+resumes processing requests.
+
+Note that previous versions of this specification stated that rings start when
+the back-end receives a kick (that is, detecting that file descriptor is
+readable) on the descriptor specified by ``VHOST_USER_SET_VRING_KICK`` or
+receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated.
+Widely-used front-ends and back-ends did not implement this behavior and it
+complicates poll mode back-ends that do not rely on the kick file descriptor.
+
+For compatibility with back-ends that implemented the start on kick behavior,
+front-ends SHOULD inject a kick after ``VHOST_USER_SET_VRING_KICK``.  This
+ensures that the back-end processes any available requests in the ring.
+Back-ends SHOULD NOT rely on receiving a kick after
+``VHOST_USER_SET_VRING_KICK``.
 
 Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
 
-- 
2.54.0


