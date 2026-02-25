Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB10F55432
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKJv-0007po-Qc; Wed, 25 Feb 2026 14:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKJq-0007pN-Vq
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKJo-0006Fg-Pd
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772046786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Okzj6QgcX9aNx7e4O5mqtYAfJEYB4JhrCLoawcbrqtw=;
 b=Hg5lAwX45scxTfSi0B7AEt7LQwQQIvKtPyXsETr7Sn+YNVWRdO3HYdJ6DKqFTBTpGVMLcb
 5lug/F43h63IiYecXD0FWGsWD0s/NNbr8l7L7UFRzkcklVB36rqls9EYFn9Y45h8jeGeIS
 BL9TaWS5h57E+CD7nDEAA68x6BMJBqc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-5_LR5rAnO9-TiH2Ys0IXTQ-1; Wed,
 25 Feb 2026 14:13:02 -0500
X-MC-Unique: 5_LR5rAnO9-TiH2Ys0IXTQ-1
X-Mimecast-MFC-AGG-ID: 5_LR5rAnO9-TiH2Ys0IXTQ_1772046781
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2351A1800465; Wed, 25 Feb 2026 19:13:01 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C63B1800352; Wed, 25 Feb 2026 19:12:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] configure: allow PyPI access for python 'tooling' dependencies
Date: Wed, 25 Feb 2026 14:12:55 -0500
Message-ID: <20260225191255.955585-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We actually do not allow our meson requirements to be fetched online
because we strictly prefer the vendored version. Move the tooling group
installation to a different invocation that does allow PyPI to be
accessed when configure is run without explicitly disabling PyPI access.

This will allow QEMU to download and install python3-wheel for you if
you don't have it in your host environment.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index c4837eba2b1..090579bf236 100755
--- a/configure
+++ b/configure
@@ -963,10 +963,12 @@ fi
 python="$python -B"
 mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
-# Finish preparing the virtual environment using vendored .whl files
+# Finish preparing the virtual environment using vendored .whl files.
+# Even if PyPI is allowed, we disallow it here to force installation
+# from our preferred vendored versions.
 
 $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
-     ${source_path}/pythondeps.toml meson tooling || exit 1
+     ${source_path}/pythondeps.toml meson || exit 1
 
 # At this point, we expect Meson to be installed and available.
 # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
@@ -993,13 +995,19 @@ if test "$host_os" = "haiku" && test ! -e "$meson" ; then
     meson="$(cd pyvenv/non-packaged/bin; get_pwd)/meson"
 fi
 
-# Conditionally ensure Sphinx is installed.
-
 mkvenv_online_flag=""
 if test "$download" = "enabled" ; then
     mkvenv_online_flag=" --online"
 fi
 
+# Unconditionally install our tooling group. PyPI is allowed if enabled here.
+
+$mkvenv ensuregroup $mkvenv_online_flag \
+        --dir "${source_path}/python/wheels" \
+        ${source_path}/pythondeps.toml tooling || exit 1
+
+# Conditionally ensure Sphinx is installed.
+
 if test "$docs" != "disabled" ; then
     if ! $mkvenv ensuregroup \
          $(test "$docs" = "enabled" && echo "$mkvenv_online_flag") \
-- 
2.53.0


