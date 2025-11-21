Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AB4CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdfZ-0001KO-SX; Fri, 21 Nov 2025 21:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMded-00009o-EA; Fri, 21 Nov 2025 21:47:16 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMddT-0004d6-RZ; Fri, 21 Nov 2025 21:47:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C5EDC16C6E6;
 Fri, 21 Nov 2025 16:51:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2AB5D321983;
 Fri, 21 Nov 2025 16:52:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 14/76] crypto: stop requiring "key encipherment" usage
 in x509 certs
Date: Fri, 21 Nov 2025 16:50:52 +0300
Message-ID: <20251121135201.1114964-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

This usage flag was deprecated by RFC8813, such that it is
forbidden to be present for certs using ECDSA/ECDH algorithms,
and in TLS 1.3 is conceptually obsolete.

As such many valid certs will no longer have this key usage
flag set, and QEMU should not be rejecting them, as this
prevents use of otherwise valid & desirable algorithms.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 3995fc238e0599e0417ba958ffc5c7a609e82a7f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index cd1f504471..5824d33989 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -144,7 +144,7 @@ qcrypto_tls_creds_check_cert_key_usage(QCryptoTLSCredsX509 *creds,
     if (status < 0) {
         if (status == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
             usage = isCA ? GNUTLS_KEY_KEY_CERT_SIGN :
-                GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT;
+                GNUTLS_KEY_DIGITAL_SIGNATURE;
         } else {
             error_setg(errp,
                        "Unable to query certificate %s key usage: %s",
@@ -171,14 +171,6 @@ qcrypto_tls_creds_check_cert_key_usage(QCryptoTLSCredsX509 *creds,
                 return -1;
             }
         }
-        if (!(usage & GNUTLS_KEY_KEY_ENCIPHERMENT)) {
-            if (critical) {
-                error_setg(errp,
-                           "Certificate %s usage does not permit key "
-                           "encipherment", certFile);
-                return -1;
-            }
-        }
     }
 
     return 0;
diff --git a/docs/system/tls.rst b/docs/system/tls.rst
index e284c82801..a4f6781d62 100644
--- a/docs/system/tls.rst
+++ b/docs/system/tls.rst
@@ -118,7 +118,6 @@ information for each server, and use it to issue server certificates.
    ip_address = 2620:0:cafe::87
    ip_address = 2001:24::92
    tls_www_server
-   encryption_key
    signing_key
    EOF
    # certtool --generate-privkey > server-hostNNN-key.pem
@@ -134,9 +133,8 @@ the subject alt name extension data. The ``tls_www_server`` keyword is
 the key purpose extension to indicate this certificate is intended for
 usage in a web server. Although QEMU network services are not in fact
 HTTP servers (except for VNC websockets), setting this key purpose is
-still recommended. The ``encryption_key`` and ``signing_key`` keyword is
-the key usage extension to indicate this certificate is intended for
-usage in the data session.
+still recommended. The ``signing_key`` keyword is the key usage extension
+to indicate this certificate is intended for usage in the data session.
 
 The ``server-hostNNN-key.pem`` and ``server-hostNNN-cert.pem`` files
 should now be securely copied to the server for which they were
@@ -171,7 +169,6 @@ certificates.
    organization = Name of your organization
    cn = hostNNN.foo.example.com
    tls_www_client
-   encryption_key
    signing_key
    EOF
    # certtool --generate-privkey > client-hostNNN-key.pem
@@ -187,9 +184,8 @@ the ``dns_name`` and ``ip_address`` fields are not included. The
 ``tls_www_client`` keyword is the key purpose extension to indicate this
 certificate is intended for usage in a web client. Although QEMU network
 clients are not in fact HTTP clients, setting this key purpose is still
-recommended. The ``encryption_key`` and ``signing_key`` keyword is the
-key usage extension to indicate this certificate is intended for usage
-in the data session.
+recommended. The ``signing_key`` keyword is the key usage extension to
+indicate this certificate is intended for usage in the data session.
 
 The ``client-hostNNN-key.pem`` and ``client-hostNNN-cert.pem`` files
 should now be securely copied to the client for which they were
@@ -222,7 +218,6 @@ client and server instructions in one.
    ip_address = 2001:24::92
    tls_www_server
    tls_www_client
-   encryption_key
    signing_key
    EOF
    # certtool --generate-privkey > both-hostNNN-key.pem
diff --git a/tests/unit/crypto-tls-x509-helpers.h b/tests/unit/crypto-tls-x509-helpers.h
index 2a0f7c04fd..7e9a508ad6 100644
--- a/tests/unit/crypto-tls-x509-helpers.h
+++ b/tests/unit/crypto-tls-x509-helpers.h
@@ -148,8 +148,7 @@ void test_tls_cleanup(const char *keyfile);
         .basicConstraintsIsCA = false,                                  \
         .keyUsageEnable = true,                                         \
         .keyUsageCritical = true,                                       \
-        .keyUsageValue =                                                \
-        GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,     \
+        .keyUsageValue = GNUTLS_KEY_DIGITAL_SIGNATURE,                  \
         .keyPurposeEnable = true,                                       \
         .keyPurposeCritical = true,                                     \
         .keyPurposeOID1 = GNUTLS_KP_TLS_WWW_CLIENT,                     \
@@ -168,8 +167,7 @@ void test_tls_cleanup(const char *keyfile);
         .basicConstraintsIsCA = false,                                  \
         .keyUsageEnable = true,                                         \
         .keyUsageCritical = true,                                       \
-        .keyUsageValue =                                                \
-        GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,     \
+        .keyUsageValue = GNUTLS_KEY_DIGITAL_SIGNATURE,                  \
         .keyPurposeEnable = true,                                       \
         .keyPurposeCritical = true,                                     \
         .keyPurposeOID1 = GNUTLS_KP_TLS_WWW_SERVER,                     \
diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index 3c25d75ca1..2025d75365 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -166,14 +166,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertreq, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
@@ -196,7 +196,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -211,7 +211,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -226,7 +226,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -250,7 +250,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     /* no-basic */
@@ -264,7 +264,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     /* Key usage:dig-sig:critical */
@@ -278,7 +278,7 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -303,7 +303,7 @@ int main(int argc, char **argv)
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT |
+                 GNUTLS_KEY_DIGITAL_SIGNATURE |
                  GNUTLS_KEY_KEY_CERT_SIGN,
                  false, false, NULL, NULL,
                  0, 0);
@@ -406,7 +406,7 @@ int main(int argc, char **argv)
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT |
+                 GNUTLS_KEY_DIGITAL_SIGNATURE |
                  GNUTLS_KEY_KEY_CERT_SIGN,
                  false, false, NULL, NULL,
                  0, 0);
