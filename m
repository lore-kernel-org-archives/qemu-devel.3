Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3937EA4FC2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWJP-0002T1-5I; Mon, 23 Feb 2026 08:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIO-0000ML-To
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIN-00071W-GQ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/09w0J2YpkpDAMjN66q20SGVs5ABPk/vfQW5xglbdY=;
 b=YpG2KJzVAVRGg+dMOgYEyP81rkpqu90VlfSfZPOfSHNfEYbT21+lfRNxd+8+CsV0x511hF
 3yPvWmkHOXwJhbrZK/2kOaXTQL+TG16ojgKEWnTkMHx1fKvLgdapOQ3Ow8DTpEt3c2B44U
 ZayD40O7OdKezH4jaqO5+h34lCZPfbU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Mt4HZNWuP7WA_z6BKT4Rww-1; Mon,
 23 Feb 2026 08:48:15 -0500
X-MC-Unique: Mt4HZNWuP7WA_z6BKT4Rww-1
X-Mimecast-MFC-AGG-ID: Mt4HZNWuP7WA_z6BKT4Rww_1771854494
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 744501955F3B; Mon, 23 Feb 2026 13:48:14 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6E2B19560A3; Mon, 23 Feb 2026 13:48:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL v3 15/85] scripts/modinfo: make --devices optional
Date: Mon, 23 Feb 2026 14:46:16 +0100
Message-ID: <20260223134731.2377432-16-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This will allow to use modinfo-generate in cases where devices aren't
relevant (tests etc)

Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>w
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/modinfo-generate.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index 777d419aa33..e7d35242414 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -84,7 +84,7 @@ def main() -> None:
     parser = argparse.ArgumentParser(
         description='Generate C code for QEMU module info'
     )
-    parser.add_argument('--devices', required=True,
+    parser.add_argument('--devices',
                         help='path to config-device.mak')
     parser.add_argument('modinfo', nargs='+',
                         help='modinfo files to process')
@@ -92,11 +92,12 @@ def main() -> None:
 
     # get all devices enabled in kconfig, from *-config-device.mak
     enabled = set()
-    with open(args.devices) as file:
-        for line in file.readlines():
-            config = line.split('=')
-            if config[1].rstrip() == 'y':
-                enabled.add(config[0][7:])  # remove CONFIG_
+    if args.devices:
+        with open(args.devices) as file:
+            for line in file.readlines():
+                config = line.split('=')
+                if config[1].rstrip() == 'y':
+                    enabled.add(config[0][7:])  # remove CONFIG_
 
     deps = set()
     modules = set()
-- 
2.53.0


