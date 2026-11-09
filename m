Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA03606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CMVxW+y0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSVv-0002OV-4S; Mon, 09 Nov 2026 11:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVI-0002Ai-F9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVC-0000y5-7a
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xJkqlvYWwnKbvtHfaIX3BiODYgSuU+/DgA91CtVXig=;
 b=CMVxW+y0wzOUAHc2NWgR8uYdtejx0gERE1RnrCbJxn994BupdR/MZihx+OjAD3l9Tgbe6w
 QChL1OvOSmZ8LwMC7Cv96FSYj1OaDXhdbSHqHIpEHXbBAKyWxjWGPpLh+6o9uyJg+51f2K
 duerudQEGxNNUp9S8KFudt9yq2oXjew=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-Pb2zfWLRMMSQBzMciWDoOg-1; Mon,
 09 Nov 2026 11:45:44 -0500
X-MC-Unique: Pb2zfWLRMMSQBzMciWDoOg-1
X-Mimecast-MFC-AGG-ID: Pb2zfWLRMMSQBzMciWDoOg_1794242743
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CB181800557; Mon,  9 Nov 2026 16:45:43 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B53F30001A2; Mon,  9 Nov 2026 16:45:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 03/11] block/vmdk: Avoid reading off the end of descriptor
 memory
Date: Mon,  9 Nov 2026 17:45:25 +0100
Message-ID: <20261109164533.293487-4-kwolf@redhat.com>
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
References: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In vmdk_parent_open() and vmdk_read_cid(), we read DESC_SIZE bytes
from the image file into a malloc'd buffer, and then look through it
for a keyword using strstr().  If found, we skip past the keyword and
attempt to parse a value from the next part of the buffer.  However,
we failed to check whether the end of the keyword is right at the end
of the buffer, and so a malicious image can cause us to read off the
end when parsing the value part.

Check for this condition before attempting to parse the value.

The worst case here is that the image causes us to read some junk
from the heap into the BlockDriverState backing_file and
auto_backing_file fields; the image could control those anyway, and
it's unlikely that this heap data could e.g. be leaked to the guest.

Cc: qemu-stable@nongnu.org
Reported-by: router0mail <https://gitlab.com/router0mail>
Fixes: 5f4da8c0f3736b2 ("New multiple snapshot support for VMDK")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4571
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-3-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 86059e1fa08..6e4e0423dc9 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -337,6 +337,10 @@ vmdk_read_cid(BlockDriverState *bs, int parent, uint32_t *pcid)
         goto out;
     }
     p_name += cid_str_size;
+    if (p_name >= desc + DESC_SIZE) {
+        ret = -EINVAL;
+        goto out;
+    }
     if (sscanf(p_name, "%" SCNx32, &cid) != 1) {
         ret = -EINVAL;
         goto out;
@@ -508,6 +512,10 @@ static int GRAPH_RDLOCK vmdk_parent_open(BlockDriverState *bs)
         char *end_name;
 
         p_name += sizeof("parentFileNameHint") + 1;
+        if (p_name >= desc + DESC_SIZE + 1) {
+            ret = -EINVAL;
+            goto out;
+        }
         end_name = strchr(p_name, '\"');
         if (end_name == NULL) {
             ret = -EINVAL;
-- 
2.56.0


