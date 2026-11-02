Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B7606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eUJIAAFW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqf1-00082X-C5; Mon, 02 Nov 2026 06:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xNqez-00082D-IE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:57:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xNqex-0006Eg-Pc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793620625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gNI9EjKu7RgbNwfDHL6LwDG77r+q2D8WEBVPki+s4XQ=;
 b=eUJIAAFWBMIN98qAgeNgjExXqf+DGnEW29H1r7MAb4viQxyUq5tYzozV0Iaj/3DRKjvosV
 3vIBxwsxCeeY7iDRpjFKyU2xNRN31tYstoP+s7HfqBk9IcP5CrWCSwbH5siCZoSvk3RWso
 fs8DL4eWV4yYEFG7ZEU1fBhNpjBBLHg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-DeC_pw3LMVOOR4ej_SF8yg-1; Mon,
 02 Nov 2026 06:57:02 -0500
X-MC-Unique: DeC_pw3LMVOOR4ej_SF8yg-1
X-Mimecast-MFC-AGG-ID: DeC_pw3LMVOOR4ej_SF8yg_1793620621
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47F30195FCCE; Mon,  2 Nov 2026 11:57:01 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15914180029C; Mon,  2 Nov 2026 11:56:59 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/1] Bug fix for QEMU Guest Agent on FreeBSD (2026-11-02)
Date: Mon,  2 Nov 2026 13:56:55 +0200
Message-ID: <20261102115657.89700-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:

  Merge tag 'qemu-sparc-20261101' of https://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-11-02

for you to fetch changes up to 03efcb7cfdef40ee3124a80b2609d800ec1df1db:

  qga: set FreeBSD virtio-serial channel to raw mode (2026-11-02 13:06:30 +0200)

----------------------------------------------------------------
qga-pull-2026-11-02
-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEwsLBCepDxjwUI+uE711egWG6hOcFAmrodkgACgkQ711egWG6
hOf72Q/+MCFGtqqVlDhHsPYpJgF1p8gZxe3zZEkgQJJc4rTXKtyq0WaJZcXWPHK1
ZohSMf8JHB1S7NbP/smjWdQrWSAcyrB1eJHv+O2g2AEEeJopHUXqu3oZ5C4ETBqr
3wKgUwqtsA2pBjC9+BVb1p9ANkP1nK38TbcVcC4t7hBKzJnG7y8Y2BtqbVONQO0G
7yYm7EzY+3KI7mJanWhUAtKR6alTAUQM1kIdceSaYxKEEMH9IgwXZc3l1nRo0yHo
qvVKcz70E2LE3En6ml+vqAq+ANWCrKAgX3nqJlyPhveeGaLQ4qxuDehqyqUI4TiQ
2TKCwLpooiTPa3Zrvz6SojQgfc9l2kkQB4YdLsxpD0yUfdB8mfG54CBS0RmGrj0b
xnRbHrCd04Xs0gYsK26JlBmxTrd+gCEvmhR8Tvdt8R/c1PbxdFj8kPMkb2FBiJLl
Y7ByzuUGrccYToCIQ5hAmmIE1cufN/7Xvug6QmnGA+ogT0SP47xpKI1wvUl3H1dN
84bGrD7ThnuzuqZI2Gs0YBmCzggw3fzKgQm2PfFbVgiR5TvQr59+sCCDpojuT3ip
ZjfpLmJeqm/JZJyHa0NV2Yqle7J4yYr4Dzcfqlx0i9aOWL7S1whjM9gg3dd3CF07
gUCYbYs96cZ6XNypUg3RP/fL6Fi9rjg+4PN5UiBnXB1APs6lZBE=
=FQSw
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Oleksij Samorukov (1):
      qga: set FreeBSD virtio-serial channel to raw mode

 qga/channel-posix.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.54.0 (Apple Git-157)


