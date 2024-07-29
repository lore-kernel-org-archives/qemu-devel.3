Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19626C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 06:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYK0o-0007HF-6h; Mon, 29 Jul 2024 02:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYK0m-0007FW-W6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYK0k-0005Hk-Gd
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722235052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDkUtjigJ9xB8ULZTX66sN4NdVtJp2mHbN0lwNo0uI0=;
 b=RIknHS6thbsobEOWHU15uc7KF75BpLMsKWNQB3G8uL/pL5C57dZCC4bmOvEaChJdskkAq4
 dkmLb+XEAILVEvMHX7qRFrnZbqRSRIJ+LNqc8p4WU2Na7wi3Mu6htxzJNCLKah3S0BSiNN
 YEJrN++ZS9kNoJGEmKm4mFlAG8VExwY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-3uq0NIcSMkmGqll2nwAr0g-1; Mon,
 29 Jul 2024 02:37:28 -0400
X-MC-Unique: 3uq0NIcSMkmGqll2nwAr0g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44FFF1955F6A; Mon, 29 Jul 2024 06:37:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E17AE1955D4C; Mon, 29 Jul 2024 06:37:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E78E21E6697; Mon, 29 Jul 2024 08:37:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/2] qapi/qom: make some QOM properties depend on the build
 settings
Date: Mon, 29 Jul 2024 08:37:21 +0200
Message-ID: <20240729063722.839708-2-armbru@redhat.com>
In-Reply-To: <20240729063722.839708-1-armbru@redhat.com>
References: <20240729063722.839708-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

Some QOM properties are associated with ObjectTypes that already
depend on CONFIG_* switches. So to avoid generating dead code,
let's also make the definition of those properties dependent on
the corresponding CONFIG_*.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20240604135931.311709-1-sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Make SecretKeyringProperties conditional, too]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/crypto.json |  3 ++-
 qapi/qom.json    | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index f03bdab8c9..39b191e8a2 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -485,7 +485,8 @@
 ##
 { 'struct': 'SecretKeyringProperties',
   'base': 'SecretCommonProperties',
-  'data': { 'serial': 'int32' } }
+  'data': { 'serial': 'int32' },
+  'if': 'CONFIG_SECRET_KEYRING' }
 
 ##
 # @TlsCredsProperties:
diff --git a/qapi/qom.json b/qapi/qom.json
index 7e780e1791..fc035f126a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -222,7 +222,8 @@
 ##
 { 'struct': 'CanHostSocketcanProperties',
   'data': { 'if': 'str',
-            'canbus': 'str' } }
+            'canbus': 'str' },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @ColoCompareProperties:
@@ -305,7 +306,8 @@
 ##
 { 'struct': 'CryptodevVhostUserProperties',
   'base': 'CryptodevBackendProperties',
-  'data': { 'chardev': 'str' } }
+  'data': { 'chardev': 'str' },
+  'if': 'CONFIG_VHOST_CRYPTO' }
 
 ##
 # @DBusVMStateProperties:
@@ -514,7 +516,8 @@
   'data': { 'evdev': 'str',
             '*grab_all': 'bool',
             '*repeat': 'bool',
-            '*grab-toggle': 'GrabToggleKeys' } }
+            '*grab-toggle': 'GrabToggleKeys' },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @EventLoopBaseProperties:
@@ -718,7 +721,8 @@
   'base': 'MemoryBackendProperties',
   'data': { '*hugetlb': 'bool',
             '*hugetlbsize': 'size',
-            '*seal': 'bool' } }
+            '*seal': 'bool' },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @MemoryBackendShmProperties:
@@ -748,7 +752,8 @@
 ##
 { 'struct': 'MemoryBackendEpcProperties',
   'base': 'MemoryBackendProperties',
-  'data': {} }
+  'data': {},
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @PrManagerHelperProperties:
@@ -761,7 +766,8 @@
 # Since: 2.11
 ##
 { 'struct': 'PrManagerHelperProperties',
-  'data': { 'path': 'str' } }
+  'data': { 'path': 'str' },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @QtestProperties:
@@ -884,7 +890,8 @@
 ##
 { 'struct': 'RngRandomProperties',
   'base': 'RngProperties',
-  'data': { '*filename': 'str' } }
+  'data': { '*filename': 'str' },
+  'if': 'CONFIG_POSIX' }
 
 ##
 # @SevCommonProperties:
-- 
2.45.0


