Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC708D10F57
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 14:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOGbv-0006nB-41; Wed, 26 Nov 2025 09:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOGbU-0006jl-H8
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOGbR-0008F3-6s
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764167676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sx9WGjWVc9f0cmylZzIaItUEECMWb+JqWBP+RA39gCs=;
 b=f1bOSg5xyxvoFc+5ULnJKqPLHBCKB25XL8y7V0jcTK1D0HJnFlfqq6Ss7ydBy21QrlYA0x
 NUyW9QiWaaIzRJd4S5MXAdFRuie96xExU3ylFb7b4B4pVjGJh3lMIGRu+1MO6V2y+yN7rZ
 /5qUNpLIjdWlBSU27MEX/2he1YqIE40=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-7mxozMahOVeGeqoREgk97g-1; Wed,
 26 Nov 2025 09:34:33 -0500
X-MC-Unique: 7mxozMahOVeGeqoREgk97g-1
X-Mimecast-MFC-AGG-ID: 7mxozMahOVeGeqoREgk97g_1764167672
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B0C218002CA; Wed, 26 Nov 2025 14:34:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67FD71800451; Wed, 26 Nov 2025 14:34:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E51FE21E6A27; Wed, 26 Nov 2025 15:34:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jmarcin@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, berrange@redhat.com, vsementsov@yandex-team.ru,
 mail@maciej.szmigiero.name, clg@redhat.com, peter.maydell@linaro.org
Subject: [PATCH 2.5/6] error: Explain why we don't g_autoptr(Error)
Date: Wed, 26 Nov 2025 15:34:27 +0100
Message-ID: <20251126143427.2470598-1-armbru@redhat.com>
In-Reply-To: <20251125204648.857018-3-peterx@redhat.com>
References: <20251125204648.857018-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index f3ce4a4a2d..fc018b4c59 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -437,6 +437,23 @@ Error *error_copy(const Error *err);
  */
 void error_free(Error *err);
 
+/*
+ * Note: we intentionally do not enable g_autoptr(Error) with
+ * G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(Error, error_free).
+ *
+ * Functions that report or propagate an error take ownership of the
+ * Error object.  Explicit error_free() is needed when you handle an
+ * error in some other way.  This is rare.
+ *
+ * g_autoptr(Error) would call error_free() automatically on return.
+ * To avoid a double-free, we'd have to manually clear the pointer
+ * every time we propagate or report.
+ *
+ * Thus, g_autoptr(Error) would make the rare case easier to get right
+ * (less prone to leaks), and the common case easier to get wrong
+ * (more prone to double-free).
+ */
+
 /*
  * Convenience function to assert that *@errp is set, then silently free it.
  */
-- 
2.49.0


