Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0492C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 02:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rczEY-00050F-Rm; Wed, 21 Feb 2024 21:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rczEW-0004zD-LH
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:54:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rczEV-00044d-7M
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708570486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xgZNmz4EfQU+346AZED1IonWHxg7nS9MwU+Uq7ReDE=;
 b=aAfX2Ko7qKQ0OQkZPTcDqFRFa1qlVyrVHOIzgUl1HcPOPz7rCPpJclcO0nTbIO6Pil5z0w
 6KA+/NNIOO9KM1+V79BI5lYeutI50NYqJ2vyfGpdSjjqMyiAhhlqQI0JBLwdkpZzlPvxkA
 RsPQLN3HFyOfNwvLdsjyxw/R4t9gE+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-dp-jo-IpPpCVEw2ciShOVQ-1; Wed, 21 Feb 2024 21:54:45 -0500
X-MC-Unique: dp-jo-IpPpCVEw2ciShOVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AA5C185A788;
 Thu, 22 Feb 2024 02:54:45 +0000 (UTC)
Received: from dhcp-8-237.nay.redhat.com (dhcp-8-237.nay.redhat.com
 [10.66.8.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CF0D2022AAA;
 Thu, 22 Feb 2024 02:54:43 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v2 1/1] qga-win: Add support of Windows Server 2025 in
 get-osinfo command
Date: Thu, 22 Feb 2024 10:54:37 +0800
Message-Id: <20240222025437.58996-2-demeng@redhat.com>
In-Reply-To: <20240222025437.58996-1-demeng@redhat.com>
References: <20240222025437.58996-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add support of Windows Server 2025 in get-osinfo command

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-win32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 697c65507c..b37fa7b5ba 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2150,10 +2150,11 @@ typedef struct _ga_win_10_0_t {
     char const *version_id;
 } ga_win_10_0_t;
 
-static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[4] = {
+static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[5] = {
     {14393, "Microsoft Windows Server 2016",    "2016"},
     {17763, "Microsoft Windows Server 2019",    "2019"},
     {20344, "Microsoft Windows Server 2022",    "2022"},
+    {26040, "MIcrosoft Windows Server 2025",    "2025"},
     {0, 0}
 };
 
-- 
2.35.1


