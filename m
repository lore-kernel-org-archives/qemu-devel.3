Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC87DCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 02:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUbJ9-0000bP-Oq; Tue, 02 Jun 2026 22:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wUbJ5-0000b3-Ri
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 22:26:12 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wUbJ0-0006z3-0F
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 22:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780453540; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=VrbLQr2aD3HZ6HzGnWYbSFHg1HBp3c6opuU83QNY8A8=;
 b=c16DuR94brQhcVv/MsOGgWp/OGQAmyC+nNfDptH3vCDHB4ImwPjnZegDBReESvLEnC0XmRNWEDt60rJSKFgi45zNcYbN37sODH9J0i1gQXy7WnltIrFktxf9YAK2MUlTTzDqXmaP5/FOJ9DcwX/1rZeyg/29fb7eHwcQ9xhjW1U=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X45mAv1_1780453538; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X45mAv1_1780453538 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 10:25:39 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	philmd@linaro.org
Subject: [PATCH v2] qobject/json-writer: preallocate output buffer
Date: Wed,  3 Jun 2026 10:25:38 +0800
Message-ID: <20260603022538.92780-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
---
v1->v2: drop "one page" argument from commit message and comment
  (per Markus Armbruster's review)

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
2.50.1 (Apple Git-155)


