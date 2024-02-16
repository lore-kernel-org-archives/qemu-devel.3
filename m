Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B769FC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayKb-0008B7-6l; Fri, 16 Feb 2024 08:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayJp-000826-NO
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rayJn-0006AP-VZ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708090315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igDQLQcrsYn/3LYOWPr70op4GGKXO51EJsvBEPe8+hs=;
 b=Ngufki6CzMIuCDBPkFWT9HAgeKVZ3B7ckv8XCb84T997Jv16eI9auZQK5CU8zZIQAECbOF
 6gecDOofAbxJXqpiAi/wpfhWwoaB3BpoVmlodxOvUrJJHfKvdbjQCbd0ZhyFU5NfS3gko6
 UeCHF6kZClkuP8dF9a1oUWl6xvjtmOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-1nALvRgROeSQnZmvsP0vXw-1; Fri, 16 Feb 2024 08:31:51 -0500
X-MC-Unique: 1nALvRgROeSQnZmvsP0vXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39DEF185A781;
 Fri, 16 Feb 2024 13:31:51 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 603BA1C066AA;
 Fri, 16 Feb 2024 13:31:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/7] ui: reject extended clipboard message if not activated
Date: Fri, 16 Feb 2024 17:31:34 +0400
Message-ID: <20240216133140.3611100-2-marcandre.lureau@redhat.com>
In-Reply-To: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
References: <20240216133140.3611100-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The extended clipboard message protocol requires that the client
activate the extension by requesting a psuedo encoding. If this
is not done, then any extended clipboard messages from the client
should be considered invalid and the client dropped.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240115095119.654271-1-berrange@redhat.com>
---
 ui/vnc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 3db87fd89c..af20d24534 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2445,6 +2445,11 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
         }
 
         if (read_s32(data, 4) < 0) {
+            if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
+                error_report("vnc: extended clipboard message while disabled");
+                vnc_client_error(vs);
+                break;
+            }
             if (dlen < 4) {
                 error_report("vnc: malformed payload (header less than 4 bytes)"
                              " in extended clipboard pseudo-encoding.");
-- 
2.43.1


