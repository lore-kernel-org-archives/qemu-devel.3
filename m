Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849ACC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 21:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s70Ab-0005vK-Fu; Tue, 14 May 2024 17:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AY-0005rB-VO
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AX-0000Bw-8h
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwjHYLm6iycQ6pC7rtrFtY9E94ZsxNimekXIcigYkpk=;
 b=fijN9WQJ/m6+6O2IRZwLQmY+HZ30O3gqf2nki8ILcpHyIH0ffm7eFIfxZst7IXIKCV+Ztv
 uBWgTwzUfEY3G5kPPiiGkY3V5uVr53YwSVUNS4EwcLnNT6HJNmf9SNgPd459abSsBfNjk1
 34GfX4qaWI9il7OARGyPlL6/is++FkA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-Cmwpts9QM_ONh6gnzl4Y3A-1; Tue,
 14 May 2024 17:58:30 -0400
X-MC-Unique: Cmwpts9QM_ONh6gnzl4Y3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAD183801EC4;
 Tue, 14 May 2024 21:58:29 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C51723C27;
 Tue, 14 May 2024 21:58:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 14/20] qapi: fix non-compliant JSON examples
Date: Tue, 14 May 2024 17:57:33 -0400
Message-ID: <20240514215740.940155-15-jsnow@redhat.com>
In-Reply-To: <20240514215740.940155-1-jsnow@redhat.com>
References: <20240514215740.940155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

If we parse all examples as QMP, we need them to conform to a standard
so that they render correctly. Once the QMP lexer is active for
examples, these will produce warning messages and fail the build.

The QMP lexer still supports elisions, but they must be represented as
the value "...", so two examples have been adjusted to support that
format here.

Signed-off-by: John Snow <jsnow@redhat.com>
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
index bce6e1bbc41..64a77557571 100644
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
index a351fd37143..89047d46c7c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2078,7 +2078,7 @@
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
2.44.0


