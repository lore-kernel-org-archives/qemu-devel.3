Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5546C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZVq-0003rj-6D; Tue, 14 Jul 2026 05:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjZVo-0003r0-QC
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjZVn-0000zl-Dm
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784021590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O1qAJ0+vRByLo6IoJgaxUKHIXOJ+zmD90BewckOPauc=;
 b=W7WMRHZTqb/edLcU/I4It/zc178WQf5yv5aNN7/iLyaLZlGNdOkoVSALlQcELHHldyaHye
 EzWNmTKNuhzUDPOznDiOBlevYEUd09Orxc0bbRDbPOJyIOhzsMd5ILM0Hi9uyw2Fov2o6J
 DzPW/toLG6cVrnxN+v18Q48yjwfRjvY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-GVXbSvblNKK0ZrXpgybZhA-1; Tue,
 14 Jul 2026 05:33:06 -0400
X-MC-Unique: GVXbSvblNKK0ZrXpgybZhA-1
X-Mimecast-MFC-AGG-ID: GVXbSvblNKK0ZrXpgybZhA_1784021586
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 152CF1802666; Tue, 14 Jul 2026 09:33:06 +0000 (UTC)
Received: from gondolin.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1324B414; Tue, 14 Jul 2026 09:33:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PULL for-11.1 0/3] s390x fixes for 11.1-rc0
Date: Tue, 14 Jul 2026 11:32:57 +0200
Message-ID: <20260714093300.2193848-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=cohuck@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit 499039798cdad7d86b787fec0eaf1da4151c0f05:

  Merge tag 'pull-request-2026-07-12' of https://gitlab.com/huth/qemu into staging (2026-07-12 21:49:04 +0200)

are available in the Git repository at:

  https://gitlab.com/cohuck/qemu tags/s390x-20260714

for you to fetch changes up to 33bece0fa121c0a85df4f0372145ca74b967e78e:

  s390x/css: firm up handling of chained TIC CCWs (2026-07-14 11:19:34 +0200)

----------------------------------------------------------------
more s390x guest->host interface hardening (sclp, css)

----------------------------------------------------------------

Christian Borntraeger (2):
  s390x/sclp: prevent re-reading the sclp header
  s390x/sclpcpi: check event length field before reading from buffer

Eric Farman (1):
  s390x/css: firm up handling of chained TIC CCWs

 hw/s390x/css.c         | 7 +++++++
 hw/s390x/sclp.c        | 4 +++-
 hw/s390x/sclpcpi.c     | 5 +++++
 include/hw/s390x/css.h | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.55.0


