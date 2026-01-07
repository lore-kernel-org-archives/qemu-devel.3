Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7DBCFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTB8-0004yP-Jy; Wed, 07 Jan 2026 08:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdTAj-0004vE-Fa
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdTAh-0007Bj-AE
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767790912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iFtiL75VdnXh+zl4sXStu5ZfJsXEP3Afpeo+fWf/Mx0=;
 b=KdBWc2tGkfO/pSP2+rgFDDVHIazR+fdL99DQJl+Q35Jz2cwH/WzL5XsSY7HsF9rxaHXyUG
 sWLV3DGqTd+KKGj1jmqpxxoiccpHHb3puHvgj5MWiTuLXeeeuq4a4XVKJfsxgLOF6qey35
 9oTPbXQ5573GYSwtKNz6Sldk3zFvhWs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-THLIPA0vMNa93PFpYJYhGA-1; Wed,
 07 Jan 2026 08:01:49 -0500
X-MC-Unique: THLIPA0vMNa93PFpYJYhGA-1
X-Mimecast-MFC-AGG-ID: THLIPA0vMNa93PFpYJYhGA_1767790908
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25F6719560AD; Wed,  7 Jan 2026 13:01:48 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.169])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77D4819560A2; Wed,  7 Jan 2026 13:01:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/4] tests/docker: improve detection of docker/podman
Date: Wed,  7 Jan 2026 13:01:41 +0000
Message-ID: <20260107130145.1495219-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This improves integration such that tests/docker/Makefile.include will
correctly honour the exact command detected by docker.py's probing
logic. Currently the probe command gets stripped down to just a bare
'podman' or 'docker' command name. This means while commands run via
'docker.py' would use 'sudo -n docker', commands run directly from
Makefile.include would only use 'docker'.

This series fixes that so that 'docker.py probe' correctly reports the
full argv, and configure honours that argv untouched.

With that fixed, we can then also add support for 'podman --remote'
and 'podman-remote', which allow use of podman when already inside
podman which is the scenario for my development environment that is
using 'toolbox'.

Finally this also improves CI by ensuring that stdout from docker is
not thrown away, so we can have a chance of diagnosing build failures
from CI.

Daniel P. Berrangé (4):
  tests/docker: improve handling of docker probes
  tests/docker: allow display of docker output
  gitlab: ensure docker output is always displayed in CI
  tests/docker: add support for podman remote access

 .gitlab-ci.d/base.yml         |  3 +++
 configure                     | 19 +++++++------------
 tests/docker/Makefile.include | 23 ++++++++++++++---------
 tests/docker/docker.py        | 17 +++++++----------
 4 files changed, 31 insertions(+), 31 deletions(-)

-- 
2.52.0


