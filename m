Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D468C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbyR-0000bS-HS; Wed, 26 Jun 2024 19:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMbyP-0000b4-60
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMbyM-0002ne-S6
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719444161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yciom4cZPXKC28wBgKo/ksmlBHFe94JnhLHrHaPGvXk=;
 b=AgTn7hCnHgkBJ42IwkLS5ByC88YK7x4la1WE53S13FqLD6umy30XvfQ+ayZMNnoAK2nUp4
 wD5dRqOKhK0DHwYAEdAhfhJP4oDOKvLKP4Y55xJtxVtKtzEw6qoCAw9mFN+/GDmZ2lrsg/
 M/kqK3YOmXjtBtCclvNlnAJ8RC1EBIo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-ve_Xj9EpP9--DL69A_WB0w-1; Wed,
 26 Jun 2024 19:22:38 -0400
X-MC-Unique: ve_Xj9EpP9--DL69A_WB0w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF9AE195608E; Wed, 26 Jun 2024 23:22:36 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.58])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C88C41956087; Wed, 26 Jun 2024 23:22:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/4] Python: Add 3.13 support, play linter whackamole
Date: Wed, 26 Jun 2024 19:22:26 -0400
Message-ID: <20240626232230.408004-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

Fix some regressions in check-python-tox that have crept in since Pylint=0D
3.x, and add Python 3.13 support to the pipeline.=0D
=0D
GitLab pipeline (before I fixed the missing DCO, but let's be honest, it=0D
can't possibly be worth re-running so many tests for just that):=0D
  https://gitlab.com/jsnow/qemu/-/pipelines/1349737188=0D
=0D
John Snow (4):=0D
  python: linter changes for pylint 3.x=0D
  python: Do not use pylint 3.2.4 with python 3.8=0D
  iotests: Change imports for Python 3.13=0D
  python: enable testing for 3.13=0D
=0D
 python/qemu/machine/machine.py         | 1 +=0D
 python/qemu/utils/qemu_ga_client.py    | 2 +-=0D
 python/setup.cfg                       | 4 +++-=0D
 tests/docker/dockerfiles/python.docker | 1 +=0D
 tests/qemu-iotests/testenv.py          | 7 ++++++-=0D
 tests/qemu-iotests/testrunner.py       | 9 ++++++---=0D
 6 files changed, 18 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.45.0=0D
=0D


