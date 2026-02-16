Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50E6E83838
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Cu-0002SV-DZ; Mon, 16 Feb 2026 16:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vs6CP-00012d-2D
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vs6CN-000442-3A
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771277525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKp4y/BuR5Z3R3ABP3ZE0nVA99Jc3i33dPjsGZ8PSLM=;
 b=U2T+az67sSFCh6AXksVmH1aW9gA+/sRL5NsZ6mtSESrvES9fLv2OpD2ZWKhGKKCaJYQeUt
 n+5nl19GftHlmJqSob+TY6TGo8bH71daBVJXAlBiykMlGhnxtEOdlb1DhW5Ou0uf3jhOBG
 V5l0rrtMiT2pKcu2YMeXSVXEg1Bln10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-fZdd5BriNJeYYqvYWUIE5Q-1; Mon,
 16 Feb 2026 16:32:02 -0500
X-MC-Unique: fZdd5BriNJeYYqvYWUIE5Q-1
X-Mimecast-MFC-AGG-ID: fZdd5BriNJeYYqvYWUIE5Q_1771277520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F13701800630; Mon, 16 Feb 2026 21:31:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2422E19560A2; Mon, 16 Feb 2026 21:31:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v7 19/19] python: add setuptools and wheel dependencies
Date: Mon, 16 Feb 2026 16:29:51 -0500
Message-ID: <20260216212952.420120-20-jsnow@redhat.com>
In-Reply-To: <20260216212952.420120-1-jsnow@redhat.com>
References: <20260216212952.420120-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add setuptools and wheel packages to ease installation burden when
internet access is allowed. When internet access is not allowed, this
functions as a configure-time check ensuring that our environment has
the necessary minimum viable versions for these packaging tools
available.

For detailed information on Python ecosystem versions, please see
https://gitlab.com/jsnow/repology-dashboard#results-overview-as-of-2026-02-16

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
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


