Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9E0C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 16:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjiy3-00056i-8f; Mon, 11 Mar 2024 12:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjiy0-00056I-TB
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjixz-0005zt-AE
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710176254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfqUGYeBh3sXT2eaC8iUIADn77FNyLKB5J5cOD/CMvc=;
 b=czULmK2JLPH1TdxTj9eCA+jLNO6ilc11HqftrZH3Oz1bEs3cLYa2TQfzGkmmGh/iueQeqg
 JcKezOgw554bdo6Dovo9bDG7sDqAO67vgEUpLrMLVy9mfeDrddHb4Rfv2hH2+DUwXmAC9B
 sC4SOHBWHeSYub5MYgqUmNbQ2HuPx04=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-Eazq2sQmO0qbBoGg0-0Z7A-1; Mon,
 11 Mar 2024 12:57:32 -0400
X-MC-Unique: Eazq2sQmO0qbBoGg0-0Z7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C68B4299E742;
 Mon, 11 Mar 2024 16:57:31 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBFC310E4B;
 Mon, 11 Mar 2024 16:57:30 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/3] qga-win: Add support of Windows Server 2025 in get-osinfo
 command
Date: Mon, 11 Mar 2024 18:57:24 +0200
Message-ID: <20240311165724.176168-4-kkostiuk@redhat.com>
In-Reply-To: <20240311165724.176168-1-kkostiuk@redhat.com>
References: <20240311165724.176168-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dehan Meng <demeng@redhat.com>

Add support of Windows Server 2025 in get-osinfo command

Signed-off-by: Dehan Meng <demeng@redhat.com>
Message-ID: <20240222152835.72095-4-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Link: https://lore.kernel.org/r/20240304134532.28506-4-kkostiuk@redhat.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 659dfb624a..6242737b00 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2153,6 +2153,7 @@ static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[] = {
     {14393, "Microsoft Windows Server 2016",    "2016"},
     {17763, "Microsoft Windows Server 2019",    "2019"},
     {20344, "Microsoft Windows Server 2022",    "2022"},
+    {26040, "MIcrosoft Windows Server 2025",    "2025"},
     { }
 };
 
-- 
2.44.0


