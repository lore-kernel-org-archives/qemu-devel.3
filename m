Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE154CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX4i-0008HN-2R; Mon, 25 May 2026 11:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRX4T-0007it-Vz
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRX4O-0000kv-S1
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yoAryUd7auyK5Z0fZ7CaL+k+c2Y+PmlKey/Jl6QvjGQ=;
 b=QjsZIqTArx1u/3f0yKNaVQWd/0+mcLl35NkL4qEJSPsxrS9XDfx9iAnySzzw7vUpMJoio4
 umvXHIrwlk3MojpaLcZSufhjqzlKpyxv6fNKo4P/5rDerBg7lw3JYFNm89kyDEtnbYrqlD
 7IjbztKU3450CRtVsuuIJQDOGIfDNmY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-5ZGkEmrZM_mLOUkvUMk1Lg-1; Mon,
 25 May 2026 11:18:16 -0400
X-MC-Unique: 5ZGkEmrZM_mLOUkvUMk1Lg-1
X-Mimecast-MFC-AGG-ID: 5ZGkEmrZM_mLOUkvUMk1Lg_1779722295
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89B44195608E; Mon, 25 May 2026 15:18:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1385F1800352; Mon, 25 May 2026 15:18:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/1] Block patches
Date: Mon, 25 May 2026 11:18:10 -0400
Message-ID: <20260525151811.1643855-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit cbf877d67a812be17a9ce404a589e1bdf722c1f6:

  Merge tag 'pbouvier/pr/docs-20260522' of https://gitlab.com/p-b-o/qemu into staging (2026-05-24 07:45:19 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 6864bec553b2e37699739615e604fc3c7bae0e1d:

  block/linux-aio: bound ioq_submit() recursion depth (2026-05-25 11:17:23 -0400)

----------------------------------------------------------------
Pull request

Denis Lunev's linux-aio stack exhaustion fix.

----------------------------------------------------------------

Denis V. Lunev (1):
  block/linux-aio: bound ioq_submit() recursion depth

 block/linux-aio.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.54.0


