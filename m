Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02582D73EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlghO-0000rV-Kg; Fri, 30 Jan 2026 00:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vlghJ-0000fm-RK
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vlghI-0005yG-82
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769749530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+wINEsfBa04+NyhW2p56L7hCT5v1dxA5fzpChtnvA0=;
 b=Hs/pQThiDBt0KP8ddPIhnINJAGFtJjUnHL/rSdoADwnJJkGwJ+8Yn42lifDtrewjP15sR3
 dOTTaIpH9rMXwh7oqobx06NvEmy6RqI5VByRMj5quOKMjRa2ulCnYbV2c8MZ8XfR4+ftL5
 0pHW0vdPEd6B3TqXvI3iStMsWrNAVjU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-UZn0LGakMYySfFpqyXPL3A-1; Fri,
 30 Jan 2026 00:05:24 -0500
X-MC-Unique: UZn0LGakMYySfFpqyXPL3A-1
X-Mimecast-MFC-AGG-ID: UZn0LGakMYySfFpqyXPL3A_1769749523
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8329F18005B5; Fri, 30 Jan 2026 05:05:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FD6A3000218; Fri, 30 Jan 2026 05:05:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 1/1] python: fix msys64 wheel directory specification
Date: Fri, 30 Jan 2026 00:05:18 -0500
Message-ID: <20260130050518.517688-2-jsnow@redhat.com>
In-Reply-To: <20260130050518.517688-1-jsnow@redhat.com>
References: <20260130050518.517688-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

In python3.14, fixes were made to the file URI parsing [1] such that
file URIs that used to work but were technically out of spec are now
broken.

As a result, our msys2 GitLab CI tests began failing.

Stop using "file://" URI links in favor of simple paths (Thanks pbo) to
fix parsing errors under Python 3.14 and fix the msys2 GitLab CI tests.

[1] https://docs.python.org/3/whatsnew/3.14.html#urllib
Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/scripts/mkvenv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index a064709e6ce..5cba5770d22 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -683,7 +683,7 @@ def pip_install(
     if not online:
         full_args += ["--no-index"]
     if wheels_dir:
-        full_args += ["--find-links", f"file://{str(wheels_dir)}"]
+        full_args += ["--find-links", str(wheels_dir)]
     full_args += list(args)
     subprocess.run(
         full_args,
-- 
2.52.0


