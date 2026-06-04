Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8229CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVEOx-00029E-9N; Thu, 04 Jun 2026 16:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVEOl-00022A-5W
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVEOj-0006Jt-QX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780603835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cmtzOKEQw1c6DjOFWMs5YUuBOPa9/M9a4WtI3BCBN6k=;
 b=WGrpJp92Z06lH95mVWrAoKCzyPxgcsW/O+eNYv7o9sdlml/LNCl4Y0iTID89J6OOTHHoKj
 EnT0jSN0EhG3Rq76t9Awp6rRgVwprLudNqrbIHkmmejX2C4q9OPoYXE6o0WywBwc9jL2Uo
 jvN4maHKBHdWmuHwRymz90nF5kOFFbw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-p8TQ7uqRM5uLVENl1aJOhA-1; Thu,
 04 Jun 2026 16:10:32 -0400
X-MC-Unique: p8TQ7uqRM5uLVENl1aJOhA-1
X-Mimecast-MFC-AGG-ID: p8TQ7uqRM5uLVENl1aJOhA_1780603831
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39B01195608D; Thu,  4 Jun 2026 20:10:31 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 469A430001A1; Thu,  4 Jun 2026 20:10:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, gmaglione@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, hreitz@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 0/3] vhost-user.rst: clarify when rings are started
Date: Thu,  4 Jun 2026 16:10:26 -0400
Message-ID: <20260604201029.250450-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

v3:
- Fix sepc -> spec typo in Patch 1 [Stefano]
- Check for a -1 fd in Patch 2 [Stefano]
- Handle failure with vu_panic() instead of incorrect return -1 in Patch 2 [Stefano]
- Add eventfd_write() EINTR and EAGAIN handling in Patch 2

Jorge Moreira <jemoreira@google.com> pointed out that the ring state machine is
underspecified. This patch series updates the spec to clarify how the ring
state machine works, makes libvhost-user spec-compliant, and improves the
compatibility of QEMU's vhost-user front-end.

Stefan Hajnoczi (3):
  vhost-user.rst: clarify when rings are started
  libvhost-user: look for available vq buffers upon SET_VRING_KICK
  vhost-user: inject kick after SET_VRING_KICK

 docs/interop/vhost-user.rst               | 26 +++++++++++++++++------
 hw/virtio/vhost-user.c                    | 24 ++++++++++++++++++++-
 subprojects/libvhost-user/libvhost-user.c | 19 ++++++++++++-----
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.54.0


