Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EE310D14A6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B0G-0005NQ-22; Mon, 30 Mar 2026 07:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Axu-0003uE-Cx
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Axk-0003YU-H5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774870759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaKW6zYLKuhfhXTrC9qv3bYFrJ/5Ahy0GlR0n7eHG+4=;
 b=KhSF6N/RE2FUpCrv9sOwFySDLvfRV4pDISFOxkdbzNSF67jmfXXVS/qu6k6JHpTCG8ucLV
 qQT/W6vBwywU663bS1KzAhYuTiOUAQ6TRrs/UC4UQMOO9z8denSDrCJ1SbIE5KPmMruHpj
 kJe2suIQ+d5Knuq0yBA//bxyCy+fo5I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-0v7yuxpzOfCO3nU7j-5HCw-1; Mon,
 30 Mar 2026 07:39:15 -0400
X-MC-Unique: 0v7yuxpzOfCO3nU7j-5HCw-1
X-Mimecast-MFC-AGG-ID: 0v7yuxpzOfCO3nU7j-5HCw_1774870755
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 753651944ABE; Mon, 30 Mar 2026 11:39:13 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.33.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A6891800767; Mon, 30 Mar 2026 11:39:11 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 1/7] qga/win: Use swprintf instead of snwprintf
Date: Mon, 30 Mar 2026 14:39:00 +0300
Message-ID: <20260330113906.168002-2-kkostiuk@redhat.com>
In-Reply-To: <20260330113906.168002-1-kkostiuk@redhat.com>
References: <20260330113906.168002-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

snwprintf is a Microsoft extension, and according to the MSVC spec,
it is called _snwprintf. MinGW defines both snwprintf and _snwprintf,
while MSVC defines only _snwprintf.

We can also use swprintf here. The only difference between
the two is the return value, and we are not using it. So change
the function to support MSVC build env.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index c0bf3467bd..2bf5581aaa 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1590,7 +1590,7 @@ static DWORD get_interface_index(const char *guid)
     ULONG index;
     DWORD status;
     wchar_t wbuf[INTERFACE_PATH_BUF_SZ];
-    snwprintf(wbuf, INTERFACE_PATH_BUF_SZ, L"\\device\\tcpip_%s", guid);
+    swprintf(wbuf, INTERFACE_PATH_BUF_SZ, L"\\device\\tcpip_%s", guid);
     wbuf[INTERFACE_PATH_BUF_SZ - 1] = 0;
     status = GetAdapterIndex (wbuf, &index);
     if (status != NO_ERROR) {
--
2.52.0


