Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AC3C3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTuAz-0008A8-30; Tue, 16 Jul 2024 22:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuAq-0007xD-8q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuAj-0003Pe-Ti
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721182416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3l8ASEjsy7nsu8L2gv+DbCir13iYXn5KlDrkyhXOHk=;
 b=hkOcM4QLyIX+cTd3ix+QhpESHQSOnMCpxOm7AF/J2+SucXzbVdu0NaxhmL1KALnNoP9Wrl
 ojt0Vj+24YbnCEM1Y8tygTQbg0pT0tqEEe2E42pQbf/YKKFAyvyn8c3R3EVKFykBX3/1KA
 1S3tDFOCIQPOlVf+TFpxNPykxbVAqIg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-m3XhqqTkPx26H6P4vR4gLQ-1; Tue,
 16 Jul 2024 22:13:31 -0400
X-MC-Unique: m3XhqqTkPx26H6P4vR4gLQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C18031955D45; Wed, 17 Jul 2024 02:13:26 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.65.127])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 923741955F3B; Wed, 17 Jul 2024 02:13:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 1/9] [DO-NOT-MERGE]: Add some ad-hoc linting helpers.
Date: Tue, 16 Jul 2024 22:13:03 -0400
Message-ID: <20240717021312.606116-2-jsnow@redhat.com>
In-Reply-To: <20240717021312.606116-1-jsnow@redhat.com>
References: <20240717021312.606116-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These aren't ready for upstream inclusion, because they do not properly
manage version dependencies, execution environment and so on. These are
just the tools I use in my Own Special Environment :tm: for testing and
debugging.

They've been tested only on Fedora 38 for right now, which means:

Python 3.11.4-1.fc38
pylint 2.17.4-2.fc38
mypy 1.4.0-1.fc38
isort 5.12.0-1.fc38
flake8 5.0.3-2.fc38

"Soon" :tm: I'll move the qapi generator code under the python/
directory to take advantage of the more robust linting infrastructure
there, but that's going to happen after this series. Sorry about that!

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi-lint.sh  | 61 +++++++++++++++++++++++++++++++++++++++++++
 scripts/qapi/Makefile |  5 ++++
 2 files changed, 66 insertions(+)
 create mode 100755 scripts/qapi-lint.sh
 create mode 100644 scripts/qapi/Makefile

diff --git a/scripts/qapi-lint.sh b/scripts/qapi-lint.sh
new file mode 100755
index 00000000000..732716f2444
--- /dev/null
+++ b/scripts/qapi-lint.sh
@@ -0,0 +1,61 @@
+#!/usr/bin/env bash
+set -e
+
+if [[ -f qapi/.flake8 ]]; then
+    echo "flake8 --config=qapi/.flake8 qapi/"
+    flake8 --config=qapi/.flake8 qapi/
+fi
+if [[ -f qapi/pylintrc ]]; then
+    echo "pylint --rcfile=qapi/pylintrc qapi/"
+    pylint --rcfile=qapi/pylintrc qapi/
+fi
+if [[ -f qapi/mypy.ini ]]; then
+    echo "mypy --config-file=qapi/mypy.ini qapi/"
+    mypy --config-file=qapi/mypy.ini qapi/
+fi
+
+if [[ -f qapi/.isort.cfg ]]; then
+    pushd qapi
+    echo "isort -c ."
+    isort -c .
+    popd
+fi
+
+if [[ -f ../docs/sphinx/qapi-domain.py ]]; then
+    pushd ../docs/sphinx
+
+    echo "mypy --strict qapi-domain.py"
+    mypy --strict qapi-domain.py
+    echo "flake8 qapi-domain.py --max-line-length=99"
+    flake8 qapi-domain.py --max-line-length=99
+    echo "isort qapi-domain.py"
+    isort qapi-domain.py
+    echo "black --check qapi-domain.py"
+    black --check qapi-domain.py
+
+    popd
+fi
+
+if [[ -f ../docs/sphinx/qapidoc.py ]]; then
+    pushd ../docs/sphinx
+
+    echo "pylint --rc-file ../../scripts/qapi/pylintrc qapidoc.py"
+    PYTHONPATH=../scripts/ pylint \
+                         --rc-file ../../scripts/qapi/pylintrc \
+                         qapidoc.py
+    echo "flake8 qapidoc.py --max-line-length=80"
+    flake8 qapidoc.py --max-line-length=80
+    echo "isort qapidoc.py"
+    isort qapidoc.py
+    echo "black --line-length 80 --check qapidoc.py"
+    black --line-length 80 --check qapidoc.py
+
+    popd
+fi
+
+pushd ../build
+make -j13
+make check-qapi-schema
+make docs
+make sphinxdocs
+popd
diff --git a/scripts/qapi/Makefile b/scripts/qapi/Makefile
new file mode 100644
index 00000000000..314e8a5505e
--- /dev/null
+++ b/scripts/qapi/Makefile
@@ -0,0 +1,5 @@
+check:
+	isort -c .
+	flake8 .
+	cd .. && pylint --rcfile=qapi/pylintrc qapi
+	cd .. && mypy -p qapi --config-file=qapi/mypy.ini
-- 
2.45.0


