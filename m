Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC43EC52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 17:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbkni-00085H-Dc; Wed, 07 Aug 2024 13:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbkne-0007qT-QI
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sbknc-0000fe-Jy
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 13:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723053011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwxbBGHFmsZsfH9DS9IhpgS16mhEtSGLb/yQJe19xw4=;
 b=QMIcBhTPeo49BXQESFfDep5dEzckALytjD4Cm28EU8j9KEWARZ0jRB1C5NT85jjscR0CHl
 IdtTTErXODGOF0lXHK7wVCGVlE11M8H4IUCT8x4yaKIg2XhqDkTKrVl5ZyAzLihoWbcvyA
 4QwNoSDuz7iCZnVlYjxrv/6U5H4RaAw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-_45jkO4eOj2CoAN0QRlKog-1; Wed,
 07 Aug 2024 13:50:07 -0400
X-MC-Unique: _45jkO4eOj2CoAN0QRlKog-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32F951955F49; Wed,  7 Aug 2024 17:50:06 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B14AD3000197; Wed,  7 Aug 2024 17:50:03 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v4 6/7] qemu-nbd: Allow users to adjust handshake limit
Date: Wed,  7 Aug 2024 12:43:32 -0500
Message-ID: <20240807174943.771624-15-eblake@redhat.com>
In-Reply-To: <20240807174943.771624-9-eblake@redhat.com>
References: <20240807174943.771624-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Eric Blake <eblake@redhat.com>

---

I'm not sure if this is 9.1 material.  It is a new feature
(user-visible command line option) implemented after soft freeze; on
the other hand, it allows one to recover the behavior that existed
prior to plugging the CVE which may be useful in integration testing.
---
 docs/tools/qemu-nbd.rst |  5 +++++
 qemu-nbd.c              | 41 ++++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index 329f44d9895..f55c10eb39c 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -154,6 +154,11 @@ driver options if :option:`--image-opts` is specified.
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
index 7bf86a6566b..4287a595d92 100644
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
+static int handshake_limit = NBD_DEFAULT_HANDSHAKE_LIMIT;

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
-    /* TODO - expose handshake limit as command line option */
-    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_LIMIT,
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
2.45.2


