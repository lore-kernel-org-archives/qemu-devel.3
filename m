Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA714D1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtSE-000897-Uv; Thu, 08 Jan 2026 12:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtS9-0007dm-PL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtS8-0007OG-99
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68Kp+6aWoHRH5lpTuDrXemE8tPoiTCechYjeJaXvG8k=;
 b=RdXvCVjRtKRXlYhEOjocsp0coQRUE7ZuwFW+a9HLjKSHJ4mBzWuTKAlKn/lzGDGhyiOlCs
 3h7ws9KqF8JCHdEOmRS6ffO/DhdptU2VoahTN7cLqchXlnHkOUGKNTRvzcGz0//W9z7ciN
 QnM+A6g1bFYejqey80rbPaB9VphFZP8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-E8iZWTFWPBOQdk7piui9rQ-1; Thu,
 08 Jan 2026 12:05:35 -0500
X-MC-Unique: E8iZWTFWPBOQdk7piui9rQ-1
X-Mimecast-MFC-AGG-ID: E8iZWTFWPBOQdk7piui9rQ_1767891932
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E26311800378; Thu,  8 Jan 2026 17:05:31 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DCBB1955F1C; Thu,  8 Jan 2026 17:05:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 24/24] util: add brackets around guest name in message
 context
Date: Thu,  8 Jan 2026 17:03:38 +0000
Message-ID: <20260108170338.2693853-25-berrange@redhat.com>
In-Reply-To: <20260108170338.2693853-1-berrange@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The message context can optionally include the guest name if the
argument '-msg guest-name=on' is given. The formatting, however,
does not look good if the guest name contains whitespace. Change
the output to include square brackets to demarcate the name.

Before:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*' -msg guest-name=on -name "fish food"
  fish food qemu-system-x86_64: (1146846:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55657e94e690 dir=fish
  fish food qemu-system-x86_64: (1146846:main): qcrypto_tls_creds_get_path TLS creds path creds=0x55657e94e690 filename=ca-cert.pem path=<none>
  fish food qemu-system-x86_64: (1146846:main): Unable to access credentials fish/ca-cert.pem: No such file or directory

After:

  # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*' -msg guest-name=on -name "fish food"
  [fish food] qemu-system-x86_64: (1144713:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5604ada2c950 dir=fish
  [fish food] qemu-system-x86_64: (1144713:main): qcrypto_tls_creds_get_path TLS creds path creds=0x5604ada2c950 filename=ca-cert.pem path=<none>
  [fish food] qemu-system-x86_64: (1144713:main): Unable to access credentials fish/ca-cert.pem: No such file or directory

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/message.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/message.c b/util/message.c
index 9bf640c8c4..73af8e8ca4 100644
--- a/util/message.c
+++ b/util/message.c
@@ -29,8 +29,9 @@ void qmessage_context_print(FILE *fp)
 
     if ((message_format & QMESSAGE_FORMAT_WORKLOAD_NAME) &&
         message_workloadname) {
+        fputc('[', fp);
         fputs(message_workloadname, fp);
-        fputc(' ', fp);
+        fputs("] ", fp);
     }
 
     if (message_format & QMESSAGE_FORMAT_PROGRAM_NAME) {
-- 
2.52.0


