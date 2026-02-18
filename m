Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72791E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vspCH-0006f7-VO; Wed, 18 Feb 2026 16:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vspCA-0006Uz-AI
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:34:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vspC8-0001wv-Vw
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771450492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H60HPP580Ns1IhD5xQ2QOs1rZpJfbe1g+6vHIjjP4Zw=;
 b=CZOksZHQM2hm/PKUN4CxC8QB/+eS+enpzscbBGFt5qQ6ANh/6zsZHRHw0x/kYTZdGHunCt
 4PY8T3/Z9tPutlPdaooMTXKVPqnqnL47IVkXE9TtAUYgcJBRCYH/ZBWTZW11c5/zQcM2VO
 rIgoHeWEffwLScvBuhyT22U02APVU/U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-DaGROyqQOGOcWhJwg0pyEw-1; Wed,
 18 Feb 2026 16:34:50 -0500
X-MC-Unique: DaGROyqQOGOcWhJwg0pyEw-1
X-Mimecast-MFC-AGG-ID: DaGROyqQOGOcWhJwg0pyEw_1771450488
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AD1E18004BB; Wed, 18 Feb 2026 21:34:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.233])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E166919560B5; Wed, 18 Feb 2026 21:34:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Cleber Rosa <crosa@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v8 03/20] python/mkvenv: bump 'qemu.qmp' dependency for
 testdeps
Date: Wed, 18 Feb 2026 16:33:58 -0500
Message-ID: <20260218213416.674483-4-jsnow@redhat.com>
In-Reply-To: <20260218213416.674483-1-jsnow@redhat.com>
References: <20260218213416.674483-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

First up, use the newest v0.0.5 instead of the older v0.0.3.

Secondly, the use of a period in the key name does not behave as
expected when installing and checking for dependencies, so quote this
string instead.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pythondeps.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pythondeps.toml b/pythondeps.toml
index 9a096160e62..85220a36426 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -32,5 +32,5 @@ sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
 [testdeps]
-qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
+"qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
 pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
-- 
2.53.0


