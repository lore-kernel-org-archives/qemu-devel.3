Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C077ECD6E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 19:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqGLq-0003Tf-D0; Wed, 11 Feb 2026 14:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqGLo-0003T0-HP
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqGLm-00053f-JP
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770839892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hMY6F8mi1km7qTvVgIi0HDbNooGTKnHtrXqez8Y6CBQ=;
 b=hf+Foup3zWw1jtvuzbCWsNT8PUkuSt3WKY9/Z2B/uweQhcbKXuhPxVMQ/WWHf8vKykuT1W
 GBAMa57f4FZH3C7p9WcpcAaDlKtDJFNU2M3Jz7o3EPm9DP2MKMtJRBCH8zK65D8/457wEc
 ajhukoGll750hn1pDfvg87YYYtdiEKc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-ad5ykMQnNiqHEEj1ssF-Iw-1; Wed,
 11 Feb 2026 14:58:10 -0500
X-MC-Unique: ad5ykMQnNiqHEEj1ssF-Iw-1
X-Mimecast-MFC-AGG-ID: ad5ykMQnNiqHEEj1ssF-Iw_1770839889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F88D1800BD0; Wed, 11 Feb 2026 19:58:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.82.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2950019560A7; Wed, 11 Feb 2026 19:58:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/2] python: fix python-minreqs test failure et al
Date: Wed, 11 Feb 2026 14:58:02 -0500
Message-ID: <20260211195804.135144-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2320293005=0D
=0D
The tox test is still broken because our use of avocado uses=0D
pkg_resources, it will have to be removed but in a separate=0D
series. Let's get the core tests green first and then worry about deeper=0D
surgeries later.=0D
=0D
John Snow (2):=0D
  python: fix minreqs test under newest pip/setuptools=0D
  python: drop uses of pkg_resources=0D
=0D
 python/Makefile          |  5 ++---=0D
 python/setup.py          |  4 ----=0D
 python/tests/minreqs.txt | 10 +++++-----=0D
 tests/Makefile.include   |  2 +-=0D
 4 files changed, 8 insertions(+), 13 deletions(-)=0D
=0D
-- =0D
2.53.0=0D
=0D


