Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96389C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNFn-0001Fm-Nr; Mon, 24 Aug 2026 01:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyNFL-0000bP-K5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyNFK-0006kZ-8C
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787549361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TH4c6HnowuFu5CvbgBQlykOA2IkGVA+5wBP1z2lgd+g=;
 b=Be99MTuJp1NWfDLr8ZIK+k5OHLux6v+ZVt+56g6sgaHtfAKaWNx797CQAyzgECpq0PTfoQ
 vwh3Jd+DXxCwsQqwFHoMim+vyjb0GKnJ0LkXzZhPV8rI3VSRVJboIXxgx3jiRq3QfY+vMj
 QdNQ0YQxsSjMu8aElhZXTOqAKoA9JoA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-BO47UyY7Ouuw_YZnyq5aAg-1; Mon,
 24 Aug 2026 01:29:17 -0400
X-MC-Unique: BO47UyY7Ouuw_YZnyq5aAg-1
X-Mimecast-MFC-AGG-ID: BO47UyY7Ouuw_YZnyq5aAg_1787549355
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CBC3180ABE7; Mon, 24 Aug 2026 05:29:15 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.29])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 664861800577; Mon, 24 Aug 2026 05:29:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 03/12] tests: update emsdk-wasm64-cross
Date: Mon, 24 Aug 2026 01:28:49 -0400
Message-ID: <20260824052859.880475-4-jsnow@redhat.com>
In-Reply-To: <20260824052859.880475-1-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This container currently uses Ubuntu 22.04 as a base, which is no
longer supported by QEMU as a build platform. Upgrade to a newer
version of the image which will provide Python3.12+.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
index c04a741b0e5..f11a9f34244 100644
--- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
@@ -1,6 +1,6 @@
 # syntax = docker/dockerfile:1.5
 
-ARG EMSDK_VERSION_QEMU=4.0.10
+ARG EMSDK_VERSION_QEMU=5.0.2
 ARG ZLIB_VERSION=1.3.2
 ARG GLIB_MINOR_VERSION=2.84
 ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
@@ -27,7 +27,7 @@ RUN apt-get update && apt-get install -y \
     pkgconf \
     ninja-build \
     python3-pip
-RUN pip3 install meson==${MESON_VERSION} tomli
+RUN pip3 install --break-system-packages meson==${MESON_VERSION} tomli
 RUN mkdir /build
 WORKDIR /build
 RUN mkdir -p $TARGET
-- 
2.55.0


