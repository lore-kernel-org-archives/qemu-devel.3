Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A56AEC111D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 18:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuaij-0004Sq-7h; Mon, 23 Feb 2026 13:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuahy-0003HW-Lb
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuahw-0002AN-4Q
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771871457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yI6wURMMUpfOdLwNiuKuax1ZdwJxTA4LsNRHdp3BObg=;
 b=ddNO3/Tq+0+gNl3thygDwJO6vh+WmHiLup/TGLMhtIY0qoustTIvGfLCWIp9Ivtkru6W5U
 rMbbA2YAf97+fYMlEeVpc51VQ0c+KDIVjJDw/I73cOFm16XzAN0yu8+KaQ1qo3y7Vsz3uO
 ooQ9aaSSw5fuhndyP7S4TPU8lOrie4M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-2qMueU7BMA-H7M4bCOw-gw-1; Mon,
 23 Feb 2026 13:30:54 -0500
X-MC-Unique: 2qMueU7BMA-H7M4bCOw-gw-1
X-Mimecast-MFC-AGG-ID: 2qMueU7BMA-H7M4bCOw-gw_1771871452
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E79E1800464; Mon, 23 Feb 2026 18:30:52 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFBB419541AA; Mon, 23 Feb 2026 18:30:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Warner Losh <imp@bsdimp.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 19/19] python: add setuptools and wheel dependencies
Date: Mon, 23 Feb 2026 13:29:01 -0500
Message-ID: <20260223182902.739189-20-jsnow@redhat.com>
In-Reply-To: <20260223182902.739189-1-jsnow@redhat.com>
References: <20260223182902.739189-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

Add setuptools and wheel packages to ease installation burden when
internet access is allowed. When internet access is not allowed, this
functions as a configure-time check ensuring that our environment has
the necessary minimum viable versions for these packaging tools
available.

For detailed information on Python ecosystem versions, please see
https://gitlab.com/jsnow/repology-dashboard#results-overview-as-of-2026-02-16

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260218213416.674483-21-jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 pythondeps.toml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/pythondeps.toml b/pythondeps.toml
index 89256132fee..a0717742423 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -38,6 +38,14 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 [tooling]
 "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
 "qemu" = { path = "python/" }
+# NB: The following dependencies should be a little bit more modern than
+# the versions listed here, but we are still using Debian 11 for several
+# GitLab CI tests, so we are further restricted.
+"setuptools" = { accepted = ">=44.1.1" }
+"wheel" = { accepted = ">=0.34.2" }
+# pip should be guaranteed by mkvenv, this is merely a sanity check for
+# which version we are counting on being present.
+"pip" = { accepted = ">=20.3.4" }
 
 # This test group is for functional tests, and can include dependencies
 # fetched from PyPI.
-- 
2.53.0


