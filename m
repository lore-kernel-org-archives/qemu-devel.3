Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52791C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfRi-0001j9-1r; Mon, 24 Jun 2024 04:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sLfRg-0001iw-B9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sLfRe-0008JF-Ou
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719219181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AlxnqO8Q5IArSCiXX39SZH8ct9mH2phQBddzEknYAgw=;
 b=AcKFScjLsPAEfaKEWDThwmove9w7PAcG/cXsmoh6z4KUOsZQbwX+Inep6fnbo1XNga+YYz
 dR20CkOznSdJE5zaqgtaiFWe+qIHqn17wqEa+vC5t3E+91L1ZE2ulHAnWpLifedXiONOjy
 1q7WjL8ixkgBeXvxhYz2LhsRrHqW7Iw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-XFkYp7WiNLyrXlXPHD1aCw-1; Mon,
 24 Jun 2024 04:52:57 -0400
X-MC-Unique: XFkYp7WiNLyrXlXPHD1aCw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B40F219560AD; Mon, 24 Jun 2024 08:52:56 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29F7C1956048; Mon, 24 Jun 2024 08:52:54 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	mtosatti@redhat.com,
	michael.roth@amd.com
Subject: [PATCH 0/2] i386/sev: Two trivial improvements to
 sev_get_capabilities()
Date: Mon, 24 Jun 2024 10:52:47 +0200
Message-ID: <cover.1719218926.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I've noticed that recent QEMU + libvirt (current HEADs, roughly) behave
a bit different than expected. The problem is in recent change to
'query-sev-capabilities' command (well, sev_get_capabilities() in fact)
which libvirt uses (see patch 2/2). The first one is trivial.

Michal Privoznik (2):
  i386/sev: Fix error message in sev_get_capabilities()
  i386/sev: Fallback to the default SEV device if none provided in
    sev_get_capabilities()

 target/i386/sev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.44.2