@@ -508,21 +508,21 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(servercertexp1req, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, -1);
     TLS_CERT_REQ(clientcertexp1req, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, -1);
 
@@ -546,21 +546,21 @@ int main(int argc, char **argv)
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(servercertnew1req, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  1, 2);
     TLS_CERT_REQ(clientcertnew1req, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  1, 2);
 
@@ -599,14 +599,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertlevel2breq, cacertlevel1breq,
                  "UK", "qemu client level 2b", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 554054e934..e8b2e0201c 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -472,14 +472,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertreq, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
@@ -487,7 +487,7 @@ int main(int argc, char **argv)
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
@@ -506,7 +506,7 @@ int main(int argc, char **argv)
                  "192.168.122.1", "fec0::dead:beaf",
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     /* This intentionally doesn't replicate */
@@ -515,7 +515,7 @@ int main(int argc, char **argv)
                  "192.168.122.1", "fec0::dead:beaf",
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
 
@@ -619,14 +619,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertlevel2breq, cacertlevel1breq,
                  "UK", "qemu client level 2b", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
diff --git a/tests/unit/test-io-channel-tls.c b/tests/unit/test-io-channel-tls.c
index e036ac5df4..c2115d45fe 100644
--- a/tests/unit/test-io-channel-tls.c
+++ b/tests/unit/test-io-channel-tls.c
@@ -302,14 +302,14 @@ int main(int argc, char **argv)
                  "UK", "qemu.org", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
     TLS_CERT_REQ(clientcertreq, cacertreq,
                  "UK", "qemu", NULL, NULL, NULL, NULL,
                  true, true, false,
                  true, true,
-                 GNUTLS_KEY_DIGITAL_SIGNATURE | GNUTLS_KEY_KEY_ENCIPHERMENT,
+                 GNUTLS_KEY_DIGITAL_SIGNATURE,
                  true, true, GNUTLS_KP_TLS_WWW_CLIENT, NULL,
                  0, 0);
 
-- 
2.47.3


