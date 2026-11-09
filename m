Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BIX3YPSy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSVu-0002OO-F0; Mon, 09 Nov 2026 11:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVC-00028l-F6
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSV7-0000xb-DV
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yaJg4zDG6rz+EJVK+yXLt4QRHcXkgJp3eA1MBuOF+XQ=;
 b=BIX3YPSy97fYLUzLRbW0XvTniu8U7vKxBnSP6ec0rRCTj9dS/VFWuYvzp5az2vIff9lh08
 F5SrgMSbO5QF90+ADjQ/PKtuwjARF6BI2JdWJrT3huAmPSvgn1n30csvjlqTBRu+cb2FCE
 gH0vgkqAOuUvCmtH+SL0jTwMUPzDaV0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-wjvAiYT6PdGPCQD1QZMbJA-1; Mon,
 09 Nov 2026 11:45:42 -0500
X-MC-Unique: wjvAiYT6PdGPCQD1QZMbJA-1
X-Mimecast-MFC-AGG-ID: wjvAiYT6PdGPCQD1QZMbJA_1794242742
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBB7C1955DC1; Mon,  9 Nov 2026 16:45:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89F2230000E5; Mon,  9 Nov 2026 16:45:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/11] block/vmdk: Avoid assertion if image file has no extents
Date: Mon,  9 Nov 2026 17:45:24 +0100
Message-ID: <20261109164533.293487-3-kwolf@redhat.com>
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
References: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

On a malformed image file which has no extents in it, we will open the file
but then fall over on an assertion in vmdk_co_get_info():

    $ cat bad.vmdk
    # Disk DescriptorFile
    version=1
    CID=fffffffe
    parentCID=ffffffff
    createType="vmfs"

    $ qemu-img info -f vmdk /tmp/zz9
    qemu-img: ../../block/vmdk.c:3104: int vmdk_co_get_info(BlockDriverState *, BlockDriverInfo *): Assertion `s->num_extents' failed.
    Aborted (core dumped)

(This was noted in passing in the report of #4571.)

Cc: qemu-stable@nongnu.org
Fixes: 7fa60fa3778f1c7336 ("VMDK: open/read/write for monolithicFlat image")
Reported-by: router0mail <https://gitlab.com/router0mail>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-2-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index b6e78a2b5d9..86059e1fa08 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1301,6 +1301,12 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
         extent->type = g_strdup(type);
     }
 
+    if (s->num_extents == 0) {
+        error_setg(errp, "Invalid file: no extent lines present");
+        ret = -EINVAL;
+        goto out;
+    }
+
     ret = 0;
     goto out;
 
-- 
2.56.0


