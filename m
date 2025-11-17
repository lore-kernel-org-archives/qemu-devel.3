Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F540CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 18:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4Kp-0002ie-O6; Mon, 17 Nov 2025 13:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4Kc-0002g0-5G
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4Ka-00086I-0v
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763405514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oOxBzFG1R1q3lg+u3bkJYmqSVGkTDsy886DCF8dgTI=;
 b=XcCHhpEZw919loGGI7sj0s/hOtNA7BMMumqj73b7kSo/Rr9D5gk7vQXR1yX9lKzjHheGC/
 xBmgHFoe4Ct6VesAZFx0OrxBIipAX6idgmrHjDu1NeVDPhhisJcoip6LWiFLS4iPalWOD/
 KA3RQ4/R94pAZCj+eUG7zpM0QQzUQ9A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-dEsgX0uHM7WXlZsqouAZXw-1; Mon,
 17 Nov 2025 13:51:49 -0500
X-MC-Unique: dEsgX0uHM7WXlZsqouAZXw-1
X-Mimecast-MFC-AGG-ID: dEsgX0uHM7WXlZsqouAZXw_1763405508
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E32DE1800447; Mon, 17 Nov 2025 18:51:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25777180047F; Mon, 17 Nov 2025 18:51:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 04/22] python/mkvenv: create timestamp file for each group
 "ensured"
Date: Mon, 17 Nov 2025 13:51:12 -0500
Message-ID: <20251117185131.953681-5-jsnow@redhat.com>
In-Reply-To: <20251117185131.953681-1-jsnow@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Each group ensured by the mkvenv script will create an empty timestamp
file named {groupname}.group which can be used to conditionally trigger
dependency installation from various scripts and build machinery.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/scripts/mkvenv.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index a064709e6ce..a22e3ee3394 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -838,6 +838,12 @@ def ensure_group(
             raise Ouch(result[0])
         raise SystemExit(f"\n{result[0]}\n\n")
 
+    if inside_a_venv():
+        for group in groups:
+            path = Path(sys.prefix).joinpath(f"{group}.group")
+            with open(path, "w", encoding="UTF8"):
+                pass
+
 
 def post_venv_setup() -> None:
     """
-- 
2.51.1


