Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0189AFD45E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKj3-0007p8-17; Wed, 25 Feb 2026 14:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKj0-0007oM-1A
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKiy-0001rq-BN
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772048345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u3+gp0Jw5OR/hibpkV4zpkb4CJCIKUwZZVkGR/z9Nsk=;
 b=MgmTtBMnTq78GLHA1xRJAgKv0jsrkleEenTJ6lB1Q6+GmE4hsFD/NXCoKruPQ65wkQtRua
 3eALWLFVt5WFbyxwYxaah4C7VSnIIJsOri3W5m4xW+cxmyKDVHBxnqWu1S5sOvmrgzORsi
 B39ltz/wJm4KEDfc4VnFU3fwigHCy1Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-S2lRnallOLiff1nl-snpKQ-1; Wed,
 25 Feb 2026 14:39:01 -0500
X-MC-Unique: S2lRnallOLiff1nl-snpKQ-1
X-Mimecast-MFC-AGG-ID: S2lRnallOLiff1nl-snpKQ_1772048340
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 718C3195605F; Wed, 25 Feb 2026 19:39:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0FBE1800370; Wed, 25 Feb 2026 19:38:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/3] tests: upgrade containers to debian 13
Date: Wed, 25 Feb 2026 14:38:53 -0500
Message-ID: <20260225193856.959771-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This mini-series upgrades everything except mipsel tests to Debian 13,=0D
removing our usage of the EOL Debian 11. Our mipsel tests continue to=0D
run Debian 12, which will be EOL in June.=0D
=0D
This is mostly helpful to me for being able to increase the minimum=0D
version of Python modules like setuptools, pip and wheel as I ran into=0D
while writing=0D
https://patchew.org/QEMU/20260216212952.420120-1-jsnow@redhat.com/=0D
=0D
v2:=0D
 - Rebased on origin/master following the merge of the qemu.qmp series=0D
=0D
Note: there is a minor conflict with=0D
https://patchew.org/QEMU/20260225192808.957477-1-jsnow@redhat.com/=0D
concerning the pinned wheel version in python/tests/minreqs.txt - the=0D
change in this series should take precedence.=0D
=0D
John Snow (3):=0D
  tests: upgrade most non-lcitool debian tests to debian 13=0D
  tests: upgrade debian-legacy-test-cross to debian 13=0D
  python: upgrade minimum setuptools/wheel/pip versions=0D
=0D
 python/tests/minreqs.txt                       |  1 +=0D
 pythondeps.toml                                | 18 ++++++++++--------=0D
 .../dockerfiles/debian-hexagon-cross.docker    | 11 ++++++-----=0D
 .../debian-legacy-test-cross.docker            | 16 +++++-----------=0D
 .../dockerfiles/debian-loongarch-cross.docker  | 10 +++++-----=0D
 .../docker/dockerfiles/debian-toolchain.docker |  8 +++++---=0D
 .../dockerfiles/debian-tricore-cross.docker    |  5 ++---=0D
 .../dockerfiles/debian-xtensa-cross.docker     |  2 +-=0D
 8 files changed, 35 insertions(+), 36 deletions(-)=0D
=0D
-- =0D
2.53.0=0D
=0D


