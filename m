Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC49CCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 10:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ0jC-00015S-UZ; Thu, 21 May 2026 06:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ0jA-00014x-E7
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ0j8-0006Ff-NS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 06:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779359646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDh2D03XxxqWXqUquQtaik8bHXQ5jB9JMZ3JGWFrmQQ=;
 b=ASb/DAiGW5zJyjvjyzUGk8adO69zmDD887lWKhGIz7OSoQ8/1zDSs1W1s0ofgDk+QdqNDS
 GU3yI63JNdmlXjIbN5bLfGRB98PqZqymMEshnmP2+f07cXHN5/rO0eeRyslXmNQWJTKl2l
 36RcXzsTf92TfHES4j3Zdpry7E4II9U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-udh2P0MdP2-RSTIY4C5rxw-1; Thu,
 21 May 2026 06:34:01 -0400
X-MC-Unique: udh2P0MdP2-RSTIY4C5rxw-1
X-Mimecast-MFC-AGG-ID: udh2P0MdP2-RSTIY4C5rxw_1779359640
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 412AB19560A6; Thu, 21 May 2026 10:34:00 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A25EA19560A3; Thu, 21 May 2026 10:33:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 boy juju <agx1657748706@gmail.com>
Subject: [PATCH 1/4] ui/vnc: fix OOB read access in VNC SASL mechname array
Date: Thu, 21 May 2026 11:33:50 +0100
Message-ID: <20260521103353.1645561-2-berrange@redhat.com>
In-Reply-To: <20260521103353.1645561-1-berrange@redhat.com>
References: <20260521103353.1645561-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When reading the SASL mechname array off the VNC connection, if
malicious, the received data may contain embedded NULs. If this
happens the memory buffer returned by g_strndup may be shorter
than the original data. Unfortunately the code continued to
index into this buffer with an offset equal to the original
length. This is a potential OOB read of the array.

Fixes: 5847d9e1 (ui/vnc: simplify and avoid strncpy)
Reported-by: boy juju <agx1657748706@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 9964b969ac..298c8f3769 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -489,6 +489,8 @@ static int protocol_client_auth_sasl_mechname(VncState *vs, uint8_t *data, size_
     char *mechname = g_strndup((const char *) data, len);
     trace_vnc_auth_sasl_mech_choose(vs, mechname);
 
+    /* If 'data' had embedded NUL the dup'd string might now be shorter */
+    len = strlen(mechname);
     if (strncmp(vs->sasl.mechlist, mechname, len) == 0) {
         if (vs->sasl.mechlist[len] != '\0' &&
             vs->sasl.mechlist[len] != ',') {
-- 
2.54.0


