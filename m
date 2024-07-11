Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5965C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRrtD-0002od-Sz; Thu, 11 Jul 2024 07:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRrtA-0002hX-Gb
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sRrsk-0000I0-Uf
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720696957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8pcV9f7oeZ3RzXKwBLGepvy1GNEY0pOyAShA1+demo=;
 b=Ldq957BK2AkqiqsQ83UI2L5+6qxux+jytU46n33AROGSfy28JdR9zuuaovoyxltxjxOxJ8
 8RV60+IYxLnzrdF2Elv/Dv6/qnvu3DT6RhV2KgvpgAoD/nRcr1sCMUGC3GibmGIAS1KK90
 wi1IUypZ8YaJxaUqUip5r9mdy8z7uBQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-3TvJNfCOMGW5m52mH08SXg-1; Thu,
 11 Jul 2024 07:22:32 -0400
X-MC-Unique: 3TvJNfCOMGW5m52mH08SXg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FFE61910403; Thu, 11 Jul 2024 11:22:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5D241955F40; Thu, 11 Jul 2024 11:22:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C375A21E6605; Thu, 11 Jul 2024 13:22:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, mst@redhat.com,
 berrange@redhat.com, marcandre.lureau@redhat.com, jsnow@redhat.com,
 imammedo@redhat.com
Subject: [PATCH 3/5] qapi/machine: Clarify query-uuid value when none has been
 specified
Date: Thu, 11 Jul 2024 13:22:26 +0200
Message-ID: <20240711112228.2140606-4-armbru@redhat.com>
In-Reply-To: <20240711112228.2140606-1-armbru@redhat.com>
References: <20240711112228.2140606-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When no UUID has been specified, query-uuid returns

    {"UUID": "00000000-0000-0000-0000-000000000000"}

The doc comment calls this "a null UUID", which I find less than
clear.  Change it to "an all-zero UUID".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 50ff102d56..f40427f21a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -305,9 +305,8 @@
 #
 # Since: 0.14
 #
-# .. note:: If no UUID was specified for the guest, a null UUID is
-#    returned.
-#
+# .. note:: If no UUID was specified for the guest, an all-zero UUID
+#    is returned.
 ##
 { 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
 
-- 
2.45.0


