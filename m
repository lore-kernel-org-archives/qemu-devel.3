Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD08606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kx4mXPTr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOsRa-0006u2-OZ; Thu, 05 Nov 2026 03:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOsRP-0006sz-Na
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:03:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOsRJ-0005Nb-E6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 03:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793865796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEnDCvUizl8ziDP5LFyP9+g8vwEGgECIjt/x5JeWHtk=;
 b=Kx4mXPTrJ6iZe69hnccKeVtHjUhpihLJKz0Os7e+0+pFWzD1l8gCokeRUzwiS9QipfdGQi
 EMoBgtTs/PbrYvJ2rwuNW3pAP4QVngo51xYVREMJspD3FeQGwSSSifcUVhwjAC5N7fnCpO
 uAt85QxiH38hXHFIrxFBnmqbGI1ZRq8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-qURqJ0HQMVaimTomw_4U3A-1; Thu,
 05 Nov 2026 03:03:14 -0500
X-MC-Unique: qURqJ0HQMVaimTomw_4U3A-1
X-Mimecast-MFC-AGG-ID: qURqJ0HQMVaimTomw_4U3A_1793865794
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAC6A19560B5
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 08:03:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A7A61848D43
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 08:03:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED28F21E692D; Thu, 05 Nov 2026 09:03:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 1/5] target/riscv: Fix up PropertyInfo to set @qapi_type
Date: Thu,  5 Nov 2026 09:03:06 +0100
Message-ID: <20261105080310.1656968-2-armbru@redhat.com>
In-Reply-To: <20261105080310.1656968-1-armbru@redhat.com>
References: <20261105080310.1656968-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When we recently updated PropertyInfo to set @qapi_type, we missed
one.  Update it now.

Fixes: 07458a910f7b ("target/riscv: convert PropertyInfo definitions to use qapi_type")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 362e561809..15c27f4ce4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2075,6 +2075,7 @@ static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
 
 static const PropertyInfo prop_vlen = {
     .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "vlen",
     .get = prop_vlen_get,
     .set = prop_vlen_set,
-- 
2.55.0


