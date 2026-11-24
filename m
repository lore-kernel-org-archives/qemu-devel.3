Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA748606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AkVwvSqk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpwO-0005S3-6k; Tue, 24 Nov 2026 07:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xVpwK-0005RL-Sw
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xVpwI-00009r-Vb
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795524480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e7E0PSjfMYKFzbxrMHUv/B6Q1F0N7L/0XuzsSTgbgys=;
 b=AkVwvSqkByEjna5iamyViC7bK8Oe+QpmSS74J68OgqCFoh2Ju1hYDgt+StuXmQ8L0dwH/u
 Ker8IdI89aG5fsY2DgPzvbFXtdcC8NDwGk/TEMWROxCIbJWXRhSbe/gofDF1USUmvnP8cp
 TmVAwQJ5E1ztGDqdQ3Qm5lef7Ea/fNs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-H8dY7qBVN6Wo887kHQy-EQ-1; Tue,
 24 Nov 2026 12:47:57 +0000
X-MC-Unique: H8dY7qBVN6Wo887kHQy-EQ-1
X-Mimecast-MFC-AGG-ID: H8dY7qBVN6Wo887kHQy-EQ_1795524476
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED9BB195DE4A; Tue, 24 Nov 2026 12:47:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C07A18011D8; Tue, 24 Nov 2026 12:47:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 0/6] vhost-user-gpu fixes
Date: Tue, 24 Nov 2026 16:47:43 +0400
Message-Id: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBCG4auQrq2h7aSAK+9hXPRnkJoIpoVGQ
 7i7LW4k6vJL5nlnJgG9w0AOxUw8Rhfc0KcBu4KYTvUXpM6mTXjJJWOMUxfChBRqqKmFxkpta6w
 0kATuHlv3WGOn83uHSV/RjLmQLzoXxsE/12+R5buf4choSRVqxUyL3JTi6NF2atyb4UZyOfJPK
 zaWJysFAwZSgjbqy4r/ViTb1AitElhVqDd2WZYXYw+w2i8BAAA=
X-Change-ID: 20261112-issue-4848-d49d6bd8e7b4
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry@taktcycles.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2269;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=awIdFKPYNR3Q3rDClrhWGXX0bWRYh0m7kUXMTqRHrSI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBrBYd16+OT/nlELdF3AbogmBtLd6M/MBsVxyWu0
 gjmlEIdQumJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCawWHdQAKCRDa6OEJdZac
 5RImD/sHXDHNxwRcWVJfJKnBZ4448LaPJdT2DcG9OlXbFZJUcRrbZ7wOTv5Xcwg/HSAwFVB4s/u
 +RpWM7tjCJCAdKuzF7bRDyRhYPHELR8IgYRXOIlSEad+rtcBbdapx5YS/vLWyemA9Eo4Bpf+2yT
 WMexXxFKWdzoocho7daK2nMoZmaI61JlHDIzcYD1LcrbhcXTxDt+Kr2LNjXr7W23t1K7qG8J107
 AyPZibIppMrQsF7pat7p0kSkhbLKSFynMZBhtvFn8Vvqt/sW0pmBD29mw5NdDLlPbwPpZ+kOe/v
 NbVKkrjyEoPdv8dx95kBeZbjfngGUZnmQSSBWMnsHnHXp32Df4cpR1tQUVvSGdCG89ukwj9Y9ju
 geUnwJDM0DEKLr1iOZCsnrOKu/2haTE3llLtZOrhEAHy6meVJ4mOiRNIrHuGvyLmrKraN/TBpQR
 c3nhIA+NWJisQHY9vnlRfr5Dan3/S/kYViQo9aabp2AycBj8Ui6uXz8qFimZMV12SQqafr5mjZI
 THekt8R9paO2Tkr3yqhaPpX1xA7ENwYWoCkOMBzTGjgF7w9J9bNqci4YIqRKR9cekeGnM/di2p7
 uvRGC1Ft5t96rXi7opMrb8OMsrYIG8h/7kk0NCJtpTlLNv25YfKGdVP1f6howfFJaxiiJU+iCI3
 jHlkDZFTF99nl+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dmitry reported a handful of vhost-user-gpu issues (#4847-4849): crash
when a command waits for a reply and a fence is signaled (#4848), guest
losing display when the device is restarted (#4849), or main loop
spinning on bad descriptor (#4847). The first patches address those.

The rest are problems found while working through the code: console is
not resized on dmabuf scanout, the 2d scanout path frees a surface it
does not own, and the exported dmabuf is imported with the wrong stride
in some setup.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v4:
- replace vg_wait_drop() with vg_wait_cancel() when queue stopped 
- drop patch 3 & 4 #4846, waiting for Akihiko series ("[PATCH v3 0/9] virtio-gpu: Do not wait for the main thread during reset")
- Link to v3: https://lore.kernel.org/qemu-devel/20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com

Changes in v3:
- fix crash on finalize
- replace Dmitry email address
- Link to v2: https://lore.kernel.org/qemu-devel/20261113-issue-4848-v2-0-631414664bca@redhat.com

Changes in v2:
- add "hw/display/vhost-user-gpu: reset scanouts on the main loop"
  patch, similar to virtio-gpu
- add Tested-by tags
- Link to v1: https://lore.kernel.org/qemu-devel/20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com

---
Marc-André Lureau (6):
      contrib/vhost-user-gpu: don't fence commands waiting for a reply
      contrib/vhost-user-gpu: reset the frontend socket on stop and start
      hw/display/vhost-user-gpu: don't set an fd handler without a socket
      hw/display/vhost-user-gpu: resize the console on dmabuf scanout
      hw/display/vhost-user-gpu: fix scanout bookkeeping on the 2D path
      contrib/vhost-user-gpu: use the stride of the exported dmabuf

 contrib/vhost-user-gpu/vhost-user-gpu.c | 169 ++++++++++++++++++++++++++------
 contrib/vhost-user-gpu/virgl.c          |  70 +++++++++++--
 contrib/vhost-user-gpu/vugpu.h          |   7 +-
 hw/display/vhost-user-gpu.c             |  56 +++++++++--
 4 files changed, 250 insertions(+), 52 deletions(-)
---
base-commit: 2bfbe39d0fff8af881cffe2bab9b615e77807c35
change-id: 20261112-issue-4848-d49d6bd8e7b4

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


