Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B928C52D7D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 07:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdPTn-00087q-CC; Mon, 12 Aug 2024 03:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sdPTj-00082g-KO
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sdPTi-0004EJ-3k
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723447709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RmQgyHeva8qC35S8yIZ4ZsG2oPvdT4mYgzQsRn/JAd8=;
 b=fLappAXuDW9Mw8LE5pT5Caw0wT0oBZwJvQpdhGFZg/8PDNmQzPpF/T4lSent5waxOb6H5q
 tDExSEBvizJkWUCSn2qjDvf5DrVh2tcg4Vz9kT/g07anr27Rd4+JZ6TjAs1vcJAk0H0on2
 PmmmmgOiplkDXe9TuB/bv/hmHJguFA4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-MAwC7KdbNtSW7O2YcnHEQA-1; Mon,
 12 Aug 2024 03:28:24 -0400
X-MC-Unique: MAwC7KdbNtSW7O2YcnHEQA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F31711944EB1; Mon, 12 Aug 2024 07:28:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.186])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 656E41955D61; Mon, 12 Aug 2024 07:28:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>, Hans <sungdgdhtryrt@gmail.com>,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/1] net: Fix '-net nic,model=' for non-help arguments
Date: Mon, 12 Aug 2024 15:28:10 +0800
Message-ID: <20240812072810.5247-2-jasowang@redhat.com>
In-Reply-To: <20240812072810.5247-1-jasowang@redhat.com>
References: <20240812072810.5247-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Oops, don't *delete* the model option when checking for 'help'.

Fixes: 64f75f57f9d2 ("net: Reinstate '-net nic, model=help' output as documented in man page")
Reported-by: Hans <sungdgdhtryrt@gmail.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index 2eb8bc9c0b..fc1125111c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1737,7 +1737,7 @@ void net_check_clients(void)
 
 static int net_init_client(void *dummy, QemuOpts *opts, Error **errp)
 {
-    const char *model = qemu_opt_get_del(opts, "model");
+    const char *model = qemu_opt_get(opts, "model");
 
     if (is_nic_model_help_option(model)) {
         return 0;
-- 
2.42.0


