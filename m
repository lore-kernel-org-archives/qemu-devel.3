Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7527BC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoZX-0002JG-FB; Wed, 21 Feb 2024 10:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rcoPd-0005Yw-Kx
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rcjGN-0006rN-9Y
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708509098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MZFrzMSAp3WcUMLxcFM+e6FN2UmU3TwbhgcKXD9+458=;
 b=DBegrXGFJ+X+5O8++N3lL/edhDWMO9Ilys8nGiceLQN4/xQz8DXo8GcLdp4tckmLat8lD/
 yO/X9JEly4r5SxnajxIkIxjJKF4AgUgW0y4gWzBcpl9t6Z9Z0NGqVpLX9b86uhRFjJCMrt
 dmw5Le4AHX0jwUhO2DjhaLwFG9WTtxw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-vIAzX9LdNFirbJxqFTn3vQ-1; Wed,
 21 Feb 2024 04:51:35 -0500
X-MC-Unique: vIAzX9LdNFirbJxqFTn3vQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 590AD3804075;
 Wed, 21 Feb 2024 09:51:35 +0000 (UTC)
Received: from dhcp-8-237.nay.redhat.com (dhcp-8-237.nay.redhat.com
 [10.66.8.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8445E492BE9;
 Wed, 21 Feb 2024 09:51:33 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH] qga-win: Add support of Windows Server 2025 in get-osinfo
 command
Date: Wed, 21 Feb 2024 17:51:30 +0800
Message-Id: <20240221095130.52711-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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
 qga/commands-win32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 697c65507c..f3c7e604c9 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2154,6 +2154,7 @@ static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[4] = {
     {14393, "Microsoft Windows Server 2016",    "2016"},
     {17763, "Microsoft Windows Server 2019",    "2019"},
     {20344, "Microsoft Windows Server 2022",    "2022"},
+    {26040, "MIcrosoft Windows Server 2025",    "2025"},
     {0, 0}
 };
 
-- 
2.35.1


