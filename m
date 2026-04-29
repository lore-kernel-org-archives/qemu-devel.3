Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0A2FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIA4M-0006I2-21; Wed, 29 Apr 2026 14:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIA47-0006F8-VF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wIA43-0005kw-TV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777488914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qmAEdggD+w50lBQGh+VtjNZdFkz+DqfnR7K9I7DbZ78=;
 b=eEub15a2W7Jc2yAD2FpnsPW7AxdldFwY8k055By7BQJEJJJLi4777bcQm2YpEIhAx2eVJy
 4o6iJGzOsf1RPaeCN56B9g/mJ00QQLC/YnIxkeI5GsOse9qHR2S9Qv7BkXpbw82ctCVMDX
 q88S6HHcoR6cqg2tJEuBXr9L1Epi7r0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-Co6-PqxyNzSbWAegYjm-vA-1; Wed,
 29 Apr 2026 14:55:10 -0400
X-MC-Unique: Co6-PqxyNzSbWAegYjm-vA-1
X-Mimecast-MFC-AGG-ID: Co6-PqxyNzSbWAegYjm-vA_1777488909
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9D511956050; Wed, 29 Apr 2026 18:55:08 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 429C6195608E; Wed, 29 Apr 2026 18:55:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 gmaglione@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jorge Moreira <jemoreira@google.com>
Subject: [RFC] vhost-user.rst: clarify when rings are started
Date: Wed, 29 Apr 2026 14:55:04 -0400
Message-ID: <20260429185504.221124-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
other existing implementations non-compliant by changing the sepc.

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
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This is an RFC because I will update hw/virtio/vhost-user.c and
libvhost-user once we've agreed on the spec wording.

 docs/interop/vhost-user.rst | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 137c9f3669..72d792930e 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -462,12 +462,24 @@ Rings have two independent states: started/stopped, and enabled/disabled.
 * started and enabled: The back-end must process the ring normally, i.e.
   process all requests and execute them.
 
-Each ring is initialized in a stopped and disabled state.  The back-end
-must start a ring upon receiving a kick (that is, detecting that file
-descriptor is readable) on the descriptor specified by
-``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
-``VHOST_USER_VRING_KICK`` if negotiated, and stop a ring upon receiving
-``VHOST_USER_GET_VRING_BASE``.
+Each ring is initialized in a stopped and disabled state.  Rings are started
+with ``VHOST_USER_SET_VRING_KICK`` and stopped with
+``VHOST_USER_GET_VRING_BASE``. A stopped ring enters the started state again
+with ``VHOST_USER_SET_VRING_KICK`` and the back-end resumes processing
+requests.
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


