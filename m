Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EA8C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYZr-0004uL-Jz; Mon, 27 May 2024 07:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZo-0004s5-K7
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZm-0001Oq-0L
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716809497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZnzXyt0cmnHw8rN/o3Hoy8TS+O/qAabN70CVCwHfMJo=;
 b=iCQCUmnTBOKzOdCZhmQ67hrC/0v04a0Ul3tul0DqVSc1HXvOpLb4GsxH4IC69/o0ITGaSY
 YfQRaF5AsogJiXl8ojyCj1ryothNsH+zY7TiA9wccI0lLKpDv8JDfl8IVwB3hnm/RKITed
 MRVs77RFWZwyP7ivLYBcaqo/i8in3ls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Ub8ZMoziOQ60daeLloew-w-1; Mon, 27 May 2024 07:31:33 -0400
X-MC-Unique: Ub8ZMoziOQ60daeLloew-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FA6381227E;
 Mon, 27 May 2024 11:31:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA2F52026D68;
 Mon, 27 May 2024 11:31:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3D3221E6757; Mon, 27 May 2024 13:31:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/9] block: Improve error message when external snapshot can't
 flush
Date: Mon, 27 May 2024 13:31:23 +0200
Message-ID: <20240527113131.2054486-2-armbru@redhat.com>
In-Reply-To: <20240527113131.2054486-1-armbru@redhat.com>
References: <20240527113131.2054486-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

external_snapshot_action() reports bdrv_flush() failure to its caller
as

    An IO error has occurred

The errno code returned by bdrv_flush() is lost.

Improve this to

    Write to node '<device or node name>' failed: <description of errno>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240513141703.549874-2-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 blockdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 08eccc9052..528db3452f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1406,8 +1406,10 @@ static void external_snapshot_action(TransactionAction *action,
     }
 
     if (!bdrv_is_read_only(state->old_bs)) {
-        if (bdrv_flush(state->old_bs)) {
-            error_setg(errp, QERR_IO_ERROR);
+        ret = bdrv_flush(state->old_bs);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Write to node '%s' failed",
+                             bdrv_get_device_or_node_name(state->old_bs));
             return;
         }
     }
-- 
2.45.0


