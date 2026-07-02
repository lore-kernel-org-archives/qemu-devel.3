Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F1EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGiE-0004fa-Pv; Thu, 02 Jul 2026 08:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi6-0004cY-W6
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfGi3-0000bH-I5
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782996002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXirk1eW7vDiQ6qUhFzNl6PwXc18LGY6D23talZ7Ckw=;
 b=c4da/zQfu2ZDAoueOnD3VVQhGk+Z8Aphss0IJb2ThShKIl4rHa9ulOBbz/JFsrF0jzVjiC
 vYp9p7vWpN7wu5tQ1C/uRk7nSmkkO0+QECCY+PaDtldTVT+nAYB98/gFC1AYgoTI0Xs/Yg
 5PMqK6zJG8vVt/KHS36c9KT2R2cmlrk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-ikZia_W8OuSxuzeRT_Q8YQ-1; Thu,
 02 Jul 2026 08:39:59 -0400
X-MC-Unique: ikZia_W8OuSxuzeRT_Q8YQ-1
X-Mimecast-MFC-AGG-ID: ikZia_W8OuSxuzeRT_Q8YQ_1782995998
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B3981944CED; Thu,  2 Jul 2026 12:39:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 998661971E71; Thu,  2 Jul 2026 12:39:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02F1A21E692F; Thu, 02 Jul 2026 14:39:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Bin Guo <guobin@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/7] qobject/json-writer: preallocate output buffer
Date: Thu,  2 Jul 2026 14:39:48 +0200
Message-ID: <20260702123954.1284221-2-armbru@redhat.com>
In-Reply-To: <20260702123954.1284221-1-armbru@redhat.com>
References: <20260702123954.1284221-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

json_writer_new() creates the output GString with g_string_new(NULL),
which starts at the GLib default of 64 bytes.  Serializing typical
QMP responses then requires multiple reallocations as the buffer
grows -- for query-qmp-schema the GString is reallocated 12+ times.

Preallocate JSON_WRITER_INITIAL_SIZE (4096) bytes.  This covers
most QMP responses without any reallocation.  The JSONWriter is a
short-lived object so the preallocation does not accumulate.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Message-ID: <20260603022538.92780-1-guobin@linux.alibaba.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-writer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qobject/json-writer.c b/qobject/json-writer.c
index aac2c6ab71..c23c81709b 100644
--- a/qobject/json-writer.c
+++ b/qobject/json-writer.c
@@ -24,13 +24,16 @@ struct JSONWriter {
     GByteArray *container_is_array;
 };
 
+/* Should cover most QMP responses without reallocation */
+#define JSON_WRITER_INITIAL_SIZE  4096
+
 JSONWriter *json_writer_new(bool pretty)
 {
     JSONWriter *writer = g_new(JSONWriter, 1);
 
     writer->pretty = pretty;
     writer->need_comma = false;
-    writer->contents = g_string_new(NULL);
+    writer->contents = g_string_sized_new(JSON_WRITER_INITIAL_SIZE);
     writer->container_is_array = g_byte_array_new();
     return writer;
 }
-- 
2.54.0


