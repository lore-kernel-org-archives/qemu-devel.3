Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FF7C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 22:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMb2X-0005YE-Su; Wed, 26 Jun 2024 18:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb2V-0005XK-Vj
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb2U-0002QJ-1w
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719440573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4m+8m4aCMK3iiMr/I4m8T61CS9JXetIeJv88m5hoV5U=;
 b=earOM8bBuVDtORwJNbsXruAduuclkBJzoNH7Bex1eUVhdNKugqJtGeQw7EWIkofGQjuV38
 b5PTWrCbXod3VIQn0ZLx70iKbnDl1k82opLKkyLximhDNgdhG+DrXlg2RHfvb1K7FKiswb
 YEGMIywyzFiY2cgbfp4faM+btClExJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-1hm229DbOIWWZx5bhW2FTg-1; Wed,
 26 Jun 2024 18:22:50 -0400
X-MC-Unique: 1hm229DbOIWWZx5bhW2FTg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A3DD1956095; Wed, 26 Jun 2024 22:22:48 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDC6519560BF; Wed, 26 Jun 2024 22:22:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 08/21] qapi: fix non-compliant JSON examples
Date: Wed, 26 Jun 2024 18:21:14 -0400
Message-ID: <20240626222128.406106-9-jsnow@redhat.com>
In-Reply-To: <20240626222128.406106-1-jsnow@redhat.com>
References: <20240626222128.406106-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The new QMP documentation generator wants to parse all examples as
"QMP". We have an existing QMP lexer in docs/sphinx/qmp_lexer.py (Seen
in-use here: https://qemu-project.gitlab.io/qemu/interop/bitmaps.html)
that allows the use of "->", "<-" and "..." tokens to denote QMP
protocol flow with elisions, but otherwise defers to the JSON lexer.

To utilize this lexer for the existing QAPI documentation, we need them
to conform to a standard so that they lex and render correctly. Once the
QMP lexer is active for examples, errant QMP/JSON will produce warning
messages and fail the build.

Fix any invalid JSON found in QAPI documentation (identified by
attempting to lex all examples as QMP; see subsequent
commits). Additionally, elisions must be standardized for the QMP lexer;
they must be represented as the value "...", so three examples have been
adjusted to support that format here.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/control.json   | 3 ++-
 qapi/machine.json   | 2 +-
 qapi/migration.json | 2 +-
 qapi/misc.json      | 3 ++-
 qapi/net.json       | 6 +++---
 qapi/rocker.json    | 2 +-
 qapi/ui.json        | 2 +-
 7 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 6bdbf077c2e..10c906fa0e7 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -145,7 +145,8 @@
 #             },
 #             {
 #                "name":"system_powerdown"
-#             }
+#             },
+#             ...
 #          ]
 #        }
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 2fd3e9c3d5d..a982c945035 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1057,7 +1057,7 @@
 #            "vcpus-count": 1 },
 #          { "props": { "core-id": 0 }, "type": "POWER8-spapr-cpu-core",
 #            "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
-#        ]}'
+#        ]}
 #
 #     For pc machine type started with -smp 1,maxcpus=2:
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 0f24206bce4..9ec9ef36c47 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2106,7 +2106,7 @@
 # Example:
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
-#                                                     'sample-pages': 512} }
+#                                                     "sample-pages": 512} }
 #     <- { "return": {} }
 #
 #     Measure dirty rate using dirty bitmap for 500 milliseconds:
diff --git a/qapi/misc.json b/qapi/misc.json
index ec30e5c570a..4b41e15dcd4 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -287,7 +287,8 @@
 #
 # Example:
 #
-#     -> { "execute": "get-win32-socket", "arguments": { "info": "abcd123..", fdname": "skclient" } }
+#     -> { "execute": "get-win32-socket",
+#          "arguments": { "info": "abcd123..", "fdname": "skclient" } }
 #     <- { "return": {} }
 ##
 { 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
diff --git a/qapi/net.json b/qapi/net.json
index 0f5a259475e..c19df435a53 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1003,9 +1003,9 @@
 #
 # Example:
 #
-#     <- { 'event': 'NETDEV_STREAM_DISCONNECTED',
-#          'data': {'netdev-id': 'netdev0'},
-#          'timestamp': {'seconds': 1663330937, 'microseconds': 526695} }
+#     <- { "event": "NETDEV_STREAM_DISCONNECTED",
+#          "data": {"netdev-id": "netdev0"},
+#          "timestamp": {"seconds": 1663330937, "microseconds": 526695} }
 ##
 { 'event': 'NETDEV_STREAM_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5635cf174fd..f5225eb62cc 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -250,7 +250,7 @@
 #                       "action": {"goto-tbl": 10},
 #                       "mask": {"in-pport": 4294901760}
 #                      },
-#                      {...more...},
+#                      {...},
 #        ]}
 ##
 { 'command': 'query-rocker-of-dpa-flows',
diff --git a/qapi/ui.json b/qapi/ui.json
index f610bce118a..c12f5292571 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -361,7 +361,7 @@
 #                    "channel-id": 0,
 #                    "tls": false
 #                 },
-#                 [ ... more channels follow ... ]
+#                 ...
 #              ]
 #           }
 #        }
-- 
2.45.0


