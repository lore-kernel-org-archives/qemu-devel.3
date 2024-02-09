Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A10C4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVl-0002uu-9K; Fri, 09 Feb 2024 09:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVb-0002hw-E1
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVZ-0004J6-I9
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nr3ddo80RnZTK5S4VJ7wU6DWU02InWN+foAX/4qSyIs=;
 b=G5X7BIpSYPR3auux/UMP7ymNP0V13t1uqA7uGctiSjBlxkE5hIOuZgUIVJy9FuKL8dC754
 PiYYHd/+/JGlQ2p7MiDv0o20h8yEV/rkqRfbejPVJjEdQ1QAtW7xPmwzYsvDOBEO06sL/8
 0oV1c9VCmubFpkB2kaufqK+hxuvLkYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ZS4uQhX0NX6Tel5Y4gsATw-1; Fri, 09 Feb 2024 09:05:31 -0500
X-MC-Unique: ZS4uQhX0NX6Tel5Y4gsATw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16F5C8F9201;
 Fri,  9 Feb 2024 14:05:31 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A762A111FF;
 Fri,  9 Feb 2024 14:05:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/17] docs: re-generate x86_64 ABI compatibility CSV
Date: Fri,  9 Feb 2024 14:04:56 +0000
Message-ID: <20240209140505.2536635-9-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This picks up the new EPYC-Genoa, SapphireRapids & GraniteRapids CPUs,
removes the now deleted Icelake-Client CPU, and adds the newer versions
of many existing CPUs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/cpu-models-x86-abi.csv | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/docs/system/cpu-models-x86-abi.csv b/docs/system/cpu-models-x86-abi.csv
index f3f3b60be1..38b9bae310 100644
--- a/docs/system/cpu-models-x86-abi.csv
+++ b/docs/system/cpu-models-x86-abi.csv
@@ -8,27 +8,37 @@ Cascadelake-Server-v1,✅,✅,✅,✅
 Cascadelake-Server-v2,✅,✅,✅,✅
 Cascadelake-Server-v3,✅,✅,✅,✅
 Cascadelake-Server-v4,✅,✅,✅,✅
+Cascadelake-Server-v5,✅,✅,✅,✅
 Conroe-v1,✅,,,
 Cooperlake-v1,✅,✅,✅,✅
+Cooperlake-v2,✅,✅,✅,✅
 Denverton-v1,✅,✅,,
 Denverton-v2,✅,✅,,
+Denverton-v3,✅,✅,,
 Dhyana-v1,✅,✅,✅,
+Dhyana-v2,✅,✅,✅,
+EPYC-Genoa-v1,✅,✅,✅,✅
 EPYC-Milan-v1,✅,✅,✅,
+EPYC-Milan-v2,✅,✅,✅,
 EPYC-Rome-v1,✅,✅,✅,
 EPYC-Rome-v2,✅,✅,✅,
+EPYC-Rome-v3,✅,✅,✅,
+EPYC-Rome-v4,✅,✅,✅,
 EPYC-v1,✅,✅,✅,
 EPYC-v2,✅,✅,✅,
 EPYC-v3,✅,✅,✅,
+EPYC-v4,✅,✅,✅,
+GraniteRapids-v1,✅,✅,✅,✅
 Haswell-v1,✅,✅,✅,
 Haswell-v2,✅,✅,✅,
 Haswell-v3,✅,✅,✅,
 Haswell-v4,✅,✅,✅,
-Icelake-Client-v1,✅,✅,✅,
-Icelake-Client-v2,✅,✅,✅,
 Icelake-Server-v1,✅,✅,✅,✅
 Icelake-Server-v2,✅,✅,✅,✅
 Icelake-Server-v3,✅,✅,✅,✅
 Icelake-Server-v4,✅,✅,✅,✅
+Icelake-Server-v5,✅,✅,✅,✅
+Icelake-Server-v6,✅,✅,✅,✅
 IvyBridge-v1,✅,✅,,
 IvyBridge-v2,✅,✅,,
 KnightsMill-v1,✅,✅,✅,
@@ -42,15 +52,21 @@ Opteron_G5-v1,✅,✅,,
 Penryn-v1,✅,,,
 SandyBridge-v1,✅,✅,,
 SandyBridge-v2,✅,✅,,
+SapphireRapids-v1,✅,✅,✅,✅
+SapphireRapids-v2,✅,✅,✅,✅
 Skylake-Client-v1,✅,✅,✅,
 Skylake-Client-v2,✅,✅,✅,
 Skylake-Client-v3,✅,✅,✅,
+Skylake-Client-v4,✅,✅,✅,
 Skylake-Server-v1,✅,✅,✅,✅
 Skylake-Server-v2,✅,✅,✅,✅
 Skylake-Server-v3,✅,✅,✅,✅
 Skylake-Server-v4,✅,✅,✅,✅
+Skylake-Server-v5,✅,✅,✅,✅
 Snowridge-v1,✅,✅,,
 Snowridge-v2,✅,✅,,
+Snowridge-v3,✅,✅,,
+Snowridge-v4,✅,✅,,
 Westmere-v1,✅,✅,,
 Westmere-v2,✅,✅,,
 athlon-v1,,,,
-- 
2.43.0


