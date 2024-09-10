Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E20AEDE9A6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41a-0006p9-LI; Tue, 10 Sep 2024 12:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41V-0006jf-FM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41T-0007YU-3b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S15FajVd/CEbaI9z1Sm6npoZAyDk4248vaEzQt4CKCE=;
 b=N0AtqTbHRmiQuuGNv8+p0GEn0aTsSu1hbjitO7LaD0PpVewAWRAbeXhB6IUpDDG6A6YF6m
 FUZ/g0cjnxyKj2yYEcfVXdMu8NxAX139T5Gvl9Jp5nDOUsLJr9p5ujEsSQxfZ3QeSkzHYO
 MS2NuiG1nlKom88Q78sJaEYkkEVhRa0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-fTjYUipWOVuvZj4fuUsBeg-1; Tue,
 10 Sep 2024 12:47:20 -0400
X-MC-Unique: fTjYUipWOVuvZj4fuUsBeg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AEBC1955D6A; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 052A230001A1; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 851DD21E6891; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 06/19] qapi/ebpf: Drop temporary 'prefix'
Date: Tue, 10 Sep 2024 18:47:01 +0200
Message-ID: <20240910164714.1993531-7-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Recent commit "qapi: Smarter camel_to_upper() to reduce need for
'prefix'" added a temporary 'prefix' to delay changing the generated
code.

Revert it.  This improves EbpfProgramID's generated enumeration
constant prefix from EBPF_PROGRAMID to EBPF_PROGRAM_ID.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240904111836.3273842-7-armbru@redhat.com>
---
 qapi/ebpf.json  | 1 -
 ebpf/ebpf_rss.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index 42df548777..db19ae850f 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -42,7 +42,6 @@
 # Since: 9.0
 ##
 { 'enum': 'EbpfProgramID',
-  'prefix': 'EBPF_PROGRAMID',   # TODO drop
   'if': 'CONFIG_EBPF',
   'data': [ { 'name': 'rss' } ] }
 
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 87f0714910..dcaa80f380 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -271,4 +271,4 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
     ctx->map_indirections_table = -1;
 }
 
-ebpf_binary_init(EBPF_PROGRAMID_RSS, rss_bpf__elf_bytes)
+ebpf_binary_init(EBPF_PROGRAM_ID_RSS, rss_bpf__elf_bytes)
-- 
2.46.0


