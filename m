Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9706CC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 20:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thwpB-0005zT-Pg; Tue, 11 Feb 2025 15:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1thwp9-0005yS-P1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 15:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1thwp7-0001c6-TL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 15:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739305536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKN99G4xOnHaVXiwlUof9zNigH8GuTTusSpkB2Gvi78=;
 b=WVrhp2ieZbZsQwGNJCR+kMq6M9tfieclbEEUAfgj5GUVo5mvzmvyTTCUqKaLYJG8plNqhP
 MauP5JTjvUfTj5/pLKjw8gWwG6oTm3ow3AkrmbOIn1zC1ShjTeC8lDAEdcfmDMo96Vv4Id
 EayzkGDG3kwZB1CKlwgcLETw82+wCNY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-_KE2yxiNNveIaUG0hdEubQ-1; Tue,
 11 Feb 2025 15:25:34 -0500
X-MC-Unique: _KE2yxiNNveIaUG0hdEubQ-1
X-Mimecast-MFC-AGG-ID: _KE2yxiNNveIaUG0hdEubQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF8011956096; Tue, 11 Feb 2025 20:25:32 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66B9F180087F; Tue, 11 Feb 2025 20:25:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 1/2] qemu-nbd: Allow users to adjust handshake limit
Date: Tue, 11 Feb 2025 14:25:09 -0600
Message-ID: <20250211202527.574723-5-eblake@redhat.com>
In-Reply-To: <20250211202527.574723-4-eblake@redhat.com>
References: <20250211202527.574723-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Although defaulting the handshake limit to 10 seconds was a nice QoI
change to weed out intentionally slow clients, it can interfere with
integration testing done with manual NBD_OPT commands over 'nbdsh
--opt-mode'.  Expose a command line option to allow the user to alter
the timeout away from the default.  This option is unlikely to be used
in enough scenarios to warrant a short option letter.

The option --handshake-limit intentionally differs from the name of
the constant added in commit fb1c2aaa98 (limit instead of max_secs)
and the QMP name to be added in the next commit; this is because
typing a longer command-line name is undesirable and there is
sufficient --help text to document the units.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250203222722.650694-5-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 docs/tools/qemu-nbd.rst |  5 +++++
 qemu-nbd.c              | 41 ++++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index 4f21b7904ac..f82ea5fd77b 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -156,6 +156,11 @@ driver options if :option:`--image-opts` is specified.
   Set the NBD volume export description, as a human-readable
   string.

+.. option:: --handshake-limit=N
+
+  Set the timeout for a client to successfully complete its handshake
+  to N seconds (default 10), or 0 for no limit.
+
 .. option:: -L, --list

   Connect as a client and list all details about the exports exposed by
diff --git a/qemu-nbd.c b/qemu-nbd.c
index b30d3ab8de3..05b61da51ea 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -57,19 +57,20 @@
 #define HAVE_NBD_DEVICE 0
 #endif

-#define SOCKET_PATH                "/var/lock/qemu-nbd-%s"
-#define QEMU_NBD_OPT_CACHE         256
-#define QEMU_NBD_OPT_AIO           257
-#define QEMU_NBD_OPT_DISCARD       258
-#define QEMU_NBD_OPT_DETECT_ZEROES 259
-#define QEMU_NBD_OPT_OBJECT        260
-#define QEMU_NBD_OPT_TLSCREDS      261
-#define QEMU_NBD_OPT_IMAGE_OPTS    262
-#define QEMU_NBD_OPT_FORK          263
-#define QEMU_NBD_OPT_TLSAUTHZ      264
-#define QEMU_NBD_OPT_PID_FILE      265
-#define QEMU_NBD_OPT_SELINUX_LABEL 266
-#define QEMU_NBD_OPT_TLSHOSTNAME   267
+#define SOCKET_PATH                  "/var/lock/qemu-nbd-%s"
+#define QEMU_NBD_OPT_CACHE           256
+#define QEMU_NBD_OPT_AIO             257
+#define QEMU_NBD_OPT_DISCARD         258
+#define QEMU_NBD_OPT_DETECT_ZEROES   259
+#define QEMU_NBD_OPT_OBJECT          260
+#define QEMU_NBD_OPT_TLSCREDS        261
+#define QEMU_NBD_OPT_IMAGE_OPTS      262
+#define QEMU_NBD_OPT_FORK            263
+#define QEMU_NBD_OPT_TLSAUTHZ        264
+#define QEMU_NBD_OPT_PID_FILE        265
+#define QEMU_NBD_OPT_SELINUX_LABEL   266
+#define QEMU_NBD_OPT_TLSHOSTNAME     267
+#define QEMU_NBD_OPT_HANDSHAKE_LIMIT 268

 #define MBR_SIZE 512

@@ -80,6 +81,7 @@ static int nb_fds;
 static QIONetListener *server;
 static QCryptoTLSCreds *tlscreds;
 static const char *tlsauthz;
+static int handshake_limit = NBD_DEFAULT_HANDSHAKE_MAX_SECS;

 static void usage(const char *name)
 {
@@ -101,6 +103,7 @@ static void usage(const char *name)
 "  -v, --verbose             display extra debugging information\n"
 "  -x, --export-name=NAME    expose export by name (default is empty string)\n"
 "  -D, --description=TEXT    export a human-readable description\n"
+"      --handshake-limit=N   limit client's handshake to N seconds (default 10)\n"
 "\n"
 "Exposing part of the image:\n"
 "  -o, --offset=OFFSET       offset into the image\n"
@@ -390,8 +393,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,

     nb_fds++;
     nbd_update_server_watch();
-    /* TODO - expose handshake timeout as command line option */
-    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_MAX_SECS,
+    nbd_client_new(cioc, handshake_limit,
                    tlscreds, tlsauthz, nbd_client_closed, NULL);
 }

@@ -569,6 +571,8 @@ int main(int argc, char **argv)
         { "object", required_argument, NULL, QEMU_NBD_OPT_OBJECT },
         { "export-name", required_argument, NULL, 'x' },
         { "description", required_argument, NULL, 'D' },
+        { "handshake-limit", required_argument, NULL,
+          QEMU_NBD_OPT_HANDSHAKE_LIMIT },
         { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
         { "tls-hostname", required_argument, NULL, QEMU_NBD_OPT_TLSHOSTNAME },
         { "tls-authz", required_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
@@ -815,6 +819,13 @@ int main(int argc, char **argv)
         case QEMU_NBD_OPT_SELINUX_LABEL:
             selinux_label = optarg;
             break;
+        case QEMU_NBD_OPT_HANDSHAKE_LIMIT:
+            if (qemu_strtoi(optarg, NULL, 0, &handshake_limit) < 0 ||
+                handshake_limit < 0) {
+                error_report("Invalid handshake limit '%s'", optarg);
+                exit(EXIT_FAILURE);
+            }
+            break;
         }
     }

-- 
2.48.1


