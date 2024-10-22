Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C35D2C56D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Gkt-0000AU-Ax; Tue, 22 Oct 2024 11:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Gkp-0008Sj-P8
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Gkm-00052a-5w
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOuPtrfxYuTQSyNiyUYfMZf4Fzl+Md7eAKoI2aBCov4=;
 b=efj01vhAi2zFIf24hsvmbPJ/ui6qV+7DrZoqQ4pOxxCGEU9vzKYqqd36BJiNr4kEBNoP6M
 098pL4JxYDmvOrOsl2RlBnNtrc1eLU1F771n2dUQL1yuxsiJxHC2tUSFO3BBhZB8Ok8bkg
 pzLR72FnspQRdTW6Oe2S2Jrj62AESIo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-nU8tbvqmMf68MNPwboR4fw-1; Tue,
 22 Oct 2024 11:24:56 -0400
X-MC-Unique: nU8tbvqmMf68MNPwboR4fw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E8181953953; Tue, 22 Oct 2024 15:24:55 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B79519560A2; Tue, 22 Oct 2024 15:24:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 13/14] ui: validate NUL byte padding in SASL client data more
 strictly
Date: Tue, 22 Oct 2024 16:24:14 +0100
Message-ID: <20241022152415.1632556-14-berrange@redhat.com>
In-Reply-To: <20241022152415.1632556-1-berrange@redhat.com>
References: <20241022152415.1632556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When the SASL data is non-NULL, the SASL protocol spec requires that
it is padded with a trailing NUL byte. QEMU discards the trailing
byte, but does not currently validate that it was in fact a NUL.
Apply strict validation to better detect any broken clients.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index a04feeb429..3f4cfc471d 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -263,8 +263,14 @@ static int protocol_client_auth_sasl_step(VncState *vs, uint8_t *data, size_t le
     /* NB, distinction of NULL vs "" is *critical* in SASL */
     if (datalen) {
         clientdata = (char*)data;
-        clientdata[datalen-1] = '\0'; /* Wire includes '\0', but make sure */
-        datalen--; /* Don't count NULL byte when passing to _start() */
+        if (clientdata[datalen - 1] != '\0') {
+            trace_vnc_auth_fail(vs, vs->auth, "Malformed SASL client data",
+                                "Missing SASL NUL padding byte");
+            sasl_dispose(&vs->sasl.conn);
+            vs->sasl.conn = NULL;
+            goto authabort;
+        }
+        datalen--; /* Discard the extra NUL padding byte */
     }
 
     err = sasl_server_step(vs->sasl.conn,
@@ -385,8 +391,14 @@ static int protocol_client_auth_sasl_start(VncState *vs, uint8_t *data, size_t l
     /* NB, distinction of NULL vs "" is *critical* in SASL */
     if (datalen) {
         clientdata = (char*)data;
-        clientdata[datalen-1] = '\0'; /* Should be on wire, but make sure */
-        datalen--; /* Don't count NULL byte when passing to _start() */
+        if (clientdata[datalen - 1] != '\0') {
+            trace_vnc_auth_fail(vs, vs->auth,  "Malformed SASL client data",
+                                "Missing SASL NUL padding byte");
+            sasl_dispose(&vs->sasl.conn);
+            vs->sasl.conn = NULL;
+            goto authabort;
+        }
+        datalen--; /* Discard the extra NUL padding byte */
     }
 
     err = sasl_server_start(vs->sasl.conn,
-- 
2.46.0


